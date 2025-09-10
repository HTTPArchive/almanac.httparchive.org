-- ======================================================================
-- PURPOSE
-- Classify government-root pages into country (and U.S. state where
-- applicable) and join Lighthouse scores for reporting.
--
-- HOW IT WORKS (high level)
-- 1) Build rule sets that map hosts to “buckets”:
--    - host_rules: explicit suffix lists (fast exact ENDS_WITH checks)
--    - regex_rules: patterns for families (e.g., *.gov.uk, *.gob.es)
--    - generic_ccgov: fallback that infers country from ccTLD when the
--      host looks like a gov/mil/gouv/gob/go/etc domain
-- 2) Match each page’s host against all three sources, UNION ALL results,
--    and pick the *best* match by:
--       priority DESC, then match_len DESC
--    (priority is curated; match_len is the explicit suffix length
--     or a large sentinel for regex/fallback).
-- 3) For U.S. hosts, optionally derive a state using:
--       - explicit us_state_overrides (brand/legacy domains)
--       - code_hit (state codes in *.state.xx.us or xx.gov)
--       - us_code_map (code → state name)
-- 4) Output one row per page with: country bucket, us_state (nullable),
--    host/page flags, and Lighthouse scores.
--
-- KEY TABLES / CTEs
-- - pages / pages_scored: source pages w/ Lighthouse category scores
-- - host_rules: hand-maintained, exact suffix → bucket (+ priority)
-- - regex_rules: regex → bucket (+ priority) for domain families
-- - cc_map: ccTLD → country name for generic gov-like inference
-- - generic_ccgov: fallback that maps gov-like host + ccTLD to country
-- - all_matches/ranked: union of matches and best-match selection
-- - us_* CTEs: derive U.S. state where possible
--
-- MATCH PRECEDENCE
--   Higher priority wins. Ties break by longer explicit suffix.
--   Order used by the script:
--     1) host_rules (explicit suffix, high priority & specific)
--     2) regex_rules (family patterns)
--     3) generic_ccgov (heuristic fallback; fixed priority 21)
--
-- NOTABLE FIELDS
--   - priority: Manual weight (higher = stronger/more specific)
--   - match_len: For suffix matches, LENGTH(suffix). For regex/fallback,
--                large sentinels to keep precedence intuitive.
--   - bucket: Country (or supranational) label (e.g., “France”, “EU”)
--   - us_state: U.S. state name if derivable; NULL otherwise
--
-- MAINTENANCE TIPS
--   - Prefer host_rules for known, fixed suffixes (cheap & precise).
--   - Use regex_rules for structured families you can’t enumerate.
--   - Keep priorities consistent across countries; bump only when a
--     rule *must* outrank others.
--   - Add us_state_overrides for branded/legacy state portals that
--     don’t expose standard state codes.
--
-- TESTING / DEBUGGING
--   - Quick peek at winners:
--       SELECT * FROM final_best LIMIT 100;
--   - See all candidates for a single host:
--       SELECT * FROM all_matches WHERE host = 'example.gov' ORDER BY priority DESC, match_len DESC;
--   - Check state inference:
--       SELECT * FROM us_state_classified WHERE host LIKE '%.gov' LIMIT 100;
--
-- PERFORMANCE
--   - host_rules uses ENDS_WITH (fast). Regex rules are costlier—keep
--     patterns tight and anchored.
--   - pages_scored filters out empty-score rows to reduce downstream joins.
--
-- INPUT DATASET
--   - Replace `httparchive.sample_data.pages_10k` with your source
--     (e.g., `httparchive.crawl.pages`) and enable the date filter.
--
-- OUTPUT
--   One row per page with: country bucket, optional U.S. state,
--   host/page identifiers, and Lighthouse category scores.
-- ======================================================================


