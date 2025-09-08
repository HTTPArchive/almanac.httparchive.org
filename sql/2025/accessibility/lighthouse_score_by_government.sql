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
('gov.nu.ca','Canada',23),('assembly.nu.ca','Canada',23),

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
('ft.dk','Denmark',24),('stm.dk','Denmark',24),('regeringen.dk','Denmark',24),('folketinget.dk','Denmark',24),('borger.dk','Denmark',24),('politi.dk','Denmark',24),('skat.dk','Denmark',24),
-- Denmark – ministries (current & stable hostnames)
('fm.dk','Denmark',24),('um.dk','Denmark',24),('jm.dk','Denmark',24),('fmn.dk','Denmark',24),('kefm.dk','Denmark',24),('sum.dk','Denmark',24),('kum.dk','Denmark',24),('ufm.dk','Denmark',24),('uvm.dk','Denmark',24),('bm.dk','Denmark',24),('skm.dk','Denmark',24),('em.dk','Denmark',24),('trm.dk','Denmark',24),('fvm.dk','Denmark',24),('uim.dk','Denmark',24),('sm.dk','Denmark',24),('digst.dk','Denmark',24),('km.dk','Denmark',24),('mssb.dk','Denmark',24),('urm.dk','Denmark',24),
-- Denmark – key agencies & authorities
('norden.dk','Denmark',23),('miljoeogfoedevarer.dk','Denmark',23),('arbejdstilsynet.dk','Denmark',23),('forsvaret.dk','Denmark',23),('dr.dk','Denmark',23),('dst.dk','Denmark',23),('sikkerdigital.dk','Denmark',23),('nemlog-in.dk','Denmark',23),('mitid.dk','Denmark',23),('nemkonto.dk','Denmark',23),('stps.dk','Denmark',23),('dataetiskraad.dk','Denmark',23),('at.dk','Denmark',23),
-- Denmark – municipalities (sample major ones)
('kk.dk','Denmark',22),('aarhus.dk','Denmark',22),('odense.dk','Denmark',22),('aalborg.dk','Denmark',22),('esbjerg.dk','Denmark',22),('randers.dk','Denmark',22),('kolding.dk','Denmark',22),('vejle.dk','Denmark',22),('horsens.dk','Denmark',22),('roskilde.dk','Denmark',22),

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
('bund.de','Germany',24),('bundesregierung.de','Germany',24),('bundesrat.de','Germany',24), ('bundestag.de','Germany',24),('bundesverfassungsgericht.de','Germany',24),('bundesgerichtshof.de','Germany',24), ('bundesverwaltungsgericht.de','Germany',24),('bundesfinanzhof.de','Germany',24),('bundessozialgericht.de','Germany',24), ('bundesarbeitsgericht.de','Germany',24),('bundesnetzagentur.de','Germany',24),('bundespolizei.de','Germany',24), ('polizei.de','Germany',24),('bmi.bund.de','Germany',24),('auswaertiges-amt.de','Germany',24),
-- Germany – Länder (state portals)
('bayern.de','Germany',23),('berlin.de','Germany',23),('brandenburg.de','Germany',23), ('bremen.de','Germany',23),('hamburg.de','Germany',23),('hessen.de','Germany',23), ('mecklenburg-vorpommern.de','Germany',23),('niedersachsen.de','Germany',23), ('nrw.de','Germany',23),('land.nrw','Germany',24),('rlp.de','Germany',23), ('saarland.de','Germany',23),('sachsen.de','Germany',23),('sachsen-anhalt.de','Germany',23), ('schleswig-holstein.de','Germany',23),('thueringen.de','Germany',23),
-- Germany – ministries (examples from TSV)
('bmf.bund.de','Germany',24),('bmj.de','Germany',24),('bmwi.de','Germany',24), ('bmbf.de','Germany',24),('bmvg.de','Germany',24),('bmas.de','Germany',24), ('bmfsfj.de','Germany',24),('bmel.de','Germany',24),('bmuv.de','Germany',24),
-- Germany – judiciary & agencies (from TSV)
('bverwg.de','Germany',24),('bundeskartellamt.de','Germany',24),('bundesbank.de','Germany',24), ('destatis.de','Germany',24),('rki.de','Germany',24),('pei.de','Germany',24),
-- Germany – embassies (patterned in diplo.de subdomains)
('nigeria.diplo.de','Germany',21),('tuerkei.diplo.de','Germany',21), ('harare.diplo.de','Germany',21),('tallinn.diplo.de','Germany',21), ('brasil.diplo.de','Germany',21),

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
('luxembourg.lu','Luxembourg',24),('etat.lu','Luxembourg',24),('public.lu','Luxembourg',24),('data.public.lu','Luxembourg',24),('service-public.lu','Luxembourg',24),
-- Luxembourg – ministries
('mfin.gouvernement.lu','Luxembourg',23),('maee.gouvernement.lu','Luxembourg',23),('mjustice.gouvernement.lu','Luxembourg',23),('meco.gouvernement.lu','Luxembourg',23),('mint.gouvernement.lu','Luxembourg',23),('mtes.gouvernement.lu','Luxembourg',23),('mss.gouvernement.lu','Luxembourg',23),('mcr.gouvernement.lu','Luxembourg',23),('mfamigr.gouvernement.lu','Luxembourg',23),('msh.gouvernement.lu','Luxembourg',23),
-- Luxembourg – agencies & authorities
('cns.lu','Luxembourg',23),('statec.lu','Luxembourg',23),('legilux.public.lu','Luxembourg',23),('ces.lu','Luxembourg',23),('education.lu','Luxembourg',23),('secu.lu','Luxembourg',23),
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
('overheid.nl','Netherlands',24),('rijksoverheid.nl','Netherlands',24),
('belastingdienst.nl','Netherlands',24),('politie.nl','Netherlands',24),
('kvk.nl','Netherlands',24),('cbs.nl','Netherlands',24),('rvo.nl','Netherlands',24),
('rijkshuisstijl.nl','Netherlands',24),('rijksoverheid.nl','Netherlands',24),
('rechtspraak.nl','Netherlands',24),('wetten.overheid.nl','Netherlands',24),
('kamer.nl','Netherlands',24),('eerstekamer.nl','Netherlands',24),
('tweedekamer.nl','Netherlands',24), ('mijnoverheid.nl','Netherlands',24),

