---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: Capítulo CSS do Web Almanac de 2019 que abrange cor, unidades, seletores, layout, tipografia e fontes, espaçamento, decoração, animação e consultas de mídia.
hero_alt: Hero image of almanac chracters measuring and painting a web page.
authors: [una, argyleink]
reviewers: [meyerweb, huijing]
analysts: [rviscomi]
editors: [rachellcostello]
translators: [HakaCode]
discuss: 1757
results: https://docs.google.com/spreadsheets/d/1uFlkuSRetjBNEhGKWpkrXo4eEIsgYelxY-qR9Pd7QpM/
una_bio: Una Kravets é palestrante internacional, escritora técnica e desenvolvedora de design de materiais do Google que mora no Brooklyn. Una hospeda a websérie <a hreflang="en" href="https://www.youtube.com/watch?v=YK8GZBx3hpg">Designing the Browser</a> e o podcast do <a hreflang="en" href="https://spec.fm/podcasts/toolsday">Toolsday</a>. Siga-a no <a href="https://x.com/una">Twitter</a> para encontrar suas reflexões sobre CSS criativo, experiências do usuário e melhores práticas de desenvolvimento web.Siga-a no
argyleink_bio: Adam Argyle é um membro de relações com desenvolvedores do Google Chrome focado em CSS; Ele é um viciado em web com um desejo insaciável de excelente UX & UI; Encontre-o na web <a href="https://x.com/argyleink">@argyleink</a> ou confira seu site <a hreflang="en" href="https://nerdy.dev">https://nerdy.dev</a>.
featured_quote: Folhas de estilo em cascata (CSS) são usadas para pintar, formatar e fazer o layout de páginas da web. Seus recursos abrangem conceitos tão simples quanto a cor do texto até a perspectiva 3D. Ele também possui ganchos para capacitar os desenvolvedores a lidar com tamanhos de tela variados, contextos de visualização e impressão. O CSS ajuda os desenvolvedores a organizar o conteúdo e garantir que ele se adapte adequadamente ao usuário.
featured_stat_1: 5%
featured_stat_label_1: Pages using custom properties
featured_stat_2: 2%
featured_stat_label_2: Sites that use CSS Grid
featured_stat_3: 780
featured_stat_label_3: Number of digits in largest Z-Index value
---

## Introdução

As Folhas de Estilo em Cascata (CSS) são usadas para pintar, formatar e dispor páginas da web. Suas capacidades abrangem conceitos tão simples quanto a cor do texto até a perspectiva 3D. Ele também tem ganchos para capacitar os desenvolvedores a lidar com tamanhos de tela variados, contextos de visualização e impressão. O CSS ajuda os desenvolvedores a lidar com o conteúdo e garantir que ele se adapte adequadamente ao usuário.

Quando se descreve o CSS para aqueles que não estão familiarizados com a tecnologia web, pode ser útil pensar nele como a linguagem para pintar as paredes da casa; descrevendo o tamanho e a posição das janelas e portas, assim como decorações exuberantes, como papel de parede ou plantas. O detalhe interessante dessa história é que, dependendo do usuário que atravessa a casa, um desenvolvedor pode adaptar a casa às preferências ou contextos específicos desse usuário!

Neste capítulo, estaremos examinando, contabilizando e extraindo dados sobre como o CSS é usado em toda a web. Nosso objetivo é compreender holisticamente quais recursos estão sendo utilizados, como estão sendo utilizados e como o CSS está crescendo e sendo adotado.

Pronto para mergulhar nos fascinantes dados?! Muitos dos números a seguir podem ser pequenos, mas não os considere insignificantes! Pode levar muitos anos para que coisas novas sejam amplamente adotadas na web.

## Cor

A cor é uma parte integral do tema e estilo na web. Vamos dar uma olhada em como os sites costumam usar a cor.

### Tipos de cores

O formato hexadecimal é, de longe, a maneira mais popular de descrever cores, com 93% de uso, seguido por RGB e, em seguida, HSL. Curiosamente, os desenvolvedores estão aproveitando ao máximo o argumento de alfa-transparência quando se trata desses tipos de cores: HSLA e RGBA são muito mais populares do que HSL e RGB, com quase o dobro do uso! Embora a transparência alfa tenha sido adicionada posteriormente à especificação da web,  HSLA e RGBA são suportados <a hreflang="en" href="https://caniuse.com/#feat=css3-colors">desde o IE9</a>, então você pode usá-los sem problemas!

{{ figure_markup(
  image="fig1.png",
  caption="Popularidade dos formatos de cores.",
  description="Gráfico de barras mostrando a adoção dos formatos de cores HSL, HSLA, RGB, RGBA e hexadecimal. O formato hexadecimal é usado em 93% das páginas para desktop, RGBA em 83%, RGB em 22%, HSLA em 19% e HSL em 1%. A adoção entre desktop e dispositivos móveis é semelhante para todos os formatos de cores, exceto para HSL, no qual a adoção em dispositivos móveis é de 9% (9 vezes maior).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1946838030&format=interactive"
  )
}}

### Seleção de cores

Existem <a hreflang="en" href="https://www.w3.org/TR/css-color-4/#named-colors">148 cores nomeadas em CSS</a>, sem incluir os valores especiais `transparent` and `currentcolor`. Você pode usar essas cores pelo nome em formato de texto para obter estilos mais legíveis. As cores nomeadas mais populares são `black` (preto) e `white`(branco), o que não é surpreendente, seguidas por `red` (vermelho) e `blue` (azul).

{{ figure_markup(
  image="fig2.png",
  caption="Principais cores nomeadas.",
  description="Gráfico de pizza mostrando as cores nomeadas mais populares. O branco é o mais popular com 40%, seguido pelo preto com 22%, vermelho com 11% e azul com 5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1985913808&format=interactive",
  width=600,
  height=415,
  data_width=600,
  data_height=415
  )
}}