WITH
-- 1) Explicit suffix → bucket rules (highest precision; curated priorities)
host_rules AS (
  SELECT * FROM UNNEST([

    -- United Nations
    STRUCT('un.org' AS suffix, 'United Nations' AS bucket, 10 AS priority),
    ('worldbank.org','United Nations',10),
    ('undp.org','United Nations',10),
    ('reliefweb.int','United Nations',10),
    ('who.int','United Nations',10),
    ('unfccc.int','United Nations',10),
    ('unccd.int','United Nations',10),
    ('unesco.org','United Nations',10),

    -- European Union
    ('europa.eu','European Union',12),
    ('eib.org','European Union',24),
    ('eif.org','European Union',24),

    -- Andorra
    ('govern.ad','Andorra',24), ('consellgeneral.ad','Andorra',24), ('justicia.ad','Andorra',24), ('tribunalconstitucional.ad','Andorra',24), ('exteriors.ad','Andorra',23),
    ('aferssocials.ad','Andorra',23), ('educacio.ad','Andorra',23), ('salut.ad','Andorra',23), ('interior.ad','Andorra',23), ('finances.ad','Andorra',23),
    ('encamp.ad','Andorra',22), ('ordino.ad','Andorra',22), ('canillo.ad','Andorra',22), ('santjulia.ad','Andorra',22), ('lauredia.ad','Andorra',22), ('escaldesengordany.ad','Andorra',22), ('pasdelacasa.ad','Andorra',22),

    -- Armenia
    ('gov.am','Armenia',24), ('parliament.am','Armenia',24), ('president.am','Armenia',24), ('e-gov.am','Armenia',24), ('mfa.am','Armenia',23),
    ('moh.am','Armenia',23), ('justice.am','Armenia',23), ('edu.am','Armenia',23), ('mil.am','Armenia',23), ('armstat.am','Armenia',23),
    ('yerevan.am','Armenia',22), ('gyumri.am','Armenia',22), ('vanadzor.am','Armenia',22), ('dilijan.am','Armenia',22),

    -- Australia (non-*.gov.au)
    ('australia.gov.au','Australia',24), ('aph.gov.au','Australia',24), ('abc.net.au','Australia',22), ('sbs.com.au','Australia',22), ('naa.gov.au','Australia',23),
    ('aic.gov.au','Australia',23), ('ansto.gov.au','Australia',23), ('csiro.au','Australia',23), ('ga.gov.au','Australia',23), ('bom.gov.au','Australia',23),
    ('vic.gov.au','Australia',23), ('parliament.vic.gov.au','Australia',23), ('justice.vic.gov.au','Australia',23), ('police.vic.gov.au','Australia',23),
    ('nsw.gov.au','Australia',23), ('parliament.nsw.gov.au','Australia',23), ('cityofsydney.nsw.gov.au','Australia',22), ('service.nsw.gov.au','Australia',23),
    ('qld.gov.au','Australia',23), ('parliament.qld.gov.au','Australia',23), ('brisbane.qld.gov.au','Australia',22), ('goldcoast.qld.gov.au','Australia',22),
    ('sa.gov.au','Australia',23), ('parliament.sa.gov.au','Australia',23), ('adelaidecitycouncil.com','Australia',22),
    ('wa.gov.au','Australia',23), ('parliament.wa.gov.au','Australia',23), ('perth.wa.gov.au','Australia',22),
    ('nt.gov.au','Australia',23), ('parliament.nt.gov.au','Australia',23), ('darwin.nt.gov.au','Australia',22),
    ('tas.gov.au','Australia',23), ('parliament.tas.gov.au','Australia',23), ('hobartcity.com.au','Australia',22),
    ('act.gov.au','Australia',23), ('parliament.act.gov.au','Australia',23), ('cityservices.act.gov.au','Australia',23),

    -- Austria
    ('oesterreich.gv.at','Austria',24),('bka.gv.at','Austria',24),('parlament.gv.at','Austria',24),('help.gv.at','Austria',24),('usp.gv.at','Austria',24),('data.gv.at','Austria',24),('ris.bka.gv.at','Austria',24),('gesundheit.gv.at','Austria',24),
    ('bmi.gv.at','Austria',24),('bmf.gv.at','Austria',24),('bmj.gv.at','Austria',24),('bmeia.gv.at','Austria',24),('bmk.gv.at','Austria',24),('bml.gv.at','Austria',24),('bmlrt.gv.at','Austria',24),('bmaw.gv.at','Austria',24),('bmbwf.gv.at','Austria',24),('bmkoes.gv.at','Austria',24),('bmsgpk.gv.at','Austria',24), ('polizei.gv.at','Austria',24),
    ('rechnungshof.gv.at','Austria',24),('vfgh.gv.at','Austria',24),('vwgh.gv.at','Austria',24),('bundesverwaltungsgericht.gv.at','Austria',24),('bundesfinanzgericht.gv.at','Austria',24),('justiz.gv.at','Austria',24),('bundesheer.at','Austria',24),('fma.gv.at','Austria',24),('rtr.at','Austria',24),('statistik.at','Austria',24),('ams.at','Austria',24),
    ('wien.gv.at','Austria',23),('noe.gv.at','Austria',23),('ooe.gv.at','Austria',23),('salzburg.gv.at','Austria',23),('tirol.gv.at','Austria',23),('ktn.gv.at','Austria',23),('kaernten.at','Austria',23),('stmk.gv.at','Austria',23),('steiermark.at','Austria',23),('bgld.gv.at','Austria',23),('burgenland.at','Austria',23),('vbg.gv.at','Austria',23),('vorarlberg.at','Austria',23),

    -- Azerbaijan
    ('president.az','Azerbaijan',24), ('meclis.gov.az','Azerbaijan',24), ('supremecourt.gov.az','Azerbaijan',24), ('justice.gov.az','Azerbaijan',23), ('mfa.gov.az','Azerbaijan',23),
    ('maliyye.gov.az','Azerbaijan',23), ('economy.gov.az','Azerbaijan',23), ('baku.az','Azerbaijan',22), ('ganja.az','Azerbaijan',22), ('sumqayit-ih.gov.az','Azerbaijan',22),
    ('sheki-ih.gov.az','Azerbaijan',22), ('lenkeran-ih.gov.az','Azerbaijan',22),

    -- Belarus
    ('president.gov.by','Belarus',24), ('government.by','Belarus',24), ('parliament.gov.by','Belarus',24), ('supcourt.gov.by','Belarus',24), ('economy.gov.by','Belarus',23),
    ('minfin.gov.by','Belarus',23), ('minjust.gov.by','Belarus',23), ('minsk.gov.by','Belarus',22), ('grodno.gov.by','Belarus',22), ('brest.gov.by','Belarus',22),
    ('vitebsk.gov.by','Belarus',22), ('gomel.gov.by','Belarus',22), ('mogilev.gov.by','Belarus',22),

    -- Belgium
    ('belgium.be','Belgium',24),('fgov.be','Belgium',24),('vlaanderen.be','Belgium',24),('wallonie.be','Belgium',24),('brussels.be','Belgium',24),('mil.be','Belgium',24),
    ('just.fgov.be','Belgium',23),('justice.belgium.be','Belgium',23),('mobilit.fgov.be','Belgium',23),('finance.belgium.be','Belgium',23),('health.belgium.be','Belgium',23),('socialsecurity.belgium.be','Belgium',23),('employment.belgium.be','Belgium',23),('bosa.belgium.be','Belgium',23),('ibz.fgov.be','Belgium',23),('diplomatie.belgium.be','Belgium',23),
    ('bruxelles.be','Belgium',23),('irisnet.be','Belgium',23),('parlement-wallonie.be','Belgium',23),('vlaamsparlement.be','Belgium',23),
    ('oost-vlaanderen.be','Belgium',22),('west-vlaanderen.be','Belgium',22),('limburg.be','Belgium',22),('vlaams-brabant.be','Belgium',22),('waals-brabant.be','Belgium',22),('hainaut.be','Belgium',22),('namur.be','Belgium',22),
    ('gent.be','Belgium',21),('brugge.be','Belgium',21),('leuven.be','Belgium',21),('mechelen.be','Belgium',21),('kortrijk.be','Belgium',21),('hasselt.be','Belgium',21),('antwerpen.be','Belgium',21),('brussel.be','Belgium',21),('charleroi.be','Belgium',21),('mons.be','Belgium',21),('namur.be','Belgium',21),('liege.be','Belgium',21),('louvain-la-neuve.be','Belgium',21),

    -- Bermuda
    ('gov.bm','Bermuda',24), ('parliament.bm','Bermuda',24), ('oba.bm','Bermuda',24),
    ('moh.gov.bm','Bermuda',23), ('moed.gov.bm','Bermuda',23), ('mohamed.gov.bm','Bermuda',23), ('mof.gov.bm','Bermuda',23), ('mps.gov.bm','Bermuda',23), ('mha.gov.bm','Bermuda',23), ('mpt.gov.bm','Bermuda',23), ('med.gov.bm','Bermuda',23), ('mhr.gov.bm','Bermuda',23),

    -- Bosnia and Herzegovina
    ('parlament.ba','Bosnia and Herzegovina',24), ('vijeceministara.gov.ba','Bosnia and Herzegovina',24), ('predsjednistvobih.ba','Bosnia and Herzegovina',24), ('mfa.ba','Bosnia and Herzegovina',23), ('mhs.ba','Bosnia and Herzegovina',23),
    ('pravosudje.ba','Bosnia and Herzegovina',23), ('mkt.gov.ba','Bosnia and Herzegovina',23), ('mfin.gov.ba','Bosnia and Herzegovina',23), ('fzs.ba','Bosnia and Herzegovina',23),
    ('sarajevo.ba','Bosnia and Herzegovina',22), ('mostar.ba','Bosnia and Herzegovina',22), ('banjaluka.rs.ba','Bosnia and Herzegovina',22), ('tuzla.ba','Bosnia and Herzegovina',22),

    -- Bulgaria 
    ('parliament.bg','Bulgaria',24),('president.bg','Bulgaria',24), ('mvr.bg','Bulgaria',24), ('mfa.bg','Bulgaria',24), 
    ('nsi.bg','Bulgaria',23), ('bnb.bg','Bulgaria',23),('nap.bg','Bulgaria',23), ('nra.bg','Bulgaria',23),
    ('cpdp.bg','Bulgaria',22), ('ombudsman.bg','Bulgaria',22),
    ('sofia.bg','Bulgaria',21),('plovdiv.bg','Bulgaria',21),('varna.bg','Bulgaria',21), ('burgas.bg','Bulgaria',21),('ruse.bg','Bulgaria',21),('pleven.bg','Bulgaria',21),
    ('stara-zagora.bg','Bulgaria',21),('sliven.bg','Bulgaria',21),('dobrich.bg','Bulgaria',21), ('shumen.bg','Bulgaria',21),('vratsa.bg','Bulgaria',21),('vidin.bg','Bulgaria',21),
    ('yambol.bg','Bulgaria',21),('kardzhali.bg','Bulgaria',21),('haskovo.bg','Bulgaria',21), ('pazardzhik.bg','Bulgaria',21),('pernik.bg','Bulgaria',21),('gabrovo.bg','Bulgaria',21),
    ('lovech.bg','Bulgaria',21),('silistra.bg','Bulgaria',21),('smolyan.bg','Bulgaria',21),

    -- Cameroon
    ('presidenceducameroun.cm','Cameroon',24),('primecm.cm','Cameroon',24),('minfi.cm','Cameroon',24),
    ('douala.cm','Cameroon',23),('yaounde.cm','Cameroon',23),('bamenda.cm','Cameroon',23),

    -- Canada
    ('canada.ca','Canada',24),('gc.ca','Canada',24),('parl.ca','Canada',24),('ourcommons.ca','Canada',24),('sencanada.ca','Canada',24),('lop.parl.ca','Canada',24),('scc-csc.ca','Canada',24),('canadapost-postescanada.ca','Canada',24),('cbc.ca','Canada',24), ('radio-canada.ca','Canada',24),
    ('alberta.ca','Canada',23),('assembly.ab.ca','Canada',23),('gov.ab.ca','Canada',23),
    ('gov.bc.ca','Canada',23),('leg.bc.ca','Canada',23),
    ('saskatchewan.ca','Canada',23),('legassembly.sk.ca','Canada',23),
    ('gov.mb.ca','Canada',23),('leg.gov.mb.ca','Canada',23),
    ('ontario.ca','Canada',23),('ola.org','Canada',23),
    ('quebec.ca','Canada',23),('gouv.qc.ca','Canada',23),('assnat.qc.ca','Canada',23),
    ('gnb.ca','Canada',23),('legnb.ca','Canada',23),
    ('novascotia.ca','Canada',23),('nslegislature.ca','Canada',23),('gov.ns.ca','Canada',23),
    ('princeedwardisland.ca','Canada',23),('gov.pe.ca','Canada',23),('assembly.pe.ca','Canada',23),
    ('gov.nl.ca','Canada',23),('newfoundlandlabrador.ca','Canada',23),('assembly.nl.ca','Canada',23),
    ('yukon.ca','Canada',23),('legassembly.gov.yk.ca','Canada',23),
    ('gov.nt.ca','Canada',23),('assembly.gov.nt.ca','Canada',23),
    ('gov.nu.ca','Canada',23),('assembly.nu.ca','Canada',23), ('revenuquebec.ca','Canada',23),

    -- Chile
    ('gob.cl','Chile',24), ('chileabroad.gov.cl','Chile',24), ('chileatiende.gob.cl','Chile',24),
    ('pjud.cl','Chile',24), ('tribunalconstitucional.cl','Chile',24), ('senado.cl','Chile',24), ('diputados.cl','Chile',24),
    ('muni.cl','Chile',23), ('muniweb.cl','Chile',23),

    -- China
    ('npc.gov.cn','China',24),('cppcc.gov.cn','China',24),('gov.cn','China',24),('xinhuanet.com','China',23), 
    ('shanghai.gov.cn','China',23),('beijing.gov.cn','China',23),('gz.gov.cn','China',23),('tj.gov.cn','China',23),('cq.gov.cn','China',23),
    ('chengdu.gov.cn','China',23),('wuhan.gov.cn','China',23),('xian.gov.cn','China',23),('nanjing.gov.cn','China',23),('hangzhou.gov.cn','China',23),('shenzhen.gov.cn','China',23),

    -- Costa Rica
    ('go.cr','Costa Rica',24),('presidencia.go.cr','Costa Rica',24),('ministeriodesalud.go.cr','Costa Rica',24), ('mep.go.cr','Costa Rica',24),('hacienda.go.cr','Costa Rica',24),('racsa.go.cr','Costa Rica',24), ('cgr.go.cr','Costa Rica',24),('ccss.sa.cr','Costa Rica',24),
    ('asamblea.go.cr','Costa Rica',24),('poder-judicial.go.cr','Costa Rica',24),('corte.go.cr','Costa Rica',24),
    ('muni.go.cr','Costa Rica',23),('munisanjose.go.cr','Costa Rica',23),('munialajuela.go.cr','Costa Rica',23), ('municartago.go.cr','Costa Rica',23),('muniheredia.go.cr','Costa Rica',23),

-- Croatia
  ('sabor.hr','Croatia',24), ('predsjednik.hr','Croatia',24),
  ('dzs.hr','Croatia',23), ('hzjz.hr','Croatia',23),('hzzo.hr','Croatia',23), ('hzmo.hr','Croatia',23),
  ('azop.hr','Croatia',22), ('hakom.hr','Croatia',22), ('narodne-novine.nn.hr','Croatia',22),
  ('zagreb.hr','Croatia',21),('split.hr','Croatia',21),('rijeka.hr','Croatia',21),
  ('osijek.hr','Croatia',21),('zadar.hr','Croatia',21),('pula.hr','Croatia',21),
  ('dubrovnik.hr','Croatia',21),('sibenik.hr','Croatia',21),('karlovac.hr','Croatia',21),
  ('sisak.hr','Croatia',21),('varazdin.hr','Croatia',21),('slavonski-brod.hr','Croatia',21),
  ('koprivnica.hr','Croatia',21),('vukovar.hr','Croatia',21),('pozega.hr','Croatia',21),

    -- Cuba
    ('camaguey.cu','Cuba',22),('guantanamo.gob.cu','Cuba',22), ('holguin.gob.cu','Cuba',22), ('mayabeque.cu','Cuba',22),('pinar.cu','Cuba',22),('santiago.cu','Cuba',22), ('sanctispiritus.cu','Cuba',22),('villa-clara.cu','Cuba',22),

    -- Cyprus
    ('parliament.cy','Cyprus',24), ('centralbank.cy','Cyprus',23),
    ('nicosia.org.cy','Cyprus',21), ('larnaka.org.cy','Cyprus',21),('larnaca.org.cy','Cyprus',21),
    ('limassolmunicipal.com.cy','Cyprus',21),('lemesos.org.cy','Cyprus',21),
    ('paphos.org.cy','Cyprus',21),('pafos.org.cy','Cyprus',21),('strovolos.org.cy','Cyprus',21),
    ('ayia-napa.org.cy','Cyprus',21),('aglantzia.org.cy','Cyprus',21),('aradippou.org.cy','Cyprus',21),

    -- Czech Republic
    ('vlada.cz','Czech Republic',24),('psp.cz','Czech Republic',24),('senat.cz','Czech Republic',24),
    ('justice.cz','Czech Republic',24),('mzv.cz','Czech Republic',24),('mzcr.cz','Czech Republic',24),
    ('mdcr.cz','Czech Republic',24),('mmr.cz','Czech Republic',24),('msmt.cz','Czech Republic',24),
    ('mpsv.cz','Czech Republic',24),('mvcr.cz','Czech Republic',24),('mfcr.cz','Czech Republic',24),
    ('mze.cz','Czech Republic',24),('mzp.cz','Czech Republic',24),('msp.cz','Czech Republic',24),
    ('csu.cz','Czech Republic',24),('uzis.cz','Czech Republic',24),('ero.cz','Czech Republic',24),
    ('uradprace.cz','Czech Republic',24),('cnb.cz','Czech Republic',24),('uoou.cz','Czech Republic',24),
    ('jihomoravsky.cz','Czech Republic',23),('jihocesky.cz','Czech Republic',23),
    ('kraj-vysocina.cz','Czech Republic',23),('kraj-lbc.cz','Czech Republic',23),
    ('khk.cz','Czech Republic',23),('olomouc.cz','Czech Republic',23),
    ('pardubickykraj.cz','Czech Republic',23),('plzensky-kraj.cz','Czech Republic',23),
    ('moravskoslezsky.cz','Czech Republic',23),('stredocesky.cz','Czech Republic',23),
    ('usk.cz','Czech Republic',23),('zlinsky.cz','Czech Republic',23),
    ('praha.eu','Czech Republic',22),('brno.cz','Czech Republic',22),('ostrava.cz','Czech Republic',22),
    ('plzen.eu','Czech Republic',22),('liberec.cz','Czech Republic',22),('olomouc.eu','Czech Republic',22),
    ('hradec.cz','Czech Republic',22),('pardubice.eu','Czech Republic',22),('usti.cz','Czech Republic',22),

    -- Denmark
    ('ft.dk','Denmark',24),('stm.dk','Denmark',24),('regeringen.dk','Denmark',24),('folketinget.dk','Denmark',24),('borger.dk','Denmark',24),('politi.dk','Denmark',24),('skat.dk','Denmark',24),('retsinformation.dk','Denmark',24),('sundhed.dk','Denmark',24),('virk.dk','Denmark',24),
    ('fm.dk','Denmark',24),('um.dk','Denmark',24),('jm.dk','Denmark',24),('fmn.dk','Denmark',24),('kefm.dk','Denmark',24),('sum.dk','Denmark',24),('kum.dk','Denmark',24),('ufm.dk','Denmark',24),('uvm.dk','Denmark',24),('bm.dk','Denmark',24),('skm.dk','Denmark',24),('em.dk','Denmark',24),('trm.dk','Denmark',24),('fvm.dk','Denmark',24),('uim.dk','Denmark',24),('sm.dk','Denmark',24),('digst.dk','Denmark',24),('km.dk','Denmark',24),('mssb.dk','Denmark',24),('urm.dk','Denmark',24),
    ('norden.dk','Denmark',23),('miljoeogfoedevarer.dk','Denmark',23),('arbejdstilsynet.dk','Denmark',23),('forsvaret.dk','Denmark',23),('dr.dk','Denmark',23),('dst.dk','Denmark',23),('sikkerdigital.dk','Denmark',23),('nemlog-in.dk','Denmark',23),('mitid.dk','Denmark',23),('nemkonto.dk','Denmark',23),('stps.dk','Denmark',23),('dataetiskraad.dk','Denmark',23),('at.dk','Denmark',23),
    ('regionh.dk','Denmark',23),('rsyd.dk','Denmark',23),('rm.dk','Denmark',23),('rn.dk','Denmark',23),('regionsjaelland.dk','Denmark',23),
    ('kk.dk','Denmark',22),('aarhus.dk','Denmark',22),('odense.dk','Denmark',22),('aalborg.dk','Denmark',22),('esbjerg.dk','Denmark',22),('randers.dk','Denmark',22),('kolding.dk','Denmark',22),('vejle.dk','Denmark',22),('horsens.dk','Denmark',22),('roskilde.dk','Denmark',22),('herning.dk','Denmark',22),('silkeborg.dk','Denmark',22),('naestved.dk','Denmark',22),('gladsaxe.dk','Denmark',22),('gentofte.dk','Denmark',22),('frederiksberg.dk','Denmark',22),('holbaek.dk','Denmark',22),('hjoerring.dk','Denmark',22),('koege.dk','Denmark',22),('varde.dk','Denmark',22),('viborg.dk','Denmark',22),('svendborg.dk','Denmark',22),('sonderborg.dk','Denmark',22),('ballerup.dk','Denmark',22),('rodovre.dk','Denmark',22),('helsingor.dk','Denmark',22),('albertslund.dk','Denmark',22),('egedal.dk','Denmark',22),('faaborgmidtfyn.dk','Denmark',22),('aabenraa.dk','Denmark',22),('fredericia.dk','Denmark',22),('skanderborg.dk','Denmark',22),('slagelse.dk','Denmark',22),('holstebro.dk','Denmark',22),

    -- Dubai (UAE)
    ('gov.ae','Dubai/UAE',24), ('uaeinteract.com','Dubai/UAE',23), ('uaecabinet.ae','Dubai/UAE',23), ('government.ae','Dubai/UAE',23), ('uaepresident.ae','Dubai/UAE',23),
    ('dubaigov.ae','Dubai/UAE',22), ('dubai.ae','Dubai/UAE',22), ('dm.gov.ae','Dubai/UAE',22), ('dewa.gov.ae','Dubai/UAE',22), ('rta.ae','Dubai/UAE',22),
    ('dxbcourts.gov.ae','Dubai/UAE',22), ('dubaitrade.ae','Dubai/UAE',22), ('dubaipolice.gov.ae','Dubai/UAE',22), ('dubaiairports.ae','Dubai/UAE',22), ('dubaihealth.gov.ae','Dubai/UAE',22),

    -- East Timor
    ('gov.tl','East Timor',24),('timor-leste.gov.tl','East Timor',24),('parlamento.tl','East Timor',24),('mj.gov.tl','East Timor',24),
    ('mire.gov.tl','East Timor',23),('mnec.gov.tl','East Timor',23),('me.tl','East Timor',23),('mss.gov.tl','East Timor',23),
    ('mejd.gov.tl','East Timor',23),('mj.gov.tl','East Timor',23),('mf.gov.tl','East Timor',23),('mdn.gov.tl','East Timor',23),
    ('misa.gov.tl','East Timor',23),('mtci.gov.tl','East Timor',23),('mjdac.gov.tl','East Timor',23),('mnec.tl','East Timor',23),
    ('tribunais.tl','East Timor',23),('procuradoria.tl','East Timor',23),('cne.tl','East Timor',23),('bancocentral.tl','East Timor',23),

    -- Estonia
    ('riigikantselei.ee','Estonia',24),('valitsus.ee','Estonia',24),('riigikogu.ee','Estonia',24),('riigiteataja.ee','Estonia',24),('riik.ee','Estonia',24),('eesti.ee','Estonia',24),('hm.ee','Estonia',24),('mkm.ee','Estonia',24),('siseministeerium.ee','Estonia',24),('sm.ee','Estonia',24),('kliimaministeerium.ee','Estonia',24),('agri.ee','Estonia',24),('just.ee','Estonia',24),('kaitseministeerium.ee','Estonia',24),('kul.ee','Estonia',24),('fin.ee','Estonia',24),('vm.ee','Estonia',24),('ria.ee','Estonia',24),('stat.ee','Estonia',24),('prokuratuur.ee','Estonia',24),('kohtuteave.ee','Estonia',24),('riigikohus.ee','Estonia',24),('tallinn.ee','Estonia',23),('tartu.ee','Estonia',23),('narva.ee','Estonia',23),('parnu.ee','Estonia',23),('viljandi.ee','Estonia',23),('rakvere.ee','Estonia',23),('kuressaare.ee','Estonia',23),

    -- Finland
    ('valtioneuvosto.fi','Finland',24),('presidentti.fi','Finland',24),('eduskunta.fi','Finland',24),('oikeus.fi','Finland',24),('suomi.fi','Finland',24),
    ('formin.fi','Finland',23),('intermin.fi','Finland',23),('vm.fi','Finland',23),('stm.fi','Finland',23),('okm.fi','Finland',23),
    ('mmm.fi','Finland',23),('lvm.fi','Finland',23),('ym.fi','Finland',23),('tem.fi','Finland',23),('defmin.fi','Finland',23),
    ('um.fi','Finland',23),('oikeusministerio.fi','Finland',23),('minedu.fi','Finland',23),('bmbwf.fi','Finland',23),
    ('vero.fi','Finland',22),('kela.fi','Finland',22),('poliisi.fi','Finland',22),('tulli.fi','Finland',22),('traficom.fi','Finland',22),
    ('migri.fi','Finland',22),('fimea.fi','Finland',22),('stat.fi','Finland',22),('thl.fi','Finland',22),('metsakeskus.fi','Finland',22),
    ('businessfinland.fi','Finland',22),('oph.fi','Finland',22),('avi.fi','Finland',22),('syke.fi','Finland',22),
    
    -- France
    ('gouvernement.fr','France',24),('elysee.fr','France',24),('service-public.fr','France',24),('legifrance.gouv.fr','France',24),('vie-publique.fr','France',24),('data.gouv.fr','France',24),('interieur.gouv.fr','France',24),('economie.gouv.fr','France',24),('travail-emploi.gouv.fr','France',24),('education.gouv.fr','France',24),('enseignementsup-recherche.gouv.fr','France',24),('justice.gouv.fr','France',24),('defense.gouv.fr','France',24),('sante.gouv.fr','France',24),('agriculture.gouv.fr','France',24),('culture.gouv.fr','France',24),('transition-ecologique.gouv.fr','France',24),('ecologie.gouv.fr','France',24),('diplomatie.gouv.fr','France',24),('impots.gouv.fr','France',24),('douane.gouv.fr','France',24),('france-visas.gouv.fr','France',24),
    ('insee.fr','France',23),('banque-france.fr','France',23),('cnil.fr','France',23),('pole-emploi.fr','France',23),('francetravail.fr','France',23),('ameli.fr','France',23),('assurance-maladie.fr','France',23),('urssaf.fr','France',23),('caf.fr','France',23),('cnam.fr','France',23),('cnav.fr','France',23),('labanquepostale.fr','France',22),('meteofrance.com','France',22),('meteofrance.fr','France',22),('boamp.fr','France',22),('marches-publics.gouv.fr','France',24),
    ('assemblee-nationale.fr','France',24),('senat.fr','France',24),('conseil-constitutionnel.fr','France',24),('conseil-etat.fr','France',24),('courdescomptes.fr','France',24),
    ('iledefrance.fr','France',23),('hautsdefrance.fr','France',23),('normandie.fr','France',23),('grandest.fr','France',23),('bourgognefranchecomte.fr','France',23),('centre-valdeloire.fr','France',23),('paysdelaloire.fr','France',23),('bretagne.bzh','France',23),('nouvelle-aquitaine.fr','France',23),('occitanie.fr','France',23),('auvergnerhonealpes.fr','France',23),('provencealpes-cotedazur.fr','France',23),('corse.fr','France',23),('lareunion.fr','France',23),('mayotte.fr','France',23),('guadeloupe.fr','France',23),('martinique.fr','France',23),('guyane.fr','France',23),('polynesie-francaise.pref.gouv.fr','France',24),('nouvelle-caledonie.gouv.fr','France',24),('saint-barth-saint-martin.gouv.fr','France',24),('saint-pierre-et-miquelon.gouv.fr','France',24),
    ('paris.fr','France',22),('lyon.fr','France',22),('marseille.fr','France',22),('toulouse.fr','France',22),('nice.fr','France',22),('nantes.fr','France',22),('montpellier.fr','France',22),('strasbourg.eu','France',22),('bordeaux.fr','France',22),('lille.fr','France',22),('rennes.fr','France',22),('reims.fr','France',22),('lehavre.fr','France',22),('saint-etienne.fr','France',22),('toulon.fr','France',22),('grenoble.fr','France',22),('dijon.fr','France',22),('angers.fr','France',22),('nancy.fr','France',22),('metz.fr','France',22),('clermont-ferrand.fr','France',22),('orleans.fr','France',22),('caen.fr','France',22),('tours.fr','France',22),('amiens.fr','France',22),('limoges.fr','France',22),('perpignan.fr','France',22),('annecy.fr','France',22),

    -- Georgia
    ('gov.ge','Georgia',24), ('parliament.ge','Georgia',24), ('president.ge','Georgia',24), ('nbe.gov.ge','Georgia',24), ('mfa.gov.ge','Georgia',24),
    ('justice.gov.ge','Georgia',24), ('moh.gov.ge','Georgia',24), ('moe.gov.ge','Georgia',24), ('police.ge','Georgia',23), ('rs.ge','Georgia',23),
    ('tbilisi.gov.ge','Georgia',22), ('batumi.gov.ge','Georgia',22), ('kutaisi.gov.ge','Georgia',22), ('rustavi.gov.ge','Georgia',22), ('zugdidi.gov.ge','Georgia',22),

    -- Greece
    ('presidency.gr','Greece',24), ('bankofgreece.gr','Greece',23),('areiospagos.gr','Greece',23), ('cityofathens.gr','Greece',22),
    ('thessaloniki.gr','Greece',22),('patras.gr','Greece',22),('heraklion.gr','Greece',22),('ioannina.gr','Greece',22),
    ('volos.gr','Greece',22),('chania.gr','Greece',22), ('kavala.gr','Greece',22),('kalamata.gr','Greece',22),
    ('lamia.gr','Greece',22),('serres.gr','Greece',22), ('agrinio.gr','Greece',22),('chalkida.gr','Greece',22),
    ('trikala.gr','Greece',22),('veria.gr','Greece',22), ('rethymno.gr','Greece',22),('xanthi.gr','Greece',22),
    ('kozani.gr','Greece',22),('corfu.gr','Greece',22),('rhodes.gr','Greece',22),

    -- Germany
    ('bund.de','Germany',24),('bundesregierung.de','Germany',24),('bundesrat.de','Germany',24),('bundestag.de','Germany',24), ('bundesverfassungsgericht.de','Germany',24),('bundesgerichtshof.de','Germany',24),('bundesverwaltungsgericht.de','Germany',24), ('bundesfinanzhof.de','Germany',24),('bundessozialgericht.de','Germany',24),('bundesarbeitsgericht.de','Germany',24), ('bundesnetzagentur.de','Germany',24),('bundespolizei.de','Germany',24),('polizei.de','Germany',24),('bmi.bund.de','Germany',24), ('auswaertiges-amt.de','Germany',24),('bmf.bund.de','Germany',24),('bmj.de','Germany',24),('bmwi.de','Germany',24), ('bmbf.de','Germany',24),('bmvg.de','Germany',24),('bmas.de','Germany',24),('bmfsfj.de','Germany',24),('bmel.de','Germany',24), ('bmuv.de','Germany',24),('bverwg.de','Germany',24),('bundeskartellamt.de','Germany',24),('bundesbank.de','Germany',24), ('destatis.de','Germany',24),('rki.de','Germany',24),('pei.de','Germany',24),
    ('bafin.de','Germany',24),('bka.de','Germany',24),('bka.bund.de','Germany',24),('bnd.bund.de','Germany',24),('zoll.de','Germany',24), ('bamf.de','Germany',24),('arbeitsagentur.de','Germany',24),('bundeswehr.de','Germany',24),('bsi.bund.de','Germany',24), ('uba.de','Germany',24),('bfarm.de','Germany',24),('bfr.bund.de','Germany',24),('dwd.de','Germany',24),('kba.de','Germany',24), ('bundesanzeiger.de','Germany',24),('gesetze-im-internet.de','Germany',24),('verwaltung.bund.de','Germany',24),('service.bund.de','Germany',24), ('govdata.de','Germany',24),('deutschland.de','Germany',23),('make-it-in-germany.com','Germany',23),
    ('bayern.de','Germany',23),('berlin.de','Germany',23),('brandenburg.de','Germany',23),('bremen.de','Germany',23),('hamburg.de','Germany',23), ('hessen.de','Germany',23),('mecklenburg-vorpommern.de','Germany',23),('niedersachsen.de','Germany',23),('nrw.de','Germany',23), ('land.nrw','Germany',24),('rlp.de','Germany',23),('saarland.de','Germany',23),('sachsen.de','Germany',23), ('sachsen-anhalt.de','Germany',23),('schleswig-holstein.de','Germany',23),('thueringen.de','Germany',23),
    ('landtag.nrw.de','Germany',23),('landtag-bw.de','Germany',23),('landtag.bayern.de','Germany',23), ('landtag.sachsen.de','Germany',23),('landtag.sachsen-anhalt.de','Germany',23),('landtag.brandenburg.de','Germany',23), ('landtag.rlp.de','Germany',23),('landtag-bb.de','Germany',23),
    ('nigeria.diplo.de','Germany',21),('tuerkei.diplo.de','Germany',21),('harare.diplo.de','Germany',21), ('tallinn.diplo.de','Germany',21),('brasil.diplo.de','Germany',21),

    -- Ghana
    ('ghana.gov.gh','Ghana',24),('gov.gh','Ghana',24),('parliament.gh','Ghana',24),
    ('mfa.gov.gh','Ghana',23),('moh.gov.gh','Ghana',23),('moe.gov.gh','Ghana',23),('moc.gov.gh','Ghana',23),
    ('mot.gov.gh','Ghana',23),('mojagd.gov.gh','Ghana',23),('moi.gov.gh','Ghana',23),('mofep.gov.gh','Ghana',23), ('moes.gov.gh','Ghana',23),('moj.gov.gh','Ghana',23),
    ('motac.gov.gh','Ghana',23),('moes.gov.gh','Ghana',23),('moesr.gov.gh','Ghana',23),('moesd.gov.gh','Ghana',23),
    ('bankofghana.org','Ghana',22),('gipc.gov.gh','Ghana',22),('ges.gov.gh','Ghana',22),('nss.gov.gh','Ghana',22),
    ('passport.mfa.gov.gh','Ghana',22),('gsa.gov.gh','Ghana',22),('nda.gov.gh','Ghana',22),('ndpc.gov.gh','Ghana',22),
    ('pensions.gov.gh','Ghana',22),('gepa.gov.gh','Ghana',22),('gipc.gov.gh','Ghana',22),('fda.gov.gh','Ghana',22),
    ('accra.gov.gh','Ghana',21),('kumasi.gov.gh','Ghana',21),('tamale.gov.gh','Ghana',21),('takoradi.gov.gh','Ghana',21),

    -- Greece
    ('gov.gr','Greece',24),('hellenicparliament.gr','Greece',24),('presidency.gr','Greece',24),
    ('mfa.gr','Greece',24),('ypes.gr','Greece',24),('aade.gr','Greece',24),('gsis.gr','Greece',24),
    ('civilprotection.gr','Greece',24), ('mindigital.gov.gr','Greece',23),('mnec.gov.gr','Greece',23),('minedu.gov.gr','Greece',23),
    ('yptp.gr','Greece',23),('minagric.gr','Greece',23),('migration.gov.gr','Greece',23),
    ('et.gr','Greece',23),('odihr.gr','Greece',23),('statistics.gr','Greece',23), ('kemep.gr','Greece',23),

    -- Greenland
    ('gov.gl','Greenland',24),('naalakkersuisut.gl','Greenland',24),('stat.gl','Greenland',24),('inatsisartut.gl','Greenland',24),('politi.gl','Greenland',24),
    ('sullissivik.gl','Greenland',24),('visitgreenland.gl','Greenland',24),('arcticcommand.gl','Greenland',24),('greenlandinstitute.gl','Greenland',24),('oqaasileriffik.gl','Greenland',24),('iluarsartuiffik.gl','Greenland',24),('energitjenesten.gl','Greenland',24),
    ('kujalleq.gl','Greenland',23),('sermersooq.gl','Greenland',23),('sisimiut.gl','Greenland',23),('kalaallitnunaata.gl','Greenland',23),('nusuka.gl','Greenland',23),('aviisi.gl','Greenland',23),('anjuma.gl','Greenland',23),('kni.gl','Greenland',23),('mhs.gl','Greenland',23),('gux.gl','Greenland',23),('univiseyisarti.gl','Greenland',23),

    -- Guyana
    ('gov.gy','Guyana',24),('parliament.gov.gy','Guyana',24),('op.gov.gy','Guyana',24),('mofa.gov.gy','Guyana',23),('finance.gov.gy','Guyana',23),('education.gov.gy','Guyana',23),('health.gov.gy','Guyana',23),

    -- Hungary
    ('kormany.hu','Hungary',24), ('parlament.hu','Hungary',24), ('birosag.hu','Hungary',24),('alkotmanybirosag.hu','Hungary',24),
    ('magyarorszag.hu','Hungary',23),('mnb.hu','Hungary',23),('ksh.hu','Hungary',23),('police.hu','Hungary',23),
    ('ajbh.hu','Hungary',23), ('valasztas.hu','Hungary',23),('kozbeszerzes.hu','Hungary',22),('budapest.hu','Hungary',22),
    ('debrecen.hu','Hungary',22),('szeged.hu','Hungary',22),('pecs.hu','Hungary',22), ('kormanyablak.hu','Hungary',22),
    ('miskolc.hu','Hungary',22),('gyor.hu','Hungary',22),('nyiregyhaza.hu','Hungary',22),
    ('kecskemet.hu','Hungary',22),('szekesfehervar.hu','Hungary',22),('szombathely.hu','Hungary',22),('tatabanya.hu','Hungary',22),
    ('kaposvar.hu','Hungary',22),('bekescsaba.hu','Hungary',22),('sopron.hu','Hungary',22),('eger.hu','Hungary',22),

    -- Iceland
    ('stjornarradid.is','Iceland',24), ('althingi.is','Iceland',24), ('lögreglan.is','Iceland',24), ('domstolar.is','Iceland',24), ('forseti.is','Iceland',24),
    ('utanrikisraduneyti.is','Iceland',24), ('forsaetisraduneyti.is','Iceland',24), ('fjarmalaraduneyti.is','Iceland',24), ('samgongustofa.is','Iceland',24), ('menntamalaraduneyti.is','Iceland',24),
    ('heilbrigdisraduneyti.is','Iceland',24), ('innviðaráðuneytið.is','Iceland',24), ('dómsmálaráðuneytið.is','Iceland',24), ('atvinnuvegaraduneyti.is','Iceland',24), ('umhverfisraduneyti.is','Iceland',24),
    ('skatturinn.is','Iceland',23), ('hagstofa.is','Iceland',23), ('utl.is','Iceland',23), ('landlaeknir.is','Iceland',23), ('island.is','Iceland',23),
    ('vinnueftirlit.is','Iceland',23), ('vinnumalastofnun.is','Iceland',23), ('mannvirkjastofnun.is','Iceland',23), ('vegagerdin.is','Iceland',23),
    ('reykjavik.is','Iceland',22), ('kopavogur.is','Iceland',22), ('hafnarfjordur.is','Iceland',22), ('akureyri.is','Iceland',22), ('gardabaer.is','Iceland',22),
    ('mos.is','Iceland',22), ('akeri.is','Iceland',22), ('keflavik.is','Iceland',22), ('selfoss.is','Iceland',22), ('egilsstadir.is','Iceland',22),

    -- India
    ('india.gov.in','India',24),('gov.in','India',24),('nic.in','India',24),('mea.gov.in','India',24),('mha.gov.in','India',24),('mohfw.gov.in','India',24),('mof.gov.in','India',24),('pmindia.gov.in','India',24),('presidentofindia.nic.in','India',24),('vicepresidentofindia.nic.in','India',24),('cabsec.gov.in','India',24),('parliamentofindia.nic.in','India',24),
    ('supremecourtofindia.nic.in','India',24),('indiacode.nic.in','India',24),('nalsa.gov.in','India',24),('lawcommissionofindia.nic.in','India',24),
    ('agriculture.gov.in','India',23),('rural.nic.in','India',23),('labour.gov.in','India',23),('education.gov.in','India',23),('defence.gov.in','India',23),('commerce.gov.in','India',23),('msme.gov.in','India',23),('morth.nic.in','India',23),('petroleum.nic.in','India',23),('power.gov.in','India',23),('coal.nic.in','India',23),('culture.gov.in','India',23),('tourism.gov.in','India',23),('tribal.nic.in','India',23),('socialjustice.nic.in','India',23),('minorityaffairs.gov.in','India',23),
    ('maharashtra.gov.in','India',22),('gujarat.gov.in','India',22),('rajasthan.gov.in','India',22),('up.gov.in','India',22),('kerala.gov.in','India',22),('tamilnadu.gov.in','India',22),('telangana.gov.in','India',22),('karnataka.gov.in','India',22),('westbengal.gov.in','India',22),('punjab.gov.in','India',22),('bihar.gov.in','India',22),('jharkhand.gov.in','India',22),('odisha.gov.in','India',22),('chhattisgarh.gov.in','India',22),('himachal.nic.in','India',22),('sikkim.gov.in','India',22),('mizoram.gov.in','India',22),('meghalaya.gov.in','India',22),('nagaland.gov.in','India',22),('tripura.gov.in','India',22),('manipur.gov.in','India',22),('arunachalpradesh.gov.in','India',22),('andhrapradesh.gov.in','India',22),
    ('uidai.gov.in','India',23),('nsdl.co.in','India',23),('incometaxindia.gov.in','India',23),('rbi.org.in','India',23),('sebi.gov.in','India',23),('irda.gov.in','India',23),('pfrda.org.in','India',23),

    -- Indonesia
    ('indonesia.go.id','Indonesia',24),('setneg.go.id','Indonesia',24),('dpr.go.id','Indonesia',24),('mahkamahagung.go.id','Indonesia',24),('kpu.go.id','Indonesia',24),
    ('kemdikbud.go.id','Indonesia',23),('kemenkeu.go.id','Indonesia',23),('kemlu.go.id','Indonesia',23),('kemhan.go.id','Indonesia',23),('kemenperin.go.id','Indonesia',23),('kemenkopmk.go.id','Indonesia',23),('kemenkumham.go.id','Indonesia',23),('kemenhub.go.id','Indonesia',23),('kemenparekraf.go.id','Indonesia',23),('kemenkes.go.id','Indonesia',23),('kemenag.go.id','Indonesia',23),('kemensos.go.id','Indonesia',23),('kemenpppa.go.id','Indonesia',23),('kemenristek.go.id','Indonesia',23),('kementan.go.id','Indonesia',23),('kemenaker.go.id','Indonesia',23),('kemenlhk.go.id','Indonesia',23),('kemenpu.go.id','Indonesia',23),
    ('jakarta.go.id','Indonesia',22),('jatimprov.go.id','Indonesia',22),('jabarprov.go.id','Indonesia',22),('jatengprov.go.id','Indonesia',22),('sumutprov.go.id','Indonesia',22),('sumbarprov.go.id','Indonesia',22),('sumselprov.go.id','Indonesia',22),('riau.go.id','Indonesia',22),('kepulauanriau.go.id','Indonesia',22),('lampungprov.go.id','Indonesia',22),('acehprov.go.id','Indonesia',22),('nttprov.go.id','Indonesia',22),('ntbprov.go.id','Indonesia',22),('papua.go.id','Indonesia',22),('papuabaratprov.go.id','Indonesia',22),('kalbarprov.go.id','Indonesia',22),('kaltimprov.go.id','Indonesia',22),('kaltengprov.go.id','Indonesia',22),('kalselprov.go.id','Indonesia',22),('sulselprov.go.id','Indonesia',22),('sulutprov.go.id','Indonesia',22),('sulbarprov.go.id','Indonesia',22),('sultrabaratprov.go.id','Indonesia',22),('gorontaloprov.go.id','Indonesia',22),('malutprov.go.id','Indonesia',22),('malukuprov.go.id','Indonesia',22),('bali.go.id','Indonesia',22),('bantenprov.go.id','Indonesia',22),('bangka.go.id','Indonesia',22),('babelprov.go.id','Indonesia',22),
    ('bandung.go.id','Indonesia',21),('surabaya.go.id','Indonesia',21),('semarang.go.id','Indonesia',21),('medan.go.id','Indonesia',21),('makassar.go.id','Indonesia',21),('denpasarkota.go.id','Indonesia',21),('yogyakarta.go.id','Indonesia',21),('bekasikota.go.id','Indonesia',21),('depok.go.id','Indonesia',21),('bogorkota.go.id','Indonesia',21),

    -- Iran
    ('gov.ir','Iran',24),('iran.ir','Iran',24),('irangov.ir','Iran',24),('president.ir','Iran',24),('parliran.ir','Iran',24),('adliran.ir','Iran',24),('cbi.ir','Iran',24),('moi.ir','Iran',23),('mop.ir','Iran',23),('mefa.ir','Iran',23),
    ('mfa.gov.ir','Iran',23),('ito.gov.ir','Iran',23), ('(^|\\.)[a-z0-9-]+\\.gov\\.ir$', 'Iran', 20),
    ('gov.iq','Iraq',24),('iraq.gov.iq','Iraq',24),('parliament.iq','Iraq',24),('presidency.iq','Iraq',24),('iraqna.iq','Iraq',23),('mofa.gov.iq','Iraq',23),('moi.gov.iq','Iraq',23),('moh.gov.iq','Iraq',23),

    -- Ireland
    ('gov.ie','Ireland',24),('oireachtas.ie','Ireland',24),('president.ie','Ireland',24),('citizensinformation.ie','Ireland',24),('irishstatutebook.ie','Ireland',24),
    ('finance.gov.ie','Ireland',23),('health.gov.ie','Ireland',23),('justice.ie','Ireland',23),('defence.ie','Ireland',23),('education.ie','Ireland',23),('enterprise.gov.ie','Ireland',23),('housing.gov.ie','Ireland',23),('socialprotection.ie','Ireland',23),('transport.gov.ie','Ireland',23),('agriculture.gov.ie','Ireland',23),('dttas.ie','Ireland',23),('environment.gov.ie','Ireland',23),('foreignaffairs.ie','Ireland',23),
    ('revenue.ie','Ireland',23),('courts.ie','Ireland',23),('agriculture.gov.ie','Ireland',23),('competitionandconsumer.ie','Ireland',23),('data.gov.ie','Ireland',23),('healthservice.hse.ie','Ireland',23),('hse.ie','Ireland',23),('rtb.ie','Ireland',23),('cso.ie','Ireland',23),
    ('dublincity.ie','Ireland',22),('corkcity.ie','Ireland',22),('galwaycity.ie','Ireland',22),('limerick.ie','Ireland',22),('waterfordcouncil.ie','Ireland',22),('fingal.ie','Ireland',22),('dlrcoco.ie','Ireland',22),('meath.ie','Ireland',22),('kildare.ie','Ireland',22),

    -- Italy
    ('governo.it','Italy',24),('parlamento.it','Italy',24),('senato.it','Italy',24),
    ('camera.it','Italy',24),('quirinale.it','Italy',24),
    ('esteri.it','Italy',23),('interno.gov.it','Italy',23),('difesa.it','Italy',23),('giustizia.it','Italy',23),
    ('salute.gov.it','Italy',23),('istruzione.it','Italy',23),('mipaaf.gov.it','Italy',23),('mise.gov.it','Italy',23),
    ('mims.gov.it','Italy',23),('mef.gov.it','Italy',23),('mase.gov.it','Italy',23),('minambiente.it','Italy',23),
    ('lavoro.gov.it','Italy',23),('cultura.gov.it','Italy',23),('turismo.gov.it','Italy',23),
    ('agid.gov.it','Italy',22),('agcom.it','Italy',22),('ivass.it','Italy',22),
    ('corteconti.it','Italy',22),('istat.it','Italy',22),('inps.it','Italy',22),
    ('agenziaentrate.gov.it','Italy',22),('agenziadoganemonopoli.gov.it','Italy',22),
    ('regione.lombardia.it','Italy',21),('regione.piemonte.it','Italy',21),('regione.lazio.it','Italy',21),
    ('regione.veneto.it','Italy',21),('regione.toscana.it','Italy',21),('regione.campania.it','Italy',21),
    ('regione.sicilia.it','Italy',21),('regione.emilia-romagna.it','Italy',21),
    ('comune.roma.it','Italy',20),('comune.milano.it','Italy',20),('comune.napoli.it','Italy',20),
    ('comune.torino.it','Italy',20),('comune.firenze.it','Italy',20),('comune.bologna.it','Italy',20),

    -- Japan
    ('kantei.go.jp','Japan',24), ('meti.go.jp','Japan',24), ('mofa.go.jp','Japan',24), ('cas.go.jp','Japan',24), ('npa.go.jp','Japan',24),
    ('courts.go.jp','Japan',24), ('stat.go.jp','Japan',24), ('e-gov.go.jp','Japan',24), ('jda.go.jp','Japan',24), ('mlit.go.jp','Japan',24),
    ('pref.osaka.lg.jp','Japan',23), ('pref.aichi.lg.jp','Japan',23), ('pref.kanagawa.lg.jp','Japan',23), ('pref.chiba.lg.jp','Japan',23), ('pref.kyoto.lg.jp','Japan',23),
    ('city.yokohama.lg.jp','Japan',22), ('city.kobe.lg.jp','Japan',22), ('city.sapporo.jp','Japan',22), ('city.fukuoka.lg.jp','Japan',22), ('city.hiroshima.lg.jp','Japan',22),

    -- Kosovo
    ('rks-gov.net','Kosovo',24), ('assembly-kosova.org','Kosovo',24), ('president-ksgov.net','Kosovo',24), ('ks-gov.net','Kosovo',23), ('kryeministri-ks.net','Kosovo',23),
    ('gjk-ks.org','Kosovo',23), ('kuvendikosoves.org','Kosovo',23), ('kallxo.com','Kosovo',22), ('rks-gov.org','Kosovo',23),
    ('prishtinaonline.com','Kosovo',22), ('prizreni.org','Kosovo',22), ('gjakova.org','Kosovo',22), ('ferizaj.org','Kosovo',22),

    -- Latvia
    ('gov.lv','Latvia',24),('mk.gov.lv','Latvia',24),('likumi.lv','Latvia',24),('president.lv','Latvia',24),('saeima.lv','Latvia',24),
    ('fm.gov.lv','Latvia',23),('mfa.gov.lv','Latvia',23),('mod.gov.lv','Latvia',23),('iem.gov.lv','Latvia',23),('em.gov.lv','Latvia',23),('izm.gov.lv','Latvia',23),('zm.gov.lv','Latvia',23),('am.gov.lv','Latvia',23),('lm.gov.lv','Latvia',23),('vmnvd.gov.lv','Latvia',23),
    ('csp.gov.lv','Latvia',23),('vd.gov.lv','Latvia',23),('pmlp.gov.lv','Latvia',23),('vraa.gov.lv','Latvia',23),('rtu.lv','Latvia',23),('riga.lv','Latvia',23),
    ('riga.lv','Latvia',22),('daugavpils.lv','Latvia',22),('liepaja.lv','Latvia',22),('jelgava.lv','Latvia',22),('ventspils.lv','Latvia',22),

    -- Liechtenstein
    ('llv.li','Liechtenstein',24),('regierung.li','Liechtenstein',24),('landtag.li','Liechtenstein',24),('gericht.li','Liechtenstein',24),('staatsanwaltschaft.li','Liechtenstein',24),
    ('gemeinden.li','Liechtenstein',23),
    
    -- Lithuania
    ('lrv.lt','Lithuania',24),('lrs.lt','Lithuania',24),('prezidentas.lt','Lithuania',24),
    ('urm.lt','Lithuania',23),('kam.lt','Lithuania',23),('smm.lt','Lithuania',23),('sveikata.lt','Lithuania',23),
    ('sumin.lt','Lithuania',23),('finmin.lt','Lithuania',23),('am.lt','Lithuania',23),('socmin.lt','Lithuania',23),
    ('ukmin.lt','Lithuania',23),('zum.lt','Lithuania',23),('teisingumas.lt','Lithuania',23),('vidmin.lt','Lithuania',23),
    ('stat.gov.lt','Lithuania',22),('vrk.lt','Lithuania',22),('policija.lt','Lithuania',22),('lvat.lt','Lithuania',22),
    ('ltok.lt','Lithuania',22),('uzt.lt','Lithuania',22),('migracija.lt','Lithuania',22),('vmi.lt','Lithuania',22),
    ('vilnius.lt','Lithuania',21),('kaunas.lt','Lithuania',21),('klaipeda.lt','Lithuania',21),
    ('siauliai.lt','Lithuania',21),('panevezys.lt','Lithuania',21),('alytus.lt','Lithuania',21),

    -- Luxembourg
    ('luxembourg.lu','Luxembourg',24),('etat.lu','Luxembourg',24),('public.lu','Luxembourg',24),('guichet.public.lu','Luxembourg',24),('data.public.lu','Luxembourg',24),('service-public.lu','Luxembourg',24),
    ('mfin.gouvernement.lu','Luxembourg',23),('maee.gouvernement.lu','Luxembourg',23),('mjustice.gouvernement.lu','Luxembourg',23),('meco.gouvernement.lu','Luxembourg',23),('mint.gouvernement.lu','Luxembourg',23),('mtes.gouvernement.lu','Luxembourg',23),('mss.gouvernement.lu','Luxembourg',23),('mcr.gouvernement.lu','Luxembourg',23),('mfamigr.gouvernement.lu','Luxembourg',23),('msh.gouvernement.lu','Luxembourg',23),
    ('legilux.public.lu','Luxembourg',23),('education.lu','Luxembourg',23),('secu.lu','Luxembourg',23),('cns.lu','Luxembourg',23),('statec.lu','Luxembourg',23),('ces.lu','Luxembourg',23),('police.public.lu','Luxembourg',23),('sante.public.lu','Luxembourg',23),('environnement.public.lu','Luxembourg',23),('snca.public.lu','Luxembourg',23),
    ('ville.lu','Luxembourg',22),('esch.lu','Luxembourg',22),('differdange.lu','Luxembourg',22),('dudelange.lu','Luxembourg',22),('ettelbruck.lu','Luxembourg',22),('remich.lu','Luxembourg',22),

    -- Malaysia
    ('malaysia.gov.my','Malaysia',24),('gov.my','Malaysia',24),('data.gov.my','Malaysia',24),
    ('moh.gov.my','Malaysia',23),('moe.gov.my','Malaysia',23),('mohr.gov.my','Malaysia',23),('mot.gov.my','Malaysia',23),('miti.gov.my','Malaysia',23),('mod.gov.my','Malaysia',23),('moa.gov.my','Malaysia',23),('mosti.gov.my','Malaysia',23),('mida.gov.my','Malaysia',23),('mohe.gov.my','Malaysia',23),('moha.gov.my','Malaysia',23),('mohd.gov.my','Malaysia',23),
    ('epu.gov.my','Malaysia',23),('bomba.gov.my','Malaysia',23),('immigration.gov.my','Malaysia',23),('police.gov.my','Malaysia',23),('spr.gov.my','Malaysia',23),('ecerdc.gov.my','Malaysia',23),('doe.gov.my','Malaysia',23),('jkr.gov.my','Malaysia',23),('lpse.gov.my','Malaysia',23),
    ('penang.gov.my','Malaysia',22),('perak.gov.my','Malaysia',22),('selangor.gov.my','Malaysia',22),('sabah.gov.my','Malaysia',22),('sarawak.gov.my','Malaysia',22),('kedah.gov.my','Malaysia',22),('kelantan.gov.my','Malaysia',22),('terengganu.gov.my','Malaysia',22),

    -- Malta
    ('gov.mt','Malta',24),('parlament.mt','Malta',24),('justice.gov.mt','Malta',24),
    ('govserv.gov.mt','Malta',24),('mepa.org.mt','Malta',24),

    -- Mexico
    ('gob.mx','Mexico',24),('presidencia.gob.mx','Mexico',24),('senado.gob.mx','Mexico',24),('diputados.gob.mx','Mexico',24),('scjn.gob.mx','Mexico',24),('inegi.org.mx','Mexico',24),('ine.mx','Mexico',24),
    ('segob.gob.mx','Mexico',23),('sre.gob.mx','Mexico',23),('shcp.gob.mx','Mexico',23),('sct.gob.mx','Mexico',23),('salud.gob.mx','Mexico',23),('sep.gob.mx','Mexico',23),('semarnat.gob.mx','Mexico',23),('sagarpa.gob.mx','Mexico',23),('stps.gob.mx','Mexico',23),('se.gob.mx','Mexico',23),('sedena.gob.mx','Mexico',23),('semar.gob.mx','Mexico',23),
    ('aguascalientes.gob.mx','Mexico',22),('bajacalifornia.gob.mx','Mexico',22),('bcs.gob.mx','Mexico',22),('campeche.gob.mx','Mexico',22),('coahuila.gob.mx','Mexico',22),('colima.gob.mx','Mexico',22),('chiapas.gob.mx','Mexico',22),('chihuahua.gob.mx','Mexico',22),('cdmx.gob.mx','Mexico',22),('durango.gob.mx','Mexico',22),('guanajuato.gob.mx','Mexico',22),('guerrero.gob.mx','Mexico',22),('hidalgo.gob.mx','Mexico',22),('jalisco.gob.mx','Mexico',22),('edomex.gob.mx','Mexico',22),('michoacan.gob.mx','Mexico',22),('morelos.gob.mx','Mexico',22),('nayarit.gob.mx','Mexico',22),('nuevoleon.gob.mx','Mexico',22),('oaxaca.gob.mx','Mexico',22),('puebla.gob.mx','Mexico',22),('queretaro.gob.mx','Mexico',22),('quintanaroo.gob.mx','Mexico',22),('sanluispotosi.gob.mx','Mexico',22),('sinaloa.gob.mx','Mexico',22),('sonora.gob.mx','Mexico',22),('tabasco.gob.mx','Mexico',22),('tamaulipas.gob.mx','Mexico',22),('tlaxcala.gob.mx','Mexico',22),('veracruz.gob.mx','Mexico',22),('yucatan.gob.mx','Mexico',22),('zacatecas.gob.mx','Mexico',22),

    -- Moldova
    ('parlament.md','Moldova',24), ('presedinte.md','Moldova',24), ('justice.md','Moldova',23), ('msmps.gov.md','Moldova',23), ('ms.gov.md','Moldova',23),
    ('statistica.md','Moldova',23), ('bnm.md','Moldova',23), ('anm.md','Moldova',23), ('cna.md','Moldova',23), ('anmec.md','Moldova',23),
    ('chisinau.md','Moldova',22), ('balti.md','Moldova',22), ('cahul.md','Moldova',22), ('comrat.md','Moldova',22),

    -- Monaco
    ('monaco.mc','Monaco',24), ('gouv.mc','Monaco',24), ('mairie.mc','Monaco',24), ('conseil-national.mc','Monaco',24), ('justice.mc','Monaco',24),
    ('monacochannel.mc','Monaco',23), ('service-public-entreprises.mc','Monaco',23), ('service-public-particuliers.mc','Monaco',23), ('maisondupatrimoine.mc','Monaco',23),

    -- Montenegro
    ('skupstina.me','Montenegro',24), ('predsjednik.me','Montenegro',24), ('sudovi.me','Montenegro',23), ('tuzioc.me','Montenegro',23), ('cso.gov.me','Montenegro',23),
    ('mif.gov.me','Montenegro',23), ('monstat.org','Montenegro',23), ('rtcg.me','Montenegro',23), ('pobjeda.me','Montenegro',22),
    ('podgorica.me','Montenegro',22), ('hercegnovi.me','Montenegro',22), ('bar.me','Montenegro',22), ('ulcinj.me','Montenegro',22),

    -- Morocco
    ('maroc.ma','Morocco',24),('gov.ma','Morocco',24),('service-public.ma','Morocco',24),
    ('justice.gov.ma','Morocco',24),('finances.gov.ma','Morocco',24),('sante.gov.ma','Morocco',24),
    ('interieur.gov.ma','Morocco',24),('map.ma','Morocco',24),('parlement.ma','Morocco',24),

    -- Nepal
    ('nepal.gov.np','Nepal',24),('nepalarmy.mil.np','Nepal',24),('supremecourt.gov.np','Nepal',24), ('parliament.gov.np','Nepal',24),('officeofattorneygeneral.gov.np','Nepal',24), ('mof.gov.np','Nepal',24),('moha.gov.np','Nepal',24),('moeap.gov.np','Nepal',24), ('mohp.gov.np','Nepal',24),('mofa.gov.np','Nepal',24),('moi.gov.np','Nepal',24), ('moest.gov.np','Nepal',24),('mowcsw.gov.np','Nepal',24),('mopit.gov.np','Nepal',24),('mofaga.gov.np','Nepal',24),('moewri.gov.np','Nepal',24),('npc.gov.np','Nepal',24),

    -- Netherlands
    ('overheid.nl','Netherlands',24),('rijksoverheid.nl','Netherlands',24), ('belastingdienst.nl','Netherlands',24),('politie.nl','Netherlands',24), ('kvk.nl','Netherlands',24),('cbs.nl','Netherlands',24),('rvo.nl','Netherlands',24), ('rijkshuisstijl.nl','Netherlands',24),('rechtspraak.nl','Netherlands',24), ('wetten.overheid.nl','Netherlands',24),('kamer.nl','Netherlands',24), ('eerstekamer.nl','Netherlands',24),('tweedekamer.nl','Netherlands',24), ('mijnoverheid.nl','Netherlands',24),('koninklijkhuis.nl','Netherlands',24), ('openbaarministerie.nl','Netherlands',24),('raadvanstate.nl','Netherlands',24), ('autoriteitpersoonsgegevens.nl','Netherlands',24),('autoriteitconsumentmarkt.nl','Netherlands',24), ('marechaussee.nl','Netherlands',24),   
    ('drenthe.nl','Netherlands',23),('flevoland.nl','Netherlands',23),('friesland.nl','Netherlands',23), ('gelderland.nl','Netherlands',23),('groningen.nl','Netherlands',23),('limburg.nl','Netherlands',23), ('noord-brabant.nl','Netherlands',23),('noord-holland.nl','Netherlands',23),('overijssel.nl','Netherlands',23), ('utrecht.nl','Netherlands',23),('zeeland.nl','Netherlands',23),('zuid-holland.nl','Netherlands',23),

    -- New Zealand
    ('govt.nz','New Zealand',24),('parliament.nz','New Zealand',24),
    ('justice.govt.nz','New Zealand',24),('treasury.govt.nz','New Zealand',24),
    ('health.govt.nz','New Zealand',24),('education.govt.nz','New Zealand',24),
    ('police.govt.nz','New Zealand',24),
    ('28maoribattalion.org.nz','New Zealand',23),('airforcemuseum.co.nz','New Zealand',23),
    ('bullyingfree.nz','New Zealand',23),('cadetforces.org.nz','New Zealand',23),
    ('christchurchattack.royalcommission.nz','New Zealand',23),
    ('digitalpassport.co.nz','New Zealand',23),('employment.elearning.ac.nz','New Zealand',23),
    ('ethnicxchange.org.nz','New Zealand',23),('etuwhanau.org.nz','New Zealand',23),
    ('forum.changeispossible.org.nz','New Zealand',23),('inclusive.tki.org.nz','New Zealand',23),
    ('koordinates.com','New Zealand',23),('kupe.net.nz','New Zealand',23),
    ('marinebiosecurity.org.nz','New Zealand',23),('msd.mykoha.co.nz','New Zealand',23),
    ('navymuseum.co.nz','New Zealand',23),('nzsar-resources.org.nz','New Zealand',23),
    ('nztcs.org.nz','New Zealand',23),('paekupu.co.nz','New Zealand',23),
    ('pasefikaproud.co.nz','New Zealand',23),('protectedspeciescaptures.nz','New Zealand',23),
    ('readingambassador.nz','New Zealand',23),('resources.alcohol.org.nz','New Zealand',23),
    ('sltk-resources.tki.org.nz','New Zealand',23),('tatai.maori.nz','New Zealand',23),
    ('tehekemai.co.nz','New Zealand',23),('tuiaeducation.org.nz','New Zealand',23),
    ('www.abuseincare.org.nz','New Zealand',23),('www.adventuresmart.nz','New Zealand',23),
    ('www.alcohol.org.nz','New Zealand',23),('www.areyouok.org.nz','New Zealand',23),
    ('www.armymuseum.co.nz','New Zealand',23),('www.artwork.org.nz','New Zealand',23),
    ('www.bionet.nz','New Zealand',23),('www.boardappointments.co.nz','New Zealand',23),
    ('www.cadetnet.org.nz','New Zealand',23),('www.changeispossible.org.nz','New Zealand',23),
    ('www.childrensday.org.nz','New Zealand',23),('www.christchurchappealtrust.org.nz','New Zealand',23),
    ('www.connect.co.nz','New Zealand',23),

    -- Norway
    ('regjeringen.no','Norway',24),('stortinget.no','Norway',24),('nav.no','Norway',24),
    ('helsenorge.no','Norway',24),('udir.no','Norway',24),('udi.no','Norway',24),
    ('politi.no','Norway',24),('nve.no','Norway',24),('ssb.no','Norway',24),
    ('norges-bank.no','Norway',24),('miljodirektoratet.no','Norway',24),
    ('arbeidstilsynet.no','Norway',24),('forsvaret.no','Norway',24),('skatteetaten.no','Norway',24),
    ('brreg.no','Norway',24),('vegvesen.no','Norway',24),('mattilsynet.no','Norway',24),
    ('lovdata.no','Norway',24),('altinn.no','Norway',24),('nkom.no','Norway',24),
    ('fhi.no','Norway',24),('dsa.no','Norway',24),('kystverket.no','Norway',24),
    ('bufdir.no','Norway',24),('nupi.no','Norway',24),

    -- North Korea
    ('naenara.com.kp','North Korea',24), ('kcna.kp','North Korea',24), ('airkoryo.com.kp','North Korea',23), ('friend.com.kp','North Korea',22),

    -- North Macedonia
    ('sobranie.mk','North Macedonia',24), ('president.mk','North Macedonia',24), ('pravda.gov.mk','North Macedonia',23), ('mvr.gov.mk','North Macedonia',23), ('finance.gov.mk','North Macedonia',23),
    ('stat.gov.mk','North Macedonia',23), ('mon.gov.mk','North Macedonia',23), ('ujp.gov.mk','North Macedonia',23), ('jorm.gov.mk','North Macedonia',23), ('av.gov.mk','North Macedonia',23),
    ('skopje.gov.mk','North Macedonia',22), ('bitola.gov.mk','North Macedonia',22), ('stip.gov.mk','North Macedonia',22), ('tetovo.gov.mk','North Macedonia',22),

    -- Peru
    ('gob.pe','Peru',24),('peru.gob.pe','Peru',24),('presidencia.gob.pe','Peru',24),
    ('congreso.gob.pe','Peru',24),('poderjudicial.gob.pe','Peru',24),
    ('minjus.gob.pe','Peru',24),('minedu.gob.pe','Peru',24),
    ('minsa.gob.pe','Peru',24),('mef.gob.pe','Peru',24),
    ('mininter.gob.pe','Peru',24),('mindef.gob.pe','Peru',24),
    ('minem.gob.pe','Peru',24),('mincetur.gob.pe','Peru',24),
    ('minam.gob.pe','Peru',24),('produce.gob.pe','Peru',24),
    ('sunat.gob.pe','Peru',24),('onpe.gob.pe','Peru',24),
    ('reniec.gob.pe','Peru',24),('osiptel.gob.pe','Peru',24),
    ('osce.gob.pe','Peru',24),

    -- Philippines
    ('gov.ph','Philippines',24),('president.gov.ph','Philippines',24),
    ('senate.gov.ph','Philippines',24),('house.gov.ph','Philippines',24),
    ('supremecourt.gov.ph','Philippines',24),('ca.judiciary.gov.ph','Philippines',24),
    ('coa.gov.ph','Philippines',24),('comelec.gov.ph','Philippines',24),
    ('doh.gov.ph','Philippines',24),('deped.gov.ph','Philippines',24),
    ('dfa.gov.ph','Philippines',24),('dilg.gov.ph','Philippines',24),
    ('doj.gov.ph','Philippines',24),('dnd.gov.ph','Philippines',24),
    ('dotr.gov.ph','Philippines',24),('dpwh.gov.ph','Philippines',24),
    ('dswd.gov.ph','Philippines',24),('dti.gov.ph','Philippines',24),
    ('denr.gov.ph','Philippines',24),('pagasa.dost.gov.ph','Philippines',24),
    ('neda.gov.ph','Philippines',24),('pnp.gov.ph','Philippines',24),
    ('psa.gov.ph','Philippines',24),('pagibigfund.gov.ph','Philippines',24),

    -- Poland
    ('prezydent.pl','Poland',24), ('nbp.pl','Poland',23),
    ('zus.pl','Poland',23),('policja.pl','Poland',23),('warszawa.pl','Poland',22),('krakow.pl','Poland',22),
    ('poznan.pl','Poland',22), ('gdansk.pl','Poland',22),('wroclaw.pl','Poland',22),('lodz.pl','Poland',22),
    ('bydgoszcz.pl','Poland',22),('torun.pl','Poland',22),('rzeszow.pl','Poland',22),('bialystok.pl','Poland',22),
    ('gdynia.pl','Poland',22),('sopot.pl','Poland',22),('czestochowa.pl','Poland',22),('szczecin.pl','Poland',22),
    ('bielsko-biala.pl','Poland',22),('zielona-gora.pl','Poland',22),('gorzow.pl','Poland',22),('lublin.eu','Poland',22),
    ('opole.pl','Poland',22),('tarnow.pl','Poland',22),('radom.pl','Poland',22), ('katowice.eu','Poland',22),
    ('kielce.eu','Poland',22),('gliwice.eu','Poland',22),('olsztyn.eu','Poland',22),('plock.eu','Poland',22),

    -- Portugal
    ('portugal.gov.pt','Portugal',24),('parlamento.pt','Portugal',24),
    ('presidencia.pt','Portugal',24),('tribunalconstitucional.pt','Portugal',24),
    ('pgdlisboa.pt','Portugal',24),('cmjornal.pt','Portugal',24),
    ('dre.pt','Portugal',24),('base.gov.pt','Portugal',24),
    ('ana.pt','Portugal',24),('ansr.pt','Portugal',24),

    -- Romania
    ('presidency.ro','Romania',24),('cdep.ro','Romania',24),('senat.ro','Romania',24),('just.ro','Romania',24),
    ('mae.ro','Romania',24),('mapn.ro','Romania',24),('bnr.ro','Romania',23),('anaf.ro','Romania',23),
    ('insse.ro','Romania',23),('cnas.ro','Romania',23),('ms.ro','Romania',23),('sri.ro','Romania',23),
    ('sie.ro','Romania',23),('sts.ro','Romania',23),('politiaromana.ro','Romania',23),
    ('roaep.ro','Romania',23),('pmb.ro','Romania',22),('clujnapoca.ro','Romania',22),('iasi.ro','Romania',22),
    ('timisoara.ro','Romania',22),('constanta.ro','Romania',22),
    ('oradea.ro','Romania',22),('sibiu.ro','Romania',22),('arad.ro','Romania',22),
    ('galati.ro','Romania',22),('bacau.ro','Romania',22),('brasovcity.ro','Romania',22),

    -- Russia
    ('government.ru','Russia',24),('kremlin.ru','Russia',24),('duma.gov.ru','Russia',24),('council.gov.ru','Russia',24),
    ('supcourt.ru','Russia',24),('minfin.gov.ru','Russia',24),('minjust.gov.ru','Russia',24),('mid.ru','Russia',24),
    ('minobrnauki.gov.ru','Russia',24),('minzdrav.gov.ru','Russia',24),('mintrud.gov.ru','Russia',24),('mchs.gov.ru','Russia',24),
    ('fsb.ru','Russia',24),('fso.gov.ru','Russia',24),('prosecutor.ru','Russia',24),('roskazna.gov.ru','Russia',24),
    ('fssprus.ru','Russia',24),('nalog.gov.ru','Russia',24),('customs.gov.ru','Russia',24),('gks.ru','Russia',24),
    ('govvrn.ru','Russia',24),

    -- San Marino
    ('gov.sm','San Marino',24), ('consigliograndeegenerale.sm','San Marino',24), ('esteri.sm','San Marino',23), ('giustizia.sm','San Marino',23), ('sanita.sm','San Marino',23),
    ('istruzione.sm','San Marino',23), ('finanze.sm','San Marino',23), ('turismo.sm','San Marino',23),

    -- Serbia
    ('parlament.rs','Serbia',24), ('predsednik.rs','Serbia',24), ('vojvodina.gov.rs','Serbia',23), ('srbija.rs','Serbia',23), ('beograd.rs','Serbia',22),
    ('novisad.rs','Serbia',22), ('kragujevac.rs','Serbia',22), ('nis.rs','Serbia',22), ('subotica.rs','Serbia',22), ('uzice.rs','Serbia',22),
    ('rfzo.rs','Serbia',23), ('apr.gov.rs','Serbia',23), ('nbs.rs','Serbia',23), ('stat.gov.rs','Serbia',23),

    -- Singapore
    ('gov.sg','Singapore',24),('istana.gov.sg','Singapore',24),('parliament.gov.sg','Singapore',24),
    ('supremecourt.gov.sg','Singapore',24),('statecourts.gov.sg','Singapore',24),('agc.gov.sg','Singapore',24),
    ('mof.gov.sg','Singapore',24),('mfa.gov.sg','Singapore',24),('mha.gov.sg','Singapore',24),
    ('mewr.gov.sg','Singapore',24),('moe.gov.sg','Singapore',24),('moh.gov.sg','Singapore',24),
    ('mot.gov.sg','Singapore',24),('mti.gov.sg','Singapore',24),('mccy.gov.sg','Singapore',24),
    ('mnd.gov.sg','Singapore',24),('msf.gov.sg','Singapore',24),('mse.gov.sg','Singapore',24),
    ('mom.gov.sg','Singapore',24),('mci.gov.sg','Singapore',24),('mindef.gov.sg','Singapore',24),
    ('mlaw.gov.sg','Singapore',24),('nea.gov.sg','Singapore',24),('iras.gov.sg','Singapore',24),
    ('singstat.gov.sg','Singapore',24),('data.gov.sg','Singapore',24),('tech.gov.sg','Singapore',24),
    ('govtech.gov.sg','Singapore',24),

    -- South Africa
    ('gov.za','South Africa',24),('parliament.gov.za','South Africa',24),('justice.gov.za','South Africa',24),
    ('health.gov.za','South Africa',24),('education.gov.za','South Africa',24),('treasury.gov.za','South Africa',24),
    ('dirco.gov.za','South Africa',24),('defence.gov.za','South Africa',24),('sapolice.gov.za','South Africa',24),
    ('environment.gov.za','South Africa',24),('labour.gov.za','South Africa',24),('transport.gov.za','South Africa',24),
    ('dpsa.gov.za','South Africa',24),('cogta.gov.za','South Africa',24),

    -- Slovakia
    ('slovensko.sk','Slovakia',24), ('gov.sk','Slovakia',24), ('vlada.gov.sk','Slovakia',24), ('nrsr.sk','Slovakia',24), ('justice.gov.sk','Slovakia',24),
    ('mzv.sk','Slovakia',23), ('finance.gov.sk','Slovakia',23), ('minv.sk','Slovakia',23), ('economy.gov.sk','Slovakia',23), ('health.gov.sk','Slovakia',23),
    ('bratislava.sk','Slovakia',22), ('kosice.sk','Slovakia',22), ('presov.sk','Slovakia',22), ('zilina.sk','Slovakia',22), ('nitra.sk','Slovakia',22),
    ('trnava.sk','Slovakia',22), ('trencin.sk','Slovakia',22), ('banskabystrica.sk','Slovakia',22), ('martin.sk','Slovakia',22), ('poprad.sk','Slovakia',22),

    -- Slovenia
    ('gov.si','Slovenia',24), ('vlada.si','Slovenia',24), ('dz-rs.si','Slovenia',24), ('ds-rs.si','Slovenia',24), ('us-rs.si','Slovenia',24),
    ('mzz.si','Slovenia',23), ('mz.gov.si','Slovenia',23), ('mf.gov.si','Slovenia',23), ('mnz.gov.si','Slovenia',23), ('mju.gov.si','Slovenia',23),
    ('ljubljana.si','Slovenia',22), ('maribor.si','Slovenia',22), ('celje.si','Slovenia',22), ('koper.si','Slovenia',22), ('kranj.si','Slovenia',22),
    ('nova-gorica.si','Slovenia',22), ('ptuj.si','Slovenia',22), ('trbovlje.si','Slovenia',22), ('kamnik.si','Slovenia',22), ('slovenjgradec.si','Slovenia',22),

    -- South Korea
    ('korea.kr','South Korea',24), ('moel.go.kr','South Korea',23), ('cha.go.kr','South Korea',23), ('bok.or.kr','South Korea',22), ('kostat.go.kr','South Korea',22),

    -- Spain
    ('lamoncloa.gob.es','Spain',24),('mptfp.gob.es','Spain',24),('hacienda.gob.es','Spain',24),('interior.gob.es','Spain',24),('justicia.gob.es','Spain',24),('exteriores.gob.es','Spain',24),('transicionecologica.gob.es','Spain',24),('transportes.gob.es','Spain',24),('educacionyfp.gob.es','Spain',24),('sanidad.gob.es','Spain',24),('agricultura.gob.es','Spain',24),('ciencia.gob.es','Spain',24),('industria.gob.es','Spain',24),('trabajo.gob.es','Spain',24),('inclusion.gob.es','Spain',24),('igualdad.gob.es','Spain',24),('policia.es','Spain',24),('guardiacivil.es','Spain',24),('dgt.es','Spain',24),('aemet.es','Spain',24),('aeat.es','Spain',24),('agenciatributaria.es','Spain',24),('seg-social.es','Spain',24),('seguridadsocial.gob.es','Spain',24),('ine.es','Spain',24),('boe.es','Spain',24),
    ('congreso.es','Spain',24),('congresodelosdiputados.es','Spain',24),('senado.es','Spain',24),('poderjudicial.es','Spain',24),('tribunalconstitucional.es','Spain',24),('audiencia-nacional.es','Spain',24),('tribunaldecuentas.es','Spain',24),('defensordelpueblo.es','Spain',24),
    ('juntadeandalucia.es','Spain',23),('andalucia.es','Spain',23),('aragon.es','Spain',23), ('asturias.es','Spain',23),('cantabria.es','Spain',23),('castillalamancha.es','Spain',23), ('jccm.es','Spain',23),('jcyl.es','Spain',23),('gencat.cat','Spain',23),
    ('comunidad.madrid','Spain',23),('navarra.es','Spain',23),('larioja.org','Spain',23), ('xunta.gal','Spain',23),('gva.es','Spain',23),('carm.es','Spain',23), ('juntaex.es','Spain',23),('caib.es','Spain',23),('gobiernodecanarias.org','Spain',23), ('euskadi.eus','Spain',23),('irekia.euskadi.eus','Spain',23),
    ('madrid.es','Spain',22),('barcelona.cat','Spain',22),('valencia.es','Spain',22),('sevilla.org','Spain',22),('zaragoza.es','Spain',22),('malaga.eu','Spain',22),('bilbao.eus','Spain',22),('vitoria-gasteiz.org','Spain',22),('donostia.eus','Spain',22),

    -- Suriname
    ('gov.sr','Suriname',24),('dna.sr','Suriname',24),
    ('president.gov.sr','Suriname',24),('ministerievanfinancien.gov.sr','Suriname',23),('biza.gov.sr','Suriname',23),('justice.gov.sr','Suriname',23),

    -- Sweden
    ('gov.se','Sweden',24),('regeringen.se','Sweden',24),('riksdagen.se','Sweden',24),('domstol.se','Sweden',24),
    ('skatteverket.se','Sweden',24),('forsakringskassan.se','Sweden',24),('arbetsformedlingen.se','Sweden',24),
    ('polisen.se','Sweden',24),('trafikverket.se','Sweden',24),('kriminalvarden.se','Sweden',24),
    ('smhi.se','Sweden',24),('naturvardsverket.se','Sweden',24),('socialstyrelsen.se','Sweden',24),
    ('1177.se','Sweden',24),('sl.se','Sweden',24),
    ('funktionstjanster.se','Sweden',23),('hemnet.se','Sweden',23),('sverigesradio.se','Sweden',23),
    ('klart.se','Sweden',23),('bankid.com','Sweden',23),
    ('schoolsoft.se','Sweden',23),('postnord.se','Sweden',23),('grandid.com','Sweden',23),('skola24.se','Sweden',23),('vklass.se','Sweden',23),

    -- Switzerland
    ('admin.ch','Switzerland',24),('parlament.ch','Switzerland',24),('bundesgericht.ch','Switzerland',24),
    ('seco.admin.ch','Switzerland',24),('bag.admin.ch','Switzerland',24),('bfs.admin.ch','Switzerland',24),
    ('eda.admin.ch','Switzerland',24),('eda.admin.ch','Switzerland',24),('vbs.admin.ch','Switzerland',24),
    ('ejpd.admin.ch','Switzerland',24),('efd.admin.ch','Switzerland',24),('bfe.admin.ch','Switzerland',24),
    ('bazg.admin.ch','Switzerland',24),('bafu.admin.ch','Switzerland',24),('bfh.ch','Switzerland',24),
    ('unige.ch','Switzerland',24),('epfl.ch','Switzerland',24),('ethz.ch','Switzerland',24),

    -- Taiwan
    ('president.gov.tw','Taiwan',24), ('legislative.gov.tw','Taiwan',24), ('judicial.gov.tw','Taiwan',24), ('mofa.gov.tw','Taiwan',23), ('moi.gov.tw','Taiwan',23),
    ('mnd.gov.tw','Taiwan',23), ('mof.gov.tw','Taiwan',23), ('mohw.gov.tw','Taiwan',23), ('moe.gov.tw','Taiwan',23), ('taipei.gov.tw','Taiwan',22),
    ('kaohsiung.gov.tw','Taiwan',22), ('tainan.gov.tw','Taiwan',22), ('taichung.gov.tw','Taiwan',22), ('hsinchu.gov.tw','Taiwan',22),
    ('nat.gov.tw','Taiwan',23), ('ey.gov.tw','Taiwan',23), ('ndl.gov.tw','Taiwan',22), ('cdc.gov.tw','Taiwan',22), ('ncc.gov.tw','Taiwan',22),

    -- Türkiye
    ('tccb.gov.tr','Türkiye',24), ('meb.gov.tr','Türkiye',24), ('sgk.gov.tr','Türkiye',24), ('diyanet.gov.tr','Türkiye',24), ('tbmm.gov.tr','Türkiye',24),
    ('ysk.gov.tr','Türkiye',24), ('mfa.gov.tr','Türkiye',24), ('icisleri.gov.tr','Türkiye',24), ('adalet.gov.tr','Türkiye',24), ('msb.gov.tr','Türkiye',24),
    ('ankara.bel.tr','Türkiye',23), ('istanbul.bel.tr','Türkiye',23), ('izmir.bel.tr','Türkiye',23), ('bursa.bel.tr','Türkiye',23), ('antalya.bel.tr','Türkiye',23),

    -- Ukraine
    ('gov.ua','Ukraine',24),('rada.gov.ua','Ukraine',24),('president.gov.ua','Ukraine',24),
    ('kmu.gov.ua','Ukraine',24),('minfin.gov.ua','Ukraine',24),('mon.gov.ua','Ukraine',24),
    ('mvs.gov.ua','Ukraine',24),('mfa.gov.ua','Ukraine',24),('minjust.gov.ua','Ukraine',24),
    ('minregion.gov.ua','Ukraine',24),('mincult.gov.ua','Ukraine',24),('mil.gov.ua','Ukraine',24),
    ('dsns.gov.ua','Ukraine',24),('ssu.gov.ua','Ukraine',24),('sfs.gov.ua','Ukraine',24),
    ('nas.gov.ua','Ukraine',24),('court.gov.ua','Ukraine',24),('zakon.rada.gov.ua','Ukraine',24),
    ('council.gov.ua','Ukraine',24),('prosecutor.gov.ua','Ukraine',24),

    -- United Kingdom (UK)
    ('parliament.uk','United Kingdom (UK)',24), ('judiciary.uk','United Kingdom (UK)',24), ('supremecourt.uk','United Kingdom (UK)',24), ('parliament.scot','United Kingdom (UK)',24), ('senedd.wales','United Kingdom (UK)',24), ('senedd.cymru','United Kingdom (UK)',24), ('police.scot','United Kingdom (UK)',23),
    ('london.gov.uk','United Kingdom (UK)',24), ('cityoflondon.gov.uk','United Kingdom (UK)',24), ('birmingham.gov.uk','United Kingdom (UK)',24), ('manchester.gov.uk','United Kingdom (UK)',24), ('leeds.gov.uk','United Kingdom (UK)',24), ('liverpool.gov.uk','United Kingdom (UK)',24), ('sheffield.gov.uk','United Kingdom (UK)',24), ('bristol.gov.uk','United Kingdom (UK)',24), ('glasgow.gov.uk','United Kingdom (UK)',24), ('edinburgh.gov.uk','United Kingdom (UK)',24), ('cardiff.gov.uk','United Kingdom (UK)',24), ('belfastcity.gov.uk','United Kingdom (UK)',24),

    -- United States (USA)
    ('si.edu','United States (USA)',24), ('dau.edu','United States (USA)',24), ('usps.com','United States (USA)',24), ('myflorida.com','United States (USA)',22), 
    ('lacity.org','United States (USA)',22), ('denvergov.org','United States (USA)',22), ('vbgov.com','United States (USA)',22), ('miamigov.com','United States (USA)',22), ('muni.org','United States (USA)',22), ('ocfl.net','United States (USA)',22), ('dallascityhall.com','United States (USA)',22),

    -- Uruguay
    ('gub.uy','Uruguay',24),('uruguay.gub.uy','Uruguay',24),('parlamento.gub.uy','Uruguay',24),
    ('presidencia.gub.uy','Uruguay',24),('ministerio.gub.uy','Uruguay',24),('poderjudicial.gub.uy','Uruguay',24),

    -- Vietnam
    ('chinhphu.vn','Vietnam',24), ('quochoi.vn','Vietnam',24), ('vpcp.chinhphu.vn','Vietnam',23), ('mof.gov.vn','Vietnam',23), ('molisa.gov.vn','Vietnam',23)

    ])
),

