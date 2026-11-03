---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Üçüncü Taraflar
description: Web Almanac 2025 Üçüncü Taraflar bölümü; web üzerinde hangi üçüncü tarafların kullanıldığına dair verileri ve üçüncü taraf dahil etme zincirlerinin analizini kapsıyor.
hero_alt: Web Almanac karakterlerinin bir web sayfasına çeşitli şeyler taktığı kapak görseli.
authors: [jazlan01, abubakaraziz]
reviewers: [tunetheweb]
analysts: [jazlan01]
editors: [tunetheweb]
translators: [MuslumYilmaz]
jazlan01_bio: Muhammad Jazlan, Kaliforniya Üniversitesi Davis kampüsünde Bilgisayar Bilimi alanında doktora eğitiminin ikinci yılındadır. Araştırmaları web üzerindeki izlemenin ölçülmesine, tespit edilmesine ve azaltılmasına odaklanıyor.
abubakaraziz_bio: Muhammad Abu Bakar Aziz, Boston'daki Northeastern Üniversitesi'nde Bilgisayar Bilimi alanında doktora adayıdır. Araştırmaları web gizliliğine odaklanıyor. Özellikle üçüncü tarafların ve çevrim içi reklamverenlerin CCPA ve GDPR gibi gizlilik yasalarına nasıl uyduğunu ampirik olarak ölçüyor.
results: https://docs.google.com/spreadsheets/d/1FPssodcLgX8iFWFXDrthWVkBCUTl5_IJon2cyaZVudU/edit
featured_quote: İlk 10 üçüncü taraf alan adına Google hâkim.
featured_stat_1: %90
featured_stat_label_1: En az bir üçüncü taraf içeren sayfalar
featured_stat_2: 16
featured_stat_label_2: Bir sayfadaki üçüncü taraf alan adı sayısının medyanı
featured_stat_3: %18
featured_stat_label_3: TCF Standardını kullanan web sitelerinin yüzdesi
doi: 10.5281/zenodo.18246420
---

## Giriş

Üçüncü taraflar web'in her yerinde. Web sitesi geliştiricileri reklam, analitik, sosyal medya entegrasyonu, ödeme işleme ve içerik dağıtımı gibi temel özellikleri hayata geçirmek için üçüncü taraflara dayanıyor. Bu modüler yaklaşım, zengin işlevlerin verimli ve hızlı biçimde devreye alınmasını sağlıyor. Ancak gizlilik, güvenlik ve performans açısından olası sorunları da beraberinde getiriyor. Bu yıl ilk kez, kullanıcıların rıza tercihlerinin web'deki üçüncü taraflar arasında nasıl aktarıldığını da analiz ediyoruz; kullanılan rıza çerçevelerini ve bu sinyalleri alan üçüncü tarafları da bu analize dahil ediyoruz.

Bu bölümde, web'deki üçüncü taraf kullanım örüntülerini ampirik olarak analiz ediyoruz. İncelediğimiz başlıklar şunlar:

- **Yaygınlık:** Kaç web sitesinin üçüncü taraf kullandığı ve bunların oranları
- **Kaynak türleri:** Üçüncü tarafların aldığı biçimler (görseller, JavaScript, yazı tipleri vb.)
- **İşlevsel kategoriler:** Reklam ağları, analitik, CDN'ler, video sağlayıcıları, etiket yöneticileri ve diğerleri
- **Entegrasyon yöntemleri:** Üçüncü tarafların sayfalara doğrudan veya dolaylı olarak nasıl yüklendiği
- **Rıza altyapısı:** Hangi üçüncü tarafların rıza sinyallerini aktardığı ve bu aktarımların uygulamada nasıl gerçekleştiği

## Tanımlar

Öncelikle, analizimiz boyunca kullanılan bazı tanımları ve terimleri belirliyoruz.

### Siteler ve sayfalar