A língua é interessantemente inferida também através das cores. Existem mais ocorrências do estilo americano "gray" do que do estilo britânico "grey". Quase todas as instâncias de <a hreflang="en" href="https://www.rapidtables.com/web/color/gray-color.html">gray colors</a> (`gray`, `lightgray`, `darkgray`, `slategray`, etc.) tiveram quase o dobro de uso quando grafadas com "a" em vez de "e". Se as variantes gr[a/e]ys fossem combinadas, elas ocupariam uma posição mais alta do que o azul, consolidando-se na quarta posição. Isso pode ser o motivo pelo qual `silver` (prata) está classificado acima de `grey` (cinza) com "e" nos gráficos!

### Contagem de cores

Quantas cores de fonte diferentes são usadas em toda a web? Portanto, isso não é o número total de cores únicas; é apenas quantas cores diferentes são usadas apenas para o texto. Os números neste gráfico são bastante altos e, pela experiência, sabemos que sem variáveis CSS, o espaçamento, tamanhos e cores podem rapidamente se tornar difíceis de gerenciar e se fragmentar em muitos valores pequenos em seus estilos. Esses números refletem uma dificuldade de gerenciamento de estilos, e esperamos que isso ajude a criar uma perspectiva para você levar de volta para suas equipes ou projetos. Como você pode reduzir esse número para uma quantidade gerenciável e razoável?

{{ figure_markup(
  image="fig3.png",
  caption="Distribuição de cores por página.",
  description="Distribuição mostrando os percentis 10, 25, 50, 75 e 90 de cores por página em desktop e dispositivos móveis. Em desktop, a distribuição é de 8, 22, 48, 83 e 131 cores. As páginas em dispositivos móveis tendem a ter 1-10 cores a mais.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1361184636&format=interactive"
  )
}}

### Duplicação de cores

Bem, ficamos curiosos aqui e queríamos verificar quantas cores duplicadas estão presentes em uma página. Sem um sistema CSS de classe reutilizável bem gerenciado, é bastante fácil criar duplicatas. Descobriu-se que a mediana contém cores duplicadas o suficiente para que valha a pena unificá-las com propriedades personalizadas.

{{ figure_markup(
  image="fig4.png",
  caption="Distribuição de cores duplicadas por página.",
  description="Gráfico de barras mostrando a distribuição de cores por página. A mediana das páginas em desktop possui 24 cores duplicadas. O 10º percentil apresenta 4 cores duplicadas e o 90º percentil mostra 62. As distribuições em desktop e dispositivos móveis são semelhantes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=326531498&format=interactive"
  )
}}

## Unidades

No CSS, existem muitas maneiras diferentes de alcançar o mesmo resultado visual usando tipos de unidades diferentes: `rem`, `px`, `em`, `ch`, ou até mesmo `cm`! Então, quais tipos de unidades são os mais populares?

{{ figure_markup(
  image="fig5.png",
  caption="Popularidade dos tipos de unidades.",
  description="Gráfico de barras da popularidade dos vários tipos de unidades. px e em são usados em mais de 90% das páginas. O rem  é o próximo tipo de unidade mais popular, presente em 40% das páginas, e a popularidade cai rapidamente para os demais tipos de unidades restantes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=540111393&format=interactive"
  )
}}

### Comprimento e dimensionamento

Sem surpresa, na Figura 2.5 acima, a unidade `px` é o tipo de unidade mais utilizado, com cerca de 95% das páginas da web usando pixels de alguma forma ou outra (isso pode ser para dimensionamento de elementos, tamanho de fonte, e assim por diante). No entanto, a unidade `em` é quase tão popular, com cerca de 90% de uso. Isso é mais de duas vezes mais popular do que a unidade `rem`, que possui apenas 40% de frequência nas páginas da web. Se você está se perguntando qual é a diferença, `em` é baseado no tamanho da fonte do elemento pai, enquanto `rem` é baseado no tamanho de fonte base definido para a página. O `rem` não muda por componente como poderia acontecer com `em`, permitindo, assim, o ajuste de todo o espaçamento de forma uniforme.

Quando se trata de unidades baseadas em espaço físico, a unidade `cm` (centímetro) é de longe a mais popular, seguida por `in` (polegadas) e, em seguida, `Q`. . Sabemos que esses tipos de unidades são especialmente úteis para folhas de estilo de impressão, mas nem sabíamos que a unidade `Q` existia até esta pesquisa! E você, sabia?

<p class="note">Uma versão anterior deste capítulo discutiu a popularidade inesperada da unidade <code>Q</code>. Graças à  <a hreflang="en" href="https://discuss.httparchive.org/t/chapter-2-css/1757/6">discussão da comunidade</a> em torno deste capítulo, identificamos que isso foi um erro em nossa análise e atualizamos a Figura 2.5 de acordo.</p>

### Unidades baseadas na visualização

Observamos maiores diferenças nos tipos de unidades quando se trata do uso em dispositivos móveis e desktop para unidades baseadas na visualização (Viewport-based units). 36,8% dos sites móveis utilizam a unidade `vh` (altura da visualização), enquanto apenas 31% dos sites de desktop o fazem. Também descobrimos que `vh`  é mais comum do que `vw` (largura da visualização) em cerca de 11%. A unidade `vmin`  (visualização mínima) é mais popular do que `vmax` (visualização máxima), com cerca de 8% de uso de `vmin` em dispositivos móveis, enquanto `vmax` é usado apenas por 1% dos sites.

### Propriedades personalizadas

As propriedades personalizadas são o que muitos chamam de variáveis CSS. No entanto, elas são mais dinâmicas do que uma variável estática típica! São extremamente poderosas e como comunidade, ainda estamos descobrindo o seu potencial.

{{ figure_markup(
  caption="Porcentagem de páginas que utilizam propriedades personalizadas (CSS variables).",
  content="5%",
  classes="big-number"
)
}}