-- 2) Regex family rules for patterned domains (.gov.uk, .gob.es, etc.)
regex_rules AS (
  SELECT * FROM UNNEST([

    -- United Nations
    STRUCT('(^|\\.)(([a-z0-9-]+\\.)*un\\.org)$' AS pattern, 'United Nations' AS bucket, 9 AS priority),   -- core un.org + subdomains
    ('(^|\\.)(([a-z0-9-]+\\.)*(who|icao|wmo|wipo|itu)\\.int)$', 'United Nations', 9),                     -- .int agencies
    ('(^|\\.)(([a-z0-9-]+\\.)*(undp|unhcr|unicef|unodc|unido|unfpa)\\.org)$','United Nations',9),         -- .org agencies

    -- European Union
    ('(^|\\.)(([a-z0-9-]+\\.)*eu\\.int|(eu20\\d{2}|20\\d{2}eu|[a-z]{2}20\\d{2})\\.(eu|[a-z]{2}))$', 'European Union', 23),                -- *.eu.int and “EU Presidency” style hostnames like eu2025.xx
    ('(^|\\.)((copernicus|euvsdisinfo|europeana|europass|wifi4eu|sanctionsmap|open-research-europe|euipo)\\.eu)$', 'European Union', 23), -- Well-known .eu program sites

    -- Canada
    ('(^|\\.)[a-z0-9-]+\\.gc\\.ca$', 'Canada', 22),
    ('(^|\\.)[a-z0-9-]+\\.canada\\.ca$', 'Canada', 22),
    ('(^|\\.)gov\\.(ab|bc|mb|nb|nl|ns|nt|nu|on|pe|qc|sk|yk)\\.ca$', 'Canada', 22),

    -- Denmark
    ('(^|\\.)((regionh|rsyd|rm|rn|regionsjaelland)\\.dk)$', 'Denmark', 23),
    ('(^|\\.)((politi|skat|sundhed|virk|borger)\\.dk)$', 'Denmark', 23),

    -- France
    ('(^|\\.)((assemblee-nationale|senat|conseil-constitutionnel|conseil-etat|courdescomptes|vie-publique)\\.fr)$', 'France', 24),
    -- ('(^|\\.)(([a-z0-9-]+\\.)*gouv\\.fr)$', 'France', 23),


    -- Germany
    ('(^|\\.)((stadt|gemeinde|verbandsgemeinde|vg|amt|bezirksamt|kreisverwaltung|kreisstadt|rathaus)[-.].*\\.de)$', 'Germany', 20),
    ('(^|\\.)((landkreis|kreis|bezirk)[-.].*\\.de)$', 'Germany', 19),
    ('(^|\\.)((polizei|justiz|innenministerium|finanzministerium|wirtschaftsministerium|kultusministerium|sozialministerium|verkehrsministerium|verfassungsschutz|rechnungshof|gesundheitsministerium|wissenschaftsministerium|landwirtschaftsministerium)\\.?\\.?.*\\.de)$', 'Germany', 20),
    ('(^|\\.)((amtsgericht|landgericht|oberlandesgericht|sozialgericht|arbeitsgericht|finanzgericht|verwaltungsgericht|oberverwaltungsgericht|staatsanwaltschaft)[-.].*\\.de)$', 'Germany', 20),
    ('(^|\\.)((bundesamt|bundesanstalt)[-.].*\\.de)$', 'Germany', 21),
    ('(^|\\.)((finanzamt|zoll|arbeitsagentur|jobcenter|jugendamt)\\.?\\.?.*\\.de)$', 'Germany', 19),
    ('(^|\\.)(([a-z0-9-]+\\.)*diplo\\.de)$', 'Germany', 21),

    -- Greece
    ('(^|\\.)municipality\\.[a-z0-9-]+\\.gr$', 'Greece', 20),

    -- Guyana
    ('(^|\\.)[a-z0-9-]+\\.gov\\.gy$', 'Guyana', 20),

    -- India
    ('(^|\\.)((gov|nic)\\.in)$', 'India', 21),

    -- Indonesia
    ('(^|\\.)[a-z0-9-]+\\.go\\.id$', 'Indonesia', 20),

    -- Ireland
    ('(^|\\.)(([a-z0-9-]+coco\\.ie|[a-z0-9-]+council\\.ie))$', 'Ireland', 21),

    -- Italy
    ('(^|\\.)comune\\.[a-z0-9-]+\\.it$', 'Italy', 20),

    -- Japan
    ('(^|\\.)[a-z0-9-]+\\.lg\\.jp$', 'Japan', 21),

    -- Luxembourg
    ('(^|\\.)((public|gov|etat|data|service|security|mfi|lux)(\\.(public|gov|etat))?\\.lu)$', 'Luxembourg', 24),
    ('(^|\\.)(([a-z0-9-]+\\.)*gouvernement\\.lu)$', 'Luxembourg', 24),
    ('(^|\\.)(([a-z0-9-]+\\.)*public\\.lu)$', 'Luxembourg', 23),

    -- Malaysia
    ('(^|\\.)([a-z0-9-]+\\.){2,}gov\\.my$', 'Malaysia', 21),
    -- ('(^|\\.)[a-z0-9-]+\\.gov\\.my$', 'Malaysia', 22),

    -- Nepal
    ('(^|\\.)[a-z0-9-]+\\.(gov|mil)\\.np$', 'Nepal', 22),

    -- Netherlands
    ('(^|\\.)[a-z0-9-]+\\.overheid\\.nl$', 'Netherlands', 22),
    ('(^|\\.)[a-z0-9-]+\\.rijksoverheid\\.nl$', 'Netherlands', 22),
    ('(^|\\.)gemeente[a-z0-9-]*\\.nl$', 'Netherlands', 21),
    ('(^|\\.)provincie[a-z0-9-]*\\.nl$', 'Netherlands', 21),
    -- ('(^|\\.)[a-z0-9-]+\\.gov\\.nl$', 'Netherlands', 22),

    -- New Zealand
    ('(^|\\.)[a-z0-9-]+\\.parliament\\.nz$', 'New Zealand', 22),
    ('(^|\\.)[a-z0-9-]+\\.health\\.nz$', 'New Zealand', 22),
    -- ('(^|\\.)[a-z0-9-]+\\.govt\\.nz$', 'New Zealand', 22),
    -- ('(^|\\.)[a-z0-9-]+\\.mil\\.nz$', 'New Zealand', 22),

    -- Norway
    -- ('(^|\\.)[a-z0-9-]+\\.no$', 'Norway', 22),

    -- Peru
    ('(^|\\.)[a-z0-9-]+\\.region\\.gob\\.pe$', 'Peru', 21),
    ('(^|\\.)[a-z0-9-]+\\.muni\\.gob\\.pe$', 'Peru', 20),
    -- ('(^|\\.)[a-z0-9-]+\\.gob\\.pe$', 'Peru', 22),

    -- Poland
    ('(^|\\.)um\\.[a-z0-9-]+\\.pl$', 'Poland', 20),
    ('(^|\\.)ug\\.[a-z0-9-]+\\.pl$', 'Poland', 20),
    ('(^|\\.)powiat[a-z0-9-]*\\.pl$', 'Poland', 20),

    -- Philippines
    ('(^|\\.)[a-z0-9-]+\\.lgu\\.gov\\.ph$', 'Philippines', 21),
    -- ('(^|\\.)[a-z0-9-]+\\.gov\\.ph$', 'Philippines', 22),

    -- Portugal
    ('(^|\\.)muni\\.[a-z0-9-]+\\.pt$', 'Portugal', 21),
    ('(^|\\.)cm-[a-z0-9-]+\\.pt$', 'Portugal', 21),
    ('(^|\\.)[a-z0-9-]+\\.cm\\.pt$', 'Portugal', 21),
    -- ('(^|\\.)gov\\.pt$', 'Portugal', 22),

    -- Spain
    ('(^|\\.)((ayto|ayuntamiento|diputacion(?:de)?|cabildo|consell)[-.][a-z0-9-]+\\.es)$', 'Spain', 20),
    -- ('(^|\\.)[a-z0-9-]+\\.gob\\.es$', 'Spain', 22),

    -- Sweden
    ('(^|\\.)[a-z0-9-]+\\.kommun\\.se$', 'Sweden', 21),
    ('(^|\\.)[a-z0-9-]+\\.region\\.se$', 'Sweden', 21),
    -- ('(^|\\.)[a-z0-9-]+\\.gov\\.se$', 'Sweden', 22),

    -- Switzerland
    ('(^|\\.)[a-z0-9-]+\\.admin\\.ch$', 'Switzerland', 22),

    -- Taiwan
    ('(^|\\.)gov\\.taipei$', 'Taiwan', 22),
    -- ('(^|\\.)[a-z0-9-]+\\.gov\\.tw$', 'Taiwan', 22),
    
    -- Türkiye
    ('(^|\\.)[a-z0-9-]+\\.bel\\.tr$', 'Türkiye', 21),

    -- Ukraine
    ('(^|\\.)[a-z0-9-]+\\.rada\\.gov\\.ua$', 'Ukraine', 22),
    -- ('(^|\\.)[a-z0-9-]+\\.gov\\.ua$', 'Ukraine', 22),

    -- United Kingdom (UK)
    ('(^|\\.)[a-z0-9-]+\\.nhs\\.uk$', 'United Kingdom (UK)', 22),
    ('(^|\\.)[a-z0-9-]+\\.police\\.uk$', 'United Kingdom (UK)', 22),
    ('(^|\\.)[a-z0-9-]+\\.mod\\.uk$', 'United Kingdom (UK)', 22),
    ('(^|\\.)[a-z0-9-]+\\.parliament\\.uk$', 'United Kingdom (UK)', 23),
    ('(^|\\.)[a-z0-9-]+\\.judiciary\\.uk$', 'United Kingdom (UK)', 23),
    ('(^|\\.)supremecourt\\.uk$', 'United Kingdom (UK)', 23),
    ('(^|\\.)[a-z0-9-]+\\.gov\\.scot$', 'United Kingdom (UK)', 23),
    ('(^|\\.)[a-z0-9-]+\\.gov\\.wales$', 'United Kingdom (UK)', 23),
    ('(^|\\.)[a-z0-9-]+\\.llyw\\.cymru$', 'United Kingdom (UK)', 23),
    ('(^|\\.)[a-z0-9-]+\\.nhs\\.scot$', 'United Kingdom (UK)', 22),
    ('(^|\\.)police\\.scot$', 'United Kingdom (UK)', 22),
    -- ('(^|\\.)[a-z0-9-]+\\.gov\\.uk$', 'United Kingdom (UK)', 22),

    -- United States (USA)
    ('\\.gov$', 'United States (USA)', 22),
    ('\\.mil$', 'United States (USA)', 22),
    ('(^|\\.)(([a-z0-9-]+\\.)*fed\\.us)$', 'United States (USA)', 22),
    ('(^|\\.)(([a-z0-9-]+\\.)*nsn\\.us)$', 'United States (USA)', 22),
    ('(^|\\.)(([a-z0-9-]+\\.)*state\\.[a-z]{2}\\.us)$', 'United States (USA)', 21),
    ('(^|\\.)(([a-z0-9-]+\\.)*(ci|city|cityof|co|county|countyof|borough|parish|town|townof|village|muni|municipal)\\.[a-z]{2}\\.us)$', 'United States (USA)', 20),
    ('(^|\\.)(([a-z0-9-]+\\.)*courts\\.[a-z]{2}\\.us)$', 'United States (USA)', 20)

  ])
),

