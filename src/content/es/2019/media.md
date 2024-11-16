---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Media
description: Capítulo Multimedia del 2019 Web Almanac que cubre los tamaños y formatos de archivo de imagen, las imágenes adaptables (responsive), los client hints, el lazy loading, la accesibilidad y los vídeos.
hero_alt: Hero image of Web Almanac chracters projecting an image onto a screen while other Web Almanac characters walk to cinema seats with popcorn to watch the projection.
authors: [colinbendell, dougsillars]
reviewers: [ahmadawais, eeeps]
analysts: [dougsillars, rviscomi]
editors: [tunetheweb]
translators: [garcaplay]
discuss: 1759
results: https://docs.google.com/spreadsheets/d/1hj9bY6JJZfV9yrXHsoCRYuG8t8bR-CHuuD98zXV7BBQ/
colinbendell_bio: <i lang="en">Colin is part of the CTO Office at <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a> and co-author of the OReilly book <a hreflang="en" href="https://www.oreilly.com/library/view/high-performance-images/9781491925799/">High Performance Images</a>. He spends much of his time at the intersection of high volume data, media, browsers and standards. You can find him on tweeting <a href="https://x.com/colinbendell">@colinbendell</a> and at blogging at <a hreflang="en" href="https://bendell.ca/">https://bendell.ca</a>.</i>
dougsillars_bio: <i lang="en">Doug Sillars is a freelance digital nomad working on the intersection of performance and media. He tweets <a href="https://x.com/dougsillars">@dougsillars</a>, and blogs regularly at <a hreflang="en" href="https://dougsillars.com">dougsillars.com</a>.</i>
featured_quote: Las imágenes, animaciones y vídeos son una parte importante de la experiencia web. Son importantes por muchas razones&colon; ayudan a contar historias, atraen a la audiencia y proporcionan expresión artística de una forma que a menudo no puede ser conseguida fácilmente a través de otras tecnologías web. La importancia de estos recursos multimedia puede ser demostrada de dos formas&colon; por la gran cantidad de bytes que se requieren para descargar cada página, y también por la cantidad de píxeles que componen esos recursos.
featured_stat_1: 1 MB
featured_stat_label_1: Tamaño medio de las páginas de inicio
featured_stat_2: 60%
featured_stat_label_2: Uso de JPEG entre imágenes
featured_stat_3: 2%
featured_stat_label_3: Uso del elemento `<picture>`
---

## Introducción
Las imágenes, animaciones y vídeos son una parte importante de la experiencia web. Son importantes por muchas razones: ayudan a contar historias, atraen a la audiencia y proporcionan expresión artística de una forma que a menudo no puede ser conseguida fácilmente a través de otras tecnologías web. La importancia de estos recursos multimedia puede ser demostrada de dos formas: por la gran cantidad de bytes que se requieren para descargar cada página, y también por la cantidad de píxeles que componen esos recursos.

Desde una perspectiva puramente de bytes, el <i lang="en">HTTP Archive</i> ha <a hreflang="en" href="https://legacy.httparchive.org/interesting.php#bytesperpage">registrado históricamente</a> una media de dos tercios de bytes de recursos vinculados con recursos multimedia. Desde la perspectiva de la distribución, podemos ver que prácticamente toda página web depende de imágenes y vídeos. Incluso en el percentil 10, podemos ver que un 44% de los bytes son de recursos multimedia y puede llegar al 91% del total de bytes en las páginas del percentil 90.

{{ figure_markup(
  image="fig1_bytes_images_and_video_versus_other.png",
  caption="Bytes por página web: imagen y vídeo frente a otros.",
  description="Gráfico de barras mostrando que en el percentil 10 un 44,1% de los bytes de la página son recursos multimedia, en el percentil 25 un 52,7% son recursos multimedia, en el percentil 50 un 67,0% son recursos multimedia, en el percentil 75 un 81,7% son recursos multimedia, y en el percentil 90 un 91,2% son recursos multimedia.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1189524305&format=interactive"
  )
}}

Mientras que los recursos multimedia son esenciales para la experiencia visual, el impacto de este gran volumen de bytes tiene dos efectos colaterales.

Primero, la carga de red requerida para descargar estos bytes puede ser alta y en un móvil o una red lenta (como la de las cafeterías o el Uber) puede ralentizar drásticamente el [rendimiento](./performance) de la página. Las imágenes son la petición del navegador de menor prioridad pero pueden bloquear fácilmente la descarga del CSS y JavaScript. Esto, por sí mismo, puede ralentizar el renderizado de la página. Aun así, en otras ocasiones, el contenido de la imagen es, para el usuario, la indicación visual de que la página se ha cargado. Por lo tanto, las transferencias lentas del contenido visual pueden dar la impresión de una página web lenta.

