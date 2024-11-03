---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Comercio electrónico
description: Capítulo sobre comercio electrónico del Web Almanac 2020 que cubre plataformas de ecommerce, cargas útiles, imágenes, terceras partes, rendimientos, SEO, y PWAs.
authors: [rockeynebhwani, jrharalson]
reviewers: [alankent]
analysts: [jrharalson, rockeynebhwani]
editors: [tunetheweb]
translators: [carloscastromx]
rockeynebhwani_bio: Rockey Nebhwani es un consultor independiente que ha trabjado en ventas al por menor y comercio electrónico desde 2001 y tiene amplia experiencia en la industria al trabajar con empresas como Amazon, Wal-Mart, Tesco, M&S, Safeway, etc. a lo largo de Estados Unidos y el Reino Unido. Rockey es un conferenciante ocasional en eventos de comercio electrónico y twitea en <a href="https://x.com/rnebhwani">@rnebhwani</a>.
#jrharalson_bio: TODO
discuss: 2052
results: https://docs.google.com/spreadsheets/d/1Hvsh_ZBKg2vWhouJ8vIzLmp0nLIMzrT2mr6RQbIkxqY/
featured_quote: El covid-19 aceleró másivamente el crecimiento del comercio electrónico en 2020 y una gran de empreas pequeás tuvieron que establecer su presencia online rápidamente para encontrar formas de continuar sus ventas durante el confinamiento. Plataformas como WooCommerce / Shopify / Wix / BigCommerce jugaron un rol fundamental en atraer a más pequeños negocios al mundo online. El covid-19 también fue parte del lanzamiento de ofertas D2C (directo a cliente) por marca y se espera que aumente en el futuro.
featured_stat_1: 21.27%
featured_stat_label_1: Sitios móviles identificados como sitios de comercio electrónico
featured_stat_2: 5.19%
featured_stat_label_2: Sitios usando WooCommerce, la plataforma de comercio electrónico más popular
featured_stat_3: 30
featured_stat_label_3: Promedio de peticiones JavaScript realizadas por sitios de comercio electrónico
---

## Introducción

Una "plataforma de comercio electrónico" es un conjunto de servicios o herramientas que te permiten crear y operar una tienda online. Hay diferentes tipos de plataformas de comercio electrónico, por ejemplo:

- Servicios de pago como Shopify que alojan tu tienda y te ayudan a empezar. Ellos proporcionan alojamiento del sitio, plantillas del sitio y páginas, manejo de datos de productos, carritos de compra, y pagos.
- Plataformas de software como Magento Open Source que puedes configurar, alojar y gestionar tú mismo. Estas plataformas pueden ser poderosas y flexibles, pero pueden ser más complejas de configurar y mantener que otros servicios como Shopify.
- Plataformas alojadas como Magento Commerce que ofrece las mismas funcionalidades que sus homólogos auto-alojados, excepto que el alojamiento del sitio es gestionado como un servicio por un tercero.