WSentimos que essa é uma informação empolgante, pois mostra um crescimento saudável de uma de nossas adições favoritas ao CSS. Elas estão disponíveis em todos os principais navegadores desde 2016 ou 2017, então é justo dizer que são relativamente novas. Muitas pessoas ainda estão fazendo a transição de suas variáveis de pré-processadores CSS para propriedades personalizadas do CSS. Estimamos que levará mais alguns anos até que as propriedades personalizadas se tornem a norma.

## Seletores

### Seletores de ID vs. classe

O CSS possui algumas maneiras de encontrar elementos na página para estilização, então vamos comparar IDs e classes para ver qual é mais prevalente! Os resultados não devem ser muito surpreendentes: as classes são mais populares!

{{ figure_markup(
  image="fig7.png",
  caption="Popularidade dos tipos de seletores por página.",
  description="Gráfico de barras mostrando a adoção dos tipos de seletores de ID e classe. Classes são utilizadas em 95% das páginas para desktop e dispositivos móveis. IDs são utilizados em 89% das páginas para desktop e 87% das páginas para dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1216272563&format=interactive"
  )
}}

Um gráfico de acompanhamento interessante é este, mostrando que as classes representam 93% dos seletores encontrados em uma folha de estilos.

{{ figure_markup(
  image="fig8.png",
  caption="Popularidade dos tipos de seletores por seletor.",
  description="Gráfico de barras mostrando que 94% dos seletores incluem o seletor de classe para desktop e dispositivos móveis, enquanto 7% dos seletores para desktop incluem o seletor de ID (8% para dispositivos móveis).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=351006989&format=interactive"
  )
}}

### Seletores de atributos

O CSS possui seletores de comparação muito poderosos. São seletores como `[target="_blank"]`, `[attribute^="value"]`, `[title~="rad"]`, `[attribute$="-rad"]` ou `[attribute*="value"]`. Você os usa? Acha que são muito utilizados? Vamos comparar como eles são usados em relação a IDs e classes em toda a web.

{{ figure_markup(
  image="fig9.png",
  caption="Popularidade dos operadores por seletor de atributos de ID.",
  description='Gráfico de barras mostrando a popularidade dos operadores utilizados pelos seletores de atributos de ID. Cerca de 4% das páginas para desktop e dispositivos móveis utilizam o operador "estrela-igual" e "acentos-igual". 1% das páginas utilizam o operador "igual" e "dólar-igual". Nenhuma página utiliza o operador "til-igual"',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=695879874&format=interactive"
  )
}}

{{ figure_markup(
  image="fig10.png",
  caption="Popularidade dos operadores por seletor de atributos de classe.",
  description='Gráfico de barras mostrando a popularidade dos operadores utilizados pelos seletores de atributos de classe. 57% das páginas utilizam o operador "estrela-igual". 36% utilizam o operador "acentos-igual". 1% utilizam o operador "igual" e "dólar-igual". Nenhuma página utiliza o operador "til-igual".',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=377805296&format=interactive"
  )
}}

Esses operadores são muito mais populares com seletores de classe do que com IDs, o que parece natural, já que uma folha de estilos geralmente tem menos seletores de ID do que seletores de classe, mas ainda é interessante ver o uso de todas essas combinações.

### Classes por elemento

Com o surgimento de estratégias de CSS como OOCSS, CSS atômico e CSS funcional, que podem compor 10 ou mais classes em um elemento para obter um design específico, talvez pudéssemos ver alguns resultados interessantes. A consulta retornou resultados bastante pouco empolgantes, com a mediana tanto em dispositivos móveis quanto em desktop sendo de 1 classe por elemento.

{{ figure_markup(
  caption="Número médio de nomes de classe por atributo de classe (desktop e dispositivos móveis).",
  content="1",
  classes="big-number"
)
}}

## Layout

### Flexbox