-- ISO ccTLD → country map used by generic gov heuristics
cc_map AS (
  SELECT * FROM UNNEST([
    -- A
    STRUCT('ac' AS tld, 'Ascension Island' AS bucket),
    ('ad','Andorra'), ('ae','United Arab Emirates'), ('af','Afghanistan'),
    ('ag','Antigua and Barbuda'), ('ai','Anguilla'), ('al','Albania'),
    ('am','Armenia'), ('ao','Angola'), ('ar','Argentina'), ('as','American Samoa'),
    ('at','Austria'), ('au','Australia'), ('aw','Aruba'), ('ax','Aland Islands'),
    ('az','Azerbaijan'),('aq','Antarctica'),

    -- B
    ('ba','Bosnia and Herzegovina'), ('bb','Barbados'), ('bd','Bangladesh'),
    ('be','Belgium'), ('bf','Burkina Faso'), ('bg','Bulgaria'), ('bh','Bahrain'),
    ('bi','Burundi'), ('bj','Benin'), ('bm','Bermuda'), ('bn','Brunei'),
    ('bo','Bolivia'), ('br','Brazil'), ('bs','Bahamas'), ('bt','Bhutan'),
    ('bv','Bouvet Island'), ('bw','Botswana'), ('by','Belarus'), ('bz','Belize'),

    -- C
    ('ca','Canada'), ('cc','Cocos (Keeling) Islands'), ('cd','Democratic Republic of the Congo'),
    ('cf','Central African Republic'), ('cg','Republic of the Congo'), ('ch','Switzerland'),
    ('ci',"Côte d'Ivoire"), ('ck','Cook Islands'), ('cl','Chile'), ('cm','Cameroon'),
    ('cn','China'), ('co','Colombia'), ('cr','Costa Rica'), ('cu','Cuba'),
    ('cv','Cabo Verde'), ('cw','Curacao'), ('cx','Christmas Island'),
    ('cy','Cyprus'), ('cz','Czech Republic'),('bq','Caribbean Netherlands'),

    -- D
    ('de','Germany'), ('dj','Djibouti'), ('dk','Denmark'), ('dm','Dominica'),
    ('do','Dominican Republic'), ('dz','Algeria'),

    -- E
    ('ec','Ecuador'), ('ee','Estonia'), ('eg','Egypt'), ('er','Eritrea'),
    ('es','Spain'), ('et','Ethiopia'), ('eu','European Union'),

    -- F
    ('fi','Finland'), ('fj','Fiji'), ('fk','Falkland Islands'),
    ('fm','Micronesia'), ('fo','Faroe Islands'), ('fr','France'),

    -- G
    ('ga','Gabon'), ('gb','United Kingdom (UK)'), ('gd','Grenada'),
    ('ge','Georgia'), ('gf','French Guiana'), ('gg','Guernsey'),
    ('gh','Ghana'), ('gi','Gibraltar'), ('gl','Greenland'), ('gm','Gambia'),
    ('gn','Guinea'), ('gp','Guadeloupe'), ('gq','Equatorial Guinea'),
    ('gr','Greece'), ('gs','South Georgia and the South Sandwich Islands'),
    ('gt','Guatemala'), ('gu','Guam'), ('gw','Guinea-Bissau'), ('gy','Guyana'),

    -- H
    ('hk','Hong Kong'), ('hm','Heard Island and McDonald Islands'),
    ('hn','Honduras'), ('hr','Croatia'), ('ht','Haiti'), ('hu','Hungary'),

    -- I
    ('id','Indonesia'), ('ie','Ireland'), ('il','Israel'), ('im','Isle of Man'),
    ('in','India'), ('io','British Indian Ocean Territory'), ('iq','Iraq'),
    ('ir','Iran'), ('is','Iceland'), ('it','Italy'),

    -- J
    ('je','Jersey'), ('jm','Jamaica'), ('jo','Jordan'), ('jp','Japan'),

    -- K
    ('ke','Kenya'), ('kg','Kyrgyzstan'), ('kh','Cambodia'), ('ki','Kiribati'),
    ('km','Comoros'), ('kn','Saint Kitts and Nevis'), ('xk','Kosovo'), ('kp','North Korea'),
    ('kr','South Korea'), ('kw','Kuwait'), ('ky','Cayman Islands'),
    ('kz','Kazakhstan'),

    -- L
    ('la','Laos'), ('lb','Lebanon'), ('lc','Saint Lucia'), ('li','Liechtenstein'),
    ('lk','Sri Lanka'), ('lr','Liberia'), ('ls','Lesotho'), ('lt','Lithuania'),
    ('lu','Luxembourg'), ('lv','Latvia'), ('ly','Libya'),

    -- M
    ('ma','Morocco'), ('mc','Monaco'), ('md','Moldova'), ('me','Montenegro'),
    ('mg','Madagascar'), ('mh','Marshall Islands'), ('mk','North Macedonia'),
    ('ml','Mali'), ('mm','Myanmar'), ('mn','Mongolia'), ('mo','Macau'),
    ('mp','Northern Mariana Islands'), ('mq','Martinique'), ('mr','Mauritania'),
    ('ms','Montserrat'), ('mt','Malta'), ('mu','Mauritius'), ('mv','Maldives'),
    ('mw','Malawi'), ('mx','Mexico'), ('my','Malaysia'), ('mz','Mozambique'),

    -- N
    ('na','Namibia'), ('nc','New Caledonia'), ('ne','Niger'),
    ('nf','Norfolk Island'), ('ng','Nigeria'), ('ni','Nicaragua'),
    ('nl','Netherlands'), ('no','Norway'), ('np','Nepal'), ('nr','Nauru'),
    ('nu','Niue'), ('nz','New Zealand'),

    -- O
    ('om','Oman'),

    -- P
    ('pa','Panama'), ('pe','Peru'), ('pf','French Polynesia'),
    ('pg','Papua New Guinea'), ('ph','Philippines'), ('pk','Pakistan'),
    ('pl','Poland'), ('pm','Saint Pierre and Miquelon'), ('pn','Pitcairn Islands'),
    ('pr','Puerto Rico'), ('ps','Palestine'), ('pt','Portugal'),
    ('pw','Palau'), ('py','Paraguay'),

    -- Q
    ('qa','Qatar'),

    -- R
    ('re','Reunion'), ('ro','Romania'), ('rs','Serbia'), ('ru','Russia'),
    ('rw','Rwanda'),

    -- S
    ('sa','Saudi Arabia'), ('sb','Solomon Islands'), ('sc','Seychelles'),
    ('sd','Sudan'), ('se','Sweden'), ('sg','Singapore'), ('sh','Saint Helena'),
    ('si','Slovenia'), ('sj','Svalbard and Jan Mayen'), ('sk','Slovakia'),
    ('sl','Sierra Leone'), ('sm','San Marino'), ('sn','Senegal'),
    ('so','Somalia'), ('sr','Suriname'), ('st','Sao Tome and Principe'),
    ('su','Soviet Union (legacy)'), ('sv','El Salvador'), ('sx','Sint Maarten'),
    ('sy','Syria'), ('sz','Eswatini'),('ss','South Sudan'),('bl','Saint Barthélemy'),
    ('mf','Saint Martin (French)'),

    -- T
    ('tc','Turks and Caicos Islands'), ('td','Chad'), ('tf','French Southern Territories'),
    ('tg','Togo'), ('th','Thailand'), ('tj','Tajikistan'), ('tk','Tokelau'),
    ('tl','East Timor'), ('tm','Turkmenistan'), ('tn','Tunisia'),
    ('to','Tonga'), ('tr','Türkiye'), ('tt','Trinidad and Tobago'),
    ('tv','Tuvalu'), ('tw','Taiwan'), ('tz','Tanzania'),

    -- U
    ('ua','Ukraine'), ('ug','Uganda'), ('uk','United Kingdom (UK)'),
    ('us','United States of America'), ('uy','Uruguay'), ('uz','Uzbekistan'),
    ('um','U.S. Outlying Islands'),

    -- V
    ('va','Vatican City'), ('vc','Saint Vincent and the Grenadines'),
    ('ve','Venezuela'), ('vg','British Virgin Islands'), ('vi','US Virgin Islands'),
    ('vn','Vietnam'), ('vu','Vanuatu'),

    -- W
    ('wf','Wallis and Futuna'), ('ws','Samoa'),('eh','Western Sahara'),

    -- Y
    ('ye','Yemen'), ('yt','Mayotte'),

    -- Z
    ('za','South Africa'), ('zm','Zambia'), ('zw','Zimbabwe'),

     -- GeoTLDs (non-ISO, regional or city)
    ('nyc','New York City'),
    ('berlin','Berlin'),
    ('paris','Paris'),
    ('london','London'),
    ('tokyo','Tokyo'),
    ('moscow','Moscow'),
    ('москва','Moscow (Cyrillic)'),
    ('quebec','Québec'),
    ('cymru','Wales (Cymraeg)'),
    ('wales','Wales'),
    ('scot','Scotland'),
    ('cat','Catalonia'),
    ('gal','Galicia'),
    ('bzh','Brittany'),
    ('barcelona','Barcelona'),
    ('madrid','Madrid'),
    ('rio','Rio de Janeiro'),
    ('istanbul','Istanbul'),
    ('ist','Istanbul (alt)'),
    ('africa','Africa (AU community)')

  ])
),

