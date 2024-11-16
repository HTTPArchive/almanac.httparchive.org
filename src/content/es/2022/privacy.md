---
title: Privacidad
description: El capítulo sobre Privacidad del Web Almanac 2022 estudia la adopción y el impacto de los rastreadores online, las señales de preferencia de privacidad y las iniciativas de los navegadores para conseguir una web más respetuosa con la privacidad.
hero_alt: Hero image of Web Almanac characters with cameras, phones, and microphones acting like paparazzi while another character pulls back a shower curtain to reveal a web page behind it.
authors: [tomvangoethem, nrllh]
reviewers: [iskander-sanchez-rola]
analysts: [max-ostapenko, ydimova]
editors: [DesignrKnight]
translators: [decrecementofeliz]
tomvangoethem_bio: Tom Van Goethem se unió hace poco al equipo Chrome Privacy en Google. Antes de eso, Tom formaba parte del programa de doctorado del grupo DistriNet de la Unversidad de Lovaina, Bélgica. Los campos de su investigación incluyen un amplio espectro de temas en el campo de la seguridad y la privacidad, especialmente en los ataques "side-channel". Revelando amenazas y proponiendo cómo mitigarlas, Tom intenta hacer de la web un lugar mejor, poquito a poco.
nrllh_bio: Nurullah Demir es un investigador de ciber-seguridad y estudiante de doctorado en el <a hreflang="en" href="https://www.internet-sicherheit.de/en/">Institute for Internet Security</a> y <a hreflang="en" href="https://intellisec.de">Intelligent System Security, KASTEL Security Research Labs</a>. Su investigación se centra en la seguridad y privacidad, así como en las analíticas web.
results: https://docs.google.com/spreadsheets/d/1iJqj3g0VEjpmjzvtX6VLeRehE7LDQGcw6lOadxGxkjk/
featured_quote: Aunque probablemente aún falten un par de años para llegar ahí, estamos viviendo una transformación hacia una web que da a los usuarios más control sobre lo que quieren compartir con los demás. Podemos ver esta convergencia en los dos lados del espectro; por un lado, iniciada por el sitio web, y por el otro, forzada por el navegador.
featured_stat_1: 82%
featured_stat_label_1: Sitios que incluyen por lo menos un rastreador de terceros.
featured_stat_2: 11%
featured_stat_label_2: Prevalencia de Plataformas de Gestión del Consentimiento (CMPs por sus siglas en inglés).
featured_stat_3: 9,5%
featured_stat_label_3: Sitios del top 1.000 que hacen uso de las Sugerencias del cliente (User-Agent Client Hints).
---

## Introducción

Para enterarnos de las últimas noticias, para estar en contacto con nuestros amigos a través de las redes sociales o para comprar un bonito vestido, muchos de nosotros recurrimos a la web a la hora de buscar estos servicios e información en tan solo unos clicks. Un efecto colateral de <a hreflang="en" href="https://datareportal.com/reports/digital-2022-global-overview-report">pasarnos casi 7 horas al día en internet de media</a>, es que muchas de nuestras actividades de navegación, y por lo tanto indirectamente también nuestros intereses y datos personales, son capturados o compartidos con una plétora de empresas y servicios web.

Mientras los anunciantes intentan ofrecer a los usuarios anuncios relevantes (con los que hay más probabilidades de que interactúen), a menudo recurren a rastreadores de terceros para deducir cuáles son los intereses del usuario. En resumen, la actividad online de un usuario es rastreada paso a paso, ofreciendo a los rastreadores, en particular a los más predominantes, un montón de información, la mayoría de la cual probablemente ni siquiera es relevante para deducir los intereses del usuario. Por si esto fuera poco, generalmente a los usuarios no se les da la posibilidad de no participar en esto adecuadamente.

En este capítulo exploraremos el actual estado de la web en cuanto a privacidad. Estudiamos la ubicuidad de los rastreadores de terceros, los diferentes servicios que conforman este ecosistema, y cómo algunos de ellos intentan sortear las medidas protectores que los usuarios emplean para proteger su privacidad (por ejemplo, listas de bloqueo anti-rastreadores). Además, también indagamos en cómo los sitios están intentando mejorar la privacidad de sus visitantes, adoptando funcionalidades que limiten la información compartida con otras entidades, o asegurándose de que cumplen leyes de privacidad como el<a hreflang="en" href="https://gdpr.eu/">GDPR</a> y el <a hreflang="en" href="https://oag.ca.gov/privacy/ccpa">CCPA</a>.

## Rastreo online

{{ figure_markup(
  caption="Porcentaje de sitios web que incluyen al menos un rastreador de terceros en escritorio.",
  content="82%",
  classes="big-number",
  sheets_gid="225736044",
  sql_file="most_common_tracker_categories.sql"
)
}}

El rastreo (en inglés, "tracking") es una de las tecnologías más generalizadas en la web: El 82% de las páginas web de escritorio (80% en móviles) incluyen por lo menos un rastreador de terceros. Siguiendo su comportamiento online, estas empresas de rastreo pueden crear perfiles de los usuarios, perfiles que luego usan para crear publicidad personalizada, para que los propietarios de los sitios web puedan saber y analizar quién los visita o para distinguir a los usuarios legítimos de los (no deseados) bots. En esta sección, exploraremos las diferentes técnicas empleadas para monitorizar la actividad de los usuarios online y cómo los rastreadores intentar evadir las diferentes funcionalidades diseñadas para evitar que los usuarios sean rastreados.

### Rastreo de terceros

Uno de los métodos más comunes de rastreo online es emplear servicios de terceros; en el caso típico, el propietario del sitio inserta en su web un script de terceros que genera estadísticas y analíticas sobre el sitio o que muestra anuncios a los visitantes. Este script puede establecer en el navegador una cookie de terceros, y registrar así los sitios web que visita el usuario. Cuando el usuario visite otro sitio web que incluya el mismo servicio de terceros, la cookie se conectará con el rastreador, permitiendo reidentificar al usuario y vincular las dos visitas a ambas webs al mismo perfil.

