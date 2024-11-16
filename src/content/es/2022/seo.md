---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: Capítulo de SEO del Web Almanac 2022 que cubre rastreabilidad, indexabilidad, experiencia de página, SEO on-page, enlaces, AMP, internacionalización y más.
hero_alt: Hero image of various web pages beneath a search field with Web Almanac characters shine a light on the pages and make various checks.
authors: [SophieBrannon, itamarblauer, mordy-oberstein]
reviewers: [patrickstox, TusharPol, mobeenali97, dwsmart, johnmurch]
analysts: [csliva, jroakes, derekperkins]
editors: [MichaelLewittes]
translators: [carloscastromx]
results: https://docs.google.com/spreadsheets/d/1qBQWxNKIAVJNOFwGlslT7AW0VAoK85Mf3nFvtw0QjVU/
SophieBrannon_bio: Sophie es Directora de Servicios al Cliente en la agencia británica Absolute Digital Media y está especializada en estrategia SEO y marketing de contenidos en sectores altamente competitivos como salud y finanzas. Sophie es ponente en conferencias y bloguera del sector, y cuenta con experiencia demostrada en la elaboración de estrategias y realización de campañas galardonadas a escala local, nacional e internacional.
itamarblauer_bio: Itamar Blauer es un experto SEO basado en Londres. Tiene un historial comprobado de aumentar el posicionamiento con SEO centrado en UX, respaldado por datos y creativo.
mordy-oberstein_bio: Mordy Oberstein es el Jefe de Branding SEO en Wix. También trabaja como consultor para SEMrush y se sienta detrás del micrófono de múltiples podcast sobre SEO, incluyendo el podcast SERP's Up.
featured_quote: La implementación de datos estructurados en el HTML de una página ha aumentado continuamente. En 2021, 41.8% de las páginas de escritorio y 42.5% de las páginas móviles usaban datos estructurados. En 2022, ha aumentado a 44% de las páginas de escritorio y 45.1% de páginas móviles que tienen datos estructurados en su HTML.
featured_stat_1: 84.75%
featured_stat_label_1: Sitios adoptando HTTPS
featured_stat_2: 66%
featured_stat_label_2: Sitios web que tienen implementada una etiqueta H1
featured_stat_3: 20%
featured_stat_label_3: Imágenes que usan propiedades de lazy loading
---

## Introducción

La Optimización para Motores de Búsqueda (SEO) es una técnica digital que se utiliza para mejorar la visibilidad de un sitio web o una página, de modo que se posicione orgánicamente más arriba en los resultados de los motores de búsqueda. Frecuentemente combina la configuración técnica, creación de contenido y la adquisición de enlaces, con el objetivo de mejorar la relevancia e intención de la búsqueda. El SEO ha seguido creciendo en popularidad y se ha convertido en uno de los canales de marketing digital más populares.

{{ figure_markup(
  image="seo-term-trends.png",
  caption="Google Trends comparando la popularidad de búsqueda direccional de los temas SEO frente a pago por clic, marketing en redes sociales y marketing por correo electrónico.",
  description="Captura de pantalla de Google Trends mostrando el fuerte interés tópico en SEO en comparación con otros canales de marketing digital; optimización para motores de búsqueda, pago por clic, marketing en redes sociales y marketing por correo electrónico. En términos de crecimiento relativo y absoluto, el SEO lidera por magnitudes.",
  width=2256,
  height=1492
  )
}}

Con métricas personalizadas que revelan información nueva y nunca antes vista, hemos analizado más de ocho millones de páginas de internet, comparando nuestros resultados con los de [2021](../2021/seo) y, en algunos casos, con los de [2020](../2020/seo). Nota: Nuestros datos, particularmente de Lighthouse y HTTP Archive, se limitan a las páginas de inicio de los sitios web, no a rastreos de todo el sitio. Conoce más sobre estas limitaciones en nuestra [Metodología](./methodology).

Continúa leyendo para saber más sobre la compatibilidad de la web con los motores de búsqueda.


## Rastreabilidad e Indexabilidad

El rastreo y la indexación son la columna vertebral de lo que Google y otros motores de búsqueda muestran en última instancia en sus páginas de resultados. Sin ellos, la clasificación es imposible.

El primer paso en el proceso es descubrir páginas web a través del rastreo. Aunque se rastrean muchas páginas, son menos las que se indexan, que son básicamente almacenadas y clasificadas en la base de datos de un motor de búsqueda. Basado en la consulta del usuario, se muestran las páginas indexadas coincidentes.

Esta sección trata del estado de la web, en términos de los robots que rastrean e indexan sitios web. ¿Qué directrices dan los sitios a los robots de motores de búsqueda? ¿Qué hacen los sitios para garantizar que Google ofrezca la página correcta y no una duplicada en los resultados de búsqueda?

Exploremos la web y algunas de sus facetas que influyen en la rastreabilidad e indexabilidad.

### Robots.txt

El archivo robots.txt indica a los robots, incluyendo a los rastreadores de los motores de búsqueda, dónde pueden ir y dónde no, es decir, qué pueden rastrear y qué no.


#### Códigos de estado de Robots.txt

{{ figure_markup(
  image="robots-txt-status-codes.png",
  caption="Códigos de estado de Robots.txt.",
  description="Gráfico de barras que muestra el porcentaje de páginas con un archivo robots.txt válido. 82.4% de los sitios móviles cuentan con un código de estado 200, y 15.8% devuelven un código de estado 404 mientras un pequeño porcentaje de 0.2% devuelven un código de estado 403 y 0.1% devuelven un código de estado 500. Para escritorio es muy similar con 81.5%, 16.5%, 1.6%, 0.3% y 0.1%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=240883913&format=interactive",
  sheets_gid="258446623",
  sql_file="robots-txt-status-codes.sql"
  )
}}

Se ha producido un incremento nominal en el porcentaje de sitios cuyos archivos robots.txt devuelven un código de estado 200 en 2022 comparado con 2021. En 2022, 81.5% de los archivos robots.txt para sitios de escritorio devolvieron un código de estado 200 mientras que el 82.4% de los sitios móviles devolvieron lo mismo. Esto contrasta con el 81% y 81.9% de los archivos robots.txt en sitios de escritorio y móviles, respectivamente, que devolvieron un código de estado 200 en 2021.

Al mismo tiempo, hubo una pequeña reducción en el porcentaje de archivos robots.txt que devuelven un código de estado 404 en 2022 comparado con 2021. El año pasado, 17.3% de los archivos robots.txt en sitios de escritorio devolvieron un código de estado 404 mientras 16.5% de los archivos robots.txt en sitios móviles devolvieron el mismo código de estado. En 2022, solo el 16.5% de sitios de escritorio y 15.8% sitios móviles tienen archivos robots.txt que devuelven un código de estado 404.

Al igual que en 2021, el resto de los códigos de estado están asociados a un número mínimo de archivos robots.txt.

Nota: Los datos anteriores no indican que tan bien optimizado está un archivo robots.txt. Aún si el archivo devuelve un código de estado 200 puede contener directivas que tal vez no beneficien la salud general del sitio.

#### Tamaño de Robots.txt

{{ figure_markup(
  image="robots-size.png",
  caption="Tamaño de Robots.txt.",
  description="Tabla de distribución que muestra las diferencias de los tamaños de robots.txt en incrementos de 100 kilobytes. Para escritorio, 96.29% están en el rango de 0-100 KB, 0.31% en 100-200 KB, 0.10% en 200-300 KB, 0.04% en 300-400 KB, 0.02% en 400-500 KB, 0.05% son superiores a 500 KB, y finalmente falta un 2.26%. Para móviles, 96.48% están en el rango de 0-100 KB, 0.30% en 100-200 KB, 0.12% en 200-300 KB, 0.04% en 300-400 KB, 0.02% en 400-500 KB, 0.05% son superiores a 500 KB, y finalmente falta un 1.97%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1600078634&format=interactive",
  sheets_gid="1828205691",
  sql_file="robots-text-size.sql"
  )
}}

