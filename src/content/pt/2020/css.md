---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: Capítulo sobre CSS do Web Almanac de 2020 que cobre cores, unidades, seletores, layout, animações, media queries e o uso de Sass.
hero_alt: Hero image of almanac chracters measuring and painting a web page.
authors: [LeaVerou, svgeesus, rachelandrew]
reviewers: [estelle, fantasai, j9t, mirisuzanne, catalinred, hankchizljaw]
analysts: [rviscomi, LeaVerou, dooman87]
editors: [tunetheweb]
translators: [emanuelgsouza]
LeaVerou_bio: Lea <a hreflang="en" href="https://designftw.mit.edu">ensina HCI & programação</a> e <a hreflang="en" href="https://mavo.io">pesquisa sobre como tornar a web mais fácil</a> no <a hreflang="en" href="https://mit.edu">MIT</a>. Ela é uma <a hreflang="en" href="https://www.amazon.com/CSS-Secrets-Lea-Verou/dp/1449372635?tag=leaverou-20">autora</a> bestselling técnica e experiente <a hreflang="en" href="https://lea.verou.me/speaking">palestrante</a>. Ela é apaixonada por padrões abertos da web e é membro do <a hreflang="en" href="https://www.w3.org/Style/CSS/members.en.php3">CSS Working Group</a> de longa data. Lea começou <a hreflang="en" href="https://github.com/leaverou">inúmeros projetos open source populares e aplicações web</a>, tais como <a hreflang="en" href="https://prismjs.com">Prism</a>, e <a hreflang="en" href="https://github.com/leaverou/awesomplete">Awesomplete</a>. Seu Twitter é <a href="https://x.com/leaverou">@leaverou</a> e blog <a hreflang="en" href="https://lea.verou.me">lea.verou.me</a>.
svgeesus_bio: Chris Lilley é Diretor Técnico do World Wide Web Consortium (W3C). Considerado "o pai do SVG", ele também foi coautor do PNG, foi co-editor do CSS2, presidiu o grupo que desenvolveu o <code>@font-face</code> e co-desenvolveu o WOFF. Ex Technical Architecture Group. Chris ainda está tentando obter o Gerenciamento de Cores na web, suspiro. Atualmente trabalhando no níveis CSS 3/4/5 (não, realmente), Web Audio e WOFF2.
rachelandrew_bio: Sou uma desenvolvedora web, escritora e palestrante pública. Cofundadora do <a hreflang="en" href="https://grabaperch.com">Perch CMS</a> e <a hreflang="en" href="https://noti.st">Notist</a>. Membra do <a hreflang="en" href="https://www.w3.org/wiki/CSSWG">CSS Working Group</a>. Editora-chefe do <a hreflang="en" href="https://www.smashingmagazine.com/">Smashing Magazine</a>.
discuss: 2037
results: https://docs.google.com/spreadsheets/d/1sMWXWjMujqfAREYxNbG_t1fOJKYCA6ASLwtz4pBQVTw/
featured_quote: A web não é mais uma adolescente - agora tem 30 anos e age como tal. Ela tende a favorecer a estabilidade em vez de um novo brilho e a legibilidade em vez da complexidade, deixando de lado os prazeres ocasionais.
featured_stat_1: 72.58%
featured_stat_label_1: Porcentagem do `<length>` dos valores que usam a unidade `px`
featured_stat_2: 91.05%
featured_stat_label_2: Porcentagem de páginas em dispositivos móveis usando qualquer funcionalidade com vendor prefix
featured_stat_3: `darken()`
featured_stat_label_3: A função SCSS mais popular
---

## Introdução

Cascading Stylesheets (CSS) é uma linguagem usada para fazer o layout, formatar e desenhar páginas da web e outras mídias. É uma das três linguagens principais para a construção de sites - sendo as outras duas, HTML, usado para estrutura, e JavaScript, usado para especificar o comportamento.

No [Web Almanac inaugural do ano passado](../2019), observamos [uma variedade de métricas CSS](../2019/css) medidas por meio de 41 consultas SQL no corpus do HTTP Archive, para avaliar o estado desta tecnologia em 2019. Este ano, nós nos aprofundamos, medindo não apenas quantas páginas usam uma determinada funcionalidade do CSS, mas também *como* elas usam.

