-- standardSQL
-- Government buckets via suffix + regex rules (ROOT pages only)
-- - Inline lists (no write access needed)
-- - Best-match selection by priority, then longest suffix
-- - Percent outputs

WITH
-- 1) Explicit suffix rules (highest specificity first by priority)
host_rules AS (
  SELECT * FROM UNNEST([
    -- United Nations & EU
    STRUCT('un.org' AS suffix, 'United Nations' AS bucket, 10 AS priority),
    ('worldbank.org','United Nations',10),
    ('undp.org','United Nations',10),
    ('reliefweb.int','United Nations',10),
    ('who.int','United Nations',10),
    ('unfccc.int','United Nations',10),
    ('unccd.int','United Nations',10),
    ('unesco.org','United Nations',10),
    ('europa.eu','European Union',12),
    ('eib.org','European Union',24),
    ('eif.org','European Union',24),

-- Many country domains are sourced from - https://www.govdirectory.org/countries/

-- Austria – federal anchors & portals
('oesterreich.gv.at','Austria',24),('bka.gv.at','Austria',24),('parlament.gv.at','Austria',24),('help.gv.at','Austria',24),('usp.gv.at','Austria',24),('data.gv.at','Austria',24),('ris.bka.gv.at','Austria',24),('gesundheit.gv.at','Austria',24),
-- Austria – ministries
('bmi.gv.at','Austria',24),('bmf.gv.at','Austria',24),('bmj.gv.at','Austria',24),('bmeia.gv.at','Austria',24),('bmk.gv.at','Austria',24),('bml.gv.at','Austria',24),('bmlrt.gv.at','Austria',24),('bmaw.gv.at','Austria',24),('bmbwf.gv.at','Austria',24),('bmkoes.gv.at','Austria',24),('bmsgpk.gv.at','Austria',24), ('polizei.gv.at','Austria',24),

-- Austria – top authorities & agencies
('rechnungshof.gv.at','Austria',24),('vfgh.gv.at','Austria',24),('vwgh.gv.at','Austria',24),('bundesverwaltungsgericht.gv.at','Austria',24),('bundesfinanzgericht.gv.at','Austria',24),('justiz.gv.at','Austria',24),('bundesheer.at','Austria',24),('fma.gv.at','Austria',24),('rtr.at','Austria',24),('statistik.at','Austria',24),('ams.at','Austria',24),
-- Austria – Länder
('wien.gv.at','Austria',23),('noe.gv.at','Austria',23),('ooe.gv.at','Austria',23),('salzburg.gv.at','Austria',23),('tirol.gv.at','Austria',23),('ktn.gv.at','Austria',23),('kaernten.at','Austria',23),('stmk.gv.at','Austria',23),('steiermark.at','Austria',23),('bgld.gv.at','Austria',23),('burgenland.at','Austria',23),('vbg.gv.at','Austria',23),('vorarlberg.at','Austria',23),


-- Belgium – federal portals & institutions
('belgium.be','Belgium',24),('fgov.be','Belgium',24),('vlaanderen.be','Belgium',24),('wallonie.be','Belgium',24),('brussels.be','Belgium',24),('mil.be','Belgium',24),
-- Belgium – ministries & federal services
('just.fgov.be','Belgium',23),('justice.belgium.be','Belgium',23),('mobilit.fgov.be','Belgium',23),('finance.belgium.be','Belgium',23),('health.belgium.be','Belgium',23),('socialsecurity.belgium.be','Belgium',23),('employment.belgium.be','Belgium',23),('bosa.belgium.be','Belgium',23),('ibz.fgov.be','Belgium',23),('diplomatie.belgium.be','Belgium',23),

-- Belgium – regional anchors
('vlaanderen.be','Belgium',23),('wallonie.be','Belgium',23),('bruxelles.be','Belgium',23),('irisnet.be','Belgium',23),('parlement-wallonie.be','Belgium',23),('vlaamsparlement.be','Belgium',23),
-- Belgium – provinces
('antwerpen.be','Belgium',22),('oost-vlaanderen.be','Belgium',22),('west-vlaanderen.be','Belgium',22),('limburg.be','Belgium',22),('vlaams-brabant.be','Belgium',22),('waals-brabant.be','Belgium',22),('hainaut.be','Belgium',22),('liege.be','Belgium',22),('luxembourg.be','Belgium',22),('namur.be','Belgium',22),
-- Belgium – municipalities (sampled major ones, can be expanded)
('gent.be','Belgium',21),('brugge.be','Belgium',21),('leuven.be','Belgium',21),('mechelen.be','Belgium',21),('kortrijk.be','Belgium',21),('hasselt.be','Belgium',21),('antwerpen.be','Belgium',21),('brussel.be','Belgium',21),('charleroi.be','Belgium',21),('mons.be','Belgium',21),('namur.be','Belgium',21),('liege.be','Belgium',21),('louvain-la-neuve.be','Belgium',21),

-- Bermuda – federal anchors
('gov.bm','Bermuda',24), ('parliament.bm','Bermuda',24), ('oba.bm','Bermuda',24),
-- Bermuda – ministries & departments
('moh.gov.bm','Bermuda',23), ('moed.gov.bm','Bermuda',23), ('mohamed.gov.bm','Bermuda',23), ('mof.gov.bm','Bermuda',23), ('mps.gov.bm','Bermuda',23), ('mha.gov.bm','Bermuda',23), ('mpt.gov.bm','Bermuda',23), ('med.gov.bm','Bermuda',23), ('mhr.gov.bm','Bermuda',23),

-- Cameroon – federal / national
('presidenceducameroun.cm','Cameroon',24),('primecm.cm','Cameroon',24),('minfi.cm','Cameroon',24),
-- Cameroon – municipalities
('douala.cm','Cameroon',23),('yaounde.cm','Cameroon',23),('bamenda.cm','Cameroon',23),

-- Canada – federal anchors & key institutions
('canada.ca','Canada',24),('gc.ca','Canada',24),('parl.ca','Canada',24),('ourcommons.ca','Canada',24),('sencanada.ca','Canada',24),('lop.parl.ca','Canada',24),('scc-csc.ca','Canada',24),('canadapost-postescanada.ca','Canada',24),
-- Canada – provinces & territories (roots + legislatures)
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

-- Chile – federal & ministry anchors
('gob.cl','Chile',24), ('chileabroad.gov.cl','Chile',24), ('chileatiende.gob.cl','Chile',24),
-- Chile – judiciary & parliament
('pjud.cl','Chile',24), ('tribunalconstitucional.cl','Chile',24), ('senado.cl','Chile',24), ('diputados.cl','Chile',24),
-- Chile – municipalities (sample, can expand if needed)
('muni.cl','Chile',23), ('muniweb.cl','Chile',23),

-- Cuba – provinces (sampled from GovDirectory list)
('camaguey.cu','Cuba',22),('granma.inf.cu','Cuba',22),('guantanamo.gob.cu','Cuba',22),
('holguin.gob.cu','Cuba',22),('islagrande.cu','Cuba',22),('laprensa.cu','Cuba',22),
('mayabeque.cu','Cuba',22),('pinar.cu','Cuba',22),('santiago.cu','Cuba',22),
('sanctispiritus.cu','Cuba',22),('villa-clara.cu','Cuba',22),

-- Czech Republic – federal anchors & portals
('vlada.cz','Czech Republic',24),('psp.cz','Czech Republic',24),('senat.cz','Czech Republic',24),
('justice.cz','Czech Republic',24),('mzv.cz','Czech Republic',24),('mzcr.cz','Czech Republic',24),
('mdcr.cz','Czech Republic',24),('mmr.cz','Czech Republic',24),('msmt.cz','Czech Republic',24),
('mpsv.cz','Czech Republic',24),('mvcr.cz','Czech Republic',24),('mfcr.cz','Czech Republic',24),
('mze.cz','Czech Republic',24),('mzp.cz','Czech Republic',24),('msp.cz','Czech Republic',24),
('csu.cz','Czech Republic',24),('uzis.cz','Czech Republic',24),('ero.cz','Czech Republic',24),
('uradprace.cz','Czech Republic',24),('cnb.cz','Czech Republic',24),('uoou.cz','Czech Republic',24),
-- Czech Republic – regional authorities (kraje)
('jihomoravsky.cz','Czech Republic',23),('jihocesky.cz','Czech Republic',23),
('kraj-vysocina.cz','Czech Republic',23),('kraj-lbc.cz','Czech Republic',23),
('khk.cz','Czech Republic',23),('olomouc.cz','Czech Republic',23),
('pardubickykraj.cz','Czech Republic',23),('plzensky-kraj.cz','Czech Republic',23),
('moravskoslezsky.cz','Czech Republic',23),('stredocesky.cz','Czech Republic',23),
('usk.cz','Czech Republic',23),('zlinsky.cz','Czech Republic',23),
-- Czech Republic – municipalities (sample major ones)
('praha.eu','Czech Republic',22),('brno.cz','Czech Republic',22),('ostrava.cz','Czech Republic',22),
('plzen.eu','Czech Republic',22),('liberec.cz','Czech Republic',22),('olomouc.eu','Czech Republic',22),
('hradec.cz','Czech Republic',22),('pardubice.eu','Czech Republic',22),('usti.cz','Czech Republic',22),

-- Denmark – federal anchors & portals
('ft.dk','Denmark',24),('stm.dk','Denmark',24),('regeringen.dk','Denmark',24),('folketinget.dk','Denmark',24),('borger.dk','Denmark',24),('politi.dk','Denmark',24),('skat.dk','Denmark',24),('retsinformation.dk','Denmark',24),('sundhed.dk','Denmark',24),('virk.dk','Denmark',24),
-- Denmark – ministries (current & stable hostnames)
('fm.dk','Denmark',24),('um.dk','Denmark',24),('jm.dk','Denmark',24),('fmn.dk','Denmark',24),('kefm.dk','Denmark',24),('sum.dk','Denmark',24),('kum.dk','Denmark',24),('ufm.dk','Denmark',24),('uvm.dk','Denmark',24),('bm.dk','Denmark',24),('skm.dk','Denmark',24),('em.dk','Denmark',24),('trm.dk','Denmark',24),('fvm.dk','Denmark',24),('uim.dk','Denmark',24),('sm.dk','Denmark',24),('digst.dk','Denmark',24),('km.dk','Denmark',24),('mssb.dk','Denmark',24),('urm.dk','Denmark',24),
-- Denmark – key agencies & authorities
('norden.dk','Denmark',23),('miljoeogfoedevarer.dk','Denmark',23),('arbejdstilsynet.dk','Denmark',23),('forsvaret.dk','Denmark',23),('dr.dk','Denmark',23),('dst.dk','Denmark',23),('sikkerdigital.dk','Denmark',23),('nemlog-in.dk','Denmark',23),('mitid.dk','Denmark',23),('nemkonto.dk','Denmark',23),('stps.dk','Denmark',23),('dataetiskraad.dk','Denmark',23),('at.dk','Denmark',23),
-- Denmark – regions (explicit)
('regionh.dk','Denmark',23),('rsyd.dk','Denmark',23),('rm.dk','Denmark',23),('rn.dk','Denmark',23),('regionsjaelland.dk','Denmark',23),
-- Denmark – municipalities (large / representative set)
('kk.dk','Denmark',22),('aarhus.dk','Denmark',22),('odense.dk','Denmark',22),('aalborg.dk','Denmark',22),('esbjerg.dk','Denmark',22),('randers.dk','Denmark',22),('kolding.dk','Denmark',22),('vejle.dk','Denmark',22),('horsens.dk','Denmark',22),('roskilde.dk','Denmark',22),('herning.dk','Denmark',22),('silkeborg.dk','Denmark',22),('naestved.dk','Denmark',22),('gladsaxe.dk','Denmark',22),('gentofte.dk','Denmark',22),('frederiksberg.dk','Denmark',22),('holbaek.dk','Denmark',22),('hjoerring.dk','Denmark',22),('koege.dk','Denmark',22),('varde.dk','Denmark',22),('viborg.dk','Denmark',22),('svendborg.dk','Denmark',22),('sonderborg.dk','Denmark',22),('ballerup.dk','Denmark',22),('rodovre.dk','Denmark',22),('helsingor.dk','Denmark',22),('albertslund.dk','Denmark',22),('egedal.dk','Denmark',22),('faaborgmidtfyn.dk','Denmark',22),('aabenraa.dk','Denmark',22),('fredericia.dk','Denmark',22),('skanderborg.dk','Denmark',22),('slagelse.dk','Denmark',22),('holstebro.dk','Denmark',22),
  
-- East Timor – federal anchors & portals
('gov.tl','East Timor',24),('timor-leste.gov.tl','East Timor',24),('parlamento.tl','East Timor',24),('mj.gov.tl','East Timor',24),
-- East Timor – ministries
('mire.gov.tl','East Timor',23),('mnec.gov.tl','East Timor',23),('me.tl','East Timor',23),('mss.gov.tl','East Timor',23),
('mejd.gov.tl','East Timor',23),('mj.gov.tl','East Timor',23),('mf.gov.tl','East Timor',23),('mdn.gov.tl','East Timor',23),
('misa.gov.tl','East Timor',23),('mtci.gov.tl','East Timor',23),('mjdac.gov.tl','East Timor',23),('mnec.tl','East Timor',23),
-- East Timor – judiciary & independent bodies
('tribunais.tl','East Timor',23),('procuradoria.tl','East Timor',23),('cne.tl','East Timor',23),('bancocentral.tl','East Timor',23),

-- Finland – federal anchors & portals
('valtioneuvosto.fi','Finland',24),('presidentti.fi','Finland',24),('eduskunta.fi','Finland',24),('oikeus.fi','Finland',24),('suomi.fi','Finland',24),
-- Finland – ministries
('formin.fi','Finland',23),('intermin.fi','Finland',23),('vm.fi','Finland',23),('stm.fi','Finland',23),('okm.fi','Finland',23),
('mmm.fi','Finland',23),('lvm.fi','Finland',23),('ym.fi','Finland',23),('tem.fi','Finland',23),('defmin.fi','Finland',23),
('um.fi','Finland',23),('oikeusministerio.fi','Finland',23),('minedu.fi','Finland',23),('bmbwf.fi','Finland',23), -- if present
-- Finland – agencies & authorities
('vero.fi','Finland',22),('kela.fi','Finland',22),('poliisi.fi','Finland',22),('tulli.fi','Finland',22),('traficom.fi','Finland',22),
('migri.fi','Finland',22),('fimea.fi','Finland',22),('stat.fi','Finland',22),('thl.fi','Finland',22),('metsakeskus.fi','Finland',22),
('businessfinland.fi','Finland',22),('oph.fi','Finland',22),('avi.fi','Finland',22),('syke.fi','Finland',22),

-- Germany – federal anchors & key institutions
('bund.de','Germany',24),('bundesregierung.de','Germany',24),('bundesrat.de','Germany',24),('bundestag.de','Germany',24), ('bundesverfassungsgericht.de','Germany',24),('bundesgerichtshof.de','Germany',24),('bundesverwaltungsgericht.de','Germany',24), ('bundesfinanzhof.de','Germany',24),('bundessozialgericht.de','Germany',24),('bundesarbeitsgericht.de','Germany',24), ('bundesnetzagentur.de','Germany',24),('bundespolizei.de','Germany',24),('polizei.de','Germany',24),('bmi.bund.de','Germany',24), ('auswaertiges-amt.de','Germany',24),('bmf.bund.de','Germany',24),('bmj.de','Germany',24),('bmwi.de','Germany',24), ('bmbf.de','Germany',24),('bmvg.de','Germany',24),('bmas.de','Germany',24),('bmfsfj.de','Germany',24),('bmel.de','Germany',24), ('bmuv.de','Germany',24),('bverwg.de','Germany',24),('bundeskartellamt.de','Germany',24),('bundesbank.de','Germany',24), ('destatis.de','Germany',24),('rki.de','Germany',24),('pei.de','Germany',24),
-- Germany – important federal portals & agencies
('bafin.de','Germany',24),('bka.de','Germany',24),('bka.bund.de','Germany',24),('bnd.bund.de','Germany',24),('zoll.de','Germany',24), ('bamf.de','Germany',24),('arbeitsagentur.de','Germany',24),('bundeswehr.de','Germany',24),('bsi.bund.de','Germany',24), ('uba.de','Germany',24),('bfarm.de','Germany',24),('bfr.bund.de','Germany',24),('dwd.de','Germany',24),('kba.de','Germany',24), ('bundesanzeiger.de','Germany',24),('gesetze-im-internet.de','Germany',24),('verwaltung.bund.de','Germany',24),('service.bund.de','Germany',24), ('govdata.de','Germany',24),('deutschland.de','Germany',23),('make-it-in-germany.com','Germany',23),
-- Germany – Länder (state portals)
('bayern.de','Germany',23),('berlin.de','Germany',23),('brandenburg.de','Germany',23),('bremen.de','Germany',23),('hamburg.de','Germany',23), ('hessen.de','Germany',23),('mecklenburg-vorpommern.de','Germany',23),('niedersachsen.de','Germany',23),('nrw.de','Germany',23), ('land.nrw','Germany',24),('rlp.de','Germany',23),('saarland.de','Germany',23),('sachsen.de','Germany',23), ('sachsen-anhalt.de','Germany',23),('schleswig-holstein.de','Germany',23),('thueringen.de','Germany',23),
-- Germany – Länder parliaments (selected)
('landtag.nrw.de','Germany',23),('landtag-bw.de','Germany',23),('landtag.bayern.de','Germany',23), ('landtag.sachsen.de','Germany',23),('landtag.sachsen-anhalt.de','Germany',23),('landtag.brandenburg.de','Germany',23), ('landtag.rlp.de','Germany',23),('landtag-bb.de','Germany',23),
-- Germany – embassies (examples)
('nigeria.diplo.de','Germany',21),('tuerkei.diplo.de','Germany',21),('harare.diplo.de','Germany',21), ('tallinn.diplo.de','Germany',21),('brasil.diplo.de','Germany',21),
  
-- Ghana – federal anchors & portals
('ghana.gov.gh','Ghana',24),('gov.gh','Ghana',24),('parliament.gh','Ghana',24),
-- Ghana – ministries
('mfa.gov.gh','Ghana',23),('moh.gov.gh','Ghana',23),('moe.gov.gh','Ghana',23),('moc.gov.gh','Ghana',23),
('mot.gov.gh','Ghana',23),('mojagd.gov.gh','Ghana',23),('moi.gov.gh','Ghana',23),('mofep.gov.gh','Ghana',23),
('moe.gov.gh','Ghana',23),('moe.gov.gh','Ghana',23),('moes.gov.gh','Ghana',23),('moj.gov.gh','Ghana',23),
('motac.gov.gh','Ghana',23),('moes.gov.gh','Ghana',23),('moesr.gov.gh','Ghana',23),('moesd.gov.gh','Ghana',23),
-- Ghana – key agencies & authorities
('bankofghana.org','Ghana',22),('gipc.gov.gh','Ghana',22),('ges.gov.gh','Ghana',22),('nss.gov.gh','Ghana',22),
('passport.mfa.gov.gh','Ghana',22),('gsa.gov.gh','Ghana',22),('nda.gov.gh','Ghana',22),('ndpc.gov.gh','Ghana',22),
('pensions.gov.gh','Ghana',22),('gepa.gov.gh','Ghana',22),('gipc.gov.gh','Ghana',22),('fda.gov.gh','Ghana',22),
-- Ghana – municipalities (sampled)
('accra.gov.gh','Ghana',21),('kumasi.gov.gh','Ghana',21),('tamale.gov.gh','Ghana',21),('takoradi.gov.gh','Ghana',21),

-- Greenland – federal anchors & institutions
('gov.gl','Greenland',24),('naalakkersuisut.gl','Greenland',24),('stat.gl','Greenland',24),('inatsisartut.gl','Greenland',24),('politi.gl','Greenland',24),
-- Greenland – agencies, portals & services
('sullissivik.gl','Greenland',24),('telepost.gl','Greenland',24),('visitgreenland.gl','Greenland',24),('arcticcommand.gl','Greenland',24),('royalgroenland.gl','Greenland',24),('greenlandinstitute.gl','Greenland',24),('oqaasileriffik.gl','Greenland',24),('iluarsartuiffik.gl','Greenland',24),('energitjenesten.gl','Greenland',24),
-- Greenland – municipalities & local
('kujalleq.gl','Greenland',23),('sermersooq.gl','Greenland',23),('sisimiut.gl','Greenland',23),('kalaallitnunaata.gl','Greenland',23),('nusuka.gl','Greenland',23),('aviisi.gl','Greenland',23),('anjuma.gl','Greenland',23),('kni.gl','Greenland',23),('mhs.gl','Greenland',23),('gux.gl','Greenland',23),('univiseyisarti.gl','Greenland',23),

-- Iceland – federal anchors & institutions
('stjornarradid.is','Iceland',24),('althingi.is','Iceland',24),('lögreglan.is','Iceland',24),('domstolar.is','Iceland',24),('forseti.is','Iceland',24),
-- Iceland – ministries
('utanrikisraduneyti.is','Iceland',24),('forsaetisraduneyti.is','Iceland',24),('fjarmalaraduneyti.is','Iceland',24),('samgongustofa.is','Iceland',24),('menntamalaraduneyti.is','Iceland',24),('heilbrigdisraduneyti.is','Iceland',24),('innviðaráðuneytið.is','Iceland',24),('dómsmálaráðuneytið.is','Iceland',24),(' atvinnuvegaraduneyti.is','Iceland',24),('umhverfisraduneyti.is','Iceland',24),
-- Iceland – agencies & services
('skatturinn.is','Iceland',23),('vinnueftirlit.is','Iceland',23),('hagstofa.is','Iceland',23),('utl.is','Iceland',23),('landlaeknir.is','Iceland',23),('island.is','Iceland',23),('vinnumalastofnun.is','Iceland',23),('mannvirkjastofnun.is','Iceland',23),('vefur.is','Iceland',23),('vegagerdin.is','Iceland',23),

-- India – federal anchors & institutions
('india.gov.in','India',24),('gov.in','India',24),('nic.in','India',24),('mea.gov.in','India',24),('mha.gov.in','India',24),('mohfw.gov.in','India',24),('mof.gov.in','India',24),('pmindia.gov.in','India',24),('presidentofindia.nic.in','India',24),('vicepresidentofindia.nic.in','India',24),('cabsec.gov.in','India',24),('parliamentofindia.nic.in','India',24),
-- India – judiciary
('supremecourtofindia.nic.in','India',24),('indiacode.nic.in','India',24),('nalsa.gov.in','India',24),('lawcommissionofindia.nic.in','India',24),
-- India – ministries (sample of stable top-level hosts)
('agriculture.gov.in','India',23),('rural.nic.in','India',23),('labour.gov.in','India',23),('education.gov.in','India',23),('defence.gov.in','India',23),('commerce.gov.in','India',23),('msme.gov.in','India',23),('morth.nic.in','India',23),('petroleum.nic.in','India',23),('power.gov.in','India',23),('coal.nic.in','India',23),('culture.gov.in','India',23),('tourism.gov.in','India',23),('tribal.nic.in','India',23),('socialjustice.nic.in','India',23),('minorityaffairs.gov.in','India',23),
-- India – state portals (roots, can expand if needed)
('maharashtra.gov.in','India',22),('gujarat.gov.in','India',22),('rajasthan.gov.in','India',22),('up.gov.in','India',22),('kerala.gov.in','India',22),('tamilnadu.gov.in','India',22),('telangana.gov.in','India',22),('karnataka.gov.in','India',22),('westbengal.gov.in','India',22),('punjab.gov.in','India',22),('bihar.gov.in','India',22),('jharkhand.gov.in','India',22),('odisha.gov.in','India',22),('chhattisgarh.gov.in','India',22),('himachal.nic.in','India',22),('sikkim.gov.in','India',22),('mizoram.gov.in','India',22),('meghalaya.gov.in','India',22),('nagaland.gov.in','India',22),('tripura.gov.in','India',22),('manipur.gov.in','India',22),('arunachalpradesh.gov.in','India',22),('andhrapradesh.gov.in','India',22),
-- India – agencies & services
('uidai.gov.in','India',23),('nsdl.co.in','India',23),('incometaxindia.gov.in','India',23),('rbi.org.in','India',23),('sebi.gov.in','India',23),('irda.gov.in','India',23),('pfrda.org.in','India',23),

-- Indonesia – federal anchors & portals
('indonesia.go.id','Indonesia',24),('setneg.go.id','Indonesia',24),('dpr.go.id','Indonesia',24),('mahkamahagung.go.id','Indonesia',24),('kpu.go.id','Indonesia',24),

-- Indonesia – ministries (sample, stable top-level domains)
('kemdikbud.go.id','Indonesia',23),('kemenkeu.go.id','Indonesia',23),('kemlu.go.id','Indonesia',23),('kemhan.go.id','Indonesia',23),('kemenperin.go.id','Indonesia',23),('kemenkopmk.go.id','Indonesia',23),('kemenkumham.go.id','Indonesia',23),('kemenhub.go.id','Indonesia',23),('kemenparekraf.go.id','Indonesia',23),('kemenkes.go.id','Indonesia',23),('kemenag.go.id','Indonesia',23),('kemensos.go.id','Indonesia',23),('kemenpppa.go.id','Indonesia',23),('kemenristek.go.id','Indonesia',23),('kementan.go.id','Indonesia',23),('kemenaker.go.id','Indonesia',23),('kemenlhk.go.id','Indonesia',23),('kemenpu.go.id','Indonesia',23),
-- Indonesia – provinces (roots, sample list)
('jakarta.go.id','Indonesia',22),('jatimprov.go.id','Indonesia',22),('jabarprov.go.id','Indonesia',22),('jatengprov.go.id','Indonesia',22),('sumutprov.go.id','Indonesia',22),('sumbarprov.go.id','Indonesia',22),('sumselprov.go.id','Indonesia',22),('riau.go.id','Indonesia',22),('kepulauanriau.go.id','Indonesia',22),('lampungprov.go.id','Indonesia',22),('acehprov.go.id','Indonesia',22),('nttprov.go.id','Indonesia',22),('ntbprov.go.id','Indonesia',22),('papua.go.id','Indonesia',22),('papuabaratprov.go.id','Indonesia',22),('kalbarprov.go.id','Indonesia',22),('kaltimprov.go.id','Indonesia',22),('kaltengprov.go.id','Indonesia',22),('kalselprov.go.id','Indonesia',22),('sulselprov.go.id','Indonesia',22),('sulutprov.go.id','Indonesia',22),('sulbarprov.go.id','Indonesia',22),('sultrabaratprov.go.id','Indonesia',22),('gorontaloprov.go.id','Indonesia',22),('malutprov.go.id','Indonesia',22),('malukuprov.go.id','Indonesia',22),('bali.go.id','Indonesia',22),('bantenprov.go.id','Indonesia',22),('bangka.go.id','Indonesia',22),('babelprov.go.id','Indonesia',22),
-- Indonesia – municipalities (major examples)
('bandung.go.id','Indonesia',21),('surabaya.go.id','Indonesia',21),('semarang.go.id','Indonesia',21),('medan.go.id','Indonesia',21),('makassar.go.id','Indonesia',21),('denpasarkota.go.id','Indonesia',21),('yogyakarta.go.id','Indonesia',21),('bekasikota.go.id','Indonesia',21),('depok.go.id','Indonesia',21),('bogorkota.go.id','Indonesia',21),

-- Ireland – federal anchors & portals
('gov.ie','Ireland',24),('oireachtas.ie','Ireland',24),('president.ie','Ireland',24),('citizensinformation.ie','Ireland',24),('irishstatutebook.ie','Ireland',24),
-- Ireland – ministries (departments with stable hostnames)
('finance.gov.ie','Ireland',23),('health.gov.ie','Ireland',23),('justice.ie','Ireland',23),('defence.ie','Ireland',23),('education.ie','Ireland',23),('enterprise.gov.ie','Ireland',23),('housing.gov.ie','Ireland',23),('socialprotection.ie','Ireland',23),('transport.gov.ie','Ireland',23),('agriculture.gov.ie','Ireland',23),('dttas.ie','Ireland',23),('environment.gov.ie','Ireland',23),('foreignaffairs.ie','Ireland',23),
-- Ireland – agencies & key authorities
('revenue.ie','Ireland',23),('courts.ie','Ireland',23),('agriculture.gov.ie','Ireland',23),('competitionandconsumer.ie','Ireland',23),('data.gov.ie','Ireland',23),('healthservice.hse.ie','Ireland',23),('hse.ie','Ireland',23),('rtb.ie','Ireland',23),('cso.ie','Ireland',23),
-- Ireland – local authorities (sample, can expand with regex)
('dublincity.ie','Ireland',22),('corkcity.ie','Ireland',22),('galwaycity.ie','Ireland',22),('limerick.ie','Ireland',22),('waterfordcouncil.ie','Ireland',22),('fingal.ie','Ireland',22),('dlrcoco.ie','Ireland',22),('meath.ie','Ireland',22),('kildare.ie','Ireland',22),

-- Latvia – federal anchors & portals
('gov.lv','Latvia',24),('mk.gov.lv','Latvia',24),('likumi.lv','Latvia',24),('president.lv','Latvia',24),('saeima.lv','Latvia',24),
-- Latvia – ministries
('fm.gov.lv','Latvia',23),('mfa.gov.lv','Latvia',23),('mod.gov.lv','Latvia',23),('iem.gov.lv','Latvia',23),('em.gov.lv','Latvia',23),('izm.gov.lv','Latvia',23),('zm.gov.lv','Latvia',23),('am.gov.lv','Latvia',23),('lm.gov.lv','Latvia',23),('vmnvd.gov.lv','Latvia',23),
-- Latvia – agencies & authorities
('csp.gov.lv','Latvia',23),('vd.gov.lv','Latvia',23),('pmlp.gov.lv','Latvia',23),('vraa.gov.lv','Latvia',23),('rtu.lv','Latvia',23),('riga.lv','Latvia',23),
-- Latvia – municipalities (sampled major ones, could expand with regex)
('riga.lv','Latvia',22),('daugavpils.lv','Latvia',22),('liepaja.lv','Latvia',22),('jelgava.lv','Latvia',22),('ventspils.lv','Latvia',22),

-- Luxembourg – federal anchors & portals
('luxembourg.lu','Luxembourg',24),('etat.lu','Luxembourg',24),('public.lu','Luxembourg',24),('guichet.public.lu','Luxembourg',24),('data.public.lu','Luxembourg',24),('service-public.lu','Luxembourg',24),
-- Luxembourg – ministries
('mfin.gouvernement.lu','Luxembourg',23),('maee.gouvernement.lu','Luxembourg',23),('mjustice.gouvernement.lu','Luxembourg',23),('meco.gouvernement.lu','Luxembourg',23),('mint.gouvernement.lu','Luxembourg',23),('mtes.gouvernement.lu','Luxembourg',23),('mss.gouvernement.lu','Luxembourg',23),('mcr.gouvernement.lu','Luxembourg',23),('mfamigr.gouvernement.lu','Luxembourg',23),('msh.gouvernement.lu','Luxembourg',23),
-- Luxembourg – agencies & authorities
('legilux.public.lu','Luxembourg',23),('education.lu','Luxembourg',23),('secu.lu','Luxembourg',23),('cns.lu','Luxembourg',23),('statec.lu','Luxembourg',23),('ces.lu','Luxembourg',23),('police.public.lu','Luxembourg',23),('sante.public.lu','Luxembourg',23),('environnement.public.lu','Luxembourg',23),('snca.public.lu','Luxembourg',23),
-- Luxembourg – municipalities (sample)
('ville.lu','Luxembourg',22),('esch.lu','Luxembourg',22),('differdange.lu','Luxembourg',22),('dudelange.lu','Luxembourg',22),('ettelbruck.lu','Luxembourg',22),('remich.lu','Luxembourg',22),

-- Malaysia – federal anchors & portals
('malaysia.gov.my','Malaysia',24),('gov.my','Malaysia',24),('data.gov.my','Malaysia',24),
-- Malaysia – ministries
('moh.gov.my','Malaysia',23),('moe.gov.my','Malaysia',23),('mohr.gov.my','Malaysia',23),('mot.gov.my','Malaysia',23),('miti.gov.my','Malaysia',23),('mod.gov.my','Malaysia',23),('moa.gov.my','Malaysia',23),('mosti.gov.my','Malaysia',23),('mida.gov.my','Malaysia',23),('mohe.gov.my','Malaysia',23),('moha.gov.my','Malaysia',23),('mohd.gov.my','Malaysia',23),
-- Malaysia – agencies & authorities
('epu.gov.my','Malaysia',23),('bomba.gov.my','Malaysia',23),('immigration.gov.my','Malaysia',23),('police.gov.my','Malaysia',23),('spr.gov.my','Malaysia',23),('ecerdc.gov.my','Malaysia',23),('doe.gov.my','Malaysia',23),('jkr.gov.my','Malaysia',23),('lpse.gov.my','Malaysia',23),
-- Malaysia – states (examples, expandable)
('penang.gov.my','Malaysia',22),('perak.gov.my','Malaysia',22),('selangor.gov.my','Malaysia',22),('sabah.gov.my','Malaysia',22),('sarawak.gov.my','Malaysia',22),('kedah.gov.my','Malaysia',22),('kelantan.gov.my','Malaysia',22),('terengganu.gov.my','Malaysia',22),


-- Nepal – federal anchors & key portals
('nepal.gov.np','Nepal',24),('nepalarmy.mil.np','Nepal',24),('supremecourt.gov.np','Nepal',24), ('parliament.gov.np','Nepal',24),('officeofattorneygeneral.gov.np','Nepal',24), ('mof.gov.np','Nepal',24),('moha.gov.np','Nepal',24),('moeap.gov.np','Nepal',24), ('mohp.gov.np','Nepal',24),('mofa.gov.np','Nepal',24),('moi.gov.np','Nepal',24), ('moest.gov.np','Nepal',24),('mowcsw.gov.np','Nepal',24),('mopit.gov.np','Nepal',24),('mofaga.gov.np','Nepal',24),('moewri.gov.np','Nepal',24),('npc.gov.np','Nepal',24),

-- Morocco – federal anchors & key portals
('maroc.ma','Morocco',24),('gov.ma','Morocco',24),('service-public.ma','Morocco',24),
('justice.gov.ma','Morocco',24),('finances.gov.ma','Morocco',24),('sante.gov.ma','Morocco',24),
('interieur.gov.ma','Morocco',24),('map.ma','Morocco',24),('parlement.ma','Morocco',24),

-- Malta – federal anchors & key portals
('gov.mt','Malta',24),('parlament.mt','Malta',24),('justice.gov.mt','Malta',24),
('govserv.gov.mt','Malta',24),('mepa.org.mt','Malta',24),('um.edu.mt','Malta',24),

-- Netherlands – federal anchors & key institutions
('overheid.nl','Netherlands',24),('rijksoverheid.nl','Netherlands',24), ('belastingdienst.nl','Netherlands',24),('politie.nl','Netherlands',24), ('kvk.nl','Netherlands',24),('cbs.nl','Netherlands',24),('rvo.nl','Netherlands',24), ('rijkshuisstijl.nl','Netherlands',24),('rechtspraak.nl','Netherlands',24), ('wetten.overheid.nl','Netherlands',24),('kamer.nl','Netherlands',24), ('eerstekamer.nl','Netherlands',24),('tweedekamer.nl','Netherlands',24), ('mijnoverheid.nl','Netherlands',24),('koninklijkhuis.nl','Netherlands',24), ('openbaarministerie.nl','Netherlands',24),('raadvanstate.nl','Netherlands',24), ('autoriteitpersoonsgegevens.nl','Netherlands',24),('autoriteitconsumentmarkt.nl','Netherlands',24), ('marechaussee.nl','Netherlands',24),   
-- Netherlands – provinces (explicit full set)
('drenthe.nl','Netherlands',23),('flevoland.nl','Netherlands',23),('friesland.nl','Netherlands',23), ('gelderland.nl','Netherlands',23),('groningen.nl','Netherlands',23),('limburg.nl','Netherlands',23), ('noord-brabant.nl','Netherlands',23),('noord-holland.nl','Netherlands',23),('overijssel.nl','Netherlands',23), ('utrecht.nl','Netherlands',23),('zeeland.nl','Netherlands',23),('zuid-holland.nl','Netherlands',23),

-- New Zealand – federal anchors & key institutions
('govt.nz','New Zealand',24),('parliament.nz','New Zealand',24),
('justice.govt.nz','New Zealand',24),('treasury.govt.nz','New Zealand',24),
('health.govt.nz','New Zealand',24),('education.govt.nz','New Zealand',24),
('police.govt.nz','New Zealand',24),
-- Other New Zealand public entitites 
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

-- Norway – federal anchors & key institutions
('regjeringen.no','Norway',24),('stortinget.no','Norway',24),('nav.no','Norway',24),
('helsenorge.no','Norway',24),('udir.no','Norway',24),('udi.no','Norway',24),
('politi.no','Norway',24),('nve.no','Norway',24),('ssb.no','Norway',24),
('norges-bank.no','Norway',24),('miljodirektoratet.no','Norway',24),
('arbeidstilsynet.no','Norway',24),('forsvaret.no','Norway',24),('skatteetaten.no','Norway',24),
('brreg.no','Norway',24),('vegvesen.no','Norway',24),('mattilsynet.no','Norway',24),
('lovdata.no','Norway',24),('altinn.no','Norway',24),('nkom.no','Norway',24),
('fhi.no','Norway',24),('dsa.no','Norway',24),('kystverket.no','Norway',24),
('bufdir.no','Norway',24),('nupi.no','Norway',24),

-- Portugal – federal anchors & portals
('portugal.gov.pt','Portugal',24),('parlamento.pt','Portugal',24),
('presidencia.pt','Portugal',24),('tribunalconstitucional.pt','Portugal',24),
('pgdlisboa.pt','Portugal',24),('cmjornal.pt','Portugal',24),
('dre.pt','Portugal',24),('base.gov.pt','Portugal',24),
('ana.pt','Portugal',24),('ansr.pt','Portugal',24),

-- Philippines – federal anchors & portals
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

-- Peru – federal anchors & portals
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

-- Russia – federal anchors & portals
('government.ru','Russia',24),('kremlin.ru','Russia',24),
('duma.gov.ru','Russia',24),('council.gov.ru','Russia',24),
('supcourt.ru','Russia',24),('minfin.gov.ru','Russia',24),
('minjust.gov.ru','Russia',24),('mid.ru','Russia',24),
('minobrnauki.gov.ru','Russia',24),('minzdrav.gov.ru','Russia',24),
('mintrud.gov.ru','Russia',24),('mchs.gov.ru','Russia',24),
('fsb.ru','Russia',24),('fso.gov.ru','Russia',24),
('prosecutor.ru','Russia',24),('roskazna.gov.ru','Russia',24),
('fssprus.ru','Russia',24),('nalog.gov.ru','Russia',24),
('customs.gov.ru','Russia',24),('gks.ru','Russia',24),
('govvrn.ru','Russia',24),

-- Singapore – federal anchors & portals
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

-- South Africa – federal anchors & portals
('gov.za','South Africa',24),('parliament.gov.za','South Africa',24),('justice.gov.za','South Africa',24),
('health.gov.za','South Africa',24),('education.gov.za','South Africa',24),('treasury.gov.za','South Africa',24),
('dirco.gov.za','South Africa',24),('defence.gov.za','South Africa',24),('sapolice.gov.za','South Africa',24),
('environment.gov.za','South Africa',24),('labour.gov.za','South Africa',24),('transport.gov.za','South Africa',24),
('dpsa.gov.za','South Africa',24),('cogta.gov.za','South Africa',24),

-- Ukraine – federal anchors & key institutions
('gov.ua','Ukraine',24),('rada.gov.ua','Ukraine',24),('president.gov.ua','Ukraine',24),
('kmu.gov.ua','Ukraine',24),('minfin.gov.ua','Ukraine',24),('mon.gov.ua','Ukraine',24),
('mvs.gov.ua','Ukraine',24),('mfa.gov.ua','Ukraine',24),('minjust.gov.ua','Ukraine',24),
('minregion.gov.ua','Ukraine',24),('mincult.gov.ua','Ukraine',24),('mil.gov.ua','Ukraine',24),
('dsns.gov.ua','Ukraine',24),('ssu.gov.ua','Ukraine',24),('sfs.gov.ua','Ukraine',24),
('nas.gov.ua','Ukraine',24),('court.gov.ua','Ukraine',24),('zakon.rada.gov.ua','Ukraine',24),
('council.gov.ua','Ukraine',24),('prosecutor.gov.ua','Ukraine',24),

-- Switzerland – federal anchors & key institutions
('admin.ch','Switzerland',24),('parlament.ch','Switzerland',24),('bundesgericht.ch','Switzerland',24),
('seco.admin.ch','Switzerland',24),('bag.admin.ch','Switzerland',24),('bfs.admin.ch','Switzerland',24),
('eda.admin.ch','Switzerland',24),('eda.admin.ch','Switzerland',24),('vbs.admin.ch','Switzerland',24),
('ejpd.admin.ch','Switzerland',24),('efd.admin.ch','Switzerland',24),('bfe.admin.ch','Switzerland',24),
('bazg.admin.ch','Switzerland',24),('bafu.admin.ch','Switzerland',24),('bfh.ch','Switzerland',24),
('unige.ch','Switzerland',24),('epfl.ch','Switzerland',24),('ethz.ch','Switzerland',24),

-- Sweden – federal & key institutions
('gov.se','Sweden',24),('regeringen.se','Sweden',24),('riksdagen.se','Sweden',24),('domstol.se','Sweden',24),
('skatteverket.se','Sweden',24),('forsakringskassan.se','Sweden',24),('arbetsformedlingen.se','Sweden',24),
('polisen.se','Sweden',24),('trafikverket.se','Sweden',24),('kriminalvarden.se','Sweden',24),
('smhi.se','Sweden',24),('naturvardsverket.se','Sweden',24),('socialstyrelsen.se','Sweden',24),
('1177.se','Sweden',24),('sl.se','Sweden',24),
-- Sweden – agencies & services (from your original mix and file list)
('funktionstjanster.se','Sweden',23),('hemnet.se','Sweden',23),('sverigesradio.se','Sweden',23),
('klart.se','Sweden',23),('bankid.com','Sweden',23),('synonymer.se','Sweden',23),
('schoolsoft.se','Sweden',23),('postnord.se','Sweden',23),('grandid.com','Sweden',23),
('viaplay.se','Sweden',23),('skola24.se','Sweden',23),('vklass.se','Sweden',23),
('familjeliv.se','Sweden',23),

-- United Kingdom – core & devolved anchors not on .gov.uk
('parliament.uk','United Kingdom (UK)',24), ('judiciary.uk','United Kingdom (UK)',24), ('supremecourt.uk','United Kingdom (UK)',24), ('parliament.scot','United Kingdom (UK)',24), ('senedd.wales','United Kingdom (UK)',24), ('senedd.cymru','United Kingdom (UK)',24), ('police.scot','United Kingdom (UK)',23),
-- Big UK municipalities (already .gov.uk but kept for high priority)
('london.gov.uk','United Kingdom (UK)',24), ('cityoflondon.gov.uk','United Kingdom (UK)',24), ('birmingham.gov.uk','United Kingdom (UK)',24), ('manchester.gov.uk','United Kingdom (UK)',24), ('leeds.gov.uk','United Kingdom (UK)',24), ('liverpool.gov.uk','United Kingdom (UK)',24), ('sheffield.gov.uk','United Kingdom (UK)',24), ('bristol.gov.uk','United Kingdom (UK)',24), ('glasgow.gov.uk','United Kingdom (UK)',24), ('edinburgh.gov.uk','United Kingdom (UK)',24), ('cardiff.gov.uk','United Kingdom (UK)',24), ('belfastcity.gov.uk','United Kingdom (UK)',24),

-- Uruguay – federal anchors & portals
('gub.uy','Uruguay',24),('uruguay.gub.uy','Uruguay',24),('parlamento.gub.uy','Uruguay',24),
('presidencia.gub.uy','Uruguay',24),('ministerio.gub.uy','Uruguay',24),('poderjudicial.gub.uy','Uruguay',24),

-- Costa Rica – federal anchors & portals
('go.cr','Costa Rica',24),('presidencia.go.cr','Costa Rica',24),('ministeriodesalud.go.cr','Costa Rica',24), ('mep.go.cr','Costa Rica',24),('hacienda.go.cr','Costa Rica',24),('racsa.go.cr','Costa Rica',24), ('cgr.go.cr','Costa Rica',24),('ccss.sa.cr','Costa Rica',24),
-- Costa Rica – legislature & judiciary
('asamblea.go.cr','Costa Rica',24),('poder-judicial.go.cr','Costa Rica',24),('corte.go.cr','Costa Rica',24),
-- Costa Rica – municipalities (sample)
('muni.go.cr','Costa Rica',23),('munisanjose.go.cr','Costa Rica',23),('munialajuela.go.cr','Costa Rica',23), ('municartago.go.cr','Costa Rica',23),('muniheredia.go.cr','Costa Rica',23),

-- France – national portals & key institutions
('gouvernement.fr','France',24),('elysee.fr','France',24),('service-public.fr','France',24),('legifrance.gouv.fr','France',24),('vie-publique.fr','France',24),('data.gouv.fr','France',24),('interieur.gouv.fr','France',24),('economie.gouv.fr','France',24),('travail-emploi.gouv.fr','France',24),('education.gouv.fr','France',24),('enseignementsup-recherche.gouv.fr','France',24),('justice.gouv.fr','France',24),('defense.gouv.fr','France',24),('sante.gouv.fr','France',24),('agriculture.gouv.fr','France',24),('culture.gouv.fr','France',24),('transition-ecologique.gouv.fr','France',24),('ecologie.gouv.fr','France',24),('diplomatie.gouv.fr','France',24),('impots.gouv.fr','France',24),('douane.gouv.fr','France',24),('france-visas.gouv.fr','France',24),
-- France – independent authorities & national public bodies (non-*.gouv.fr)
('insee.fr','France',23),('banque-france.fr','France',23),('cnil.fr','France',23),('pole-emploi.fr','France',23),('francetravail.fr','France',23),('ameli.fr','France',23),('assurance-maladie.fr','France',23),('urssaf.fr','France',23),('caf.fr','France',23),('cnam.fr','France',23),('cnav.fr','France',23),('labanquepostale.fr','France',22),('meteofrance.com','France',22),('meteofrance.fr','France',22),('boamp.fr','France',22),('marches-publics.gouv.fr','France',24),
-- France – Parliament & high courts
('assemblee-nationale.fr','France',24),('senat.fr','France',24),('conseil-constitutionnel.fr','France',24),('conseil-etat.fr','France',24),('courdescomptes.fr','France',24),
-- France – regions (anchors)
('iledefrance.fr','France',23),('hautsdefrance.fr','France',23),('normandie.fr','France',23),('grandest.fr','France',23),('bourgognefranchecomte.fr','France',23),('centre-valdeloire.fr','France',23),('paysdelaloire.fr','France',23),('bretagne.bzh','France',23),('nouvelle-aquitaine.fr','France',23),('occitanie.fr','France',23),('auvergnerhonealpes.fr','France',23),('provencealpes-cotedazur.fr','France',23),('corse.fr','France',23),('lareunion.fr','France',23),('mayotte.fr','France',23),('guadeloupe.fr','France',23),('martinique.fr','France',23),('guyane.fr','France',23),('polynesie-francaise.pref.gouv.fr','France',24),('nouvelle-caledonie.gouv.fr','France',24),('saint-barth-saint-martin.gouv.fr','France',24),('saint-pierre-et-miquelon.gouv.fr','France',24),
-- France – major municipalities (explicit; many city sites are plain .fr/.eu)
('paris.fr','France',22),('lyon.fr','France',22),('marseille.fr','France',22),('toulouse.fr','France',22),('nice.fr','France',22),('nantes.fr','France',22),('montpellier.fr','France',22),('strasbourg.eu','France',22),('bordeaux.fr','France',22),('lille.fr','France',22),('rennes.fr','France',22),('reims.fr','France',22),('lehavre.fr','France',22),('saint-etienne.fr','France',22),('toulon.fr','France',22),('grenoble.fr','France',22),('dijon.fr','France',22),('angers.fr','France',22),('nancy.fr','France',22),('metz.fr','France',22),('clermont-ferrand.fr','France',22),('orleans.fr','France',22),('caen.fr','France',22),('tours.fr','France',22),('amiens.fr','France',22),('limoges.fr','France',22),('perpignan.fr','France',22),('annecy.fr','France',22),
  
-- Spain – national portals & key institutions
('lamoncloa.gob.es','Spain',24),('mptfp.gob.es','Spain',24),('hacienda.gob.es','Spain',24),('interior.gob.es','Spain',24),('justicia.gob.es','Spain',24),('exteriores.gob.es','Spain',24),('transicionecologica.gob.es','Spain',24),('transportes.gob.es','Spain',24),('educacionyfp.gob.es','Spain',24),('sanidad.gob.es','Spain',24),('agricultura.gob.es','Spain',24),('ciencia.gob.es','Spain',24),('industria.gob.es','Spain',24),('trabajo.gob.es','Spain',24),('inclusion.gob.es','Spain',24),('igualdad.gob.es','Spain',24),('policia.es','Spain',24),('guardiacivil.es','Spain',24),('dgt.es','Spain',24),('aemet.es','Spain',24),('aeat.es','Spain',24),('agenciatributaria.es','Spain',24),('seg-social.es','Spain',24),('seguridadsocial.gob.es','Spain',24),('ine.es','Spain',24),('boe.es','Spain',24),
-- Spain – legislature & judiciary
('congreso.es','Spain',24),('congresodelosdiputados.es','Spain',24),('senado.es','Spain',24),('poderjudicial.es','Spain',24),('tribunalconstitucional.es','Spain',24),('audiencia-nacional.es','Spain',24),('tribunaldecuentas.es','Spain',24),('defensordelpueblo.es','Spain',24),
-- Spain – autonomous communities (anchors)
('juntadeandalucia.es','Spain',23),('andalucia.es','Spain',23),('aragon.es','Spain',23), ('asturias.es','Spain',23),('cantabria.es','Spain',23),('castillalamancha.es','Spain',23), ('jccm.es','Spain',23),('jcyl.es','Spain',23),('gencat.cat','Spain',23),
('comunidad.madrid','Spain',23),('navarra.es','Spain',23),('larioja.org','Spain',23), ('xunta.gal','Spain',23),('gva.es','Spain',23),('carm.es','Spain',23), ('juntaex.es','Spain',23),('caib.es','Spain',23),('gobiernodecanarias.org','Spain',23), ('euskadi.eus','Spain',23),('irekia.euskadi.eus','Spain',23),
-- Spain – major municipalities (sample anchors; regex below will catch the rest)
('madrid.es','Spain',22),('barcelona.cat','Spain',22),('valencia.es','Spain',22),('sevilla.org','Spain',22),('zaragoza.es','Spain',22),('malaga.eu','Spain',22),('bilbao.eus','Spain',22),('vitoria-gasteiz.org','Spain',22),('donostia.eus','Spain',22),

-- Liechtenstein
('llv.li','Liechtenstein',24),       -- Main government portal (Landesverwaltung)
('regierung.li','Liechtenstein',24), -- Government / Prime Minister’s office
('landtag.li','Liechtenstein',24),   -- Parliament
('gericht.li','Liechtenstein',24),   -- Courts / judiciary
('staatsanwaltschaft.li','Liechtenstein',24), -- Public Prosecutor’s office
('gemeinden.li','Liechtenstein',23), -- Municipal portal (links to the 11 municipalities)

-- Estonia – federal anchors, ministries, agencies, courts & major municipalities
('riigikantselei.ee','Estonia',24),('valitsus.ee','Estonia',24),('riigikogu.ee','Estonia',24),('riigiteataja.ee','Estonia',24),('riik.ee','Estonia',24),('eesti.ee','Estonia',24),('hm.ee','Estonia',24),('mkm.ee','Estonia',24),('siseministeerium.ee','Estonia',24),('sm.ee','Estonia',24),('kliimaministeerium.ee','Estonia',24),('agri.ee','Estonia',24),('just.ee','Estonia',24),('kaitseministeerium.ee','Estonia',24),('kul.ee','Estonia',24),('fin.ee','Estonia',24),('vm.ee','Estonia',24),('ria.ee','Estonia',24),('stat.ee','Estonia',24),('prokuratuur.ee','Estonia',24),('kohtuteave.ee','Estonia',24),('riigikohus.ee','Estonia',24),('tallinn.ee','Estonia',23),('tartu.ee','Estonia',23),('narva.ee','Estonia',23),('parnu.ee','Estonia',23),('viljandi.ee','Estonia',23),('rakvere.ee','Estonia',23),('kuressaare.ee','Estonia',23),

-- Mexico – federal anchors & portals
('gob.mx','Mexico',24),('presidencia.gob.mx','Mexico',24),('senado.gob.mx','Mexico',24),('diputados.gob.mx','Mexico',24),('scjn.gob.mx','Mexico',24),('inegi.org.mx','Mexico',24),('ine.mx','Mexico',24),
-- Mexico – key ministries (federal secretarías)
('segob.gob.mx','Mexico',23),('sre.gob.mx','Mexico',23),('shcp.gob.mx','Mexico',23),('sct.gob.mx','Mexico',23),('salud.gob.mx','Mexico',23),('sep.gob.mx','Mexico',23),('semarnat.gob.mx','Mexico',23),('sagarpa.gob.mx','Mexico',23),('stps.gob.mx','Mexico',23),('se.gob.mx','Mexico',23),('sedena.gob.mx','Mexico',23),('semar.gob.mx','Mexico',23),
-- Mexico – states (anchors for each state government)
('aguascalientes.gob.mx','Mexico',22),('bajacalifornia.gob.mx','Mexico',22),('bcs.gob.mx','Mexico',22),('campeche.gob.mx','Mexico',22),('coahuila.gob.mx','Mexico',22),('colima.gob.mx','Mexico',22),('chiapas.gob.mx','Mexico',22),('chihuahua.gob.mx','Mexico',22),('cdmx.gob.mx','Mexico',22),('durango.gob.mx','Mexico',22),('guanajuato.gob.mx','Mexico',22),('guerrero.gob.mx','Mexico',22),('hidalgo.gob.mx','Mexico',22),('jalisco.gob.mx','Mexico',22),('edomex.gob.mx','Mexico',22),('michoacan.gob.mx','Mexico',22),('morelos.gob.mx','Mexico',22),('nayarit.gob.mx','Mexico',22),('nuevoleon.gob.mx','Mexico',22),('oaxaca.gob.mx','Mexico',22),('puebla.gob.mx','Mexico',22),('queretaro.gob.mx','Mexico',22),('quintanaroo.gob.mx','Mexico',22),('sanluispotosi.gob.mx','Mexico',22),('sinaloa.gob.mx','Mexico',22),('sonora.gob.mx','Mexico',22),('tabasco.gob.mx','Mexico',22),('tamaulipas.gob.mx','Mexico',22),('tlaxcala.gob.mx','Mexico',22),('veracruz.gob.mx','Mexico',22),('yucatan.gob.mx','Mexico',22),('zacatecas.gob.mx','Mexico',22),

-- Lithuania – federal anchors & portals
('lrv.lt','Lithuania',24),('lrs.lt','Lithuania',24),('prezidentas.lt','Lithuania',24),
-- Lithuania – ministries
('urm.lt','Lithuania',23),('kam.lt','Lithuania',23),('smm.lt','Lithuania',23),('sveikata.lt','Lithuania',23),
('sumin.lt','Lithuania',23),('finmin.lt','Lithuania',23),('am.lt','Lithuania',23),('socmin.lt','Lithuania',23),
('ukmin.lt','Lithuania',23),('zum.lt','Lithuania',23),('teisingumas.lt','Lithuania',23),('vidmin.lt','Lithuania',23),
-- Lithuania – key agencies & authorities
('stat.gov.lt','Lithuania',22),('vrk.lt','Lithuania',22),('policija.lt','Lithuania',22),('lvat.lt','Lithuania',22),
('ltok.lt','Lithuania',22),('uzt.lt','Lithuania',22),('migracija.lt','Lithuania',22),('vmi.lt','Lithuania',22),
-- Lithuania – municipalities (major cities)
('vilnius.lt','Lithuania',21),('kaunas.lt','Lithuania',21),('klaipeda.lt','Lithuania',21),
('siauliai.lt','Lithuania',21),('panevezys.lt','Lithuania',21),('alytus.lt','Lithuania',21),

-- Italy – federal anchors & portals
('governo.it','Italy',24),('parlamento.it','Italy',24),('senato.it','Italy',24),
('camera.it','Italy',24),('quirinale.it','Italy',24),
-- Italy – ministries
('esteri.it','Italy',23),('interno.gov.it','Italy',23),('difesa.it','Italy',23),('giustizia.it','Italy',23),
('salute.gov.it','Italy',23),('istruzione.it','Italy',23),('mipaaf.gov.it','Italy',23),('mise.gov.it','Italy',23),
('mims.gov.it','Italy',23),('mef.gov.it','Italy',23),('mase.gov.it','Italy',23),('minambiente.it','Italy',23),
('lavoro.gov.it','Italy',23),('cultura.gov.it','Italy',23),('turismo.gov.it','Italy',23),
-- Italy – key agencies & authorities
('agid.gov.it','Italy',22),('agcom.it','Italy',22),('ivass.it','Italy',22),
('corteconti.it','Italy',22),('istat.it','Italy',22),('inps.it','Italy',22),
('agenziaentrate.gov.it','Italy',22),('agenziadoganemonopoli.gov.it','Italy',22),
-- Italy – regions (anchors)
('regione.lombardia.it','Italy',21),('regione.piemonte.it','Italy',21),('regione.lazio.it','Italy',21),
('regione.veneto.it','Italy',21),('regione.toscana.it','Italy',21),('regione.campania.it','Italy',21),
('regione.sicilia.it','Italy',21),('regione.emilia-romagna.it','Italy',21),
-- Italy – municipalities (major cities)
('comune.roma.it','Italy',20),('comune.milano.it','Italy',20),('comune.napoli.it','Italy',20),
('comune.torino.it','Italy',20),('comune.firenze.it','Italy',20),('comune.bologna.it','Italy',20),

-- Andorra – federal anchors
('govern.ad','Andorra',24),('consellgeneral.ad','Andorra',24),('exteriors.ad','Andorra',24),
-- Andorra – ministries & authorities
('justicia.ad','Andorra',23),('tribunalconstitucional.ad','Andorra',23),
('iniciativa.ad','Andorra',23),('aferssocials.ad','Andorra',23),('educacio.ad','Andorra',23),
('salut.ad','Andorra',23),('interior.ad','Andorra',23),('finances.ad','Andorra',23),
-- Andorra – municipalities (comuns/parishes)
('andorra.ad','Andorra',22),('encamp.ad','Andorra',22),('ordino.ad','Andorra',22),
('canillo.ad','Andorra',22),('santjulia.ad','Andorra',22),('lauredia.ad','Andorra',22),
('escaldesengordany.ad','Andorra',22),('pasdelacasa.ad','Andorra',22),

-- United States (USA) – non-.gov anchors to keep explicitly
('si.edu','United States (USA)',24), ('dau.edu','United States (USA)',24), ('usps.com','United States (USA)',24), ('myflorida.com','United States (USA)',22), 
-- United States – major municipal/county outliers (non-.gov)
('lacity.org','United States (USA)',22), ('denvergov.org','United States (USA)',22), ('vbgov.com','United States (USA)',22), ('miamigov.com','United States (USA)',22), ('muni.org','United States (USA)',22), ('ocfl.net','United States (USA)',22), ('dallascityhall.com','United States (USA)',22) 

  ])
),