Como se esperaba, la abrumadora mayoría de los archivos robots.txt eran bastante pequeños, con un peso de entre 0-100 KB.

El límite máximo de Google para un archivo robots.txt es de 500 KiB. Cualquier directiva que se encuentre después de que el archivo alcance este límite será ignorada por el motor de búsqueda. Un pequeño número de archivos robots.txt entran en esta categoría. Concretamente, solo .005% de sitios de escritorio y móviles contienen un archivo robots.txt que es mayor al límite máximo de Google (lo cual es consistente con los datos del 2021). En casos donde el archivo excede los límites, <a hreflang="en" href="https://developers.google.com/search/docs/advanced/robots/robots_txt">Google recomienda</a> consolidar las directivas.

#### Uso de user-agent en Robots.txt

{{ figure_markup(
  image="robots-useragents.png",
  caption="Uso de user-agent en Robots.txt.",
  description="Gráfico de barras que muestra los user agent más comunes en archivos robots.txt. Para escritorio `*` es 74.9%, `adsbot-google` es 6.8%, `mj12bot` es 6.0%, `ahrefsbot` es 5.4%, `mediapartners-google` es 3.4%, `nutch` es 3.7%, `googlebot` es 3.3%, `pinterest` es 3.3%, `adsbot-google-mobile` es 2.8%, `ahrefssiteaudit` es 3.2%, `yandex` es 2.9%, `bingbot` es 2.6%, `semrushbot` es 2.2%, `baiduspider` es 1.8%, y finalmente `dotbot` es 1.5%. En móviles es casi idéntico con 76.1%, 7.0%, 6.0%, 5.3%, 4.5%, 3.5%, 3.3%, 3.1%, 3.3%, 2.9%, 3.0%, 2.5%, 2.3%, 1.8%, y 1.7%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1197419046&format=interactive",
  sheets_gid="184863489",
  sql_file="robots-txt-user-agent-usage.sql",
  width=600,
  height=499
  )
}}

Hoy en día, la mayoría de los sitios web (74.9% en escritorio y 76.1% en móvil) no indican un user-agent específico en el archivo robots.txt, lo que significa que las directivas en el archivo aplican a todos los user-agents. Esto es consistente con datos de 2020 donde 74% de los archivos robots.txt de escritorio y 75.2% de los archivos robots.txt en móvil no especificaron un user-agent específico.

Curiosamente, Bingbot no apareció en los 10 user-agents más especificados. En cuanto a herramientas SEO, similar al 2021, los bots de Majestic y Ahrefs estuvieron en el top 5 de user-agents más especificados, mientras el bot de Semrush aparece en los 15 user-agents más usados.

En términos de motores de búsqueda, Googlebot lidera con 3.3% de los archivos robots.txt especificándolo como user-agent mientras Bingbot cuenta con 2.5%. Curiosamente, hubo una diferencia de casi un punto porcentual en 2021 entre los archivos robots.txt móviles y de escritorio que usan Bingbot. No es el caso en 2022 donde los datos son esencialmente uniformes.

Cabe destacar que Yandexbot solo se especificó en el 0.5% de los archivos robots.txt en 2021. Para 2022, se multiplicó por seis, con 3% de los archivos especificando a Yandexbot.

### Etiqueta `IndexIfEmbedded`

En Enero del 2022, Google introdujo una nueva etiqueta robots llamada _indexifembedded_. La etiqueta ofrece control sobre la indexación cuando el contenido está incrustado en un iframe en una página, aun cuando una etiqueta noindex ha sido aplicada.

Empecemos por determinar el porcentaje de páginas para las que la nueva etiqueta es posiblemente aplicable.

{{ figure_markup(
  image="pages-with-iframe.png",
  caption="Páginas con `<iframe>`.",
  description="Gráfico de pastel mostrando un 4.1% de páginas móviles que utilizan un iframe dentro del contenido analizado, mientras que el 95.9% no usan un iframe.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1839527748&format=interactive",
  sheets_gid="1009024750",
  sql_file="robots-meta-usage.sql"
  )
}}

Poco más del 4% de las páginas contienen un elemento `<iframe>`. Del 4.1% de las páginas que contienen el elemento, 76% de ellas tienen no indexado el iframe, convirtiéndolos en un posible caso de uso para la nueva etiqueta `indexifembedded`.

Sin embargo, un porcentaje minúsculo de sitios han adoptado la etiqueta robots `indexifembedded`. La etiqueta sólo aparece en el 0.015% de las páginas analizadas.

De las páginas que han adoptado la etiqueta `indexifembedded`, el 98.3% de ellas la implementaron en el header mientras 66.3% están usando el HTML.

{{ figure_markup(
  image="indexifembedded-useragents.png",
  caption="User agents de `Indexifembedded`.",
  description="Gráfico de barras mostrando la mayoría de las implementaciones de `indexifembedded` que usan un robots header en un 98.3% y usan el user agent `googlebot`. Los otros tres user agents (`google`, `gogglebot-news`, y `robots`) muestran un uso del 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=994494235&format=interactive",
  sheets_gid="1009024750",
  sql_file="robots-meta-usage.sql"
  )
}}

### Elementos inválidos en head

El elemento `<head>` sirve como el contenedor para los metadatos de una página. Desde un punto de vista SEO, el título y meta descripción de una página residen dentro del elemento `<head>`, así como las meta etiquetas robots.

Sin embargo, no todos los elementos pertenecen en el `<head>`. Si Google encuentra un elemento inválido en el `<head>`, asume que ha llegado al final de `<head>` y <a hreflang="en" href="https://developers.google.com/search/docs/advanced/guidelines/valid-html">no descubrirá el resto de su contenido</a>.

Nuestros datos del 2022 muestran que 12.7% de las páginas de escritorio y 12.6% de las páginas móviles contienen un elemento inválido en el `<head>`.

{{ figure_markup(
  image="invalid-head-elements.png",
  caption="Elementos inválidos en `<head>`.",
  description="Gráfica de barras que muestran el porcentaje de páginas con varios elementos HTML que son inválidos en el `<head>`. En escritorio, `img` es usado en el head en el 9.92% de las páginas, `div` en 3.58%, `a` en 1.73%, `p` en 1.11%, `span` en 1.08%, `iframe` en 0.96%, `br` en 0.94%, `input` en 0.78%, `li` en 0.63%, y finalmente `ul` 0.63%. En móvil es muy similar con 9.77%, 3.91%, 1.93%, 1.32%, 1.30%, 1.13%, 1.12%, 1.05%, 0.90%, y 0.90% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=2061840642&format=interactive",
  sheets_gid="130501136",
  sql_file="invalid-head-elements.sql"
  )
}}

El elemento más mal aplicado en el `<head>` por mucha diferencia es el elemento `<img>`. Es incorrectamente colocado dentro del `<head>` en el 9.7% de las páginas móviles y 9.9% de las páginas de escritorio.

El elemento `<div>` es el único otro elemento mal aplicado que aparece dentro del `<head>` en más del 3% de las páginas del conjunto de datos de 2022. Es incorrectamente aplicado al `<head>` en 3.5% de las páginas de escritorio y 3.9% de las páginas móviles.

## Etiquetas Canonical