-- 3) Source pages + Lighthouse category scores (host extracted)
pages AS (
  SELECT
    client,
    page,
    is_root_page,
    LOWER(NET.HOST(page)) AS host,
    SAFE_CAST(JSON_VALUE(lighthouse, '$.categories.performance.score')       AS FLOAT64) AS perf,
    SAFE_CAST(JSON_VALUE(lighthouse, '$.categories.accessibility.score')     AS FLOAT64) AS a11y,
    SAFE_CAST(JSON_VALUE(lighthouse, '$.categories."best-practices".score')  AS FLOAT64) AS bp,
    SAFE_CAST(JSON_VALUE(lighthouse, '$.categories.seo.score')               AS FLOAT64) AS seo

-- ========================
-- Small Sample to Full DB - Start
-- ========================
  
  FROM
  `httparchive.sample_data.pages_10k` 
  -- `httparchive.crawl.pages`
  WHERE 
    -- date = DATE '2025-07-01' AND
    -- is_root_page AND

-- ========================
-- Small Sample to Full DB - End
-- ========================

    lighthouse IS NOT NULL AND
    JSON_TYPE(lighthouse) = 'object'
),
  
-- Filter out rows without any score to shrink downstream work
pages_scored AS (
  SELECT
    page,
    LOWER(NET.HOST(page)) AS host,
    ANY_VALUE(is_root_page) AS is_root_page,
    MAX(perf) AS perf,
    MAX(a11y) AS a11y,
    MAX(bp) AS bp,
    MAX(seo) AS seo
  FROM pages
  WHERE perf IS NOT NULL OR a11y IS NOT NULL OR bp IS NOT NULL OR seo IS NOT NULL
  GROUP BY page, host
),

