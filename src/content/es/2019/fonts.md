---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Fuentes
description: Capítulo Fuentes del Almanaque Web de 2019 que cubre desde dónde se cargan las fuentes, formatos de fuente, rendimiento de carga de fuentes, fuentes variables y fuentes de color.
hero_alt: Hero image of Web Almanac chracters on an assembly line preparing various F letters in various styles and shapes.
authors: [zachleat]
reviewers: [logicalphase, AymenLoukil]
analysts: [tjmonsi, rviscomi]
editors: [tunetheweb]
translators: [c-torres]
discuss: 1761
results: https://docs.google.com/spreadsheets/d/108g6LXdC3YVsxmX1CCwrmpZ3-DmbB8G_wwgQHX5pn6Q/
zachleat_bio: <i lang="en">Zach es un Desarrollador Web en <a hreflang="en" href="https://www.filamentgroup.com/">Filament Group</a>. Actualmente está obsesionado con <a hreflang="en" href="https://www.zachleat.com/web/fonts/">las fuentes web</a> y <a hreflang="en" href="https://www.zachleat.com/web/introducing-eleventy/">generadores de sitios estáticos</a>. Su <a hreflang="en" href="https://www.zachleat.com/web/speaking/">currículum de expositor</a> incluye charlas en ocho países diferentes en eventos como JAMstack_conf, Beyond Tellerrand, Smashing Conference, CSSConf, y <a hreflang="en" href="https://www.zachleat.com/web/whitehouse/">La Casa Blanca</a>. Él también ayuda a organizar <a hreflang="en" href="http://nejsconf.com/">NEJS CONF</a> y las reuniones de <a hreflang="en" href="http://nebraskajs.com">NebraskaJS</a>.</i>
featured_quote: Las fuentes web permiten una tipografía hermosa y funcional en la web. El uso de fuentes web no solo fortalece el diseño, sino que democratiza un subconjunto del diseño, ya que permite un acceso más fácil a aquellos que quizás no tengan habilidades de diseño particularmente sólidas. Sin embargo, a pesar de todo lo bueno que pueden hacer, las fuentes web también pueden causar un gran daño al rendimiento de su sitio si no se cargan correctamente.
featured_stat_1: 74.9%
featured_stat_label_1: 3P Solicitudes de fuentes que utilizan Google Fonts
featured_stat_2: 29%
featured_stat_label_2: Porcentaje de páginas que incluyen un enlace de hoja de estilo de Google Fonts
featured_stat_3: 718
featured_stat_label_3: Mayor cantidad de solicitudes de fuentes por una sola página
---

## Introducción

Las fuentes web permiten una tipografía hermosa y funcional en la web. El uso de fuentes web no solo fortalece el diseño, sino que democratiza un subconjunto del diseño, ya que permite un acceso más fácil a aquellos que quizás no tengan habilidades de diseño particularmente sólidas. Sin embargo, a pesar de todo lo bueno que pueden hacer, las fuentes web también pueden causar un gran daño al rendimiento de su sitio si no se cargan correctamente.

¿Son positivas para la web? ¿Proporcionan más beneficios que daños? ¿Están los estándares web suficientemente pavimentados para fomentar las mejores prácticas de carga de fuentes web de forma predeterminada? Y si no es así, ¿qué necesita cambiar? Echemos un vistazo basado en datos para ver si podemos o no responder a esas preguntas inspeccionando cómo se utilizan las fuentes web en la web hoy en día.

## ¿De dónde sacaste esas fuentes web?

La primera y más destacada pregunta: rendimiento. Hay un capítulo completo dedicado al [rendimiento](./performance) pero aquí profundizaremos un poco en los problemas de rendimiento específicos de la fuente.