El análisis del año pasado solo podía detectar sitios creados en una plataforma de comercio electrónico. Esto significa que la mayoría de las tiendas online y marketplaces-como Amazon, JD, y eBay u otros sitios de comercio electrónico creados con plataformas internar (normalmente empresas más grandes)-, no fueron parte del análisis. Para el análisis de este año, esta limitación se abordó con la mejora en la detección de sitios de comercio electrónico de Wappalyzer. Revisa la sección [Detección de plataformas](#detección-de-plataformas) para más detalles.

Es importante mencionar que los datos presentados son únicamente para páginas de inicio: no páginas de categorías, productos u otros tipos. Aprende más sobre nuestra [metodología](./methodology).

## Detección de plataformas

¿Cómo revisamos si una página está en una plataforma de comercio electrónico? La detección se lleva a cabo con Wappalyzer. Wappalyzer es una utilidad multi-plataforma que descubre las tecnologías usadas en los sitios web. Detecta los sistemas gestores de contenido, plataformas de comercio electrónico, servidores web, frameworks de JavaScript, herramientas de analítica, y muchas tecnologías más.

Comparado con el 2019, notarás que el % de los sitios de comercio electrónico ha aumentado significativamente. Esto se debe principalmente a la mejora en la detección de Wappalyzer este año usando señales secundarias. Estas señales secundarias incluyen lo siguiente:
- Sitios que usan el etiquetado de Google Analytics para comercio electrónico son considerados sitios de comercio electrónico.
- Las señales secundarias también incluyen la búsqueda de patrones más usados para identificar enlaces a los carritos de compra.

Este cambio en la metodología proporciona una mayor cobertura para plataformas empresariales y sitios web construidos con soluciones "headless".

### Limitaciones

Nuestra metodología tiene las siguientes limitaciones:
- Plataformas de comercio electrónico "headless" como <a hreflang="en" href="https://commercetools.com/">commercetools</a> pueden no ser detectadas como plataformas de comercio electrónico, pero si pudimos identificar la presencia de un carrito de compras en dichos sitios, seguiremos incluyendo los sitios que utilizan estas plataformas en nuestras estadísticas de cobertura.
- No se detectan las tecnologías que suelen emplearse fuera de las páginas principales (por ejemplo, WebAr en las páginas de detalles de productos).
- Debido a que nuestro rastreo se origina desde Estados Unidos, puede haber cierto favoritismo hacia plataformas específicas de Estados Unidos. Por ejemplo, si un negocio global tiene sitios de comercio electrónico construidos en diferentes plataformas para diferentes países (usando dominios específicos por país o subdominios), puede que no se muestren estas diferencias regionales en nuestro análisis.
- Es común para sitios B2B esconder la funcionalidad de carrito de compras detrás de un inicio de sesión, y debido a ello, este análisis no es una correcta representación del mercado B2B.

## Plataformas de comercio electrónico

{{ figure_markup(
  image="ecommerce-comparison-2019-to-2020.png",
  caption="Comparación del comercio electrónico de 2019 frente a 2020",
  description="Gráfico de barras que muestra un aumento de 9.67% a 21.72% en la detección de sitios de escritorio de comercio electrónico. Móvil también tuvo un aumento similar de 9.41% a 21.27%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1775630157&format=interactive",
  sheets_gid="856812465",
  sql_file="pct_ecommsites_bydevice_compare20192020.sql"
) }}

En total, 21.72% de los sitios móviles y 21.27% de los sitios de escritorio usan una plataforma de comercio electrónico. Para 2019, el porcentaje era 9.41% para sitios móviles y 9.67% en sitios de escritorio.

<p class="note">Nota: Este aumento se debe principalmente a mejoras hechas a Wappalyzer para detectar los sitios de comercio electrónico y no debe ser atribuido a otros factores como el crecimiento debido al Covid-19. Además, una corrección menor fue aplicada a las estadísticas del 2019 de forma retrospectiva para compensar un error y, por lo tanto, los porcentajes de 2019 son ligeramente diferentes de los mencionados en el capítulo de <a href="../2019/ecommerce">Comercio Electrónico 2019</a>.</p>

### Principales plataformas de comercio electrónico

{{ figure_markup(
  image="top-ecommerce-platforms.png",
  caption="Principales plataformas de comercio electrónico.",
  description="Gráfico de barras que muestra, en orden descendiente, el uso de las plataformas de comercio electrónico con WooCommerce en 5.12% en escritorio y 5.19% en móvil, seguido de Shopify (2.55% y 2.48% respectivamente), Wix (1.05% y 1.24%), Magento (1.03% y 0.96%), PrestaShop (0.91%, 0.94%), 1C-Bitrix (0.64% y 0.65%), Bigcommerce (0.24% y 0.21%), Cafe24 (0.21% y 0.12%), Shopware (0.14 en ambos), y Loja Integrade en 0.08% y 0.09% respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=795567278&format=interactive",
  sheets_gid="872326386",
  sql_file="top_vendors.sql"
) }}

Nuestro análisis contabilizó 145 plataformas de comercio electrónico individuales (comparado con [116 en el análisis del año pasado](../2019/ecommerce#ecommerce-platforms)). De estas, solo 9 plataformas tienen una cuota de mercado mayor al 0.1%. WooCommerce es la plataforma de comercio electrónico más común y ha mantenido la posición número uno. Wix aparece en este análisis por primera vez este año, después de que Wappalyzer lo empezará a identificar como plataforma de comercio electrónico el 30 de Junio de 2019.

### Principales plataformas de comercio electrónico empresariales

Aunque es difícil discernir el nivel preciso de una plataforma, vamos a destacar cuatro proveedores que se centran en gran medida en el nivel empresarial: Salesforce, HCL, SAP y Oracle.

{{ figure_markup(
  image="enterprise-ecommerce-platforms.png",
  caption="Plataformas de comercio electrónico empresariales (escritorio)",
  description="Gráfico de barras que muestra Salesforce Commerce Cloud con 2,653 y 3,347, HCL WebSphere Commerce es usado por 2,268 sitios de escritorio en 2019 y 2,604 en 2020, SAP Commerce Cloud es  usado por 1,979 y 2,371 y Oracle Commerce Cloud por 1,095 y 917.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=783560373&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

Salesforce Commerce Cloud sigue siendo la plataforma principal en este grupo. Los 3,437 sitios de escritorio en 2020 representan un aumento de 29.5% respecto a los 2,653 sitios en 2019. Los sitios que usan Salesforce conforman el 36.8% de las 4 plataformas de comercio electrónico empresariales.

HCL Technologies adquirió WebSphere Commerce de IBM en Julio de 2019. La transición ha tenido resultados mixtos en 2020. Mientras que HCL WebSphere Commerce aumentó el número de sitios de escritorio en un 14.8% a 2,604 comparado con los 2,268 sitios de escritorio en 2019, hubo una disminución de popularidad en este grupo de 0.5% hasta el 27.9%. Algo que vigilar en el futuro.

SAP Commerce Cloud, conocido formalmente como Hybris, sigue siendo la tercer plataforma de comercio electrónico empresarial más popular con 25.4%, que es un ligero aumento respecto al 24.8% del año pasado. Los 2,371 sitios web son un aumento de 1,979 sitios de escritorio encontrados en 2019 atribuidos a Hybris.

Por último, Oracle Commerce Cloud desafortunadamente perdió un poco de tracción entre 2019 y 2020. Los sitios de escritorio disminuyeron de 1,095 a 917, una reducción del 16%, lo que resultó en una disminución de 13.7% a 9.8% en su lugar dentro de las plataformas de comercio electrónico empresariales.

{{ figure_markup(
  image="enterprise-ecommerce-platforms-2019.png",
  caption="Plataformas de comercio electrónico empresariales - 2019 escritorio",
  description="Gráfico de barras que muestra que Salesforce Commerce Cloud fue usado por 33.2% del mercado de plataformas empresariales en 2019, HCL WebSphere Commerce en 28.4%, SAP Commerce Cloud en 24.8% y Oracle Commerce Cloud en 13.7%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1864431795&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

{{ figure_markup(
  image="enterprise-ecommerce-platforms-2020.png",
  caption="Plataformas de comercio electrónico empresariales - 2020 escritorio",
  description="Gráfico de barras que muestra que Salesforce Commerce Cloud fue usado por 36.8% del mercado de plataformas empresariales en 2020, HCL WebSphere Commerce en 27.9%, SAP Commerce Cloud en 25.4 y Oracle Commerce Cloud en 9.8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1013485197&format=interactive",
  sheets_gid="1789086753",
  sql_file="top_vendors.sql"
) }}

Las ofertas Shopify Plus de Shopify, Magento Enterprise de Adobe y Enterprise de Bigcommerce están disponibles y ganando tracción, pero las limitaciones de la detección de plataformas dificultan la habilidad de aislar los sitios empresariales de sus sitios web de comunidad o comerciales.

## Impacto del COVID-19 en el comercio electrónico

El COVID-19 ha tenido un gran impacto mundial y ha hecho necesario un cambio online aún mayor. La medición del aumento total en las plataformas de comercio electrónico ha sido mayormente influenciada por la ampliación en la detección en parte para este capítulo. Así que, en su lugar, observamos algunas de las plataformas que ya se habían detectado y notamos un aumento en su uso - particularmente desde Marzo del 2020 cuando el COVID empezó a impactar gran parte del mundo:

{{ figure_markup(
  image="ecommerce-vendor-growth-covid-19-impact.png",
  caption="Impacto del Covid-19 en el crecimiento de las plataformas de comercio electrónico",
  description="Gráfico lineal que muestra el crecimiento de 5 plataformas de comercio electrónico: WooCommerce, Shopify, Wix, Magento y PrestaShop. WooCommerce muestra un crecimiento estable con un aumento notable en Febrero 2020 y de nuevo en Junio y Julio. Shopify muestra un porcentaje similar pero menor y los otros 3 muestran un impacto menor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1475961371&format=interactive",
  sheets_gid="535254570",
  sql_file="ecomm_vendors_covid_growth.sql"
) }}

Definitivamente existe un crecimiento significativo en los sitios WooCommerce y Shopify alrededor del tiempo que el COVID empezó a afectar realmente al mundo.

<p class="note">Nota: <a hreflang="en" href="https://github.com/AliasIO/wappalyzer/pull/2731/commits/f44f20f03618f6a5fd868dd38ce9db5e2e2f1407">La detección de Wappalyzer para Wix</a> no diferencia si un sitio esta usando Wix como CMS o como plataforma de comercio electrónico. Debido a ello, el crecimiento de Wix como plataforma de comercio electrónico puede no estar representado correctamente en la gráfica anterior.</p>

## Tamaño de página y peticiones

El tamaño de página de una plataforma de comercio electrónico incluye todo el HTML, CSS, JavaScript, JSON, XML, imágenes, audios, y videos.

{{ figure_markup(
  image="page-requests-distribution.png",
  caption="Distribución de peticiones de página",
  description="Gráfico de barras que muestra el número de peticiones, con el percentil 10 teniendo 46 peticiones en escritorio y 44 en móvil, el percentil 25 tiene 68 y 65 peticiones respectivamente, el percentil 50 teniendo 103 y 98, el 75 teniendo 151 y 146 y el percentil 90 teniendo 2917 en escritorio y 208 en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1278986228&format=interactive",
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

{{ figure_markup(
  image="page-weight-distribution.png",
  caption="Distribución de tamaño de página",
  description="Gráfico de barras que muestra el tamaño de página en MB con el percentil 10 teniendo 0.94 MB en escritorio y 0.85 en móvil, el percentil 25 teniendo 1.55 y 1.45 respectivamente, el percentil 50 teniendo 2.62 y 2.48, el percentil 75 teniendo 4.52 y 4.28, y el percentil 90 teniendo 7.89 MB en escritorio y 7.3 MB en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1078671906&format=interactive",
  sheets_gid="1733352933",
  sql_file="pagestats_percentiles_bydevice.sql"
) }}

De manera prometedora, el peso de las páginas móviles ha disminuido en todos los percentiles [comparado con 2019](../2019/ecommerce#page-weight-and-requests) mientras que el tamaño de página en escritorio se ha mantenido más o menos igual (excepto el percentil 90). Las peticiones por página también disminuyeron en móvil (9-11 peticiones menos en todos los percentiles excepto en el percentil 90) y en escritorio.

Los sitios de comercio electrónico aún siguen siendo más grandes en términos de peticiones y tamaño comparado con todos los sitios, tal y como se muestra en el capítulo de [Tamaño de Página](./page-weight).

### Tamaño de página por tipo de recurso

Al desglosar esto por tipo de recurso, para las páginas promedio, podemos ver que las peticiones de imágenes y JavaScript dominan las páginas de comercio electrónico:

{{ figure_markup(
  image="median-page-requests-by-type.png",
  caption="Peticiones de la página promedio por tipo.",
  description="Gráfico de barras que muestra las peticiones por página por tipo de recurso en orden descendente para la página promedio. Las imágenes tienen 37 peticiones en escritorio y 34 en móvil, los scripts tienen 31 y 30 respectivamente, css 8 en ambos, fuentes 5 en ambos, otros 4 en ambos, html 4 en ambos, video 3 en ambos, y xml, texto y audio 1 en ambos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1680167507&format=interactive",
  sheets_gid="1479463761",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

Sin embargo, al mirar los bytes entregados, los archivos multimedia son los recursos más pesados por mucha diferencia:

{{ figure_markup(
  image="median-page-kilobytes-by-type.png",
  caption="Kilobytes por tipo en la página promedio.",
  description="Gráfico de barras que muestra los kilobytes por tipo de archivo en orden descendente para la página promedio. Las imágenes son 1,754 KB en escritorio y 2,176 KB en móvil, los scripts son 1,271 y 1,208 respectivamente, css 643 y 611, fuentes 143 y 123, html 35 y 34, audio 14 y 9, xml 1 y 1, y texto y otros 0 en ambos casos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1077946836&format=interactive",
  sheets_gid="1479463761",
  sql_file="pagestats_percentile_bydevice_format.sql"
) }}

Video, a pesar de contar con una cantidad mínima de peticiones, es el recurso de mayor tamaño en sitios de comercio electrónico, seguido de imágenes y JavaScript.

### Tamaño de la descarga de HTML

{{ figure_markup(
  image="distribution-of-html-bytes-per-ecommerce-page.png",
  caption="Distribución de bytes de HTML por página de comercio electrónico",
  description="Gráfico de barras que muestra el número de kilobytes de HTML, con el percentil 10 teniendo 12 KB en escritorio y 13 KB en móvil, el percentil 25 teniendo 20 y 21 respectivamente, el 50 teniendo 35 y 36, el 75 teniendo 76 y 74, y el percentil 90 teniendo 133 KB en escritorio y 134 KB en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1956748774&format=interactive",
  sheets_gid="1032303587",
  sql_file="pagestats_html_bydevice.sql"
) }}

Hay que tener en cuenta que la descarga de HTML puede contener otro tipo de código presente en el mismo archivo HTML como JSON, JavaScript o CSS, que no es referenciado como recursos externos. El tamaño promedio de la descarga de HTML para páginas de comercio electrónico es de 35 KB en móvil y 36 KB en escritorio. [Comparado con el 2019](../2019/ecommerce#html-payload-size), el tamaño promedio de la descarga en los percentiles 10, 25 y 50 se ha mantenido aproximadamente igual. Sin embargo, en el percentil 75 y 90 vemos un incremento de aproximadamente 10 KB y 15 KB respectivamente en móvil y escritorio.

Los tamaños de la descarga de HTML en móvil no son muy diferentes a los de escritorio. En otras palabras, parece que los sitios web no presentan diferencias significativas en los archivos HTML para diferentes dispositivos o tamaños de viewport.

### Uso de imágenes

Ahora, miremos a cómo se usan las imágenes en los sitios de comercio electrónico. Hay que mencionar que nuestra metodología de recolección de datos no simula las interacciones de un usuario como hacer clic o scroll, las imágenes que son cargadas con lazy loading no serán representadas en estos resultados.

{{ figure_markup(
  image="distribution-of-image-requests-for-ecommerce.png",
  caption="Distribución de peticiones de imágenes para comercio electrónico",
  description="Gráfico de barras que muestra el número de peticiones de imágenes, con el percentil 10 teniendo 14 peticiones en escritorio y 12 en móvil, el percentil 25 teniendo 22 y 20 respectivamente, el percentil 50 teniendo 37 y 34 respectivamente, el percentil 75 teniendo 60 y 56, y el percentil 90 teniendo 101 peticiones en escritorio y 91 en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=286315936&format=interactive",
  sheets_gid="898563708",
  sql_file="pagestats_image_bydevice.sql"
) }}

{{ figure_markup(
  image="distribution-of-image-bytes-for-ecommerce.png",
  caption="Distribución de bytes de imágenes para comercio electrónico",
  description="Gráfico de barras que muestra el número de kilobytes de imágenes, con el percentil 10 teniendo 242 KB en escritorio y 189 KB en móvil, el percentil 25 teniendo 546 y 486 respectivamente, el percentil 50 teniendo 1,271 y 1,208, el percentil 75 teniendo 2,835 y 2,737, y el percentil 90 teniendo 5,819 KB en escritorio y 5,459 KB en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=416820889&format=interactive",
  sheets_gid="898563708",
  sql_file="pagestats_image_bydevice.sql"
) }}

Las imágenes anteriores muestran que la página de comercio electrónico promedio tiene 34 imágenes y una descarga de imágenes de 1,208 en móvil, 37 imágenes y 1,271 KB en escritorio. 10% de las páginas de inicio tienen 90 o más imágenes y una descarga de imágenes de casi 5.5 MB en móvil y 5.8 MB en escritorio.

[Comparado con el 2019](../2019/ecommerce#image-stats), tanto el promedio de peticiones de imágenes y el tamaño promedio de la descarga de imágenes sufrieron una reducción. Las peticiones de imágenes promedio disminuyeron en 3 tanto para móvil como para escritorio. El tamaño promedio de la descarga de imágenes también disminuyo en aproximadamente 200KB-250KB tanto en móvil como escritorio. Esta disminución puede ser causada por sitios que han adoptado técnicas de lazy loading como el uso del atributo `loading="lazy"` que ahora es <a hreflang="en" href="https://caniuse.com/loading-lazy-attr">soportado por más navegadores</a>. El capítulo de [Marcado](./markup#data--attributes) de este año hace una observación sobre el uso nativo de lazy loading que parece estar en aumento ya que cerca del 3.86% de las páginas usan esto en Agosto-2020 y esto ha sido un aumento constante (como se puede ver en [este tweet](https://x.com/rick_viscomi/status/1344380340153016321?s=20)).

#### Formatos de imágenes populares

{{ figure_markup(
  image="popular-image-formats-on-ecommerce-sites.png",
  caption="Formatos de imágenes populares en sitios de comercio electrónico",
  description="Gráfico de barras que muestra los formatos de imágenes en orden descendente de popularidad con cifras de dispositivos móviles que muestran a jpg con 50.19%, png con 26.54%, gif con 17.35%, svg con 2.61%, webp con 1.17% y sin formato con 0.07%. Las cifras para escritorio son casi idénticas.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=753462591&format=interactive",
  sheets_gid="943479146",
  sql_file="pagestats_image_bydevice_format.sql"
) }}

<p class="note">Hay que mencionar que algunos servicios de imágenes o CDNs entregan automáticamente imágenes en formato WebP (en vez de JPEG o PNG) a plataformas que soportan WebP, aún cuando la URL tiene un sufijo <code>.jpg</code> o <code>.png</code>. Por ejemplo, la imagen <code>IMG_20190113_113201.jpg</code> muestra una imagen WebP en Chrome. Sin embargo, la forma en la que el HTTP Archive detecta los formatos de imágenes es revisar las palabras clave en tipo MIME primero, después se verifica la extensión del archivo. Esto significa que el formato para imágenes con URLs como la anterior, son identificadas como WebP, ya que WebP es soportado por HTTP Archive como agente de usuario.</p>

El uso de PNG se mantuvo casi al [mismo nivel que en 2019](../2019/ecommerce#png) (en 27% tanto para escritorio como para móvil). Observamos una reducción en el uso de JPEG (4% para escritorio y 6% para móvil). Como resultado de esta reducción, vimos que se compensan los porcentajes con un aumento en el uso de GIF. Los GIFs son muy comunes en páginas de inicio de comercio electrónico, aunque no se usan mucho los GIFs en las páginas de producto. Ya que nuestra metodología solo toma en cuenta las páginas de inicio, esto explica el incremento en el uso de GIFs en los sitios de comercio electrónico. Lighthouse tiene una auditoría que recomienda usar "formatos de video para contenido animado". Esta es una técnica que los sitios de comercio electrónico pueden usar para optimizar su rendimiento y así mantener las propiedades de animación de los GIFs. Revisa <a hreflang="es" href="https://web.dev/i18n/es/replace-gifs-with-videos/">este artículo</a> para más información.

El uso de WebP en diferentes sitios de comercio electrónico aún sigue siendo muy bajo, aunque su uso se duplicó y aumento de un 1% de uso en 2019 a un 2% en 2020. El formato WebP tiene hoy casi 10 años de antigüedad y aún después de permitir la mejora progresiva con el uso del elemento `picture`, su uso se ha mantenido bajo. En 2020, WebP obtuvo esperanzas cuando Safari introdujo su soporte en <a hreflang="en" href="https://caniuse.com/webp">Safari 14</a>. Sin embargo, el Web Almanac de este año se basa en Agosto de 2020 y el soporte de Safari llegó en Septiembre de 2020, así que las estadísticas presentadas aquí no toman en cuenta el impacto del soporte añadido de Safari.

Este año, en Chrome 85 (lanzado en Agosto del 2020), vimos el soporte para AVIF que es un <a hreflang="en" href="https://www.ctrl.blog/entry/webp-avif-comparison.html">formato de imagen más eficiente comparado con WebP</a>. En el análisis del próximo año, esperamos cubrir el uso de AVIF en sitios de comercio electrónico. Similar a WebP, AVIF también es un elemento de mejora progresiva y puede ser implementado usando el elemento `picture` para evitar problemas de <a hreflang="en" href="https://caniuse.com/avif">compatibilidad entre navegadores</a>.

Según la experiencia del autor, hay una falta de conciencia en los equipos de desarrollo sobre los servicios de optimización de imágenes que ofrecen los CDNs donde los CDNs hacen casi todo el trabajo pesado sin mucho código. Por ejemplo, Adobe Scene7 ofrece esto bajo su <a hreflang="en" href="https://helpx.adobe.com/uk/experience-manager/6-3/assets/using/imaging-faq.html">Smart Imaging solution</a>. Los clientes de Salesforce Commerce Cloud que usan la capacidad integrada del CDN (que usa Cloudflare) pueden habilitar esto con un simple interruptor. Al aumentar la difusión de dichas soluciones, podemos tratar de mover la aguja a favor de formatos más eficientes.

Otro punto para los lectores que están interesados en mejorar las métricas del CRUX con formatos/tamaños de imágenes, actualmente las imágenes progresivas no afectan al puntaje de Largest Contentful Paint (LCP) aunque son útiles para el rendimiento percibido por el usuario. Hay una fascinante <a hreflang="en" href="https://github.com/WICG/largest-contentful-paint/issues/68">discusión</a> en la comunidad respecto a este tema y es posible que en el futuro las imágenes progresivas contribuyan al LCP. Puede haber un interés renovado en la comunidad de comercio electrónico respecto a los formatos que soportan la larga progresiva debido a esto y la inclusión de los Core Web Vitals como señal de experiencia de página en Mayo del 2021.

### Peticiones y bytes de terceros

Las plataformas de comercio electrónico y demás sitios frecuentemente usan contenido [de terceros](./third-party). Nosotros usamos el [Third Party Web project](./methodology#third-party-web) para detectar el uso de terceros.

{{ figure_markup(
  image="distribution-of-third-party-requests.png",
  caption="Distribución de las peticiones de terceros",
  description="Gráfico de barras que muestra el número de peticiones de terceros para sitios de comercio electrónico con el percentil 10 teniendo 8 peticiones en escritorio y 7 en móvil, el percentil 25 teniendo 16 y 15 respectivamente, el 50 teniendo 32 y 30, el 75 teniendo 60 y 58, y el percentil 90 teniendo 103 peticiones de terceros en escritorio y 98 en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1577985571&format=interactive",
  sheets_gid="1199548164",
  sql_file="pct_3pusage_bydevice.sql"
) }}

{{ figure_markup(
  image="distribution-of-third-party-bytes.png",
  caption="Distribución de bytes de terceros",
  description="Gráfico de barras que muestra el número de kilobytes de terceros para sitios de comercio electrónico, con el percentil 10 teniendo 88 KB en escritorio y 67 KB en móvil, el percentil 25 teniendo 242 y 208 respectivamente, el 50 teniendo 547 y 489, el 75 teniendo 1,179 y 1,098, y el percentil 90 teniendo 2,367 KB en escritorio y 2,155 KB en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1165664044&format=interactive",
  sheets_gid="1199548164",
  sql_file="pct_3pusage_bydevice.sql"
) }}

Vemos un aumento significativo en el uso de peticiones y bytes de terceros [comparado con los datos de terceros del año pasado](../2019/ecommerce#third-party-requests-and-bytes), pero no hemos podido identificar la causa en particular o un cambio notable en la detección. Nos encantaría escuchar <a hreflang="en" href="https://discuss.httparchive.org/t/2052">las opiniones de los lectores</a> en esto ya que ¡el uso de terceros básicamente se duplicó este año!

## Experiencia de usuario de comercio electrónico

El comercio electrónico se trata de crear clientes, y para lograrlo se requiere de un sitio web de buen rendimiento. En esta sección tratamos de mostrar la experiencia de usuario en el mundo real en sitios de comercio electrónico. Para lograr esto, hemos enfocado nuestro análisis en métricas de rendimiento percibido por el usuario, que son capturadas en las 3 métricas de los <a hreflang="es" href="https://web.dev/i18n/es/vitals/">Core Web Vitals</a>.

### Reporte de Experiencia de Usuario de Chrome

En esta sección analizamos los tres factores más importantes provenientes del [Chrome User Experience Report](./methodology#chrome-ux-report), los cuales pueden darnos a entender la experiencia de los usuarios en sitios de comercio electrónico en la vida real:

- Largest Contentful Paint (LCP)
- First Input Delay (FID)
- Cumulative Layout Shift (CLS)

Estas métricas buscan cubrir los elementos esenciales que son indicadores de una buena experiencia de usuario en una web. El capítulo de [Rendimiento](./performance) cubre esto en mayor detalle, pero aquí estamos interesados en mirar a estas métricas específicamente para sitios de comercio electrónico. Revisemos cada una de ellas.

#### Largest Contentful Paint

El Largest Contentful Paint (LCP) mide el punto en que el contenido principal de una página ha cargado, y por lo tanto la página es útil para el usuario. Esto lo hace al medir el tiempo de renderizado de la imagen o bloque de texto más largo visible en el viewport.

Esto es diferente al First Contentful Paint (FCP), que mide desde que la página carga hasta que el contenido como texto o imagen es primeramente mostrado. El LCP se considera un buen medio para medir cuando carga el contenido principal de una página.

En el contexto de comercio electrónico, esta métrica brinda una muy buena indicación del contenido más útil para los usuarios (e.g. El banner de imagen para páginas de aterrizaje, la imagen del 1er producto mostrado en páginas de listado/búsqueda, la imagen del producto en caso de una página de detalles del producto). Antes de esta métrica, los sitios debían implementar explícitamente una solución RUM, pero esta métrica democratiza la medición para cualquiera que no tenga los recursos o experiencia para hacerlo.

{{ figure_markup(
  image="ecommerce-real-user-largest-contentful-paint-experiences.png",
  caption="Experiencias de usuarios reales de Largest Contentful Paint",
  description="Gráfico de barras que muestra el número de sitios con un buen puntaje de LCP para las 5 plataformas de comercio electrónico más populares. WooCommerce tiene 21.73% para escritorio y 14.27% para móviles, Shopify tiene 64% y 47.47% respectivamente, Magento tiene 39.45% y 28.17%, Wix tiene 7.46% y 7.40%, y PrestaShop tiene 53.03% en escritorio y 38.08% en móvil.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1881724605&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

Vemos grandes niveles de variabilidad entre las principales plataformas con Wix y WooCommerce en particular con puntuaciones muy baja. Siendo dos de las 3 plataformas más usadas de comercio electrónico, ¡parece que tienen mejoras por hacer!

#### First Input Delay

El First Input Delay (FID) intenta medir la interactividad, o lo que es más importante, cualquier barrera a la interactividad cuando una página no responde mientras está ocupada procesando la página.

{{ figure_markup(
  image="ecommerce-real-user-first-input-delay-experiences.png",
  caption="Experiencias de usuarios reales de First Input Delay",
  description="Gráfico de barras que muestra el número de sitios con un buen puntaje FID para las 5 plataformas de comercio electrónico más populares. WooCommerce tiene 99.95% para escritorio y 92.36% para móviles, Shopify tiene 99.96% y 96.49% respectivamente, Magento tiene 99.99% y 89.02%, Wix tiene 88.30% y 37.95%, y PrestaShop tiene 99.93% en escritorio y 92.96% en móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=490091603&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

En general, los puntajes de FID son típicamente más altos de cualquiera de los demás Core Web Vitals, y es prometedor que los sitios de comercio electrónico, a pesar de hacer uso de muchos recursos y JavaScript como se vio anteriormente, mantengan puntajes algo en esta categoría.

#### Cumulative Layout Shift

El Cumulative Layout Shift (CLS) mide cuanto "se mueve" la página conforme carga y se coloca en la página el contenido. Por nuestros rastreos, esto estará limitado a la carga de página "above the fold", pero los sitios de comercio electrónico deben entender que por debajo del contenido inicialmente visible o cualquier otra interacción puede impactar al CLS más de lo que nuestras estadísticas muestran.

{{ figure_markup(
  image="ecommerce-real-user-cumulative-layout-shift-experiences.png",
  caption="Experiencias de usuarios reales de Cumulative Layout Shift",
  description="Gráfico de barras que muestra el número de sitios con un buen puntaje LCP para las 5 plataformas de comercio electrónico más populares. WooCommerce tiene 37.98% para escritorio y 51.40% para móviles, Shopify tiene 40.72% y 40.55% respectivamente, Magento has 38.11% y 38.28%, Wix tiene 58.15% y 57.47%, y PrestaShop tiene 51.56% en escritorio y 49.83% en móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1137826141&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

Cerca de la mitad de los sitios de comercio electrónico tienen buenos puntajes de CLS e interesantemente hay poca diferencia entre escritorio y móvil, a pesar de la convención habitual de que los dispositivos móviles suelen tener poca potencia y suelen experimentar cambios variables de red.

#### Core Web Vitals en general

Al revisar los Core Web Vitals en general, para aquellos sitios que aprueban las tres métricas vemos lo siguiente:

{{ figure_markup(
  image="ecommerce-real-user-core-web-vitals-exeriences.png",
  caption="Experiencias de usuarios reales de Core Web Vitals",
  description="Gráfico de barras que muestra el número de sitios con un buen puntaje de Core Web Vitals para las 5 plataformas de comercio electrónico más populares. WooCommerce tiene 10.72% para escritorio y 8.63% para móviles, Shopify tiene 28.78% y 21.24% respectivamente, Magento tiene 18.33% y 11.14%, Wix tiene 5.23% y 3.30%, y PrestaShop tiene 30.43% en escritorio y 19.10% en móviles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=733851599&format=interactive",
  sheets_gid="768760354",
  sql_file="core_web_vitals_passingmetrics_byvendor_bydevice.sql"
) }}

Esto es muy similar a la gráfica de LCP anterior, quizás un poco inesperado ya que es la que tiene más variabilidad y la mayoría de los sitios han fallado esta métrica.

## Herramientas

¿Cómo están usando los sitios de comercio electrónico las herramientas más comunes de Medición, Gestión de Etiquetas, Plataformas de Gestión de Consentimiento y soluciones de Accesibilidad?

### Analítica

{{ figure_markup(
  image="top-analytics-solutions-on-ecommerce-sites.png",
  caption="Principales soluciones de analítica en sitios de comercio electrónico",
  description="Gráfico de barras que muestra los principales proveedores de herramientas de analítica en orden descendente. Para móviles Google Analytics tiene un 77% de uso, GA Enhanced eCommerce tiene 22%, Hotjar tiene 6%, New Relic tiene 4%, TrackJs tiene 3%, Yandex.Metrika tiene 3%, Matomo Analytics tiene 2%, BugSnag tiene 2%, Liveinternet tiene 2%, comScore tiene 1%, y Quantcast Measure tiene 1%. El uso en escritorio es bastante similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=431305389&format=interactive",
  sheets_gid="618573782",
  sql_file="top_analytics_bydevice_vendor.sql"
) }}

Google Analytics tiene un puntaje nada sorprendente del 77% de los sitios móviles de comercio electrónico, pero quizás lo que es más sorprendente es que Google Analytics Enhanced Ecommerce solo es usado por 22% de los sitios de comercio electrónico, lo que refleja ya sea una oportunidad para el 55% de los sitios de aprovechar más su Google Analytics, o tal vez refleja otra limitación de nuestra metodología que está limitada a las páginas de inicio y es probable que algunos sitios solo lo carguen en sus páginas de compra.

HotJar es otra herramienta usada frecuentemente en sitios de comercio electrónico para analizar y mejorar el uso del sitio, así como conversiones, pero su uso es muy bajo en 6% para sitios móviles.

### Gestores de Etiquetas

Google Tag Manager se mantiene como el gestor de etiquetas más usado en sitios de comercio electrónico seguido por Adobe Tag Manager. No esperamos que esto cambie debido a la naturaleza gratuita de Google Tag Manager. En Agosto 2020, Google también lanzó el <a hreflang="en" href="https://developers.google.com/tag-manager/serverside">etiquetado del lado del servidor</a> en Google Tag Manager. Implementar el etiquetado del lado del servidor significará un pequeño costo para sitios de comercio electrónico, pero puede ayudar a los sitios a eliminar la sobre carga de terceros y, por ende, mejorar métricas como el Total Blocking Time (TBT), First Input Delay (FID) y Time to Interactive (TTI). Simon Ahava tiene <a hreflang="en" href="https://www.simoahava.com/analytics/server-side-tagging-google-tag-manager/">mucha información útil en su blog</a> que la recomendamos a los lectores.

La adopción del etiquetado del lado del servidor dependerá en que los terceros ofrezcan plantillas de etiquetado del lado del servidor para facilitar la migración. Aún son días tempranos para el etiquetado del lado del servidor de GTM y al momento de escribir este capítulo, no pudimos encontrar ninguna plantilla disponible públicamente en la <a hreflang="en" href="https://tagmanager.google.com/gallery/#/?context=server&page=1">galería de la comunidad</a>. Pero si la adopción aumenta, será interesante comparar los puntajes de rendimiento de sitios usando etiquetado del lado del cliente vs del lado del servidor. Otras empresas como Adobe, Signal también ofrecen soluciones similares de etiquetado del lado del servidor, que los sitios deberían considerar para ayudar con su rendimiento.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Gestor de Etiquetas</th>
        <th scope="col">Escritorio</th>
        <th scope="col">Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Google Tag Manager</td>
        <td class="numeric">48.45%</td>
        <td class="numeric">46.56%</td>
      </tr>
      <tr>
        <td>Adobe DTM</td>
        <td class="numeric">0.41%</td>
        <td class="numeric">0.38%</td>
      </tr>
      <tr>
        <td>Ensighten</td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>TagCommander</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td>Signal</td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>Matomo Tag Manager</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Yahoo! Tag Manager</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.00%</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th scope="col">Total</th>
        <th scope="col" class="numeric">49.14%</th>
        <th scope="col" class="numeric">47.20%</th>
      </tr>
    </tfoot>
  </table>
  <figcaption>{{ figure_link(caption="Tag manager usage on ecommerce sites.", sheets_gid="2045910168", sql_file="percent_of_ecommsites_using_each_tag_managers.sql") }}</figcaption>
</figure>

<p class="note">Nota: El análisis anterior está basado en la detección de Wappalyzer, que puede diferir del análisis realizado con los datos de <a href="./methodology#third-party-web">Third Party Web</a> que es usado en el capítulo de <a href="./third-parties">Contenido de Terceros</a>.</p>

### Plataformas de Gestión de Consentimiento

El capítulo de [Privacidad](./privacy) de este año abarcó la adopción de Plataformas de Gestión de Consentimiento en todos los tipos de sitios web. Cuando comparamos la adopción en sitios de comercio electrónico con todos los sitios web, vemos una ligeramente mayor adopción en dispositivos móviles (4.2% en sitios de comercio electrónico Vs 4.0% en todos los sitios) y en escritorio (4.6% en sitios de comercio electrónico Vs 4.4% en todos los sitios).

{{ figure_markup(
  image="ecommerce-consent-management-platform-adoption.png",
  caption="Adopción de Plataformas de Gestión de Consentimiento",
  description="Gráfico de barras que muestra que 4.4% de todos los sitios de escritorio y 4.0% de los sitios móviles usan una Plataforma de Gestión de Consentimiento, comparado con 4.6% y 4.2% respectivamente para sitios de comercio electrónico. Es así que los sitios de comercio electrónico tienen un uso ligeramente mayor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=285357141&format=interactive",
  sheets_gid="1374272999",
  sql_file="percent_of_ecommsites_using_cmp.sql"
) }}

En términos de las diferentes Plataformas de Gestión de Consentimiento, la tendencia para sitios de comercio electrónico fue similar a la de todos los sitios web analizados en el capítulo de [Privacidad](./privacy). En futuras ediciones del Web Almanac, esperamos que esta adopción aumente conforme más países establezcan sus propias regulaciones. Además, las "Plataformas de Gestión de Consentimiento" fueron recientemente agregadas a Wappalyzer por el equipo del Web Almanac. Aunque el equipo agregó las plataformas más populares, con el tiempo esperamos que más plataformas sean agregadas y por ende aumenten sus estadísticas de uso.

### Soluciones de accesibilidad

En la introducción del capítulo de [Accesibilidad](./accessibility) de este año, el equipo del Web Almanac habla sobre los peligros de implementar soluciones de accesibilidad rápidas y hacen referencia al gran artículo de Lainey Feingold, <a hreflang="en" href="https://www.lflegal.com/2020/08/quick-fix/">Honor the ADA: Avoid Web Accessibility Quick Fix Overlays</a>.

Aunque no es recomendado, analizamos el uso de dichas soluciones en los sitios de comercio electrónico y encontramos que el 0.47% de los sitios web móviles y 0.54% de los sitios de escritorio usan dichas soluciones.

En la metodología actual empleada para este capítulo, no hay una manera sencilla de analizar si algunos de los principales sitios de comercio electrónico han implementado soluciones rápidas en vez de tratar de conseguir accesibilidad por medio del diseño.  Será posible identificar esto en el futuro al combinar los datos del HTTP Archive con publicaciones como Los 500 Principales Sitios del Reino Unido por International Retailing o publicaciones similares.

### Uso de AMP

{{ figure_markup(
  caption="Uso de AMP en sitios de comercio electrónico (móviles).",
  content="0.61%",
  classes="big-number",
  sheets_gid="1317152621",
  sql_file="pct_ampusage_bydevice_vendor.sql"
)
}}

En el capítulo SEO cubrimos estadísticas sobre el [uso de AMP en todos los sitios web](./seo#amp). En este capítulo, analizamos el uso de AMP en sitios de comercio electrónico. El uso de AMP se mantiene bajo en sitios de comercio electrónico (0.61% en móvil y 0.66% en escritorio) ya que AMP aún no soporta todos los casos de uso del comercio electrónico. Además, en este análisis, dependemos de la detección mediante Wappalyzer y esto puede resultar en detecciones duplicadas donde AMP es implementado como un dominio diferente usando el elemento `<link rel="amphtml"...>` . Esto no debería ser un problema al revisar los porcentajes, ya que dichos dominios también son contabilizados dos veces al calcular el número total de sitios de comercio electrónico.

También consideramos analizar el rendimiento de CRUX para sitios de comercio electrónicos con sus equivalentes en AMP (cuando es implementado en un dominio diferente usando el atributo `amphtml`). Dicho análisis nos ayudaría a identificar si hay una diferencia significativa de rendimiento entre con el dominio AMP, pero debido al bajo nivel de uso de AMP en los sitios de comercio electrónico, dicho análisis podría no dar resultados relevantes y aplazamos el análisis para años futuros (si las tasas de uso aumentan).

### Notificaciones Web Push

Las notificaciones push son muy populares hoy en día pero, según la experiencia del autor, el conocimiento sobre las notificaciones push por parte de los profesionales de marketing es todavía muy escaso, a pesar de la introducción de la <a hreflang="en" href="https://developers.google.com/web/updates/2015/03/push-notifications-on-the-open-web">Push API</a> en el 2015 por primera vez en Chrome. Intentamos revisar la adopción de las notificaciones web push (que es posible usando tecnologías como service workers) en sitios de comercio electrónico. Como parte de los datos de permisos de notificaciones del CRUX, tenemos acceso a métricas como tasas de aceptación y de rechazo. Consulte este <a hreflang="en" href="https://developers.google.com/web/updates/2020/02/notification-permission-data-in-crux">artículo de Google</a> para más detalles del cómo son capturados estos datos y que métricas están disponibles.

En nuestro análisis encontramos que solo 0.68% de los sitios de comercio electrónico en escritorio y 0.69& en móviles, usan notificaciones web push. En cuanto a las notificaciones push, es importante que los clientes encuentren las notificaciones útiles. Una clave para esto es solicitar permiso en el momento adecuado del recorrido del cliente y no bombardear a usuarios con notificaciones irrelevantes. Para hacer frente al cansancio de los clientes con las notificaciones push, Chrome automáticamente agregará a los sitios con baja tasa de aceptación en <a hreflang="en" href="https://blog.chromium.org/2020/05/protecting-chrome-users-from-abusive.html"> notificaciones UI discretas</a> (aunque todavía no se define el umbral exacto). Las notificaciones UI estándar se restablecerán para el sitio cuando sus tasas de aceptación del grupo de control mejoren.

PJ Mclachlan (Product Manager, Google) ha hablado sobre <a hreflang="en" href="https://www.youtube.com/watch?v=J_t8c9HOjBc">establecer al menos un 50% de tasa de aceptación</a> para evitar ser asignado a notificaciones UI discretas, y establecer un 80% o más de tasa de aceptación. Las tasas de aceptación promedio para un sitio de comercio electrónico son de 13.6% en móvil y 13.2% en escritorio. A nivel promedio, estas tasas de aceptación tienen mucho que desear. Aún en el percentil 90, los números no se ven muy bien (36.9% en móvil y 36.8% en escritorio). Los sitios de comercio electrónico pueden revisar <a hreflang="en" href="https://www.youtube.com/watch?v=riKmez3sHaM">esta plática para socios recomendados para asegurar que las tasas de aceptación se mantengan saludables</a> y evitar que sean sorprendidos por los próximos cambios de notificaciones abusivas.

{{ figure_markup(
  image="web-push-notification-acceptance-rates.png",
  caption="Tasas de aceptación de Notificaciones Web Push",
  description="Gráfico de barras que muestra las tasas de aceptación para las Notificaciones Web Push, con el percentil 10 teniendo 4% en móvil, el percentil 25 teniendo 9%, el 50 teniendo 14%, el 75 teniendo 20%, el 90 teniendo 37% y el 100 teniendo 89% de tasas de aceptación. Las tasas de aceptación de escritorio son bastante similares.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ65OxpVGpTJVuFhG6EIO55Z_itqFtGnoYLm7W7SEBaRL-YGDUJsBMVrlDjLa-fNdeyNdqXxJt4a-xc/pubchart?oid=1062364223&format=interactive",
  sheets_gid="2129008669",
  sql_file="webpushstats_ecommsites.sql"
) }}

## Futuras oportunidades de análisis

También será interesante revisar la adopción de aplicaciones nativas por los sitios de comercio electrónico con el aprovechamiento de estándares de aplicaciones nativas como `.well-known/assetlinks.json` en Play Store y `.well-known/apple-app-site-association` en App Store. Google ha facilitado a las PWAs que logren esto usando Trusted Web Activity, pero actualmente no hay estadísticas publicas disponibles sobre cuantos sitios podrían estar usando esta técnica para publicar sus PWAs en Play Store.

El capítulo [SEO](./seo) de este año incluye un análisis de sitios web que usan los atributos `hreflang` y `lang`, así como el HTTP header  `content-language`. Esto, combinado con la detección de Wappalyzer de soluciones internacionales como Global-e, Flow, y Borderfree, representa una oportunidad para mirar a los aspectos internacionales de los sitios de comercio electrónico. Actualmente Wappalyzer no cuenta con una categoría separada para "comercio internacional", por lo que este tipo de análisis no es posible a menos que creemos un repositorio con dichas soluciones por nuestra cuenta.

Wappalyzer también provee la detección de soluciones de pago (Apple Pay / PayPal / ShopPay etc.), pero basado en los tipos de implementación y solución, no siempre es posible detectar esto al solo analizar la página principal, dicho análisis puede ser útil para las tendencias anuales.

## Conclusión

El Covid-19 aceleró masivamente el crecimiento del comercio electrónico en 2020, y muchas empresas pequeñas tuvieron que establecer rápidamente su presencia online y encontrar oportunidades de ventas durante el confinamiento. Plataformas como WooCommerce/Shopify/Wix/BigCommerce tuvieron un rol muy importante en establecer a más pequeños negocios online. El Covid-19 también contribuyó al lanzamiento de la oferta D2C (directo al consumidos) por las marcas, y se espera que esto aumente en el futuro. El impacto completo del Covid-19 puede no ser visible en el Web Almanac de este año, ya que nuevos negocios deben tener cierta cantidad de tráfico para ser parte del conjunto de datos del CRUX que usamos para nuestro análisis. Es por ello que podemos ver un crecimiento continuo en el análisis del próximo año.

Mejorar los Core Web Vitals será una prioridad para negocios de comercio electrónico debido a los cambios anunciados por Google, además, los equipos de marketing que usan las Notificaciones Web Push deben vigilar sus estadísticas usando el CRUX para evitar ser sorprendidos por futuros cambios en las notificaciones abusivas. Los Gestores de Etiquetas parecen seguir causando mucha fricción entre los equipos de marketing y desarrollo y soluciones como el etiquetado del lado del servidor de Google Tag Manager hará algunos avances, pero no esperamos que cambie mucho en 2021 y será más un camino de 3-5 años, pero la comunidad debe preguntar a sus respectivos terceros que brinden soluciones compatibles para evolucionar este ecosistema.

Sin olvidar la limitación de que para este análisis solo usamos datos de las páginas principales, nos gustaría escuchar de la comunidad que más deberíamos cubrir en el análisis del siguiente año. Hemos incluido oportunidades de análisis en la sección anterior y cualquier <a hreflang="en" href="https://discuss.httparchive.org/t/2052">sugerencia es muy apreciada</a>.