-- New Zealand – federal anchors & key institutions
('govt.nz','New Zealand',24),('parliament.nz','New Zealand',24),
('justice.govt.nz','New Zealand',24),('treasury.govt.nz','New Zealand',24),
('health.govt.nz','New Zealand',24),('education.govt.nz','New Zealand',24),
('police.govt.nz','New Zealand',24),

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

-- United Kingdom – central government & devolved administrations
('gov.uk','United Kingdom (UK)',24),('service.gov.uk','United Kingdom (UK)',24),
-- UK – key agencies & sectors
('mod.uk','United Kingdom (UK)',23),('nhs.uk','United Kingdom (UK)',23),('police.uk','United Kingdom (UK)',23),
-- UK – devolved governments
('gov.scot','United Kingdom (UK)',23),('gov.wales','United Kingdom (UK)',23),('llyw.cymru','United Kingdom (UK)',23),

-- Uruguay – federal anchors & portals
('gub.uy','Uruguay',24),('uruguay.gub.uy','Uruguay',24),('parlamento.gub.uy','Uruguay',24),
('presidencia.gub.uy','Uruguay',24),('ministerio.gub.uy','Uruguay',24),('poderjudicial.gub.uy','Uruguay',24),

-- Costa Rica – federal anchors & portals
('go.cr','Costa Rica',24),('presidencia.go.cr','Costa Rica',24),('ministeriodesalud.go.cr','Costa Rica',24), ('mep.go.cr','Costa Rica',24),('hacienda.go.cr','Costa Rica',24),('racsa.go.cr','Costa Rica',24), ('cgr.go.cr','Costa Rica',24),('ccss.sa.cr','Costa Rica',24),
-- Costa Rica – legislature & judiciary
('asamblea.go.cr','Costa Rica',24),('poder-judicial.go.cr','Costa Rica',24),('corte.go.cr','Costa Rica',24),
-- Costa Rica – municipalities (sample)
('muni.go.cr','Costa Rica',23),('munisanjose.go.cr','Costa Rica',23),('munialajuela.go.cr','Costa Rica',23), ('municartago.go.cr','Costa Rica',23),('muniheredia.go.cr','Costa Rica',23),

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




    -- USA (federal extras + state.xx.us families)
    ('si.edu','United States (USA)',24),
    ('usps.com','United States (USA)',24),
    ('dau.edu','United States (USA)',24),
    -- common state .* domains you called out (more handled by regex below)
    ('state.mi.us','United States (USA)',23),
    ('sos.state.mi.us','United States (USA)',24),
    ('msp.state.mi.us','United States (USA)',24),
    ('state.in.us','United States (USA)',23),
    ('state.mn.us','United States (USA)',23)




  ])
),