El uso de fuentes web alojadas facilita la implementación y el mantenimiento, pero el alojamiento propio ofrece el mejor rendimiento. Dado que las fuentes web de forma predeterminada hacen que el texto sea invisible mientras se carga la fuente web (también conocido como [Destello de Texto Invisible] (https://css-tricks.com/fout-foit-foft/), o FOIT por sus siglas en inglés), el rendimiento de las fuentes web puede ser más crítico que los activos que no bloquean, como las imágenes.

### ¿Las fuentes se alojan en el mismo dominio o en un dominio diferente?

Diferenciar el alojamiento propio del alojamiento de terceros es cada vez más relevante en un mundo [HTTP/2] (./ http2), donde la brecha de rendimiento entre una conexión del mismo dominio y de un dominio diferente puede ser más amplia. Las solicitudes del mismo dominio tienen el gran beneficio de un mejor potencial de priorización frente a otras solicitudes del mismo dominio en la cascada.

Las recomendaciones para mitigar los costos de rendimiento de cargar fuentes web desde otro dominio incluyen el uso de `preconnect`, `dns-prefetch` y `preload` [sugerencias de recursos] (./resource-hints), pero las fuentes web de alta prioridad deben ser solicitadas al alojamiento propio para minimizar el impacto en el rendimiento de las fuentes web. Esto es especialmente importante para las fuentes utilizadas por contenido visualmente prominente o cuerpo de texto que ocupan la mayor parte de una página.

{{ figure_markup(
  image="fig1.png",
  caption="Estrategias populares de alojamiento de fuentes web.",
  description="Gráfico de barras que muestra la popularidad de las estrategias de alojamiento propio y de terceros para fuentes web. El 75% de las páginas web móviles utilizan dominios de terceros y el 25% alojamiento propio. Los sitios web de escritorio tienen un uso similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1546332659&format=interactive"
  )
}}

El hecho de que tres cuartas partes estén alojadas tal vez no sea sorprendente dado el dominio de Google Fonts que discutiremos [más adelante](#¿cuáles-son-los-dominios-de-terceros-más-populares).<!-- markdownlint-disable-line MD051 -->

Google ofrece fuentes que utilizan archivos CSS de terceros alojados en `https://fonts.googleapis.com`. Los desarrolladores agregan solicitudes a estas hojas de estilo usando etiquetas`<link>` en su código. Si bien estas hojas de estilo bloquean el procesamiento, son muy pequeñas. Sin embargo, los archivos de fuentes se alojan en otro dominio, `https://fonts.gstatic.com`. El modelo de requerir dos peticiones separadas a dos dominios diferentes hace que `preconnect` sea una gran opción aquí para la segunda solicitud que no se descubrirá hasta que se descargue el CSS.

Tenga en cuenta que, si bien `preload` sería una buena adición para cargar los archivos de fuentes más arriba en la cascada de solicitudes (recuerde que `preconnect` configura la conexión, no solicita el contenido del archivo), `preload` aún no está disponible con Google Fonts. Google Fonts genera URLs únicas para sus archivos de fuentes <a hreflang="en" href="https://github.com/google/fonts/issues/1067">que están sujetos a cambios</a>.

### ¿Cuáles son los dominios de terceros más populares?

<figure>
  <table>
    <thead>
      <tr>
        <th>Dominio</th>
        <th>Escritorio</th>
        <th>Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>fonts.gstatic.com</td>
        <td class="numeric">75.4%</td>
        <td class="numeric">74.9%</td>
      </tr>
      <tr>
        <td>use.typekit.net</td>
        <td class="numeric">7.2%</td>
        <td class="numeric">6.6%</td>
      </tr>
      <tr>
        <td>maxcdn.bootstrapcdn.com</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>use.fontawesome.com</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>static.parastorage.com</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>fonts.shopifycdn.com</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>cdn.shopify.com</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>cdnjs.cloudflare.com</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>use.typekit.com</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>netdna.bootstrapcdn.com</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>fast.fonts.net</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>static.dealer.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>themes.googleusercontent.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>static-v.tawk.to</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>stc.utdstc.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>cdn.jsdelivr.net</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>kit-free.fontawesome.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>open.scdn.co</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>assets.squarespace.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>fonts.jimstatic.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Los 20 dominios principales de fuentes por porcentaje de solicitudes.") }}</figcaption>
</figure>

El dominio de Google Fonts aquí fue simultáneamente sorprendente y no sorprendente. No fue sorprendente porque esperaba que el servicio fuera el más popular y sorprendente por el dominio absoluto de su popularidad. El 75% de las solicitudes de fuentes es asombroso. TypeKit fue un distante segundo lugar de un solo dígito, con la biblioteca Bootstrap representando un tercer lugar aún más distante.

{{ figure_markup(
  caption="Porcentaje de páginas que incluyen un vínculo de hoja de estilo de Google Fonts en el documento <code><head></code>.",
  content="29%",
  classes="big-number"
)
}}

Si bien el alto uso de Google Fonts aquí es muy impresionante, también es digno de mención que solo el 29% de las páginas incluían un elemento `<link>` de Google Fonts. Esto podría significar algunas cosas:

- Cuando las páginas usan fuentes de Google, usan _muchas_ fuentes de Google. Se proporcionan sin costo monetario, después de todo. ¿Quizás están siendo utilizados en un editor WYSIWYG popular? Esta parece una explicación muy probable.
- O una historia más improbable es que podría significar que mucha gente está usando Google Fonts con `@import` en lugar de `<link>`.
- O si queremos irnos al extremo profundo hacia escenarios súper improbables, podría significar que muchas personas están usando Google Fonts con un [HTTP `Link:` header](https://developer.mozilla.org/docs/Web/HTTP/Headers/Link) en su lugar.

{{ figure_markup(
  caption="Porcentaje de páginas que incluyen un vínculo de hoja de estilo de Google Fonts como primer elemento secundario del documento <code><head></code>.",
  content="0.4%",
  classes="big-number"
)
}}

La documentación de Google Fonts recomienda que el `<link>` del CSS de Google Fonts se coloque como el primer hijo en el `<head>` de una página. ¡Esta es una gran pregunta! En la práctica, esto no es común, ya que solo cerca del medio porciento de todas las páginas (unas 20.000 páginas) siguió este consejo.

Más aún, si una página usa `preconnect` o `dns-prefetch` como elementos `<link>`, estos vendrían antes del CSS de Google Fonts de todos modos. Siga leyendo para obtener más información sobre estas sugerencias de recursos.

### Acelerando el alojamiento de terceros

Como se mencionó anteriormente, una manera súper fácil de acelerar las solicitudes de fuentes web a un dominio de terceros es usar la [sugerencia de recursos](./resource-hints) `preconnect`.

{{ figure_markup(
  caption="Porcentaje de páginas móviles que se pre-conectan previamente a un dominio de fuentes web.",
  content="1.7%",
  classes="big-number"
)
}}

¡Guauu! ¡Menos del 2% de las páginas están usando <a hreflang="es" href="https://web.dev/i18n/es/uses-rel-preconnect">`preconnect`</a>! Dado que Google Fonts está al 75%, ¡debería ser más alto! Desarrolladores: si usa Google Fonts, use `preconnect`! Google Fonts: ¡proselitice más `preconnect`!

De hecho, si está usando Google Fonts, continúe y agregue esto a su `<head>` si aún no está allí:

```html
<link rel="preconnect" href="https://fonts.gstatic.com/">
```

### Tipos de letra más populares

<figure>
  <table>
      <thead>
        <tr>
          <th>Rango</th>
          <th>Familia tipográfica</th>
          <th>Escritorio</th>
          <th>Móvil</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="numeric">1</td>
          <td>Open Sans</td>
          <td class="numeric">24%</td>
          <td class="numeric">22%</td>
        </tr>
        <tr>
          <td class="numeric">2</td>
          <td>Roboto</td>
          <td class="numeric">15%</td>
          <td class="numeric">19%</td>
        </tr>
        <tr>
          <td class="numeric">3</td>
          <td>Montserrat</td>
          <td class="numeric">5%</td>
          <td class="numeric">4%</td>
        </tr>
        <tr>
          <td class="numeric">4</td>
          <td>Source Sans Pro</td>
          <td class="numeric">4%</td>
          <td class="numeric">3%</td>
        </tr>
        <tr>
          <td class="numeric">5</td>
          <td>Noto Sans JP</td>
          <td class="numeric">3%</td>
          <td class="numeric">3%</td>
        </tr>
        <tr>
          <td class="numeric">6</td>
          <td>Lato</td>
          <td class="numeric">3%</td>
          <td class="numeric">3%</td>
        </tr>
        <tr>
          <td class="numeric">7</td>
          <td>Nanum Gothic</td>
          <td class="numeric">4%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">8</td>
          <td>Noto Sans KR</td>
          <td class="numeric">3%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">9</td>
          <td>Roboto Condensed</td>
          <td class="numeric">2%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">10</td>
          <td>Raleway</td>
          <td class="numeric">2%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">11</td>
          <td>FontAwesome</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">12</td>
          <td>Roboto Slab</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">13</td>
          <td>Noto Sans TC</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">14</td>
          <td>Poppins</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">15</td>
          <td>Ubuntu</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">16</td>
          <td>Oswald</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">17</td>
          <td>Merriweather</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">18</td>
          <td>PT Sans</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">19</td>
          <td>Playfair Display</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">20</td>
          <td>Noto Sans</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
      </tbody>
    </table>
  <figcaption>{{ figure_link(caption="Las 20 familias de fuentes principales como porcentaje de todas las declaraciones de fuentes.") }}</figcaption>
</figure>

No es sorprendente que las entradas principales aquí parezcan coincidir de manera muy similar a la <a hreflang="en" href="https://fonts.google.com/?sort=popularity">lista de fuentes de Google Fonts ordenadas por popularidad</a>.

## ¿Qué formatos de fuente se están utilizando?

<a hreflang="en" href="https://caniuse.com/#feat=woff2">WOFF2 está bastante bien soportado</a> en los navegadores web hoy. Google Fonts sirve WOFF2, un formato que ofrece una compresión mejorada con respecto a su predecesor WOFF, que en sí mismo ya era una mejora con respecto a otros formatos de fuente existentes.

{{ figure_markup(
  image="fig7.png",
  caption="Popularidad de los tipos MIME de fuentes web.",
  description="Gráfico de barras que muestra la popularidad de los tipos MIME de fuentes web. WOFF2 se utiliza en el 74% de las fuentes, seguido del 13% WOFF, el 6% de octet-stream, el 3% TTF, el 2% plano, el 1% HTML, el 1% SFNT y menos del 1% para todos los demás tipos. Las computadoras de escritorio y los dispositivos móviles tienen distribuciones similares.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=998584594&format=interactive"
  )
}}

Desde mi perspectiva, se podría argumentar que solo se opte por WOFF2 para fuentes web después de ver los resultados aquí. Me pregunto de dónde viene el doble dígito en uso de WOFF. ¿Quizás los desarrolladores todavía ofrecen fuentes web en Internet Explorer?

Tercer lugar `octet-stream` (y `plano` un poco mas abajo) parecería sugerir que muchos servidores web están configurados incorrectamente, enviando un tipo MIME incorrecto con solicitudes de archivos de fuentes web.

Profundicemos un poco más y veamos los valores `format()` usados en la propiedad `src:` de las declaraciones `@font-face`:

{{ figure_markup(
  image="fig8.png",
  caption="Popularidad de los formatos de fuente en las declaraciones <code>@font-face</code>.",
  description="Gráfico de barras que muestra la popularidad de los formatos utilizados en las declaraciones de fuentes. El 69% de las declaraciones @font-face de las páginas de escritorio especifican el formato WOFF2, 11% WOFF, 10% TrueType, 8% SVG, 2% EOT y menos del 1% OpenType, TTF y OTF. La distribución de las páginas móviles es similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=700778025&format=interactive"
  )
}}

Estaba esperando ver <a hreflang="en" href="https://caniuse.com/#feat=svg-fonts">fuentes SVG</a> en declive. Tienen errores y las implementaciones se han eliminado de todos los navegadores excepto Safari. Es hora de dejarlas a todas.

El punto de datos SVG aquí también me hace preguntarme con qué tipo de MIME están sirviendo estas fuentes SVG. No veo `image/svg+xml` en ninguna parte de la Figura 6.7. De todos modos, no se preocupe por arreglar eso, ¡simplemente deshágase de ellas!

### Solo WOFF2

<figure>
  <table>
    <thead>
      <tr>
        <th>Rango</th>
        <th>Combinaciones de formato</th>
        <th>Escritorio</th>
        <th>Móvil</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>woff2</td>
        <td class="numeric">84.0%</td>
        <td class="numeric">81.9%</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>svg, truetype, woff</td>
        <td class="numeric">4.3%</td>
        <td class="numeric">4.0%</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>svg, truetype, woff, woff2</td>
        <td class="numeric">3.5%</td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td>eot, svg, truetype, woff</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">2.9%</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td>woff, woff2</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td class="numeric">6</td>
        <td>eot, svg, truetype, woff, woff2</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td class="numeric">7</td>
        <td>truetype, woff</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td class="numeric">8</td>
        <td>woff</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td class="numeric">9</td>
        <td>truetype</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td class="numeric">10</td>
        <td>truetype, woff, woff2</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td class="numeric">11</td>
        <td>opentype, woff, woff2</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">12</td>
        <td>svg</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">13</td>
        <td>eot, truetype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">14</td>
        <td>opentype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">15</td>
        <td>opentype</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">16</td>
        <td>eot</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">17</td>
        <td>opentype, svg, truetype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">18</td>
        <td>opentype, truetype, woff, woff2</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">19</td>
        <td>eot, truetype, woff, woff2</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">20</td>
        <td>svg, woff</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Las 20 principales combinaciones de formatos de fuente.") }}</figcaption>
</figure>

Este conjunto de datos parece sugerir que la mayoría de las personas ya están usando WOFF2-only en sus bloques `@font-face`. Pero esto es engañoso, por supuesto, según nuestra discusión anterior sobre el dominio de Google Fonts en el conjunto de datos. Google Fonts utiliza algunos métodos de rastreo para ofrecer un archivo CSS simplificado y solo incluye el `format()` más moderno. Como era de esperar, WOFF2 domina los resultados aquí por esa razón, ya que el soporte del navegador para WOFF2 ha sido bastante amplio desde hace algún tiempo.

Es importante destacar que estos datos en particular no respaldan ni restan mérito al caso de pasar solo a WOFF2 todavía, pero sigue siendo una idea tentadora.

## Luchando contra el texto invisible

La herramienta número uno que tenemos para combatir el comportamiento de carga de fuentes web predeterminado de "invisible durante la carga" (también conocido como FOIT por sus siglas en inglés), es `font-display`. Agregar `font-display: swap` a su bloque `@font-face` es una manera fácil de decirle al navegador que muestre el texto de respaldo mientras se carga la fuente web.

<a hreflang="en" href="https://caniuse.com/#feat=mdn-css_at-rules_font-face_font-display">Soporte de navegador</a> es genial tambien. Internet Explorer y la versión anterior a Chromium Edge no son compatibles, pero también representan el texto de respaldo de forma predeterminada cuando se carga una fuente web (aquí no se permiten FOIT). Para nuestras pruebas de Chrome, ¿con qué frecuencia se usa `font-display`?

{{ figure_markup(
  caption="Porcentaje de páginas móviles que utilizan el estilo <code>font-display</code>.",
  content="26%",
  classes="big-number"
)
}}

Supongo que esto aumentará con el tiempo, especialmente ahora que <a hreflang="en" href="https://www.zachleat.com/web/google-fonts-display/">Google Fonts está agregando `font-display` a todos los nuevos fragmentos de código</a> copiado desde su sitio.

Si está utilizando Google Fonts, actualice sus fragmentos. Si no está utilizando Google Fonts, use `font-display`. Lea más sobre `font-display` en [MDN](https://developer.mozilla.org/docs/Web/CSS/@font-face/font-display).

Echemos un vistazo a los valores de `font-display` que son populares:

{{ figure_markup(
  image="fig11.png",
  caption="Uso de valores <code>font-display</code>.",
  description="Gráfico de barras que muestra el uso del estilo font-display. El 2,6% de las páginas móviles configuran este estilo en `swap`, 1,5% en `auto`, 0,7% en `block`, 0,4% en `fallback`, 0,2% en `optional` y 0,1% en `swap` entre comillas. que no es válido. La distribución de escritorio es similar, excepto que el uso de `swap` es menor en 0.4 puntos porcentuales y el uso `auto` es mayor en 0.1 puntos porcentuales.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1988783738&format=interactive"
  )
}}

Como una manera fácil de mostrar texto de respaldo mientras se carga una fuente web, `font-display: swap` reina suprema y es el valor más común. `swap` también es el valor predeterminado utilizado por los nuevos fragmentos de código de Google Fonts. Hubiera esperado que `optional` (solo renderizado si se almacena en caché) tuviera un poco más de uso aquí, ya que algunos promotores prominentes de los desarrolladores presionaron un poco por ello, pero sin lugar.

## ¿Cuántas fuentes web son demasiadas?

Ésta es una pregunta que requiere cierto matiz. ¿Cómo se utilizan las fuentes? ¿Por cuánto contenido hay en la página? ¿Dónde vive este contenido en el diseño? ¿Cómo se renderizan las fuentes? Sin embargo, en lugar de matices, profundicemos en un análisis amplio y de mano dura centrado específicamente en el recuento de solicitudes.

{{ figure_markup(
  image="fig12.png",
  caption="Distribución de solicitudes de fuentes por página.",
  description="Gráfico de barras que muestra la distribución de solicitudes de fuentes por página. Los percentiles 10, 25, 50, 75 y 90 para escritorio son: 0, 1, 3, 6 y 9 solicitudes de fuentes. La distribución para móviles es idéntica hasta los percentiles 75 y 90, donde las páginas móviles solicitan 1 fuente menos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=451821825&format=interactive"
  )
}}

La página web mediana realiza tres solicitudes de fuentes web. En el percentil 90, solicitó seis y nueve fuentes web en dispositivos móviles y computadoras de escritorio, respectivamente.

{{ figure_markup(
  image="fig13.png",
  caption="Histograma de fuentes web solicitadas por página.",
  description="Histograma que muestra la distribución del número de solicitudes de fuentes por página. El número más popular de solicitudes de fuentes es 0 en el 22% de las páginas de escritorio. La distribución cae al 9% de las páginas que tienen 1 fuente, luego alcanza el 10% para 2-4 fuentes antes de caer a medida que aumenta el número de fuentes. Las distribuciones de escritorio y móvil son similares, aunque la distribución móvil se inclina ligeramente hacia tener menos fuentes por página.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1755200484&format=interactive"
  )
}}

Parece bastante interesante que las solicitudes de fuentes web parezcan ser bastante estables en computadoras de escritorio y dispositivos móviles. Me alegro de ver que la<a hreflang="en" href="https://css-tricks.com/snippets/css/using-font-face/#article-header-id-6">recomendación de esconder bloques `@font-face` dentro de consultas `@media`</a> no fue acogida (ni lo pienses).

Dicho esto, hay un poco más de solicitudes de fuentes realizadas en dispositivos móviles. Mi corazonada aquí es que hay menos tipos de letra disponibles en dispositivos móviles, lo que a su vez significa menos accesos `local()` en Google Fonts CSS, recurriendo a las solicitudes de red para estos.

### No quieres ganar este premio

{{ figure_markup(
  caption="La mayor cantidad de solicitudes de fuentes web en una sola página.",
  content="718",
  classes="big-number"
)
}}

El premio a la página que solicita más fuentes web es para un sitio que hizo **718** solicitudes de fuentes web!

Después de sumergirse en el código, ¡todas esas 718 solicitudes van a Google Fonts! Parece que un plugin de optimización del contenido "de la parte superior de la página" para WordPress que funciona mal se ha vuelto loco en este sitio y está solicitando (¿Ataque DDoS?) todas las fuentes de Google.

Es irónico que un complemento de optimización del rendimiento pueda empeorar su rendimiento.

## Coincidencia más precisa con `unicode-range`

{{ figure_markup(
  caption="Porcentaje de páginas móviles que declaran una fuente web con la propiedad <code>unicode-range</code>.",
  content="56%",
  classes="big-number"
)
}}

[`unicode-range`](https://developer.mozilla.org/docs/Web/CSS/@font-face/unicode-range) es una excelente propiedad de CSS para que el navegador sepa específicamente qué puntos de código le gustaría usar la página en el archivo de fuente. Si la declaración `@font-face` tiene un `unicode-range`, el contenido de la página debe coincidir con uno de los puntos de código en el rango antes de que se solicite la fuente. Es algo muy bueno.

Esta es otra métrica que espero que esté sesgada por el uso de Google Fonts, ya que Google Fonts usa `unicode-range` en la mayoría (si no en todos) de su CSS. Espero que esto sea menos común en la tierra de los usuarios, pero tal vez sea posible filtrar las solicitudes de Google Fonts en la próxima edición del Almanaque.

## No solicite fuentes web si existe una fuente del sistema

{{ figure_markup(
  caption="Porcentaje de páginas móviles que declaran una fuente web con la propiedad <code>local ()</code>.",
  content="59%",
  classes="big-number"
)
}}

`local()` es una buena forma de hacer referencia a una fuente del sistema en su `@font-face` `src`. Si la fuente `local()` existe, no necesita solicitar una fuente web en absoluto. Google Fonts usa esto de manera extensa y controvertida, por lo que es probable que sea otro ejemplo de datos sesgados si estamos tratando de obtener patrones de la tierra del usuario.

También debe tenerse en cuenta aquí que personas más inteligentes que yo (Bram Stein de TypeKit) han dicho que <a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html">usar `local()` puede ser impredecible ya que las versiones instaladas de las fuentes pueden estar desactualizadas y no ser confiables</a>.

## Fuentes condensadas y `font-stretch`

{{ figure_markup(
  caption="Porcentaje de páginas de escritorio y móviles que incluyen un estilo con la propiedad <code>font-stretch</code>.",
  content="7%",
  classes="big-number"
)
}}

Históricamente, `font-stretch` ha sufrido de un soporte deficiente del navegador y no era una prpopiedad `@font-face` conocida. Lee mas sobre [`font-stretch` en MDN](https://developer.mozilla.org/docs/Web/CSS/font-stretch). Pero el <a hreflang="en" href="https://caniuse.com/#feat=css-font-stretch">soporte de los navegadores</a> se ha ampliado.

Se ha sugerido que el uso de fuentes condensadas en ventanas gráficas más pequeñas permite ver más texto, pero este enfoque no se usa comúnmente. Dicho esto, que esta propiedad se use medio punto porcentual más en computadoras de escritorio que en dispositivos móviles es inesperado, y el 7% parece mucho más alto de lo que hubiera predicho.

## Las fuentes variables son el futuro

[Las fuentes variables](https://developer.mozilla.org/docs/Web/CSS/CSS_Fonts/Variable_Fonts_Guide) permite incluir varios tamaños y estilos de fuente en un archivo de fuente.

{{ figure_markup(
  caption="Porcentaje de páginas que incluyen una fuente variable.",
  content="1.8%",
  classes="big-number"
)
}}

Incluso con un 1.8%, esto fue más alto de lo esperado, aunque estoy emocionado de ver esto despegar. <a hreflang="en" href="https://developers.google.com/fonts/docs/css2">Google Fonts v2</a> incluye cierto soporte para fuentes variables.

{{ figure_markup(
  image="fig19.png",
  caption="Uso de los ejes <code>font-variation-settings</code>.",
  description="Gráfico de barras que muestra el uso de la propiedad font-variation-settings. El 42% de las propiedades en las páginas de escritorio se establecen en el valor `opsz`, el 32% en `wght`, el 16% en `wdth`, el 2% o menos en `roun`, `crsb`, `slnt`, `inln` , y más. Las diferencias más notables entre las páginas de escritorio y móviles son el 26% de uso de `opsz`, el 38% de `wght` y el 23% de `wdth`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=699343351&format=interactive"
  )
}}

A través del lente de este gran conjunto de datos, estos son tamaños de muestra muy bajos; tome estos resultados con un grano de sal. Sin embargo, `opsz` como el eje más común en las páginas de escritorio es notable, con `wght` y `wdth` al final. En mi experiencia, las demostraciones introductorias de fuentes variables suelen estar basadas en el peso.

## ¿Las fuentes de color también podrían ser el futuro?

{{ figure_markup(
  caption="El número de páginas web de escritorio que incluyen una fuente de color.",
  content="117",
  classes="big-number"
)
}}

El uso aquí de estas es básicamente inexistente, pero puede consultar el excelente recurso <a hreflang="en" href="https://www.colorfonts.wtf/">Color Fonts! WTF?</a> para obtener más información. Similar (pero no en absoluto) al formato SVG para fuentes (que es malo y va a desaparecer), esta le permite incrustar SVG dentro de archivos OpenType, lo cual es increíble y genial.

## Conclusión

Lo más importante aquí es que Google Fonts domina la discusión de fuentes web. Los enfoques que han adoptado pesan mucho sobre los datos que hemos registrado aquí. Los aspectos positivos aquí son el fácil acceso a fuentes web, buenos formatos de fuente (WOFF2) y configuraciones gratuitas de `unicode-range`. Las desventajas aquí son los inconvenientes de rendimiento asociados con el alojamiento de terceros, las solicitudes de dominios diferentes y la falta de acceso al `preload`.

Espero que en el futuro veamos el "Aumento de la fuente variable". Esto _debe_ combinarse con una disminución en las solicitudes de fuentes web, ya que las fuentes variables combinan varios archivos de fuentes individuales en un solo archivo de fuentes compuestas. Pero la historia nos ha demostrado que lo que suele pasar aquí es que optimizamos una cosa y luego añadimos más cosas para cubrir la vacante.

Será muy interesante ver si las fuentes de color aumentan en popularidad. Espero que estos sean mucho más especializados que las fuentes variables, pero es posible que vean una línea de vida en el espacio de fuente del icono.

Mantengan esas fuentes heladas.