-- 4) Exact ENDS_WITH matches against curated suffix list
match_suffix AS (
  SELECT p.*, r.bucket, r.priority, LENGTH(r.suffix) AS match_len
  FROM pages_scored p
  JOIN host_rules r
    ON REGEXP_CONTAINS(
         p.host,
         CONCAT(
           r'(^|\.)',
           REGEXP_REPLACE(r.suffix, r'([.^$|()\\[\]{}+*?-])', r'\\\1'),
           r'$'
         )
       )
),

-- 5) Regex family matches against patterned rules
match_regex AS (
  SELECT p.*, r.bucket, r.priority, 9999 AS match_len
  FROM pages_scored p              -- was: pages
  JOIN regex_rules r
    ON REGEXP_CONTAINS(p.host, r.pattern)
),

-- Heuristic fallback: gov-like host + ccTLD → country via cc_map
generic_ccgov AS (
  SELECT p.*, m.bucket, 21 AS priority, 9998 AS match_len
  FROM pages_scored p              -- was: pages
  JOIN cc_map m
    ON REGEXP_EXTRACT(
         p.host,
         r'^(?:[a-z0-9-]+\.)*(?:gov|gouv|gob|gub|go|govt|gv|nic|mil|govern)(?:\.(?:[a-z0-9-]+|xn--[a-z0-9-]+))*\.([a-z]{2,3})$'
       ) = m.tld
),