-- 2) Regex rules for families that aren’t just suffixes
regex_rules AS (
  SELECT * FROM UNNEST([
    -- US state portals like *.state.xx.us (generic)
    STRUCT(r'(^|\.)(?:[a-z0-9-]+\.)*state\.[a-z]{2}\.us$' AS pattern, 'United States (USA)' AS bucket, 22 AS priority),

    -- Luxembourg family (from your pattern)
    (r'(^|\.)(?:public|gov|etat|data|service|security|mfi|lux)(?:\.public|\.gov|\.etat)?\.lu$', 'Luxembourg', 24),

    -- Plain .gov / .mil TLDs (federal)
    (r'\.gov$', 'United States (USA)', 21),
    (r'\.mil$', 'United States (USA)', 21),


(r'(^|\.)(?:stadt|gemeinde|verbandsgemeinde|vg|amt|landkreis|kreis|bezirksamt|kreisverwaltung|kreisstadt|rathaus)[-.].*\.de$', 'Germany', 20),
(r'(^|\.).*-?(?:stadt|gemeinde|amt|landkreis|kreis)(?:\.[a-z0-9-]+)?\.de$', 'Germany', 19),
(r'(^|\.)(?:polizei|justiz|innenministerium|finanzministerium|wirtschaftsministerium|kultusministerium|sozialministerium|verkehrsministerium|verfassungsschutz|rechnungshof)\.?.*\.de$', 'Germany', 20),
(r'(^|\.)(?:landkreis|kreis|bezirk)[-.].*\.de$', 'Germany', 19),
(r'(^|\.)(?:xn--)[a-z0-9-]+\.de$', 'Germany', 16),
(r'(^|\.)[a-z0-9-]+\.gc\.ca$', 'Canada', 22),
(r'(^|\.)gov\.(ab|bc|mb|nb|nl|ns|nt|nu|on|pe|qc|sk|yk)\.ca$', 'Canada', 22),
(r'(^|\.)(?:[a-z0-9-]+\.)*diplo\.de$', 'Germany', 21),
(r'(^|\.)(gov|nic)\.in$', 'India', 21),
(r'(^|\.)[a-z0-9-]+\.go\.id$', 'Indonesia', 20),
(r'(^|\.)([a-z0-9-]+coco\.ie|[a-z0-9-]+council\.ie)$', 'Ireland', 21),
(r'(^|\.)([a-z0-9-]+\.lv)$', 'Latvia', 21),
(r'(^|\.)([a-z0-9-]+\.lu)$','Luxembourg',21),
(r'(^|\.)(?:[a-z0-9-]+)\.gov\.my$', 'Malaysia', 22),
(r'(^|\.)(?:[a-z0-9-]+\.){2,}gov\.my$', 'Malaysia', 21),
(r'(^|\.)(?:[a-z0-9-]+)\.(gov|mil)\.np$', 'Nepal',22),
(r'(^|\.)(?:[a-z0-9-]+)\.gov\.ma$', 'Morocco',22),
(r'(^|\.)(?:[a-z0-9-]+)\.gov\.mt$', 'Malta',22),
(r'(^|\.)[a-z0-9-]+\.overheid\.nl$', 'Netherlands',22),
(r'(^|\.)[a-z0-9-]+\.rijksoverheid\.nl$', 'Netherlands',22),
(r'(^|\.)[a-z0-9-]+\.gov\.nl$', 'Netherlands',22),
(r'(^|\.)gemeente[a-z0-9-]*\.nl$', 'Netherlands',21),   -- municipalities like gemeente-amsterdam.nl
(r'(^|\.)provincie[a-z0-9-]*\.nl$', 'Netherlands',21),   -- provinces like provincie-utrecht.nl
(r'(^|\.)[a-z0-9-]+\.govt\.nz$', 'New Zealand',22),
(r'(^|\.)[a-z0-9-]+\.parliament\.nz$', 'New Zealand',22),
(r'(^|\.)[a-z0-9-]+\.health\.nz$', 'New Zealand',22),
(r'(^|\.)[a-z0-9-]+\.no$', 'Norway',22),
(r'(^|\.)gov\.pt$', 'Portugal',22),
(r'(^|\.)muni\.[a-z0-9-]+\.pt$', 'Portugal',21),   -- municipalities using muni.*
(r'(^|\.)cm-[a-z0-9-]+\.pt$', 'Portugal',21),      -- Câmara Municipal (city councils)
(r'(^|\.)([a-z0-9-]+)\.cm\.pt$', 'Portugal',21),    -- alternate Câmara Municipal form
(r'(^|\.)[a-z0-9-]+\.gov\.ph$', 'Philippines',22),   -- generic agencies
(r'(^|\.)[a-z0-9-]+\.lgu\.gov\.ph$', 'Philippines',21), -- LGUs (local government units)
(r'(^|\.)[a-z0-9-]+\.edu\.ph$', 'Philippines',20),    -- some state universities/colleges
(r'(^|\.)[a-z0-9-]+\.gob\.pe$', 'Peru',22),    -- national ministries/agencies
(r'(^|\.)[a-z0-9-]+\.region\.gob\.pe$', 'Peru',21), -- regional governments
(r'(^|\.)[a-z0-9-]+\.muni\.gob\.pe$', 'Peru',20),   -- municipal governments
(r'(^|\.)[a-z0-9-]+\.gov\.ru$', 'Russia',22),   -- federal & regional gov
(r'(^|\.)[a-z0-9-]+\.edu\.ru$', 'Russia',21),   -- state universities/institutes
(r'(^|\.)[a-z0-9-]+\.mil\.ru$', 'Russia',21),   -- Ministry of Defence and units
-- (r'(^|\.)[a-z0-9-]+\.ru$', 'Russia',19)         -- catch-all (caution: may overmatch)
(r'(^|\.)[a-z0-9-]+\.gov\.sg$', 'Singapore',22),
(r'(^|\.)[a-z0-9-]+\.gov\.za$', 'South Africa',22),
(r'(^|\.)[a-z0-9-]+\.gov\.ua$', 'Ukraine',22),
(r'(^|\.)[a-z0-9-]+\.rada\.gov\.ua$', 'Ukraine',22),
(r'(^|\.)[a-z0-9-]+\.admin\.ch$', 'Switzerland',22),
(r'(^|\.)[a-z0-9-]+\.ch$', 'Switzerland',18),
(r'(^|\.)[a-z0-9-]+\.gov\.se$', 'Sweden',22),
(r'(^|\.)[a-z0-9-]+\.kommun\.se$', 'Sweden',21),  -- municipalities
(r'(^|\.)[a-z0-9-]+\.region\.se$', 'Sweden',21),  -- regions
-- (r'(^|\.)[a-z0-9-]+\.se$', 'Sweden',18)           -- fallback for .se
(r'(^|\.)[a-z0-9-]+\.gov\.uk$', 'United Kingdom (UK)',22),
(r'(^|\.)[a-z0-9-]+\.nhs\.uk$', 'United Kingdom (UK)',22),
(r'(^|\.)[a-z0-9-]+\.police\.uk$', 'United Kingdom (UK)',22),
(r'(^|\.)([a-z0-9-]+\.)*gub\.uy$', 'Uruguay',22),
(r'(^|\.)([a-z0-9-]+)\.go\.cr$', 'Costa Rica',22),
(r'(^|\\.)[a-z0-9-]+\\.gob\\.es$','Spain',22),
(r'(^|\\.)(?:ayto|ayuntamiento|diputacion(?:de)?|cabildo|consell)[-.][a-z0-9-]+\\.es$','Spain',20)

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

-- 6) Union matches and pick best (higher priority, then longest suffix)
all_matches AS (
  SELECT * FROM match_suffix
  UNION ALL
  SELECT * FROM match_regex
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