-- 2) Regex rules for families that aren’t just suffixes
regex_rules AS (
  SELECT * FROM UNNEST([

    -- European Union
    STRUCT(
      '(^|\\.)((eib\\.org|eif\\.org)|([a-z0-9-]+\\.)*eu\\.int|((eu20\\d{2}|20\\d{2}eu|[a-z]{2}20\\d{2})\\.(eu|[a-z]{2})))$' AS pattern,
      'European Union' AS bucket,
      23 AS priority
    ),
    (r'(^|\.)(?:copernicus|euvsdisinfo|europeana|europass|wifi4eu|sanctionsmap|open-research-europe|euipo)\.eu$', 'European Union', 23),

    -- United Nations
    ('(^|\\.)(([a-z0-9-]+\\.)*un\\.org)$', 'United Nations', 9),
    ('(^|\\.)(([a-z0-9-]+\\.)*(who|icao|wmo|wipo|itu)\\.int)$', 'United Nations', 9), -- .int agencies
    ('(^|\\.)(([a-z0-9-]+\\.)*(undp|unhcr|unicef|unodc|unido|unfpa)\\.org)$','United Nations',9), -- .org agencies

    -- Canada
    ('(^|\\.)[a-z0-9-]+\\.gc\\.ca$', 'Canada', 22),
    ('(^|\\.)gov\\.(ab|bc|mb|nb|nl|ns|nt|nu|on|pe|qc|sk|yk)\\.ca$', 'Canada', 22),
  
    -- Costa Rica
    ('(^|\\.)[a-z0-9-]+\\.go\\.cr$', 'Costa Rica', 22),

    -- Denmark
    ('(^|\\.)((regionh|rsyd|rm|rn|regionsjaelland)\\.dk)$', 'Denmark', 23),
    ('(^|\\.)((politi|skat|sundhed|virk|borger)\\.dk)$', 'Denmark', 23),

    -- France
    ('(^|\\.)(([a-z0-9-]+\\.)*gouv\\.fr)$', 'France', 23),
    ('(^|\\.)((assemblee-nationale|senat|conseil-constitutionnel|conseil-etat|courdescomptes|vie-publique)\\.fr)$', 'France', 24),

    -- Germany
    ('(^|\\.)((stadt|gemeinde|verbandsgemeinde|vg|amt|landkreis|kreis|bezirksamt|kreisverwaltung|kreisstadt|rathaus)[-.].*\\.de)$', 'Germany', 20),
    ('(^|\\.).*-?(stadt|gemeinde|amt|landkreis|kreis)(\\.[a-z0-9-]+)?\\.de$', 'Germany', 19),
    ('(^|\\.)((polizei|justiz|innenministerium|finanzministerium|wirtschaftsministerium|kultusministerium|sozialministerium|verkehrsministerium|verfassungsschutz|rechnungshof)\\.?\\.?.*\\.de)$', 'Germany', 20),
    ('(^|\\.)((amtsgericht|landgericht|oberlandesgericht|sozialgericht|arbeitsgericht|finanzgericht|verwaltungsgericht|oberverwaltungsgericht|staatsanwaltschaft)[-.].*\\.de)$', 'Germany', 20),
    ('(^|\\.)((bundesamt|bundesanstalt)[-.].*\\.de)$', 'Germany', 21),
    ('(^|\\.)((finanzamt|zoll|arbeitsagentur|jobcenter|jugendamt)\\.?\\.?.*\\.de)$', 'Germany', 19),
    ('(^|\\.)((gesundheitsministerium|wissenschaftsministerium|kultusministerium|landwirtschaftsministerium)\\.?\\.?.*\\.de)$', 'Germany', 20),
    ('(^|\\.)((landkreis|kreis|bezirk)[-.].*\\.de)$', 'Germany', 19),
    ('(^|\\.)(([a-z0-9-]+\\.)*diplo\\.de)$', 'Germany', 21),
  
    -- India
    ('(^|\\.)((gov|nic)\\.in)$', 'India', 21),

    -- Indonesia
    ('(^|\\.)[a-z0-9-]+\\.go\\.id$', 'Indonesia', 20),

    -- Ireland
    ('(^|\\.)(([a-z0-9-]+coco\\.ie|[a-z0-9-]+council\\.ie))$', 'Ireland', 21),

    -- Latvia
    ('(^|\\.)[a-z0-9-]+\\.lv$', 'Latvia', 21),

    -- Luxembourg
    ('(^|\\.)((public|gov|etat|data|service|security|mfi|lux)(\\.(public|gov|etat))?\\.lu)$', 'Luxembourg', 24),
    ('(^|\\.)(([a-z0-9-]+\\.)*gouvernement\\.lu)$', 'Luxembourg', 24),
    ('(^|\\.)(([a-z0-9-]+\\.)*public\\.lu)$', 'Luxembourg', 23),


    -- Malaysia
    ('(^|\\.)[a-z0-9-]+\\.gov\\.my$', 'Malaysia', 22),
    ('(^|\\.)([a-z0-9-]+\\.){2,}gov\\.my$', 'Malaysia', 21),

    -- Malta
    ('(^|\\.)[a-z0-9-]+\\.gov\\.mt$', 'Malta', 22),

    -- Morocco
    ('(^|\\.)[a-z0-9-]+\\.gov\\.ma$', 'Morocco', 22),

    -- Nepal
    ('(^|\\.)[a-z0-9-]+\\.(gov|mil)\\.np$', 'Nepal', 22),

    -- Netherlands
    ('(^|\\.)[a-z0-9-]+\\.overheid\\.nl$', 'Netherlands', 22),
    ('(^|\\.)[a-z0-9-]+\\.rijksoverheid\\.nl$', 'Netherlands', 22),
    ('(^|\\.)[a-z0-9-]+\\.gov\\.nl$', 'Netherlands', 22),
    ('(^|\\.)gemeente[a-z0-9-]*\\.nl$', 'Netherlands', 21),
    ('(^|\\.)provincie[a-z0-9-]*\\.nl$', 'Netherlands', 21),
  
    -- New Zealand
    ('(^|\\.)[a-z0-9-]+\\.govt\\.nz$', 'New Zealand', 22),
    ('(^|\\.)[a-z0-9-]+\\.parliament\\.nz$', 'New Zealand', 22),
    ('(^|\\.)[a-z0-9-]+\\.health\\.nz$', 'New Zealand', 22),
    ('(^|\\.)[a-z0-9-]+\\.mil\\.nz$', 'New Zealand', 22),

    -- Norway
    ('(^|\\.)[a-z0-9-]+\\.no$', 'Norway', 22),

    -- Peru
    ('(^|\\.)[a-z0-9-]+\\.gob\\.pe$', 'Peru', 22),
    ('(^|\\.)[a-z0-9-]+\\.region\\.gob\\.pe$', 'Peru', 21),
    ('(^|\\.)[a-z0-9-]+\\.muni\\.gob\\.pe$', 'Peru', 20),

    -- Philippines
    ('(^|\\.)[a-z0-9-]+\\.gov\\.ph$', 'Philippines', 22),
    ('(^|\\.)[a-z0-9-]+\\.lgu\\.gov\\.ph$', 'Philippines', 21),
    ('(^|\\.)[a-z0-9-]+\\.edu\\.ph$', 'Philippines', 20),

    -- Portugal
    ('(^|\\.)gov\\.pt$', 'Portugal', 22),
    ('(^|\\.)muni\\.[a-z0-9-]+\\.pt$', 'Portugal', 21),
    ('(^|\\.)cm-[a-z0-9-]+\\.pt$', 'Portugal', 21),
    ('(^|\\.)[a-z0-9-]+\\.cm\\.pt$', 'Portugal', 21),

    -- Russia
    ('(^|\\.)[a-z0-9-]+\\.gov\\.ru$', 'Russia', 22),
    ('(^|\\.)[a-z0-9-]+\\.edu\\.ru$', 'Russia', 21),
    ('(^|\\.)[a-z0-9-]+\\.mil\\.ru$', 'Russia', 21),

    -- Singapore
    ('(^|\\.)[a-z0-9-]+\\.gov\\.sg$', 'Singapore', 22),

    -- South Africa
    ('(^|\\.)[a-z0-9-]+\\.gov\\.za$', 'South Africa', 22),

    -- Spain
    ('(^|\\.)[a-z0-9-]+\\.gob\\.es$', 'Spain', 22),
    ('(^|\\.)((ayto|ayuntamiento|diputacion(?:de)?|cabildo|consell)[-.][a-z0-9-]+\\.es)$', 'Spain', 20),
  
    -- Sweden
    ('(^|\\.)[a-z0-9-]+\\.gov\\.se$', 'Sweden', 22),
    ('(^|\\.)[a-z0-9-]+\\.kommun\\.se$', 'Sweden', 21),
    ('(^|\\.)[a-z0-9-]+\\.region\\.se$', 'Sweden', 21),
  
    -- Switzerland
    ('(^|\\.)[a-z0-9-]+\\.admin\\.ch$', 'Switzerland', 22),
    ('(^|\\.)[a-z0-9-]+\\.ch$', 'Switzerland', 18),

    -- Taiwan
    ('(^|\\.)[a-z0-9-]+\\.gov\\.tw$', 'Taiwan', 22),
    ('(^|\\.)gov\\.taipei$', 'Taiwan', 22),
  
    -- Ukraine
    ('(^|\\.)[a-z0-9-]+\\.gov\\.ua$', 'Ukraine', 22),
    ('(^|\\.)[a-z0-9-]+\\.rada\\.gov\\.ua$', 'Ukraine', 22),

    -- United Kingdom (UK)
    ('(^|\\.)[a-z0-9-]+\\.gov\\.uk$', 'United Kingdom (UK)', 22),
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

    -- United States (USA)
    ('\\.gov$', 'United States (USA)', 22),
    ('\\.mil$', 'United States (USA)', 22),
    ('(^|\\.)(([a-z0-9-]+\\.)*fed\\.us)$', 'United States (USA)', 22),
    ('(^|\\.)(([a-z0-9-]+\\.)*nsn\\.us)$', 'United States (USA)', 22),
    ('(^|\\.)(([a-z0-9-]+\\.)*state\\.[a-z]{2}\\.us)$', 'United States (USA)', 21),
    ('(^|\\.)(([a-z0-9-]+\\.)*(ci|city|cityof|co|county|countyof|borough|parish|town|townof|village|muni|municipal)\\.[a-z]{2}\\.us)$', 'United States (USA)', 20),
    ('(^|\\.)(([a-z0-9-]+\\.)*courts\\.[a-z]{2}\\.us)$', 'United States (USA)', 20),

    -- Uruguay
    ('(^|\\.)(([a-z0-9-]+\\.)*gub\\.uy)$', 'Uruguay', 22)

  ])
),