-- 6) Union all candidates and compute best match (priority, then length)
all_matches AS (
  SELECT * FROM match_suffix
  UNION ALL
  SELECT * FROM match_regex
  UNION ALL
  SELECT * FROM generic_ccgov
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY page
      ORDER BY priority DESC, match_len DESC
    ) AS rn
  FROM all_matches
),

-- UK: Look for dot-or-hyphen delimited province tokens inside *.uk hosts
uk_nation_from_domain AS (
  SELECT
    p.page, p.host,
    CASE
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)[a-z0-9-]+\.gov\.scot$')  THEN 'Scotland'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)[a-z0-9-]+\.nhs\.scot$')  THEN 'Scotland'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)parliament\.scot$')       THEN 'Scotland'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)police\.scot$')           THEN 'Scotland'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)[a-z0-9-]+\.gov\.wales$') THEN 'Wales'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)[a-z0-9-]+\.llyw\.cymru$') THEN 'Wales'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)[a-z0-9-]+\.nhs\.wales$') THEN 'Wales'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)senedd\.(wales|cymru)$')  THEN 'Wales'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)nidirect\.gov\.uk$')      THEN 'Northern Ireland'
      ELSE NULL
    END AS uk_nation
  FROM pages_scored p
),

-- Australia: Look for dot-or-hyphen delimited province tokens inside *.au hosts
au_state_map AS (
  SELECT * FROM UNNEST([
    STRUCT('nsw' AS code, 'New South Wales' AS state),
    ('vic','Victoria'), ('qld','Queensland'), ('sa','South Australia'),
    ('wa','Western Australia'), ('tas','Tasmania'),
    ('act','Australian Capital Territory'), ('nt','Northern Territory')
  ])
),
au_state_from_gov_au AS (
  SELECT
    p.page, p.host,
    m.state AS au_state
  FROM pages_scored p
  JOIN au_state_map m
    ON LOWER(REGEXP_EXTRACT(p.host, r'(?i)(?:^|\.)(nsw|vic|qld|sa|wa|tas|act|nt)\.gov\.au$')) = m.code
),

