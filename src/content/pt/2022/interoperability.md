---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Interoperabilidade
description: Capítulo de Interoperabilidade do Web Almanac de 2022 cobrindo Compat 2021 (Grid e Flexbox) e Interop 2022 (Formulários, Rolagem, Tipografia e codificações, Diálogo, Contenção, Subgrid, Espaços de cor, Unidades de viewport e Camadas de cascata)
authors: [bkardell]
reviewers: [meyerweb, foolip]
analysts: [rviscomi, kevinfarrugia]
editors: [tunetheweb]
translators: [HakaCode]
bkardell_bio: Brian Kardell é um defensor de desenvolvedores e Representante do Comitê Consultivo W3C na <a hreflang="en" href="https://igalia.com">Igalia</a>, uma contribuidora de padrões, <a hreflang="en" href="https://bkardell.com">blogger</a>. . Ele foi um dos fundadores do Grupo Comunitário da Web Extensível e co-autor do <a hreflang="en" href="https://extensiblewebmanifesto.org">Manifesto da Web Extensível</a>.
results: https://docs.google.com/spreadsheets/d/1w3GzzTNeKxafFODmjDs6OC2dseNEDDKwUV8KeSgRI1Y/
featured_quote: A interoperabilidade é um objetivo fundamental dos padrões, mas às vezes não conseguimos alcançá-lo totalmente. Este capítulo começará a fornecer uma atualização anual aos desenvolvedores sobre os esforços para se unirem e melhorar as coisas. Ele abordará o que é novo ou foi aprimorado em termos de interoperabilidade este ano e fornecerá um meio para os implementadores medirem os impactos ao longo do tempo.
featured_stat_1: 309%
featured_stat_label_1: O aumento no uso de CSS `aspect-ratio` entre abril de 2021 e setembro de 2022
featured_stat_2: 0.3%
featured_stat_label_2: A porcentagem de sites usando o novo elemento `dialog` interoperável até setembro de 2022.
featured_stat_3: 4%
featured_stat_label_3: Páginas móveis usando o CSS `containment` recentemente interoperável. Essa compatibilidade é fundamental para as Consultas de Contêiner.
---

## Introduction

Em 2019, o Conselho Consultivo de Produtos da Mozilla Developer Network (MDN) realizou uma pesquisa significativa com mais de 28.000 desenvolvedores e designers de 173 países. Os resultados dessa pesquisa foram publicados como o primeiro <a hreflang="en" href="https://insights.developer.mozilla.org/reports/pdf/MDN-Web-DNA-Report-2019.pdf">Web Developer Needs Assessment</a> (Web DNA). Este estudo identificou, entre outras coisas, que algumas das frustrações e pontos problemáticos mais significativos frequentemente envolviam diferenças entre navegadores. Em 2020, isso resultou em um acompanhamento conhecido como o <a hreflang="en" href="https://insights.developer.mozilla.org/reports/mdn-browser-compatibility-report-2020.html">Relatório de Compatibilidade entre Navegadores MDN</a>.

Historicamente, as prioridades e o foco dos implementadores eram gerenciados de forma independente. No entanto, com esses novos dados, os fabricantes de navegadores se uniram em um esforço pioneiro chamado <a hreflang="pt" href="https://web.dev/i18n/pt/compat2021/">_Compat 2021_</a>, que identificou 5 áreas específicas de foco conjunto para alinhamento em milhares de Testes da Plataforma Web. No início do Compat 2021, todos os motores tinham apenas 65-70% de compatibilidade nas cinco áreas em navegadores estáveis e em funcionamento. Hoje, todos eles estão acima de 90%. Em 2022, esse esforço foi expandido e renomeado para <a hreflang="en" href="https://hacks.mozilla.org/2022/03/interop-2022/">_Interop 2022_</a>.

Ambos esses esforços oferecem diferentes aspectos para este capítulo analisar. Já faz quase um ano desde que a maioria das melhorias do Compat 2021 foi lançada, e embora muitas coisas no Interop 2022 já estejam implementadas em navegadores em funcionamento, ainda há mais por vir antes do final do ano.

Uma pergunta interessante nessas iniciativas é "como sabemos que fizemos bem (ou não)?" Ver melhorias significativas na pontuação é útil, mas insuficiente sem a adoção pelos desenvolvedores. Portanto, este ano, pela primeira vez, o Web Almanac também incluirá um novo capítulo sobre Interoperabilidade para começar a lidar com essas questões e fornecer informações essenciais aos desenvolvedores sobre o que mudou e o que vale a pena ser revisto.

Este capítulo resumirá o trabalho realizado no Compat 2021 e medirá o que for possível, além de investigar o que está acontecendo no Interop 2022 e considerar se também existem métricas potencialmente valiosas que podemos acompanhar ao longo do tempo. Ambos esses esforços abrangem uma ampla variedade de casos, desde recursos estáveis e já úteis com diferentes graus de incompatibilidade ou frustração até coisas completamente novas que tentamos acertar desde o início.

## Compat 2021

O Compat 2021 teve 5 principais áreas de foco:

- <span lang="en">Grid</span>
- <span lang="en">Flexbox</span>
- <span lang="en">Sticky Position</span>
- <span lang="en">Transforms</span>
- <span lang="en">Aspect Ratio</span>

Em janeiro de 2021, todos os navegadores estáveis/em funcionamento obtiveram uma pontuação de 65-70% de compatibilidade nessas áreas, e não necessariamente foram os mesmos 30-35% de testes que falharam em cada navegador.

{{ figure_markup(
  image="compat-2021-dashboard.png",
  caption='Painel do Compat 2021.<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/compat2021">Web Platform Tests</a>)',
  description="Uma captura de tela recente do painel do Compat 2021 mostrando a melhoria na interoperabilidade em navegadores reais, estáveis e em funcionamento: Chrome/Edge 96%, Firefox 91%, Safari 94%.",
  width=780,
  height=801
  )
}}

Hoje, é possível observar que níveis significativos de melhoria foram alcançados. O Chrome e o Edge estão em 96%, o Firefox em 91% e o Safari em 94%.

### Grid

CSS Grid é um dos recursos mais populares em muitos anos. [Os dados do HTTP Archive](./css#flexbox-and-grid-adoption) mostra um aumento de adoção duplicado ano após ano desde a sua chegada, com um leve desaceleramento neste ano — aumentando apenas a metade do valor em relação à duplicação. Grid já tinha um alto grau de interoperabilidade, mas ainda havia algumas diferenças menores no suporte. Trabalho foi realizado ao longo de 2021 e 2022 para melhorar a harmonização dos mais de 900 testes em Web Platform Tests que testam recursos do Grid. Se você já teve problemas no passado ao tentar fazer algo no Grid, tente novamente — a situação pode ter melhorado.

Um bom exemplo disso é a capacidade de animar trilhas de grid — linhas e colunas de grid — que, até meados de 2022, era suportada apenas pelo Firefox. No entanto, no momento em que este capítulo estava sendo escrito, a animação de trilhas de grid foi adicionada tanto ao <a hreflang="en" href="https://webkit.org/blog/13152/webkit-features-in-safari-16-0/">WebKit</a> quanto ao <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/Ll7br0giMk8/m/l4WNHdatBQAJ">Chromium</a>, o que significa que os três principais motores devem estar animando trilhas de grid até o momento em que você ler isso.

### Flexbox

O Flexbox é ainda mais antigo e amplamente utilizado. Este ano, seu uso cresceu novamente, [agora aparecendo em 75% das páginas móveis e 76% das páginas de desktop](./css#flexbox-and-grid-adoption). Ele tem um número semelhante de testes ao Grid e, apesar de uma adoção muito ampla, começou em condições muito piores. Ao entrar em 2021, tínhamos uma combinação de bugs e subrecursos que permaneciam subimplementados. Por exemplo, [valores de palavras-chave de alinhamento posicional](https://developer.mozilla.org/docs/Web/CSS/CSS_Box_Alignment#positional_alignment_keyword_values) (os quais podem ser aplicados a justify-content e align-content, assim como a justify-self e align-self) tinham suporte irregular e várias questões de interoperabilidade. Para itens flex posicionados absolutamente, essa situação era ainda pior. Esses problemas foram resolvidos.

{{ figure_markup(
  caption="Páginas de desktop usando `flex-basis: content` em suas folhas de estilo.",
  content="112,323",
  classes="big-number",
  sheets_gid="1354091711",
  sql_file="flex_basis_content.sql"
)
}}

Outra área de foco foi em relação ao `flex-basis: content`, que é usado para dimensionar automaticamente com base no conteúdo do item flex. Isso foi inicialmente implementado no Firefox, mas implementações no WebKit e no Chromium estavam em andamento em 2021. Hoje, esses testes passam uniformemente em todos os navegadores e o `flex-basis: content`  aparece em 112.323 páginas na área de trabalho e 75.565 em dispositivos móveis, aproximadamente 1% das páginas. Isso não é um começo ruim para um recurso em seu primeiro ano de suporte universal e cerca do dobro do que era no ano passado. Vamos acompanhar essa métrica no futuro.

### Posicionamento Sticky

{{ figure_markup(
  caption="Páginas de desktop usando `position: sticky` em suas folhas de estilo.",
  content="5.5%",
  classes="big-number",
  sheets_gid="712845051",
  sql_file="position_sticky.sql"
)
}}

O posicionamento "sticky" está presente há um tempo. Na verdade, vale ressaltar que é a [consulta de recurso mais popular usada por uma grande margem](../2022/css#feature-queries), representando mais de 50% das consultas de recursos. Ele tinha diversos problemas de interoperabilidade, como a incapacidade de fixar cabeçalhos em tabelas no Chrome. O `position: sticky` é ativamente utilizado em cerca de 5% das páginas de desktop e 4% das páginas móveis em 2022. Vamos ficar de olho nessa métrica por um tempo para ver como a resolução desses problemas de interoperabilidade afeta a adoção ao longo do tempo.


### Transformações CSS

{{ figure_markup(
  image="css-transforms-wpt-dashboard-stable.png",
  caption='Painel de Testes de Página da Web de Transformações CSS (estável).<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/compat2021?feature=css-transforms&stable">Web Platform Tests</a>)',
  description="Gráfico de Compat 2021 mostrando que as transformações CSS melhoraram em 20-30% em todos os navegadores estáveis entre então e agora.",
  width=720,
  height=479
  )
}}

As transformações CSS são populares e existem há muito tempo. No entanto, no início, havia muitos problemas de interoperabilidade, especialmente em torno de `perspective:none` e `transform-style: preserve-3d`. Isso significava que muitas animações eram<a hreflang="en" href="https://web.dev/compat2021/#css-transforms"> irritantemente inconsistentes</a>.

{{ figure_markup(
  image="css-transforms-wpt-dashboard-experimental.png",
  caption='Painel de Testes de Páginas da Web de Transformações CSS (experimental).<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/compat2021?feature=css-transforms">Web Platform Tests</a>)',
  description="Gráfico de Compatibilidade 2021 mostrando as mesmas Transformações CSS em navegadores experimentais, nos quais todos os navegadores têm uma pontuação de 90% ou superior.",
  width=720,
  height=479
  )
}}

Um gráfico recente de compatibilidade 2021 mostrando as mesmas Transformações CSS em navegadores experimentais, como mostrado acima, indica que todos os navegadores têm uma pontuação de 90% ou superior em suas versões experimentais, que exibem as futuras versões dos navegadores. Essa foi uma das áreas com melhorias significativas e visíveis nos navegadores estáveis, que continuam a melhorar, uma vez que parte do Interop 2022 envolve a continuação do trabalho do Compat 2021.

### `aspect-ratio`

`aspect-ratio` foi um novo recurso desenvolvido em 2021. Devido ao seu potencial de utilidade generalizada, optamos por buscar alta interoperabilidade desde o início.

{{ figure_markup(
  image="aspect-ratio-usage.png",
  caption='Uso do Aspect-ratio ao longo do tempo.<br>(Fonte: <a hreflang="en" href="https://chromestatus.com/metrics/css/timeline/popularity/657">Chrome Status</a>)',
  description="Um gráfico mostrando a adoção constante ao longo do tempo de regras que contêm o aspect-ratio nos últimos cerca de um ano e meio, passando de 0,11% em desktop e 0,24% em dispositivos móveis para 1,44% em desktop e 1,55% em dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSu00TnW-7UyYdnE2O4XVTW55MWJ0o5jmj-LWVYESaWrzhaCHELP82GwEnYxgEw3ZCmGMB6aiSVfaw7/pubchart?oid=921119661&format=interactive",
  sheets_gid="1987465082"
) }}

Em 2022, o `aspect-ratio` já está aparecendo no [CSS de 2% dos URLs na rastreio do arquivo](./css#the-aspect-ratio-property). Note que isso não significa que 2% dessas páginas estão usando o  `aspect-ratio` por si mesmas: as regras podem ser carregadas para uso em outras páginas no site. Quais regras são aplicadas nessas páginas é uma pergunta diferente, e isso mostra um percentual mais modesto de 1,55% de visualizações de página em desktop e 1,44% em dispositivos móveis. Ainda assim, o gráfico de crescimento mostra uma adoção constante e crescente. Essa será uma métrica interessante para acompanhar à medida que avançamos.

## Interop 2022

Assim como o esforço anterior do _Compat_ , o esforço renomeado do _Interop_ oncentra-se em uma combinação de coisas, desde coleções de bugs até a implementação de boas versões finais de recursos que estão sendo rapidamente lançados, além de recursos relativamente novos que gostaríamos de lançar com boa qualidade. Vamos começar com os bugs...

### Bugs

Em muitos casos, temos recursos maduros que apresentam problemas relatados de forma irregular em diferentes navegadores. Problemas irregulares significam que a experiência de autoria pode ser muito pior do que as taxas de aprovação individuais podem indicar. Por exemplo, se todos os navegadores relatam uma taxa de aprovação de 70% em uma série de testes, mas todos os navegadores falham em 30% diferentes, a interoperabilidade na prática seria bastante baixa. Uma parte significativa de nosso foco no Interop 2022 é em alinhar implementações e corrigir bugs em recursos como esses.

#### Formulários

Durante a maior parte da história da web, os formulários desempenharam um papel bastante importante. Em 2022, <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/edit#gid=2057119066">mais de 69% das páginas de desktop incluem um elemento `<form>`</a>. Eles receberam muitos investimentos, mas apesar disso, ainda são fonte de muitos bugs nos navegadores, à medida que os desenvolvedores encontram casos onde as coisas diferem das especificações ou diferem de outras implementações de maneiras às vezes sutis. Identificamos <a hreflang="en" href="https://wpt.fyi/results/?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-forms">um conjunto de 200 testes</a> nos quais a taxa de aprovação era muito irregular. As pontuações individuais variaram de cerca de 62% (Safari) a cerca de 91% (Chrome), mas novamente, cada navegador tinha lacunas diferentes no suporte.

Fizemos um progresso bastante radical no sentido de fechar essas lacunas nas versões experimentais, e esperamos que até o final do ano isso seja implementado nas versões estáveis dos navegadores. Provavelmente há pouco que possa ser rastreado aqui usando os dados do HTTP Archive em termos de uso ou adoção, mas esperamos que os desenvolvedores experimentem menos dor e frustração e precisem de menos soluções alternativas para navegadores individuais.

{{ figure_markup(
  image="forms-wpt-dashboard.png",
  caption='Painel de Testes Web Platform para Formulários (experimental).<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-forms&stable">Web Platform Tests</a>)',
  description="Um gráfico mostrando a melhoria na interoperabilidade de formulários ao longo de 2022 em todos os navegadores, com destaque para um avanço significativo no Safari. Todos os navegadores agora estão marcando entre ~92-99%.",
  width=732,
  height=696
  )
}}

#### Rolagem

Ao longo dos anos, adicionamos novos padrões e desenvolvemos novas capacidades em torno das experiências de rolagem, como `scroll-snap`, `scroll-behavior`, e `overscroll-behavior`. . O desejo por esse tipo de funcionalidade é evidente - em 2022, o número de folhas de estilo CSS que incluíam algumas dessas propriedades-chave era o seguinte:

{{ figure_markup(
  image="scroll-property-adoption.png",
  caption='Adoção da propriedade de rolagem.',
  description="Um gráfico de adoção da propriedade de rolagem em desktop e dispositivos móveis. `scroll-snap-type` é usado em 7,8% das páginas de desktop e 7,9% das páginas de dispositivos móveis,  `scroll-behavior` é usado em 7,2% das páginas de desktop e 6,9% das páginas de dispositivos móveis, e finalmente  `overscroll-behavior` é usado em 2,4% das páginas de desktop e 3,0% das páginas de dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSu00TnW-7UyYdnE2O4XVTW55MWJ0o5jmj-LWVYESaWrzhaCHELP82GwEnYxgEw3ZCmGMB6aiSVfaw7/pubchart?oid=1940734631&format=interactive",
  sheets_gid="1538908642",
  sql_file="../css/all_properties.sql"
) }}

Infelizmente, esta é uma área onde várias incompatibilidades ainda persistem, e lidar com incompatibilidades na rolagem causa muita frustração para os desenvolvedores.  Identificamos <a hreflang="en" href="https://wpt.fyi/results/css?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-scrolling">106 testes da Plataforma Web</a> relacionados com a rolagem. No início do processo, as pontuações de lançamento estável variavam de cerca de 70% (Firefox e Safari) até cerca de 88% (Chrome). Novamente, tenha em mente que essas são pontuações gerais — devido às diferenças nas lacunas, a real interseção de "interoperabilidade" era menor do que qualquer uma dessas pontuações.

{{ figure_markup(
  image="scrolling-wpt-dashboard.png",
  caption='Painel WPT (Web Platform Tests) de Rolagem.<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-scrolling&stable">Web Platform Tests</a>)',
  description="Um gráfico recente mostrando melhorias em navegadores experimentais, mostrando ganhos significativos e alinhamento, especialmente no Firefox, que passou de cerca de 71% para mais de 86%.",
  width=718,
  height=683
  )
}}

É muito difícil estimar qual será o efeito dessas melhorias na adoção ao longo do tempo, mas acompanharemos de perto essas métricas. Enquanto isso, se você já enfrentou problemas de interoperabilidade com recursos de rolagem, pode ser uma boa ideia dar uma nova olhada neles. Esperamos que à medida que essas melhorias continuem e cheguem às versões estáveis dos navegadores, a experiência melhore significativamente.

#### Tipografia e Codificações

A renderização de texto é uma das principais habilidades da web. Assim como nos formulários, muitas ideias básicas existem há muito tempo, mas ainda existem várias lacunas e inconsistências no suporte à tipografia e às codificações.

O Interop 2022 abordou uma série de questões gerais relacionadas a `font-variant-alternates`, `font-variant-position`, a unidade `ic`, e as codificações de texto CJK. Identificamos <a hreflang="en" href="https://wpt.fyi/results/?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-text">114 testes no Web Platform Tests</a> representando diferentes tipos de lacunas.

{{ figure_markup(
  image="typography-and-encodings-wpt-dashboard.png",
  caption='Painel de Controle de Tipografia e Codificações no Web Platform Tests.<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-text&stable">Web Platform Tests</a>)',
  description="Um gráfico mostrando as pontuações de interoperabilidade para tipografia e codificações ao longo do último ano. O Chrome começou com cerca de 70%, o Safari com cerca de 79% e o Firefox com cerca de 98%. O Chrome praticamente fechou a lacuna entre si e o Safari, mas o gráfico é de outra forma composto por três linhas retas sem mudanças.",
  width=727,
  height=688
  )
}}

O Chrome recentemente começou a fechar as lacunas em relação ao Safari, mas tanto o Safari quanto o WebKit ainda requerem atenção para alcançar a completude do Firefox nesta área.

### Completando Implementações

Alinhar implementações é particularmente difícil. Existe um equilíbrio delicado entre a necessidade de experimentação e experiência inicial de implementação e ter um acordo suficiente para garantir que o trabalho seja bem compreendido e muito provável de atingir o status de implementação em todos os navegadores. Às vezes, esse alinhamento pode levar anos. Este ano, focamos em três itens que tinham uma implementação e pelo menos algum acordo de que estavam prontos: o elemento `<dialog>`, CSS Containment e Subgrid. Vamos analisar cada um.

#### `<dialog>`

O elemento dialog foi lançado pela primeira vez no Chrome 37 em agosto de 2014. Introduzir um diálogo requer a introdução e definição de vários conceitos de suporte, como "camada superior" e "inércia". Também requer responder a muitas novas questões de acessibilidade e UX.

Várias questões fizeram com que o trabalho nos diálogos ficasse parado por um longo período, mas ao longo dos anos ele foi retomado. Ele foi incluído no Firefox Nightly 53 com uma bandeira em abril de 2017. Desde então, muito trabalho foi dedicado a responder a todas essas questões. Detalhes finais foram resolvidos e o trabalho foi priorizado como parte do Interop 2022 para garantir uma boa interoperabilidade desde o início. Identificamos 88 testes. Ele foi lançado por padrão em navegadores estáveis tanto no [Firefox 98](https://developer.mozilla.org/docs/Mozilla/Firefox/Releases/98) quanto no <a hreflang="en" href="https://developer.apple.com/documentation/safari-release-notes/safari-15_4-release-notes">Safari 15.4</a> em março de 2022, com todos os navegadores atingindo ~93% ou mais de compatibilidade.

{{ figure_markup(
  image="dialog-element-wpt-dashboard.png",
  caption='Painel de Controle WPT do elemento de diálogo.<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-dialog&stable">Web Platform Tests</a>)',
  description="Um gráfico mostrando as pontuações de interoperabilidade para o elemento de diálogo ao longo do último ano. Firefox e Safari começaram em cerca de 80%, com o Chrome um pouco acima, em 87%. Todos tiveram melhorias constantes, com o Chrome/Edge terminando em 99,4%, o Safari em 97,5% e o Firefox em 92,8%.",
  width=720,
  height=685
  )
}}

É difícil prever quantas das páginas rastreadas no arquivo precisarão de um `<dialog>`, mas acompanhar seu crescimento será informativo e interessante. No ano passado, apenas um navegador em operação oferecia suporte ao `<dialog>`, e ele aparecia em cerca de 0,101% das páginas no conjunto de dados móveis. No momento do rastreamento usado para este capítulo, ele estava sendo usado universalmente há cerca de 5 meses e <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1grkd2_1xSV3jvNK6ucRQ0OL1HmGTsScHuwA8GZuRLHU/edit#gid=2057119066">encontramos sua presença em cerca de 0,148%</a>. Ainda são números pequenos, mas isso representa cerca de 146% do que era no mesmo período do ano passado. Continuaremos a acompanhar essa métrica no próximo ano. Enquanto isso, se você precisa de um `<dialog>` há boas notícias: agora ele está disponível universalmente para uso!

#### CSS containment

O CSS containment introduz um conceito para isolar uma subárvore da página do restante da página em termos de como o CSS deve processá-la e renderizá-la. Ele foi introduzido como um recurso que poderia ser usado para melhorar o desempenho e abrir caminho para o desenvolvimento de [Container Queries](https://developer.mozilla.org/docs/Web/CSS/CSS_Container_Queries).

{{ figure_markup(
  image="containment-wpt-dashboard.png",
  caption='Painel do WPT para Containment.<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-contain&stable">Web Platform Tests</a>)',
  description="Um gráfico mostrando as pontuações de interoperabilidade para o containment ao longo do último ano. O Safari começou relativamente baixo, em cerca de 30%, mas aumentou rapidamente para 88% no início e aumentou constantemente para 99%. O Chrome/Edge e o Firefox começaram muito mais altos (84% e 95%, respectivamente), mas também melhoraram para 99%.",
  width=709,
  height=675
  )
}}

Primeiro foi lançado no Chrome estável em julho de 2016. O Firefox lançou a segunda implementação em setembro de 2019. Neste ano, o Interop 2022 tomou a iniciativa de alinhar e garantir que, à medida que ele se torne universalmente disponível, comecemos em boa forma. Identificamos <a hreflang="en" href="https://wpt.fyi/results/css/css-contain?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-contain">235 testes</a>. <a hreflang="en" href="https://developer.apple.com/documentation/safari-release-notes/safari-15_4-release-notes">O Safari lançou o suporte para containment na versão estável 15.4</a> em março de 2022. Ao longo do ano, cada navegador melhorou o suporte e agora está universalmente disponível.

{{ figure_markup(
  caption='Número de páginas móveis que utilizam "containment" em suas folhas de estilo.',
  content="3.7%",
  classes="big-number",
  sheets_gid="1436876723",
  sql_file="contain.sql"
)
}}

Nos dados de 2022, "containment" aparece nas folhas de estilo em 3,7% das páginas em dispositivos móveis e em 3,1% das páginas em desktop.


{{ figure_markup(
  image="contain-property-usage.png",
  caption="Uso da propriedade `contain`",
  description="Um gráfico de barras mostrando que o valor `layout` representa 27% dos valores da propriedade `contain` em páginas de desktop e 34% em páginas móveis, `strict` é 24% e 19%, `content` é 12% e 11%, `paint` é 12% e 9%, `none` é 7% e 8%, `style layout paint` é 10% e 8%, `layout style` é 2% e 4%, `style` é 1% e 3%, `layout size style` é 1% e 1%, `style size layout` é 2% e 1%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSu00TnW-7UyYdnE2O4XVTW55MWJ0o5jmj-LWVYESaWrzhaCHELP82GwEnYxgEw3ZCmGMB6aiSVfaw7/pubchart?oid=932967645&format=interactive",
  sheets_gid="1251142331",
  sql_file="contain_values.sql",
  width=600,
  height=489
) }}

A figura acima mostra a aparência relativa dos valores nessas páginas, com a contenção `layout` sendo de longe o uso mais popular, representando 34% dos valores de `contain`.

Embora seja útil por si só, níveis adicionais de suporte à contenção são um requisito para suportar consultas de contêiner, então essa será uma métrica interessante para continuar a acompanhar ao longo do tempo, já que as consultas de contêiner são a <a hreflang="pt" href="https://2021.stateofcss.com/pt-PT/opinions/#currently_missing_from_css_wins">característica CSS mais solicitada</a> há muitos anos. Agora que a contenção está universalmente disponível, é um ótimo momento para você dar uma olhada e se familiarizar com os conceitos básicos.

Note que algum grau de suporte a consultas de contêiner já está disponível no Chrome e no Safari, e existem polyfills disponíveis. Por isso, também decidimos verificar quantas folhas de estilo já contêm um conjunto de regras `@container`, para entender quanto isso contribuiria para o uso que vimos anteriormente.

{{ figure_markup(
  caption="Porcentagem de páginas móveis que contêm um conjunto de regras `@container`.",
  content="0.002%",
  classes="big-number",
  sheets_gid="1772897513",
  sql_file="container.sql"
)
}}

Realmente não é muito, pelo menos por enquanto! Apenas 238 páginas, de quase 8 milhões de páginas que rastreamos em nosso conjunto de dados móveis, estão usando consultas de contêiner. Considerando que isso é algo novo e ainda não está completamente disponível, isso não é surpreendente. No entanto, isso nos fornece uma boa base para começar a acompanhar a adoção no futuro.

#### Subgrade

Embora o layout de grade CSS tenha permitido que um contêiner expresse o layout de seus filhos em termos de linhas, colunas e trilhas, sempre houve algo como um limite aqui. Frequentemente, há a necessidade de que descendentes que não são filhos participem do mesmo layout de grade. [Subgrade](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout/Subgrid) é a solução para problemas como esse. Ele foi suportado pela primeira vez em um lançamento estável no Firefox em dezembro de 2019, mas outras implementações não seguiram imediatamente.

Coordenar o trabalho nessa função há muito aguardada e garantir uma boa interoperabilidade foi outro objetivo do Interop 2022. Marcamos <a hreflang="en" href="https://wpt.fyi/results/css/css-grid/subgrid?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-subgrid">51 testes no Web Platform Tests</a>.

{{ figure_markup(
  image="subgrid-wpt-dashboard.png",
  caption='Subgrid WPT dashboard.<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-subgrid&stable">Web Platform Tests</a>)',
  description="Um gráfico mostrando as pontuações do subgrade nas versões estáveis ao longo do último ano. O Chrome começou com cerca de 20% e chegou a cerca de 20%, o Safari foi de cerca de 10% para cerca de 98% e o Firefox foi de cerca de 81% para cerca de 83%.",
  width=719,
  height=683
  )
}}

Até o momento em que este texto foi escrito, houve um progresso muito bom (Safari é agora o mais completo), e há pelo menos 2 implementações (Safari e Firefox) em navegadores estáveis em funcionamento. Esperamos ver uma melhoria rápida no Chrome antes do final do ano.

{{ figure_markup(
  caption="Porcentagem de páginas móveis que contêm o uso de `subgrid` em suas folhas de estilo.",
  content="0.002%",
  classes="big-number",
  sheets_gid="519660506",
  sql_file="subgrid.sql"
)
}}

Embora isso ainda não esteja totalmente disponível em todos os navegadores estáveis, o conjunto de dados já incluía algum uso em pequena quantidade.

### Novos Recursos

Este ano, todos os novos recursos que se enquadram na categoria de CSS, juntamente com a maioria dos dados sobre eles, serão abordados no capítulo de [CSS](./css). Aqui, iremos nos concentrar principalmente em alguns destaques.

#### Espaços de Cores e Funções de Cores

A cor na web sempre apresentou desafios fascinantes. Ao longo dos anos, fornecemos aos autores várias maneiras de expressar o que são, no final das contas, as mesmas cores [sRGB](https://pt.wikipedia.org/wiki/SRGB) Ou seja, é possível escrever como um nome de cor (`red`). Bastante simples.

No entanto, também poderíamos usar seu equivalente hexadecimal `(#FF0000)`. Seres humanos geralmente não pensam em hexadecimal, então adicionamos a função de cor `rgb()` (`rgb(255,0,0)`). Note que ambos estão usando dois sistemas numéricos diferentes, mas equivalentes. Também se trata de expressar as coisas em termos de misturar a intensidade das luzes individuais que eram comuns nos displays de tubos de raios catódicos.

O método RGB de construção de cores pode ser muito difícil para os seres humanos visualizarem, então desenvolvemos outros sistemas de coordenadas para expressar cores sRGB de maneira talvez mais fácil de entender, como [`hsl(0, 100%, 50%)`](https://en.wikipedia.org/wiki/HSL_and_HSV) ou [`hwb(0, 0%, 0%)`](https://en.wikipedia.org/wiki/HWB_color_model). No entanto, mais uma vez, esses são sistemas de coordenadas sRGB.

{{ figure_markup(
  image="p3-color-space.jpg",
  caption="Espaço de cores P3 comparado ao espaço de cores sRGB.",
  description="Uma ilustração mostrando que o espaço de cores P3 possui um gamut mais amplo do que o sRGB e é capaz de expressar mais cores.",
  width=736,
  height=300
  )
}}

Então, o que acontece quando as capacidades de exibição excedem seus limites? Isso é, na verdade, o caso hoje em dia, como pode ser visto com displays de amplo espectro.

No Safari 10, lançado em 2017, a Apple adicionou suporte para imagens de cores P3. Os novos sistemas de coordenadas `lab()` e `lch()` foram adicionados ao CSS para suportar o espaço de gamas completo disponível, com base no [Modelo CIELAB](https://en.wikipedia.org/wiki/CIELAB_color_space#Cylindrical_model).  Eles são uniformes perceptualmente, permitindo-nos expressar cores que não podíamos anteriormente (e definindo o que fazer se o suporte estiver ausente). O suporte para esses sistemas de coordenadas foi introduzido no Safari 15 em setembro de 2021.

O espaço de gamas mais amplo e a melhor uniformidade perceptual de `lab()` e `lch()` também nos permitem focar mais facilmente em novas funções de cores como `color-mix()`,  que recebe duas cores e retorna o resultado da mistura delas em um espaço de cor especificado por uma quantidade especificada.

O Interop 2022 abordou cerca de <a hreflang="en" href="https://wpt.fyi/results/css/css-color?label=master&label=experimental&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-color">189 testes</a> relacionados a esses itens, com o objetivo de priorizar uma boa interoperabilidade. O Safari começou bem na frente e só melhorou — tanto o Firefox quanto o Chrome tiveram melhorias constantes, mas ainda estão consideravelmente atrás nessa área. Um desafio inevitável é que o suporte em níveis mais baixos — <a hreflang="en" href="https://youtu.be/eHZVuHKWdd8?t=906">ao longo da biblioteca gráfica subjacente, pipeline de renderização, etc.</a>—também é baseado em sRGB, tornando a adição de suporte não fácil.

{{ figure_markup(
  image="color-spaces-and-functions-wpt-dashboard.png",
  caption='Painel de Controle de Espaços de Cores e Funções WPT.<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-color&stable">Web Platform Tests</a>)',
  description=" Gráfico mostrando as pontuações de Espaços de Cores e Funções em versões estáveis ao longo do último ano. Chrome/Edge e Firefox começaram em torno de 50% e o Firefox melhorou moderadamente, enquanto o Chrome/Edge melhorou um pouco mais, chegando a quase 65%. O Safari começou forte, um pouco acima de 90%, e subiu acima de 95%.",
  width=719,
  height=684
  )
}}

#### Unidades de Viewport

No Relatório de Compatibilidade de Navegadores MDN de 2020, <a hreflang="en" href="https://insights.developer.mozilla.org/reports/mdn-browser-compatibility-report-2020.html#findings-viewport">a capacidade de trabalhar com o tamanho relatado da viewport com as unidades vh/vw existentes foi um tema comum</a>. Conforme os navegadores experimentam diferentes escolhas de interface e os sites têm diferentes necessidades de design, o <a hreflang="en" href="https://drafts.csswg.org/css-values-4/#viewport-variants">Grupo de Trabalho CSS definiu várias novas classes de unidades de viewport</a> para medir as medidas de viewport maiores (unidades `lv*`), menores (unidades `sv*`) e dinâmicas (unidades`dv*`). Todas as medidas relacionadas à visão incluem unidades semelhantes:

- 1% da largura (`vw`, `lvw`, `svw`, `dvw`)
- 1% da altura (`vh`, `lvh`, `svh`, `dvh`)
- 1% do tamanho no eixo inline (`vi`, `lvi`, `svi`, `dvi`)
- 1% do tamanho do bloco contenedor inicial (`vb`, `lvb`, `svb`, `dvb`)
- O valor menor entre duas dimensões (`vmin`, `lvmin`, `svmin`, `dvmin`)
- O valor maior entre duas dimensões (`vmax`, `lvmax`, `svmax`, `dvmax`)

{{ figure_markup(
  image="viewport-units-wpt-dashboard.png",
  caption='Painel de unidades de viewport no Web Platform Tests (experimental)<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-viewport">Web Platform Tests</a>)',
  description="Um gráfico mostrando as pontuações das unidades de viewport em versões experimentais ao longo do último ano. Em janeiro, nenhum mecanismo as suportava. O Safari teve um início mais rápido, alcançando cerca de 65% de suporte em fevereiro, mas foi rapidamente ultrapassado pelo Chrome com cerca de 87% de suporte. Até setembro, todos alcançaram taxas de aprovação de 100%.",
  width=732,
  height=697
  )
}}

O Interop 2022 identificou 7 testes para verificar diversos aspectos dessas unidades. O Safari lançou o primeiro suporte para essas unidades em março de 2022, seguido pelo Firefox no final de maio. Até o momento desta escrita, está sendo suportado nas versões experimentais do Chromium.

Até o momento desta escrita, o HTTP Archive ainda não detectou o uso dessas unidades na prática, mas é algo muito recente. Continuaremos acompanhando a adoção delas daqui para frente.

#### Camadas de Cascata

As Camadas de Cascata são um recurso interessante do CSS, construído com base em uma ideia fundamental que sempre existiu no CSS. Como autores, nosso principal meio de expressar a importância das regras tem sido a especificidade. Isso funciona bem para muitas coisas, mas pode rapidamente se tornar complicado à medida que tentamos incorporar ideias para sistemas de design ou componentes. Os navegadores também usam CSS internamente no que é chamado de folha de estilo UA. No entanto, você pode notar que normalmente não tem batalhas relacionadas à especificidade com a folha de estilo UA. Isso ocorre porque existem "camadas" de regras incorporadas ao próprio funcionamento do CSS. As Camadas de Cascata oferecem uma maneira para os autores se conectarem a esse mesmo mecanismo e gerenciarem seus desafios de CSS e especificidade de maneira mais eficaz. [Miriam Suzanne](https://x.com/TerribleMia) escreveu <a hreflang="en" href="https://css-tricks.com/css-cascade-layers/">uma explicação mais completa e um guia</a>.

{{ figure_markup(
  image="cascade-layers-wpt-dashboard.png",
  caption='Painel de Controle WPT (versões experimentais).<br>(Fonte: <a hreflang="en" href="https://wpt.fyi/interop-2022?feature=interop-2022-cascade">Web Platform Tests</a>)',
  description="Um gráfico mostrando as pontuações do suporte a camadas de cascata em versões experimentais ao longo do último ano. Em janeiro, o Firefox tinha aproximadamente 75% de suporte, o Safari 62% e o Chrome apenas cerca de 11%. Ao longo do ano, cada um ganhou constantemente. Em setembro, tanto o Firefox quanto o Chrome têm pontuações de cerca de 96%, e o Safari 100%.",
  width=720,
  height=675
  )
}}

Para começar bem, o Interop 2022 definiu <a hreflang="en" href="https://wpt.fyi/results/css/css-cascade?label=experimental&label=master&product=chrome&product=firefox&product=safari&aligned&view=interop&q=label%3Ainterop-2022-cascade">31 testes no Web Platform Tests</a>. O suporte nos navegadores estáveis no início do ano era inexistente, mas desde abril, ele está agora universalmente implementado entre as versões estáveis nos 3 motores. Veja como foi o desenvolvimento.

{{ figure_markup(
  caption="Porcentagem de páginas móveis contendo um conjunto de regras `@layer`.",
  content="0.003%",
  classes="big-number",
  sheets_gid="474436360",
  sql_file="layer_adoption.sql"
)
}}

Até o momento do conjunto de dados deste ano, as camadas ocorreram em um número muito pequeno de sites na prática.

O maior número de camadas definidas foi 6. As futuras edições do Web Almanac continuarão a acompanhar a adoção e as tendências das Cascade Layers. Com sorte, o trabalho alinhado, os lançamentos próximos e o foco inicial na boa interoperabilidade ajudarão a alcançar seu potencial e reduzir qualquer frustração.

Dado que ela está presente em todos os lugares, agora seria um ótimo momento para aprender mais sobre como as Cascade Layers podem ajudá-lo a controlar melhor o seu CSS.

## Conclusão

A interoperabilidade é o objetivo das normas e, em última análise, fundamental para a adoção em larga escala. No entanto, na prática, alcançar a interoperabilidade é a culminação de um trabalho complexo, independente, focado, orçamentado e priorizado. Historicamente, isso às vezes tem sido desafiador, com lacunas de muitos anos entre as implementações e várias incompatibilidades. Os fabricantes de navegadores têm ouvido esse feedback e começaram a dedicar esforços para aumentar o foco em esforços coordenados para fechar as lacunas existentes e encurtar o tempo necessário para que novas implementações cheguem com um grau muito alto de interoperabilidade.

Esperamos que esta revisão do trabalho realizado neste ano sirva para informar os desenvolvedores e estimular a adoção e a atenção a esses recursos. Continuaremos a acompanhar as métricas que pudermos e buscaremos usar os dados para orientar nossa percepção de como estamos indo e influenciar onde e como estamos nos concentrando.