cc_map AS (
  SELECT * FROM UNNEST([
    -- A
    STRUCT('ac' AS tld, 'Ascension Island' AS bucket),
    ('ad','Andorra'), ('ae','United Arab Emirates'), ('af','Afghanistan'),
    ('ag','Antigua and Barbuda'), ('ai','Anguilla'), ('al','Albania'),
    ('am','Armenia'), ('ao','Angola'), ('ar','Argentina'), ('as','American Samoa'),
    ('at','Austria'), ('au','Australia'), ('aw','Aruba'), ('ax','Aland Islands'),
    ('az','Azerbaijan'),

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
    ('cy','Cyprus'), ('cz','Czech Republic'),

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
    ('km','Comoros'), ('kn','Saint Kitts and Nevis'), ('kp','North Korea'),
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
    ('sy','Syria'), ('sz','Eswatini'),

    -- T
    ('tc','Turks and Caicos Islands'), ('td','Chad'), ('tf','French Southern Territories'),
    ('tg','Togo'), ('th','Thailand'), ('tj','Tajikistan'), ('tk','Tokelau'),
    ('tl','East Timor'), ('tm','Turkmenistan'), ('tn','Tunisia'),
    ('to','Tonga'), ('tr','Türkiye'), ('tt','Trinidad and Tobago'),
    ('tv','Tuvalu'), ('tw','Taiwan'), ('tz','Tanzania'),

    -- U
    ('ua','Ukraine'), ('ug','Uganda'), ('uk','United Kingdom (UK)'),
    ('us','United States of America'), ('uy','Uruguay'), ('uz','Uzbekistan'),

    -- V
    ('va','Vatican City'), ('vc','Saint Vincent and the Grenadines'),
    ('ve','Venezuela'), ('vg','British Virgin Islands'), ('vi','US Virgin Islands'),
    ('vn','Vietnam'), ('vu','Vanuatu'),

    -- W
    ('wf','Wallis and Futuna'), ('ws','Samoa'),

    -- Y
    ('ye','Yemen'), ('yt','Mayotte'),

    -- Z
    ('za','South Africa'), ('zm','Zambia'), ('zw','Zimbabwe')
  ])
),