Los tipos de servicios de terceros que se insertan -y que por lo tanto tienen la capacidad implícita de rastrear a los visitantes del sitio web- varían un poco. Las dos categorías de rastreadores más comunes (<a hreflang="en" href="https://whotracks.me/blog/tracker_categories.html">tal y como las define WhoTracks.me</a>) son los scripts de analítica (68% en móvil, 73% en escritorio) y los de publicidad (66% en móvil, 68% en escritorio). A ellos les siguen otras categorías de scripts que quizá no tengan una relación clara con el rastreo: interacción del cliente (servicios que le permiten al cliente enviar mensajes directos al dueño del sitio web), reproductores de audio / video (por ejemplo, vídeos de YouTube incrustados), y redes sociales (por ejemplo, los botones de "me gusta" de Facebook.

{{ figure_markup(
  image="most-common-trackers.png",
  caption="Rastreadores más comunes.",
  description="Gráfico de barras que muestra la prevalencia de los rastreadores de páginas web. Encontramos Google Analytics (analítica) en el 65% de los sitios en versión escritorio y en el 60% de los sitios en móvil, Google (publicidad) en el 51% y 49% respectivamente, DoubleClick (publicidad) en el 50% y 46%, Facebook (publicidad) en el 30% y el 28%, Google Adservices (publicidad) en 23% y 21%, Google Syndication (publicidad) en 12%, WordPress Stats (analítica) en el 6% tanto en móvil como en escritorio, Twitter (Social Media) en el 6% y 5%, Adobe Audience Manager (publicidad) en el 5% y el 6%, y finalmente Rubicon (publicidad) en el 5% de los sitios tanto en móvil como en escritorio.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=951980374&format=interactive",
  sheets_gid="944492219",
  sql_file="most_common_trackers.sql",
  width=600,
  height="524"
  )
}}

Para que un script de rastreo consiga crear perfiles de usuarios ha de estar insertado en una gran cantidad de sitios web desde los que rastrear una cantidad significativa de actividad online de usuarios. Si nos fijamos en los rastreadores más comunes, muchos de ellos son los "sospechosos habituales". Entre los 10 rastreadores más comunes, cinco de ellos están afiliados a Google. En esta lista también se incluyen redes sociales muy populares como Facebook o Twitter.

{{ figure_markup(
  image="number-of-trackers-per-site.png",
  caption="Número de rastreadores por sitio web.",
  description="Gráfico de líneas que muestra el número de rastreadores por sitio, en un rango de 1 a 20 rastreadores, tanto en la versión móvil como para escritorio. Aproximadamente el 15% de los sitios, tanto en escritorio como en móvil, tienen insertado un único rastreador. Las líneas del gráfico en general decrecen hasta menos del 1% de sitios en los que hay 10 rastreadores. El final del gráfico muestra una larga cola con un porcentaje más bajo de sitios que cuentan con más de 10 rastreadores.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1803959066&format=interactive",
  sheets_gid="1992611959",
  sql_file="number_of_websites_with_nb_trackers.sql"
  )
}}

Los sitios web pueden emplear múltiples servicios de terceros y por lo tanto pueden tener insertados múltiples rastreadores (no dejes de revisar el capítulo de [Terceros](./third-parties) para conocer con detalle qué terceras partes están incluidas en la web). Descubrimos que aproximadamente el 15% de los sitios en escritorio y el 16% de los sitios en móvil incluyen "solo" un rastreador. Desafortunadamente, esto significa que de hecho es más común que los sitios webs incluyan varios rastreadores. ¡Incluso encontramos un sitio web que tenía insertados 126 rastreadores diferentes!

### (Re)targeting

{{ figure_markup(
  image="retargeting-services.png",
  caption="Servicios de retargeting más comunes.",
  description="Gráfico de barras que muestra el porcentaje de páginas que incluyen algún servicio particular de retargeting. Criteo apareció en el 2,04% y el 1,98% de las versiones de escritorio y móvil respectivamente, Yahoo Advertising en el 0,44% y el 0,54%, AdRoll en el 0,34% y el 0,49%, OptiMonk en el 0,09% y el 0,11%, SharpSpring Ads en el 0,08% y el 0,12%. El resto de entradas del gráfico muestran una prevalencia menor del 0,10%. Son Albacross, Smarter Click, Blue, SteelHouse, Cross Pixel, Linx Impulse, y Picreel.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=2098143733&format=interactive",
  sheets_gid="96406513",
  sql_file="number_of_websites_using_each_retargeting.sql",
  width=600,
  height="454"
  )
}}

Cuando navegamos por la web, a menudo encontramos anuncios de productos que habíamos buscado recientemente. La razón es el retargeting (podría traducirse al español como "recaptación"). Cuando un sitio web detecta que un usuario podría estar interesado en un determinado producto, se lo notifica al rastreador y/o al anunciante, quienes más adelante, cuando el mismo usuario esté visitando otra página web no relacionada con la anterior, mostrarán anuncios del producto en el que supuestamente está interesado el usuario, intentando empujarlo hacia la compra.

De los rastreadores que ofrecen servicios específicos de retargeting, el más común es Criteo, con una prevalencia del 1,98% en escritorio y del 2,04% en móvil. Lo sigue Yahoo Advertising y AdRoll, que juntos suman menos de la mitad de la cuota de mercado de Criteo. El servicio de retargeting que había sido el más ampliamente usado el [año pasado](../2021/privacy), Google Tag Manager, no aparece en estos resultados porque ahora está clasificado dentro de la categoría de Wappalyzer "Gestores de etiquetas". Aunque este servicio sí gestiona el retargeting, lo hace indirectamente, incluyendo etiquetas de retargeting que son detectadas de forma independiente.

### Cookies de terceros

Como se comentó antes, la manera más establecida para rastrear a los usuarios a través de diferentes sitios web es empleando cookies de terceros. Con los recientes cambios en las políticas de los navegadores, las cookies ya no serán incluidas en las peticiones cross-site (entre diferentes sitios) por defecto. En términos técnicos, esto significa que la mayoría de los navegadores establecen el atributo `SameSite` de las cookies al valor por defecto `Lax`. Los sitios web pueden sobreescribir esto cambiando ellos mismos ese valor de forma explícita. Algo que ha esto ocurriendo a gran escala: de entre todas las cookies de terceros que establecen el atributo `SameSite`, el 98% de ellas le asignan el valor `None`, lo que les permite ser incluidas en las peticiones cross-site. Y aún hay más, en cuanto al tiempo de expiración que determina por cuánto tiempo la cookie es válida: descubrimos que el tiempo de vida medio de una cookie es 365 días. Para un estudio más a fondo de las cookies y sus atributos, por favor, revisa el capítulo [Seguridad](./security#cookies).

{{ figure_markup(
  image="cookie-origins.png",
  caption="Top 10 de los orígenes de las cookies creadas por los rastreadores.",
  description="Gráfico de barras que muestra la prevalencia de los diferentes orígenes que crean cookies cross-site. Encontramos cookies de doubleclick.net en el 26,3% de los sitios de escritorio y en el 24,1% de los sitios de móvil respectivamente, en el caso de las cookies creadas desde facebook.com estos valores fueron del 18,9% para móviles y del 17,5% para escritorio, las cookies de youtube.com se encuentran en el 9,7% de los sitios móvil y en el 8,7% de los sitios de escritorio, otros orígenes son google.com en el 6,4% y 6,0%, yandex.ru en el 4,3% y 4,9%, linkedin.com en el 4,1% y 3,2%, adsrvr.org en el 4,0% y 3,8%, pubmatic.com en el 4,0% y 4,9%, yahoo.com en el 3,9% y 3,6%, bing.com en el 3,8% y 2,8%, y por último, cookies creadas por rubiconproject.com en el 3,7% de los sitios de escritorio y en el 3,3% de los sitios para móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=852543503&format=interactive",
  sheets_gid="1010563596",
  sql_file="top100_domains_that_set_cookies_via_response_header.sql",
  width=600,
  height="429"
  )
}}

En gran medida, los rastreadores de terceros que crean cookies coinciden a grandes rasgos con los servicios terceros insertados en los sitios web. Sin embargo, el rastreador de terceros más común, Google Analytics, no tiene tanta prevalencia aquí. Esto se debe a que Google Analytics establece una cookie propia, o de origen, (`_ga`), que según <a href="https://policies.google.com/technologies/cookies?hl=es-es">su definición</a> "es exclusiva de una propiedad específica, así que no se puede utilizar para rastrear a un usuario o navegador en sitios web no relacionados". Aún así, el dominio de rastreadores que crean cookies de terceros más común, `doubleclick.net`, también es afiliado de Google. El resto de dominios que aparecen en la lista están vinculados a la publicidad y las redes sociales.

{{ figure_markup(
  image="most-common-cookies.png",
  caption="Top 10 de cookies establecidas por los rastreadores.",
  description="Gráfico de barras que muestra la prevalencia de cookies cross-site específicas, agrupadas por el nombre de la cookie. La cookie llamada `test_cookie`, creada por doubleclick.net, se encuentra en el 26% de los sitios de escritorio y en el 24% de los sitios móviles; `fr`, creada por facebook.com, está presente en el 19% y el 17%, respectivamente; `IDE`, establecida por doubleclick.net, en el 12% y 12%; `YSC`, de youtube.com, en el 10% y el 9%; `VISITOR_INFO1_LIVE`, de youtube.com, en el 10% y el 8%; `sync_cookie_csrf`, originada en yandex.ru, en el 4% y el 5%; `yandexuid`, de yandex.com, en el 4% y 5%; `yuidss`, de yandex.com, en el 4% y 5%; `i`, de yandex.com, en el 4% y 5%, y por último `ymex`, creada también por yandex.com, en el 4% y 5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1506966442&format=interactive",
  sheets_gid="1112448573",
  sql_file="top100_cookies_set_from_header.sql"
  )
}}

Si nos fijamos en las cookies de terceros más comunes, volvemos a encontrarnos con varios dominios de rastreadores, empezando por la `test_cookie` de `doubleclick.net`—una cookie que dura 15 minutos y que es necesaria a nivel funcional según <a hreflang="en" href="https://business.safety.google/adscookies/">su descripción</a>. A esta cookie la sigue la cookie `fr` procedente de `facebook.com`—una cookie empleada para "entregar, medir y mejorar la pertinencia de los anuncios, con una vida útil de 90 días", según <a href="https://es-es.facebook.com/policy/cookies/">su definición</a>. El resto de las 10 cookies más comunes provienen de YouTube y de Yandex.

### Técnica de evasión: fingerprinting

{{ figure_markup(
  image="fingerprinting-services.png",
  caption="Uso de servicios de fingerprinting.",
  description="Gráfico de barras que muestra la prevalencia de los servicios de fingerprinting. El script FingerprintJS se encontró en el 0,62% de los sitios en escritorio y en el 0,73% de los sitios para móvil, ClientJS se detectó en un 0,04% y 0,04%, MaxMind en el 0,03% y 0,04%, y por último TruValidate en el 0,02% y 0,03% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=79170171&format=interactive",
  sheets_gid="1069316937",
  sql_file="number_of_websites_using_each_fingerprinting.sql"
  )
}}

Mientras cada vez más navegadores desarrollan medidas contra el rastreo basado en cookies, dándoles a los usuarios más control para bloquear las cookies de terceros, algunos rastreadores intentan sortear estas protecciones. Una de estas técnicas de evasión es el seguimiento de las huellas digitales, más conocido por su nombre en inglés, fingerprinting: recurrir a características específicas de los navegadores (por ejemplo, las extensiones que hay instaladas), de los sistemas operativos (por ejemplo, las fuentes instaladas en el sistema) y del hardware (por ejemplo, las diferencias en el renderizado de composiciones complejas según qué GPU se esté usando) para crear una huella digital única del usuario. Esta huella permite que el rastreador pueda reidentificar al mismo usuario cuando visita sitios webs diferentes y no relacionados entre sí.

En nuestro análisis, buscamos cinco librerías diferentes y descubrimos que la más usada en la web para hacer fingerprinting es <a hreflang="en" href="https://github.com/fingerprintjs/fingerprintjs">FingerprintJS</a>, detectada en el 0.62% de todos los sitios web. Lo más probable es que esto se deba a que es una librería open source y con una versión gratuita. Comparado con [nuestras métricas del año pasado](../2021/privacy), vemos que el uso del fingerprinting se ha mantenido más o menos igual.

### Técnica de evasión: rastreo por CNAME

Dado que mucha de las medidas antirastreao se centrar en bloquear o deshabilitar las cookies de terceros, otra manera de evadir estas protecciones es emplear cookies propias o de origen en su lugar. En este caso, el rastreador se oculta usando el registro CNAME de un subdominio del sitio web en el que está insertado. Así, cuando el rastreador crea una cookie, será considerada como cookie propia. Una limitación de este rastreo basado en los CNAME es que sólo puede usarse para rastrear la actividad dentro de un sitio web específico, pero el rastreador podría recurrir a la técnica de <a hreflang="en" href="https://adtechexplained.com/cookie-syncing-explained/">sincronización de cookies</a> para relacionar visitas a múltiples sitios.

{{ figure_markup(
  image="cname-tracking-services.png",
  caption="Top 5 de servicios de rastreo por CNAME.",
  description="Gráfico de barras que muestra la prevalencia de los rastreadores vía CNAME. Adobe Experience Cloud se encontró en el 0,65% de los sitios de escritorio y en el 0,38% de los sitios móviles respectivamente, Pardot en el 0,44% y 0,25%, Oracle Eloqua en el 0,06% y 0,03%, Act-On Software en el 0,05% y 0,03%, y Webtrekk en el 0.02% y 0,01%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=118406352&format=interactive",
  sheets_gid="1717363829",
  sql_file="nb_sites_with_cname_tracking.sql"
  )
}}

Analizando los diferentes rastreadores por CNAME, vemos que la cuota de mercado está concentrada en dos servicios principales: Adobe Experience Cloud (0,65% en escritorio y 0,38% en móvil) y Pardot (0,25% en escritorio y 0,44% en móvil). Curiosamente, la adopción del rastreo por CNAME es significativamente mayor en sitios visitados con un navegador de escritorio que en los visitados con un navegador móvil. Posiblemente esto se deba a que en móvil hay menos mecanismos para preservar la privacidad; por ejemplo, la mayoría de los navegadores para móvil no permiten instalar extensiones.

{{ figure_markup(
  image="cname-tracking-by-rank.png",
  caption="Uso del rastreo por CNAME por grupos de ranking.",
  description="Gráfico de barras que muestra la prevalencia de los rastreadores por CNAME y por grupos de ranking, de 1.000 a 1.000.000 y una categoría separada que engloba todos los sitios. Los sitios del top 1.000 tienen rastreo por CNAME en el 6,2% de los casos desde escritorio y en el 5,8% desde móvil, entre el top 10.000 es el 5,9% y 5,3%, respectivamente, en el top 100.000 el 2,9% y el 2,7%, en el top 1.000.000 es el 1,3% y el 1,2%, y por último en el total la prevalencia del rastreo por CNAME es del 0,9% en escritorio y el 0,5% en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=213195774&format=interactive",
  sheets_gid="303099519",
  sql_file="nb_sites_with_cname_tracking_per_rank.sql"
  )
}}

Aunque la prevalencia total de los rastreadores por CNAME puede parecer baja (0,9% en sitios para escritorio, 0,5% para móvil), su adopción está muy concentrada en sitios web muy populares. Dentro del top 1.000 de los sitios más visitados, el 6,2% de los de escritorio y el 5,8% de las versiones móviles tienen insertados un rastreador de tipo CNAME. Esto significa que es bastante probable que los usuarios se acaben encontrando con alguno de estos rastreadores mientras navegan por la web.

## Acceso a datos (sensibles) desde el navegador

Los navegadores cuentan con un alto número de APIs que ofrecen a los desarrolladores mecanismos útiles para que puedan interactuar con diferentes componentes. Algunas de estas APIs también se pueden usar para extraer información de los sensores y otros periféricos conectados al dispositivo del usuario. Aunque la mayoría de las APIs ofrecen una cantidad limitada de información (como la orientación de la pantalla), otras ofrecen datos muy detallados (por ejemplo, el acelerómetro y el giroscopio) que pueden usarse para hacer fingerprinting de dispositivo, o incluso para deducir qué contraseña teclea un usuario basándose en los movimientos que hacen con su teléfono móvil.

### Eventos de sensores

{{ figure_markup(
  image="sensor-events.png",
  caption="Los eventos de sensores de dispositivos más usados.",
  description="Gráfico de barras que muestra el porcentaje de sitios web que usan un cierto tipo de eventos de sensores. El evento llamado `deviceOrientation` se usa en el 4,04% de los sitios de escritorio y en el 4,10% de los sitios para móvil, `deviceReady` en el 1,16% y 1,28%, `devicemotion` en el 0,78% y 0,72%, `deviceChange` en el 0,29% y 0,28%, y por último el evento `deviceproximity` se detectó en el 0,03% de los sitios de escritorio y en el 0,02% de las versiones móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=2114701877&format=interactive",
  sheets_gid="217371442",
  sql_file="number_of_websites_with_device_sensor_events.sql"
  )
}}

Descubrimos que el evento de sensores más monitorizado por los sitios web es el `deviceOrientation`, que se dispara cuando el dispositivo cambia de la vista horizontal a la vertical o viceversa. Se usa en el 4,0% de los sitios de escritorio y en el 4,1% de los sitios para móviles. Seguramente la razón de este uso sea que los sitios web puedan actualizar los elementos del diseño cuando cambia la orientación del dispositivo.

### Dispositivos media

{{ figure_markup(
  caption="Porcentaje de páginas web que enumeran los dispositivos media.",
  content="0.59%",
  classes="big-number",
  sheets_gid="1554147968",
  sql_file="number_of_websites_with_device_sensor_blink_usage.sql"
)
}}

A través de la [API MediaDevices](https://developer.mozilla.org/docs/Web/API/MediaDevices), los desarrolladores web pueden usar el método `enumerateDevices()` para conseguir una lista de todos los recursos media conectados al dispositivo del usuario. Aunque esta funcionalidad puede ser útil para saber si un usuario tiene una cámara o un micrófono conectado a la hora de iniciar una videollamada, también se puede usar para recoger información sobre el entorno del sistema y usarla para hacer fingerprinting. Descubrimos que el  0.59% de los sitios de escritorio y el 0,48% de los sitios para móviles intentan acceder a la lista de recursos conectados -téngase en cuenta que nuestro crawler no interactúa con el sitio, ni hace click en ningún botón. Curiosamente, el [uso de esta API se ha reducido significativamente desde el año pasado](../2021/privacy#media-devices), cuando la prevalencia de sitios que acceden a la lista de recursos media era 12 veces mayor. Seguramente esto se deba al uso de una popular librería que funciona sin necesidad de hacer peticiones a la API.

### Geolocalización

{{ figure_markup(
  image="gelocation-services.png",
  caption="Servicios de geolocalización más comunes.",
  description="Gráfico de barras que muestra el porcentaje de sitios web que usan algún servicio de geolocalización. El servicio de geolocalización ipify se detectó en el 0,083% de los sitios de escritorio y en el 0,115% de los sitios para móvil, MaxMind en el 0,029% y 0,044%, IPinfo en el 0,003% y 0,005%, y por último Geo Targetly se detectó en el 0,002% y 0,002%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1039516482&format=interactive",
  sheets_gid="1999414939",
  sql_file="number_of_websites_using_each_geolocation.sql"
  )
}}

Buena parte del contenido que se nos sirve depende del lugar desde el que visitemos el sitio web. Para que los desarrolladores puedan determinar dónde está un usuario, pueden usar servicios de geolocalización de terceros. Estos determinarán la localización de un usuario basándose en su dirección IP. Aunque este tipo de geolocalización es más habitual en el bck-end, también detectamos algún uso en el front-end: el 0.115% de los sitios de escritorio y el 0.083% de los sitios para móviles se conectan con ipify para determinar la localización de la IP del usuario.


{{ figure_markup(
  caption="Porcentaje de páginas de escritorio que intentan acceder a la geolocalización del navegador.",
  content="0.65%",
  classes="big-number",
  sheets_gid="1213448832",
  sql_file="number_of_websites_with_geolocation.sql"
)
}}

Aunque la geolocalización basada en la IP puede ser bastante imprecisa, sobre todo cuando los usuarios emplean una VPN para ocultar su dirección IP original, los sitios web pueden solicitar una localización más granular a través de la [Geolocation API](https://developer.mozilla.org/docs/Web/API/Geolocation_API). Por supuesto, el acceso a esta API (intrusiva en cuanto privacidad) depende de que los usuarios den manualmente su permiso. Aún así, vemos que el 0,65% de los sitios de escritorio y el 0,61% de los sitios para móvil intentan acceder a la localización actual del usuario tras una visita a la página de inicio, sin que haya ninguna interacción del usuario. Curiosamente, aún detectamos 574 sitios de escritorio (menos que los 900 del año pasado) que intentaban acceder a esta funcionalidad cuando la página se cargaba a través de una conexión insegura. Debido a la naturaleza sensible de estos datos, la mayoría de los navegadores restringen su uso a orígenes seguros.

## Controles establecidos para mejorar la privacidad del usuario

Dado que los sitios web incluyen mucho contenido de terceros (scripts, plugins, etc.) en el que no tienen por qué confiar plenamente, pueden proteger la privacidad de sus usuarios de estas terceras partes. A continuación exploraremos los diferentes controles que se pueden usar para restringir los datos o funcionalidades a los que tienen acceso los terceros, o para dejarles explícitamente claro qué información del usuario puede obtener un sitio web.

### Política de Permisos

{{ figure_markup(
  image="permissions-policy-type.png",
  caption="Uso de la Política de Permisos por tipo de API.",
  description="Gráfico de barras que muestra el porcentaje de sitios web que usan alguna política, o bien la Política de Permisos (Permissions Policy) o bien la Política de Funcionalidades (Features Policy). La Política de Funcionalidades se usó en el 0,69% de los sitios de escritorio y en el 0,52% de los sitios versión móvil respectivamente, y la API Política de Permisos se usó en el 2,7% de sitios de escritorio y en el 2,3% de sitios móviles; en total el 3,3% de los sitios en escritorio y el 2,7% controlan qué características admite el sitio estableciendo una política.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1921531833&format=interactive",
  sheets_gid="741173570",
  sql_file="number_of_websites_with_permissions_policy.sql"
  )
}}

Por defecto, cualquier script de terceros puede acceder a las mismas funcionalidades que el sitio en el que está insertado. Para limitar las características que se habilitarán, el sitio web puede hacer uso de la Política de Permisos <a hreflang="en" href="https://developer.chrome.com/en/docs/privacy-sandbox/permissions-policy/">Política de Permisos</a>. A través de un cabecero de respuesta HTTP el sitio web puede indicar qué funcionalidades quiere permitir. Por ejemplo, si la función `microphone` no está incluida en esta lista, ninguno de los scripts insertados en la página web puede usarla. Aunque esta política es bastante reciente, vemos una adopción del 2,71% de los sitios para escritorio y del 2,31% de los sitios en móvil.

La Política de Permisos (en inglés, "Permissions Policy") sustituye a la [Feature Policy](https://developer.mozilla.org/docs/Web/HTTP/Headers/Feature-Policy) (Política de Funcionalidades), que aún podemos encontrar en el 0,69% de los sitios de escritorio y en el 0,52% de los sitios móvil.
Por defecto la mayoría de las características reguladas por la Política de Permisos están deshabilitadas en iframes de orígenes externos (cross-origin), pero pueden ser explícitamente habilitadas con el atributo `allow`. Vemos que el 15,18% de los sitios de escritorio y el 14,32% de los sitios móvil usan esta característica. Para un análisis más pormenorizado del uso del atributo `allow` en los iframes, por favor consulta el capítulo referido a la [Seguridad](./security#permissions-policy).

{{ figure_markup(
  image="permission-policy-features.png",
  caption="Las características más comunes en las Políticas de Permisos.",
  description="Gráfico de barras que muestra qué características de la Política de Permisos son las más comunes. La característica `interest-cohort` de la Política de Permisos estaba presente en el 1,18% de los sitios de escritorio y en el 0,93% de los móviles respectivamente, la característica `geolocation` se especificó en el 0,80% y 0,58% de los sitios, `microphone` en el 0,78% y 0,57%, `camera` en el 0,75% y 0,55%, `payment` en el 0.57% y 0,42%, `gyroscope` en el 0,54% y 0,40%, `magnetometer` en el 0,54% y 0,39%, `fullscreen` en el 0,47% y 0.34%, `usb` en el 0,45% y 0,33%, y por último  `accelerometer` se detectó en el 0,44% de los sitios desde escritorio y en el 0,32% desde móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1803269356&format=interactive",
  sheets_gid="315730924",
  sql_file="most_common_permissions_policy_directives.sql",
  width="600",
  height="448"
  )
}}

Si nos fijamos en qué directiva son las más usadas en la Política de Permisos, vemos un uso similar al del [año pasado](../2021/privacy), con la excepción de la que ha sido la más usada en 2022, `interest-cohort`. Esta directiva puede usarse para limitar el acceso a la ahora difunta API FLoC. Probablemente este aumento se deba a los diferentes fallos de FLoC (aumento de la superficie de fingerprinting, revelación de información potencialmente sensible sobre los usuarios, etc.) que obligaron a los dueños de sitios web, proveedores y libreraías a tomar medidas para proteger la privacidad de sus usuarios.

### Política de Referencias (Referrer Policy)

{{ figure_markup(
  caption="Porcentaje de sitios web de escritorio que establecen una Política de Referencias.",
  content="12%",
  classes="big-number",
  sheets_gid="1186623225",
  sql_file="number_of_websites_with_referrerpolicy.sql"
)
}}

Por defecto, la mayoría de los agentes de usuario incluyen un cabecero `Referer` (referencia). Resumiendo, esto muestra a terceras partes desde qué sitio web -o incluso de qué pagina- se inició una petición. Esto se aplica para cualquier recurso que esté insertado en la página web, así como para la petición iniciada después de que un usuario haga click en un enlace. Por supuesto, una consencuencia indeseada de esto es que esas terceras partes sabrán qué sitio web, o incluso qué página web estaba visitando un usuario específico. Valiéndose de la [Política de Referencias](https://developer.mozilla.org/docs/Web/HTTP/Headers/Referrer-Policy), los sitios web pueden limitar la instancias en las que el cabecero `Referer` se incluye en las peticiones y así mejorar la privacidad del usuario. in requests and thus improve user privacy. Observamos que el 12% de los sitios de escritorio y el 10-% de los sitios desde móvil establecen esta política en todo el documento, casi siempre a través de un cabecero de respuesta HTTP.

{{ figure_markup(
  image="referrer-policies.png",
  caption="Las Políticas de Referencias más comunes.",
  description="Gráfico de barras que muestra qué Políticas de Referencia son las más comunmente definidas en los sitios web. La política `no-referrer-when-downgrade` se encontró en el 4.33% de los sitios en escritorio y en el 3,70% desde móvil respectivamente, `strict-origin-when-cross-origin` se encontró en el 2,68% en escritorio y 2,14% en móvil, `always` en el 1,07% y 0,53%, `unsafe-url` en el 0,64% y 0,71%, `same-origin` en el 0,74% y 0,60%, `origin` en el 0,41% y 0,57%, `no-referrer` en el 0,44% y 0,33%, `origin-when-cross-origin` en el 0,37% y 0,32%, `strict-origin` en el 0,32% y 0,25%, y por último `no-referrer, strict-origin-when-cross-origin` se detectó en el 0,11% desde escritorio y en el 0,09% desde móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=2062222912&format=interactive",
  sheets_gid="1353802246",
  sql_file="most_common_referrer_policy.sql",
  width=600,
  height="473"
  )
}}

Vemos que el uso más común de Política de Referencias es no incluir el cabecero `Referer` en peticiones menos seguras, es decir, peticiones HTTP iniciadas en una página que tenga HTTPS habilitado. Desafortunadamente, con esto se sigue revelando la página que el usuario estaba visitando en la mayoría de los escenarios, que son los de las peticiones HTTPS. Sí vemos que el 2,7% de los sitios desde escritorio y el 2,1% desde móvil intentan ocultar la página web específica que el usuario está visitando a través de la política `strict-origin-when-cross-origin`, que ahora es la que eligen por defecto la mayoría de los navegadores cuando no especifica otra política.

### Indicaciones del cliente sobre agentes de usuario (User-Agent Client Hints)

En un esfuerzo para reducir la cantidad de información que se revela sobre el entorno del navegador, y más específicamente la cadena `User-Agent`, se diseñó el mecanismo <a hreflang="en" href="https://wicg.github.io/ua-client-hints/">User-Agent Client Hints</a>(en español, Indicaciones del cliente sobre el agente de usuario). Con este método, los sitios web que quieren acceder a cierta información sobre el entorno de navegación del usuario (versión del navegador, sistema operativo, etc.) ahora deben establecer un cabecero (`Accept-CH`) en la primera respuesta, y el navegador devolverá los datos solicitados en las siguientes peticiones. Entre otros beneficios, esta función reduce la superficie de huella digital (fingerprinting) y permite a los navegadores intervenir a la hora de enviar según qué datos, por ejemplo, con la propuesta del <a hreflang="en" href="https://github.com/mikewest/privacy-budget">Privacy Budget</a> (en español, Presupuesto de privacidad).

{{ figure_markup(
  image="client-hints-by-rank.png",
  caption="Número de sitios web con Indicaciones de Cliente por grupo de ranking de popularidad.",
  description="Gráfico de barras que muestra la prevalencia de sitios web que emplean las Indicaciones de cliente sobre agentes de usuario por los diferentes grupos de ranking, desde 1.000 a 1.000.000 y una categoría separada que engloba a todos los sitios. Entre el top 1.000 de sitios más populares, habilitaron las Indicaciones de cliente (Client Hints) el 9,53% de los sitios de escritorio y el 9,11% desde móvil; respectivamente, en el top 10.000 encontramos Indicaciones de cliente en el 3,14% de los sitios desde escritorio y en el 3,12% desde móvil, y en el top 1.000.000, en el 0,38% y 0,39%; en el total de los sitios, las Indicaciones de cliente se detectaron en el 0,31% de los sitios desde escritorio y en el 0,56% desde móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=318395619&format=interactive",
  sheets_gid="1199573159",
  sql_file="number_of_websites_with_client_hints.sql"
  )
}}

Si observamos el número de sitios que responden al cabecero `Accept-CH` en comparación con los resultados del [año pasado](../2021/privacy) (top 1.000: 3,56%, top 10.000: 1,44%), vemos un aumento significativo de la adopción de esta técnica, de casi tres veces más en los sitios más populares. we see a significant increase in adoption, almost 3x for the most popular sites. Presumiblemente, este aumento en la adopción está relacionado con el hecho de que Chromium ha estado reduciendo la información que comparte en la cadena `User-Agent`  (mediante el <a hreflang="en" href="https://www.chromium.org/updates/ua-reduction/">Plan de Reducción del User-Agent</a>).

Vemos que los sitios que emplean las Indicaciones de cliente sobre agentes de usuario generalmente solicitan acceso a una cantidad relativamente larga de propiedades, limitando así el beneficio que los navegadores pretenden conseguir con esfuerzos como el de la reducción de la cadena User-Agent. Será interesante ver cómo los navegadores intentarán en un futuro próximo seguir limitando las prácticas para adquirir información sobre el entorno de navegación del usuario.

## Nuevos esfuerzos para mejorar la privacidad del navegador

Durante los últimos años, el usuario medio de la web se ha vuelto cada vez más consciente de su privacidad online. Por otro lado, las brechas y fugas de datos, que parecen ser <a hreflang="en" href="https://www.informationisbeautiful.net/visualizations/worlds-biggest-data-breaches-hacks/">cada vez más comunes y más graves</a>, afectan a casi todo el mundo. A esto se suma que el rastreo ubicuo de usuarios a través de cookies de terceros ya es muy conocido entre la población general. Como resultado, cada vez son más los usuarios que esperan que su navegador proteja su privacidad y les dé más control sobre el rastreo de comportamientos online. Los fabricantes de navegadores, los creadores de contenido online y las compañías de publicidad se han hecho eco de esta demanda para mejorar la privacidad y han propuesto la Privacy Sandbox, una iniciativa encabezada por Google Chrome.

### Prueba de origen en Privacy Sandbox

En el momento de publicar el Web Almanac de este año, las funcionalidades de la Privacy Sandbox (en español, "Entorno de privacidad") aún no están disponbiles para el uso general. Sin embargo, los sitios y servicios web -como por ejemplo los anuncios, que suelen mostrarse en iframes- pueden participar en el testeo adelantado de las características de la Privacy Sandbox, usando la <a hreflang="en" href="https://developer.chrome.com/en/blog/privacy-sandbox-unified-origin-trial/">Prueba de origen</a> (en inglés, "Origin Trial"). Hay que tener en cuenta que esto sólo se aplica a los usuarios cuyo navegador soporta las característias de la Privacy Sandbox, y que éstas sólo están implementadas en Chrome y desactivadas por defecto en el momento de escribir este informe. La Prueba de origen les da a los servicios web acceso a tres APIs diferentes relacionadas con la Privacy Sandbox: <a href="https://developer.chrome.com/es/docs/privacy-sandbox/topics/">Topics</a>, <a href="https://developer.chrome.com/es/docs/privacy-sandbox/fledge/">FLEDGE</a> y <a href="https://developer.chrome.com/es/docs/privacy-sandbox/attribution-reporting/">Informes de atribuciones</a>.

<figure>
  <table>
    <thead>
      <tr>
        <th>Origen que solicita funcionalidad</th>
        <th>Escritorio</th>
        <th>Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>https://www.googletagmanager.com</td>
        <td class="numeric">12,53%</td>
        <td class="numeric">10,99%</td>
      </tr>
      <tr>
        <td>https://googletagservices.com</td>
        <td class="numeric">11,05%</td>
        <td class="numeric">10,52%</td>
      </tr>
      <tr>
        <td>https://doubleclick.net</td>
        <td class="numeric">11,04%</td>
        <td class="numeric">10,51%</td>
      </tr>
      <tr>
        <td>https://googlesyndication.com</td>
        <td class="numeric">11,04%</td>
        <td class="numeric">10,51%</td>
      </tr>
      <tr>
        <td>https://googleadservices.com</td>
        <td class="numeric">2,50%</td>
        <td class="numeric">2,29%</td>
      </tr>
      <tr>
        <td>https://s.pinimg.com</td>
        <td class="numeric">1,49%</td>
        <td class="numeric">1,21%</td>
      </tr>
      <tr>
        <td>https://criteo.net</td>
        <td class="numeric">0,64%</td>
        <td class="numeric">0,41%</td>
      </tr>
      <tr>
        <td>https://criteo.com</td>
        <td class="numeric">0,59%</td>
        <td class="numeric">0,37%</td>
      </tr>
      <tr>
        <td>https://imasdk.googleapis.com</td>
        <td class="numeric">0,10%</td>
        <td class="numeric">0,07%</td>
      </tr>
      <tr>
        <td>https://teads.tv</td>
        <td class="numeric">0,04%</td>
        <td class="numeric">0,03%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Prevalencia de los orígenes que solicitan acceso a alguna de las APIs de la Privacy Sandbox a través de la Prueba de Origen",
      sheets_gid="1410031518",
      sql_file="number_of_websites_with_origin_trial_from_token.sql",
    ) }}
  </figcaption>
</figure>

Los servicios más habituales de los que testearon la Privacy Sandbox a través de la Prueba de origen fueron: Google Tag Manager, Doubleclick, Google Syndication y Google Ad Services, que están en el top 5 tanto en escritorio como en móvil. Los sigue la red social Pinterest y otros rastreadores y anunciantes: Criteo, Google Ads SDK y Teads.

### Experimentos en la Privacy Sandbox

La iniciativa Privacy Sandbox consiste en muchas funcionalidades diferentes que cubren diferentes aspectos y cuyo objetivo es seguir dando soporte a las acciones más comunes de los usuarios en la web a medida que el sistema de las cookies de terceros va desapareciendo. Dado que la mayoría de las funcionalidades aún están en fase de desarrollo, los sitios web aún no las han adoptado (con la excepción de los servicios que soclitiaron acceso a la `PrivacySandboxAdsAPIs` a través de la Prueba de origen).

Durante un tiempo, la Prueba de origen para diferentes funcionalidades de la Privacy Sandbox se separó en diferentes pruebas o "trials", una para cada funcionalidad. Aunque estas pruebas no tienen ningún efecto en los entornos de navegación modernos, algunos servicios web sí que solicitaron acceso y se olvidaron de eliminar el cabecero de respuesta `Origin-Trial`.

Por ejemplo, vemos que en 34,128 sitios un servicio web accede a la Prueba de Origen del `ConversionMeasurement` , que en algún momento les dio acceso a la API <a href="https://developer.chrome.com/es/docs/privacy-sandbox/attribution-reporting/">Informes de atribución</a> (previamente llamada API de Medición de Conversiones). Esta API se usa, por ejemplo, para rastrear las conversiones de los usuarios que hacen click en un anuncio.

Para la Prueba de origen <a href="https://developer.chrome.com/es/docs/privacy-sandbox/trust-tokens/">TrustTokens</a>, que también ha expirado, aún vemos 6.005 sitios en los que un servicio web solicita acceso. Este mecanismo intenta ayudar a los sitios web a combatir el fraude permitiendo que un contexto de navegación (por ejemplo, un sitio) transmita una cantidad limitada de información a otra.

Es interesante destacar que en más de 30.000 sitios web un servicio web aún está intentando acceder a la Prueba de origen `InterestCohort`, que les daría acceso al grupo de interés del usuario en FLoC. Sin embargo, debido a las dudas que esta API generó respecto a la privacidad, se interrumpió su desarrollo. Fue sustituida por la the <a href="https://developer.chrome.com/es/docs/privacy-sandbox/fledge/">API FLEDGE</a>, que intenta ofrecer "subastas de anuncios en el dispositivo de forma local para ayudar al remarketing y a las audiencias personalizadas" y la <a href="https://developer.chrome.com/es/docs/privacy-sandbox/topics/">API Topics API</a>, cuyo objetivo es permitir que los anunciantes sirvan anuncios basados en los intereses del usuario sin necesidad de recurrir al rastreo en diferents sitios web.

## Cumplimiento de las regulaciones de privacidad

El espacio de regulación de la privacidad continúa creciendo como la frontera más reciente de la legislación. Estas regulaciones requieren que las organizaciones sean más transparentes a la hora de procesar los datos de sus usuarios para protegerlos. Tras la aprobación de leyes de privacidad clave como el <a href="https://data.consilium.europa.eu/doc/document/ST-9565-2015-INIT/es/pdf">Reglamento General de Protección de Datos</a> y <a hreflang="en" href="https://www.iabeurope.eu/">Framework de Transaprencia y Consentimiento IAB (TCF) v2.0</a>, los proveedores de páginas web se pusieron manos a la obra para informar a sus usuarios sobre cómo se procesan sus datos durante la visita, recogiendo el consentimiento de estos usuarios para procesar sus datos también con fines no funcionales, como por ejemplo, analítica y anuncios. Por esta razón vemos en las webs cada vez más banners de cookies, el sistema más empleado por los sitios webs para notificar a sus usuarios o pedirles su consentimiento.

En la mayoría de los casos, los usuarios pueden interactura con estos banners y elegir qué datos pueden ser procesados. Sin embargo, gestionar esas tareas no es sencillo en nuestra moderna y sofisticada web, que cada vez se hace más compleja. Por ello, muchos operadores de sitios web delegan este trabajo en terceras partes, llamadas Plataformas de Gestión del Consentimiento (CMP, por sus siglas en inglés). Las CMP se aseguran de que las cookies se emplean correctamente en la web, según lo que dicta la ley. A continuación desgranamos el uso de CMP y de las notificaciones de políticas de privacidad.

### Plataformas de Gestión del Consentimiento (CMP)

Como hemos visto, emplear una Plataforma de Gestión del Consentimiento debería garantizar que el sitio web, en particular el comportamiento de las cookies, funciona de acuerdo a la ley.

Aquí debemos señalar que el uso de estos servicios de CMP no siempre garantiza que los sitios webs cumplan la ley, tal y como muestran varios siguientes estudios (por ejemplo <a hreflang="en" href="https://arxiv.org/abs/2104.06861">Santos et al.</a> y <a hreflang="en" href="https://ieeexplore.ieee.org/document/9229842">Fouad et al.</a>).

{{ figure_markup(
  image="cmp-services.png",
  caption="Servicios de Plataformas de Gestión del Consentimiento (CMP) más comunes",
  description="Gráfico de barras que muestra las CMP más comunes. El servicio CookieYes se encontró en el 2,0% de los sitios desde escritorio y en el 2,1% desde móvil; respectivamente, el servicio Osan se detectó en el 1,4% y el 1,4%, OneTrust en el 1,2% y el 0,9%, Cookiebot en el 1,0% y el 0,8%, Cookie Notice en el 0,6% y el 0,6%, iubenda en el 0,5% y el 0,5%, Complianz en el 0,5% y el 0,5%, Moove GDPR Consent en el 0,4% y el 0,4%, Quantcast Choice en el 0,4% y el 0,4%, y por último Borlabs Cookie se detectó en el 0,2% y el 0,3% de los sitios.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1774136411&format=interactive",
  sheets_gid="2107042211",
  sql_file="number_of_websites_using_each_cmp.sql"
  )
}}

Nuestro análisis muestra que el uso de CMP ha aumentando del 7% al 11% desde el año pasado. Un aumento de casi el 60%. Además, también vemos que este año el móvil está menos implicado que el escritorio, aunque la diferencia es mínima.
También vems que los proveedores CookieYes (18%), OneTrust (64%) y Cookiebot (56%) han aumentado su cuota de mercado desde el año pasado.

### Frameworks de consentimiento IAB

Al contrario que el GDPR, el <a hreflang="en" href="https://iabeurope.eu">Framework de Transparencia y Consentimiento IAB Europe (TCF)</a> es un estándar de la industria en el que están implicados <a hreflang="en" href="https://iabeurope.eu/vendor-list/">comerciantes globales</a>. El objetivo es establecer comunicación entre el consentimiento del usuario y los anunciantes. El TCF garantiza que los sitios web de Europa cumplen en l GDPR. El IAB Tech Lab US desarrolló las <a hreflang="en" href="https://iabtechlab.com/standards/ccpa/">U.S. Privacy Technical Specifications (USP)</a> para que los sitios de Estados Unidos usen el mismo concepto de TCF.

{{ figure_markup(
  image="iab-prevalence.png",
  caption="Sitios web con IAB.",
  description="Gráfico de barras que muestra los frameworks IAB más comunes. En total, el IAB se detectó en el  4,6% desde escritorio y en el 4,4% de los sitios desde móvil; respectivamente, el IAB USP se encontró en el 3,5% de escritorio y en el 3,4% de móvil, el IAB TCF en el 2,2% y 1,9% de los sitios, de los que el 2,1% y el 1,8% respectivamente eran versión 2, y el 0,4% y el 0,3% eran versión 1.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1149211507&format=interactive",
  sheets_gid="772029978",
  sql_file="number_of_websites_with_iab.sql"
  )
}}

Descubrimos que el 4,6% de los sitios en escritorio usan algún IAB, con el 3,5% usando USP y el 2,2% usando IAB. Se trata de un aumento del uso desde el año pasado. Queremos destacar que nuestras mediciones se hacen desde EEUU, por lo que según TCF, no es necesario mostrar ningún banner de consentimiento para las visitas que no provienen de la Unión Europea. Quizá sea esa la razón por la que identificamos más sitios con USP.

{{ figure_markup(
  image="iab-tcfv2-prevalence.png",
  caption="Top CMPs para IAB TCF v2.",
  description="Gráfico de barras que muestra los proveedores de CMP para IAB TCF version 2. Quantcast International Limited fue el proveedor de CMP provider en el 0,37% de los sitios de escritorio y en el 0,33% desde móvil, Google LLC en el 0,34% y 0.29%, Didomi en el 0,31% y 0,26%, 1020, Inc. dba Placecast y Ericsson Emodo en el 0,23% y 0,17%, iubenda en el 0,10% y 0,10%, Sourcepoint Technologies, Inc. en el 0,07% y 0,07%, y por último SIRDATA en el 0,06% y 0,07% sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1405483323&format=interactive",
  sheets_gid="1374296424",
  sql_file="most_common_cmps_for_iab_tcf_v2.sql",
  width="600",
  height="459"
  )
}}

Vemos que Quantcast International Limited (0.37%), Google LLC (0.34%) y Didomi (0.31%) son servicios CMP populares para IAB TCF v2.

{{ figure_markup(
  image="iab-publisher-countries.png",
  caption="Países de editores más comunes en IAB TCF v2.",
  description="Gráfico de barras que muestra los países de los editores que emplean IAB TCF v2. El país del editor fue desconocido para el 0,31% de los sitios en escritorio y el 0,29% en móvil, y en el 0,04% de los sitios el país del editor era Alemania, en el 0,04% de los sitios de escritorio y el 0,03% desde móvil el país era Estados Unidos, en el 0,03% y 0,02% la Unión Europea, y por último, en el 0,02% y 0,01% de los sitios era Reino Unido",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=1828110274&format=interactive",
  sheets_gid="1272054750",
  sql_file="most_common_countries_for_iab_tcf_v2.sql"
  )
}}

Nuestro análisis muestra que la mayoría de los editores identificados eran de Alemania, EEUU y la UE..

### Política de privacidad

Las notificaciones relacionadas con el procesamiento de datos no siempre se ubican en un banner de consentimiento. También suelen describirse con más detalle en páginas separadas. En estas páginas, se muestra información sobre los servicios de terceros empleados, qué información es empleada para cada fin, etc. Para identificar estas páginas, empleamos las señales relacionadas con la privacidad indicadas en <a hreflang="en" href="https://github.com/RUB-SysSec/we-value-your-privacy/blob/master/privacy_wording.json">este estudio</a>. Con este método, pudimos determinar que el 45% de los sitios desde escritorio (el 41% en móvil) contenía un enlace en su página inicial a una página relacionada con la privacidad. El siguiente gráfico muestra la distribución de las palabras contenidas en este enlace.

{{ figure_markup(
  image="privacy-link-keywords.png",
  caption="Palabras más usadas en los enlaces a las políticas de privacidad.",
  description="Gráfico de barras que muestra las palabras más usadas para referirse a la página de la política de privacidad del sitio. La palabra 'privacy' se usó en el 28,63% de los sitios desde escritorio y en el 22,95% desde móvil para enlazar a la página de privacidad, la palabra 'policy' en el 24,26% y 19,41% de los sitios, 'cookies' en el 8,19% y 7,90%, 'cookie policy' en el 3,63% y 3,30%, 'privacidad' en el 2,68% y 2,99%, 'datenschutz' en el 2,09% y 3,14%, 'mentions légales' en el 2,08% y 1,85%, 'privacidade' en el 1,66% y 1,76%, 'aviso legal' en el 1,35% y 1,65%, 'prywatności' en el 0,97% y 1,12%, y por último la palabra 'gdpr' se usó en el 0,99% y 0,94% de los sitios para enlazar a la política de privacidad.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRSnqWDZQ07x6NdnIix7JOfg5DqGcoTrrpwaKavCIvNFkIANncyMxahKaTYjLka3rsrcBmrRIURpnPo/pubchart?oid=817391735&format=interactive",
  sheets_gid="1284713488",
  sql_file="most_common_privacy_link_keywords.sql",
  )
}}

Vemos que "privacy" (29%), "policy" (24%) y "cookies" (8%) son las palabras más usadas en esos enlaces.

## Conclusión

En este capítulo, exploramos diferentes aspectos relacionados con nuestra privacidad online. Está claro que durante el pasado año cambiaron bastantes cuestiones que afectan a nuestra privacidad, y podemos esperar que este progreso continúe en los próximos años. Resumiendo, creemos que están por llegar cosas interesantes. Por un lado, vimos evoluciones desafortunadas, que esperemos que algún día no sean más que el pasado de la web. Rastreo de terceros, basado fundamentalmente en las cookies de terceros, aún es ubicuo: el 82% de los sitios web contienen al menos un rastreador. Además de esto, hay un número considerable de sitios o servicios web que emplean técnicas evasivas para eludir las medidas anti-rastreo.

Desde una perspectiva más positiva y pro-privacidad, vemos que hay menos sitios que tratan de acceder a información potencialmente sensible desde las APIs de nuestros navegadores. Confiemos en que este siga siendo el caso con las nuevas APIs de navegación que se están introduciendo.

Generalmente, parece que los sitios web están empezando a hacerse eco de las demandas de los usuarios con respecto a su privacidad, una demanda que cada vez es más fuerte. Cada vez hay más sitios que empiezan a usar funcionalidades del navegador para restringir la información que se envía a terceros. Además, motivados mayormente por leyes de privacidad como el GDPR y el CCPA, hemos visto un claro aumento —casi un 60%— en el uso de Plataformas de Gestión del Consentimiento, dando a los usuarios más control sobre qué información quieren compartir.

Finlamente, del lado de los navegadores, también vemos una fuerte evolución dirigida a ofrecer a los usuarios más control sobre su privacidad online. Junto con las funcionalidades que ya ofrecen varios navegadores especializados en privacidad, también está la iniciativa Privacy Sandbox que intenta seguir ofreciendo funcionalidades como publicidad dirigida, antifraude, atribución de compras, etc. sin el nefasto efecto secundario del rastreo a través de múltiples sitios. Aunque su desarrollo aún está en fase muy temprana, vemos que un número sustancial de sitios web ya están solicitando acceso a esta iniciativa a través de la Prueba de origen. Así, estas novedades se pueden testear de forma extensiva y tener más posibilidades de convertirse en una parte persistente de la web.

Aunque aún tardaremos un par de años en llegar ahí, estamos evolucionando hacia una web que da a los usuarios más control sobre lo que quieren compartir con terceros. Vemos esta convergencia en ambos lados del espectro; por un lado iniciada por el sitio web y por el otro forzada por el navegador. Con la esperanza de un mañana más respetuoso para todos, debemos confiar en que en un futuro no muy lejano los datos que compartimos serán los datos que queremos compartir y en que las rutas que seguimos día a día cuando navegamos por la web ya no serán recogidas, compartidas y analizadas por los numerosos rastreadores que hoy en día encontramos.