Las etiquetas canonical son tradicionalmente usadas para definir páginas de contenido duplicado y ayudan a los motores de búsqueda a priorizar. Son un fragmento de código HTML (`rel="canonical"`) que permite a los webmasters definir al motor de búsqueda cuál es la versión "preferida". No son directivas, sino que actúan como "pistas". Por lo tanto, los motores de búsqueda como Google determinan por su cuenta la versión canónica de una página, basándose en que tan útil creen que sea la página para el usuario. Las etiquetas canonical también pueden ser usadas para consolidar otras señales como enlaces, así como simplificar métricas de seguimiento y gestionar mejor el contenido sindicado.

{{ figure_markup(
  image="canonical-usage.png",
  caption="Uso de Canonical.",
  description="Gráfico de barras que destaca los porcentajes de páginas que tienen una etiqueta canonical o están canonicalizadas a otras. La adopción del canonical es de 58.7% en escritorio y 60.6% en móvil y las páginas canonicalizadas son de 4.2% en escritorio y 7.5% en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=34038632&format=interactive",
  sheets_gid="1931314929",
  sql_file="pages-canonical-stats.sql"
  )
}}

Vemos en los datos que el uso de etiquetas canonical ha aumentado a lo largo de los años. En 2019, 48.3% de las páginas móviles usaban canonical. En 2020, esto creció a 53.6%. En 2021, esto creció aún más a 58.5%. Y en 2022, ha aumentado a 60.6%.

En dispositivos móviles hay un mayor porcentaje de atribución de canonical que en escritorio (60.6% vs. 58.7%), lo que probablemente sea consecuencia directa de URLs de uso único en dispositivos móviles. Debido a que el conjunto de datos de este capítulo está limitado a páginas de inicio, es justo asumir que esta es la razón para la mayor atribución de canonical en móvil. Según las <a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls">directrices de Google</a>, tener un sitio móvil independiente no es recomendado.

### Uso de canonical HTML vs. HTTP

Hay dos maneras de implementar etiquetas canonical:

1. En el `<head>` HTML
2. En los encabezados HTTP (encabezado HTTP `Link`)

{{ figure_markup(
  image="html-versus-http-canonical.png",
  caption="Uso de Canonical en HTML vs HTTP.",
  description="Gráfico de barras que compara las implementaciones de canonical entre HTML y encabezados HTTP. Las canonical en HTML son el método principal de implementación con 58.6% en escritorio y 60.4% en móvil apareciendo en el código de la página, comparado con 1.2% y 0.9% en encabezados HTTP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1403695913&format=interactive",
  sheets_gid="1931314929",
  sql_file="pages-canonical-stats.sql"
  )
}}

La implementación más común tanto en escritorio como en móvil es a través del HTML con 58.6% y 60.4%, respectivamente. Es probable que esto se deba a la facilidad de implementación. Mientras una requiere un conocimiento básico de HTML, el otro método (a través de encabezados HTTP) requiere conocimientos más técnicos.

### Uso de código fuente vs. renderización

{{ figure_markup(
  image="raw-vs-rendered-canonical.png",
  caption="Canonical en código fuente vs. renderizado.",
  description="Gráfico de barras que compara el canonical en el código fuente, en renderización y en HTTP. El uso de canonical en el código fuente es de 57.9% en páginas de escritorio, en la renderización es de 58.6%, en renderizado pero no en el código fuente en 0.7%, el renderizado cambió el canonical en 2.2%, y el encabezado HTTP cambió el canonical en 0.4% en escritorio. En móviles es muy similar con 59.4%, 60.4%, 1.0%, 1.9%, y 0.3% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=473608668&format=interactive",
  sheets_gid="1931314929",
  sql_file="pages-canonical-stats.sql"
  )
}}

Comparado con 2021, donde el uso de canonical en el código fuente fue de 57.7% y el uso de canonical renderizada fue de 57.7%, en 2022 hubo algo de crecimiento, con el uso del canonical en código fuente alcanzando un 59.4% y el uso del canonical en renderizado se elevó a 60.4%. Esto se correlaciona con el crecimiento del uso de canonical en general.

## Experiencia de página

En esta sección del capítulo, analizaremos los diferentes elementos de la experiencia de página y cómo han evolucionado desde el Web Almanac 2021.

### HTTPS

En 2021, se prestó más atención a la velocidad de carga y la experiencia de página tras la introducción de la actualización de Google sobre Core Web Vitals, que se había anunciado e impulsado a lo largo del 2020. Aunque la evidencia de que HTTPs es un factor de posicionamiento <a hreflang="en" href="https://developers.google.com/search/blog/2014/08/https-as-ranking-signal">se remontan a 2014</a>, la atención general prestada a la experiencia de página desde el anuncio de los Core Web Vitals probablemente haya tenido un impacto en la adopción de HTTPs en la web.