[Flexbox](https://developer.mozilla.org/pt-BR/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox) é um estilo de contêiner que direciona e alinha seus elementos filhos; ou seja, ele auxilia no layout de forma baseada em restrições. No início, teve um começo conturbado na web, pois sua especificação passou por duas ou três mudanças bastante drásticas entre 2010 e 2013. Felizmente, foi estabilizado e implementado em todos os navegadores até 2014. Devido a essa história, teve uma adoção lenta, mas já se passaram alguns anos desde então! Atualmente, é bastante popular e existem muitos artigos sobre como utilizá-lo, mas ainda é uma técnica de layout relativamente nova em comparação com outras.

{{ figure_markup(
  image="fig12.png",
  caption="Adoção do flexbox.",
  description="Gráfico de barras mostrando que 49% das páginas para desktop e 52% das páginas para dispositivos móveis utilizam flexbox.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2021161093&format=interactive"
  )
}}

Uma história de sucesso bastante evidente aqui, já que quase 50% da web utiliza flexbox em suas folhas de estilo.

### Grid

Assim como o flexbox, [grid](https://developer.mozilla.org/pt-BR/docs/Web/CSS/CSS_Grid_Layout) também passou por algumas alterações na especificação no início de sua existência, mas sem alterar as implementações em navegadores publicamente disponíveis. A Microsoft tinha o grid nas primeiras versões do Windows 8, como o mecanismo de layout principal para seu estilo de design de rolagem horizontal. Ele foi testado lá primeiro, depois transicionado para a web e, em seguida, aprimorado pelos outros navegadores até o seu lançamento final em 2017. Ele teve um lançamento muito bem-sucedido, já que quase todos os navegadores lançaram suas implementações ao mesmo tempo, permitindo que os desenvolvedores da web acordassem um dia com um suporte excelente para grid. Hoje, no final de 2019, o grid ainda parece ser uma novidade, pois as pessoas ainda estão descobrindo o seu poder e capacidades.

{{ figure_markup(
  caption="Porcentagem de sites usando grid.",
  content="2%",
  classes="big-number"
)
}}

Isso mostra o quão pouco a comunidade de desenvolvimento web tem exercitado e explorado sua mais recente ferramenta de layout. Estamos ansiosos pela eventual adoção do grid como o mecanismo de layout principal em que as pessoas contarão ao construir um site. Para nós, autores, adoramos escrever usando o grid: geralmente recorremos a ele primeiro e, em seguida, reduzimos a complexidade à medida que percebemos e iteramos no layout. Ainda resta ver o que o restante do mundo fará com esse recurso poderoso do CSS nos próximos anos.

### Modos de escrita

A web e o CSS são recursos de plataforma internacional, e os modos de escrita oferecem uma maneira para o HTML e o CSS indicarem a direção de leitura e escrita preferida do usuário dentro de nossos elementos.

{{ figure_markup(
  image="fig14.png",
  caption="Popularidade dos valores de direção.",
  description="Gráfico de barras mostrando a popularidade dos valores de direção ltr e rtl. ltr é utilizado por 32% das páginas para desktop e 40% das páginas para dispositivos móveis. rtl é utilizado por 32% das páginas para desktop e 36% das páginas para dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=136847988&format=interactive"
  )
}}

## Tipografia

### Fontes da web por página

Quantas fontes da web você está carregando em sua página da web: 0? 10? O número mediano de fontes da web por página é 3!

{{ figure_markup(
  image="fig15.png",
  caption="Distribuição do número de fontes da web carregadas por página.",
  description="Distribuição do número de fontes da web carregadas por página. No desktop, os percentis 10, 25, 50, 75 e 90 são: 0, 1, 3, 6 e 9. Isso é ligeiramente maior do que a distribuição em dispositivos móveis, que possui uma fonte a menos nos percentis 75 e 90..",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1453570774&format=interactive"
  )
}}

### Famílias de fontes populares

Uma continuação natural da investigação sobre o número total de fontes por página é: quais são essas fontes?! Designers, atentem-se, pois agora vocês verão se suas escolhas estão de acordo com o que é popular ou não.

{{ figure_markup(
  image="fig16.png",
  caption="Principais fontes da web.",
  description="Gráfico de barras das fontes mais populares. Entre as páginas para desktop, elas são: Open Sans (24%), Roboto (15%), Montserrat (5%), Source Sans Pro (4%), Noto Sans JP (3%), and Lato (3%). Nos dispositivos móveis, as diferenças mais notáveis são que o Open Sans é utilizado 22% do tempo (caiu de 24%) e o Roboto é usado 19% do tempo (aumentou de 15%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1883567922&format=interactive",
  width=600,
  height=450,
  data_width=600,
  data_height=450
  )
}}

Open Sans é um grande vencedor aqui, com quase 1 em cada 4 declarações de `@font-family` CSS especificando-o. Definitivamente, usamos Open Sans em projetos em agências.

Também é interessante observar as diferenças entre a adoção em desktop e dispositivos móveis. Por exemplo, as páginas para dispositivos móveis usam Open Sans um pouco menos frequentemente do que em desktop. Enquanto isso, eles também usam Roboto um pouco mais frequentemente.

### Tamanhos de fonte

Este é um ponto interessante, pois se você perguntasse a um usuário quantos tamanhos de fonte eles acham que existem em uma página, eles geralmente retornariam um número de 5 ou definitivamente menos de 10. Mas será que essa é a realidade? Mesmo em um sistema de design, quantos tamanhos de fonte existem? Pesquisamos a web e descobrimos que a mediana é de 40 para dispositivos móveis e 38 para desktop. Pode ser hora de pensar seriamente sobre propriedades personalizadas ou criar algumas classes reutilizáveis para ajudar a distribuir melhor sua hierarquia tipográfica.

{{ figure_markup(
  image="fig17.png",
  caption="Distribuição do número de tamanhos de fonte distintos por página.",
  description="Gráfico de barras mostrando a distribuição de tamanhos de fonte distintos por página. Para as páginas em desktop, os percentis 10, 25, 50, 75 e 90 são: 8, 20, 40, 66 e 92 tamanhos de fonte. A distribuição em desktop diverge da distribuição em dispositivos móveis no percentil 75, onde é maior em 7 a 13 tamanhos distintos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1695270216&format=interactive"
  )
}}

## Espaçamento

### Margens

A margem é o espaço fora dos elementos, como o espaço que você cria quando estende seus braços para longe de si mesmo. Isso muitas vezes se parece com o espaçamento entre elementos, mas não se limita a esse efeito. Em um site ou aplicativo, o espaçamento desempenha um papel importante na experiência do usuário e no design. Vamos ver quantos códigos de espaçamento de margem existem em uma folha de estilos, certo?

{{ figure_markup(
  image="fig18.png",
  caption="Distribuição do número de valores de margem distintos por página.",
  description="Gráfico de barras mostrando a distribuição de valores de margem distintos por página. Para as páginas em desktop, os percentis 10, 25, 50, 75 e 90 são: 12, 47, 96, 167 e 248 valores de margem distintos. A distribuição em desktop diverge da distribuição em dispositivos móveis no percentil 75, onde é menor em 12 a 31 valores distintos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=4233531&format=interactive"
  )
}}

Parece ser uma quantidade considerável! A página média em desktop possui 96 valores de margem distintos e 104 em dispositivos móveis. Isso resulta em muitos momentos únicos de espaçamento em seu design. Curioso para saber quantas margens você tem em seu site? Como podemos tornar todo esse espaço em branco mais gerenciável?

### Propriedades lógicas

{{ figure_markup(
  caption="Porcentagem de páginas para desktop e dispositivos móveis que incluem propriedades lógicas.",
  content="0.6%",
  classes="big-number"
)
}}

Estimamos que a hegemonia de `margin-left` e `padding-top` em uma duração limitada, prestes a ser substituída por sua sintaxe de propriedade lógica sucessiva, independente da direção de escrita. Embora estejamos otimistas, o uso atual é bastante baixo, com 0,67% de utilização em páginas para desktop. Para nós, isso parece ser uma mudança de hábito que precisaremos desenvolver como indústria, enquanto esperamos treinar novos desenvolvedores para utilizarem a nova sintaxe.

### z-index

O empilhamento vertical, ou "stacking", pode ser gerenciado com `z-index` o CSS. Estávamos curiosos para saber quantos valores diferentes as pessoas usam em seus sites. A faixa do que o `z-index` aceita é teoricamente infinita, limitada apenas pelas limitações de tamanho variável do navegador. Será que todas essas posições de empilhamento são utilizadas? Vamos ver!

{{ figure_markup(
  image="fig20.png",
  caption="Distribuição do número de valores distintos de <code>z-index</code> por página",
  description="Gráfico de barras mostrando a distribuição de valores distintos de z-index por página. Para as páginas em desktop, os percentis 10, 25, 50, 75 e 90 são: 1, 7, 16, 26 e 36 valores distintos de z-index. A distribuição em desktop é muito maior do que em dispositivos móveis, com até 16 valores distintos a mais no percentil 90.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1320871189&format=interactive"
  )
}}

### Valores populares de z-index

Com base em nossa experiência de trabalho, qualquer número com vários noves parecia ser a escolha mais popular. Mesmo que tenhamos aprendido a usar o menor número possível, isso não é a norma comum. Então, o que é então?! Se as pessoas precisam que algo fique acima de outros elementos, quais são os números mais populares de `z-index` a serem utilizados? Pode colocar a bebida de lado; este é engraçado o suficiente para fazer você perdê-la.

{{ figure_markup(
  image="fig21.png",
  caption="Valores de <code>z-index</code> mais frequentemente utilizados.",
  description="Gráfico de dispersão de todos os valores conhecidos de z-index e a quantidade de vezes que são utilizados, tanto para desktop como para dispositivos móveis. 1 e 2 são os mais frequentemente utilizados, mas o restante dos valores populares explodem em ordens de magnitude: 10, 100, 1.000 e assim por diante, chegando a números com centenas de dígitos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1169148473&format=interactive"
  )
}}

{{ figure_markup(
  caption="O maior valor conhecido de <code>z-index</code>.",
  content="999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 !important",
  classes="really-big-number"
)
}}

## Decoração

### Filtros

Os filtros são uma forma divertida e ótima de modificar os pixels que o navegador pretende desenhar na tela. É um efeito de pós-processamento que é aplicado a uma versão plana do elemento, nó ou camada a que está sendo aplicado. O Photoshop os tornou fáceis de usar e, em seguida, o Instagram os tornou acessíveis às massas através de combinações estilizadas exclusivas. Eles existem desde cerca de 2012, existem 10 deles e podem ser combinados para criar efeitos únicos.

{{ figure_markup(
  caption="Porcentagem de páginas que incluem uma folha de estilos com a propriedade <code>filter</code>.",
  content="78%",
  classes="big-number"
)
}}

Ficamos animados ao ver que 78% das folhas de estilos contêm a propriedade `filter`! Esse número também era tão alto que parecia um pouco suspeito, então investigamos para explicar o alto valor. Porque sejamos honestos, os filtros são legais, mas eles não estão presentes em todas as nossas aplicações e projetos. A menos que!

Após uma investigação mais detalhada, descobrimos que a folha de estilos do <a hreflang="en" href="https://fontawesome.com">FontAwesome</a>contém algum uso de `filter` , assim como um vídeo embutido do <a hreflang="en" href="https://youtube.com">YouTube</a>. Portanto, acreditamos que a propriedade `filter` acabou sendo incluída através do uso compartilhado em algumas folhas de estilos muito populares. Também acreditamos que a presença do `-ms-filter` pode ter contribuído para a alta porcentagem de uso.

### Modos de mesclagem

Os modos de mesclagem são semelhantes aos filtros no sentido de que são um efeito de pós-processamento executado contra uma versão plana de seus elementos-alvo, mas são únicos porque estão relacionados à convergência de pixels. Dito de outra forma, os modos de mesclagem determinam como 2 pixels _devem_  interagir quando se sobrepõem. O elemento que está acima ou abaixo afetará a forma como o modo de mesclagem manipula os pixels. Existem 16 modos de mesclagem - vamos ver quais são os mais populares.

{{ figure_markup(
  caption="Porcentagem de páginas que incluem uma folha de estilos com a propriedade <code>*-blend-mode</code>.",
  content="8%",
  classes="big-number"
)
}}

No geral, o uso dos modos de mesclagem é muito menor em comparação com os filtros, mas ainda é suficiente para ser considerado moderadamente utilizado.

Em uma edição futura do Web Almanac, seria ótimo aprofundar o uso dos modos de mesclagem para ter uma ideia dos modos exatos que os desenvolvedores estão usando, como multiplicar, tela, queimar cor, iluminar, etc.

## Animação

### Transições

O CSS possui esse incrível poder de interpolação que pode ser facilmente utilizado escrevendo apenas uma regra para fazer a transição desses valores. Se você está usando o CSS para gerenciar estados em seu aplicativo, com que frequência você está empregando transições para realizar a tarefa? Vamos consultar a web!

{{ figure_markup(
  image="fig25.png",
  caption="Distribuição do número de transições por página.",
  description="Gráfico de barras mostrando a distribuição de transições por página. Para as páginas em desktop, os percentis 10, 25, 50, 75 e 90 são: 0, 2, 16, 49 e 118 transições. A distribuição em desktop é muito menor do que em dispositivos móveis, com até 77 transições a menos no percentil 90.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=419145172&format=interactive"
  )
}}

Isso é muito bom! Vimos a biblioteca `animate.css` como uma biblioteca popular a ser incluída, que traz várias animações de transição, mas ainda é bom ver que as pessoas estão considerando a transição em suas interfaces de usuário.

### Animações com Keyframes

As animações de keyframes do CSS são uma ótima solução para animações ou transições mais complexas. Elas permitem ser mais explícitas, o que oferece um maior controle sobre os efeitos. Elas podem ser simples, com apenas um efeito de keyframe, ou serem grandes, com muitos efeitos de keyframe compostos em uma animação robusta. O número médio de animações com keyframes por página é muito menor do que as transições CSS.

{{ figure_markup(
  image="fig26.png",
  caption="Distribuição do número de keyframes por página.",
  description="Gráfico de barras mostrando a distribuição de keyframes por página. Para as páginas em dispositivos móveis, os percentis 10, 25, 50, 75 e 90 são: 0, 0, 3, 18 e 76 keyframes. A distribuição em dispositivos móveis é ligeiramente maior do que em desktop, com 6 keyframes a mais no percentil 75 e 90.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=11848448&format=interactive"
  )
}}

## Consultas de mídia

As consultas de mídia permitem que o CSS se conecte a várias variáveis de nível do sistema para se adaptar adequadamente ao usuário que está visitando a página. Algumas dessas consultas podem lidar com estilos de impressão, estilos de tela de projetor e tamanho de viewport/tela. Por muito tempo, as consultas de mídia eram principalmente utilizadas para o conhecimento do viewport. Designers e desenvolvedores podiam adaptar seus layouts para telas pequenas, grandes e assim por diante. Mais tarde, a web passou a oferecer cada vez mais capacidades e consultas, o que significa que as consultas de mídia agora podem gerenciar recursos de acessibilidade além das características do viewport.

Um bom ponto de partida para as consultas de mídia é saber quantas delas são usadas por página? Quantos momentos ou contextos diferentes a página típica deseja responder?

{{ figure_markup(
  image="fig27.png",
  caption="Distribuição do número de consultas de mídia por página.",
  description="Gráfico de barras mostrando a distribuição de consultas de mídia por página. Para as páginas em desktop, os percentis 10, 25, 50, 75 e 90 são: 0, 3, 14, 27 e 43 consultas de mídia. A distribuição em desktop é similar à distribuição em dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1892465673&format=interactive"
  )
}}

### Tamanhos de pontos de interrupção de consulta de mídia populares

Para as consultas de mídia do viewport, qualquer tipo de unidade CSS pode ser usada na expressão da consulta para avaliação. Nos primeiros dias, as pessoas costumavam usar `em` e `px` na consulta, mas ao longo do tempo foram adicionadas mais unidades, despertando nossa curiosidade sobre os tipos de tamanhos encontrados comumente na web. Supomos que a maioria das consultas de mídia seguirá tamanhos populares de dispositivos, mas ao invés de supor, vamos analisar os dados!

{{ figure_markup(
  image="fig28.png",
  caption="Pontos de interrupção mais frequentemente usados em consultas de mídia.",
  description="Gráfico de barras dos pontos de interrupção mais populares em consultas de mídia. 768px e 767px são os mais populares, com 23% e 16%, respectivamente. A lista diminui rapidamente após esses tamanhos, com 992px sendo usado em 6% das vezes e 1200px em 4% das vezes. O uso em desktop e dispositivos móveis é similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1353707515&format=interactive"
  )
}}

A Figura 2.28 acima mostra que parte de nossas suposições estavam corretas: certamente há uma quantidade considerável de tamanhos específicos para dispositivos móveis, mas também há alguns que não são. É interessante notar também que os tamanhos são dominados principalmente por valores em pixels, com algumas entradas utilizando `em`, que estão além do escopo deste gráfico.

### Uso de retrato vs paisagem

O valor de consulta mais popular dentre os tamanhos de ponto de interrupção populares parece ser `768px`, o que nos deixou curiosos. Esse valor é principalmente utilizado para mudar para um layout em retrato, já que pode ser baseado na suposição de que `768px` representa o tamanho típico da visualização móvel em modo retrato? Então, realizamos uma consulta adicional para verificar a popularidade do uso dos modos retrato e paisagem:

{{ figure_markup(
  image="fig29.png",
  caption="Adoção dos modos de orientação de consulta de mídia.",
  description="Gráfico de barras mostrando a adoção dos modos de orientação retrato e paisagem nas consultas de mídia. 31% das páginas especificam o modo paisagem, 8% especificam o modo retrato e 7% especificam ambos. A adoção é a mesma para páginas em desktop e dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=295845630&format=interactive"
  )
}}

Curiosamente, o modo `retrato` não é muito utilizado, enquanto o modo `paisagem` é muito mais usado. Podemos supor que `768px` tem sido considerado confiável o suficiente como o caso de layout em retrato, sendo assim, é menos utilizado. Também podemos supor que pessoas em um computador desktop, testando seu trabalho, não podem visualizar facilmente o modo retrato para ver o layout em dispositivos móveis, ao contrário de apenas ajustar o tamanho do navegador. É difícil afirmar com certeza, mas os dados são fascinantes.

### Tipos de unidades mais populares

Nas consultas de mídia para largura e altura que analisamos até agora, os pixels parecem ser a unidade dominante escolhida pelos desenvolvedores para adaptar suas interfaces de usuário aos viewports. No entanto, queríamos fazer uma consulta exclusiva sobre isso e realmente analisar os tipos de unidades que as pessoas usam. Aqui está o que encontramos.

{{ figure_markup(
  image="fig30.png",
  caption="Adoção de unidades em pontos de interrupção de consultas de mídia.",
  description="Gráfico de barras mostrando que 75% dos pontos de interrupção de consulta de mídia especificam pixels, 8% especificam ems e 1% especifica rems.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=305563768&format=interactive"
  )
}}

### `min-width` vs `max-width`

Quando as pessoas escrevem uma consulta de mídia, elas geralmente estão verificando se o viewport está acima ou abaixo de um intervalo específico, _ou_ ambas, verificando se está entre um intervalo de tamanhos? Vamos perguntar à web!

{{ figure_markup(
  image="fig31.png",
  caption="Adoção das propriedades usadas nos pontos de interrupção de consultas de mídia.",
  description="Gráfico de barras mostrando que 74% das páginas de desktop usam max-width, 70% usam min-width e 68% usam ambas as propriedades. A adoção é semelhante para páginas móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2091525146&format=interactive"
  )
}}

Aqui não há vencedores claros; `max-width` e `min-width`  são usados quase igualmente.

### Impressão e Fala

Sites da web são como papel digital, certo? Como usuários, é geralmente sabido que você pode simplesmente clicar em "imprimir" no seu navegador e transformar esse conteúdo digital em conteúdo físico. Um site não é obrigado a se adaptar para esse caso de uso, mas pode fazê-lo se quiser! Menos conhecida é a capacidade de ajustar o site para ser lido por uma ferramenta ou robô. Então, com que frequência esses recursos são aproveitados?

{{ figure_markup(
  image="fig32.png",
  caption='Adoção dos tipos de media queries "all", "print", "screen" e "speech".',
  description='Gráfico de barras mostrando que 35% das páginas de desktop usam o tipo de media query "all", 46% usam "print", 72% usam "screen" e 0% usam "speech". A adoção é menor em cerca de 5 pontos percentuais para desktop em comparação com dispositivos móveis.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=939890574&format=interactive"
  )
}}

## Estatísticas por página

### Folhas de estilos

Quantas folhas de estilos você referencia na sua página inicial? Quantas no seu aplicativo? Você serve mais ou menos para dispositivos móveis em comparação com desktops? Aqui está um gráfico de todos os outros!

{{ figure_markup(
  image="fig33.png",
  caption="Distribuição do número de folhas de estilos carregadas por página.",
  description="Gráfico mostrando a distribuição do número de folhas de estilos carregadas por página. Desktop e dispositivos móveis têm distribuições idênticas com os seguintes percentis: 10º, 25º, 50º, 75º e 90º: 1, 3, 6, 12 e 20 folhas de estilos por página.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1377313548&format=interactive"
  )
}}

### Nomes de folhas de estilos

Como você nomeia suas folhas de estilos? Você tem sido consistente ao longo da sua carreira? Você tem convergido lentamente ou divergido consistentemente? Este gráfico mostra uma pequena visão da popularidade das bibliotecas, mas também uma grande visão dos nomes populares dos arquivos CSS.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Nome da folha de estilos</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>style.css</td>
        <td class="numeric">2.43%</td>
        <td class="numeric">2.55%</td>
      </tr>
      <tr>
        <td>font-awesome.min.css</td>
        <td class="numeric">1.86%</td>
        <td class="numeric">1.92%</td>
      </tr>
      <tr>
        <td>bootstrap.min.css</td>
        <td class="numeric">1.09%</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td>BfWyFJ2Rl5s.css</td>
        <td class="numeric">0.67%</td>
        <td class="numeric">0.66%</td>
      </tr>
      <tr>
        <td>style.min.css?ver=5.2.2</td>
        <td class="numeric">0.64%</td>
        <td class="numeric">0.67%</td>
      </tr>
      <tr>
        <td>styles.css</td>
        <td class="numeric">0.54%</td>
        <td class="numeric">0.55%</td>
      </tr>
      <tr>
        <td>style.css?ver=5.2.2</td>
        <td class="numeric">0.41%</td>
        <td class="numeric">0.43%</td>
      </tr>
      <tr>
        <td>main.css</td>
        <td class="numeric">0.43%</td>
        <td class="numeric">0.39%</td>
      </tr>
      <tr>
        <td>bootstrap.css</td>
        <td class="numeric">0.40%</td>
        <td class="numeric">0.42%</td>
      </tr>
      <tr>
        <td>font-awesome.css</td>
        <td class="numeric">0.37%</td>
        <td class="numeric">0.38%</td>
      </tr>
      <tr>
        <td>style.min.css</td>
        <td class="numeric">0.37%</td>
        <td class="numeric">0.37%</td>
      </tr>
      <tr>
        <td>styles__ltr.css</td>
        <td class="numeric">0.38%</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td>default.css</td>
        <td class="numeric">0.36%</td>
        <td class="numeric">0.36%</td>
      </tr>
      <tr>
        <td>reset.css</td>
        <td class="numeric">0.33%</td>
        <td class="numeric">0.37%</td>
      </tr>
      <tr>
        <td>styles.css?ver=5.1.3</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.35%</td>
      </tr>
      <tr>
        <td>custom.css</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.33%</td>
      </tr>
      <tr>
        <td>print.css</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.28%</td>
      </tr>
      <tr>
        <td>responsive.css</td>
        <td class="numeric">0.28%</td>
        <td class="numeric">0.31%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Nomes de folhas de estilos mais frequentemente usados.") }}</figcaption>
</figure>

Olhe todos esses nomes de arquivo criativos! style, styles, main, default, all. Porém, um se destacou, você o vê? `BfWyFJ2Rl5s.css` ocupa a quarta posição como mais popular. Fizemos uma pesquisa sobre ele e nossa melhor suposição é que esteja relacionado aos botões de "curtir" do Facebook. Você sabe o que é esse arquivo? Deixe um comentário, pois adoraríamos ouvir a história.

### Tamanho dos Arquivos de Estilo

Qual é o tamanho desses arquivos de estilo? O tamanho do nosso CSS é motivo de preocupação? Com base nesses dados, nosso CSS não é uma das principais causas de inchaço das páginas.

{{ figure_markup(
  image="fig35.png",
  caption="Distribuição do número de bytes (KB) de arquivos de estilo carregados por página.",
  description="Distribuição do número de bytes de arquivos de estilo carregados por página. Os percentis 10, 25, 50, 75 e 90 das páginas de desktop são: 8, 26, 62, 129 e 240 KB. A distribuição para desktop é ligeiramente maior do que a distribuição para mobile em 5 a 10 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2132635319&format=interactive"
  )
}}

Consulte o capítulo [Peso da Página](./page-weight) para uma análise mais detalhada do número de bytes que os sites estão carregando para cada tipo de conteúdo.

### Bibliotecas

É comum, popular, conveniente e poderoso recorrer a uma biblioteca de CSS para iniciar um novo projeto. Embora você possa não ser alguém que recorre a uma biblioteca, pesquisamos a web em 2019 para ver quais estão liderando o grupo. Se os resultados o surpreenderem, assim como nos surpreenderam, acredito que é uma pista interessante de quão pequena pode ser a bolha de desenvolvedores em que vivemos. As coisas podem parecer extremamente populares, mas quando a web é consultada, a realidade é um pouco diferente.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Bibliotecas</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Bootstrap</td>
        <td class="numeric">27.8%</td>
        <td class="numeric">26.9%</td>
      </tr>
      <tr>
        <td>animate.css</td>
        <td class="numeric">6.1%</td>
        <td class="numeric">6.4%</td>
      </tr>
      <tr>
        <td>ZURB Foundation</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">2.6%</td>
      </tr>
      <tr>
        <td>UIKit</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Material Design Lite</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>Materialize CSS</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Pure CSS</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Angular Material</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Semantic-ui</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>Bulma</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>Ant Design</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>tailwindcss</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>Milligram</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td>Clarity</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Porcentagem de páginas que incluem uma determinada biblioteca de CSS.") }}</figcaption>
</figure>

Este gráfico sugere que o <a hreflang="en" href="https://getbootstrap.com/">Bootstrap</a> é uma biblioteca valiosa para se conhecer e pode ajudar a obter emprego. Veja todas as oportunidades que existem para ajudar! Também vale ressaltar que este é um gráfico de sinais positivos apenas: a matemática não totaliza 100% porque nem todos os sites estão usando um framework de CSS. Pouco mais da metade de todos os sites _não estão_ usando um framework de CSS conhecido. Muito interessante, não é?

### utilitários de redefinição

As ferramentas de reset de CSS têm a intenção de normalizar ou criar uma linha de base para os elementos nativos da web. Caso você não saiba, cada navegador serve seu próprio arquivo de estilo para todos os elementos HTML, e cada navegador toma decisões únicas sobre como esses elementos devem parecer ou se comportar. As ferramentas de reset analisam esses arquivos, encontram pontos comuns (ou não) e resolvem quaisquer diferenças para que você, como desenvolvedor, possa estilizar em um navegador e ter uma confiança razoável de que ele parecerá o mesmo em outro.

Então vamos dar uma olhada em quantos sites estão usando uma! A existência delas parece bastante razoável, então quantas pessoas concordam com suas táticas e as utilizam em seus sites?

{{ figure_markup(
  image="fig37.png",
  caption="Adoção de utilitários de redefinição de CSS.",
  description="Gráfico de barras mostrando a adoção de três utilitários de redefinição de CSS: Normalize.css (33%), Reset CSS (3%) e Pure CSS (0%). Não há diferença na adoção entre páginas de desktop e mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1318910215&format=interactive"
  )
}}

Parece que cerca de um terço da web está usando o <a hreflang="en" href="https://necolas.github.io/normalize.css">`normalize.css`</a>, que pode ser considerado uma abordagem mais suave para a tarefa do que um reset. Investigamos um pouco mais e descobrimos que o Bootstrap inclui o `normalize.css`, o que provavelmente representa uma grande parte de sua utilização. Vale ressaltar também que o `normalize.css`  tem uma adoção maior do que o Bootstrap, o que significa que muitas pessoas o estão utilizando de forma independente.

### `@supports` e `@import`

O `@supports` do CSS é uma maneira para o navegador verificar se uma combinação específica de propriedade-valor é interpretada como válida e, em seguida, aplicar estilos se a verificação retornar como verdadeira.

{{ figure_markup(
  image="fig38.png",
  caption='Popularidade das regras "at" do CSS',
  description='Gráfico de barras mostrando a popularidade das regras @import e @supports "at". . No desktop, @import é usado em 28% das páginas e @supports é usado em 31%. Para dispositivos móveis, @import é usado em 26% das páginas e @supports is é usado em 29%.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1739611283&format=interactive"
  )
}}

Considerando que o `@supports` foi implementado na maioria dos navegadores em 2013, não é surpreendente ver uma quantidade elevada de uso e adoção. Estamos impressionados com a atenção dos desenvolvedores aqui. Isso é codificação considerada! 30% de todos os sites estão verificando algum suporte relacionado à exibição antes de usá-lo.

Um acompanhamento interessante disso é que há mais uso do `@supports` do que `@imports`! Não esperávamos por isso! O `@import` está nos navegadores desde 1994.

## Conclusão

Há muito mais aqui para explorar em dados! Muitos dos resultados nos surpreenderam, e esperamos que também tenham surpreendido você. Esse conjunto de dados surpreendente tornou a tarefa de resumir muito divertida e nos deixou com muitas pistas e caminhos para investigar se quisermos descobrir as razões por que alguns dos resultados são como são.

Quais resultados você achou mais alarmantes?
Quais resultados o levam a acessar rapidamente sua base de código para fazer uma consulta?

Nós consideramos que a maior conclusão a ser tirada desses resultados é que as propriedades personalizadas oferecem o melhor custo-benefício em termos de desempenho, organização e escalabilidade das suas folhas de estilo. Estamos ansiosos para vasculhar novamente as folhas de estilo da internet, em busca de novos dados e gráficos interessantes. Entre em contato com [@una](https://x.com/una) ou [@argyleink](https://x.com/argyleink) nos comentários com suas consultas, perguntas e afirmações. Gostaríamos de ouvi-las!