Bu bölümde, önceki yıllarda olduğu gibi, site terimini belirli bir alan adının kayıt ettirilebilir kısmını ifade etmek için kullanıyoruz; bu kısım genellikle *genişletilmiş üst düzey alan adı artı bir* (<i lang="en">extended Top Level Domain plus one</i>, eTLD+1) olarak adlandırılır. Örneğin `https://www.bar.com/` URL'si için eTLD+1 `bar.com`, `https://foo.co.uk` URL'si için ise `foo.co.uk` olur. Sayfa (veya web sayfası) derken benzersiz bir URL'yi ya da daha açık bir ifadeyle o URL'de bulunan belgeyi (örneğin HTML veya JavaScript) kastediyoruz.

### Üçüncü taraf nedir?

Önceki sürümlerle karşılaştırma yapılabilmesi için Web Almanac'ın geçmiş baskılarında kullanılan üçüncü taraf tanımına bağlı kalıyoruz.

_Üçüncü taraf_, site sahibinden (birinci taraf olarak da bilinir) farklı bir varlıktır. Sitenin doğrudan site sahibi tarafından oluşturulmayan ve sunulmayan yönlerini kapsar. Daha açık söylemek gerekirse üçüncü taraf içeriği, kullanıcının asıl ziyaret ettiği siteden değil, başka bir siteden yüklenir. Kullanıcının `example.com` sitesini (birinci taraf) ziyaret ettiğini ve `example.com` sitesinin `awesome-cats.edu` sitesinden komik kedi görselleri yüklediğini (örneğin bir `<img>` etiketiyle) varsayalım. Bu durumda `awesome-cats.edu` üçüncü taraftır, çünkü kullanıcı başlangıçta bu siteyi ziyaret etmemiştir. Ancak kullanıcı `awesome-cats.edu` sitesini doğrudan ziyaret ederse `awesome-cats.edu` birinci taraf olur.

Analizimize yalnızca, kaynakları HTTP Archive veri kümesinde en az beş benzersiz sayfada bulunabilen bir alan adından gelen üçüncü taraflar dahil edildi.

Üçüncü taraf içeriği doğrudan birinci taraf alan adından sunulduğunda birinci taraf içeriği olarak sayılır. Örneğin kendi sunucusunda barındırılan analitik betikleri, CSS veya yazı tipleri birinci taraf içeriği olarak sayılır. Benzer şekilde, üçüncü taraf alan adından sunulan birinci taraf içeriği de üçüncü taraf içeriği olarak sayılır. Bazı üçüncü taraflar içeriklerini farklı alt alan adlarından sunar. Ancak alt alan adı sayısından bağımsız olarak bunlar tek bir üçüncü taraf olarak sayılır.

Ayrıca üçüncü tarafların birinci taraf gibi gösterilmesi giderek yaygınlaşıyor. Bunu iki temel teknik mümkün kılıyor:

- **CNAME gizleme** (<i lang="en">CNAME cloaking</i>), üçüncü tarafın içeriğini birinci taraf alan adından geliyormuş gibi göstermek için bir CNAME kaydı kullanır. Bu analizde CNAME ile gizlenen hizmetleri birinci taraf olarak kabul ediyoruz.

- **Sunucu taraflı izleme** (<i lang="en">server-side tracking</i>), site sahibinin izleyiciyi (<i lang="en">tracker</i>) birinci taraf olarak gömdüğü ve tüm istekleri birinci taraf alan adı üzerinden yönlendirerek izleyiciyi birinci taraf gibi gösterdiği, yeni yeni yaygınlaşan bir eğilimdir. Örneğin `www.example.com` adlı bir web sitesi, Google Analytics ile birlikte sunucu taraflı Google Tag Manager'ı gömebilir ve istekleri bir Google Tag Manager kapsayıcısına göndermek için `sst.example.com` alt alan adını gizleyebilir. Bu şekilde üçüncü taraflara giden istekler kullanıcının tarayıcısından değil, etiket yöneticisinin sunucusundan çıkar.