No geral, o que observamos foi uma web em duas engrenagens diferentes quando se trata de adoção de features no CSS. Em nossas postagens de blog e bolhas no Twitter, tendemos a discutir principalmente o mais recente e o mais brilhante, no entanto, ainda existem milhões de sites usando código muito antigo. Coisas como [vendor prefixes de uma era passada](#vendor-prefixes), [filtros IE proprietários](#filtros), [floats para layout](#layout) e o [clearfix](#nomes-de-classes) em toda a sua glória. Mas também observamos a adoção impressionante de muitos novos recursos - até mesmo recursos que só tiveram suporte geral neste mesmo ano, como [`min()` e `max()`](#feature-queries). Contudo, há uma correlação inversa entre quanto algo é visto como interessante e o quanto ele realmente é usado; por exemplo, recursos de ponta do [CSS Houdini](#houdini) foram praticamente inexistentes.

Da mesma forma, em nossas palestras em conferências, geralmente tendemos a nos concentrar em casos de uso complicados e elaborados que fazem cabeças explodirem e os feeds do Twitter serem preenchidos com "CSS pode fazer *isso*?". No entanto, acontece que a maioria do uso de CSS em estado selvagem é bastante simples. [Variáveis ​​CSS são principalmente usadas como constantes](#complexidade) e raramente referenciam outras variáveis, `calc()` é [usado principalmente com dois termos](#cálculos), gradientes [geralmente têm duas paradas](#gradientes) e assim por diante.

A web não é mais uma adolescente - agora tem 30 anos e age como tal. Ela tende a favorecer a estabilidade em vez de um novo brilho e a legibilidade em vez da complexidade, deixando de lado os prazeres ocasionais.

## Metodologia

O <a hreflang="en" href="https://httparchive.org/">HTTP Archive</a> rastreia <a hreflang="en" href="https://httparchive.org/reports/state-of-the-web#numUrls">milhões de páginas</a> todos os meses e as executa por meio de uma instância privada de <a hreflang="en" href="https://webpagetest.org/">WebPageTest</a> para armazenar informações importantes de cada página. (Você pode aprender mais sobre isso em nossa [Metodologia](./methodology)).

Para este ano, decidimos envolver a comunidade em quais métricas estudar. Começamos com um <a hreflang="en" href="https://projects.verou.me/mavoice/?repo=leaverou/css-almanac&labels=proposed%20stat">aplicativo para propor métricas e votar nelas</a>. No final, havia tantas métricas interessantes que acabamos incluindo quase todas! Excluímos apenas as métricas relacionadas às fontes, uma vez que há um [capítulo inteiro de fontes](./fonts) separado e houve sobreposição significativa.

Os dados neste capítulo levaram 121 consultas SQL para serem produzidos, totalizando mais de 10K linhas de SQL, incluindo 3K linhas de funções JavaScript no SQL. Isso o torna o maior capítulo da história do Web Almanac.

Muito trabalho de engenharia foi feito para tornar esta escala de análise viável. Como no ano passado, colocamos todo o código CSS por meio de um <a hreflang="en" href="https://github.com/reworkcss/css">CSS parser</a> e armazenamos as [Abstract Syntax Trees](https://pt.wikipedia.org/wiki/%C3%81rvore_sint%C3%A1tica_abstrata) (AST) para todas as folhas de estilo no corpus, resultando em incríveis 10 TB de dados. Este ano, também desenvolvemos uma <a hreflang="en" href="https://github.com/leaverou/rework-utils">biblioteca de *helpers*</a> que operam neste AST e um <a hreflang="en" href="https://projects.verou.me/parsel">selector parser</a> - ambos lançados como projetos de código aberto separados. A maioria das métricas envolveu <a hreflang="en" href="https://github.com/LeaVerou/css-almanac/tree/master/js">JavaScript</a> para coletar dados de um único AST e <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/sql/2020/css">SQL</a> para agregar esses dados em todo o corpus. Curioso para saber como seu próprio CSS se sai em relação às nossas métricas? Fizemos um <a hreflang="en" href="https://projects.verou.me/css-almanac/playground">playground online</a> onde você pode experimentar com os seus próprios sites.

Para algumas métricas, olhar para o AST CSS não foi suficiente. Queríamos olhar para o <a hreflang="en" href="https://sass-lang.com/">SCSS</a> onde quer que fosse fornecido por meio de *sourcemaps*, pois mostra o que os desenvolvedores precisam do CSS que ainda não é possível, ao passo que estudar o CSS nos mostra o que os desenvolvedores usam atualmente. Para isso, nós tivemos que usar uma *custom metric* - um código JavaScript que roda no *crawler* quando ele visita uma determinada página. Não podíamos usar um *parser* SCSS adequado, pois isso poderia diminuir muito a velocidade do rastreamento, então tivemos que recorrer a <a hreflang="en" href="https://github.com/LeaVerou/css-almanac/blob/master/runtime/sass.js">expressões regulares</a> (*oh, que horror!*). Apesar da abordagem rude, obtivemos uma [infinidade de insights](#sass)!

Custom metrics também foram usadas para parte da análise de <a href="#propriedades-customizadas">propriedades customizadas</a>. Embora possamos obter muitas informações sobre o uso de propriedades customizadas apenas com as folhas de estilo, não podemos construir um gráfico de dependência sem ser capaz de olhar para o contexto da árvore DOM, pois as propriedades customizadas são herdadas. Observar o estilo computado dos nós da DOM também nos dá informações de quais tipos de elementos cada propriedade é aplicada e quais deles estão [registrados](https://developer.mozilla.org/docs/Web/API/CSS/RegisterProperty) - informações que também não podemos obter nas folhas de estilo.

<p class="note">Rastreamos nossas páginas tanto no modo desktop quanto no modo celular, mas para a maioria dos dados eles fornecem resultados semelhantes, portanto, a menos que seja indicado de outra forma, as estatísticas apresentadas neste capítulo referem-se ao conjunto de páginas no celular.</p>

## Uso

Enquanto o JavaScript ultrapassa de longe o CSS em sua participação no peso da página, o CSS certamente cresceu em tamanho ao longo dos anos, com a média de carregamento de página no desktop com 62 KB de código CSS, e uma em cada dez páginas carregando mais de 240 KB de código CSS. Páginas no celular usam um pouco menos de código CSS em todos os percentis, mas apenas de 4 a 7 KB. Embora isto seja definitivamente maior do que nos anos anteriores, não se aproxima da [gritante média de 444 KB de JavaScript tendo um topo de 10% de 1.2 MB](./javascript#how-much-javascript-do-we-we-use).

{{ figure_markup(
  image="stylesheet-size.png",
  caption="Distribuição do tamanho de transferência de folhas de estilo por página.",
  description="Gráfico de barras mostrando a distribuição do tamanho de transferência de folhas de estilo, que inclui a compressão quando habilitada. Para desktop, tende a ter um pouco mais de bytes por página cerca de 10 KB. Os 10, 25, 50, 75, e 90 percentis para celular são: 5, 22, 56, 122, e 234 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=762340058&format=interactive",
  sheets_gid="314594173",
  sql_file="stylesheet_kbytes.sql"
) }}

Seria razoável supor que muito deste CSS é gerado através de pré-processadores ou outras ferramentas de build, no entanto, apenas cerca de 15% incluíam sourcemaps. Não está claro se isto diz mais sobre a adoção de sourcemaps ou o uso de ferramentas de build. Destes, a esmagadora maioria (45%) veio de outros arquivos CSS, indicando o uso de processos de build que operam em arquivos CSS, tais como minificação, <a hreflang="en" href="https://autoprefixer.github.io/">autoprefixação</a>, e/ou <a hreflang="en" href="https://postcss.org/">PostCSS</a>. <a hreflang="en" href="https://sass-lang.com/">Sass</a> foi muito mais popular que <a hreflang="en" href="https://lesscss.org/">Less</a> (34% das folhas de estilo com sourcemaps vs 21%), sendo SCSS o dialeto mais popular (33% para .scss vs 1% para .sass).

Todos esses quilobytes de código estão tipicamente distribuídos em múltiplos arquivos e elementos `<style>`; apenas cerca de 7% das páginas concentram todo o código CSS em uma folha de estilo remota, como muitas vezes somos ensinados a fazer. Na verdade, a página mediana contém 3 elementos `<style>` e 6 folhas de estilo remotas, sendo que 10% delas contêm mais de 14 elementos `<style>` e mais de 20 arquivos CSS remotos! Embora isto não seja otimizado no desktop, realmente acaba com a [performance](./performance) no celular, onde a latência de ida e volta é mais importante do que apenas a velocidade de download.

{{ figure_markup(
  caption="O maior número de folhas de estilo carregados por uma página.",
  content="1,379",
  classes="big-number",
  sheets_gid="1111507751",
  sql_file="stylesheet_count.sql"
)
}}

Surpreendentemente, o número máximo de folhas de estilo por página são incríveis 26.777 elementos `<style>` e 1.379 remotos! Eu definitivamente gostaria de evitar carregar essa página!

{{ figure_markup(
  image="stylesheet-count.png",
  caption="Distribuição do número de folhas de estilo por página.",
  description="Gráfico de barras mostrando a distribuição das folhas de estilo por página. Desktop e celular são quase iguais em toda a distribuição. Os percentis 10, 25, 50, 75, e 90 para celular são: 1, 3, 6, 12, e 21 folhas de estilo por página.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=163217622&format=interactive",
  sheets_gid="1111507751",
  sql_file="stylesheet_count.sql"
) }}

Outra métrica de tamanho é o número de regras. A página mediana contém um total de 448 regras e 5.454 declarações. Curiosamente, 10% das páginas contêm uma pequena quantidade de CSS: menos de 13 regras! Apesar de ter folhas de estilo ligeiramente menores, ela também tem um pouco mais de regras, indicando regras menores em geral (como tende a acontecer com media queries).

{{ figure_markup(
  image="rules.png",
  caption="Distribuição do número total de regras de estilo por página.",
  description="Gráfico de barras mostrando a distribuição das regras de estilo por página. No celular tende a ter um pouco mais de regras do que no desktop. Os percentis 10, 25, 50, 75, e 90 para celular são: 13, 140, 479, 1.074, e 1.831 regras por página.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1918103300&format=interactive",
  sheets_gid="42376523",
  sql_file="selectors.sql"
) }}

## Seletores e cascata

O CSS oferece várias formas de aplicar estilos à página, desde classes, ids e utilizando e a tão importante cascata para evitar a duplicação de estilos. Então, como os desenvolvedores estão aplicando seus estilos em suas páginas?

### Nomes de classes

Para que os desenvolvedores usam nomes de classe hoje em dia? Para responder a esta pergunta, analisamos os nomes de classe mais populares. A lista foi dominada pelas classes do <a hreflang="en" href="https://fontawesome.com/">Font Awesome</a>, sendo 192 das 198 classes `fa` ou `fa-*`! A única coisa que a exploração inicial pôde nos dizer foi que o Font Awesome é extremamente popular e é utilizado por quase um terço dos websites!

Entretanto, uma vez que removemos as classes `fa-*` e depois `wp-*` (que vêm do <a hreflang="en" href="https://wordpress.com/">WordPress</a>, outro software extremamente popular), obtivemos resultados mais significativos. Omitindo estas classes, as relacionadas ao estado parecem ser as mais populares, com `.active` ocorrendo em quase metade dos websites, e `.selected` e `.disabled` logo em seguida.

Apenas algumas das classes no topo eram de apresentação, com a maioria delas relacionadas a alinhamentos (`pull-right` e `pull-left` do antigo <a hreflang="en" href="https://getbootstrap.com/">Bootstrap</a>, `alignright`, `alignleft` etc.) ou `clearfix` - que ainda ocorre em 22% dos websites, apesar de floats serem substituídos como um método de layout pelos módulos mais modernos Grid e Flexbox.

{{ figure_markup(
  image="popular-class-names.png",
  caption="Os nomes de classe mais populares pela porcentagem de páginas.",
  description="Gráfico de barras mostrando os 14 nomes de classe mais populares para páginas desktop e celular. A classe active é encontrada em 40% das páginas. O restante das classes é encontrado em 20-30% das páginas e estão, em ordem decrescente: `fa`, `fa-*;`, `pull-right`, `pull-left`, `selected`, `disabled`, `clearfix`, `button`, `title`, `wp-*;`, `btn`, `container`, e `sr-only`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1187401149&format=interactive",
  sheets_gid="863628849",
  sql_file="top_selector_classes_wp_fa_prefixes.sql"
) }}

### IDs

Apesar dos IDs serem desencorajados atualmente em alguns círculos devido à sua grande especificidade, a maioria dos sites ainda os utiliza, embora com parcimônia. Menos da metade das páginas utilizava mais de um ID em qualquer um de seus seletores (tinha uma especificidade máxima de (1,x,y) ou menos) e quase todos tinham uma especificidade média que não incluía IDs (0,x,y). Consulte a <a hreflang="en" href="https://www.w3.org/TR/selectors/#specificity-rules">especificação de seletores da W3C</a> para obter mais detalhes de como calcular especificidade e esta notação (a,b,c).

Mas para que os IDs são usados? Acontece que os IDs mais populares são estruturais: `#content`, `#footer`, `#header`, `#main`, embora existam [elementos HTML correspondentes](https://developer.mozilla.org/docs/Learn/HTML/Introduction_to_HTML/Document_and_website_structure#elementos_de_layout_do_html_em_mais_detalhes) que poderiam ser utilizados como seletores ao mesmo tempo em que melhoram a marcação semântica.

{{ figure_markup(
  image="popular-ids.png",
  caption="Os mais populares IDs pela porcentagem de páginas.",
  description="Gráfico de barras mostrando os 10 IDs mais populares para páginas desktop e celular. O ID mais popular é `content` em 14% das páginas. Os IDs `footer` e `header` tem adoção um pouco menor. Os IDs `logo`, `main`, `respond`, `comments`, `fancybox-loading`, `wrapper`, e `submit` tem entre 5 e 10% de adoção nas páginas. A única diferença notável entre desktop e celular é o ID `comments` usado em cerca de 8% das páginas para celular e apenas 5% nas páginas desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=141873739&format=interactive",
  sheets_gid="734822190",
  sql_file="top_selector_ids.sql"
) }}

IDs também podem ser usados para reduzir ou aumentar intencionalmente a especificidade. O <a hreflang="en" href="https://csswizardry.com/2014/07/hacks-for-dealing-with-specificity/">hack de especificidade de escrever um seletor de ID como um seletor de atributo</a> (`[id="foo"]` em vez de `#foo` para reduzir a especificidade) foi surpreendentemente raro, com apenas 0,3% das páginas utilizando-o pelo menos uma vez. Outro hack de especificidade relacionada a ID, utilizando um seletor de negação + descendente como `:not(#nonexistent) .foo` em vez de `.foo` para aumentar a especificidade, também foi muito raro, aparecendo em apenas 0,1% das páginas.

### `!important` {important}

Em vez disso, o antigo `!important` ainda é utilizado de forma justa apesar de seus <a hreflang="en" href="https://www.impressivewebs.com/everything-you-need-to-know-about-the-important-css-declaration/#post-475:~:text=Drawbacks,-to">conhecidos inconvenientes</a>. A página mediana utiliza `!important` em quase 2% de suas declarações, ou 1 em 50.

{{ figure_markup(
  caption="Páginas no celular usando `!important` em cada declaração!",
  content="2,138",
  classes="big-number",
  sheets_gid="1743048352",
  sql_file="meta_important_adoption.sql"
)
}}

Alguns desenvolvedores literalmente não conseguem se fartar do uso dele: encontramos 2304 páginas desktop e 2138 páginas para celular que utilizam `!important` em cada uma das declarações!

{{ figure_markup(
  image="important-properties.png",
  caption="Distribuição de porcentagem da propriedade `!important` por página.",
  description="Gráfico de barras mostrando a distribuição da porcentagem da propriedade !important por página. As páginas desktop tendem a usar !important em um pouco mais de propriedades do que para celular. Os percentis 10, 25, 50, 75, e 90 para celular são: 0, 1, 2, 4, e 7% de propriedades com !important.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=768784205&format=interactive",
  sheets_gid="1743048352",
  sql_file="meta_important_adoption.sql"
) }}

O que é que os desenvolvedores estão tão interessados em sobrescrever? Fizemos uma discriminação por propriedade e descobrimos que quase 80% das páginas utilizam `!important` com a propriedade `display`. É uma estratégia comum aplicar o `display: none !important` para ocultar conteúdo nas classes helper para sobrescrever o CSS existente que utiliza o `display` para definir um modo de layout. Este é um efeito colateral do que, em retrospectiva, foi uma falha no CSS. Ele combinou três características ortogonais em uma: modo de layout interno, comportamento de fluxo e status de visibilidade, todos controlados pela propriedade `display`. Há esforços para separar estes valores em palavras-chave separadas do `display` para que possam ser ajustados independentemente através de propriedades personalizadas, mas <a hreflang="en" href="https://caniuse.com/mdn-css_properties_display_multi-keyword_values">o suporte do navegador é praticamente inexistente</a> por enquanto.

{{ figure_markup(
  image="important-top-properties.png",
  caption="O topo de propriedades com `!important` pela porcentagem de páginas.",
  description="Gráfico de barras mostrando as 10 propriedades que mais usam `!important`. Páginas para celular e desktop tem um uso similar. A propriedade `display` é a mais usada com `!important`, em 79% das páginas para celular. Em ordem decrescente, as propriedades subsequentes em 71-58% das páginas para celular são: `color`, `width`, `height`, `background`, `padding`, `margin`, `border`, `background-color`, e `float`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=257343566&format=interactive",
  sheets_gid="1222608982",
  sql_file="meta_important_properties.sql"
) }}

### Especificidade e classes

Além de manter os `id`s e `!important`s poucos e distantes, há uma tendência de contornar completamente a especificidade, colocando todos os critérios de seleção de um seletor em um único nome de classe, forçando assim todas as regras a terem a mesma especificidade e transformando a cascata em um sistema mais simples em que o último vence. O BEM é uma metodologia popular desse tipo, embora não seja a única. Embora seja difícil avaliar quantos websites usam exclusivamente metodologias no estilo BEM, uma vez que segui-la em cada regra é raro (mesmo o <a hreflang="en" href="https://en.bem.info/">website BEM</a> usa múltiplas classes em muitos seletores), cerca de 10% das páginas tinham uma especificidade mediana de (0,1,0), o que pode indicar que a maioria segue uma metodologia no estilo BEM. No extremo oposto do BEM, muitas vezes os desenvolvedores utilizam <a hreflang="en" href="https://csswizardry.com/2014/07/hacks-for-dealing-with-specificity/#safely-increasing-specificity">classes duplicadas</a> para aumentar a especificidade e empurrar um seletor à frente de outro (por exemplo, `.foo.foo` em vez de `.foo`). Este tipo de hack de especificidade é na verdade mais popular que o BEM, estando presente em 14% dos websites nos celulares (9% no desktop)! Isto pode indicar que a maioria dos desenvolvedores não quer realmente se livrar completamente da cascata, eles só precisam de mais controle sobre ela.

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentíl</th>
        <th>Desktop</th>
        <th>Celular</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td>0,1,0</td>
        <td>0,1,0</td>
      </tr>
      <tr>
        <td>25</td>
        <td>0,2,0</td>
        <td>0,1,2</td>
      </tr>
      <tr>
        <td>50</td>
        <td>0,2,0</td>
        <td>0,2,0</td>
      </tr>
      <tr>
        <td>75</td>
        <td>0,2,0</td>
        <td>0,2,0</td>
      </tr>
      <tr>
        <td>90</td>
        <td>0,3,0</td>
        <td>0,3,0</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Distribuição da especificidade média por página.",
      sheets_gid="1213836297",
      sql_file="specificity.sql"
    ) }}
  </figcaption>
</figure>

### Seletores de atributo

O seletor de atributos mais popular, de longe, é o atributo `type`, utilizado em 45% das páginas, com probabilidade de estilizar entradas de diferentes tipos, por exemplo, para estilizar inputs de forma diferente de radios, checkboxes, sliders, file upload controls etc.

{{ figure_markup(
  image="attribute-selectors.png",
  caption="Os seletores de atributos mais populares pela porcentagem de páginas.",
  description="Gráfico de barras mostrando os seletores de atributos mais usados pela porcentagem de páginas. Celular e desktop têm uso semelhante. O seletor de atributos mais popular de longe é o `type`, utilizado em 46% das páginas para celular. Em seguida, o seletor de atributo `class` é utilizado em 30% das páginas para celular. Os seguintes seletores de atributo são utilizados entre 17 e 3% em ordem decrescente: `disabled`, `dir`, `title`, `hidden`, `controls`, `data-type`, `data-align`, `href`, `poster`, `role`, `style`, `xmlns`, `aria-disabled`, `src`, `id`, `name`, `lang`, e `multiple`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=320159317&format=interactive",
  sheets_gid="1926527049",
  sql_file="top_selector_attributes.sql"
) }}

### Pseudo-classes e pseudo-elements

Há sempre muita inércia quando mudamos algo na plataforma web depois que ela está estabelecida há muito tempo. Por exemplo, a web ainda não tirou o atraso com o uso dos pseudo-elements com sintaxe separada em comparação com as pseudo-classes, embora esta tenha sido uma mudança que aconteceu há mais de uma década. Todos os pseudo-elementos que também estão disponíveis com uma sintaxe de pseudo-classe por razões de legado são muito mais difundidos (2,5x a 5x!) com a sintaxe de pseudo-classe.

{{ figure_markup(
  image="selector-pseudo-classes.png",
  caption="Uso da sintaxe legada `:pseudo-class` como `::pseudo-elements` pela porcentagem das páginas para celular.",
  description="Gráfico de barras mostrando a porcentagem de páginas que usam a sintaxe de pseudo-classe (prefixada por um cólon) versus a sintaxe de pseudo-elementos (dois cólons) para pseudo-elementos. O pseudo-elemento `before` é usado com a sintaxe pseud-classe em 71% páginas para celular e sintaxe pseudo-elemento em 33% das páginas para celular. O pseudo-elemento `after` é usado com sintaxe de classe e elemento em 68% e 30% das páginas para celular, `first-letter` em 7% e 1% das páginas para celular, e `first-line` em 1% e 0% das páginas para celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=227968207&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

De longe as pseudo-classes mais populares são as de ação do usuário, com `:hover`, `:focus`, e `:active` no topo da lista, todas utilizadas em mais de dois terços das páginas, indicando que os desenvolvedores gostam da conveniência de especificar as interações declarativas da IU.

`:root` parece muito mais popular do que se justifica por sua função, utilizada em um terço das páginas. No conteúdo HTML, ele apenas seleciona o elemento `<html>`, então por que os desenvolvedores não utilizaram apenas `html`? Uma possível resposta pode estar em uma prática comum relacionada à definição de propriedades customizadas, [que também são altamente utilizadas](#propriedades-customizadas), na pseudo-classe `:root`. Outra resposta pode estar na especificidade: `:root`, sendo uma pseudo-classe, tem uma especificidade maior do que `html`: (0, 1, 0) versus (0, 0, 1). É um hack comum para aumentar a especificidade de um seletor, atrelando ele com `:root`, por exemplo `:root .foo` tem uma especificidade de (0, 2, 0) em comparação com apenas (0, 1, 0) para `.foo`. Muitas vezes, isso é tudo o que é necessário para empurrar um seletor ligeiramente sobre outro na corrida em cascata e evitar a marreta que é `!important`. Para testar esta hipótese, também medimos exatamente isso: quantas páginas utilizam `:root` no início de um seletor descendente? Os resultados verificaram nossa hipótese: 29% das páginas utilizam `:root` dessa forma! Além disso, 14% das páginas desktop e 19% das páginas para celular utilizam `html` no início de um seletor de descendentes, possivelmente para dar ao seletor um impulso ainda menor de especificidade. A popularidade desses hacks de especificidade indica fortemente que os desenvolvedores precisam de um controle mais refinado para ajustar a especificidade do que o que é oferecido a eles com `!important`. Felizmente, isto está chegando em breve com [`:where()`](https://developer.mozilla.org/docs/Web/CSS/:where), que já está <a hreflang="en" href="https://caniuse.com/mdn-css_selectors_where">implementado na maioria dos navegadores modernos</a> (embora, por enquanto, via flag no Chrome).

{{ figure_markup(
  image="popular-selector-pseudo-classes.png",
  caption="As mais populares pseudo-classes pela porcentagem de páginas.",
  description="Gráfico de barras mostrando as pseudo-classes mais populares pela porcentagem de páginas para desktops e celular. Desktop e celular são em sua maioria similares, com páginas para celular tendo tendência a ter uma adoção ligeiramente maior. A pseudo-classe mais popular é `hover`, utilizada em 84% das páginas. As seguintes pseudo-classes diminuem em popularidade de 71% para 12% quase linearmente: `before`, `after`, `focus`, `active`, `first-child`, `last-child`, `visited`, `not`, `root`, `nth-child`, `link`, `disabled`, `empty`, `nth-of-type`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1363774711&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

Quando se trata de pseudo-elementos, depois dos suspeitos habituais `::before` e `::after`, quase todos os pseudo-elementos populares eram extensões de navegador para controles de forma de estilo e outras IU built-in, ecoando fortemente a necessidade do desenvolvedor de um controle mais fino sobre o estilo de construção da IU. Estilização de focus rings, placeholders, search inputs, spinners, selection, scrollbars, media controls eram especialmente populares.

{{ figure_markup(
  image="popular-selector-pseudo-elements.png",
  caption="Os pseudo-elementos mais populares pela porcentagem das páginas.",
  description="Gráfico de barras mostrando os pseudo-elementos mais populares pela porcentagem de páginas para desktops e celular. Desktop e celular são em sua maioria similares, com celular tendo tendência a ter uma adoção ligeiramente maior. O pseudo-elemento mais popular é `before`, usado em 33% das páginas para celular. O pseudo-elemento `after` é usado em 30% das páginas para celular. `-moz-focus-inner` é usado em 24% das páginas. A popularidade diminui para estes de 17% a 4% em ordem decrescente: `-webkit-input-placeholder`, `-moz-placeholder`, `-webkit-search-decoration`, `-webkit-search-cancel-button`, `-webkit-inner-spin-button`, `-webkit-outer-spin-button`, `-webkit-scrollbar` (7%), `selection`, `-ms-clear`, `-moz-selection`, `-webkit-media-controls`, e `-webkit-scrollbar-thumb`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1417577353&format=interactive",
  sheets_gid="1972610663",
  sql_file="top_selector_pseudo_elements.sql",
  width=600,
  height=500
) }}

## Valores e unidades

CSS fornece várias formas de especificar valores e unidades, seja em comprimentos ou cálculos ou baseados em keywords globais.

### Lengths

A humilde unidade `px` tem recebido muita mídia negativa ao longo dos anos. No início, porque não funcionava bem com a funcionalidade de zoom do antigo Internet Explorer e, mais recentemente, porque existem unidades melhores para a maioria das tarefas que escalam com base em outro fator de design, como o tamanho do viewport, tamanho da fonte do elemento ou tamanho da fonte root, reduzindo o esforço de manutenção ao tornar explícitas as relações implícitas de design. O principal ponto de promoção do `px` - sua correspondência a um pixel do dispositivo dando aos designers um controle total - também desapareceu agora, já que um pixel não é mais um pixel do dispositivo com as modernas telas de alta densidade de pixels. Apesar de tudo isso, os pixels CSS ainda são quase onipresentes nos designs da web.

{{ figure_markup(
  caption="Porcentagem de valores de `<comprimento>` que usam a unidade `px`.",
  content="72.58%",
  classes="big-number",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

A unidade `px` continua forte como a unidade de comprimento mais popular em geral, com um impressionante 72,58% de todos os valores de comprimento em todas as folhas de estilo utilizando o `px`! E se excluirmos as porcentagens (já que elas não são realmente uma unidade) a proporção de `px` aumenta ainda mais, para 84,14%.

{{ figure_markup(
  image="length-units.png",
  caption="As unidades de `<comprimento>` mais populares pela percentagem de ocorrências.",
  description="Gráfico de barras mostrando as unidades de comprimento mais populares pela porcentagem de ocorrências (a frequência com que as unidades aparecem em todas as folhas de estilo). A unidade px é de longe a mais popular, usada em 73% das vezes em folhas de estilo para celular. A próxima unidade mais popular é `%` (sinal de porcentagem), em 17%, seguida de `em` em 9%, e `rem` em 1%. Todas as unidades a seguir têm uma utilização tão baixa que arredondam para 0%: `pt`, `vw`, `vh`, `ch`, `ex`, `cm`, `mm`, `in`, `vmin`, `pc`, e `vmax`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2095127496&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

Como estes `px` estão distribuídos pelas propriedades? Há alguma diferença dependendo da propriedade? Com certeza. Por exemplo, como seria de se esperar, o `px` é muito mais popular nas bordas (80-90%) em comparação com as métricas relacionadas à fonte, tais como `font-size`, `line-height` ou `text-indent`. Entretanto, mesmo para estes, a utilização do `px` supera em muito qualquer outra unidade. De fato, as únicas propriedades para as quais outra unidade (*qualquer* outra unidade) é mais utilizada do que `px` são `vertical-align` (55% `em`), `mask-position` (50% `em`), `padding-inline-start` (62% `em`), `margin-block-start` e `margin-block-end` (65% `em`), e o novíssima `gap` com 62% `rem`.

Pode-se facilmente argumentar que muito deste conteúdo é apenas antigo, escrito antes que os autores fossem mais esclarecidos sobre o uso de unidades relativas para tornar seus designs mais adaptáveis e poupar tempo para si mesmos. No entanto, isto é facilmente desmascarado ao olhar para propriedades mais recentes, tais como `grid-gap` (62% `px`).

<figure>
  <table>
    <thead>
      <tr>
        <th>Propriedade</th>
        <th><code>px</code></th>
        <th><code>&lt;número&gt;</code></th>
        <th><code>em</code></th>
        <th><code>%</code></th>
        <th><code>rem</code></th>
        <th><code>pt</code></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>font-size</code></td>
        <td class="numeric">70%</td>
        <td class="numeric">2%</td>
        <td class="numeric">17%</td>
        <td class="numeric">6%</td>
        <td class="numeric">4%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td><code>line-height</code></td>
        <td class="numeric">54%</td>
        <td class="numeric">31%</td>
        <td class="numeric">13%</td>
        <td class="numeric">3%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>border</code></td>
        <td class="numeric">71%</td>
        <td class="numeric">27%</td>
        <td class="numeric">2%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>border-radius</code></td>
        <td class="numeric">65%</td>
        <td class="numeric">21%</td>
        <td class="numeric">3%</td>
        <td class="numeric">10%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>text-indent</code></td>
        <td class="numeric">32%</td>
        <td class="numeric">51%</td>
        <td class="numeric">8%</td>
        <td class="numeric">9%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>vertical-align</code></td>
        <td class="numeric">29%</td>
        <td class="numeric">12%</td>
        <td class="numeric">55%</td>
        <td class="numeric">4%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>grid-gap</code></td>
        <td class="numeric">63%</td>
        <td class="numeric">11%</td>
        <td class="numeric">9%</td>
        <td class="numeric">1%</td>
        <td class="numeric">16%</td>
        <td></td>
      </tr>
      <tr>
        <td><code>mask-position</code></td>
        <td></td>
        <td></td>
        <td class="numeric">50%</td>
        <td class="numeric">50%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>padding-inline-start</code></td>
        <td class="numeric">33%</td>
        <td class="numeric">5%</td>
        <td class="numeric">62%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>gap</code></td>
        <td class="numeric">21%</td>
        <td class="numeric">16%</td>
        <td class="numeric">1%</td>
        <td></td>
        <td class="numeric">62%</td>
        <td></td>
      </tr>
      <tr>
        <td><code>margin-block-end</code></td>
        <td class="numeric">4%</td>
        <td class="numeric">31%</td>
        <td class="numeric">65%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td><code>margin-inline-start</code></td>
        <td class="numeric">38%</td>
        <td class="numeric">46%</td>
        <td class="numeric">14%</td>
        <td></td>
        <td class="numeric">1%</td>
        <td></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Usos de unidade por propriedade.",
      sheets_gid="1200981062",
      sql_file="units_properties.sql"
    ) }}
  </figcaption>
</figure>

Semelhantemente, apesar das vantagens muito comentadas do `rem` vs `em` para muitos casos de uso, e seu suporte universal ao navegador <a hreflang="en" href="https://caniuse.com/rem">há anos</a>, a web ainda não o alcançou em grande parte: o fiel `em` representa 87% de todas as unidades de uso de fontes-relativas e o `rem` fica muito atrás, com 12%. Vimos alguma utilização do `ch` (largura do glifo '0') e do `ex` (altura x da fonte em uso) na web, mas muito pequena (apenas 0,37% e 0,19% de todas as unidades de fontes-relativas).

{{ figure_markup(
  image="font-units.png",
  caption="Participação relativa de unidades de fonte relativas",
  description="Gráfico de barras mostrando a popularidade relativa de diferentes unidades baseadas em fontes. O `em` é utilizado em 87,3% dos casos, seguido pelo `rem` em 12,2, `ch` em 0,4%, e `ex` em 0,2% dos casos em páginas para celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=166603845&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

Os comprimentos são os únicos tipos de valores em CSS para os quais podemos omitir a unidade quando o valor é zero, ou seja, podemos escrever `0` em vez de `0px` ou `0em` etc. Os desenvolvedores (ou minificadores CSS?) estão tirando proveito disso amplamente: De todos os valores `0`, 89% não tinham unidade.

{{ figure_markup(
  image="zero-lengths.png",
  caption="Popularidade relativa de comprimentos zerados por unidade pela porcentagem das ocorrências em páginas para celular.",
  description="Gráfico de pizza mostrando comprimentos zerados sem unidade (AKA unitless) utilizados em 88,7% do tempo em páginas para celular, a unidade `px` em 10,7%, e outras unidades em 0,5% dos casos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1935151776&format=interactive",
  sheets_gid="313150061",
  sql_file="units_zero.sql"
) }}

### Cálculos

Quando a função [`calc()`](https://developer.mozilla.org/docs/Web/CSS/calc()) foi introduzida para realizar cálculos entre diferentes unidades no CSS, foi uma revolução. Anteriormente, apenas os pré-processadores eram capazes de realizar tais cálculos, mas os resultados eram limitados a valores estáticos e não confiáveis, uma vez que faltava o contexto dinâmico que muitas vezes é necessário.

Hoje, `calc()` tem sido <a hreflang="en" href="https://caniuse.com/calc">suportado por todos os navegadores</a> já há nove anos, portanto não é surpresa que tenha sido amplamente adotado com 60% das páginas utilizando-o pelo menos uma vez. De qualquer forma, nós esperávamos uma adoção ainda maior do que esta.

`calc()` é usado principalmente para comprimentos, com 96% de sua utilização concentrada em propriedades que aceitam valores de `<comprimento>`, e 60% disso (58% da utilização total) na propriedade `width`!

{{ figure_markup(
  image="calc-properties.png",
  caption="Popularidade relativa das propriedades que utilizam `calc()` pela porcentagem das ocorrências.",
  description="Gráfico de barras mostrando a popularidade relativa das propriedades que utilizam a função calc pela porcentagem das ocorrências. Desktop e celular têm resultados semelhantes. A função calc é usada com mais freqüência na propriedade width, 59% das ocorrências de calc em páginas para celular. Ela é usada na propriedade left 11% do tempo, top 5%, max-width 4%, height 4%, e as propriedades restantes estão diminuindo em 2% e 1%: min-height, margin-left, flex-basis, margin-right, max-height (1%), right, padding-bottom, padding-left, font-size, e padding-right.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=722318406&format=interactive",
  sheets_gid="1661677319",
  sql_file="calc_properties.sql"
) }}

Parece que a maior parte desse uso é para subtrair pixels das porcentagens, como evidenciado pelo fato de que as unidades mais comuns em `calc()` são `px` (51% do uso de`calc()`) e `%` ( 42% do uso de `calc()`), e 64% do uso de `calc()` envolve subtração. Curiosamente, as unidades de comprimento mais populares com `calc()` são diferentes das unidades de comprimento mais populares em geral (por exemplo, `rem` é mais popular do que `em`, seguido por unidades de viewport), provavelmente devido ao fato de que o código usando `calc()` é mais recente.

{{ figure_markup(
  image="calc-units.png",
  caption="Popularidade relativa de unidades que usam `calc()` pela porcentagem das ocorrências.",
  description="Gráfico de barras mostrando a popularidade relativa de propriedades que usam a função calc pela porcentagem de ocorrências. Desktop e celular apresentam resultados semelhantes. A função calc é usada com mais frequência na propriedade `width`, 59% das ocorrências calc em páginas para celular. É usado na propriedade `left` 11% do tempo, `top` 5%, `max-width` 4%, `height` 4% e as propriedades restantes estão diminuindo em 2% e 1%: `min-height`, `margin-left`, `flex-basis`, `margin-right`, `max-height` (1%), `right`, `padding-bottom`, `padding-left`, `font-size`, e `padding-right`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=477094785&format=interactive",
  sheets_gid="769910871",
  sql_file="calc_units.sql"
) }}

{{ figure_markup(
  image="calc-operators.png",
  caption="Popularidade relativa de operadores que usam `calc()` pela porcentagem das ocorrências.",
  description="Gráfico de barras mostrando a popularidade relativa de operadores que usam a função calc pelo percentual de ocorrências. Desktop e celular apresentam resultados semelhantes. A função calc é usada com mais frequência com o operador de subtração (sinal de menos), 64% dos casos de calc em páginas para celular, seguido por divisão (barra) 20%, adição (sinal de mais) 11%, e multiplicação (asterisco) 5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1909242522&format=interactive",
  sheets_gid="2077258816",
  sql_file="calc_operators.sql"
) }}

A maioria dos cálculos são muito simples, com 99,5% dos cálculos envolvendo até 2 unidades diferentes, 88,5% dos cálculos envolvendo até 2 operadores e 99,4% dos cálculos envolvendo um conjunto de parênteses ou menos (3 de 4 cálculos não incluem parênteses).

{{ figure_markup(
  image="calc-complexity-units.png",
  caption="Distribuição do número de unidades por ocorrência de `calc()`.",
  description="Gráfico de barras mostrando a distribuição do número de unidades por ocorrência da função calc. Desktop e celular apresentam resultados semelhantes. Calc é usado com uma unidade 11% do tempo em páginas para celular, duas vezes 89% do tempo, e 3 ou mais vezes aproximadamente 0% do tempo.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=695698141&format=interactive",
  sheets_gid="1493602565",
  sql_file="calc_complexity_units.sql"
)
}}

### Global keywords e `all`

Por muito tempo, o CSS suportou apenas uma palavra-chave global: [`inherit`](https://developer.mozilla.org/docs/Web/CSS/inherit), que permite a redefinição de uma propriedade herdável para seu valor herdado ou reutilizando o valor do pai para uma determinada propriedade não herdável. Acontece que a primeira forma é muito mais comum do que a última, com 81,37% do uso de `inherit` sendo encontrado em propriedades herdáveis. O resto é principalmente para herdar backgrounds, borders, ou dimensions. O último provavelmente indica problemas de layout, já que com o modo de layout adequado raramente é necessário forçar uma herança para `width` e `height`.

A palavra-chave `inherit` tem sido particularmente útil para reconfigurar as cores padrão sangrentas do link para a cor do texto do pai, quando pretendemos usar algo diferente de cor como um recurso para links. Portanto, não é surpresa que `color` seja a propriedade mais comum em que `inherit` é usado. Quase um terço de todo o uso de `inherit` é encontrado na propriedade `color`. 75% das páginas usam `color: inherit` pelo menos uma vez.

Embora o *valor de propriedade initial* seja um conceito que <a hreflang="en" href="https://www.w3.org/TR/CSS1/#cascading-order">existe desde CSS 1</a>, ele só tem sua própria palavra-chave dedicada, `initial` , para se referir explicitamente a ele <a hreflang="en" href="https://www.w3.org/TR/2013/WD-css3-cascade-20130103/#initial-keyword">17 anos depois</a>, e levou mais dois anos para essa palavra-chave ganhar <a hreflang="en" href="https://caniuse.com/css-initial-value">suporte universal nos navegadores</a> em 2015. Portanto, não é surpresa que seja usado muito menos do que `inherit`. Enquanto a herança antiga é encontrada em 85% das páginas, `initial` aparece em 51% delas. Além disso, há muita confusão sobre o que `initial` realmente faz, já que `display` está no topo da lista de propriedades mais comumente usadas com `initial`, com `display: initial` aparecendo em 10% das páginas. Presumivelmente, os desenvolvedores pensaram que isso redefinia `display` para seu valor da [folha de estilo do user-agent](https://developer.mozilla.org/docs/Web/CSS/Cascade#User-agent_stylesheets) e estavam usando para alternar `display: none` entre ligado e desligado. No entanto, <a hreflang="en" href="https://drafts.csswg.org/css-display/#the-display-properties">o valor inicial de `display` é `inline`</a>, então `display: initial` é apenas outra maneira de escrever `display: inline` e não tem propriedades mágicas dependentes do contexto.

Em vez disso, `display: revert` teria realmente feito o que esses desenvolvedores provavelmente esperavam e teria redefinido `display` para o valor do UA para o elemento fornecido. No entanto, `revert` é muito mais recente: foi definido <a hreflang="en" href="https://www.w3.org/TR/2015/WD-css-cascade-4-20150908/#valdef-all-revert">em 2015</a> e <a hreflang="en" href="https://caniuse.com/css-revert-value">só ganhou suporte universal para navegadores este ano</a>, o que explica sua subutilização: aparece apenas em 0,14% das páginas e metade de seu uso é `line-height: revert;`, encontrado em <a hreflang="en" href="https://github.com/WordPress/WordPress/commit/303180b392c530b8e2c8b3c27532d591b915caeb">versões recentes do tema TwentyTwenty do WordPress</a>.

A última palavra-chave global, `unset`, é essencialmente um híbrido de `initial` e `inherit`. Nas propriedades herdadas, torna-se `inherit` e no resto torna-se `initial`, essencialmente redefinindo a propriedade em todas as origens em cascata. Da mesma forma, para `initial`, foi <a hreflang="en" href="https://www.w3.org/TR/2013/WD-css-cascade-3-20130730/#inherit-initial">definido em 2013</a> e ganhou <a hreflang="en" href="https://caniuse.com/css-unset-value">suporte completo dos navegadores em 2015</a>. Apesar do uso maior de `unset`, ele é usado em apenas 43% das páginas, enquanto `initial` é usado em 51% das páginas. Além disso, além de `max-width` e `min-width`, em todas as outras propriedades o uso `initial` supera o uso de `unset`.

{{ figure_markup(
  image="keyword-totals.png",
  caption="Adoção de palavras-chave globais pela porcentagem de páginas.",
  description="Gráfico de barras mostrando a adoção de palavras-chave globais pela porcentagem das páginas. As páginas para celular tendem a ter uma taxa de adoção mais alta. A palavra-chave `inherit` é usada em 85% das páginas móveis, `initial` em 51%, `unset` em 43% e `revert` em aproximadamente 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1246886332&format=interactive",
  sheets_gid="437371205",
  sql_file="keyword_totals.sql"
) }}

A propriedade `all` foi <a hreflang="en" href="https://www.w3.org/TR/2013/WD-css3-cascade-20130103/#all-shorthand">introduzida em 2013</a> e ganhou <a hreflang="en" href="https://caniuse.com/css-all">suporte quase universal em 2016 (exceto Edge) e suporte universal no início deste ano</a>. É uma abreviação de quase todas as propriedades em CSS (exceto propriedades personalizadas, `direction` e `unicode-bidi`), e só aceita as <a hreflang="en" href="https://drafts.csswg.org/css-cascade-4/#defaulting-keywords">quatro palavras-chave globais</a> (`initial`, `inherit`, `unset` e `revert`) como valores. Ele foi concebido como um reset de CSS de uma linha, seja como `all: unset` ou `all: revert`, dependendo do tipo de reset que desejamos. No entanto, a adoção ainda é muito baixa: encontramos apenas `all` em 477 páginas (0,01% de todas as páginas), e apenas usado com a palavra-chave `revert`.

## Cor

Dizem que as piadas antigas são as melhores, e isso vale também para as cores. A sintaxe hexadecimal original, enigmática, `#rrggbb` permanece como a forma mais popular de especificar uma cor em CSS em 2020: Metade de todas as cores são escritas dessa forma. O próximo formato mais popular é o formato hexadecimal de três dígitos `#rgb` um pouco mais curto, com 26%. Embora seja mais curto, também é capaz de *expressar* muito menos cores; apenas 4.096, dos 16,7 milhões de valores de sRGB.

{{ figure_markup(
  image="popular-color-formats.png",
  caption="Popularidade relativa de formatos de cores pela porcentagem de ocorrências.",
  description="Gráfico de barras mostrando a popularidade relativa de formatos de cores pela porcentagem de ocorrências. O formato `#rrggbb` é usado em 50% das ocorrências em páginas para celular, com desktop sendo um pouco maior com 52%. O formato `#rgb` é usado em 25% das ocorrências, seguido por `rgba()` com 14%, `transparent` com 8%, e cores nomeadas (como `red`) com 1%, e todos os formatos de cores restantes têm aproximadamente 0% de popularidade relativa em páginas para celular: `#rrggbbaa`, `rbg()`, `hsla()`, `currentColor`, `#rgba`, um sistema de cor, `hsl()`, e `color()`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=65722098&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

Da mesma forma, 99,89% das cores sRGB especificadas funcionalmente estão usando o formato legado desde sempre com vírgulas `rgb(127, 255, 84)` em vez da nova forma sem vírgulas `rgb(127 255 84)`. Porque, apesar de todos os navegadores modernos aceitarem a nova sintaxe, a mudança oferece nenhuma vantagem para os desenvolvedores.

Então, por que as pessoas se desviam desses formatos testados e comprovados? Para expressar transparência alfa. Isso fica claro quando você olha para `rgba()`, que é usado 40 vezes mais do que `rgb()` (13,82% vs 0,34% de todas as cores) e `hsla()`, que é usado 30 vezes mais do que `hsl()` (0,25% vs 0,01% de todas as cores).

HSL deve ser <a hreflang="en" href="https://drafts.csswg.org/css-color-4/#the-hsl-notation">fácil de entender e fácil de modificar</a>. Mas esses números mostram que, na prática, HSL é usado em folhas de estilo muito menos do que RGB, provavelmente porque essas vantagens são <a hreflang="en" href="https://drafts.csswg.org/css-color-4/#ex-hsl-sucks">exageradas</a>.

{{ figure_markup(
  image="color-formats-alpha.png",
  caption="Popularidade relativa de formatos de cores agrupados por suporte alfa pela porcentagem de ocorrências em páginas para celular (excluindo `#rrggbb` e `#rgb`).",
  description="Gráfico de barras mostrando a popularidade relativa de formatos de cores agrupados por suporte alfa pela porcentagem de ocorrências em páginas para celular, excluindo `#rrggbb` e `# rgb`. Os formatos de cores que suportam alfa somam cerca de 23% das ocorrências, enquanto os formatos de cores que não suportam alfa somam apenas 2% das ocorrências em páginas para celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1861989753&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

E quanto às cores nomeadas? A keyword `transparent`, que é apenas outra maneira de dizer `rgb(0 0 0 / 0)`, é a mais popular, com 8,25% de todos os valores sRGB (66% de todo o uso de cores nomeadas); seguido por todas as cores nomeadas (X11) - estou olhando para você, `papayawhip` - com 1,48%. Os mais populares deles eram os nomes facilmente compreendidos como `white`, `black`, `red`, `gray`, `blue`. `whitesmoke` era o mais comum dos nomes incomuns (claro, podemos visualizar whitesmoke, certo), enquanto nomes como `gainsboro`, `lightCoral` e `burlywood` foram bem menos usados​. Podemos entender por quê - você precisa consultá-los para ver o que realmente significam!

E se você está procurando nomes de cores fantásticos, por que não definir os seus próprios com as [propriedades customizadas do CSS](#propriedades-customizadas)? `--intensePurple` e `--corporateBlue` significam o que você precisa que eles signifiquem. Isso provavelmente explica porque [50% das propriedades personalizadas](#uso-por-tipo) são usados ​​para cores.

{{ figure_markup(
  link="https://codepen.io/leaverou/pen/GRjjJwJ",
  image="color-keywords-app.png",
  caption='Explore interativamente os dados de uso de palavras-chave de cores com <a hreflang="en" href="https://codepen.io/leaverou/pen/GRjjJwJ"> esta aplicação interativa </a>!',
  description="Captura de tela de uma aplicação que permite selecionar cores e ver seu uso relativo em um gráfico de pizza. Os dados para as cores são mostrados na próxima tabela.",
  width=600,
  height=1065
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="col">Palavra-chave</th>
        <th scope="col">Desktop</th>
        <th scope="col">Celular</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>{{ swatch('transparent') }}</span></td>
        <td>transparent</td>
        <td class="numeric">84.04%</td>
        <td class="numeric">83.51%</td>
      </tr>
      <tr>
        <td>{{ swatch('white') }}</td>
        <td>white</td>
        <td class="numeric">6.82%</td>
        <td class="numeric">7.34%</td>
      </tr>
      <tr>
        <td>{{ swatch('black') }}</span></td>
        <td>black</td>
        <td class="numeric">2.32%</td>
        <td class="numeric">2.42%</td>
      </tr>
      <tr>
        <td>{{ swatch('red') }}</td>
        <td>red</td>
        <td class="numeric">2.03%</td>
        <td class="numeric">2.01%</td>
      </tr>
      <tr>
        <td>{{ swatch('currentColor') }}</span></td>
        <td>currentColor</td>
        <td class="numeric">1.43%</td>
        <td class="numeric">1.43%</td>
      </tr>
      <tr>
        <td>{{ swatch('gray') }}</span></td>
        <td>gray</td>
        <td class="numeric">0.75%</td>
        <td class="numeric">0.79%</td>
      </tr>
      <tr>
        <td>{{ swatch('silver') }}</span></td>
        <td>silver</td>
        <td class="numeric">0.66%</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>{{ swatch('grey') }}</span></td>
        <td>grey</td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td>{{ swatch('green') }}</span></td>
        <td>green</td>
        <td class="numeric">0.36%</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td>{{ swatch('magenta') }}</span></td>
        <td>magenta</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('blue') }}</span></td>
        <td>blue</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('whitesmoke') }}</span></td>
        <td>whitesmoke</td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgray') }}</span></td>
        <td>lightgray</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td>{{ swatch('orange') }}</span></td>
        <td>orange</td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgrey') }}</span></td>
        <td>lightgrey</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('yellow') }}</span></td>
        <td>yellow</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>{{ swatch('Highlight') }}</span></td>
        <td>Highlight</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('gold') }}</span></td>
        <td>gold</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('pink') }}</span></td>
        <td>pink</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>{{ swatch('teal') }}</span></td>
        <td>teal</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Popularidade relativa de palavras-chave de cores pela porcentagem das ocorrências.",
      sheets_gid="1429541094",
      sql_file="color_keywords.sql"
    ) }}
  </figcaption>
</figure>

E, por último, as cores do sistema antes obsoletas - agora parcialmente obsoletas - como `Canvas` e `ThreeDDarkShadow`: essas foram uma ideia terrível, introduzidas para emular a interface de usuário típica de coisas como Java ou Windows 95, e já incapazes para acompanhar o Windows 98, elas logo caíram no esquecimento. Alguns sites usam essas cores do sistema para tentar rastrear suas impressões digitais, uma brecha que <a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5710">estamos tentando fechar enquanto conversamos</a>. Existem alguns bons motivos para usá-las, e a maioria dos sites (99,99%) não as usam, então estamos bem.

O <a hreflang="en" href="https://css-tricks.com/currentcolor/">valor bastante útil `currentColor`</a>, surpreendentemente, ficou atrás com 0,14% de todas as cores sRGB (1,62% de todas as cores nomeadas).

Todas as cores que discutimos até agora têm uma coisa em comum: sRGB, o espaço de cores padrão para a web (e para a TV de alta definição, de onde veio). Por que isso é tão ruim? Porque ele só pode exibir uma gama limitada de cores: seu telefone, sua TV e provavelmente seu laptop são capazes de exibir cores muito mais vivas devido aos avanços na tecnologia de exibição. Monitores com ampla gama de cores, que costumavam ser reservados para fotógrafos profissionais bem pagos e designers gráficos, agora estão disponíveis para todos. Aplicativos nativos usam esse recurso, assim como filmes digitais e serviços de streaming de TV, mas até recentemente a web estava perdendo.

E ainda estamos perdendo. Apesar de ter sido <a hreflang="en" href="https://webkit.org/blog/6682/improving-color-on-the-web/">implementado no Safari em 2016</a>, o uso de cores display-p3 em páginas da web é muito pequeno. Nosso rastreamento na web encontrou apenas 29 páginas para celular e 36 páginas para desktop usando-o! (E mais da metade deles foram erros de sintaxe, erros ou tentativas de usar a função `color-mod()` nunca implementada). Ficamos curiosos por quê.

Compatibilidade, certo? Você não quer que as coisas quebrem? Não. Nas folhas de estilo que examinamos, encontramos um uso sólido de fallback: com a ordem do documento, a cascata, `@supports`, a media query `color-gamut`, todas essas coisas boas. Portanto, em uma folha de estilo, veríamos a cor desejada pelo designer, expressa em display-p3, e também uma cor sRGB substituta. Calculamos a diferença visível (um cálculo chamado <a hreflang="en" href="https://zschuessler.github.io/DeltaE/learn/">ΔE2000</a>) entre a cor desejada e a de fallback e isso era normalmente bastante modesto. Um pequeno ajuste. Uma exploração cuidadosa. Na verdade, em 37,6% das vezes, a cor especificada em display-p3 realmente caiu dentro da faixa de cores (a gama) que o sRGB pode gerenciar. Parece que as pessoas estão apenas experimentando isso com cautela no momento, em vez de obter ganhos reais, mas certamente haverá mais por vir neste espaço, então apenas vamos observar.

<figure>
  <table class="large-table">
    <thead>
      <tr>
        <th scope="col" colspan="2">sRGB</th>
        <th scope="col">display-p3</th>
        <th scope="col">ΔE2000</th>
        <th scope="col" class="no-wrap">In gamut</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>rgba(255,205,63,1)</code></td>
        <td>{{ swatch('rgba(255, 205, 63, 1)') }}</td>
        <td><code>color(display 1 0.80 0.25 / 1)</code></td>
        <td class="numeric">3.880</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(120,0,255,1)</code></td>
        <td>{{ swatch('rgba(120, 0, 255, 1)') }}</td>
        <td><code>color(display 0.47 0 1 / 1)</code></td>
        <td class="numeric">1.933</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(121,127,132,1)</code></td>
        <td>{{ swatch('rgba(121, 127, 132, 1)') }}</td>
        <td><code>color(display 0.48 0.50 0.52 / 1)</code></td>
        <td class="numeric">0.391</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(200,200,200,1)</code></td>
        <td>{{ swatch('rgba(200, 200, 200, 1)') }}</td>
        <td><code>color(display 0.78 0.78 0.78 / 1)</code></td>
        <td class="numeric">0.274</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(97,97,99,1)</code></td>
        <td>{{ swatch('rgba(97, 97, 99, 1)') }}</td>
        <td><code>color(display 0.39 0.39 0.39 / 1)</code></td>
        <td class="numeric">1.474</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(0,0,0,1)</code></td>
        <td>{{ swatch('rgba(0, 0, 0, 1)') }}</td>
        <td><code>color(display 0 0 0 / 1)</code></td>
        <td class="numeric">0.000</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(255,255,255,1)</code></td>
        <td>{{ swatch('rgba(255, 255, 255, 1)') }}</td>
        <td><code>color(display 1 1 1 / 1)</code></td>
        <td class="numeric">0.015</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(84,64,135,1)</code></td>
        <td>{{ swatch('rgba(84, 64, 135, 1)') }}</td>
        <td><code>color(display 0.33 0.25 0.53 / 1)</code></td>
        <td class="numeric">1.326</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(131,103,201,1)</code></td>
        <td>{{ swatch('rgba(131, 103, 201, 1)') }}</td>
        <td><code>color(display 0.51 0.40 0.78 / 1)</code></td>
        <td class="numeric">1.348</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(68,185,208,1)</code></td>
        <td>{{ swatch('rgba(68, 185, 208, 1)') }}</td>
        <td><code>color(display 0.27 0.75 0.82 / 1)</code></td>
        <td class="numeric">5.591</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(255,0,72)</code></td>
        <td>{{ swatch('rgb(255, 0, 72)') }}</td>
        <td><code>color(display 1 0 0.2823 / 1)</code></td>
        <td class="numeric">3.529</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(255,205,63,1)</code></td>
        <td>{{ swatch('rgba(255, 205, 63, 1)') }}</td>
        <td><code>color(display 1 0.80 0.25 / 1)</code></td>
        <td class="numeric">3.880</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(241,174,50,1)</code></td>
        <td>{{ swatch('rgba(241, 174, 50, 1)') }}</td>
        <td><code>color(display 0.95 0.68 0.17 / 1)</code></td>
        <td class="numeric">4.701</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(245,181,40,1)</code></td>
        <td>{{ swatch('rgba(245, 181, 40, 1)') }}</td>
        <td><code>color(display 0.96 0.71 0.16 / 1)</code></td>
        <td class="numeric">4.218</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(147, 83, 255)</code></td>
        <td>{{ swatch('rgb(147, 83, 255)') }}</td>
        <td><code>color(display 0.58 0.33 1 / 1)</code></td>
        <td class="numeric">2.143</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(75,3,161,1)</code></td>
        <td>{{ swatch('rgba(75, 3, 161, 1)') }}</td>
        <td><code>color(display 0.29 0.01 0.63 / 1)</code></td>
        <td class="numeric">1.321</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(255,0,0,0.85)</code></td>
        <td>{{ swatch('rgba(255, 0, 0, 0.85)') }}</td>
        <td><code>color(display 1 0 0 / 0.85)</code></td>
        <td class="numeric">7.115</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(84,64,135,1)</code></td>
        <td>{{ swatch('rgba(84, 64, 135, 1)') }}</td>
        <td><code>color(display 0.33 0.25 0.53 / 1)</code></td>
        <td class="numeric">1.326</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(131,103,201,1)</code></td>
        <td>{{ swatch('rgba(131, 103, 201, 1)') }}</td>
        <td><code>color(display 0.51 0.40 0.78 / 1)</code></td>
        <td class="numeric">1.348</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(68,185,208,1)</code></td>
        <td>{{ swatch('rgba(68, 185, 208, 1)') }}</td>
        <td><code>color(display 0.27 0.75 0.82 / 1)</code></td>
        <td class="numeric">5.591</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#6d3bff</code></td>
        <td>{{ swatch('#6d3bff') }}</td>
        <td><code>color(display .427 .231 1)</code></td>
        <td class="numeric">1.584</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#03d658</code></td>
        <td>{{ swatch('#03d658') }}</td>
        <td><code>color(display .012 .839 .345)</code></td>
        <td class="numeric">4.958</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#ff3900</code></td>
        <td>{{ swatch('#ff3900') }}</td>
        <td><code>color(display 1 .224 0)</code></td>
        <td class="numeric">7.140</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#7cf8b3</code></td>
        <td>{{ swatch('#7cf8b3') }}</td>
        <td><code>color(display .486 .973 .702)</code></td>
        <td class="numeric">4.284</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#f8f8f8</code></td>
        <td>{{ swatch('#f8f8f8') }}</td>
        <td><code>color(display .973 .973 .973)</code></td>
        <td class="numeric">0.028</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e3f5fd</code></td>
        <td>{{ swatch('#e3f5fd') }}</td>
        <td><code>color(display .875 .945 .976)</code></td>
        <td class="numeric">1.918</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e74832</code></td>
        <td>{{ swatch('#e74832') }}</td>
        <td><code>color(display .905882353 .282352941 .196078431 / 1 )</code></td>
        <td class="numeric">3.681</td>
        <td>true</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption='Esta tabela mostra as cores sRGB substitutas e, em seguida, as cores em display-p3. Uma diferença de cor (ΔE2000) de 1 praticamente não é visível, enquanto 5 é claramente distinto. Esta é uma tabela de resumo (<a hreflang="en" href="https://docs.google.com/spreadsheets/d/1sMWXWjMujqfAREYxNbG_t1fOJKYCA6ASLwtz4pBQVTw/#gid=264429000"> confira a tabela completa </a>).',
      sheets_gid="1370141402"
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  image="p3-chromaticity-big.svg",
  iframe="p3-chromaticity-big.svg",
  caption="Cromaticidade uv especificada de cores p3 de exibição e seus fallbacks.",
  description="Este diagrama u'v' de 1976 mostra a cromaticidade das cores (achatadas em 2D, portanto a luminosidade não é mostrada). A forma curva externa representa o espectro de comprimentos de onda simples e puros; não há cores visíveis fora disso. A linha reta é roxa, uma mistura de vermelho e violeta. O triângulo menor e cinza é a gama sRGB, enquanto o triângulo maior e mais escuro é a gama display-p3. São mostradas as 23 cores de display-p3 exclusivas realmente em uso na web em 2020; para cada par de cores, o círculo maior é o fallback em sRGB, enquanto o círculo menor é a cor display-p3. Se estiver dentro da gama sRGB, esses círculos mostram a cor correta. Caso contrário, um círculo branco com uma borda vermelha indica cores fora da gama sRGB.",
  width=600,
  height=600
) }}

As cores roxas são semelhantes em sRGB e display-p3, talvez porque ambos os espaços de cores tenham o mesmo azul primário. Vários vermelhos, amarelos-alaranjados e verdes estão próximos do limite de gama sRGB (quase tão saturados quanto possível) e mapeados para pontos análogos próximos ao limite da gama display-p3.

Parece haver duas razões pelas quais a web ainda está presa na terra do sRGB. A primeira é a falta de ferramentas, falta de bons seletores de cores, falta de compreensão de quais cores mais vivas estão disponíveis. Mas a principal razão, pensamos, é que até o momento o Safari é o único navegador a implementá-lo. Isso está mudando rapidamente - o Chrome e o Firefox estão implementando agora - mas até que o suporte seja bom, provavelmente usar display-p3 é muito esforço para pouco ganho porque <a hreflang="en" href="https://gs.statcounter.com/browser-market-share">apenas 17% dos usuários</a> verão essas cores. A maioria das pessoas verá o fallback. Portanto, o uso atual é uma mudança sutil na vibração das cores, ao invés de uma grande diferença.

Será interessante ver como o uso do formato de cor display-p3 (existem outras opções, mas esta é a única que encontramos na web) muda nos próximos um ou dois anos.

A *wide color gamut* (WCG) é apenas o começo. A indústria de TV e cinema já passou do P3 para uma gama ainda mais ampla, [*Rec. 2020*](https://en.wikipedia.org/wiki/Rec._2020); e também uma gama mais ampla de luminosidade, de reflexos ofuscantes a sombras mais profundas. *High Dynamic Range* (HDR) já chegou nas casas, especialmente em jogos, streaming de TV e filmes. A web tem muito que se atualizar.

## Gradientes

Apesar do minimalismo e design flat estarem na moda, os gradientes CSS são usados ​​em 75% das páginas. Como esperado, quase todos os gradientes são usados ​​em backgrounds. 74,45% das páginas especificam gradientes em backgrounds, mas apenas 7% em qualquer outra propriedade.

Os gradientes lineares são 5 vezes mais populares do que os radiais, aparecendo em quase 73% das páginas, em comparação com 15% dos gradientes radiais. A diferença de popularidade é tão impressionante que mesmo `-ms-linear-gradient()`, que nunca foi necessário (gradientes compatíveis com Internet Explorer 10 com e sem o prefixo `-ms-`), é mais popular do que `radial-gradient()`! O <a hreflang="en" href="https://caniuse.com/css-conic-gradients">recém-suportado</a> `conic-gradient()` é ainda mais subutilizado, aparecendo em apenas 652 páginas para desktop (0,01%) e 848 páginas para dispositivos móveis (0,01%), o que é esperado, uma vez que o Firefox acaba de enviar sua implementação para o canal estável.

Gradientes repetitivos de todos os tipos também são bastante subutilizados, com `repeating-linear-gradient()` aparecendo em apenas 3% das páginas e os outros ficando ainda mais atrás (`repeating-conic-gradient()` é usado apenas em 21 páginas!).

Gradientes prefixados ainda são muito comuns também, embora prefixos não sejam mais necessários em gradientes desde 2013. É notável que -webkit-gradient() ainda seja usado em metade de todos os sites, embora <a hreflang="en" href="https://caniuse.com/css-gradients">não seja necessário desde 2011</a>. E `-webkit-linear-gradient()` ainda é a segunda função gradiente mais usada de todas, aparecendo em 57% dos sites, com as outras formas prefixadas também sendo usadas em um terço da metade das páginas.

{{ figure_markup(
  image="gradient-functions.png",
  caption="As funções de gradiente mais populares pela porcentagem de páginas.",
  description="Gráfico de barras mostrando as funções de gradiente mais populares pela porcentagem de páginas desktop e celular. As funções de gradiente tendem a ser mais populares em páginas para celular. A função de gradiente mais popular é `linear-gradient`, usada em 73% das páginas para celular. Seguido por `-webkit-linear-gradient` em 57%,`-webkit-gradient` e `-linear-gradient` em 50%, `-moz-linear-gradient` em 49%, `-ms-linear-gradient` em 33%, `radial-gradient` em 15%, `-webkit-radial-gradient` em 9% e `repeating-linear-gradient` e `-moz-radial-gradient` usado em 3% das páginas para celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1552177796&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

{{ figure_markup(
  image="gradient-functions-unprefixed.png",
  caption="As funções de gradiente mais populares pela porcentagem de páginas, omitindo prefixos do navegador.",
  description="Gráfico de barras mostrando as funções de gradiente mais populares pela porcentagem de páginas desktop e celular, omitindo prefixos do navegador. A adoção nos desktops está ligeiramente atrás dos dispositivos móveis. Variações de `linear-gradient` são usadas em 72,57% das páginas para celular, `radial-gradient` em 15,13%, `repeating-linear-gradient` em 2,99%, `repeating-radial-gradient` em 0,07%, `conic-gradient` em 0,01% e `repeating-conic-gradient` em aproximadamente 0,00% das páginas para celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1676879657&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

Usar paradas (stops) de cor com cores diferentes na mesma posição (paradas rígidas - hard stops) para criar listras e outros padrões é a primeira técnica <a hreflang="en" href="https://lea.verou.me/2010/12/checkered-stripes-other-background-patterns-with-css3-gradients/">popularizada pela Lea Verou em 2010</a>, que agora tem muitas variações interessantes, incluindo <a hreflang="en" href="https://bennettfeely.com/gradients/">algumas muito legais com modos de mesclagem</a>. Embora possa parecer um hack, paradas rígidas são encontradas em 50% das páginas, indicando uma forte necessidade do desenvolvedor por gráficos leves dentro do CSS sem recorrer a editores de imagem ou SVG externos.

Dicas de interpolação (interpolation hints) (ou como a Adobe, que popularizou a técnica, as chama de: "midpoints") são encontradas em apenas 22% das páginas, apesar do <a hreflang="en" href="https://caniuse.com/mdn-css_types_image_gradient_linear-gradient_interpolation_hints">suporte quase universal para navegadores desde 2015</a>. O que é uma pena, porque sem eles, as paradas de cor são conectadas por linhas retas no espaço de cores, em vez de curvas suaves. Esse baixo uso provavelmente reflete um mal-entendido sobre o que eles fazem ou como usá-los; compare isso com as transições e animações CSS, onde as funções de atenuação (que fazem praticamente a mesma coisa, ou seja, conectam os quadros-chave com curvas em vez de linhas retas irregulares) são muito mais comumente usadas ([80% das transições](#transições-e-animações)). "Midpoints" não é uma descrição muito compreensível e "interpolation hint" parece que você está ajudando o navegador a fazer cálculos aritméticos simples.

A maior parte do uso de gradiente é bastante simples, com mais de 75% dos gradientes encontrados em todo o conjunto de dados usando apenas 2 paradas de cor. Na verdade, menos da metade das páginas contém até mesmo um único gradiente com mais de 3 paradas de cor!

O gradiente com mais paradas de cor é <a hreflang="en" href="https://dabblet.com/gist/4d1637d78c71ef2d8d37952fc6e90ff5">este com 646 paradas</a>! Tão lindo! Isso quase certamente é gerado e o código CSS resultante é de 8 KB, então um PNG de 1px de altura provavelmente teria feito o trabalho também, com uma pegada menor (nossa imagem abaixo tem 1,1 KB).

{{ figure_markup(
  image="gradient-most-stops.png",
  classes="height-16vw-122px",
  caption="O gradiente com mais paradas de cor, 646.",
  description="Uma captura de tela do gradiente com mais interrupções de cor, que é uma série de listras multicoloridas intrincadas de tons variados.",
  width=600,
  height=122
) }}

## Layout

O CSS agora tem várias opções de layout - muito longe das tabelas quando elas tinham que ser usadas para layouts. Os layouts Flexbox, Grid e Múltiplas colunas agora são bem suportados na maioria dos navegadores, então vamos ver como eles estão sendo usados.

### Adoção do Flexbox e Grid

Na [edição de 2019](../2019/css#flexbox), 41% das páginas no celular e desktop foram relatados como contendo [Flexbox](https://developer.mozilla.org/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox). Em 2020, esse número cresceu para 63% para celular e 65% para desktop. Com o número de sites legados desenvolvidos antes que o Flexbox fosse uma ferramenta viável ainda existente, podemos dizer com segurança que há uma ampla adoção desse método de layout.

Se olharmos para [Grid layout](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout), a porcentagem de sites que usam Grid layout cresceu para 4% para celular e 5% para desktop. O uso dobrou desde o ano passado, mas ainda está muito atrás do flex layout.

{{ figure_markup(
  image="flexbox-grid-mobile.png",
  caption="Adoção do Flexbox e Grid por ano pela porcentagem de páginas para celular.",
  description="Gráfico de barras mostrando a adoção de Flexbox e Grid por ano pela porcentagem de páginas para celular. A adoção do Flexbox cresceu de 2019 a 2020 de 41% para 63% das páginas para celular. A adoção do Grid cresceu de 2% para 4% no mesmo período.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1879364309&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

{{ figure_markup(
  image="flexbox-grid-desktop.png",
  caption="Adoção de Flexbox e Grid por ano pela porcentagem de páginas desktop.",
  description="Gráfico de barras mostrando a adoção do Flexbox e Grid por ano pela porcentagem de páginas desktop. A adoção do Flexbox cresceu de 2019 a 2020 de 41% para 65% das páginas para celular. A adoção do Grid cresceu de 2% para 5% no mesmo período.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1140202160&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

Observe que, ao contrário da maioria das outras métricas neste capítulo, este é o uso real do Grid layout, e não apenas propriedades e valores relacionados ao Grid que são especificados em uma folha de estilo e potencialmente não usados. Embora à primeira vista isso possa parecer mais preciso, deve-se ter em mente que o HTTP Archive rastreia páginas iniciais, portanto, esses dados podem ser distorcidos devido a grids que apareçam mais em páginas internas.

Então, vamos examinar também outra métrica: quantas páginas especificam `display: grid` e `display: flex` em suas folhas de estilo? Essa métrica coloca o Grid layout em uma adoção significativamente maior, com 30% das páginas usando `display: grid` pelo menos uma vez. No entanto, isso não afeta o número do Flexbox de maneira significativa, com 68% das páginas especificando `display: flex`. Embora isso soe como uma adoção impressionantemente alta do Flexbox, é importante notar que as CSS tables ainda são muito mais populares, com 80% das páginas usando display table! Parte desse uso pode ser devido a <a hreflang="en" href="https://css-tricks.com/snippets/css/clear-fix/">certos tipos de clearfix</a> que usam `display: table`, e não para o layout real.

{{ figure_markup(
  image="layout-methods.png",
  caption="Modos de layout e porcentagem de páginas em que aparecem. Esses dados são uma combinação de certos valores das propriedades `display`, `position` e `float`.",
  description="Gráfico de barras mostrando a adoção de métodos de layout pela porcentagem de páginas de desktop e celular. Os resultados em desktop e para celular são semelhantes, a menos que indicado de outra forma. Os quatro principais métodos de layout são block, absolute, floats e inline-block com adoção de 92%, 92%, 91% e 90%, respectivamente. Em seguida, inline, fixed, e css tables têm 81%, 80% e 80% de adoção, respectivamente. Flex tem 68% de adoção, seguido por box com 46% e distintamente maior que a adoção de desktop em 38%, inline-flex com 33%, grid com 30%, list-item com 26%, inline-table com 26%, inline-box com 20% e sticky com 13% das páginas para celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013998073&format=interactive",
  width="600",
  height="588",
  sheets_gid="335708969",
  sql_file="layout_properties.sql"
) }}

Dado que o Flexbox estava disponível em navegadores antes do Grid layout, é provável que parte do uso do Flexbox seja para configurar um sistema de grids. Para usar o Flexbox como grid, os autores precisam desabilitar parte da flexibilidade inerente do Flexbox. Para fazer isso, defina a propriedade `flex-grow` como `0` e dimensione os itens flex usando porcentagens. Usando essas informações, pudemos relatar que 19% dos sites tanto no desktop quanto no celular usavam o Flexbox em um formato de grid.

As razões para escolher Flexbox em vez de Grid são frequentemente citadas como suporte dos navegadores, visto que o Grid layout <a hreflang="en" href="https://caniuse.com/css-grid">não era suportado pelo Internet Explorer</a>. Além disso, alguns desenvolvedores podem não ter aprendido o Grid layout ainda ou estarem usando uma estrutura com um sistema de grids baseado em Flexbox. O framework <a hreflang="en" href="https://getbootstrap.com/docs/4.5/layout/grid/">Bootstrap</a> atualmente usa um grid baseado em Flexbox, assim como várias outras opções de frameworks populares.

### Uso das diferentes técnicas de Grid layout

A especificação do Grid layout oferece várias maneiras de descrever e definir um layout em CSS. O uso mais básico envolve <a hreflang="en" href="https://www.smashingmagazine.com/2020/01/understanding-css-grid-lines/">arrajar os items em linha</a>. E com relação [nomeação de linhas](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout/Layout_using_Named_Grid_Lines), ou uso de `grid-template-areas`?

Para linhas nomeadas, verificamos a presença de colchetes em uma track listing. O nome ou nomes sendo colocados entre colchetes.

```css
.wrapper {
  display: grid;
  grid-template-columns: [main-start] 1fr [content-start] 1fr [content-end] 1fr [main-end];
}
```

O resultado disso mostrou que 0,23% das páginas que usam o Grid no celular tinham linhas nomeadas e 0,27% no desktop.

O recurso de [Grid template areas](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout/Grid_Template_Areas), que permite aos desenvolvedores nomeares itens de grid e colocá-los na grid com o valor de propriedade `grid-template-areas`, se saiu um pouco melhor. Dos sites que usam Grid, 19% no celular e 20% no desktop usavam esse método.

Esses resultados mostram que não só o uso do Grid layout ainda é relativamente baixo em sites de produção, mas também é relativamente simples. Os desenvolvedores estão optando por usar a simples colocação baseada em linha em vez de métodos que lhes permitiriam nomear linhas e áreas. Embora não haja nada de errado em escolher fazer isso, eu me pergunto se a adoção lenta do Grid se deve parcialmente ao fato de que os desenvolvedores ainda não perceberam o poder desses recursos. Se o Grid for visto como essencialmente Flexbox com um pobre suporte a navegador, isso certamente o tornaria uma escolha menos atraente.

### Layout multi-coluna

A especificação de [layout multi-coluna](https://developer.mozilla.org/docs/Web/CSS/CSS_Columns/Basic_Concepts_of_Multicol), ou *multicol*, possibilita o layout de conteúdo em colunas, assim como em um jornal. Embora seja popular em CSS para impressão, é menos útil na web devido ao risco de criar uma situação em que o leitor precise rolar para cima e para baixo para ler o conteúdo. Com base nos dados, no entanto, há significativamente mais páginas usando multicol do que o Grid layout, com 15,33% no desktop e 14,95% no celular. Enquanto as propriedades multicol básicas são bem suportadas, o uso mais complexo e o controle de quebras de coluna com <a hreflang="en" href="https://www.smashingmagazine.com/2019/02/css-fragmentation/">fragmentation</a> tem <a hreflang="en" href="https://caniuse.com/multicolum">suporte baixo</a>. Considerando isso, foi bastante surpreendente ver o quanto é usado.

### Box sizing

É útil saber o quão grande serão as caixas em sua página, mas com o [modelo padrão de box model do CSS](https://developer.mozilla.org/docs/Learn/CSS/Building_blocks/The_box_model#What_is_the_CSS_box_model) adicionando padding e border no tamanho da caixa de conteúdo, o tamanho que você deu à sua caixa é menor do que a caixa renderizada em sua página. Embora não possamos mudar o passado, a propriedade `box-sizing` permite que os desenvolvedores mudem para aplicar o tamanho especificado para o `border-box`, então o tamanho que você definir será o tamanho que você vê renderizado. Quantos sites estão usando a propriedade `box-sizing`? A maioria! A propriedade `box-sizing` aparece em 83,79% do CSS para desktop e 86,39% no celular.

{{ figure_markup(
  image="box-sizing.png",
  caption="Distribuição do número de declarações `border-box` por página.",
  description="Gráfico de barras mostrando a distribuição do número de declarações `border-box` por página para desktop e celular. A distribuição no celular lidera a de desktop em 0 a 11 declarações por página, crescendo nos percentis mais altos. Os percentis 10, 25, 50, 75 e 90 da distribuição no celular são: 0, 4, 17, 46 e 96 declarações 'border-box' por página.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1626960751&format=interactive",
  sheets_gid="1982524793",
  sql_file="box_sizing.sql"
) }}

A página de desktop mediana tem 14 declarações de `box-sizing`. A no celular tem 17. Talvez devido aos sistemas de componentes que inserem a declaração por componente, ao invés de globalmente como uma regra para todos os elementos na folha de estilo.

## Transições e animações

Em geral, as transições e animações se tornaram muito populares, com a propriedade `transition` sendo usada em 81% de todas as páginas e `animation` em 73% das páginas celular e 70% das páginas desktop. É um tanto surpreendente que o uso não seja menor no celular, onde seria de se esperar que <a hreflang="en" href="https://css-tricks.com/how-web-content-can-affect-power-usage/">conservar a energia da bateria</a> seja uma prioridade. Por outro lado, as animações CSS são muito mais eficientes em termos de bateria do que as animações em JS, especialmente a maioria delas que apenas animam transformações e opacidade (confira a próxima seção).

A única propriedade de transição mais comum especificada é `all`, usada em 41% das páginas. Isso é um pouco confuso porque `all` é o valor inicial, portanto, não precisa ser especificado explicitamente. Depois disso, as transições fade in/out parecem ser o tipo mais comum, usado em mais de um terço das páginas rastreadas, seguidas por transições na propriedade `transform` (provavelmente rotação, escala, transições de movimento). Surpreendentemente, a transição de `height` é muito mais popular do que a transição de `max-height`, embora a última seja uma solução alternativa comumente ensinada quando a altura inicial ou final é desconhecida (automática). Também foi surpreendente ver o uso significativo da propriedade `scale` (2%), apesar de sua falta de suporte além do Firefox. Uso intencional de CSS de ponta, um erro de digitação ou um mal-entendido sobre como animar transformações?

{{ figure_markup(
  image="transition-properties.png",
  caption="Adoção de propriedades de transição pela porcentagem das páginas.",
  description="Gráfico de barras mostrando a adoção das propriedades de transição mais populares. As páginas para desktop e celular são muito semelhantes, exceto que o filtro não parece ser usado de forma significativa no desktop. A propriedade de transição mais popular em páginas para celular é `all`, usada em 41% das páginas, seguida por `opacity` em 37%, `transform` em 26%, `color` em 17%, `none` em 15%, `height` em 13%, `background-color` em 12%, `background` em 10%, `filter` em 7% e as propriedades restantes usadas em 6% das páginas para celular: `width`, `left`, `top`, `-webkit-transform`, `box-shadow` e `border-color`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1677028861&format=interactive",
  sheets_gid="134272305",
  sql_file="transition_properties.sql"
) }}

Ficamos felizes em descobrir que a maioria dessas transições são bastante curtas, com a duração média de transição sendo de apenas 300ms, e 90% dos sites com durações médias de menos de meio segundo. Em geral, essa é uma boa prática, pois transições mais longas podem deixar a IU lenta, enquanto uma transição curta comunica uma mudança sem atrapalhar.

{{ figure_markup(
  image="transition-durations.png",
  caption="Distribuição da duração das transições.",
  description="Gráfico de barras mostrando a distribuição das durações de transição em milissegundos para páginas desktop e celular. Desktop e celular são equivalentes nos percentis 10, 25 e 90 com durações de 100, 150 e 500ms, respectivamente. No entanto, na mediana e no 75º percentil, o desktop tem durações maiores em 50ms: 300 e 400ms, respectivamente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1587838983&format=interactive",
  sheets_gid="286912288",
  sql_file="transition_durations.sql"
) }}

Os autores da especificação acertaram! `Ease` é a função de temporização mais popular especificada, embora seja o padrão, portanto, pode ser omitida. Talvez as pessoas especifiquem explicitamente os padrões porque preferem o detalhamento autodocumentado ou - talvez mais provavelmente - porque não sabem que são padrões. Apesar das desvantagens da animação de progresso linear (tende a parecer monótona e não natural), `linear` é a segunda função de tempo mais usada com 19,1%. Também é interessante que as funções de atenuação integradas acomodam mais de 87% de todas as transições: apenas 12,7% escolheram especificar uma atenuação personalizada por meio de `cubic-bezier()`.

{{ figure_markup(
  image="transition-timing-functions.png",
  caption="Popularidade relativa das funções de tempo pela porcentagem de ocorrências em páginas para celular.",
  description="Gráfico de pizza mostrando a popularidade relativa das funções de tempo pela porcentagem de ocorrências em páginas para celular. A mais popular função é `ease` em 31% das ocorrências, seguida por `linear` em 19%, `ease-in-out` em 19%, `cubic-bezier` em 13%, `ease-out` em 9%, `steps` em 5%, e `ease-in` em 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=63879013&format=interactive",
  sheets_gid="1514240349",
  sql_file="transition_timing_functions.sql"
) }}

Um grande impulsionador da adoção da animação parece ser o Font Awesome, como evidenciado pelo nome da animação `fa-spin` aparecendo em uma de quatro páginas e, portanto, no topo da lista dos nomes de animação mais populares. Embora haja uma grande variedade de nomes de animação, parece que a maioria deles se enquadra em apenas algumas categorias básicas, com uma em cada cinco animações sendo algum tipo de rotação. Isso também pode explicar a alta porcentagem de transições e animações que progridem linearmente: se quisermos uma rotação perpétua suave, `linear` é o caminho a se seguir.

{{ figure_markup(
  image="transition-animation-names.png",
  caption="Popularidade relativa das categorias de nomes de animação pela porcentagem de ocorrências.",
  description="Gráfico de barras mostrando a popularidade relativa das categorias de nomes de animação pela porcentagem de ocorrências. A categoria mais popular é `rotate`, que aparece em 21% das ocorrências em páginas para celular, seguida por unknown/other com 13%, `fade` com 9%, `bounce` com 7%, `scale` com 6%, `wobble` e `slide` com 5%, `pulse` com 2%, e o restante com 1%: `visibility`, `flip`, e `move`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=709747830&format=interactive",
  sheets_gid="1998209374",
  sql_file="transition_animation_names.sql"
) }}

## Efeitos visuais

CSS também oferece uma grande variedade de efeitos visuais, dando aos designers acesso a técnicas de design avançadas incorporadas aos navegadores que podem ser acessados ​​com pequenas quantidades de código.

### Blend modes

No ano passado, 8% das páginas usavam blend modes. Este ano, a adoção aumentou significativamente, com 13% das páginas usando blend modes em elementos (`mix-blend-mode`) e 2% em fundos (`background-blend-mode`).

### Filtros

A adoção de filtros permaneceu alta, com a propriedade `filter` aparecendo em 79,43% das páginas. Embora no início isso tenha sido bastante empolgante, muito provavelmente é devido aos antigos filtros do IE DX (`-ms-filter`), que compartilhavam o mesmo nome de propriedade. Quando levamos em consideração apenas filtros CSS válidos que o Blink reconhece, o uso cai para 22% para celular e 20% para desktop, com `blur()` sendo o tipo de filtro mais popular, aparecendo em 4% das páginas.

Outra propriedade de filtro, `backdrop-filter`, nos permite aplicar filtros apenas a área atrás de um elemento, o que é incrivelmente útil para melhorar o contraste em fundos translúcidos e criar o elegante <a hreflang="en" href="https://css-tricks.com/backdrop-filter-effect-with-css/">efeito "frosted glass" (vidro fosco)</a> que conhecemos de muitas interfaces de usuário nativas. Embora não seja tão popular quanto `filter`, encontramos `backdrop-filter` em 6% das páginas.

A função `filter()` nos permite aplicar um filtro apenas em uma imagem particular, o que pode ser extremamente útil para fundos. Infelizmente, ele é <a hreflang="en" href="https://caniuse.com/css-filter-function">atualmente compatível apenas com Safari</a>. Não encontramos nenhum uso de `filter()`.

### Máscaras

Uma década atrás, tínhamos máscaras no Safari com `-webkit-mask-image` e era emocionante. Todo mundo estava usando. Por fim, obtivemos <a hreflang="en" href="https://www.w3.org/TR/css-masking-1/">uma especificação</a> e um conjunto de propriedades não prefixadas modeladas de perto após o protótipo do WebKit, e parecia uma questão de tempo até que masking se tornasse o padrão, com uma sintaxe consistente em todos os navegadores. Avance 10 anos depois, e a sintaxe sem prefixo <a hreflang="en" href="https://caniuse.com/css-masks">ainda não é suportada no Chrome ou Safari, o que significa que está disponível em menos de 5% dos navegadores dos usuários em todo o mundo</a>. Portanto, não é surpresa que `-webkit-mask-image` ainda seja mais popular do que sua contraparte padrão, sendo encontrada em 22% das páginas. No entanto, apesar de seu suporte muito pobre, `mask-image` é encontrado em 19% das páginas. Vemos um padrão semelhante na maioria das outras propriedades de masking com as versões não prefixadas aparecendo em quase tantas páginas quanto as do `-webkit-`. No geral, apesar de terem saído do hype, máscaras ainda são encontradas em quase um quarto da web, indicando que os casos de uso ainda estão lá, apesar da falta de interesse do implementador (dica, dica!).

{{ figure_markup(
  image="mask-properties.png",
  caption="Popularidade relativa das propriedades de máscaras pela porcentagem de ocorrências.",
  description="Popularidade relativa das propriedades da máscara pela porcentagem das ocorrências. `-webkit-mask-image` é usado em 22% das páginas para celular, contra 19% no desktop. As seguintes propriedades são `mask-size` e `mask-image` em 19%, `mask-repeat`, `mask-position`, `mask-mode` e `-webkit-mask-size` em 18%, `-webkit-mask-repeat` e `-webkit-mask-position` em 16% e as propriedades `-webkit-mask` e `mask` em 2% das páginas para celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=615866471&format=interactive",
  width="600",
  height="575",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

### Clipping paths

Na mesma época que as máscaras se tornaram populares, outra propriedade semelhante, mas mais simples (originalmente do SVG), começou a circular: `clip-path`. No entanto, ao contrário das máscaras, teve um destino mais brilhante. Ele foi padronizado com bastante rapidez e obteve suporte em todos os navegadores relativamente rápido, com o último obstáculo sendo o Safari, que abandonou o prefixo em 2016. Hoje, ele é encontrado em 19% das páginas sem prefixo e 13% com o prefixo `-webkit-`.

## Design Responsivo

Criar sites que lidam com os diversos tamanhos de tela e dispositivos que navegam na web se tornou um pouco mais fácil com os novos métodos de layout integrados, flexíveis e responsivos, como Flexbox e Grid. Esses métodos de layout geralmente são aprimorados com o uso de media queries. Os dados mostram que 80% dos sites para desktop e 83% dos sites para elular usam media queries associadas com design responsivo, como `min-width`.

### Quais recursos de mídia as pessoas estão usando?

Como você pode esperar, os recursos de mídia mais comuns em uso são os recursos de tamanho da janela de visualização (viewport size), que estão em uso desde o início no design responsivo. A porcentagem de sites verificando `max-width` é de 78% para desktop e celular. Uma verificação dos recursos `min-width` em 75% dos sites para celular e 73% dos sites para desktop.

O recurso de mídia `orientation`, que permite aos autores diferenciar seu layout com base no fato de a tela estar em formato retrato ou paisagem, pode ser encontrado em 33% de todos os sites.

Estamos vendo alguns recursos de mídia mais novos surgindo nas estatísticas. O recurso de mídia <a hreflang="pt" href="https://web.dev/i18n/pt/prefers-reduced-motion/">`prefers-reduced-motion`</a> fornece uma maneira de verificar se o usuário solicitou movimento reduzido, para que os sites possam ajustar a quantidade de animação eles usam. Isso pode ser ativado explicitamente, por meio de uma configuração do sistema operacional controlado pelo usuário, ou implicitamente, por exemplo, devido à redução do nível da bateria. 24% dos sites estão verificando esse recurso.

Outras boas notícias, os recursos mais recentes da especificação <a hreflang="en" href="https://www.w3.org/TR/mediaqueries-4/">Media Queries Level 4</a> estão começando a aparecer. No celular, 5% dos sites verificam o tipo de ponteiro que o usuário possui. Um ponteiro `coarse` indica que eles estão usando uma tela sensível ao toque, enquanto um ponteiro `fine` indica um dispositivo apontador. Compreender a forma como um usuário está interagindo com seu site é tão útil, se não mais útil, do que observar o tamanho da tela. Uma pessoa pode estar usando um dispositivo de tela pequena com teclado e mouse, ou um dispositivo de tela grande de alta resolução com tela sensível ao toque e se beneficiar de áreas de impacto maiores.

{{ figure_markup(
  image="media-query-features.png",
  caption="Os recursos de media query mais populares pela porcentagem de páginas.",
  description="Gráfico de barras mostrando os recursos de media query mais populares pela porcentagem de páginas. Desktop e celular são geralmente semelhantes, a menos que seja especificado de outra forma. O recurso de media query mais popular em páginas para celular é `max-width` em 79%, seguido por `min-width` em 75%, `-webkit-min-device-pixel-ratio` em 45% (acima do desktop com 39%), orientation em 33%, `max-device-width` em 28%, `-ms-high-contrast` em 24% (a partir do desktop em 15%), `prefere-reduzido-motion` em 24% , `max-height` e `min-resolution` a 22%, `-webkit-transform-3d`, `transform-3d` e `min-device-pixel-ratio` todos a 15%, `min-height` usado em 14% das páginas para celular, mas apenas 3% das páginas para desktop, `-o-min-device-pixel-ratio` em 8%, `ponteiro` em 5% e, finalmente, `device-width` em 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1998463556&format=interactive",
  sheets_gid="1374950017",
  width="600",
  height="600",
  sql_file="media_query_features.sql"
) }}

### Breakpoints comuns

O breakpoint mais comum em uso em dispositivos móveis e desktop é o `min-width` de 768px. 54% dos sites usam esse breakpoint, seguido de perto por um `max-width` de 767px com 50%. <a hreflang="en" href="https://getbootstrap.com/docs/4.1/layout/overview/">O Bootstrap framework</a> usa um `min-width` de 768px como seu tamanho "Médio", então esta pode ser a fonte de grande parte do uso. Os outros dois valores de `min-width` com alta classificação, de 1200px (40%) e 992px (37%), também são encontrados no Bootstrap.

{{ figure_markup(
  image="breakpoints.png",
  caption="Os breakpoints para `min-width` e `max-width` mais populares pela porcentagem de páginas.",
  description="Os breakpoints para min-width e max-width mais populares pela porcentagem de páginas. `480px` é usado como min-width em 21% das páginas para celular e como `max-width` em 35%. `600px` em 27% e 37% para min e max widths respectivamente, `767px` e 8% e 50%, `768px` e 54% e 35%, `800px` em 8% e 24%, `991px` em 3% e 30%, `992px` em 37% e 11%, `1024px` em 13% e 23%, `1199px` em apenas 31% como `max-width`, e `1200px` em 40% e 19%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=502128948&format=interactive",
  sheets_gid="1070028321",
  sql_file="media_query_values.sql"
) }}

Pixels são basicamente a unidade usada para breakpoints. Existem algumas ocorrências de `em`s bem abaixo na lista, no entanto, definir breakpoints em pixels parece ser a escolha popular. Provavelmente, existem muitas razões para isso. Legado: todos os primeiros artigos sobre design responsivo usam pixels, e muitas pessoas ainda pensam em visar dispositivos específicos ao criar designs responsivos. Dimensionamento: <a hreflang="en" href="https://zellwk.com/blog/media-query-units/">usar `em`s</a> envolve considerar o tamanho do conteúdo em vez do dispositivo, e esta é uma maneira mais nova de pensar sobre design responsivo, talvez ainda a ser totalmente aproveitado junto com métodos de dimensionamento intrínsecos ao layout.

### Propriedades usadas dentro de media queries

Em 79% dos dispositivos móveis e no 77% desktop as media queries são usadas para alterar a propriedade `display`. Talvez indicando que as pessoas estão testando antes de mudar para um contexto de formatação Flex ou Grid. Novamente, podem ser estruturas vinculadas, por exemplo, os <a hreflang="en" href="https://getbootstrap.com/docs/4.1/utilities/display/">utilitários de responsividade do Bootstrap</a>. 78% dos autores alteram a propriedade `width` dentro das media queries, `margin`, `padding` e `font-size`, todos têm alta classificação para propriedades alteradas.

{{ figure_markup(
  image="media-query-properties.png",
  caption="As propriedades mais populares usadas em media queries pela porcetagem de páginas.",
  description="Gráfico de barras das propriedades mais populares usadas em media queries pela porcetagem de páginas. Desktop e celular são muito similares. O range de porcentagem das páginas para celular vão de 79% a 71% para `display`, `width`, `margin-left`, `padding`, `font-size`, `height`, `margin`, `margin-right`, `margin-top`, e `position`, nesta ordem.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1199544976&format=interactive",
  sheets_gid="190367365",
  sql_file="media_query_properties.sql"
) }}

## Propriedades customizadas

No ano passado, apenas 5% dos sites estavam usando propriedades customizadas. Este ano, a adoção disparou. Usando a consulta do ano passado (que contou apenas declarações que definem propriedades customizadas), o uso quadruplicou no celular (19,29%) e triplicou no desktop (14,47%). No entanto, quando olhamos para os valores que fazem referência às propriedades customizadas via `var()`, temos uma visão ainda melhor: 27% das páginas para celular e 22% das páginas de desktop usavam a função `var()` pelo menos uma vez, o que indica que há um número considerável de páginas usando apenas `var()` para oferecer ganchos de personalização, sem nunca definir uma propriedade customizada.

Embora à primeira vista esta seja uma adoção impressionante, parece que um dos principais impulsionadores é o WordPress, como evidenciado pelos nomes de propriedades customizadas mais populares, os 4 principais dos quais vêm com o WordPress.

### Nomeando

{{ figure_markup(
  image="custom-property-names.png",
  caption="Popularidade relativa dos nomes das propriedades customizadas pela porcentagem de ocorrências em páginas para celular.",
  description="Gráfico de pizza da popularidade relativa de nomes de propriedades customizadas por entidade de software responsável por criar essas propriedades, como um percentual de ocorrências em páginas para celular. 35% das ocorrências de nomes de propriedades customizadas em páginas para celular podem ser rastreadas até Avada, 31% para Bootstrap, 16% para Elementor, 13% para WordPress e 3% para uma versão antiga do Multirange.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1627287194&format=interactive",
  sheets_gid="1043074687",
  sql_file="custom_property_names.sql"
) }}

Dos 1.000 principais nomes de propriedades, menos de 13 são "customizados", como compostos por desenvolvedores individuais da web. A grande maioria está associada a softwares populares, como WordPress, Elementor e Avada. Para determinar isso, levamos em consideração não apenas quais propriedades customizadas aparecem em qual software (pesquisando no GitHub), mas também quais propriedades aparecem em grupos com frequências semelhantes. Isso não significa necessariamente que a principal maneira pela qual uma propriedade customizada acaba em um site é por meio do uso desse software (as pessoas ainda copiam e colam!), Mas indica que não há muitas semelhanças orgânicas entre as propriedades customizadas que os desenvolvedores definem. Os únicos nomes de propriedades customizadas que parecem ter feito organicamente na lista dos 1000 principais são `--height`, `--primary-color` e `--caption-color`.

### Uso por tipo

O maior uso das propriedades personalizadas parece ser a nomeação de cores e a manutenção de cores consistentes. Aproximadamente 1 em cada 5 páginas para desktop e 1 em cada 6 páginas para celular usam propriedades customizadas em `background-color`, e as 11 principais propriedades que contêm referências a função `var()` são propriedades de cores ou abreviações que contêm cores. Comprimentos é o segundo maior uso, com `width` e `height` sendo usados ​​com `var()` em 7% das páginas para celular (curiosamente, apenas cerca de 3% das páginas para desktop). Isso também é confirmado pelos tipos de valores mais populares, com os valores de cores representando 52% de todas as declarações de propriedades personalizadas. Dimensões (um número + uma unidade, por exemplo, comprimentos, ângulos, tempos, etc.) foram o segundo tipo mais popular, maiores do que os números sem unidade (12%). Apesar da orientação para preferir o último, já que os números podem ser convertidos em dimensões por meio de `calc()` e multiplicação, mas as dimensões não podem ser convertidas em números, pois a divisão pelas dimensões ainda não é suportada.

{{ figure_markup(
  image="custom-property-properties.png",
  caption="Os nomes de propriedades mais populares usadas com propriedades customizadas pela porcentagem de páginas.",
  description="Gráfico de barras dos nomes de propriedades mais populares usadas com propriedades customizadas, pela porcentagem de páginas. A adoção em dispositivos móveis é muito maior para cada propriedade do que suas contrapartes em desktop. As propriedades customizadas são usadas em `background-color` e `color` em 19% e 15% das páginas para celular, respectivamente. As propriedades restantes usam propriedades customizadas de 9% a 6% em ordem decrescente: `border`, `background`, `border-top`, `border-bottom`, `background-image`, `box-shadow`, `height`, `width`, `border-left`, `min-height`, `margin-top`, `border-right` e `border-left-color`. A adoção em desktops é cerca de 4 pontos percentuais menor.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=16420165&format=interactive",
  sheets_gid="556945658",
  sql_file="custom_property_properties.sql"
) }}

Em pré-processadores, as variáveis ​​de cores são freqüentemente manipuladas para gerar variações de cores, como tons diferentes. No entanto, <a hreflang="en" href="https://drafts.csswg.org/css-color-5/">funções de modificação de cor no CSS</a> são apenas um rascunho não implementado. No momento, a única maneira de gerar novas cores a partir de variáveis ​​é usar variáveis ​​para componentes individuais e inseri-los em funções de cores, como `rgba()` e `hsla()`. No entanto, menos de 4% das páginas para celular e 0,6% das páginas para desktop fazem isso, indicando que o alto uso de variáveis ​​de cor é principalmente para manter cores inteiras, com as variações sendo variáveis ​​separadas em vez de geradas dinamicamente.

{{ figure_markup(
  image="custom-property-functions.png",
  caption="Os nomes de função mais populares usados ​​com propriedades customizadas pela porcentagem de páginas.",
  description="Gráfico de barras dos nomes de funções mais populares usados ​​com propriedades customizadas, pela porcentagem de páginas. A adoção em dispositivos móveis é muito maior para as seis primeiras funções: `calc` (7%), `linear-gradient`, `rgba` (4%),`radial-gradient`, `hsla` e `drop-shadow`. As funções a seguir têm 1% de adoção em páginas de desktop e celular: `-o-linear-gradient`,`translate` e `-webkit-linear-gradient`. E, finalmente, essas funções têm aproximadamente 0% de adoção em páginas de desktop e ,celular: `scale`, `-webkit-gradient`, `max`, `to`, `from` e `rotate`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1986770560&format=interactive",
  width="600",
  height="525",
  sheets_gid="2076074923",
  sql_file="custom_property_functions.sql"
) }}

### Complexidade

A seguir, vimos o quão complexo o uso de propriedade customizada é. Uma maneira de avaliar a complexidade do código na engenharia de software é a forma de grafo de dependência (dependency graph). Primeiro, examinamos a *profundidade* de cada propriedade personalizada. Uma propriedade personalizada definida com um valor literal como, por exemplo, `#fff` tem uma profundidade de 0, enquanto uma propriedade que é referenciada via var() teria uma profundidade de 1 e assim por diante. Por exemplo:

```css
:root {
  --base-hue: 335; /* profundidade = 0 */
  --base-color: hsl(var(--base-hue) 90% 50%); /* profundidade = 1 */
  --background: linear-gradient(var(--base-color), black); /* profundidade = 2 */
}
```

2 de 3 propriedades customizadas examinadas (67%) tinham uma profundidade de 0 e 30% tinham uma profundidade de 1 (um pouco menos no celular). Menos de 1,8% tinha uma profundidade de 2 e praticamente nenhuma (0,7%) tinha uma profundidade de +3, o que indica um uso bastante básico. A vantagem desse uso básico é que é mais difícil cometer erros: menos de 0,5% das páginas incluem ciclos.

{{ figure_markup(
  image="custom-property-depth.png",
  caption="Distribuição de profundidades de propriedades customizadas pela porcentagem de ocorrências.",
  description="Gráfico de barras da distribuição de profundidades de propriedades customizadas pela porcentagem de ocorrências. As propriedades customizadas em páginas desktop e celular têm uma profundidade de 0 em 67% e 60% das ocorrências, respectivamente. Para uma profundidade de 1, é 31% e 38%. Para uma profundidade de 2, apenas 2% cada. Aproximadamente 0% das ocorrências têm uma profundidade de 3 ou mais.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=262191540&format=interactive",
  sheets_gid="1368222498",
  sql_file="custom_property_depth.sql"
) }}

Examinar os seletores nos quais as propriedades customizadas são declaradas confirma ainda mais que a maioria do uso de propriedades customizadas é bastante básica. Duas das três declarações de propriedades personalizadas estão no elemento root, indicando que são usadas essencialmente como constantes globais. É importante observar que muitos polyfills populares exigiram que eles fossem globais nesse sentido, portanto, os desenvolvedores que usam os referidos polyfills podem não ter escolha.

## CSS e JS

Nos últimos anos houve uma maior interação entre CSS e JavaScript, além das simples configurações de classes e estilos CSS ou desabilitação. Então, o quanto estamos usando tecnologias como Houdini e técnicas como CSS-in-JS?

### Houdini

Você provavelmente já ouviu falar de [Houdini](https://developer.mozilla.org/docs/Web/Houdini) até o momento. Houdini é um conjunto de APIs de baixo nível que expõe partes do mecanismo CSS, dando aos desenvolvedores o poder de estender o CSS, conectando-se ao processo de estilo e layout do mecanismo de renderização do navegador. Como <a hreflang="en" href="https://ishoudinireadyyet.com/">várias especificações do Houdini foram liberadas nos navegadores</a>, concluímos que é hora de ver se eles já são realmente usados ​​em estado selvagem. Resposta curta: não. E agora a resposta mais longa ...

Primeiro, vimos a [Properties & Values API](https://developer.mozilla.org/docs/Web/API/CSS/RegisterProperty), que permite que os desenvolvedores registrem uma propriedade personalizada e forneçam um tipo, um valor inicial, e evite que seja herdado. Um dos principais casos de uso é a capacidade de animar propriedades personalizadas, portanto, também observamos a frequência com que as propriedades personalizadas são animadas.

Como é comum com tecnologias de ponta, especialmente quando não é compatível com todos os navegadores, a adoção em geral tem sido extremamente baixa. Detectou-se que apenas 32 páginas para desktop e 20 para celular tinham propriedades personalizadas registradas, embora isso exclua as propriedades personalizadas que foram registradas, mas não estavam sendo aplicadas no momento do rastreamento. Apenas 325 páginas para celular e 330 para desktop (0,00%) usam propriedades personalizadas em animações, e a maioria (74%) disso parece ser impulsionada por um <a hreflang="en" href="https://quasar.dev/vue-components/expansion-item">componente Vue</a>. Praticamente nenhum deles parece tê-los registrado, embora isso seja provável porque a animação não estava ativa no momento do rastreamento, portanto, não havia nenhum estilo computado que precisava ser registrado.

A [Paint API](https://developer.mozilla.org/docs/Web/API/CSS_Painting_API) é uma especificação Houdini mais amplamente implementada que permite aos desenvolvedores criar funções CSS personalizadas que retornam valores de uma tag `<image>`, por exemplo para implementar gradientes ou padrões personalizados. Apenas 12 páginas foram encontradas usando `paint()`. Cada nome de worklet (`hexagon`,`ruler`, `lozenge`, `image-cross`, `grid`, `dashed-line`, `ripple`) apareceu apenas em uma página cada, então parece que os unicos casos in-the-wild eram provavelmente demos.

<a hreflang="en" href="https://github.com/w3c/css-houdini-drafts/blob/master/css-typed-om/README.md">Typed OM</a>, outra especificação do Houdini, permite acesso a valores estruturados em vez das strings do clássico CSSOM. Parece ter uma adoção consideravelmente maior em comparação com outras especificações do Houdini, embora ainda seja baixa no geral. Ele é usado em 9.864 páginas para desktop (0,18%) e 6.391 páginas para celular (0,1%). Embora isso possa parecer baixo, colocando em perspectiva, esses são números semelhantes à adoção do `<input type="date">`! Observe que, ao contrário da maioria das estatísticas neste capítulo, esses números refletem o uso real, e não apenas a inclusão nos assets de um site.

### CSS-in-JS

Há tanta discussão (ou argumentos) sobre CSS-in-JS que se poderia supor que todo mundo está usando.

{{ figure_markup(
  caption="Porcentagem de sites que estão usando qualquer método de CSS-in-JS.",
  content="2%",
  classes="big-number",
  sheets_gid="1368222498",
  sql_file="css_in_js.sql"
)
}}

Contudo, quando observamos o uso das várias bibliotecas CSS-in-JS, descobrimos que apenas cerca de 2% dos sites usam qualquer método CSS-in-JS, com <a hreflang="en" href="https://styled-components.com/">Styled Components</a> sendo responsável por quase metade disso.

{{ figure_markup(
  image="css-in-js.png",
  caption="Popularidade relativa das bibliotecas CSS-in-JS pelo percentual de ocorrências em páginas para celular.",
  description="Gráfico de pizza da popularidade relativa das bibliotecas CSS-in-JS pelo percentual de ocorrências em páginas para celular. Styled Components aparece em 42% das ocorrências em páginas para celular, seguido pelo Emotion em 30%, Aphrodite em 9%, React JSS em 8%, Glamor em 7%, Styled Jsx em 2%, e o restante tendo menos que 1% das ocorrências: Radium, React Native for Web, Goober, Merge Styles, Styletron, e Fela.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=969014374&format=interactive",
  sheets_gid="1368222498",
  sql_file="css_in_js.sql"
) }}

## Internacionalização

O inglês, como muitos idiomas, é escrito em linhas horizontais e os caracteres são dispostos da esquerda para a direita. Mas alguns idiomas (como o árabe e o hebraico) são escritos da direita para a esquerda e há idiomas que podem ser escritos em linhas verticais, de cima para baixo. Para não mencionar outras línguas. Então as coisas podem ficar bem complicadas. Tanto o HTML quanto o CSS têm maneiras de lidar com isso.

### Direção

Quando o texto é apresentado em linhas horizontais, a maioria dos sistemas de escrita exibe caracteres da esquerda para a direita. Urdu, árabe e hebraico exibem caracteres da direita para a esquerda, exceto para números, que são escritos da esquerda para a direita; eles são bidirecionais. Alguns caracteres - como colchetes, aspas, pontuação - podem ser usados ​​da esquerda para a direita ou da direita para a esquerda e são considerados direcionalmente neutros. As coisas ficam mais complexas quando strings de texto de diferentes idiomas são aninhadas umas nas outras - texto em inglês contendo uma pequena citação em hebraico que contém algumas palavras em inglês, por exemplo. O algoritmo bidirecional Unicode define como dispor parágrafos de texto de direção mista, mas precisa saber a direção básica do parágrafo.

Para suportar a bidirecionalidade, o suporte explícito para indicação de direção está disponível em HTML (através do <a hreflang="en" href="https://html.spec.whatwg.org/multipage/dom.html#the-dir-attribute">atributo `dir`</a> e o <a hreflang="en" href="https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-bdo-element">elemento `<bdo>`</a>) e CSS (as propriedades <a hreflang="en" href="https://www.w3.org/TR/css-writing-modes-3/#direction">direction</a> e <a hreflang="en" href="https://www.w3.org/TR/css-writing-modes-3/#unicode-bidi">`unicode-bidi`</a>). Nós olhamos para ambos os usos destes métodos HTML e CSS.

Apenas 12,14% das páginas para celular (e 10,76% similarmente no desktop) definiram o atributo `dir` no elemento `<html>`. O que é bom: a maioria dos sistemas de escrita no mundo são `ltr`, e o valor padrão de `dir` é `ltr`. Das páginas que definiram `dir` em `<html>`, 91% definiram como `ltr`, enquanto 8,5% definiram como `rtl` e 0,32% como `auto` (a direção explícita é um valor desconhecido, principalmente útil para templates que serão preenchidos com conteúdo desconhecido). Um número ainda menor, 2,63%, definiram `dir` na tag `<body>` ao invés da tag `<html>`. O que é bom, porque configurá-lo no `<html>` também cobre o conteúdo que está no `<head>`, como `<title>`.

Por que definir a direção usando atributos HTML em vez de estilos CSS? Um dos motivos é a separação de preocupações: a direção tem a ver com o conteúdo, que é o escopo do HTML. Também é a <a hreflang="en" href="https://www.w3.org/International/tutorials/bidi-xhtml/index.en">prática recomendada</a>: <q>Evite usar códigos de controle CSS ou Unicode para gerenciar a direção onde você pode usar marcação</q>. Afinal de contas, a folha de estilo pode não carregar e o texto ainda precisa ser legível.

### Lógica vs propriedades físicas

Muitas das primeiras propriedades que ensinamos quando aprendemos CSS, coisas como `width`, `height`, `margin-left`, `padding-bottom`, `right` e assim por diante, são baseadas em uma direção física específica. No entanto, quando o conteúdo precisa ser apresentado em vários idiomas com características de direcionalidade diferentes, essas direções físicas geralmente dependem do idioma, por exemplo, `margin-left` frequentemente precisa se tornar `margin-right` em um idioma right-to-left, como o árabe. A direcionalidade é uma característica 2D. Por exemplo, `height` pode precisar se tornar `width` quando apresentamos o conteúdo na escrita vertical (como o chinês tradicional).

No passado, a única solução para esses problemas era uma folha de estilo separada com substituições para diferentes sistemas de escrita. No entanto, mais recentemente, o CSS adquiriu [propriedades e valores *lógicos*](https://developer.mozilla.org/docs/Web/CSS/CSS_Logical_Properties) que funcionam exatamente como suas contrapartes *físicas*, mas são sensíveis com relação à direcionalidade de seu contexto. Por exemplo, em vez de `width` poderíamos escrever `inline-size`, e em vez de `left` poderíamos usar o [`inset-inline`](https://developer.mozilla.org/docs/Web/CSS/inset-inline). Além das *propriedades* lógicas, também existem *keywords* lógicas, como `float: inline-start` em vez de `float: left`.

Embora essas propriedades sejam razoavelmente <a hreflang="en" href="https://caniuse.com/css-logical-props">bem suportadas</a> (com algumas exceções), elas não são muito usadas fora das folhas de estilo do user agent. Nenhuma das propriedades lógicas foi usada em mais de 0,6% das páginas. A maior parte do uso era para especificar margens e preenchimentos. Keywords lógicas para `text-align` foram usadas em 2,25% das páginas, mas fora isso, nenhuma das outras keywords foi encontrada. Isso é em grande parte impulsionado pelo suporte do navegador: `text-align: start` e `end` têm <a hreflang="en" href="https://caniuse.com/mdn-css_properties_text-align_flow_relative_values_start_and_end">um bom suporte dos navegadores</a> enquanto keywords lógicas para `clear` e `float` são suportados apenas no Firefox.

## Suporte dos browsers

Um problema constante com a plataforma da web é como introduzir novos recursos e estender a plataforma. CSS nos viu mudando de vendor prefixes para media queries como uma maneira melhor de introduzir mudanças, então queríamos ver como essas duas técnicas estavam sendo usadas.

### Vendor prefixes

{{ figure_markup(
  caption="Porcentagem de páginas para celular usando qualquer funcionalidade de vendor prefixe.",
  content="91.05%",
  classes="big-number",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

Mesmo que a prefixação seja agora reconhecida como uma forma ruim de introduzir recursos experimentais para os desenvolvedores, e os navegadores tenham parado de usá-la, optando por flags em vez disso, impressionantes 91% das páginas ainda usam pelo menos um recurso prefixado.

{{ figure_markup(
  image="vendor-prefix-features.png",
  caption="Os recursos de vendor prefixes mais populares por tipo pela porcentagem de páginas.",
  description="Gráfico de barras dos recursos de vendor prefixes mais populares por tipo pela porcentagem de páginas. Desktop e celular são muito semelhantes. 91% das páginas para celular usam propriedades com vendor prefixes, 77% usam keydwords e pseudoelements, 65% usam funções, 61% usam pseudo classes e 52% usam media.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1057411197&format=interactive",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

Propriedades prefixadas ocupam a maior parte disso, uma vez que 84% de todos os recursos prefixados usados ​​eram propriedades e eram usados ​​em 90,76% das páginas para celular e 89,66% das páginas para desktop. Isso é provavelmente um resquício da feliz era dos prefixes para CSS3 por volta de 2009-2014. Isso também é evidente a partir dos prefixos mais populares, nenhum dos quais realmente precisou de prefixos desde 2014:

{{ figure_markup(
  image="vendor-prefix-properties.png",
  caption="Popularidade relativa das propriedades que são mais usadas com vendor prefixes, pela porcentagem de ocorrências.",
  description="Gráfico de barras da popularidade relativa das propriedades que são mais usadas com vendor prefixes, pela porcentagem de ocorrências. Desktop e celular possuem resultados similares. A propriedade `transform` aparecem com 19% de uso de vendor prefix, seguido por 12% `transition`, 9% `border-radius`, 8% `box-shadow`, 5% `user-select` e `box-sizing`, 4% `animation`, 3% `filter`, 2% cada para `font-smoothing`, `backface-visibility`, `appearance`, e `flex`, e 1% de uso para as propriedades restantes: `transform-origin`, `osx-font-smoothing`, `animation-name`, `background-size`, `transition-property`, e `tap-highlight-color`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=859599479&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql",
  width="600",
  height="627"
) }}

Alguns desses prefixos, como `-moz-border-radius`, não têm sido úteis desde 2011. Ainda mais surpreendente, outras propriedades prefixadas que nunca existiram, ainda são moderadamente comuns, com cerca de 9% de todas as páginas incluindo `-o-border-radius`!

Pode não ser surpresa que `-webkit-` seja de longe o prefixo mais popular, com metade das propriedades prefixadas usando ele:

{{ figure_markup(
  image="top-vendor-prefixes.png",
  caption="Popularidade relativa de vendor prefixes, pela porcentagem de ocorrências.",
  description="Gráfico de barras da popularidade relativa de vendor prefixes, pela porcentagem de ocorrências. `-webkit` aparece com 49% do uso de vendor prefix em páginas para celular, `-moz` 23%, `-ms` 19%, `-o` 8%, `-khtml` 1%, e 0% para `-pie`, `-js`, e `-ie`. Desktop é similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=702800205&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql"
) }}

Pseudoclasses prefixadas não são tão comuns quanto as propriedades, com nenhuma delas sendo usada em mais de 10% das páginas. Quase dois terços de todas as pseudoclasses prefixadas em geral são para estilizar placeholders. Em contraste, a pseudo classe padrão `:placeholder-shown` quase não é usada, encontrada em menos de 0,34% das páginas.

{{ figure_markup(
  image="vendor-prefix-pseudo-classes.png",
  caption="As pseudo-classes prefixadas mais populares pela porcentagem de páginas.",
  description="Gráfico de barras das pseudo-classes prefixadas mais populares pela porcentagem de páginas. `:ms-input-placeholder` é usada em 10% das páginas para celular, `:-moz-placeholder` 8%, `:-mox-focusring` 2%, e 1% ou menos para as seguintes: `:-webkit-full-screen`, :-moz-full-screen, :-moz-any-link, `:-webkit-autofill`, `:-o-prefocus,` `:-ms-fullscreen`, `:-ms-input-placeholder` [sic], `:-ms-lang`, `:-moz-ui-invalid`, `:-webkit-input-placeholder`, `:-moz-input-placeholder`, e `:-webkit-any-link`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1884876858&format=interactive",
  sheets_gid="1477158006",
  width="600",
  height="650",
  sql_file="vendor_prefix_pseudo_classes.sql"
) }}

O pseudo-elemento prefixado mais comum é o `::-moz-focus-inner`, usado para desativar o anel de foco interno do Firefox. Constitui quase um quarto de pseudoelementos prefixados e para os quais não há alternativa padrão. Outro quarto de pseudoelementos prefixados é mais uma vez para estilizar placeholders, enquanto a versão padrão, `::placeholder`, fica muito atrás, usada em apenas 4% das páginas.

A metade restante dos pseudoelementos prefixados é principalmente dedicada a estilizar barras de rolagem e Shadow DOM de elementos nativos (search input, controles de vídeo e áudio, spinner buttons, sliders, meters, progress bars). Isso indica uma forte necessidade do desenvolvedor de personalização de controles de IU integrados, para os quais o CSS compatível com os padrões ainda é insuficiente, embora haja várias <a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5187">discussões</a> <a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/4410">em andamento</a> no CSS WG para melhorar isso.

{{ figure_markup(
  image="vendor-prefix-pseudo-elements.png",
  caption="Uso de pseudo-elementos prefixados por categoria.",
  description="Gráfico de barras da popularidade relativa de pseudo-elementos prefixados por sua finalidade pela porcentagem de ocorrências. placeholder é usado em 29% das ocorrências prefixadas, anel de foco 21%, barra de rolagem 11%, search input 10%, controles de mídia 8%, spinner 7%, outros, selection, slider, botão limpar tudo em 3%, progress bar 2% , upload de arquivo 1% e o restante com popularidade relativa de aproximadamente 0% em páginas para celular: date picker, validation, meter, details marker, e resizer..",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013685965&format=interactive",
  sheets_gid="1466863581",
  width="600",
  height="566",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

Não é nenhum segredo que o Chrome e o Safari têm sido muito mais felizes com prefixos, mas é especialmente verdade com pseudo-elementos: quase metade de todos os pseudo-elementos prefixados que encontramos tinham um prefixo `-webkit-`.

{{ figure_markup(
  image="top-pseudo-element-prefixes.png",
  caption="Popularidade relativa de vendor prefixes de pseudo-elementos pelo percentual de ocorrências em páginas para celular.",
  description="Pie chart da popularidade relativa de vendor prefixes de pseudo-elementos pelo percentual de ocorrências em páginas para celular. `-webkit` representa 47% do uso de vendor prefixes de pseudo-elemento, seguido por 26% `-moz`, 15% `-ms`, 7% `-o` e 6% outros.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=744523431&format=interactive",
  sheets_gid="1466863581",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

Quase todo o uso de funções prefixadas (98%) é para especificar gradientes, embora <a hreflang="en" href="https://caniuse.com/css-gradients">isso não tenha sido necessário desde 2014</a>. O mais popular deles é `-webkit-linear-gradient()` usado em mais de um quarto das páginas examinadas. Os <2% restantes são principalmente para cálculo, <a hreflang="en" href="https://caniuse.com/calc">para o qual não é necessário mais um prefixo desde 2013</a>.

{{ figure_markup(
  caption="Porcentagem de funções de gradientes em todas as ocorrências de funções prefixadas em páginas para celular",
  content="98.22%",
  classes="big-number",
  sheets_gid="1586213539",
  sql_file="vendor_prefix_functions.sql"
) }}

O uso de recursos de mídia prefixados é menor no geral, com o mais popular, `-webkit-min-pixel-ratio`, usado em 13% das páginas para detectar telas "Retina". O recurso de mídia padrão correspondente, [`resolution`](https://developer.mozilla.org/docs/Web/CSS/@media/resolution) finalmente ultrapassou em popularidade e é usado em 22% dos páginas para celular e 15% páginas desktop.

No geral, `-*-min-pixel-ratio` compreende três quartos dos recursos de mídia prefixados no desktop e cerca da metade no celular. A razão para a diferença não é o uso reduzido de dispositivos móveis, mas que outro recurso de mídia prefixado, `-*-high-contrast`, é muito mais popular em dispositivos móveis, constituindo quase toda a outra metade dos recursos de mídia prefixados, mas apenas 18% no desktop. O recurso de mídia padrão correspondente, [forced-colors](https://developer.mozilla.org/docs/Web/CSS/@media/forced-colors) ainda é experimental e está por trás de uma flag no Chrome e Firefox e não apareceu em nossa análise.

{{ figure_markup(
  image="vendor-prefixed-media.png",
  caption="Popularidade relativa dos recursos de mídia prefixados pelo percentual de ocorrências em páginas no celular.",
  description="Pie chart da popularidade relativa dos recursos de mídia prefixados pelo percentual de ocorrências em páginas no celular. `min-device-pixel-ratio` e `high-contrast` representam, cada um, 47% das ocorrências, `transform-3d` a 5% e os recursos restantes com menos de 1% são `device-pixel-ratio`, `max-device-pixel-ratio`, e outros recursos",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1940027848&format=interactive",
  sheets_gid="1192245087",
  sql_file="vendor_prefix_media.sql"
) }}

### Feature queries

As feature queries ([@supports](https://developer.mozilla.org/docs/Web/CSS/@supports)) têm ganhado força nos últimos anos e foram usadas em 39% das páginas, um aumento notável em relação aos 30% do ano passado.

Mas para que são usadas? Vimos as queries mais populares. Os resultados podem ser uma grande surpresa - e foi para nós! Esperávamos que as queries relacionadas ao Grid estivessem no topo da lista, mas, em vez disso, as feature queries mais populares de longe são para `position: sticky`! Elas abrangem metade de todas as feature queries e são usados ​​em cerca de um quarto das páginas. Em contraste, as queries relacionadas ao Grid respondem por apenas 2% de todas as queries, indicando que os desenvolvedores se sentem confortáveis ​​o suficiente com o suporte do navegador do Grid para que não precisem usá-lo apenas como aprimoramento progressivo.

O que é ainda mais misterioso é que o próprio `position: sticky` não é usado tanto quanto as feature queries sobre ele, aparecendo em 10% das páginas de desktop e 13% das páginas para dispositivos móveis. Portanto, há mais de meio milhão de páginas que detectam `position: sticky` sem nunca usá-lo! Por que?!

Por último, foi encorajador ver `max()` já entre os 10 recursos mais detectados, aparecendo em 0,6% das páginas para desktop e 0,7% das páginas para dispositivos móveis. Dado que `max()` (e `min()` e `clamp()`) foi <a hreflang="en" href="https://caniuse.com/mdn-css_types_max">suportado pela maioria dos navegadores modernos apenas este ano</a>, é bastante impressionante a adoção e destaca o quão desesperadamente os desenvolvedores precisavam disso.

Um número pequeno, mas notável de páginas (cerca de 3.000 ou 0,05%) estava estranhamente usando `@supports` com sintaxe CSS 2, como `display: block` ou `padding: 0px`, sintaxe que existia bem antes do `@supports` ser implementado. Não está claro qual o objetivo disso. Talvez tenha sido usado para proteger as regras CSS de navegadores antigos que não implementam `@supports`?

{{ figure_markup(
  image="supports-criteria.png",
  caption="Popularidade relativa dos recursos consultados com `@supports` pela porcentagem de ocorrências.",
  description="Gráfico de barras da popularidade relativa dos recursos consultados com `@supports` pela porcentagem de ocorrências. O recurso mais popular consultado é `sticky` em 49% das ocorrências em páginas para dispositivos móveis, seguido por `ime-align` em 24%, `mask-image` em 12%, `overflow-scrolling` em 5%, `grid` a 2%, propriedades personalizadas, `transform-style`, `max()` e `object-fit` todos em 1% e `appearance` em aproximadamente 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1901533222&format=interactive",
  sheets_gid="1155233487",
  sql_file="supports_criteria.sql"
) }}

## Meta

Até agora vimos o que os desenvolvedores CSS têm usado, mas nesta seção queremos ver mais a respeito de _como_ eles estão usando.

### Repetição de declarações

Para dizer o quão eficiente e sustentável é uma folha de estilo, um fator básico é a repetição da declaração, ou seja, a proporção entre o número único (diferente) e o número total de declarações. O fator é grosseiro porque não é trivial normalizar declarações (`border: none`, `border: 0`, até mesmo `border-width: 0` - entre outros mais - são todos diferentes, mas dizem a mesma coisa), e também porque existem níveis para a repetição: media query (mais útil, mas mais difícil de medir), folha de estilo ou nível de conjunto de dados como com as métricas gerais do Almanaque.

Analisamos a repetição de declarações e descobrimos que a uma página média na web, no celular, usa um total de 5.454 declarações, das quais 2.398 são únicas. A proporção média (que se baseia no conjunto de dados, não nesses dois valores) chega a 45,43%. O que isso significa é que na página mediana, cada declaração é usada aproximadamente duas vezes.

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentíl</th>
        <th>Único / Total</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">30.97%</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">45.43%</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">63.67%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Distribuição das taxas de repetição em páginas para dispositivos móveis.",
      sheets_gid="2124098640",
      sql_file="repetition.sql"
    ) }}
  </figcaption>
</figure>

Essas proporções são melhores, então, do que sabemos com base em dados anteriores escassos. Em 2017, Jens Oliver Meiert <a hreflang="en" href="https://meiert.com/en/blog/70-percent-css-repetition/">amostrou 220 sites populares</a> e obteve as seguintes médias: 6.121 declarações, das quais 1.698 foram únicas e uma proporção única/total de 28% (mediana de 34%). O tópico pode precisar de uma investigação mais aprofundada, mas pelo pouco que sabemos até agora, a repetição de declarações é tangível - e pode ter melhorado ou ser um problema para os sites mais populares e provavelmente maiores.

### Abreviações e declarações completas

Algumas abreviações têm mais sucesso do que outras. Às vezes, a abreviação é suficientemente fácil de usar e sua sintaxe memorável, que acabamos usando apenas a declaração completa intencionalmente, quando queremos substituir certos valores independentemente. E então há essas abreviações que quase nunca são usadas porque sua sintaxe é muito confusa.

#### Abreviações antes de declarações completas

Algumas abreviações têm mais sucesso do que outras. Às vezes, a abreviação é suficientemente fácil de usar e sua sintaxe memorável, que acabamos usando apenas a declaração completa intencionalmente, quando queremos substituir certos valores independentemente. E então há essas abreviações que quase nunca são usadas porque sua sintaxe é muito confusa. Usar uma abreviatura e substituí-la por algumas declarações completas na mesma regra é uma boa estratégia por uma variedade de razões:

Primeiro, é uma boa codificação defensiva. A abreviação redefine todos os seus caracteres longos para seus valores iniciais, se eles não tiverem sido especificados explicitamente. Isso evita que valores invasores entrem pela cascata.

Em segundo lugar, é bom para a manutenção, para evitar a repetição de valores quando a abreviação tem padrões inteligentes. Por exemplo, em vez de `margin: 1em 1em 0 1em`, podemos escrever:

```css
margin: 1em;
margin-bottom: 0;
```

Da mesma forma, para propriedades com valor em lista, as declarações completas podem nos ajudar a reduzir a repetição quando um valor é o mesmo em todos os valores da lista:

```css
background: url("one.png"), url("two.png"), url("three.png");
background-repeat: no-repeat;
```
Terceiro, para os casos em que partes da sintaxe abreviada são muito estranhas, declarações completas podem ajudar a melhorar a legibilidade:

```css
/* Em vez de: */
background: url("one.svg") center / 50% 50% content-box border-box;

/* Isso é mais legível: */
background: url("one.svg") center;
background-size: 50% 50%;
background-origin: content-box;
background-clip: border-box;
```

Então, com que frequência isso ocorre? Muito, ao que parece. 88% das páginas usam essa estratégia pelo menos uma vez. De longe, o a declaração completa mais frequente com que isso acontece é `background-size`, respondendo por 40% de todos as declarações completas que vêm depois de sua abreviação, indicando que a sintaxe de barra para `background-size` em `background` pode não ter sido a sintaxe mais legível ou memorável que poderíamos ter criado. Nenhuma outra declaração completa chega perto dessa frequência. Os 60% restantes são uma cauda longa espalhada por muitas outras propriedades uniformemente.

{{ figure_markup(
  image="most-popular-longhand-after-shorthand.png",
  caption="Declarações completas mais populares que vêm depois de abreviações na mesma regra.",
  description="Gráfico de barras mostrando `background-size` em 15% para desktop e 41% para celular, `background-image` em 8% e 6% respectivamente, `margin-bottom` em 6% e 4%, `margin-top` em 6% e 4%, `border-bottom-color` a 5% e 3%, `font-size` a 4% e 3%, `border-top-color` a 4% e 3%, `background-color` em 4% e 2%, `padding-left` em 3% e 2% e, finalmente, `margin-left` em 3% e 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=176504610&format=interactive",
  sheets_gid="17890636",
  sql_file="meta_shorthand_first_properties.sql",
  width="600",
  height="429"
) }}

#### font

A abreviação `font` é bastante popular (usada 49 milhões de vezes em 80% das páginas), mas usada muito menos do que a maioria de suas declarações completas (exceto `font-variant` e `font-stretch`). Isso indica que a maioria dos desenvolvedores se sente confortável em usá-lo (já que aparece em muitos sites). Os desenvolvedores geralmente precisam substituir aspectos tipográficos específicos nas regras descendentes, o que provavelmente explica por que as declarações completas são usadas ​​tanto mais.

{{ figure_markup(
  image="font-shorthands.png",
  caption="Adoção de propriedades abreviadas e completas de `font`.",
  description="Gráfico de barras mostrando a adoção de propriedades de abreviação e completas de font. As propriedades mais usadas são as declarações compeltas que variam de 95% a 92% das páginas para dispositivos móveis em ordem decrescente: font-weight, font-family, font-size, line-height, e font-style. A abreviação font é usada em 80% das páginas para dispositivos móveis. Declarações completas de font menos usadas ​​são font-variant em 43% e font-stretch em 8%. A adoção é semelhante em desktop e celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1455030576&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### background

Como uma das abreviações mais antigas, `background` também é muito usado, aparecendo 1 bilhão de vezes em 92% das páginas. Ele é usado com mais frequência do que qualquer um de seus longhands, exceto em `background-color`, que é usado 1,5 bilhão de vezes, em aproximadamente o mesmo número de páginas. No entanto, isso não significa que os desenvolvedores estão totalmente confortáveis ​​com toda a sua sintaxe: quase todo (> 90%) do uso de `background` é muito simples, com um ou dois valores, provavelmente cores e imagens ou imagens e posições. Para qualquer coisa além, os longhands são vistos como mais autoexplicativos.

{{ figure_markup(
  image="background-shorthand-versus-longhand.png",
  caption="Uso comparativo da abreviação de `background` e seus longhands.",
  description="Gráfico de barras mostrando que `background` é usado em 91% no desktop e 92% no celular, `background-color` é 91% e 92% respectivamente, `background-image` é 85% e 87%, `background-position` é 84% e 85%, `background-repeat` é 82% e 84%, `background-size` é 77% e 79%, `background-clip` é 48% e 53%, `background-attachment` é 37% e 38 %, `background-origin` é 5% no desktop e 12% no celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2014923335&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="429"
) }}

#### Margins e paddings

Ambas as abreviações `margin` e `padding`, bem como seus longhands foram algumas das propriedades CSS mais usadas. Padding é consideravelmente mais provável de ser especificado como uma abreviação (1.5B usa para `padding` vs 300-400M para cada abreviação), enquanto há menos diferença para a margem (1.1B usa de `margin` vs 500-800M para cada um de seus longhands). Dada a confusão inicial de muitos desenvolvedores de CSS sobre a ordem dos valores no sentido horário dessas abreviações e a regra de repetição para 2 ou 3 valores, esperávamos que a maioria desses usos das abreviações fossem simples (1 valor), no entanto, vimos a totalidade intervalo de 1,2,3 ou 4 valores. Obviamente, 1 ou 2 valores eram mais comuns, mas 3 ou 4 não eram incomuns, ocorrendo em mais de 25% dos usos de `margin` e mais de 10% do uso de `padding`.

{{ figure_markup(
  image="margin-padding-shorthand-vs-longhand.png",
  caption="Uso comparativo das abreviações `margin` e `padding` e seus longhands longhands.",
  description="Gráfico de barras mostrando que `padding` esta 93% no desktop, 94% no celular, `margin` está em 93% e 93% respectivamente, `margin-left` está 91% e 92%, `margin-top` está 90% e 91%, `margin-right` está 90% e 91%, `margin-bottom` está 90% e 91%, `padding-left` está 90% e 90%, `padding-top` está 88% e 89%, `padding-bottom` está 88% e 89%, e `padding-right` está 87% e 88%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=804317202&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Flex

Quase todas as propriedades `flex`, `flex-*` são muito usadas, aparecendo em 30-60% das páginas. No entanto, `flex-wrap` e `flex-direction` são usados ​​muito mais do que a abreviação, `flex-flow`. Quando `flex-flow` é usado, ele é usado com dois valores, ou seja, como uma maneira mais curta de definir seus longhands. Apesar dos [padrões elaborados e sensatos](https://developer.mozilla.org/docs/Web/CSS/flex#Syntax:~:text=The%20flex%20property%20may%20be%20specified%20using%20one%2C%20two%2C%20or%20three%20values) para uso de `flex` com um ou dois valores, cerca de 90% do uso consiste na sintaxe com 3 valores, definindo explicitamente todos os três de seus longhands.

{{ figure_markup(
  image="flex-shorthand-vs-longhand.png",
  caption="Uso comparativo das abreviações da abreviação flex e seus longhands.",
  description="Gráfico de barras mostrando que `flex-direction` está 55% no desktop e 60% no celular, `flex-wrap` está 55% e 58% respectivamente,`flex` está 52% e 56%, `flex-grow` está 44% e 52%,`flex-basis` está 40% e 44%,`flex-shrink` está 28% e 37%, `flex-flow` está 27% e 30%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=930720666&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Grid

Você sabia que `grid-template-columns`, `grid-template-rows` e `grid-template-areas` são na verdade abreviações de `grid-template`? Você sabia que existe uma propriedade `grid` e todas essas são alguns de seus longhands? Não? Bem, você está em boa companhia: nem a maioria dos desenvolvedores. A propriedade `grid` foi usada apenas em 5.279 sites (0,08%) e `grid-template` em 8.215 sites (0,13%). Em comparação, `grid-template-columns` é usado em 1,7 milhões de sites, mais de 200 vezes mais!

{{ figure_markup(
  image="usage-of-grid-properties.png",
  caption="Uso comparativo da abreviação grid e seus longhands.",
  description="Gráfico de barras mostrando que `grid-template-columns` está em 27% no desktop e 26% no celular, `grid-template-rows` está em 24% e 24% respectivamente, `grid-column` está em 20% e 20%, `grid-row` está em 20% e 19%, `grid-area` está em 6% e 6%, `grid-template-areas` está em 6% e 6%, `grid-gap` está em 4% e 5%, `grid-column-gap` está em 4% e 3%, `grid-row-gap` está em 3% e 3%, `grid-column-end` está em 3% e 2%, `grid-column-start` está em 3% e 2%, `grid-row-start` está em 3% e 2%, `grid-row-end` está em 2% e 2%, `grid-auto-columns` está em 2% e 2%, `grid-auto-rows` está em 1% e 1%, `grid-auto-flow` está em 1% e 1%, `grid-template` está em 0% e 0%, `grid` está em 0% e 0%, `grid-column-span` está em 0% e 0%, `grid-columns` está em 0% e 0%, e `grid-rows` está em 0% e 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=290183398&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="575"
) }}

### Erros de CSS

Como acontece com qualquer plataforma complexa em evolução, nem tudo é feito corretamente. Então, vamos dar uma olhada em alguns dos erros que os desenvolvedores estão cometendo por aí.

#### Erros de sintaxe

Para a maioria das métricas neste capítulo, usamos <a hreflang="en" href="https://github.com/reworkcss/css">Rework</a>, um parser CSS. Embora isso ajude a melhorar drasticamente a precisão, também significa que podemos ser menos tolerantes com os erros de sintaxe em comparação com um navegador. Mesmo se uma declaração em toda a folha de estilo tiver um erro de sintaxe, o parser falhará e essa folha de estilo será deixada de fora do parsing. Mas quantas folhas de estilo contêm esses erros de sintaxe? Bem, substancialmente mais no desktop do que no celular! Mais especificamente, quase 10% das folhas de estilo encontradas em páginas desktop incluíam pelo menos um erro de sintaxe irrecuperável, enquanto apenas 2% nos dispositivos móveis. Observe que esses são essencialmente limites inferiores para erros de sintaxe, uma vez que nem todos os erros de sintaxe realmente causam falha no parsing. Por exemplo, um ponto e vírgula ausente resultaria apenas na próxima declaração sendo analisada como parte do valor (por exemplo, `{property: "color", value: "red background: yellow"}`), não faria com que o parser falhasse.

#### Propriedades inexistentes

Também examinamos as propriedades inexistentes mais comuns, usando uma lista de propriedades conhecidas. Excluímos propriedades prefixadas desta parte da análise e excluímos manualmente propriedades proprietárias não prefixadas (por exemplo, `behavior` do Internet Explorer, que estranhamente ainda aparece em 200 mil sites). Das propriedades inexistentes restantes:

- 37% deles estavam em uma forma mutilada de uma propriedade prefixada (por exemplo, `webkit-transition` ou `-transition`)
- 43% eram uma forma não prefixada de uma propriedade que existe apenas com prefixo (por exemplo, `font-smoothing`, que apareceu em 384K sites), provavelmente incluída para compatibilidade sob a suposição incorreta de que é padrão, ou devido ao desejo de que irá se tornar padrão.
- Um erro de digitação que foi encontrado em uma biblioteca popular. Por meio dessa análise, constatamos que a propriedade `white-wpace` estava presente em 234.027 sites. São sites demais para que o mesmo erro de digitação tenha ocorrido organicamente, então decidimos dar uma olhada nele. E eis que [descobriu-se](https://x.com/rick_viscomi/status/1326739379533000704) qie era o widget do Facebook! A correção já existe.
- E outra estranheza: a propriedade `font-rendering` aparece em 2.575 páginas. No entanto, não podemos encontrar evidências da existência de tal propriedade, com ou sem um prefixo. Existe o não padrão <a hreflang="en" href="https://medium.com/better-programming/improving-font-rendering-with-css-3383fc358cbc">`-webkit-font-smoothing`</a> que é extremamente popular, aparecendo em 3 milhões de sites, ou cerca de 49% das páginas, mas `font-rendering` não é suficientemente próximo para ser um erro de ortografia. Existe [`text-rendering`](https://developer.mozilla.org/docs/Web/CSS/text-rendering) que é usado em cerca de 100K de sites, portanto, é concebível que 2,5K e todos os desenvolvedores se lembraram erroneamente e cunharam um portmanteau de `font-smoothing` e `text-rendering`.

{{ figure_markup(
  image="most-popupular-unknown-properties.png",
  caption="As propriedades inexistentes mais populares.",
  description="Gráfico de barras mostrando que `webkit-transition` está em 15% no desktop e 14% no celular, `font-smoothing` está 13% e 12% respectively, `user-drag` está 12% no celular, `white-wpace` está 10% no celular, `tap-highlight-color` está 10% e 10%, `webkit-box-shadow` está 4% e 4%, `ms-transform` está 2% e 2%, `-transition` está 1% e 1%, `font-rendering` está 0% e 0%, `webkit-border-radius` está 2% no desktop, e `moz-border-radius` está 2% no desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1166982997&format=interactive",
  sheets_gid="84286607",
  sql_file="meta_unknown_properties.sql",
  width="600",
  height="401"
) }}

#### Longhands antes de abreviações

Usar longhands após abreviações é uma boa maneira de usar os padrões e substituir algumas propriedades. É especialmente útil com propriedades com valor em lista, onde usar um longhand nos ajuda a evitar a repetição do mesmo valor várias vezes. O oposto, por outro lado - usar um longhand antes da abreviação - é sempre um erro, uma vez que a abreviação substituirá o longhand. Por exemplo, dê uma olhada nisso:

```css
background-color: rebeccapurple; /* longhand */
background: linear-gradient(white, transparent); /* shorthand */
```

Isso não produzirá um gradiente de `white` para `rebeccapurple`, mas de `white` para `transparent`. A cor de fundo `rebeccapurple` será sobrescrita pela abreviação `background` que vem depois, que redefine todos os seus valores longos para seus valores iniciais.

Existem dois motivos principais pelos quais os desenvolvedores cometem esse tipo de erro: ou um mal-entendido sobre como as abreviações funcionam e qual abreviatura é redefinida por qual abreviatura, ou simplesmente restos de resíduos de movimentação de declarações.

Então, quão comum é esse erro? Certamente, não pode ser tão comum nos principais 6 milhões de sites, certo? Errado! Acontece que é extremamente comum, ocorrendo pelo menos uma vez em 54% dos sites!

Este tipo de confusão parece acontecer muito mais com a abreviatura `background` do que com qualquer outra abreviação: mais da metade (55%) desses erros envolvem colocar `background-*` longhands antes de `background`. Neste caso, isso pode realmente não ser um erro, mas um bom aprimoramento progressivo: navegadores que não suportam um recurso - como gradientes lineares - irão renderizar os valores dos longhands definidos anteriormente, neste caso, uma cor de fundo. Os navegadores que entendem a abreviação substituem o valor da versão longa, implícita ou explicitamente.

{{ figure_markup(
  image="most-popupular-shorthands-after-longhands.png",
  caption="Abreviações depois de longhands mais populares.",
  description="Gráfico de barras mostrando que `background` está em 56.46% no desktop e 55.17% no celular, `margin` está em 12.51% e 12.18% respectivamente, `font` está em 10.15% e 10.31%, `padding` está em 8.36% e 7.87%, `border-radius` está em 1.08% e 3.14%, `animation` está em 3.18% e 3.05%, `list-style` está em 2.09% e 2.00%, e `transition` está em 1.09% e 0.98%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1389278729&format=interactive",
  sheets_gid="1143644053",
  sql_file="meta_longhand_first_properties.sql"
) }}

## Sass

Embora a análise do código CSS nos diga o que os desenvolvedores CSS estão fazendo, olhar o código do pré-processador pode nos dizer um pouco sobre o que os desenvolvedores CSS querem fazer, mas não podem, o que de certa forma é mais interessante. O Sass consiste em duas sintaxes: Sass, que é mais mínimo, e SCSS, que é mais próximo do CSS. O primeiro está caindo em desuso e não é muito usado hoje, portanto, olhamos apenas para o último. Usamos arquivos CSS com sourcemaps para extrair e analisar folhas de estilo SCSS em estado selvagem. Escolhemos olhar para o SCSS porque é a sintaxe de pré-processamento mais popular, com base em nossa análise dos sourcemaps.

Há algum tempo sabemos que os desenvolvedores precisam de funções de modificação de cores e estão trabalhando nelas na especificação do <a hreflang="en" href="https://drafts.csswg.org/css-color-5/">CSS Color 5</a>. No entanto, a análise de chamadas de função SCSS nos dá dados concretos para provar o quão necessárias são as funções de modificação de cor e também nos diz quais tipos de modificações de cor são mais comumente necessários.

No geral, mais de um terço de todas as chamadas de função Sass são para modificar cores ou extrair componentes de cores. Praticamente todas as modificações de cores que encontramos eram bastante simples. Metade deveria tornar as cores mais escuras. Na verdade, `darken()` foi a chamada de função Sass mais popular em geral, usada ainda mais do que o genérico `if()`! Parece que uma estratégia comum é definir cores básicas brilhantes e usar `darken()` para criar variações mais escuras. O oposto, tornando-os mais leves, é menos comum, com apenas 5% das chamadas de função sendo `lighten()`, embora essa ainda seja a 6ª função mais popular no geral. As funções que alteram o canal alfa representam cerca de 4% das chamadas de função gerais e a mistura de cores representa 3,5% de todas as chamadas de função. Outros tipos de modificações de cor, como ajuste de matiz, saturação, canais de vermelho/verde/azul (red/green/blue) ou o mais complexo `adjust-color()`, foram usados ​​com moderação.

{{ figure_markup(
  image="most-popupular-sass-function-calls.png",
  caption="Chamadas de função Sass mais populares.",
  description="Gráfico de barras mostrando `(other)` é usado em 23% no desktop e 23% no celular, `darken` está em 17% e 18% respectivamente, `if` está em 14% e 14%, `map-keys` está em 8% e 9%, `percentage` está em 8% e 8%, `map-get` está em 8% e 7%, `lighten` está em 5% e 6%, `nth` está em 5% e 5%, `mix` está em 4% e 4%, `length` está em 3% e 3%, `type-of` está em 2% e 2%, e `(alpha adjustment)` 2% no desktop e 2% no celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=774248494&format=interactive",
  sheets_gid="170555219",
  sql_file="sass_function_calls.sql"
) }}

Definir funções personalizadas é algo que tem sido <a hreflang="en" href="https://github.com/w3c/css-houdini-drafts/issues/857">discutido por anos no Houdini</a>, mas estudar as folhas de estilo Sass nos dá dados sobre o quão comum é a necessidade. Muito comum, ao que parece. Pelo menos metade das folhas de estilo SCSS estudadas contém funções personalizadas, uma vez que a folha SCSS média contém não uma, mas duas funções personalizadas.

Existem também <a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5009">recentes</a> <a hreflang="en" href="https://github.com/w3c/csswg-drafts/issues/5624">discussões</a> no CSS WG sobre a introdução de uma forma limitada de condicionais, e Sass nos fornece alguns dados sobre a frequência com que isso é necessário. Quase dois terços das folhas SCSS contêm pelo menos um bloco `@if`, constituindo quase dois terços de todas as instruções de fluxo de controle. Há também uma função `if()` para condicionais dentro dos valores, que é a segunda função mais comumente usada no geral (14%).

{{ figure_markup(
  image="usage-of-control-flow-statements-scss.png",
  caption="Uso de declarações de controle de fluxo no SCSS.",
  description="Gráfico mostrando que `@if` é usado em 63% no desktop e 63% no celular, `@for` está em 55% e 55% respectively, `@each` está em 54% e 55%, e `@while` está em 2% e 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=157473209&format=interactive",
  sheets_gid="498478750",
  sql_file="sass_control_flow_statements.sql"
) }}

Outra especificação futura que está sendo trabalhada atualmente é a <a hreflang="en" href="https://drafts.csswg.org/css-nesting/">CSS Nesting</a>, que nos dará a capacidade de aninhar regras dentro de outras regras de maneira semelhante ao que podemos fazer no Sass e outros pré-processadores usando `&`. Com que frequência o aninhamento é usado em folhas SCSS? Muito, ao que parece. A grande maioria das folhas de estilo SCSS usa pelo menos um seletor explicitamente aninhado, com pseudoclasses (por exemplo, `&:hover`) e classes (por exemplo, `&.active`) perfazendo três quartos dele. E isso não leva em consideração o aninhamento implícito, onde um descendente é assumido e o caractere `&` não é necessário.

{{ figure_markup(
  image="usage-of-explicit-nesting-in-scss.png",
  caption="Uso do aninhamento explícito no SCSS.",
  description="Gráfico de barras mostrando que `Total` é usado em 85% no desktop e 85% no celular, `&:pseudo-class` está em 83% e 83% respectively, `&.class` está em 80% e 80%, `&::pseudo-element` está em 66% e 66%, `& (sozinho)` está em 62% e 62%, `&[attr]` está em 57% e 57%, `& >` 24% e 23%, `& +` 21% e 20%, `& descendant` está em 16% e 15%, e `&#id` está em 6% no desktop e 6% no celular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=370242263&format=interactive",
  sheets_gid="1872903377",
  sql_file="sass_nesting.sql"
) }}

## Conclusão

Uau! Isso foi muito dado! Esperamos que você tenha achado tão interessante quanto nós, e talvez até tenha formado suas próprias percepções sobre alguns deles.

Uma das nossas conclusões foi que bibliotecas populares como WordPress, Bootstrap e Font Awesome são os principais motivadores por trás da adoção de novos recursos, enquanto os desenvolvedores individuais tendem a ser mais conservadores.

Outra observação é que há mais código antigo na web do que código novo. A web, na prática, abrange uma grande variedade, desde código que poderia ter sido escrito 20 anos atrás até tecnologia de ponta que só funciona nos navegadores mais recentes. O que este estudo nos mostrou, entretanto, é que existem recursos poderosos que muitas vezes são mal compreendidos e subutilizados, apesar da boa interoperabilidade.

Também nos mostrou algumas das maneiras como os desenvolvedores desejam usar CSS, mas não podem, e nos deu algumas dicas sobre o que eles acham confuso. Alguns desses dados serão trazidos de volta ao CSS WG para ajudar a impulsionar a evolução do CSS, porque as decisões baseadas em dados são o melhor tipo de decisão.

Estamos entusiasmados com as maneiras como essa análise pode ter um impacto maior na maneira como desenvolvemos sites e estamos ansiosos para ver como essas métricas se desenvolvem ao longo do tempo!