-- Brazil: Look for dot-or-hyphen delimited province tokens inside *.br hosts
br_state_map AS (
  SELECT * FROM UNNEST([
    STRUCT('ac' AS code, 'Acre' AS state),
    ('al','Alagoas'), ('ap','Amapá'), ('am','Amazonas'), ('ba','Bahia'),
    ('ce','Ceará'), ('df','Distrito Federal'), ('es','Espírito Santo'),
    ('go','Goiás'), ('ma','Maranhão'), ('mt','Mato Grosso'),
    ('ms','Mato Grosso do Sul'), ('mg','Minas Gerais'), ('pa','Pará'),
    ('pb','Paraíba'), ('pr','Paraná'), ('pe','Pernambuco'),
    ('pi','Piauí'), ('rj','Rio de Janeiro'), ('rn','Rio Grande do Norte'),
    ('rs','Rio Grande do Sul'), ('ro','Rondônia'), ('rr','Roraima'),
    ('sc','Santa Catarina'), ('sp','São Paulo'), ('se','Sergipe'), ('to','Tocantins')
  ])
),
br_state_from_gov_br AS (
  SELECT
    p.page, p.host,
    m.state AS br_state
  FROM pages_scored p
  JOIN br_state_map m
    ON LOWER(REGEXP_EXTRACT(
         p.host,
         '(?i)(?:^|\\.)(ac|al|ap|am|ba|ce|df|es|go|ma|mt|ms|mg|pa|pb|pr|pe|pi|rj|rn|rs|ro|rr|sc|sp|se|to)\\.gov\\.br$'
       )) = m.code
),

-- Spain: Look for dot-or-hyphen delimited province tokens inside *.es hosts
es_region_from_known AS (
  SELECT p.page, p.host,
    CASE
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)gencat\.cat$')         THEN 'Catalonia'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)euskadi\.eus$')        THEN 'Basque Country'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)xunta\.gal$')          THEN 'Galicia'
      WHEN REGEXP_CONTAINS(p.host, r'(?i)(^|\.)comunidad\.madrid$')   THEN 'Community of Madrid'
      ELSE NULL
    END AS es_region
  FROM pages_scored p
),

-- Canadian: province code lookup (code → province name)
ca_prov_map AS (
  SELECT * FROM UNNEST([
    STRUCT('ab' AS code, 'Alberta' AS province),
    ('bc','British Columbia'), ('mb','Manitoba'), ('nb','New Brunswick'),
    ('nl','Newfoundland and Labrador'), ('ns','Nova Scotia'),
    ('nt','Northwest Territories'), ('nu','Nunavut'), ('on','Ontario'),
    ('pe','Prince Edward Island'), ('qc','Quebec'), ('sk','Saskatchewan'),
    ('yt','Yukon'), ('yk','Yukon')  -- accept either token
  ])
),
ca_prov_from_gc AS (
  SELECT
    p.page, p.host,
    LOWER(
      REGEXP_EXTRACT(
        p.host,
        r'(?i)(?:^|[.-])(ab|bc|mb|nb|nl|ns|nt|nu|on|pe|qc|sk|yt|yk)(?:[.-])'
      )
    ) AS prov_code
  FROM pages_scored p
  WHERE ENDS_WITH(p.host, '.gc.ca')
),

-- Canadian domain overrides for branded/legacy provincial portals
ca_province_classified AS (
  SELECT
    g.page, g.host,
    m.province AS ca_province
  FROM ca_prov_from_gc g
  LEFT JOIN ca_prov_map m
    ON g.prov_code = m.code
),

-- US state code lookup (code → state name)
us_code_map AS (
  SELECT * FROM UNNEST([
    STRUCT('al' AS code, 'Alabama' AS state),
    ('ak','Alaska'),('az','Arizona'),('ar','Arkansas'),
    ('ca','California'),('co','Colorado'),('ct','Connecticut'),('de','Delaware'),
    ('fl','Florida'),('ga','Georgia'),('hi','Hawaii'),('id','Idaho'),
    ('il','Illinois'), ('in','Indiana'), ('ia','Iowa'), ('ks','Kansas'),
    ('ky','Kentucky'), ('la','Louisiana'), ('me','Maine'), ('md','Maryland'),
    ('ma','Massachusetts'), ('mi','Michigan'), ('mn','Minnesota'), ('ms','Mississippi'),
    ('mo','Missouri'), ('mt','Montana'), ('ne','Nebraska'), ('nv','Nevada'),
    ('nh','New Hampshire'), ('nj','New Jersey'), ('nm','New Mexico'), ('ny','New York'),
    ('nc','North Carolina'), ('nd','North Dakota'), ('oh','Ohio'), ('ok','Oklahoma'),
    ('or','Oregon'), ('pa','Pennsylvania'), ('ri','Rhode Island'), ('sc','South Carolina'),
    ('sd','South Dakota'), ('tn','Tennessee'), ('tx','Texas'), ('ut','Utah'),
    ('vt','Vermont'), ('va','Virginia'), ('wa','Washington'), ('wv','West Virginia'),
    ('wi','Wisconsin'), ('wy','Wyoming'),
    ('dc','DC'), ('pr','Puerto Rico'), ('gu','Guam'), ('as','American Samoa'), ('vi','US Virgin Islands')
  ])
),

-- US domain overrides for branded/legacy state portals
us_state_overrides AS (
  SELECT * FROM UNNEST([
    STRUCT('Florida' AS state, r'(?:^|\\.)myflorida\\.com$' AS host_pattern),
    ('Massachusetts', r'(?:^|\\.)mass(?:achusetts)?\\.gov$'),
    ('Oregon', r'(?:^|\\.)oregon\\.gov$'),
    ('Nebraska', r'(?:^|\\.)nebraska\\.gov$'),
    ('Hawaii', r'(?:^|\\.)ehawaii\\.gov$'),
    ('California', r'(?:^|\\.)state\\.ca\\.us$'),
    ('New Mexico', r'(?:^|\\.)state\\.nm\\.us$'),
    ('Washington', r'(?:^|\\.)access\\.wa\\.gov$'),
    ('Virginia', r'(?:^|\\.)virginia\\.gov$')
  ])
),

-- US federal exceptions that must *not* be treated as states (e.g., va.gov)
us_federal_exceptions AS (
  SELECT * FROM UNNEST([
    -- add more as you find conflicts
    STRUCT(r'(?:^|\.)va\.gov$' AS host_pattern, 'US Department of Veterans Affairs' AS org)
  ])
),

-- Extract potential state code hits from host (xx.gov or *.xx.us)
code_hit AS (
  SELECT p.page, p.host,
         CASE
           WHEN EXISTS (
             SELECT 1 FROM us_federal_exceptions f
             WHERE REGEXP_CONTAINS(p.host, f.host_pattern)
           ) THEN NULL
           ELSE LOWER(COALESCE(
             REGEXP_EXTRACT(p.host, r'(?:^|\.)([a-z]{2})\.gov$'),
             REGEXP_EXTRACT(p.host, r'\.([a-z]{2})\.us$')
           ))
         END AS code2
  FROM pages_scored p
),

-- Pick a U.S. state for each host (overrides first, else code mapping)
us_state_classified AS (
  SELECT p.page, p.host,
         COALESCE(
           (SELECT o.state
            FROM us_state_overrides o
            WHERE REGEXP_CONTAINS(p.host, o.host_pattern)
            LIMIT 1),
           (SELECT um.state
            FROM us_code_map AS um
            WHERE LOWER(ch.code2) = um.code
            LIMIT 1)
         ) AS us_state
  FROM pages_scored p
  LEFT JOIN code_hit ch USING (page, host)
),

-- Final winner for each page (rn = 1)
final_best AS (
  SELECT * FROM ranked WHERE rn = 1
),

-- ========================
-- SQL below is unique for lighthouse_score_by_government_with_urls.sql
-- ========================

-- Assemble report columns and friendly names
domain_scores AS (
  SELECT
    host AS gov_domain,
    host,                     -- keep raw host for joins
    page,
    is_root_page,
    perf AS performance_score,
    a11y AS accessibility_score,
    bp   AS best_practices_score,
    seo  AS seo_score,
    bucket
  FROM final_best
)

-- Final SELECT
SELECT DISTINCT
  ds.bucket AS country,
  COALESCE(
    uk.uk_nation,
    cpc.ca_province,
    usc.us_state,
    au.au_state,
    br.br_state,
    es.es_region
  ) AS subnational,
  ds.gov_domain,
  ds.page,
  ds.is_root_page,
  ds.performance_score,
  ds.accessibility_score,
  ds.best_practices_score,
  ds.seo_score
FROM domain_scores ds
LEFT JOIN uk_nation_from_domain   uk ON uk.page = ds.page AND uk.host = ds.host
LEFT JOIN ca_province_classified  cpc ON cpc.page = ds.page AND cpc.host = ds.host
LEFT JOIN us_state_classified     usc ON usc.page = ds.page AND usc.host = ds.host
LEFT JOIN au_state_from_gov_au    au  ON au.page  = ds.page AND au.host  = ds.host
LEFT JOIN br_state_from_gov_br    br  ON br.page  = ds.page AND br.host  = ds.host
LEFT JOIN es_region_from_known    es  ON es.page  = ds.page AND es.host  = ds.host
ORDER BY country, subnational, gov_domain, page;