Analizimizde bu tür durumları birinci taraf etkileşimi olarak ele alıyoruz, çünkü üçüncü taraf iletişimi sunucudan sunucuya gerçekleşiyor ve istemci tarafındaki HTTP Archive verilerinde doğrudan gözlemlenemiyor. Bu nedenle ölçümlerimiz, üçüncü tarafların web'deki gerçek yaygınlığının alt sınırını temsil ediyor.

## Kategoriler

Daha önce belirtildiği gibi, üçüncü taraflar çeşitli kullanım senaryolarında, örneğin video eklemek, reklam sunmak veya sosyal medya sitelerinden içerik almak için kullanılabilir. Önceki yılda olduğu gibi, veri kümemizde gözlemlenen üçüncü tarafları kategorilere ayırmak için <a hreflang="en" href="https://x.com/patrickhulce">Patrick Hulce</a> tarafından geliştirilen <a hreflang="en" href="https://github.com/patrickhulce/third-party-web/#third-parties-by-category">Third-Party Web</a> deposuna başvuruyoruz. Depo, üçüncü tarafları aşağıdaki kategorilere ayırıyor:

- **Reklam (<i lang="en">Ad</i>):** Bu betikler, reklam sunan veya ölçen reklam ağlarının parçasıdır.
- **Analitik (<i lang="en">Analytics</i>):** Bu betikler kullanıcıları ve eylemlerini ölçer veya izler. Neyin izlendiğine bağlı olarak etkileri büyük ölçüde değişir.
- **CDN:** Bunlar, farklı genel CDN'ler üzerinden sunulan, herkese açık barındırılan açık kaynaklı kütüphaneler (örneğin jQuery) ile özel CDN kullanımının bir karışımıdır.
- **İçerik (<i lang="en">Content</i>):** Bu betikler içerik sağlayıcılardan veya yayıncılığa özgü satış ortaklığı izlemesinden gelir.
- **Müşteri Başarısı (<i lang="en">Customer Success</i>):** Bu betikler, sohbet ve iletişim çözümleri sunan müşteri desteği/pazarlama sağlayıcılarından gelir. Genellikle daha ağırdırlar.
- **Barındırma (<i lang="en">Hosting</i>):** Bu betikler web barındırma platformlarından gelir (WordPress, Wix, Squarespace vb.).
- **Pazarlama (<i lang="en">Marketing</i>):** Bu betikler, açılır pencereler/bültenler vb. ekleyen pazarlama araçlarından gelir.
- **Sosyal (<i lang="en">Social</i>):** Bu betikler sosyal özellikleri etkinleştirir.
- **Etiket Yöneticisi (<i lang="en">Tag Manager</i>):** Bu betikler genellikle başka birçok betiği yükler ve birçok görev başlatır.
- **Yardımcı Araçlar (<i lang="en">Utility</i>):** Bu betikler geliştirici yardımcı araçlarıdır (API istemcileri, site izleme, dolandırıcılık tespiti vb.).
- **Video:** Bu betikler video oynatıcı ve akış işlevlerini sağlar.
- **Rıza sağlayıcı (<i lang="en">Consent provider</i>):** Bu betikler sitelerin kullanıcı rızasını yönetmesini sağlar (örneğin [Genel Veri Koruma Tüzüğü](https://tr.wikipedia.org/wiki/Genel_Veri_Koruma_Tüzüğü) (GDPR) uyumluluğu için). _Çerez Rızası_ (<i lang="en">Cookie Consent</i>) açılır pencereleri olarak da bilinirler ve genellikle kritik yolda yüklenirler.
- **Diğer (<i lang="en">Other</i>):** Bunlar, ortak bir köken üzerinden sunulan, net bir kategorisi veya atfı olmayan çeşitli betiklerdir.

### `Content-Type`

Üçüncü taraf kaynaklarını betikler, HTML içerik, JSON verileri, düz metin ve görseller gibi farklı türlere ayırmak için [`Content-Type`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) HTTP başlığını kullanıyoruz. Bu sayede web sitelerinde sunulan üçüncü taraf kaynaklarının bileşimini analiz edebiliyoruz.

## Yaygınlık

{{ figure_markup(
  image="pages-using-at-least-one-3p.png",
  caption="Bir veya daha fazla üçüncü taraf kullanan sayfaların yüzdesi.",
  description="Farklı sıralama gruplarında en az bir üçüncü taraf kullanan sayfaların yüzdesini gösteren çubuk grafik. Sıralama gruplarının genelinde sayfaların yaklaşık %90-92'si üçüncü taraf kullanıyor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=249114645&format=interactive",
  sheets_gid="1741089577",
  sql_file="percent_of_websites_with_third_party_by_ranking.sql"
  )
}}

<a hreflang="en" href="../2024/third-parties#prevalence">Önceki yıla</a> kıyasla, web sitelerinde bir veya daha fazla üçüncü taraf kullanan sayfaların yüzdesinde hafif bir düşüş görüyoruz. Ancak bu düşüşe rağmen, bir veya daha fazla üçüncü taraf içeren sayfaların yüzdesi %90 veya üzerinde kalmaya devam ediyor.

{{ figure_markup(
  image="num-3p-by-rank.png",
  caption="Sıralamaya göre üçüncü taraf sayısının dağılımı.",
  description="Sıralama gruplarına göre üçüncü taraf sayısının dağılımını gösteren çubuk grafik. Sıralama grubu büyüdükçe üçüncü taraf sayısı azalıyor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=211745165&format=interactive",
  sheets_gid="199539546",
  sql_file="number_of_third_parties_by_rank.sql"
  )
}}

Önceki yıla kıyasla, tüm web sitesi sıralamalarında üçüncü taraf alan adı sayısının medyanında önemli bir düşüş görüyoruz; düşüş özellikle üst sıralardaki web sitelerinde çok daha büyük.

Bu düşüşün birkaç nedeni olabilir. İlk olarak, üçüncü taraflar `CNAME` gizleme ve sunucu taraflı izleme yoluyla giderek daha fazla gizleniyor; bu da istemci tarafı ölçümlerde görünürlüklerini azaltabilir. İkinci olarak, HTTP Archive'ın tarama botları (<i lang="en">crawler</i>) web sayfalarıyla etkileşime girmiyor ve sayfayı aşağı kaydırmıyor; bu da gecikmeli yükleme (<i lang="en">lazy loading</i>) nedeniyle bazı üçüncü tarafların düzgün yüklenmesini engelleyebilir. Sonuç olarak daha az üçüncü taraf isteği gözlemlenebilir.

Ayrıca masaüstü sayfaların genellikle mobil sayfalardan daha fazla üçüncü taraf içerdiğini görüyoruz.

{{ figure_markup(
  image="num-3p-req-per-page-by-rank.png",
  caption="Sıralamaya göre sayfa başına üçüncü taraf isteği sayısının dağılımı.",
  description="Sıralamaya göre sayfa başına üçüncü taraf isteği sayısının medyanını gösteren çubuk grafik. Sayfa başına üçüncü taraf isteği sayısı ilk 1 bin grubundan ilk 10 bin grubuna doğru artıyor, daha büyük sıralama gruplarında ise azalıyor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1763082827&format=interactive",
  sheets_gid="641162136",
  sql_file="number_of_third_party_requests_per_page_by_rank.sql"
  )
}}

Üst sıralardaki web siteleri daha fazla üçüncü taraf isteği yüklüyor. İlk 1.000 sitede medyan masaüstünde 129, mobilde 106 istekken, tüm sitelerde bu sayı masaüstünde 83, mobilde 79.

Yıllık bazda, üçüncü taraf istekleri tüm sıralamalarda arttı. İlk 1.000 site, <a hreflang="en" href="../2024/third-parties#fig-3">2024'e kıyasla</a> masaüstünde 15, mobilde 15 istek artış gösterirken, daha geniş veri kümesinde artış masaüstünde beş, mobilde beş istek oldu. Bu yukarı yönlü eğilim, daha önce gözlemlediğimiz benzersiz üçüncü taraf alan adı sayısındaki düşüşe rağmen ortaya çıkıyor; bu da tek tek üçüncü tarafların sayfa başına daha fazla istek gönderdiğini düşündürüyor.

{{ figure_markup(
  image="3p-req-categories-by-rank.png",
  caption="Sıralamaya göre üçüncü taraf isteği kategorilerinin dağılımı.",
  description="Sıralama gruplarına göre üçüncü taraf kategorilerinin dağılımını gösteren çubuk grafik. En üst kategoriler ad, analytics ve cdn.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1133634663&format=interactive",
  sheets_gid="445864775",
  sql_file="number_of_third_party_providers_by_rank_and_category.sql"
  )
}}

Çubuk grafik, sıralama ve kategoriye göre sayfa başına üçüncü taraf sağlayıcı sayısının medyanını gösteriyor. Önceki baskıda bu analiz, sıralama ve kategoriye göre sayfa başına üçüncü taraf alan adı sayısına odaklanıyordu; bu yıl ise benzersiz üçüncü taraf sağlayıcı sayısını ölçüyoruz, bu da genel olarak daha düşük sayılarla sonuçlanıyor. Bu yıl en üst kategoriler `ad`, `analytics` ve `cdn`.

{{ figure_markup(
  image="3p-req-types-by-rank.png",
  caption="Sıralamaya göre üçüncü taraf isteği türlerinin dağılımı.",
  description="Üçüncü taraf isteklerinin içerik türüne göre yüzde dağılımını gösteren pasta grafik. İlk 3 içerik türü `script` (%24,8), `image` (%19,9) ve other (%13,9)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1309978891&format=interactive",
  sheets_gid="418010554",
  sql_file="percent_of_third_parties_by_content_type.sql"
  )
}}

Grafik, üçüncü taraf isteklerinde `script`, `image` ve `other` kategorisinin baskın olduğunu gösteriyor. `script`, `image` ve `other` birlikte tüm üçüncü taraf isteği içerik türlerinin yarısından fazlasını oluşturuyor. Bu örüntü, yine `script`, `image` ve `other` türlerini en üst istek türleri olarak belirleyen <a hreflang="en" href="../2024/third-parties#fig-5">2024 baskısıyla</a> tutarlı; yani geçen yıldan bu yana çok az değişiklik var.

{{ figure_markup(
  image="top-3p-by-num-pages.png",
  caption="Sayfa sayısına göre en yaygın üçüncü taraflar.",
  description="Bulundukları sayfaların yüzdesine göre en yaygın üçüncü tarafları gösteren çubuk grafik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=194077318&format=interactive",
  sheets_gid="803451847",
  sql_file="top100_third_parties_by_number_of_websites.sql",
  width=600,
  height=498
  )
}}

İlk 10 üçüncü taraf alan adına `fonts.googleapis.com`, `googletagmanager.com`, `google-analytics.com`, `accounts.google.com` ve `adservice.google.com` gibi Google'a ait hizmetler hâkim. Meta'ya ait `facebook.com`, ilk 10'daki Google dışı tek alan adı; sayfaların %21'inde bulunarak 7. sırada yer alıyor.

## Üçüncü taraflar arasında rıza aktarımı

Bu bölümde, farklı üçüncü tarafların kullanıcı rızasını web genelinde nasıl ilettiğini inceliyoruz. <a hreflang="en" href="https://petsymposium.org/popets/2024/popets-2024-0120.pdf">Önceki araştırmalar</a>, üçüncü tarafların rıza bilgilerini iletmek için sıklıkla sektör standardı çerçevelere dayandığını gösteriyor. Analizimizde ağırlıklı olarak IAB'nin üç rıza standardına odaklanıyoruz: <a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">Şeffaflık ve Rıza Çerçevesi (TCF)</a>, <a hreflang="en" href="https://iabtechlab.com/standards/ccpa/">CCPA Çerçevesi</a> ve <a hreflang="en" href="https://iabtechlab.com/gpp/">Küresel Gizlilik Protokolü (GPP)</a>.

Bu çerçeveler, rıza bilgilerinin nasıl kodlanacağını ve web siteleri ile üçüncü taraflar arasında nasıl paylaşılacağını tanımlar. İşe, veri kümemizde gözlemlenen üçüncü taraflar arasında en yaygın rıza standartlarını belirleyerek başlıyoruz. Bir üçüncü tarafın hangi çerçeveyi kullandığını belirlemek için istek URL'lerinde belirli parametrelerin bulunup bulunmadığına bakıyoruz. Farklı standartların ayrıntıları aşağıda:

- **TCF Standardı**: TCF çerçevesinin kullanımını, üçüncü taraf isteğinin IAB TCF'de belirtildiği gibi `gdpr` veya `gdpr_consent` parametrelerini içerip içermediğini kontrol ederek tespit ediyoruz.

- **GPP Standardı**: GPP çerçevesinin kullanımını, `gpp` ve `gpp_sid` parametrelerinin varlığını kontrol ederek tespit ediyoruz.

- **USP Standardı ve standart dışı USP**: USP Standardının kullanımını, bir isteğin IAB CCPA Çerçevesinde tanımlandığı şekilde `us_privacy` parametresi iletip iletmediğini kontrol ederek tespit ediyoruz. Standart dışı USP kullanımını ise <a hreflang="en" href="https://petsymposium.org/popets/2024/popets-2024-0120.pdf">önceki çalışmada</a> belirlenen standart dışı parametreler üzerinden iletilen rıza dizelerini saptayarak belirliyoruz.

Rıza sinyallerinin yaygınlığını web sitesi sıralamaları, üçüncü taraf kategorileri ve en sık gözlemlenen rıza sinyali alan üçüncü taraflar açısından analiz ediyoruz.

### Farklı sıralamalarda rıza sinyallerinin yaygınlığı

{{ figure_markup(
  image="consent-signal-prevalence-by-rank.png",
  caption="Sıralamaya göre rıza sinyallerinin yaygınlığı.",
  description="Üçüncü taraf isteklerindeki farklı rıza standartlarının web sitesi sıralamalarına göre yaygınlığını gösteren çubuk grafik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=2066656520&format=interactive",
  sheets_gid="1614774531",
  sql_file="consent_signal_prevalence_by_third_party_category.sql"
  )
}}

TCF Standardının baskın rıza standardı olduğunu görüyoruz; özellikle üst sıralardaki sitelerde, tüm sitelerdeki %18'e kıyasla %36'ya ulaşıyor. Bu yüksek benimsenme, GDPR kapsamındaki daha katı açık rıza (<i lang="en">opt-in</i>) gereklilikleriyle uyumlu. USP Standardı, sıralamalara göre %9–17 arasında değişen benimsenme oranıyla en yaygın ikinci standart. Bu, CCPA'ya yanıt olarak getirilen IAB CCPA rıza çerçevesinin kullanımını yansıtıyor. GPP'nin amacı rıza çerçevelerini yargı bölgeleri arasında birleştirmek olsa da benimsenme oranı %3–6 ile çok düşük kalmaya devam ediyor.

### Farklı kategorilerde rıza standartlarının dağılımı

{{ figure_markup(
  image="consent-signal-prevalence-by-category.png",
  caption="Kategoriye göre rıza sinyallerinin yaygınlığı.",
  description="Farklı üçüncü taraf kategorilerinde rıza standartlarının yaygınlığını gösteren çubuk grafik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=828032137&format=interactive",
  sheets_gid="1614774531",
  sql_file="consent_signal_prevalence_by_third_party_category.sql"
  )
}}

Farklı üçüncü taraf kategorilerinde farklı rıza standardı tercihleri görüyoruz. Örneğin Sosyal kategorisindeki hizmetlerde TCF benimsenme oranı en yüksekken, reklam sağlayıcıları GPP, USP Standardı ve daha küçük TCF paylarından oluşan daha dengeli bir karışım kullanıyor. Ayrıca analitik sağlayıcıları ağırlıklı olarak GPP'yi benimsiyor.

### Rıza sinyali alan önde gelen üçüncü taraflar

{{ figure_markup(
  image="consent-signal-prevalence-by-domain.png",
  caption="Alan adına göre rıza sinyallerinin yaygınlığı.",
  description="En yüksek hacimde rıza sinyali alan üçüncü tarafları gösteren çubuk grafik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=1262795614&format=interactive",
  sheets_gid="1788947788",
  sql_file="consent_signals_by_parameter_and_domain_optimized.sql"
  )
}}

Üst sıralardaki web siteleri arasında en yüksek hacimde rıza sinyalini `pubmatic.com` alıyor, `adservice.google.com` ise ikinci sırada. En fazla rıza sinyali gönderilen alan adlarının çoğu reklam ve reklam teknolojisi sağlayıcılarına ait: reklam borsaları, DSP'ler ve reklam sunucuları. Bu sezgisel olarak da anlamlı, çünkü birçok yargı bölgesinde üçüncü taraf reklam ve analitik sağlayıcıları, kullanıcı verilerini reklam ve diğer amaçlarla kullanmadan önce kullanıcı rızası almak zorunda.

## Dahil etme

Önceki örneğimizi hatırlayalım: `example.com` (birinci taraf), `awesome-cats.edu` (üçüncü taraf) sitesinden bir `<img>` etiketiyle görsel yükleyebilir. Görselin bu şekilde eklenmesi doğrudan dahil etme sayılır. Ancak görsel, sitedeki bir üçüncü taraf betiği tarafından `XMLHttpRequest` aracılığıyla yüklenseydi, bu dolaylı dahil etme sayılırdı. Dolaylı olarak dahil edilen üçüncü taraflar da başka üçüncü tarafları dahil edebilir. Örneğin siteye doğrudan dahil edilen bir üçüncü taraf betiği, başka bir üçüncü taraf betiğini de dahil edebilir. Bu bölümde, üçüncü tarafların dahil etme zincirlerinin derinliklerine ilişkin temel bir analiz yapıyoruz.

{{ figure_markup(
  image="median-depth-tp-inclusion-chains.png",
  caption="Üçüncü taraf dahil etme zincirlerinin medyan derinliği.",
  description="Dahil etme zincirinin medyan derinliğini gösteren çubuk grafik.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTrElluFB6gvlkt65HjzZMJ4PtgJ53tVnez46cBrhQNtNxUjDxvNPuS_xmlQBUmhSHZkOMAjd0bTJyr/pubchart?oid=692408075&format=interactive",
  sheets_gid="1518420053",
  sql_file="inclusion_chain.sql"
  )
}}

Dahil etme zincirinin medyan derinliği 3'tür; bu, üçüncü tarafların çoğunun bir web sayfasında en az bir başka üçüncü tarafı dahil ettiği anlamına gelir. Dahil etme zincirinin en büyük derinliği ise 2.285'tir.

## Sonuç

Bulgularımız, üçüncü tarafların web'de her yerde bulunduğunu ve giderek daha fazla yoğunlaştığını gösteriyor. Web sayfalarının onda dokuzundan fazlası bir veya daha fazla üçüncü taraf içeriyor. Benzersiz üçüncü taraf alan adı sayısının medyanı önceki yıla göre azalmış olsa da üçüncü taraflardan gelen toplam istek sayısında önemli bir artış görüyoruz; bu da tek tek sağlayıcıların sayfa başına daha fazla istek gönderdiğini düşündürüyor.

Rıza standartları açısından, TCF tüm web sitesi sıralamalarında baskın rıza standardı. Tek tek üçüncü taraflar arasında ise en yüksek hacimde rıza sinyalini `pubmatic.com`, `adservice.google.com` ve diğer reklam teknolojisi alan adları alıyor.

Son olarak, CNAME gizleme ve sunucu taraflı izleme gibi maskeleme tekniklerinin giderek daha fazla kullanılması, istemci tarafı ölçümlerde üçüncü tarafların görünürlüğünü azaltıyor; bu da bulgularımızın gerçek yaygınlığın alt sınırını temsil ettiğini düşündürüyor.