-- 3) Pages (root only) + scores
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
  FROM
  `httparchive.sample_data.pages_10k` 
  -- `httparchive.crawl.pages`
  WHERE 
    -- date = DATE '2025-07-01' AND
    is_root_page AND
    lighthouse IS NOT NULL AND
    JSON_TYPE(lighthouse) = 'object'
),

-- 4) Match by suffix
match_suffix AS (
  SELECT
    p.*, r.bucket, r.priority, LENGTH(r.suffix) AS match_len
  FROM pages p
  JOIN host_rules r
    ON ENDS_WITH(p.host, r.suffix)
),

-- 5) Match by regex family
match_regex AS (
  SELECT
    p.*, r.bucket, r.priority, 9999 AS match_len
  FROM pages p
  JOIN regex_rules r
  ON REGEXP_CONTAINS(p.host, r.pattern)
),

generic_ccgov AS (
  SELECT
    p.*,
    m.bucket,
    21 AS priority,     -- below your explicit host_rules (22–24), above many locals
    9998 AS match_len
  FROM pages p
  JOIN cc_map m
  ON REGEXP_EXTRACT(
       p.host,
       r'^(?:[a-z0-9-]+\.)*(?:gov|gouv|gob|go|govt|gv|nic|mil|govern)\.([a-z]{2,3})$'
     ) = m.tld
),

-- 6) Union matches and pick best … (add generic_ccgov to the UNION)
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
)

SELECT
  bucket,
  FORMAT('%.1f%%', 100 * AVG(perf)) AS avg_performance,
  FORMAT('%.1f%%', 100 * AVG(a11y)) AS avg_accessibility,
  FORMAT('%.1f%%', 100 * AVG(bp))   AS avg_best_practices,
  FORMAT('%.1f%%', 100 * AVG(seo))  AS avg_seo,
  COUNT(*)                          AS total_pages
FROM ranked
WHERE rn = 1
GROUP BY bucket
ORDER BY AVG(a11y) DESC;