La segunda consecuencia es el coste económico que supone para el usuario. Normalmente, este aspecto es poco tenido en cuenta ya que no afecta al dueño del sitio web, sino al usuario final.  Como anécdota, se ha difundido que algunos mercados, [como el de Japón](https://x.com/yoavweiss/status/1195036487538003968?s=20), han visto una caída en las compras hechas por estudiantes a finales de mes, cuando alcanzan los límites de datos y no pueden ver el contenido visual.

Es más, el coste económico de visitar estos sitios web en diferentes partes del mundo es desproporcionado. En la mediana y en el percentil 90, la cantidad de bytes por imagen es de 1 MB y de 1,9 MB respectivamente. A través de <i lang="en"><a hreflang="en" href="https://whatdoesmysitecost.com/#gniCost">WhatDoesMySiteCost.com</a></i>, podemos ver que el Producto Interior Bruto (PIB) per cápita en Madagascar supone al usuario un coste tal que la carga de una sola página web del percentil 90 equivaldría al 2,6% del ingreso bruto diario. Por el contrario, en Alemania esto supondría el 0,3% del ingreso bruto diario.

{{ figure_markup(
  image="fig2_total_image_bytes_per_web_page_mobile.png",
  caption="Total de bytes de una imagen por sitio web (móvil).",
  description="En la mediana, una página web en formato móvil requiere 1 MB para imágenes, y 4,9 MB en el percentil 90.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2025280105&format=interactive"
  )
}}

Analizar los bytes por página significa analizar el gasto por rendimiento de la página y por usuario, pero se pasan por alto los beneficios. Estos bytes son importantes para renderizar los píxeles en la pantalla. De este modo, también podemos ver la importancia de las imágenes y los recursos visuales a través del análisis de la cantidad de píxeles usados de media por página.

Hay tres métricas a tener en cuenta cuando se analiza el tamaño de píxeles: píxeles CSS, píxeles lógicos y píxeles físicos:

* El _tamaño de pixel CSS_ es desde el punto de vista del diseño. Esta medida se centra en la caja delimitadora a la que la imagen o el vídeo pueden adaptarse, expandiéndose o comprimiéndose. No tiene en cuenta ni los verdaderos píxeles del archivo ni los de la pantalla.
* Los _píxeles lógicos_ se refieren a aquellos píxeles que conforman un archivo. Si tuvieras que cargar esa imagen en GIMP o en Photoshop, las dimensiones en píxeles de dicho archivo serían los píxeles lógicos (o píxeles naturales).
* Los _píxeles físicos_ se refieren a las partes electrónicas de la pantalla. Antes del móvil y de las modernas pantallas de alta resolución, había una relación 1:1 entre los píxeles CSS y los puntos LED de una pantalla. Sin embargo, debido a que los dispositivos móviles son sostenidos muy próximos al ojo y que las pantallas de los ordenadores están más cerca que los monitores de los terminales antiguos, las pantallas actuales tienen un ratio mayor de píxeles físicos que los tradicionales píxeles CSS. Este ratio es el <i lang="en">Device-Pixel-Ratio</i>, coloquialmente llamado Retina™.

{{ figure_markup(
  image="fig3_image_pixel_per_page_mobile_css_v_actual.png",
  caption="Píxeles de una imagen por página (móvil): CSS versus real.",
  description=" Una comparación entre los píxeles CSS distribuidos en el contenido de la imagen y los píxeles reales en móvil, mostrando el percentil 10 (0,07 MP reales, 0,04 MP CSS), el percentil 25 (0,38MP reales, 0,18 MP CSS), el percentil 50 (1,6 MP reales, 0,65 MP CSS), el percentil 75 (5,1 MP reales, 1,8 MP CSS), y el percentil 90 (12 MP reales, 4,6 MP CSS).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2027393897&format=interactive"
  )
}}

{{ figure_markup(
  image="fig4_image_pixel_per_page_desktop_css_v_actual.png",
  caption="Píxeles de una imagen por página (escritorio): CSS versus real.",
  description=" Una comparación entre los píxeles CSS distribuidos en el contenido de la imagen y los píxeles reales en escritorio, mostrando el percentil 10 (0,09 MP reales, 0,05 MP CSS), el percentil 25 (0,52 MP reales, 0,29 MP CSS), el percentil 50 (2,1 MP reales, 1,1 MP CSS), el percentil 75 (6,0 MP reales, 2,8 MP CSS), y el percentil 90 (14 MP reales, 6,3 MP CSS).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1364487787&format=interactive"
  )
}}

Si miramos el volumen del pixel CSS y del pixel lógico, podemos observar que el sitio web medio tiene un diseño que muestra un megapixel (MP) de contenido multimedia. En el percentil 90, el volumen de la distribución del pixel CSS aumenta hasta 4,6 MP y 6,3 MP en móvil y escritorio respectivamente. Esto es interesante, no solo porque probablemente el diseño <i lang="en">responsive</i> sea diferente, sino también porque el factor de forma es diferente. En resumen, el diseño móvil tiene menos espacio para el contenido multimedia comparado con el de escritorio.

Por el contrario, el volumen del pixel lógico, o real, es entre 2 y 2,6 veces el volumen del diseño. La página web para escritorio media envía 2,1 MP de contenido pixel que es distribuido en 1,1 MP de espacio en el diseño. En el percentil 90 para móvil vemos que 12 MP son comprimidos a 4,6 MP.

Por supuesto, el factor forma para dispositivos móviles es diferente al de escritorio. Un dispositivo móvil es más pequeño y normalmente se sujeta en vertical, mientras que un ordenador es más grande y se usa principalmente en horizontal. Como se ha mencionado anteriormente, un dispositivo móvil también tiene habitualmente un ratio pixel-dispositivo (DPR por sus siglas en inglés: <i lang="en">Device Pixel Ratio</i>) mayor porque se sujeta mucho más cerca del ojo, necesitando más píxeles por pulgada, en comparación, que los que se necesitan para una pantalla publicitaria en Times Square. Estas diferencias fuerzan cambios en el diseño y los usuarios desde móviles tienen normalmente que hacer scroll por el sitio para poder consumir la totalidad de su contenido.

Los megapíxeles son una unidad de medida compleja porque es bastante abstracta. Una forma muy útil de expresar la cantidad de píxeles que están siendo usados en una página web es representándola como el ratio relativo al tamaño de la pantalla.

Para los dispositivos móviles usados en el rastreo (<i lang="en">crawl</i>) de páginas web, tenemos unas dimensiones de `512 x 360`, que suponen un 0,18 MP de contenido CSS (no confundir con las pantallas físicas para las cuales es `3x` o 3^2 píxeles más, 1,7 MP). Si se divide esta cantidad de píxeles del visor por el número de píxeles CSS correspondiente a las imágenes, obtenemos la cantidad de píxeles relativa.

Si tuviéramos una imagen que ocupase perfectamente la totalidad de la pantalla, el ratio de relleno de píxeles sería de 1x. Por supuesto, rara vez una página web ocupa la pantalla completa con una única imagen. El contenido multimedia suele mezclarse con el diseño y otro tipo de contenido. Un valor superior a 1x significa que el diseño requiere que el usuario haga scroll para ver el resto de la imagen.

<p class="note">Nota: esto es únicamente analizando el diseño CSS para tanto el <i lang="en">DPR</i> como para la cantidad de contenido del diseño. No está evaluándose la efectividad de las imágenes <i lang="en">responsive</i> o la efectividad de facilitar un contenido con alto DPR.</p>

{{ figure_markup(
  image="fig5_image_pixel_volume_v_css_pixels.png",
  caption="Cantidad de píxeles en una imagen versus el tamaño de la pantalla (píxeles CSS).",
  description="Una comparación entre la cantidad de píxeles necesaria por página en relación con el tamaño real de la pantalla en píxeles CSS, mostrando el percentil 10 (20% en móvil, 20% en escritorio), el percentil 25 (97% en móvil, 13% en escritorio), el percentil 50 (354% en móvil, 46% en escritorio), el percentil 75 (1003% en móvil, 123% en escritorio), y el percentil 90 (2477% en móvil, 273% en escritorio).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1889020047&format=interactive"
  )
}}

Para la página web media en formato escritorio, solamente el 46% de la pantalla tendría contenido con imágenes y vídeo. En contraposición, en móvil, la cantidad de píxeles multimedia sería 3,5 veces el tamaño real de la ventana. El diseño tiene más contenido que lo que puede ser mostrado en una sola pantalla, requiriendo el uso del scroll. Como mínimo, hay 3,5 páginas de contenido con scroll por sitio (dando por hecho un 100% de saturación). En el percentil 90 para móvil, ¡esto aumenta sustancialmente a 25x el tamaño de la ventana!

Los recursos multimedia son esenciales para la experiencia del usuario.

## Imágenes

Ya se ha escrito mucho sobre la gestión y optimización de imágenes para ayudar a reducir los bytes y mejorar la experiencia de usuario. Este es un tema importante y esencial para muchos porque son los medios creativos los que definen la experiencia de marca. Por ello, optimizar el contenido de imagen y vídeo es un equilibrio entre aplicar las mejores prácticas que ayuden a reducir los bytes transferidos por la red y mantener la fidelidad de la experiencia prevista.

Mientras que el enfoque utilizado para imágenes, vídeos y animaciones son, a grandes rasgos, similares, sus abordajes específicos pueden ser muy diferentes. En general, estas estrategias se reducen a:

* **Formatos de archivo** - utilizando el formato de archivo óptimo.
* **Adaptable** - aplicando técnicas de imágenes <i lang="en">responsive</i> para transferir únicamente los píxeles que serán mostrados en pantalla.
* **<i lang="en">Lazy loading</i>** - para trasladar solamente contenido que pueda ser visto por un humano.
* **Accesibilidad** - asegurando una experiencia consistente para todos los seres humanos.

<p class="note">Una advertencia a la hora de interpretar estos resultados. Las páginas webs rastreadas para el Web Almanac fueron rastreadas con un navegador Chrome. Esto significa que la negociación de contenido que pueda estar mejor integrada para Safari o Firefox podría no estar representada en este conjunto de datos. Por ejemplo, el uso de formatos de archivos como JPEG2000, JPEG-XR, HEVC, y HEIC no están representados porque estos no son compatibles de forma nativa con Chrome. Esto no significa que la web no contenga estos otros formatos o experiencias. Del mismo modo, Chrome tiene soporte nativo para <i lang="en">lazy loading</i> (desde la v76) el cual no está disponible en otros navegadores. Puedes leer más sobre estas excepciones en <a href="./methodology">Metodología</a>.</p>

Es raro encontrar una página web que no utilice imágenes. A lo largo de los años, han aparecido muchos formatos de archivo diferentes para ayudar a mostrar el contenido en la web, cada uno abordando un problema diferente. Principalmente, hay 4 formatos de imagen universales: JPEG, PNG, GIF, y SVG. Además, Chrome ha mejorado el canal multimedia y añadido soporte a un quinto formato de imagen: WebP. Otros navegadores, del mismo modo, han añadido soporte para JPEG2000 (Safari), JPEG-XL (IE y Edge) y HEIC (WebView solamente en Safari).

Cada formato tiene sus propias ventajas y usos para la web. Una forma muy simple de resumirlo sería:

<figure>
  <table>
    <thead>
      <tr>
        <th>Formato</th>
        <th class="width-45">Ventajas</th>
        <th class="width-45">Desventajas</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>JPEG</td>
        <td><ul><li>Soporte generalizado</li><li>Perfecto para contenido fotográfico</li></ul></td>
        <td><ul><li>Siempre hay pérdida de calidad</li><li>La mayoría de decodificadores no pueden manejar fotografías de alta profundidad de bits tomadas con cámaras modernas (> 8 bits por canal)</li><li>No hay soporte para transparencia</li></ul></td>
      </tr>
      <tr>
        <td>PNG</td>
        <td><ul><li>Como el JPEG y el GIF, comparte amplia compatibilidad</li><li>Sin pérdidas</li><li>Soporta transparencia, animación y alta profundidad de bits</li></ul></td>
        <td><ul><li>Archivos más grandes en comparación con el JPEG</li><li>No es el ideal para contenido fotográfico</li></ul></td>
      </tr>
      <tr>
        <td>GIF</td>
        <td><ul><li>El predecesor del PNG, más conocido por las animaciones</li><li>Sin pérdidas</li></ul></td>
        <td><ul><li>Debido a la limitación de 256 colores, durante la conversión siempre hay pérdida visual</li><li>Archivos muy grandes para las animaciones</li></ul></td>
      </tr>
      <tr>
        <td>SVG</td>
        <td><ul><li>Un formato vectorial que puede ser redimensionado sin aumentar el tamaño del archivo</li><li>Se basa en matemáticas más que en píxeles y genera unas líneas muy suaves</li></ul></td>
        <td><ul><li>No es útil para fotografía u otros contenidos de gráfico por puntos</li></ul></td>
      </tr>
      <tr>
        <td>WebP</td>
        <td><ul><li>Un formato de archivo más nuevo que puede crear imágenes sin pérdida, como el PNG, y con pérdida, como el JPEG</li><li><a hreflang="en" href="https://developers.google.com/speed/webp/faq">Presume de una reducción comparada promedia del 30% en archivos</a> a JPEG, mientras que otros datos sugieren que la mediana de reducción de archivo está <a hreflang="en" href="https://cloudinary.com/state-of-visual-media-report/">entre el 10-28% basado en la cantidad de píxeles</a>.</li></ul></td>
        <td><ul><li>Al contrario que el JPEG, se limita al submuestreo de crominancia lo que hará que algunas imágenes se muestren borrosas.</li><li>No tiene una compatibilidad universal. Únicamente ecosistemas Chrome, Firefox y Android.</li><li>Compatibilidad con funciones fragmentadas dependiendo de la versión de navegador</li></ul></td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Explicación de los formatos de archivo convencionales.") }}</figcaption>
</figure>

### Formatos de imagen

Además, en toda la página, podemos ver la prevalencia de estos formatos. JPEG, uno de los formatos más antiguos de la web, es de lejos el que más comúnmente se utiliza como formato de imagen, con un 60% de peticiones de imagen y un 65% de todos los bytes de imagen. Curiosamente, el PNG es el segundo formato de imagen más común, con un 28% de peticiones de imágenes y bytes. La ubicuidad de la compatibilidad junto con la precisión del color y el contenido creativo son, probablemente, el porqué de su extendido uso. Por otro lado, SVG, GIF y WebP comparten un porcentaje de uso muy similar, el 4%.

{{ figure_markup(
  image="fig7_image_format_usage.png",
  caption="Uso del formato de imagen.",
  description="Un gráfico de estructura de árbol mostrando que los JPEGs son usados un 60,27% de las veces, los PNGs el 28,2%, el WebP el 4,2%, el GIF el 3,67% y el SVG el 3,63%.",
  width=600,
  height=376
  )
}}

Por supuesto, las páginas webs no son uniformes en el uso del contenido de imagen. Algunas dependen de las imágenes más que otras. Basta con que mires la página principal de `google.com` y veas las pocas imágenes que muestra en comparación con el resto de las típicas páginas webs modernas. De hecho, la página web media tiene 13 imágenes, 61 imágenes en el percentil 90, y se dispara en el percentil 99 a 229 imágenes.

{{ figure_markup(
  image="fig8_image_format_usage_per_page.png",
  caption="Formato de imagen usado por página.",
  description="Un gráfico de barras mostrando en el percentil 10 que no se usa ningún tipo de formato de imagen, en el percentil 25 se usan tres JPGS y cuatro PNGs, en el percentil 50 nueve JPGs, cuatro PNGs y un GIF, en el percentil 75 39 JPEGs, 18 PNGs, dos SVGs, y dos GIFs, y en el percentil p99 119 JPGs, 49 PNGs, 28 WebPs, 19 SVGs y 14 GIFs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=294858455&format=interactive"
  )
}}

Mientras que la página media tiene nueve JPEGS y cuatro PNGs, y solamente en el primer 25% de las páginas se usan GIFs, esto no representa la tasa de adopción. El uso y recurrencia de cada formato por página no proporciona información sobre la adopción de formatos más modernos. Concretamente, qué porcentaje de páginas incluye al menos una imagen por cada formato.

{{ figure_markup(
  image="fig9_pages_using_at_least_1_image.png",
  caption="Porcentaje de páginas que usan al menos una imagen.",
  description="Un gráfico de barras mostrando que los JPEGs son usados en el 90% de las páginas, los PNGs en un 89%, el WebP en un 9%, el GIF en un 37% y el SVG un 22%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1024386063&format=interactive"
  )
}}

Esto ayuda a explicar por qué, incluso en el percentil 90 de las páginas, la recurrencia del WebP es todavía nula; únicamente el 9% de las páginas web tienen al menos un recurso. Hay muchas razones por las que WebP podría no ser la mejor elección para una imagen, pero la adopción de las mejores prácticas multimedia, como la adopción del propio WebP, es todavía incipiente.

### Tamaños de archivo de imagen

Hay dos formas de analizar los tamaños de archivo de imagen: total de bytes por recursos y bytes por pixel.

{{ figure_markup(
  image="fig10_image_format_size.png",
  caption="Tamaño de archivo (KB) por formato de imagen.",
  description="Un gráfico mostrando que en el percentil 10 se usan 4 KB de JPEGs, 2 KB de PNGs y 2 KB de GIFs, en el percentil 25 se usan 9 KB de JPGs, 4 KB de PNGs, 7 KB de WebP, y 3 KB de GIFs, en el percentil 50 se usan 24 KB de JPGs, 11 KB de PNGs, 17 KB de WebP, 6 KB de GIFs y 1 KB de SVGs, en el percentil 75 se usan 68 KB de JPEGs, 43 KB de PNGs 41 KB de WebPs, 17 KB de GIFs y 2 KB de SVGs, y en el percentil 90 se usan 116 KB de JPGs, 152 KB de PNGs, 90 KB de WebPs, 87 KB de GIFs y 8 KB de SVGs."
  )
}}

A partir de esto, podemos hacer una idea de cuán grande o pequeño es el recurso habitual de una web. Sin embargo, esto no nos muestra la cantidad de píxeles en pantalla para estas distribuciones de archivo. Para ello podemos dividir cada recurso de bytes por la cantidad de píxeles lógicos de la imagen. A menor cuantía de bytes por pixel, mayor eficiencia en la transmisión del contenido visual.

{{ figure_markup(
  image="fig11_bytes_per_pixel.png",
  caption="Bytes por pixel.",
  description=" Un gráfico de velas que muestra en el percentil 10 que tenemos 0,1175 bytes por pixel para JPEG, 0,1197 para PNG, 0,1702 para GIF, 0,0586 para WebP y 0,0293 para SVG. En el percentil 25 tenemos 0,1848 bytes por pixel para JPEGs, 0,2874 para PNG, 0,3641 para GIF, 0,1025 para WebP, y 0,174 para SVG. En el percentil 50 tenemos 0,2997 bytes por pixel para JPEGs, 0,6918 para PNG, 0,7967 para GIF, 0,183 para WebP, y 0,6766 para SVG. En el percentil 75 tenemos 0,5456 bytes por pixel para JPEGs, 1,4548 para PNG, 2,515 para GIF, 0,3272 para WebP, y 1,9261 para SVG. En el percentil 90 tenemos 0,9822 bytes por pixel para JPEGs, 2,5026 para PNG, 8,5151 para GIF, 0,6474 para WebP, y 4,1075 para SVG",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1379541850&format=interactive"
  )
}}

Aunque previamente se había visto que los archivos GIF son más pequeños que los JPEG, ahora podemos ver claramente que la razón de esos recursos JPEG de mayor envergadura es su cantidad de píxeles. Seguramente no sea una sorpresa ver que los GIF muestran una densidad de píxeles mucho menor que la de otros formatos, en comparación. Además, aunque el PNG puede gestionar una alta profundidad de bits y no verse afectado por el desenfoque del submuestreo de crominancia, se traduce en el doble de tamaño que en JPG o WebP para el mismo número de píxeles.

Cabe señalar que el volumen de pixel usado para SVG es el tamaño del elemento del DOM en pantalla (en píxeles CSS). Pese a ser considerablemente menor en tamaño de archivo, esto nos da pie a pensar que normalmente los SVGs son usados en las partes del diseño más pequeñas. Esta es la razón por la que los bytes por pixel empeoran en comparación con el PNG.

Nuevamente, cabe destacar que esta comparación de densidad de pixel no es equivalente a comparar las imágenes. Más bien muestra la experiencia de usuario típica. Como veremos más adelante, incluso en cada uno de estos formatos hay diferentes técnicas que pueden ser usadas para optimizar todavía más y reducir los bytes por pixel.

### Optimización del formato de imagen

Ser capaz de seleccionar el mejor formato para cada experiencia es el arte de poder equilibrar las capacidades del formato reduciendo el total de bytes. Con las páginas web, un objetivo es la mejora del rendimiento de la web mediante la optimización de imágenes. Y aún así, dentro de cada formato hay funciones adicionales que permiten reducir los bytes.

Algunas funciones pueden afectar a la experiencia de usuario. Por ejemplo, tanto JPEG como WebP pueden utilizar la _cuantificación_ (comúnmente conocida como _niveles de calidad_) y el _submuestreo de crominancia_, con lo que reducen los bits almacenados en la imagen sin afectar la experiencia visual. Como el MP3 para la música, esta técnica depende de un fallo en el ojo humano que nos permite disfrutar de la misma experiencia pese a haber perdido información del color. Pese a todo, no todas las imágenes son adecuadas para usar estas técnicas ya que podrían volverse borrosas o dentadas, así como que se distorsionen los colores o que los bloques de texto se vuelvan ilegibles.

Otras funciones del formato simplemente organizan el contenido y, a veces, necesitan tener un contexto. Por ejemplo, aplicar una encriptación progresiva en un JPEG reorganizará los píxeles en capas digitales que permitirán al navegador completar la estructura más rápidamente y, a su vez, reducirá el volumen de píxeles.

El test <i lang="en">[Lighthouse](./methodology#lighthouse)</i> es una comparación A/B con una encriptación progresiva del JPEG. Esto facilita una guía para saber qué imágenes pueden ser optimizadas un poco más con técnicas sin pérdida y potencialmente con técnicas con pérdida como usar diferentes niveles de calidad.

{{ figure_markup(
  image="fig12_percentage_optimized_images.png",
  caption="Porcentaje de imágenes 'optimizadas'",
  description="Gráfico de barras mostrando que en el percentil 10 el 100% de las imágenes están optimizadas, igual que en el percentil 25, en el percentil 50 el 98% de las imágenes están optimizadas (un 2% no lo están), en el percentil 75 un 83% de las imágenes están optimizadas (un 17% no lo están), y en el percentil 90 un 59% de las imágenes están optimizadas y un 41% no lo están.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1569150767"
  )
}}

La ventaja de este test AB <i lang="en">Lighthouse</i> no es solo la potencial reducción de bytes, la cual puede suponer bastantes MBs en el p95, sino que también muestra la mejora del rendimiento de la página.

{{ figure_markup(
  image="fig13_project_perf_improvements_image_optimization.png",
  caption='Estimación de la mejora del rendimiento de la página tras la optimización de imagen de <i lang="en">Lighthouse</i>.',
  description="Gráfico de barras que muestra  que en el percentil 10 0 ms pudieron ser medidos, lo mismo pasa en el percentil 25, en el percentil 50 se redujeron 150 ms, en el percentil 75 se redujeron 1.460 ms, y en el percentil 90 se redujeron 5.720 ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=167590779"
  )
}}

### Imágenes adaptables (<i lang="en">responsive</i>) {imágenes-adaptables-responsive}

Otra forma de mejorar el rendimiento de la página es usar imágenes <i lang="en">responsive</i>. Esta técnica se basa en la reducción de bytes por imagen, mediante la reducción de aquellos pixeles de más que no estarán visibles debido al encogimiento de la imagen. Al comenzar este capítulo, viste cómo la página web media, en escritorio, usaba un MP de marcadores de imagen aunque transfiere 2,1 MP de volumen de pixel. Dado que esto era un test de 1x DPR, 1,1 MP de píxeles fueron transferidos por la red, pero no mostrados. Para reducir esta carga, podemos usar cualquiera de estas dos (posiblemente tres) técnicas:

* **Marcado HTML** - a través de la combinación de los elementos `<picture>` y `<source>`, junto con los atributos `srcset` y `sizes`, se facilita que el navegador pueda seleccionar la mejor imagen, basándose en las dimensiones de la ventana y la densidad de pantalla.
* **<i lang="en">Client Hints</i>** - esto pasa la selección de posibles imágenes redimensionadas a negociación de contenido HTTP.
* **BONUS**: Librerías de JavaScript para retrasar la carga de las imágenes hasta que el código JavaScript pueda ejecutar e inspeccionar el DOM del navegador e inyectar la mejor imagen para ese contenedor.

### Uso del marcado HTML

El método más usado para implementar las imágenes <i lang="en">responsive</i> es construir una lista de imágenes alternativas usando tanto `<img srcset>` como `<source srcset>`. Si el `srcset` está basado en DPR, el navegador podrá seleccionar la imagen correcta del listado sin información adicional. De todos modos, la mayoría de implementaciones también usan `<img sizes>` para ayudar a enseñar al navegador cómo realizar los cálculos de estructura necesarios para seleccionar la imagen correcta en el `srcset` en función de las dimensiones en píxeles.

{{ figure_markup(
  image="fig14_html_usage_of_responsive_images.png",
  caption="Porcentaje de páginas que usan imágenes adaptables con HTML.",
  description="Un gráfico de barras que muestra que el 18% de las imágenes usan 'sizes', un 21% usan 'srcset', y un 2% usan 'picture'.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=582530039&format=interactive"
  )
}}

No es sorprendente el notable menor uso del `<picture>` ya que se usan más a menudo para el diseño web <i lang="en">responsive</i> (RWD, siglas del inglés <i lang="en">responsive web design</i>) avanzado como el de [dirección de arte](https://developer.mozilla.org/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images#Art_direction).

### Uso de sizes

La utilidad de `srcset` normalmente depende de la precisión de la media query `sizes`. Sin `sizes` el navegador asumirá que la etiqueta `<img>` ocupará la ventana entera en lugar de un componente de menor tamaño. Curiosamente, hay 5 patrones comunes que los desarrolladores web han adoptado para `<img sizes>`:

* **`<img sizes="100vw">`** - este indica que la imagen ocupará toda la anchura de la ventana (el que se aplica por defecto).
* **`<img sizes="200px">`** - este es útil para la selección del navegador basada en DPR.
* **`<img sizes="(max-width: 300px) 100vw, 300px">`** - este es el segundo patrón de diseño más popular. Es el que se autogenera por WordPress y otro par de plataformas. Aparece autogenerado en base a su tamaño de imagen original (en este caso 300px).
* **`<img sizes="(max-width: 767px) 89vw, (max-width: 1000px) 54vw, ...">`** - este patrón es el patrón de diseño personalizado que se alinea con el diseño <i lang="en">responsive</i> del CSS. Cada punto de ruptura (<i lang="en">breakpoint</i>) tiene un cálculo diferente para los tamaños a usar.

<figure>
  <table>
    <thead>
      <tr>
        <th><code>&lt;img sizes&gt;</code></th>
        <th>Frecuencia (millones)</th>
        <th>%</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>(max-width: 300px) 100vw, 300px</code></td>
        <td class="numeric">1.47</td>
        <td class="numeric">5%</td>
      </tr>
      <tr>
        <td><code>(max-width: 150px) 100vw, 150px</code></td>
        <td class="numeric">0.63</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td><code>(max-width: 100px) 100vw, 100px</code></td>
        <td class="numeric">0.37</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td><code>(max-width: 400px) 100vw, 400px</code></td>
        <td class="numeric">0.32</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td><code>(max-width: 80px) 100vw, 80px</code></td>
        <td class="numeric">0.28</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Porcentaje de páginas que usan los patrones <code>sizes</code> más populares.") }}</figcaption>
</figure>

* **`<img sizes="auto">`** - éste es el que más se usa, aunque en realidad no es standard, sino producto del uso de la librería JavaScript `lazy_sizes`. Ésta usa un código del lado del cliente que inyecta mejores cálculos de `sizes` para el navegador. Su desventaja es que depende de la carga del JavaScript y de que el DOM esté completamente listo, retrasando sustancialmente la carga de las imágenes.

{{ figure_markup(
  image="fig16_top_patterns_of_img_sizes.png",
  caption="Top de patrones de <code><img sizes></code>.",
  description="Gráfico de barras que muestra que 11,3 millones de imágenes usan 'img sizes=`(max-width: 300px) 100vw, 300px`', 1,60 millones usan 'auto', 1 millón usan 'img sizes=`(max-width: 767px) 89vw...etc.`', 0,23 millones usan '100vw' y 0,13 millones usan '300px'",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=663985412&format=interactive"
  )
}}

### <i lang="en">Client Hints</i> {client-hints}

Los <i lang="en"><a hreflang="en" href="https://web.dev/user-agent-client-hints/">Client Hints</a></i> permiten a los creadores de contenido cambiar el redimensionamiento de imágenes por la negociación de contenido HTTP. De este modo, el HTML no necesita de `<img srcset>` adicionales para reordenar el marcado, y en su lugar depende de un servidor o <a hreflang="en" href="https://cloudinary.com/blog/client_hints_and_responsive_images_what_changed_in_chrome_67">imagen CDN para elegir la imagen óptima</a> en cada contexto. Esto permite simplificar el HTML y habilita a los servidores de origen para adaptar y desconectar el contenido y las capas de presentación.

Para habilitar los <i lang="en">Client Hints</i>, la página web debe señalizárselo al navegador usando bien un encabezado HTTP adicional `Accept-CH: DPR, Width, Viewport-Width` _o bien_ añadiendo el HTML `<meta http-equiv="Accept-CH" content="DPR, Width, Viewport-Width">`. La conveniencia de usar una u otra técnica depende del equipo que las esté implementando, ambas se ofrecen por conveniencia.

{{ figure_markup(
  image="fig17_usage_of_accept-ch_http_v_html.png",
  caption="Uso del encabezado <code>Accept-CH</code> versus la etiqueta <code><meta></code> equivalente.",
  description="Gráfico de barras mostrando que un 71% usa el 'meta http-equiv', un 30% usa el encabezado 'Accept-CH' HTTP y un 1% usa ambos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=284657706&format=interactive"
  )
}}

El uso de la etiqueta `<meta>` en HTML para invocar los <i lang="en">Client Hints</i> es bastante más común en comparación con el del encabezado HTTP. Esto es un claro reflejo de la comodidad de modificar el marcado de las plantillas en comparación con añadir los encabezados HTTP en cajas intermedias. De todos modos, analizando el uso del encabezado HTTP, más del 50% de estos casos provienen de una sola plataforma SaaS (Mercado).

De los <i lang="en">Client Hints</i> solicitados, la mayoría de las páginas los usan para los tres casos originales de `DPR`, `ViewportWidth` y `Width`. Por supuesto, el <i lang="en">Client Hint</i> `Width` necesita del uso de `<img sizes>` para que el navegador tenga el contexto necesario relativo al diseño.

{{ figure_markup(
  image="fig18_enabled_client_hints.png",
  caption="Client Hints habilitados.",
  description="Un gráfico circular de estilo donut que muestra que el 26,1% de los client hints usa 'dpr', 24,3% usa 'viewport-width', 19,7% usa 'width', 6,7% usa 'save-data', 6,1% usan 'device-memory', 6,0% usan 'downlink', 5,6% usan 'rtt' y 5,6% usan 'ect'",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1878506264&format=interactive"
  )
}}

Los <i lang="en">Client Hints</i> relacionados con la red, `downlink`, `rtt`, y `ect`, solamente están disponibles en Android Chrome.

### <i lang="en">Lazy loading</i> {lazy-loading}

Mejorar el rendimiento de una página web puede ser parcialmente descrito como un juego de ilusiones; moviendo las cosas más lentas fuera de banda y lejos de la vista del usuario. De este modo, el <i lang="en">lazy loading</i> de imágenes es una de esas ilusiones donde la imagen y el contenido multimedia solamente se cargan cuando el usuario se desplaza por la página. Esto mejora el rendimiento que se percibe, incluso en conexiones lentas, y evita al usuario la descarga de bytes que no van a estar visibles.

<!-- markdownlint-disable-next-line MD051 -->
Anteriormente, en la [Figura 4.5](#fig-5), mostramos como el volumen del contenido de imagen en el percentil 75 es bastante más de lo que, en principio, puede verse en una sola ventana de escritorio o móvil. La auditoría <i lang="en">Lighthouse</i> de <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/offscreen-images">imágenes fuera de pantalla</a> confirma nuestras sospechas. La página web media tiene un 27% de contenido de imagen significativamente por debajo del borde. Esto aumenta hasta el 84% en el percentil 90.

{{ figure_markup(
  image="fig19_lighthouse_audit_offscreen.png",
  caption='Auditoría <i lang="en">Lighthouse</i>: Fuera de pantalla.',
  description="Un gráfico de barras que muestra que en el percentil 10 un 0% de las imágenes se encuentran fuera de pantalla, en el percentil 25 un 2% están fuera de pantalla, en el percentil 50 un 27% están fuera de pantalla, en el percentil 75 un 64% están fuera de pantalla, y en el percentil 90 un 84% de las imágenes están fuera de pantalla.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2123391693&format=interactive"
  )
}}

La auditoría <i lang="en">Lighthouse</i> nos da solo una idea ya que hay un buen número de situaciones que pueden ser difíciles de detectar, como el uso de marcadores de calidad.

El <i lang="en">lazy loading</i> <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/lazy-loading-guidance/images-and-video">puede ser implementado</a> de muchas maneras, incluyendo el uso de una combinación de Observadores de intersección (<i lang="en">Intersection Observers</i>), Observadores de redimensión (<i lang="en">Resize Observers</i>), o el uso de librerías de JavaScript como <a hreflang="en" href="https://github.com/aFarkas/lazysizes">lazySizes</a>, <a hreflang="en" href="https://github.com/ApoorvSaxena/lozad.js">lozad</a>, y otras tantas.

En agosto de 2019, Chrome 76 fue lanzado con la compatibilidad para un <i lang="en">lazy loading</i> basado en marcado usando `<img loading="lazy">`. Aunque la instantánea de los sitios web usada para el 2019 Web Almanac utilizaba datos de julio de 2019, más de 2.509 sitios web ya utilizaban esta función.

### Accesibilidad

En el centro de la accesibilidad de imagen se encuentra la etiqueta `alt`. Cuando la etiqueta `alt` es añadida a una imagen, su texto puede ser usado para describir la imagen a un usuario que no puede ver dichas imágenes (bien debido a una discapacidad, o bien debido a una mala conexión a internet).

Podemos encontrar todas las etiquetas de imagen en los archivos HTML del conjunto de datos. De las 13 millones de etiquetas de imagen que hay en versión escritorio y de las 15 millones que hay en versión móvil, un 91,6% tienen una etiqueta `alt` asociada. A primera vista, parece que la accesibilidad de imagen en la web está en muy buena forma. Pero, tras un análisis más profundo, el panorama no pinta tan bien. Si estudiamos la longitud de las etiquetas `alt` presentes en el conjunto de datos, podemos ver que su longitud media es de seis caracteres. Esto nos conduce a una etiqueta `alt` vacía (representada como `alt=""`). Solamente un 39% de las imágenes usa un texto `alt` con más de seis caracteres. El valor medio de texto `alt` "real" es de 31 caracteres, de los cuales 25 realmente se corresponden con la descripción de la imagen.

## Vídeo

Aunque las imágenes dominan los medios multimedia de las páginas web, los vídeos están empezando a adquirir mayor relevancia como transmisores de contenido en la web. Según el <i lang="en">HTTP Archive</i>, vemos que el 4,06% de sitios para escritorio y el 2,99% de sitios para móvil tienen archivos de vídeo auto-hospedados (<i lang="en">self-hosting</i>). En otras palabras, archivos de vídeo que no están alojados en otro sitio web como Youtube o Facebook.

### Formatos de vídeo

El vídeo puede ser mostrado en muchos formatos y reproductores diferentes. Los formatos que dominan en móvil y escritorio son el `.ts` (segmentos de transmisión HLS) y el `.mp4` (el H264 MPEG):

{{ figure_markup(
  image="fig20_video_files_by_extension.png",
  caption="Recuento de archivos de vídeo por extensión.",
  description="Un gráfico de barras que muestra el uso de 'ts' es de 1.283.439 para escritorio (792.952 para móvil), de 'mp4' es de 729.757 para escritorio (662.015 para móvil), el de 'webm' es de 38.591 para escritorio (32.417 para móvil), el de 'mov' es de 22.194 para escritorio (14.986 para móvil), el de 'm4s' es de 17.338 para escritorio (16.046 para móvil), el de 'm4v' es de 7.466 para escritorio (6.169 para móvil).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=999894252&format=interactive"
  )
}}

Otros formatos vistos incluyen `webm`, `mov`, `m4s` y `m4v` (segmentos de transmisión MPEG-DASH). Queda claro que la mayoría de las transmisiones (<i lang="en">streamings</i>) en la web son HLS y que el formato por excelencia para vídeos estáticos es el `mp4`.

Bajo estas líneas puede verse el tamaño de vídeo medio para cada formato:

{{ figure_markup(
  image="fig21_median_vidoe_file_size_by_extension.png",
  caption="Tamaño medio de archivo por extensión de vídeo.",
  description="Un gráfico de barras mostrando que el tamaño medio de un archivo 'ts' es 335 KB para escritorio (156 KB para móvil), el de 'mp4' es de 175 KB para escritorio (128 KB para móvil), el de 'webm' es de 359 KB para escritorio (192 KB para móvil), el de 'mov' es de 128 KB para escritorio (96 KB para móvil), el de 'm4s' es de 324 KB para escritorio (246 KB para móvil), y el de 'm4v' es de 383 KB para escritorio (161 KB para móvil)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=821311770&format=interactive"
  )
}}

Los valores medios son menores en versión móvil, lo que puede significar simplemente que algunos sitios que tienen vídeos de gran tamaño en versión de escritorio no los muestran en la versión móvil, y que las transmisiones de vídeo ofrecen versiones menores de dichos vídeos para las pantallas más pequeñas.

### Tamaño de archivos de vídeo

Cuando se muestran vídeos en la web, la mayoría de ellos son reproducidos con el reproductor de vídeo de HTML5. El reproductor de vídeo de HTML es altamente personalizable para poder mostrar vídeos con fines muy diferentes. Por ejemplo, para reproducir un vídeo automáticamente, los parámetros `autoplay` y `muted` han de ser añadidos. El atributo `controls` permite al usuario iniciar/parar y moverse a través del vídeo. Si analizamos las etiquetas de vídeo en el <i lang="en">HTTP Archive</i>, podemos ver el uso de cada uno de estos atributos:

{{ figure_markup(
  image="fig22_html_video_tag_attributes_usage.png",
  caption="Uso de los atributos de la etiqueta HTML de vídeo.",
  description="Un gráfico de barras que muestra para escritorio: 'autoplay' en el 11.84%, 'buffered' en el 0%, 'controls' en el 12.05%, 'crossorigin' en el 0.45%, 'currenttime' en el 0.01%, 'disablepictureinpicture' en el 0.01%, 'disableremoteplayback' en el 0.01%, 'duration' en el 0.05%, 'height' en el 7.33%, 'intrinsicsize' en el 0%, 'loop' en el 14.57%, 'muted' en el 13.92%, 'playsinline' en el 6.49%, 'poster' en el 8.98%, 'preload' en el 11.62%, 'src' en el 3.67%, 'use-credentials' en el 0%, y 'width' en el 9%. Y para móvil: 'autoplay' en el 12.38%, 'buffered' en el 0%, 'controls' en el 13.88%, 'crossorigin' en el 0.16%, 'currenttime' en el 0.01%, disablepictureinpicture' en el 0.01%, 'disableremoteplayback' en el 0.02%, 'duration' en el 0.09%, 'height' en el 6.54%,  intrinsicsize' en el 0%, 'loop' en el 14.44%, 'muted' en el 13.55%, 'playsinline' en el 6.15%, 'poster' en el 9.29%, 'preload' en el 10.34%, 'src' en el 4.13%, 'use-credentials' en el 0%, y 'width' en el 9.03%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=593556050&format=interactive"
  )
}}

Los atributos más comunes son `autoplay`, `muted` y `loop`, seguidos por la etiqueta `preload` y por `width` y `height`. El uso del atributo `loop` es para vídeos de fondo y también para vídeos usados para reemplazar animaciones GIFs, así que no es sorprendente ver que se usa habitualmente en la página de inicio de los sitios web.

Aunque muchos de estos atributos tienen un uso muy parecido tanto en escritorio como en móvil, hay unos pocos que tienen diferencias significativas. Los dos atributos que mayor diferencia presentan entre móvil y escritorio son `width` y `height`, con un 4% menos de sitios que los usen en móvil. Curiosamente, hay un pequeño incremento del atributo `poster` (sitúa una imagen sobre la ventana de vídeo antes de la reproducción) en móvil.

Desde el punto de vista de la accesibilidad, la etiqueta `<track>` puede ser usada para añadir descripciones o subtítulos. Hay información en el <i lang="en">HTTP Archive</i> sobre con qué frecuencia se usa `<track>`, pero tras analizarlo, la mayoría de instancias del conjunto de datos estaban comentadas o apuntaban a una dirección que devolvía un error `404`. Parece ser que muchos sitios usan plantillas de JavaScript o HTML y no eliminan el registro, incluso cuando éste ya no se usa más.

### Reproductores de vídeo

Para una reproducción más avanzada (y para iniciar la transmisión de vídeo), el reproductor de vídeo nativo de HTML5 no servirá. Hay otras pocas librerías de vídeo populares que son usadas para reproducir vídeo:

{{ figure_markup(
  image="fig23_top_javascript_video_players.png",
  caption="Top de reproductores de vídeo de JavaScript.",
  description="Gráfico de barras mostrando que 'flowplayer' se usa en 3.365 sitios web para escritorio (3.400 para móvil), 'hls' en 52.375 sitios web para escritorio (40.925 para móvil), 'jwplayer' en 110.280 sitios web para escritorio (96.945 para móvil), 'shaka' en 325 sitios web para escritorio (275 para móvil) y 'vídeo' se usa en 377.990 sitios web para escritorio (391.330 para móvil)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=215677194&format=interactive"
  )
}}

El más popular (de lejos) es el vídeo.js, seguido por JWPLayer y HLS.js. Los autores advierten de que es posible que haya otros archivos con el nombre "vídeo.js" que puedan no ser la misma librería de reproducción de vídeo.

## Conclusiones
Casi todas las páginas web usan imágenes y vídeo en cierta medida para mejorar la experiencia de usuario y crear significado. Estos archivos multimedia utilizan una gran cantidad de recursos y son un gran porcentaje del tonelaje de las páginas web (¡y no se van a ir!) El uso de formatos alternativos, <i lang="en">lazy loading</i>, imágenes adaptables, y la optimización de imagen pueden ayudar mucho a minimizar el tamaño de los archivos multimedia en la web.