{{ figure_markup(
  image="https-usage.png",
  caption="Porcentaje de sitios que soportan HTTPs.",
  description="85% de los sitios de escritorio y 88% de los sitios móviles usan HTTPs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=115976742&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

Los datos muestran que más sitios están usando un certificado seguro (HTTPS) al momento de rastreo (teniendo en cuenta los vencimientos de estos certificados). En 2021, 84.3% de las páginas de escritorio usaban HTTPs, y aumentó a 87.71% en 2022. En móvil, esto aumentó de 81.2% en 2021 a 84.75% en 2022. Desde el anuncio de la actualización de los Core Web Vitals en 2020 al presente se ha producido un incremento de casi 11% en móvil y 10% en escritorio.

### Compatibilidad móvil

La compatibilidad móvil puede ser determinada al comparar la implementación de diseño responsivo vs. publicación dinámica. Para identificar esto, nos fijamos en el uso de la meta etiqueta viewport que es comúnmente usado en el diseño responsivo vs. el encabezado vary: User-Agent para determinar si un sitio usa publicación dinámica.

### Meta etiqueta viewport

{{ figure_markup(
  caption="Sitios que usan una meta etiqueta viewport.",
  content="92%",
  classes="big-number",
  sheets_gid="1858203218",
  sql_file="meta-tag-usage-by-name.sql"
)
}}

Hemos visto un aumento en el uso de la meta etiqueta viewport de 91.1% de páginas móviles usando meta etiqueta viewport en 2021 a 92% hoy en día. En 2020, estaba en 89.2%

### Uso de encabezado vary

El encabezado vary es un encabezado HTTP que permite mostrar diferente contenido a los usuarios en diferentes dispositivo. Esto se conoce como publicación dinámica, y es lo opuesto al diseño responsivo, que sirve el mismo contenido, pero a diferentes dispositivos.

{{ figure_markup(
  image="vary-header.png",
  caption="Uso del encabezado vary.",
  description="Gráfico de barras que compara si se usa o no el encabezado vary. Los encabezados vary son implementados en 12% de los sitios de escritorio y 13% de los sitios móviles, y 88% y 87% respectivamente no lo están usando.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1832557145&format=interactive",
  sheets_gid="942102950",
  sql_file="html-response-vary-header-used.sql"
  )
}}

El uso del encabezado vary se ha mantenido relativamente estable en los últimos años. En 2021, 12.6% de páginas en escritorio y 13.4% en móvil lo implementan. En 2022, los datos son muy similares con 12% en escritorio y 13% en móviles.

### Tamaños de fuente legibles

En 2021, 13.5% de las páginas móviles no estaban usando un tamaño de fuente legible. Gracias al enfoque de Google en la experiencia de usuario en todos los dispositivos, más páginas utilizan ahora un tamaño de fuente legible. Solo 11% de las páginas móviles aún no usan un tamaño de fuente legible.

{{ figure_markup(
  caption="Sitios que no usan un tamaño de fuente legible.",
  content="11%",
  classes="big-number",
  sheets_gid="74703616",
  sql_file="lighthouse-seo-stats.sql"
)
}}

### Core Web Vitals (CWV)

Los Core Web Vitals fueron un tema importante en SEO a lo largo del 2021 después de que Google anunciara el lanzamiento de su actualización de Experiencia de Página en junio de ese año. Este año hemos observado un interés continuo, con más sitios prestando atención al rendimiento de sus Core Web Vitals.

Los Core Web Vitals son una serie de métricas estandarizadas que ayudan a desarrolladores y SEOs a comprender mejor la experiencia de usuario en una página. Las métricas principales son:

* Largest Contentful Paint (LCP) mide que tan rápido carga el contenido principal de una página web
* First Input Delay (FID) mide cuánto tarda desde que el usuario interactúa con la página (i.e. hace clic en un botón) hasta que el navegador es capaz de responder
* Cumulative Layout Shift (CLS) mide la estabilidad visual y si una página se mueve dentro del viewport

Estas tres métricas son fundamentales para la experiencia de usuario y la estabilidad de una página web.

Los datos para los Core Web Vitals provienen del Reporte de Experiencia de Usuario de Chrome (CrUX). El reporte se basa en un conjunto de datos públicos de usuarios reales (registrados), y de millones de sitios web (contrario a los datos de laboratorio, que son simulados).

{{ figure_markup(
  image="good-cwv-mobile.png",
  caption="Porcentaje de buenas experiencias CWV móviles.",
  description="Gráfico de series de tiempo que muestra las mejoras de los Core Web Vitals móviles a través del tiempo y todas han tendido a la alza. 39% de los sitios móviles entran ahora en la categoría buena de los Core Web Vitals. 51% tienen un buen LCP, 74% tienen un buen CLS, y 92% tienen un buen FID.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1140903870&format=interactive",
  sheets_gid="1713598891",
  sql_file="core-web-vitals.sql"
  )
}}

En móvil, 39% de los sitios aprueban los CWV, que es un aumento respecto al 29% del 2021 y del 20% en 2020. Y mientras que el 92% de los sitios actualmente pasan el FID, la mayoría de los dueños de sitios tienen problemas con LCP, que tiene un porcentaje de aprobación de 51%.

{{ figure_markup(
  image="good-cwv-desktop.png",
  caption="Porcentaje de buenas experiencias CWV en escritorio.",
  description="Gráfico de series de tiempo que muestra las mejoras de Core Web Vitals en escritorio a través del tiempo y todas de ellas tienden a la alza excepto el FID que está estable al 100% durante todo el periodo. 43% de los sitios de escritorio se clasifican como buenos dentro de los Core Web Vitals. 63% tienen buen LCP, 65% tiene buen CLS, y 100% tiene buen FID.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1399758157&format=interactive",
  sheets_gid="1713598891",
  sql_file="core-web-vitals.sql"
  )
}}

En escritorio, vemos un sorprendente 100% de sitios que aprueban FID, aunque presentan dificultades para pasar LCP y CLS. Cabe destacar, más los sitios aprueban los CWV en escritorio (43%) que en móvil (39%).

### Iframes con `lazy` loading vs. `eager` loading

Lazy loading es una técnica que aplaza la carga de elementos no críticos en una página web hasta el punto en el que son necesarios. Esto puede ayudar a reducir el peso de la página, así como conservar el ancho de banda y recursos de sistema. Eager loading es cuando las entidades relacionadas se cargan y obtienen simultáneamente.

{{ figure_markup(
  image="iframe-loading.png",
  caption="Uso de propiedades loading en `iframe`",
  description="Gráfico de barras que muestra las propiedades loading de `iframe` entre `lazy`, `auto`, `eager`, o ninguna. No está presente en 95.30% de las páginas de escritorio, `lazy` es usado en 3.67%, `auto` en 0.74%, `eager` en 0.29%, y es inválido en 0.00%, y vacío en 0.00% de las páginas. En móvil es casi idéntico con 94.94%, 4.08%, 0.60%, 0.37%, 0.00%, y 0.00% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1451716640&format=interactive",
  sheets_gid="246694365",
  sql_file="iframe-loading-property-usage.sql"
  )
}}

Cuando miramos únicamente a los iframes, vemos que lazy loading es preferido mucho más que eager loading, con 4.08% de iframes usando lazy loading frente a 0.37% de iframes usando eager loaded.

Esto es particularmente interesante desde que <a hreflang="en" href="https://web.dev/iframe-lazy-loading/">lazy loading para iframes en el navegador se ha estandarizado en Chrome</a>. La estandarización del atributo `loading` sin especificar lazy o eager, es probablemente la razón de que los datos muestren un 94.4% de atributos que no contienen lazy o eager.

## On page

Al buscar señales de relevancia, los motores de búsqueda se fijan en el contenido de una página web. Hay varios elementos de SEO on-page que pueden afectar el posicionamiento y/o apariencia en las SERPs (Páginas de Resultados de Motores de Búsqueda).

### Metadatos

{{ figure_markup(
  image="has-title-meta.png",
  caption="Etiqueta title y meta descripciones.",
  description="Gráfico de barras con porcentaje de páginas que contienen una etiqueta title y meta descripción. 98% de páginas tienen un título y 71% de las páginas tienen una meta descripción, y es el mismo caso en escritorio y móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1299529015&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

Por segundo año consecutivo, 98.8% de las páginas de escritorio y móviles tenían elementos `<title>`. También en 2022, 71% de las páginas principales de escritorio y móviles tienen etiquetas `<meta name="description">` tags, un 0.1% menos que el año pasado.

#### Elemento `<title>`

El elemento `<title>` es un factor de posicionamiento on-page que brinda una pista importante sobre la relevancia de una página y puede aparecer en la SERP. En Agosto de 2021, <a hreflang="en" href="https://developers.google.com/search/blog/2021/08/update-to-generating-page-titles">Google empezó a reescribir más títulos de sitios en sus resultados de búsqueda</a>.

{{ figure_markup(
  image="title-words-percentile.png",
  caption="Palabras en el título por percentil.",
  description="Distribución del conteo de palabras dentro de los títulos de página. El promedio de palabras en los títulos es de 6 palabras tanto en escritorio como en móvil. En el percentil 10 es 1 para escritorio y 2 para móviles, en el percentil 25 es 3 palabras para ambos, en el percentil 75 son 9 palabras para ambos y en el percentil 90 son 12 palabras para ambos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1674970307&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

{{ figure_markup(
  image="title-characters-percentile.png",
  caption="Caracteres en el título por percentil.",
  description="Distribución de conteo de caracteres en los títulos de página. El promedio de caracteres para títulos es de 39 caracteres en escritorio y 40 caracteres en móvil. En el percentil 10 es de 12 caracteres para ambos, en el percentil 25 es de 21 caracteres para ambos, en el percentil 75 es de 59 caracteres para ambos, y en el percentil 90 es de 74 caracteres para escritorio y 75 para móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1110487580&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

En 2022:

* En promedio, el `<title>` de una página contiene 6 palabras.
* En promedio, el `<title>` contiene 39 y 40 caracteres en escritorio y móvil respectivamente.
* 10% de las páginas tienen elementos `<title>` con 12 palabras.
* 10% de las páginas de escritorio y móviles tienen elementos `<title>` que contienen 74 y 75 caracteres respectivamente.

Estas estadísticas se mantienen sin cambio desde el año pasado. Nota: Estos títulos en las páginas de inicio tienden a ser más cortos que los de las páginas más profundas

#### Etiqueta de meta descripción

La etiqueta `<meta name="description>` no impacta directamente el posicionamiento. Sin embargo, puede aparecer como la descripción de la página en las SERPs, y puede influenciar el CTR.

{{ figure_markup(
  image="meta-description-words-percentile.png",
  caption="Palabras de meta descripción por percentil.",
  description="Distribución del conteo de palabras dentro de las meta descripciones en escritorio y móvil. Son idénticos para ambos. El promedio de palabras es de 19 palabras para meta descripciones. En el percentil 10 es de 2 palabras, en el percentil 25 es de 9 palabras, en el percentil 75 es de 25 palabras y en el percentil 90 es de 35 palabras.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1883941031&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

{{ figure_markup(
  image="meta-description-characters-percentile.png",
  caption="Caracteres de meta descripción por percentil.",
  description="Distribución de conteo de caracteres dentro de meta descripciones. El promedio es de 137 caracteres en escritorio y 136 caracteres en móvil para meta descripciones. En el percentil 10, es de 33 caracteres para escritorio y 33 para móvil, en el percentil 25 es de 80 y 75 respectivamente, en el percentil 75 es de 160 caracteres para ambos y en el percentil 90 es de 232 caracteres para ambos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1915861678&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

En 2022:

* En promedio, la etiqueta `<meta name="description>` en páginas de escritorio y móviles contienen 19 palabras.
* En promedio, la etiqueta `<meta name="description>` en páginas de escritorio y móviles contienen 137 y 136 caracteres respectivamente.
* 10% de las páginas de escritorio y móviles tienen etiquetas `<meta name="description>` con 35 palabras.
* 10% de las páginas de escritorio y móviles tienen etiquetas `<meta name="description>` con 232 caracteres.

En su mayoría, estas estadísticas se mantuvieron relativamente sin cambios respecto al año pasado.

#### Etiquetas de encabezado

Los elementos de encabezado (`<h1>`, `<h2>`...) son partes importantes de la estructura de una página, ya que ayudan a organizar el contenido de la página. Los elementos de encabezado no son un factor de posicionamiento directo, pero pueden ayudar a Google a entender mejor el contenido que se encuentra en la página.

{{ figure_markup(
  image="has-h-elements.png",
  caption="Presencia de elementos H.",
  description="Gráfico de barras que muestra el uso de etiquetas H1 hasta etiquetas H4. En escritorio, 66% de las páginas tienen una etiqueta H1, 73% una etiqueta H2, 62% una etiqueta H3 y 38% una etiqueta H4. Los porcentajes son idénticos en móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=46522676&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

Las tendencias de implementación de encabezados por tipo en 2022 se asemejan mucho a las de 2021, con solo unas pequeñas diferencias. Por ejemplo, 71.9% de las páginas móviles utilizaban un h2 en 2021 mientras 73.02% lo hicieron en 2022.

Otra tendencia que se ha mantenido es la discrepancia en el uso entre h1 y h2. Mientras 72.7% de las páginas de escritorio implementan un h2, solo 65.8% usan un h1 (con números similares reflejados en móvil).

Aunque no hay una explicación definitiva para esto, una posible razón es que el h1 se coloca a menudo antes de cualquier contenido. No es esencial para el flujo natural del contenido. Sin embargo, sin el h2, puede haber un flujo largo de contenido no estructurado.

{{ figure_markup(
  image="nonempty-h-elements.png",
  caption="Presencia de elementos H no vacíos.",
  description="Gráfico de barras que muestra el uso de etiquetas H1 a H4 no vacías. En escritorio, 58% de las páginas tienen una etiqueta H1 no vacía, 72% una etiqueta H3 no vacía, 61% una etiqueta H3 no vacía y 37% una etiqueta H4 no vacía. Los porcentajes son muy similares en móviles con 59%, 71%, 60% y 37% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1398855380&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

En general, similar a las estadísticas del 2021, hay relativamente pocos elementos H encontrados en las páginas. Adicionalmente, hay una pequeña discrepancia entre los datos de escritorio y móvil.

Sin embargo, hay divergencias con h1. Mientras 65.8% de las páginas contienen un elemento H1, 58.5% contienen un elemento h1 no vacío. Esto representa una diferencia de 7.3 puntos porcentuales. A diferencia del h2, que solo tuvo una diferencia porcentual de 1.5. Como fue mencionado en el Web Almanac 2021, esto puede deberse a que muchos sitios web incluyen imágenes de logotipos en el elemento h1 de las páginas de inicio.

### Atributos de imagen

El objetivo principal del atributo alt en el elemento `<img>` es la accesibilidad. Los atributos alt también ayudan a los motores de búsqueda a posicionar recursos específicos en las búsquedas de imágenes.

{{ figure_markup(
  image="image-alt-present.png",
  caption="Porcentaje de atributos `alt` en `img`.",
  description="Gráfica de distribución de páginas con etiquetas img que implementan atributos alt. El uso promedio de imágenes con atributos alt es de 56% en escritorio y 54% en móvil. En el percentil 10 es de 0% para ambos, en el percentil 25 es de 16% y 14%, en el percentil 75 es de 92% y 91%, y en el percentil 90 es de 100% para ambos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1932752526&format=interactive",
  sheets_gid="1161905146",
  sql_file="image-alt-stats.sql"
  )
}}

{{ figure_markup(
  image="image-alt-empty.png",
  caption="Porcentaje de `img` con atributo `alt` vacío.",
  description="Gráfica de distribución de páginas con una etiqueta img que implementan atributos alt vacíos. Como promedio, 0% de las imágenes tanto en escritorio como en móvil tienen un atributo alt vacío, haciéndolo poco común. En el percentil 75 esto aumenta a 24% de imágenes en ambos dispositivos y en el percentil 90 es de 75% en escritorio y 79% en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1460266248&format=interactive",
  sheets_gid="1161905146",
  sql_file="image-alt-stats.sql"
  )
}}

{{ figure_markup(
  image="image-alt-missing.png",
  caption="Porcentaje de imágenes sin `alt`.",
  description="Gráfica de distribución de páginas con imágenes sin atributos alt. El promedio de imágenes sin atributo alt es de 12% en escritorio y 13% en sitios móviles. En el percentil 10 y 25 es de 0% en ambos casos, pero arriba del promedio en el percentil 75 es de 51% en escritorio y 53% en móvil. Finalmente, en el percentil 90 es de 86% en escritorio y 87% en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=986554040&format=interactive",
  sheets_gid="1161905146",
  sql_file="image-alt-stats.sql"
  )
}}

Lo que encontramos:

- En la página de escritorio promedio, 56.25% de etiquetas `<img>` tienen un atributo alt. Esto representa un inapreciable retroceso de apenas un cuarto de punto porcentual con respecto al 56.5% de 2021.
- En la página móvil promedio, 54.9% de etiquetas `<img>` tienen un atributo alt. Esto es un aumento marginal respecto al 54.6% de etiquetas con atributo alt en 2021.
- Hay un cambio notable en las páginas de escritorio y móvil promedio que contienen etiquetas `<img>` con atributos alt vacíos comparado con 2021. El año pasado, las páginas de escritorio y móvil promedio tenían, respectivamente, 10.5% y 11.8% de etiquetas `<img>` con atributos `alt` vacíos. En 2022, esta cifra aumentó a 12.1% y 12.5% para escritorio y móvil respectivamente.
- La tendencia del 0% de las páginas de escritorio y móviles promedio que contienen etiquetas `<img>` con atributo alt faltante continúa. En 2021, en la página de escritorio promedio había un 1.4% de etiquetas `<img>` con atributos vacíos. Se redujo a 0% en 2022.

### Uso de la propiedad `loading` en imágenes

El atributo loading aplicado a los elementos `<img>` influye en la forma en la que los agentes de usuario priorizan el renderizado y representación de imágenes. Esta implementación puede impactar la experiencia de usuario y el tiempo de rendimiento, con posibles efectos tanto en el éxito SEO y conversiones.

{{ figure_markup(
  image="image-loading-property.png",
  caption="Uso de propiedad `loading` en imágenes.",
  description="Gráfico de barras que muestra la adopción de la propiedad loading en imágenes. 20% de imágenes han adoptado el lazy loading nativo, 78% no usan el atributo, y 2% establecen el valor `eager`. 0% establecen el valor `auto` o `blank`. Los números son idénticos en escritorio y móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1909677331&format=interactive",
  sheets_gid="166283668",
  sql_file="image-loading-property-usage.sql"
  )
}}

Lo que encontramos:

- Se ha reducido considerablemente el número de páginas que no utilizan ninguna propiedad de carga de imágenes. En 2021, 83.3% de las páginas de escritorio y 83.5% de las páginas móviles no utilizaban ninguna propiedad de carga de imágenes. Ahora es de 78.3% en páginas de escritorio y 77.9% en páginas móviles en 2022.
- Por el contrario, la implementación de loading="lazy" ha aumentado. En 2021, el 15.6% de páginas de escritorio y móviles implementaron loading="lazy". Esto ha aumentado a 19.8% (escritorio) y 20.3% (móvil) en 2022.
- El número de páginas que utilizan el método de carga predeterminado de los navegadores ha disminuido en 2022. En escritorio .07% de las páginas usan loading="auto" y .08% en móvil. En 2021, .01% de páginas utilizaban loading="auto".

### Conteo de palabras

Aunque la longitud del contenido no es un factor de posicionamiento, sigue siendo valioso evaluar cuántas palabras contiene una página en promedio.

#### Conteo de palabras en renderizado

Empecemos con el número de palabras que se encuentran en la página una vez que se ha renderizado.

{{ figure_markup(
  image="visible-words-rendered.png",
  caption="Palabras visibles renderizadas por percentil.",
  description="Distribución del recuento de palabras de contenido visible. En móvil, el promedio de número de palabras es de 412 en escritorio y 366 palabras en móvil. Hay un número similarmente menor en las palabras de móvil en otros percentiles por encima y debajo del promedio: en el percentil 10 son 88 palabras en escritorio y 77 en móvil, en el percentil 25 es de 209 y 179 respectivamente, en el percentil 75 es de 763 y 677 y en el percentil 90 es de 1,305 y 1,166.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1348358716&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

La página de escritorio promedio en 2022 contiene 421 palabras. Esto es muy cercano a las 425 palabras encontradas en 2021. Sin embargo, sigue siendo un gran salto porcentual respecto a lo que encontramos en 2020 cuando se encontró que en la página de escritorio promedio había 402 palabras. Sea cual sea la causa del aumento del conteo de palabras renderizadas en 2021, parece haberse mantenido a lo largo del 2022.

Similarmente, el número promedio de palabras renderizadas en móvil en 2022 es de 366 palabras, que es algo similar en términos porcentuales a los datos de 2021. Para contexto, las páginas de escritorio contienen 15% más palabras que las páginas móviles. La página de escritorio promedio contiene 15% más palabras que las páginas móviles en el percentil 50. Esto es significativo ya que Google adoptó hace unos años un índice mobile-first, y el contenido que no se encuentra en la versión móvil de una página corre el riesgo de no ser indexado por el motor de búsqueda.

#### Conteo de palabras en código fuente

Examinemos ahora el número de palabras contenidas en el código fuente de una página antes de que el navegador ejecute cualquier código JavaScript u otras modificaciones en el DOM o CSSOM.

{{ figure_markup(
  image="visible-words-raw.png",
  caption="Palabras visibles en código fuente por percentil.",
  description="Distribución de palabras recibidas en el código HTML. El número promedio de palabras es de 363 en escritorio y 318 en móvil mostrando una clara diferencia a las páginas renderizadas. Hay un número similarmente menor de palabras en móvil en otros percentiles por encima y debajo del promedio: en el percentil 10 es de 68 palabras en escritorio y 61 en móvil, en el percentil 25 es de 174 y 151 respectivamente, en el percentil 75 es de 663 y 594, y en el percentil 90 es de 1,142 y 1,039.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=519228938&format=interactive",
  sheets_gid="771280814",
  sql_file="seo-stats-by-percentile.sql"
  )
}}

Al igual que el número de palabras renderizadas, hay una mínima diferencia entre los datos de 2022 y los de 2021. Por ejemplo, la página de escritorio promedio tiene 369 palabras en el código fuente, comparado con 363 en 2022 y la página móvil promedio tiene 318 palabras en el código fuente que es ligeramente menor al 2021 donde tenían 321 palabras en promedio.

También en este caso las páginas móviles contienen menos palabras que las páginas de escritorio. La página móvil promedio contiene un conteo de palabras en el código fuente de un 12.39% menor que en escritorio. Como fue mencionado anteriormente, esto es significante debido al índice mobile-first de Google.

## Datos Estructurados

La adopción de datos estructurados ha adquirido mayor protagonismo a medida que los resultados enriquecidos de las SERP de Google se han vuelto más prominentes.

{{ figure_markup(
  image="raw-vs-rendered-structured-data.png",
  caption="Datos estructurados en código fuente vs. renderizados.",
  description="Gráfico de barras que muestra los cambios de datos estructurados comparando el código fuente con la versión renderizada. 44% de las páginas de escritorio tienen datos estructurados en el código fuente, aumentando 2 puntos porcentuales para datos estructurados en la versión renderizada. 0% tienen datos estructurados solo en la versión renderizada y solo 5 % de las páginas cambian los datos estructurados al renderizarse. Para móvil es casi similar con 45%, 47%, 0% y 5% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=486315827&format=interactive",
  sheets_gid="1564568239",
  sql_file="seo-stats.sql"
  )
}}

La implementación de datos estructurados en el HTML de una página ha aumentado continuamente. En 2021, 42% de las páginas de escritorio y 43% de las páginas móviles usaban datos estructurados. En 2022, ha aumentado a 44% de páginas de escritorio y 45% de páginas móviles que cuentan con datos estructurados en su HTML.

Esto refleja un aumento de 2 puntos porcentuales tanto en páginas de escritorio como móviles. Dos posibles explicaciones para una mayor adopción pueden ser que cierto número de Sistemas Gestores de Contenido han agregado marcado de datos estructurados de manera automática para las páginas, así como la ya mencionada prominencia de los datos estructurados en las SERPs de Google.

También se ha producido una gran reducción tanto en móviles como escritorio de páginas que tienen datos estructurados agregados con JavaScript, dónde no están presentes en la respuesta inicial de HTML. En 2021, 1.7% de páginas móviles y 1.4% de páginas de escritorio tenían datos estructurados agregados vía JavaScript que no estaban en su código fuente HTML inicial. Ahora solo es .15% en escritorio y .13% en móvil.

### Formatos de datos estructurados más populares

{{ figure_markup(
  image="structured-data-formats.png",
  caption="Formatos de datos estructurados.",
  description="Gráfico de barras de los datos estructurados más comúnmente admitidos. JSON-LD en 64% de páginas de escritorio, microdatos en 33%, RDFa en 3% y microformatos2 en 0%. En móvil es casi idéntico con JSON-LD en 62% de páginas móviles, microdatos en 35%, RDFa en 2% y microformatos2 en 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1310320311&format=interactive",
  sheets_gid="2048293717",
  sql_file="structured-data-formats.sql"
  )
}}

Los datos estructurados pueden ser implementados de varias formas en una página. Sin embargo, JSON-LD, que coincide con la recomendación de Google para implementación, es por mucho el formato más popular.

Comparado con las cifras de 2021, los datos de 2022 muestran un aumento nominal en la implementación a través de JSON-LD y una ligera disminución en la implementación de datos estructurados con microdatos. Estas cifras se confirman sobre todo en móvil. En 2021, 60.5% de las páginas móviles usaban JSON-LD para implementar datos estructurados. El número de páginas móviles en 2022 que usan JSON-LD para agregar datos estructurados creció un 2.3% hasta 61.9%. En cambio, 36.9% de páginas móviles en 2021 usaban datos estructurados con microdatos. Este número cayó 4.3% en 2022 hasta 35.3%.

### Tipos de schema más populares

{{ figure_markup(
  image="popular-schemas.png",
  caption="Tipos de schema más populares.",
  description="Gráfico de barras de implementaciones de tipos de schema por popularidad. 30% de sitios han adoptado un schema website de schema.org. `schema.org/WebSite` es usado en 31% de las páginas de escritorio, `schema.org/SearchAction` en 27%, `schema.org/WebPage` en 23%, `schema.org/-UnknownType-` en 22%, `schema.org/Organization` en 21%, `schema.org/ListItem` en 19%, `schema.org/BreadcrumbList` en 18%, `schema.org/ImageObject` en 16%, `schema.org/ReadAction` en 15%, `schema.org/EntryPoint` en 14%, `schema.org/SiteNavigationElement` en 6%, `schema.org/PostalAddress` en 6%, `schema.org/WPHeader` en 5%, `schema.org/WPFooter` en 5%, y finalmente `schema.org/Person` en 5% de las páginas de escritorio. En móvil es casi idéntico con 30%, 26%, 23%, 22%, 20%, 18%, 18%, 16%, 14%, 13%, 7%, 6%, 5%, 5%, y 5% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=201128426&format=interactive",
  sheets_gid="432096465",
  sql_file="structured-data-schema-types.sql",
  width=600,
  height=532
  )
}}

Hay una fuerte correlación entre los tipos de schema más populares presentes en las páginas principales en 2021 y 2022.

Como fue mencionado en ediciones anteriores del Web Almanac, `WebSite`, `SearchAction`, `WebPage`, `SearchAction` son los que permiten el <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/sitelinks-searchbox">Cuadro de Búsqueda de Vínculos a Sitios</a> [ver la tabla anterior].

Al comparar 2021 con 2022, se ha producido un aumento significativo en la adopción de los schema más populares en todos los ámbitos. De hecho, cada tipo de schema anotado ha experimentado un aumento en la adopción en 2022. Entre los más notables están el schema para BreadcrumbsList, que ha aumentado 22.8% desde 2021 e ImageObject, que aumentó 12.3%.

En términos de implementación de los schema más populares, hay diferencias relativamente pequeñas entre los porcentajes de páginas móviles y de escritorio.

Puedes leer más sobre datos estructurados en nuestro capítulo específico.

## Enlaces

Los motores de búsqueda utilizan los enlaces para descubrir nuevas páginas y para pasar PageRank, que ayuda a determinar la importancia de las páginas. Los enlaces también actúan como referencia de una página a otra (supuestamente relevante) página.

### Textos de enlace no descriptivos

El texto de anclaje, que es el texto sobre el que se puede hacer clic en un enlace, ayuda a los motores de búsqueda a entender el contenido de la página enlazada. Lighthouse tiene una prueba para validar si el texto de anclaje usado es útil y/o contextual, o si es genérico y/o no descriptivo como puede ser "aprende más" o "clic aquí". En 2022, 15% y 17% de los enlaces probados en móvil y escritorio, respectivamente, no tenían un texto de anclaje descriptivo, una oportunidad perdida desde un punto de vista SEO y malo para la accesibilidad.

### Enlaces salientes

{{ figure_markup(
  image="median-internal-links.png",
  caption="Enlaces salientes promedio al mismo sitio.",
  description="Una distribución por rango del conteo promedio de enlaces internos. En escritorio para los principales 1,000 sitios es 137 enlaces, para los principales 10,000 sitios es de 139, para los principales 100,000 sitios es 105, para el millón principal de sitios es 88, para los principales 10 millones de sitios es 63, y para todos los sitios es 56. En móvil es ligeramente menor con 106, 117, 94, 82, 56, 48 respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=2040803708&format=interactive",
  sheets_gid="1325442493",
  sql_file="outgoing_links_by_rank.sql"
  )
}}

Los enlaces internos son enlaces a otras páginas del mismo sitio. Similar al año pasado, las cifras de 2022 sugieren que las páginas tienen menos enlaces en sus versiones móviles comparado con sus contrapartes de escritorio.

El número promedio de enlaces internos ahora es 16% mayor en escritorio que en móvil con 56% y 48% respectivamente. Probablemente se deba a que los desarrolladores minimizan los menús de navegación y pies de página en dispositivos móviles para facilitar su uso en pantallas más pequeñas.

De acuerdo con los datos del CrUX, los 1,000 sitios más populares tienen más enlaces salientes internos que sitios menos populares, un total de 137 enlaces en escritorio frente a 106 en móvil. Esto es más del doble que el promedio. Esto puede ser atribuido al uso de mega menús en sitios más grandes que generalmente tienen más páginas.

{{ figure_markup(
  image="median-external-links.png",
  caption="Promedio de enlaces externos.",
  description="Distribución por rangos del conteo promedio de enlaces externos. En escritorio para los principales 1,000 sitios es 15 enlaces externos, para los principales 10,000 es de 13, para los principales 100,000 es de 10, para el millón principal de sitios es de 8, para los principales 10 millones de sitios es de 7, y para todos los sitios es de 7 enlaces externos. En móvil es uno o dos menos en cada rango con 12, 11, 9, 7, 6, y 6 respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1367867640&format=interactive",
  sheets_gid="1325442493",
  sql_file="outgoing_links_by_rank.sql"
  )
}}

Los enlaces externos son enlaces a otras páginas en diferentes sitios web. Los datos, que han sido consistentes por los últimos años, apuntan a que hay menos enlaces externos en las versiones móviles de las páginas comparado con las versiones de escritorio. A pesar de que Google puso en marcha el mobile-first indexing hace unos años, los sitios web aún no han igualado sus versiones móviles con sus contrapartes de escritorio.

### Uso del atributo rel

En Septiembre de 2019, Google <a hreflang="en" href="https://webmasters.googleblog.com/2019/09/evolving-nofollow-new-ways-to-identify.html">introdujo atributos</a> que permiten a los editores clasificar enlaces como _sponsored_ o _user-generated content_. Estos atributos son adicionales a `rel=nofollow`, que fue previamente <a hreflang="en" href="https://googleblog.blogspot.com/2005/01/preventing-comment-spam.html">introducido en 2005</a>. Estos nuevos atributos, `rel=ugc` y `rel=sponsored`, agregan información adicional a los enlaces.

{{ figure_markup(
  image="anchor-rel-attr.png",
  caption="Uso del atributo `rel`.",
  description="Gráfico de barras comparando el uso de `rel` `noopener`, `nofollow`, `noreferrer`, `dofollow`, `sponsored`, `ugc`, y `follow`. En escritorio `noopener` es usado en 34.3% de sitios, `nofollow` en 28.8%, `noreferrer` en 18.8%, `dofollow` en 0.4%, `sponsored` en 0.5%, `ugc` en 0.4%, y finalmente `follow` es usado en 0.3% de sitios. En móvil es casi idéntico con 32.6%, 29.5%, 17.3%, 0.6%, 0.4%, 0.4%, y 0.3% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=583878647&format=interactive",
  sheets_gid="411053146",
  sql_file="anchor-rel-attribute-usage.sql"
  )
}}


No mucho ha cambiado en términos de la adopción de los nuevos atributos, con `rel=ugc` apareciendo en 0.4% de páginas de escritorio y móviles y `rel=sponsored` apareciendo en 0.5% de páginas de escritorio y 0.4% de páginas móviles en 2022.

`rel="dofollow"` otra vez apareció en más páginas que `rel="ugc"` y `rel="sponsored"`. Aunque técnicamente esto no es un problema, Google ignora `rel="follow"` y `rel="dofollow"` porque, a pesar de su inclusión, no son atributos oficiales.

`rel="nofollow"`, que es un atributo válido, fue encontrado en 2022 en el 29.5% de páginas móviles. que es 1.2% menor que el año pasado. Google trata `nofollow` como una sugerencia, lo que significa que el motor de búsqueda puede elegir si respeta o no el atributo.


## AMP

AMP ha sido un tema controversial desde su lanzamiento en 2015, con SEOs debatiendo si tuvo o no un impacto directo en el posicionamiento. Más tarde, Google publicó esta declaración (a continuación) en su documentación para aclaraciones adicionales:

<figure>
  <blockquote>Aunque AMP por sí solo no es un factor de posicionamiento, la velocidad es un factor de posicionamiento para la búsqueda de Google. La búsqueda de Google aplica el mismo estándar a todas las páginas, sin importar de la tecnología usada para crear la página.</blockquote>
  <figcaption>— <cite><a hreflang="en" href="https://developers.google.com/search/docs/advanced/experience/about-amp">Google Search Central</a></cite></figcaption>
</figure>

El futuro de AMP parece estar cambiando desde el lanzamiento de los Core Web Vitals. Una de las razones principales para implementar previamente AMP, adicional a mejorar la velocidad de carga, era que era necesario para aparecer en los Top Carousels. En 2021, Google actualizó sus requisitos y detalló que cualquier página es ahora elegible para aparecer en los Top Carousels con o sin AMP.

{{ figure_markup(
  image="amp-markup.png",
  caption="Tipos de marcado AMP.",
  description="Gráfico de barras que muestra las implementaciones AMP en todas las páginas. La adopción de AMP es baja en el conjunto de datos de la muestra. El atributo HTML Amp es usado en 0.07% de páginas de escritorio y 0.19% de páginas móviles. HTML Amp & el atributo Emoji se usan en 0.01% y 0.03% respectivamente, HTML Amp o el atributo Emoji en 0.09% y 0.22%, y la etiqueta Rel Amp HTML en 0.67% y 0.60%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1100298070&format=interactive",
  sheets_gid="1210998028",
  sql_file="markup-stats.sql"
  )
}}

El uso en escritorio ha disminuido en 2022 de 0.09% a 0.07% comparado con 2021 mientras que el uso en móvil ha bajado de 0.22% a 0.19% durante el mismo periodo de tiempo.

## Internacionalización

La internacionalización en SEO es el proceso de optimizar un sitio web siguiendo las buenas prácticas cuando se enfoca a varios países y varios idiomas, para garantizar que puede ser rastreado e indexado correctamente por los motores de búsqueda.

### Uso de hreflang

Las etiquetas hreflang ayudan a Google y otros motores de búsqueda, como Bing y Yandex, a entender el idioma principal de una página. Se usa principalmente en campañas de SEO internacional cuando se usan diferentes idiomas en diferentes versiones de un sitio web.

{{ figure_markup(
  image="hreflang-usage.png",
  caption="Uso de hreflang.",
  description="Gráfico de barras de valores hreflang comunes. En escritorio `en` es usado en 5.4% de las páginas de nuestro conjunto de datos. `x-default` en 4.0%, `fr` en 2.2%, `de` en 2.2%, `es` en 2.1%, `en-us` en 1.6%, `it` en 1.5%, `ru` en 1.3%, `en-gb` en 1.2%, y finalmente `nl` en 1.0%. Para móvil es casi idéntico con 4.7%, 3.7%, 2.0%, 2.0%, 2.0%, 1.4%, 1.5%, 1.3%, 1.0%, 1.0% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=561647523&format=interactive",
  sheets_gid="297028820",
  sql_file="hreflang-link-tag-usage.sql",
  width=600,
  height=546
  )
}}

Actualmente, 9.6% de los sitios usan etiquetas hreflang en escritorio mientras que 8.9% las usan en móvil. Esto es un ligero aumento desde 2021 donde 9.0% de sitios usaban etiquetas hreflang en escritorio y 8.4% las implementaron en móvil.

El valor hreflang más popular en 2022 es `en` [English], que representa un 5.4% del uso en escritorio y 4.7% en móvil. Estos porcentajes son aproximadamente los mismos que el año pasado.

Después de x-default, que es el valor "de respaldo" (y el segundo más común en uso), las etiquetas hreflang para francés, alemán y español son las siguientes más frecuentes.

Las tres diferentes formas de implementar etiquetas hreflang son en el `<head>`, encabezados link, o sitemaps XML. Nota: Como estos datos se refieren únicamente a páginas de inicio, los sitemaps XML no se incluyen.

### Uso de content language

Aunque Google tiende a usar etiquetas hreflang, otros motores de búsqueda como Bing prefieren el [atributo `content-language`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Language). Esto puede ser implementado usando dos métodos:

1. HTML
2. Encabezados HTTP

{{ figure_markup(
  image="content-language.png",
  caption="Uso de idiomas (HTML y encabezado HTTP).",
  description="Gráfica de barras que muestra el uso de idiomas como porcentaje de páginas. Para escritorio `en` es usado en 4.22% de las páginas de nuestro conjunto de datos, `en-us` en 1.83%, `de` en 0.50%, `fr` en 0.33%, `es` en 0.29%, `pt-br` en 0.12%, `it` en 0.13%, `ru` en 0.12%, `nl` en 0.14%, y finalmente `ja` en 0.11%. Para móvil es muy similar con 3.28%, 2.28%, 0.53%, 0.29%, 0.33%, 0.15%, 0.14%, 0.14%, 0.11%, y 0.10% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSZxId5PPpTHp4835BI-rt4HqZVrhn1UiF0xcOrVUytVs6j262ZqFrY5e1FXZibAGDY6gWnZ0uG3WZC/pubchart?oid=1743056980&format=interactive",
  sheets_gid="1291138023",
  sql_file="content-language-usage.sql",
  width=600,
  height=507
  )
}}

En 2022, la respuesta del servidor HTTP es el método más popular de implementación para content-language, con 8.27% de sitios móviles que lo utilizan y 8.82% de sitios de escritorio. Sin embargo, esto ha sido una disminución en la adopción móvil comparado con 2021 cuando 9.3% de sitios móviles lo usaban. Por el contrario, en escritorio ha ocurrido un ligero aumento comparado con 2021 cuando 8.7% de sitios lo usaban.

HTML, por otro lado, tiene un 2.98% de adopción en escritorio en 2022 y 3.01% de adopción en móvil. Pero nuevamente hay una disminución en el uso móvil comparado con 2021 cuando 3.3% de los sitios móviles usaban la etiqueta HTML.

## Conclusión

Similar a los patrones de nuestros datos en [2021](../2021/seo), [2020](../2020/seo), y [2019](../2019/seo), la mayoría de los sitios analizados muestran pequeñas, pero consistentes, mejoras respecto a diversos fundamentos SEO, como tener páginas indexables y rastreables.

También hemos visto un creciente interés en elementos de rendimiento como los Core Web Vitals, con 39% de los sitios que cuentan con puntajes aprobatorios comparado con solo 20% en 2020 cuando se anunció la actualización por primera vez. Esto parece indicar que los sitios están tomando más en cuenta las directrices de Google. Aun así, queda mucho por hacer en toda la web.

Nuevas adiciones, como la etiqueta indexifembedded, están teniendo una lenta adopción. Esto subraya la continua necesidad de adoptar las mejores prácticas y las grandes oportunidades de crecimiento que hay en SEO, la compatibilidad con motores de búsqueda, y el estado de la web en general.
