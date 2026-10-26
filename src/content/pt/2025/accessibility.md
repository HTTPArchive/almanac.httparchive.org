---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Acessibilidade
description: Capítulo de Acessibilidade do Web Almanac de 2025 abordando facilidade de leitura, navegação, formulários, mídia, ARIA e aplicativos de acessibilidade.
hero_alt: Imagem de destaque de um robô com um ícone azul de acessibilidade em forma de pessoa na parte da frente, escaneando uma página web, enquanto personagens do Web Almanac verificam alguns rótulos.
authors: [tricinel, mgifford]
reviewers: [hidde, atierney, scottdavis99]
analysts: [mgifford, tunetheweb]
editors: [tricinel]
translators: [markksantos]
tricinel_bio: Bogdan é o consultor de acessibilidade que ajuda product owners a lançar sites acessíveis sem travar o trabalho em andamento. Ele traz mais de uma década de experiência em educação e saúde, com profundo conhecimento em design inclusivo e acessibilidade na web. Desde março de 2024, ele escreve uma <a hreflang="en" href="https://dailyaccessibility.com">newsletter diária</a> sobre acessibilidade, movido por uma crença central. "Abra espaço para todos."
mgifford_bio: Mike Gifford é o Líder de Padrões e Práticas Abertas da CivicActions. Ele também é uma referência em governo aberto, acessibilidade digital e sustentabilidade. Atuou como Mantenedor de Acessibilidade do Drupal Core e também como Especialista Convidado do W3C. É um especialista reconhecido em acessibilidade de ferramentas de autoria e colaborador do rascunho das Web Sustainability Guidelines (WSG) 1.0 do W3C.
results: https://docs.google.com/spreadsheets/d/13sY_wmYODArxo-hH5cSuRAbvtLdGI3x5Xc9qUyqP8as/
featured_quote: A web deve funcionar para todos. Enquanto esse princípio não orientar nossas decisões, as lacunas de acessibilidade vão persistir.
featured_stat_1: 85
featured_stat_label_1: Pontuação mediana de acessibilidade no Lighthouse.
featured_stat_2: 67%
featured_stat_label_2: Sites que removem os contornos de foco padrão.
featured_stat_3: 2%
featured_stat_label_3: Sites que usam overlays de acessibilidade.
doi: 10.5281/zenodo.18246524
---

## Introdução

A web está mudando rapidamente. Em 2025, a acessibilidade na web importa mais do que nunca, à medida que as tecnologias mais difundidas dependem cada vez mais de recursos inclusivos. Por exemplo, assistentes ativados por voz usam tecnologias de leitores de tela. Recursos originalmente projetados para acessibilidade, como legendas em vídeos e feedback háptico, agora são comuns.

Os princípios do Design Universal são fundamentais para o nosso trabalho no desenvolvimento web moderno. Estamos criando, cada vez mais, soluções que atendem a necessidades diversas e melhoram a experiência de todos os usuários. Como disse Sir Tim Berners-Lee em uma frase célebre: "O poder da Web está em sua universalidade. O acesso por todos, independentemente de deficiência, é um aspecto essencial."

Eventos globais recentes e mudanças nos requisitos legais colocaram a inclusão digital em evidência. As <a hreflang="en" href="https://inclusive.microsoft.design/">Diretrizes de Design Inclusivo da Microsoft</a> mostram que a acessibilidade ajuda muito mais do que apenas pessoas com deficiências permanentes. As diretrizes mencionam especificamente limitações temporárias e situacionais. Por exemplo, a possibilidade de usar um dispositivo com uma só mão pode ajudar pessoas com lesões, pais com filhos pequenos e também pessoas carregando objetos.

Em 2025, as leis de acessibilidade na web têm força de verdade. O [Ato Europeu de Acessibilidade (EAA)](https://en.wikipedia.org/wiki/European_Accessibility_Act) da União Europeia (UE) é um grande avanço. Ele estabeleceu junho de 2025 como prazo para que inúmeros sites e aplicativos estivessem em conformidade com a norma [EN 301 549](https://en.wikipedia.org/wiki/EN_301_549), que faz referência às <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/wcag/">Diretrizes de Acessibilidade para Conteúdo Web (WCAG)</a>.

Os Estados Unidos também atualizaram suas regulamentações. Os sites de governos estaduais e locais agora precisam atender à <a hreflang="en" href="https://www.w3.org/TR/WCAG21/">WCAG 2.1</a>, conforme <a hreflang="en" href="https://www.ada.gov/resources/2024-03-08-web-rule/">exigido pelo Título II da Lei dos Americanos com Deficiência</a>. Os dados de 2024 nos dão uma linha de base fundamental para medir o impacto concreto desses prazos na acessibilidade dos sites em todo o mundo.

O Google Lighthouse sustenta nossa análise usando o <a hreflang="en" href="https://www.deque.com/axe/axe-core/">mecanismo axe-core da Deque</a>. Comparamos os resultados de 2025 com os dados de 2024 e identificamos as principais tendências. Com a adoção mais ampla da WCAG 2.2, examinamos a adoção dos novos Critérios de Sucesso e as mudanças contínuas decorrentes de regras descontinuadas, como `duplicate-id`.

Nossa abordagem é semelhante à do <a hreflang="en" href="https://webaim.org/projects/million/">WebAim Million</a>, mas com diferenças nos sites rastreados e nas ferramentas de análise utilizadas. O HTTP Archive rastreia 17 milhões de sites todo mês, em páginas iniciais e secundárias, usando o Lighthouse e outras ferramentas. O WebAim analisa o <a hreflang="en" href="https://webaim.org/projects/million/#method">primeiro milhão de páginas iniciais</a> com o <a hreflang="en" href="https://wave.webaim.org/">WAVE</a>.

Testes automatizados, incluindo o axe-core, que é usado pelo Lighthouse, conseguem <a hreflang="en" href="https://html5accessibility.com/stuff/2025/03/24/a-tools-errand/#:~:text=automation%20blues">verificar apenas parcialmente um subconjunto dos Critérios de Sucesso da WCAG</a>. O Alphagov, do GOV.UK, oferece uma <a hreflang="en" href="https://alphagov.github.io/accessibility-tool-audit/">comparação de ferramentas populares de auditoria automatizada</a>, e todas elas detectam menos de 50% dos erros de acessibilidade. Muitos critérios não têm nenhum teste automatizado, e nem todos os problemas de acessibilidade têm critérios correspondentes na WCAG.

Mas lembre-se da Lei de Goodhart. Quando uma métrica se torna uma meta, ela deixa de ser uma métrica confiável. Uma pontuação perfeita não garante acessibilidade total. Você deve tratar as pontuações de acessibilidade do Lighthouse como um ponto de partida para a avaliação, e não como um objetivo final. Ainda assim, acompanhar essas pontuações oferece um retrato valioso do progresso geral da web.

Nosso relatório se concentra exclusivamente em HTML e não inclui PDFs nem outros documentos de escritório.

Em comparação com 2024, a pontuação mediana de Acessibilidade do Lighthouse melhorou 1%, ultrapassando 85% em 2025. Desde o primeiro Web Almanac, em 2019, temos visto um progresso constante e gradual. O [Google Lighthouse atribui pesos diferentes](https://developer.chrome.com/docs/lighthouse/accessibility/scoring) aos problemas do axe-core, então <a hreflang="en" href="https://accessibility.civicactions.com/posts/prioritizing-accessibility-bugs-for-maximum-impact">as organizações podem priorizar as correções de formas diferentes</a>.

{{ figure_markup(
  image="lighthouse-audit-improvements-yoy.png",
  caption="Melhorias na auditoria do Lighthouse ano a ano.",
  description="Um gráfico de barras mostrando o aumento médio da pontuação mediana de acessibilidade do Google Lighthouse ao longo de seis anos. Os valores aumentam lentamente ano a ano, da seguinte forma: em 2019, 83%; em 2020, 80%; em 2021, 82%; em 2022, 83%; em 2024, 84%; e em 2025, 85%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1116937150&format=interactive",
  sheets_gid="1543303999",
  sql_file="lighthouse_a11y_score.sql"
  )
}}

Este ano, vimos os maiores avanços nos seguintes testes do axe-core:

- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-input-field-name">Campos de entrada ARIA devem ter um nome acessível</a>: +3% em relação a 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-meter-name">Nós ARIA `meter` devem ter um nome acessível</a>: +15% em relação a 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-progressbar-name">Nós ARIA `progressbar` devem ter um nome acessível</a>: +5% em relação a 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/aria-tooltip-name">Nós ARIA `tooltip` devem ter um nome acessível</a>: +13% em relação a 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/meta-refresh">Evite atualização com atraso inferior a 20 horas</a>: +1% em relação a 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/object-alt">Elementos `<object>` devem ter texto alternativo</a>: +1% em relação a 2024
- <a hreflang="en" href="https://dequeuniversity.com/rules/axe/4.11/select-name">O elemento `<select>` deve ter um nome acessível</a>: +5% em relação a 2024

{{ figure_markup(
  image="most-improved-lighthouse-accessibility-tests-axe.png",
  caption="Testes de acessibilidade do Lighthouse que mais melhoraram (axe).",
  description="Um gráfico de séries mostrando as melhorias em sete verificações específicas do Lighthouse ao longo de quatro anos. Para `aria-input-field-name`: em 2021, 12%; em 2022, 14%; em 2024, 21%; e em 2025, 24%. Para `aria-meter-name`: em 2021, 0%; em 2022, 100%; em 2024, 35%; e em 2025, 50%. Para `aria-progressbar-name`: em 2021, 1%; em 2022, 3%; em 2024, 14%; e em 2025, 19%. Para `aria-tooltip-name`: em 2021, 29%; em 2022, 75%; em 2024, 74%; e em 2025, 87%. Para `meta-refresh`: em 2021 e 2022, 2%; em 2024, 7%; e em 2025, 8%. Para `object-alt`: em 2021, 1%; em 2022, 20%; em 2024, 10%; e em 2025, 11%. Para `select-name`: em 2024, 37%; e em 2025, 42%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=2072636024&format=interactive",
  sheets_gid="1312474493",
  sql_file="lighthouse_a11y_audits.sql"
  )
}}

Este ano, estamos adicionando ao Web Almanac uma nova seção sobre [Inteligência Artificial (IA)](#o-impacto-da-inteligência-artificial-ia). A IA está mudando a forma como construímos sites, escrevemos código, geramos conteúdo, otimizamos o desempenho e interagimos com interfaces. Ela já tem um papel crescente no trabalho de acessibilidade, desde a geração de descrições de imagens e legendas até assistentes que ajudam as equipes a encontrar e corrigir problemas.

Ao mesmo tempo, a IA traz riscos e perguntas sem resposta. Ainda não há uma forma confiável de saber quando a IA criou um site ou ajudou a criá-lo. Os modelos de linguagem são treinados com código e conteúdo que frequentemente contêm problemas de acessibilidade. Descrições ou padrões automatizados podem facilmente deixar escapar o contexto, a intenção do usuário ou nuances. Preocupações mais amplas sobre uso de dados, impacto ambiental e vieses embutidos afetam diretamente quem se beneficia da IA na web e quem é prejudicado ou excluído.

O novo capítulo sobre IA explora essas tensões: como a IA já está ajudando as equipes, onde ela deixa a desejar e quais padrões, salvaguardas e práticas são necessários. Um princípio permeia toda a análise: a IA deve apoiar a expertise humana e o design inclusivo, e não substituí-los.

Ao longo deste capítulo, você encontrará links acionáveis e soluções práticas para ajudar a melhorar a acessibilidade dos seus próprios sites.

## Facilidade de leitura

Os usuários precisam ler e compreender o conteúdo web com facilidade. Isso vai além de escolher fontes legíveis. Também envolve usar uma linguagem clara, organizar as páginas de forma lógica e seguir padrões de design previsíveis.

Embora este relatório se concentre em métricas técnicas mensuráveis, fatores qualitativos, como escrever em linguagem simples, importam na mesma medida. A WCAG 3.0 está explorando como incorporar requisitos de linguagem clara, mas ainda está em fase de desenvolvimento.

Assim como a linguagem simples, os números apresentam seus próprios desafios de acessibilidade. Alguns usuários têm dificuldade para interpretá-los, e os testes automatizados não conseguem identificar isso de forma confiável como uma barreira. Para lidar com isso, consulte recursos como o <a hreflang="en" href="https://accessiblenumbers.com">Accessible Numbers</a> para obter conselhos práticos sobre como apresentar informações numéricas com clareza na web.

Existem métricas de legibilidade para conteúdo em inglês. A pontuação de legibilidade [Flesch-Kincaid](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests) é um exemplo. Mas a web é global. Ela abrange muitos idiomas e públicos diversos. Nenhum teste automatizado padronizado cobre todos os casos ou idiomas.

### Contraste de cores

A diferença entre as cores de primeiro plano e de fundo determina se as pessoas conseguem perceber o conteúdo web. O contraste de cores insuficiente continua sendo uma barreira comum, especialmente para usuários com baixa visão ou <a hreflang="en" href="https://www.colourblindawareness.org/">deficiências na visão de cores</a>.

O contraste de cores é especialmente importante para usuários mais velhos, pessoas com deficiências temporárias, como quem está sem os óculos de leitura, e qualquer pessoa lendo sob luz solar intensa ou em ambientes desafiadores.

A WCAG exige taxas de contraste de pelo menos 4,5:1 para texto padrão e 3:1 para texto grande para alcançar a conformidade AA. A conformidade AAA exige 7:1 para texto normal. As [taxas de contraste da WCAG](https://developer.mozilla.org/docs/Web/Accessibility/Guides/Understanding_WCAG/Perceivable/Color_contrast) são uma base importante, mas essas diretrizes não abordam todas as formas de daltonismo nem as variações individuais de percepção.

Outros documentos, incluindo o <a hreflang="en" href="https://git.myndex.com/">Accessible Perceptual Contrast Algorithm (APCA)</a>, buscam oferecer uma medição de contraste perceptualmente mais precisa.

<a hreflang="en" href="https://accessibility.civicactions.com/guide/tools#color">Ferramentas de código aberto</a>, como o <a hreflang="en" href="https://contrast.report/">recém-lançado Contrast Report</a>, tornam mais fácil do que nunca encontrar e corrigir problemas de contraste de cores. Elas até sugerem modificações quando as cores não atingem as taxas exigidas. Para orientações adicionais, você pode consultar recursos de especialistas, como o <a hreflang="en" href="https://www.dennisdeacon.com/web/accessibility/testing-methods-use-of-color/">artigo de Dennis Deacon sobre testes de contraste de cores</a>.

{{ figure_markup(
  image="sites-with-sufficient-color-contrast.png",
  caption="Sites com contraste de cores suficiente.",
  description="Um gráfico de barras em série mostrando a porcentagem de sites com contraste de cores suficiente ao longo de seis anos, tanto em desktop quanto em dispositivos móveis. Em 2019, 22% tinham contraste de cores suficiente. Em 2020, esse número caiu para 21% e se recuperou em 2021, voltando a 22%. Em 2022, em desktop e em dispositivos móveis, era de 23%, e em 2024 saltou para 28% em desktop e 29% em dispositivos móveis. Em 2025, tanto em desktop quanto em dispositivos móveis, é de 30%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1491798527&format=interactive",
  sheets_gid="15996962",
  sql_file="color_contrast.sql"
  )
}}

Este ano, a taxa de aprovação no contraste de texto melhorou cerca de 1% em comparação com 2024. Mas apenas 31% dos sites em dispositivos móveis atendem atualmente aos requisitos mínimos de contraste de cores. Como as experiências em dispositivos móveis dependem muito de uma boa visibilidade, essa lacuna é um problema real para os usuários que acessam a web pelo celular.

Navegadores e sistemas operacionais oferecem cada vez mais suporte aos modos claro, escuro e de alto contraste. Os usuários agora têm mais controle. Ainda assim, a maioria dos sites não responde a essas preferências.

### Zoom e redimensionamento

Os usuários devem poder redimensionar o conteúdo de acordo com suas necessidades. Desativar o zoom tira o controle do usuário e é uma violação direta dos requisitos de redimensionamento da WCAG. Isso é mais do que um pequeno inconveniente. Pode tornar um site completamente inutilizável para pessoas com baixa visão ou que dependem de ampliação de tela para ler.

Em 2025, esse padrão restritivo ainda aparece, muitas vezes porque os desenvolvedores querem layouts perfeitos ao pixel em dispositivos móveis. Infelizmente, isso custa caro à usabilidade e à acessibilidade.

{{ figure_markup(
  image="pages-with-zooming-and-scaling-disabled.png",
  caption="Páginas com zoom e redimensionamento desativados.",
  description="Uma série de gráficos de barras mostrando dados sobre zoom desativado em desktop e em dispositivos móveis. 15% dos sites em desktop e 13% dos sites em dispositivos móveis desativam o redimensionamento, 19% e 17%, respectivamente, definem uma escala máxima de 1, e 21% e 19% usam uma das duas opções.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=327558014&format=interactive",
  sheets_gid="684000055",
  sql_file="viewport_zoom_scale.sql"
  )
}}

O número de sites que desativam o zoom ou o redimensionamento continua caindo. Em 2025, apenas 19% dos sites em dispositivos móveis e 21% dos sites em desktop restringem o redimensionamento, seja usando `user-scalable=no` ou definindo uma escala máxima restritiva. Isso representa uma melhoria de 1–2% em relação a 2024, mostrando um progresso lento, mas constante.

{{ figure_markup(
  image="font-unit-usage.png",
  caption="Uso de unidades de fonte.",
  description="Um gráfico de barras mostrando que `px` é usado para tamanhos de fonte em 67% dos sites em desktop, `em` em 16%, `rem` em 9%, porcentagens em 4%, `<number>` em 2% e, por fim, `pt` em 1% dos sites testados.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=611369037&format=interactive",
  sheets_gid="1493373752",
  sql_file="units_properties.sql"
  )
}}

As unidades de tamanho de fonte afetam diretamente como o texto pode responder às preferências do usuário. Unidades relativas, como `em` e `rem`, permitem que o texto seja redimensionado de forma previsível de acordo com as configurações do navegador. Em 2025, o uso de `em` em sites para dispositivos móveis aumentou 2%, melhorando a experiência de quem ajusta o tamanho da fonte para ler com mais facilidade. Fora isso, o uso de unidades de tamanho de fonte permanece praticamente o mesmo do ano passado.

Se você quiser verificar se o seu site está restringindo o zoom, examine o código-fonte em busca da tag `<meta name="viewport">`. Evite usar valores como `maximum-scale`, `minimum-scale`, `user-scalable=no` ou `user-scalable=0`, pois eles limitam o redimensionamento. Em vez disso, deixe os usuários ajustarem livremente o tamanho do conteúdo. A <a hreflang="en" href="https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-scale.html#:~:text=Content%20satisfies%20the%20Success%20Criterion%20if%20it%20can,more%20extreme%2C%20adaptive%20layouts%20may%20introduce%20usability%20problems.">WCAG exige que o texto possa ser redimensionado até 200%</a> sem perda de conteúdo ou funcionalidade.

### Identificação de idioma

Declarar o idioma principal de uma página com o atributo `lang` é essencial. Isso permite que os leitores de tela selecionem as regras de pronúncia corretas e que os navegadores ofereçam traduções automáticas mais precisas. Além do idioma principal, é igualmente importante especificar o idioma de trechos que diferem do idioma principal. Isso garante que os leitores de tela alterem corretamente a pronúncia de palavras ou frases estrangeiras.

Apesar de ser um <a hreflang="en" href="https://www.w3.org/WAI/WCAG22/Understanding/language-of-page">requisito simples de Nível A da WCAG</a>, a declaração de idioma continua sendo uma área em que muitos sites deixam a desejar. Em 2025, cerca de 86% dos sites incluem um atributo `lang` válido, praticamente sem mudanças em relação a 2024. Isso sugere uma adoção estável, mas também evidencia espaço para melhorias.

A aplicação correta do atributo `lang` começa com a sua inclusão na tag `<html>` para especificar o idioma principal da página. As páginas frequentemente contêm vários idiomas. Use o atributo `lang` em elementos ou trechos individuais conforme necessário. A <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/language-of-parts.html">documentação do W3C sobre como especificar o idioma de partes</a> oferece orientações detalhadas sobre esse tema.

Declarações de idioma ausentes ou incorretas podem causar erros de tradução.

Por exemplo, a tradução automática do Chrome pode interpretar mal o conteúdo de uma página sem um idioma declarado, gerando traduções confusas ou imprecisas. A marcação adequada do idioma também auxilia na estilização de idiomas escritos da direita para a esquerda e em outros comportamentos específicos de cada idioma.

## Preferências do usuário

O CSS moderno inclui [Media Queries de Preferência do Usuário](https://developer.mozilla.org/docs/Web/CSS/Reference/At-rules/@media/prefers-color-scheme) que permitem que os sites se adaptem às configurações do sistema operacional ou do navegador do usuário. Os usuários têm uma experiência mais confortável e personalizada. Os sites podem responder a preferências de movimento, contraste e esquemas de cores.

{{ figure_markup(
  image="user-preference-media-query.png",
  caption="Media queries de preferência do usuário.",
  description="Um gráfico de barras comparando a proporção de páginas que usam diversos recursos de mídia de preferência do usuário em desktop e em dispositivos móveis. O recurso mais usado é `prefers-reduced-motion`, presente em cerca de metade das páginas tanto em desktop (49,99%) quanto em dispositivos móveis (50,55%). `-ms-high-contrast` e `forced-colors` também mostram uso considerável, com cerca de 21% e 16% em desktop e 20% e 19% em dispositivos móveis, respectivamente. Outros recursos, como `prefers-color-scheme` (cerca de 13% em ambas as plataformas) e `prefers-contrast` (cerca de 1%), são muito menos usados, enquanto vários recursos legados ou experimentais praticamente não aparecem em nenhuma página.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1063383428&format=interactive",
  sheets_gid="1601070335",
  sql_file="media_query_features.sql",
  width=600,
  height=551
  )
}}

As queries mais conhecidas, `prefers-reduced-motion` e `prefers-color-scheme`, continuam amplamente suportadas pelos navegadores. Em 2025, a adoção dessas queries pelos sites mostra poucas mudanças. No entanto, o uso de `forced-colors`, que oferece suporte a modos de alto contraste para usuários com baixa visão, aumentou 5%, chegando a 19%. Enquanto isso, o uso da media query obsoleta `-ms-high-contrast` caiu 3%, para 20%. Isso reflete uma transição gradual para os padrões modernos de CSS.

Continuar incorporando essas preferências promove a acessibilidade e a satisfação do usuário, respeitando necessidades individuais e configurações do sistema.

A implementação mais ampla da personalização por meio de media queries CSS não teve um crescimento significativo, apesar desses ganhos graduais. Incentivar uma adoção maior ajuda a garantir que os sites respeitem as preferências dos usuários, incluindo a redução de movimento para quem tem sensibilidade causada por distúrbios vestibulares e a adaptação das cores ou do contraste da tela para conforto visual.

## Navegação

Os usuários navegam pelos sites de formas diferentes. Alguns usam o mouse para rolar a página. Outros usam o teclado, um dispositivo de controle por acionador ou um leitor de tela para navegar pelos títulos. Um sistema de navegação eficaz deve funcionar para todos os usuários, independentemente do dispositivo de entrada.

TVs de tela larga e interfaces de voz como a Siri e a Amazon Alexa criam desafios de navegação únicos. Construir uma boa estrutura semântica em um site ajuda os usuários de leitores de tela a navegar. Também ajuda os usuários de muitos outros tipos de tecnologia.

### Indicação de foco

A indicação de foco é essencial para usuários que dependem principalmente da navegação por teclado e de dispositivos assistivos para percorrer o conteúdo web. Ela fornece uma pista visual que destaca qual elemento está em foco no momento, para que os usuários entendam onde estão na página.

Ferramentas de teste automatizado, como o Google Lighthouse, conseguem identificar muitos requisitos básicos e sinalizar falhas óbvias relacionadas aos indicadores de foco. Mas elas são limitadas quando se trata de interações complexas, como armadilhas de teclado, ordem de foco e se o foco se move de forma lógica para novos conteúdos. Passar em auditorias automatizadas não garante a acessibilidade por teclado de um site nem uma boa experiência para usuários de teclado.

Testes manuais abrangentes são insubstituíveis.

Ferramentas como a extensão de código aberto <a hreflang="en" href="https://accessibilityinsights.io/docs/web/overview/">Accessibility Insights for the Web</a> utilizam o axe-core da Deque e oferecem testes manuais guiados. O recurso de visualização "Tab Stops" ajuda os testadores a ver o caminho que os usuários de teclado percorrem e a identificar com eficácia possíveis problemas, como estilos de foco ausentes ou armadilhas de foco inesperadas.

Usuários de dispositivos de navegação alternativos com habilidades motoras limitadas têm necessidades específicas relacionadas à visibilidade e à sequência do foco. Personalizar as interfaces das tecnologias assistivas ajuda a maximizar um controle adaptado às suas habilidades.

As boas práticas de teste de foco incluem:

- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focus-traps">Nenhuma armadilha de foco em que usuários de teclado fiquem presos</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/focusable-controls">Todos os controles interativos podem receber foco pelo teclado</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/logical-tab-order">A ordem de tabulação é lógica e intuitiva</a>
- <a href="https://developer.chrome.com/docs/lighthouse/accessibility/managed-focus">O foco é direcionado adequadamente para conteúdo novo ou carregado dinamicamente</a>

<a hreflang="en" href="https://www.a11y-collective.com/blog/focus-indicator/">O relatório do The A11y Collective sobre como entender os indicadores de foco</a> oferece insights práticos para implementar e testar estilos de contorno de foco visíveis.

#### Estilos de foco

A WCAG determina que todo conteúdo interativo deve ter um <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/focus-visible.html">indicador de foco claramente visível</a>. Essa pista visual ajuda os usuários de teclado a identificar qual elemento está em foco no momento enquanto percorrem a página.

Sem um indicador de foco bem visível, os usuários de teclado e aqueles que dependem de tecnologias assistivas podem se perder facilmente. Estilos de foco robustos, como um contorno de alto contraste, são fundamentais para o design acessível. Muitas instituições, como o <a hreflang="en" href="https://www.gov.uk/">GOV.UK</a>, estabeleceram padrões para indicadores de foco a fim de garantir consistência e clareza.

As anotações de design precisam especificar as interações por teclado, como <a hreflang="en" href="https://tetralogical.com/blog/2025/09/23/annotating-designs-using-common-language/">Craig Abbott explicou claramente no blog da TetraLogical</a>. Pouco depois dessa publicação, o GitHub lançou seu <a hreflang="en" href="https://github.com/github/annotation-toolkit">Annotation Toolkit</a> de acessibilidade, abordando o mesmo problema.

{{ figure_markup(
  image="pages-overriding-browser-focus-styles.png",
  caption="Páginas que sobrescrevem os estilos de foco do navegador.",
  description="Um gráfico de barras comparando a proporção de páginas que usam três padrões de CSS relacionados ao foco em desktop e em dispositivos móveis. O seletor básico `:focus` está presente em cerca de 90% das páginas, tanto em desktop quanto em dispositivos móveis, enquanto a remoção dos contornos de foco com `:focus { outline: 0; }` aparece em cerca de dois terços das páginas (67%) em ambos. O uso do seletor `:focus-visible`, mais acessível, é bem menor, presente em cerca de um quarto das páginas (25% em desktop e 24% em dispositivos móveis).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1774339890&format=interactive",
  sheets_gid="1499298533",
  sql_file="focus_outline_0.sql"
  )
}}

Em 2025, 67% dos sites removeram explicitamente os contornos de foco padrão, um aumento de 14% em relação a 2024. Essa tendência preocupante pode prejudicar a acessibilidade se esses contornos não forem substituídos por estilos eficazes. Pelo lado positivo, a adoção da pseudoclasse `:focus-visible` cresceu. Isso significa que os desenvolvedores estão começando a criar indicadores de foco sensíveis ao contexto, visíveis apenas quando necessário.

#### `tabindex`

O atributo `tabindex` controla a participação de um elemento na ordem de foco do teclado. Ele permite que os desenvolvedores incluam, excluam ou reordenem elementos focáveis. O uso correto favorece a navegação lógica e a acessibilidade, e é um <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/focus-order.html">requisito da WCAG</a>. O uso indevido, especialmente com valores positivos, pode atrapalhar a ordem natural de tabulação e confundir os usuários.

{{ figure_markup(
  image="tabindex-usage.png",
  caption="Uso de `tabindex`.",
  description="Um gráfico de barras mostrando a proporção de páginas que usam diferentes valores de `tabindex` em desktop e em dispositivos móveis. Pouco mais da metade das páginas usa `0` (52,1% em desktop e 50,1% em dispositivos móveis), e uma proporção semelhante usa valores negativos de `tabindex`, como `-1` (52,0% em desktop e 50,3% em dispositivos móveis). Em contrapartida, valores positivos de `tabindex` aparecem em apenas uma pequena minoria das páginas (3,7% em desktop e 3,4% em dispositivos móveis).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=140565248&format=interactive",
  sheets_gid="1566430802",
  sql_file="tabindex_usage_and_values.sql"
  )
}}

Em 2025, o uso de `tabindex` aumentou ligeiramente. Pouco mais de 50% dos sites o utilizaram, cerca de 3-4% a mais do que em 2024. O uso de `tabindex` positivo permanece estável e, de modo geral, baixo, refletindo a consciência contínua de que valores positivos de tabindex devem ser evitados.

### Landmarks

Os landmarks estruturam uma página web em regiões temáticas distintas, usando elementos HTML nativos como `<header>`, `<nav>`, `<main>` e `<footer>`. Esses elementos criam um esboço claro e de alto nível da página, que ajuda os usuários de tecnologias assistivas a entender rapidamente o layout e a pular diretamente para as seções relevantes.

Um antipadrão comum de acessibilidade persiste quando os desenvolvedores adicionam atributos ARIA redundantes. Por exemplo, adicionar `role="navigation"` a um elemento `<nav>`. O elemento `<nav>` já carrega inerentemente a role de navegação, então essa duplicação polui o código sem nenhum benefício e pode confundir as tecnologias assistivas. A <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Techniques/html/H101">boa prática é priorizar os elementos nativos do HTML5</a> antes de adicionar roles de landmark ARIA. Essa é a principal diretriz do ARIA.

Especialistas em acessibilidade como Eric Bailey destacaram <a hreflang="en" href="https://www.smashingmagazine.com/2025/06/what-i-wish-someone-told-me-aria/">as armadilhas do uso excessivo de ARIA</a> em contextos nos quais o HTML semântico nativo é suficiente. Os <a hreflang="en" href="https://heydonworks.com/article/pride-shame-and-accessibility/">doze princípios de acessibilidade na web</a> de Heydon Pickering também enfatizam o papel fundamental que a estrutura semântica e os landmarks desempenham na navegação acessível.

<figure>
  <table>
    <thead>
      <tr>
        <th>Elemento</th>
        <th>Elemento %</th>
        <th>Role %</th>
        <th>Ambos %</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>main</td>
        <td class="numeric">40.72%</td>
        <td class="numeric">17.81%</td>
        <td class="numeric">47.34%</td>
      </tr>
      <tr>
        <td>header</td>
        <td class="numeric">65.99%</td>
        <td class="numeric">10.95%</td>
        <td class="numeric">67.41%</td>
      </tr>
      <tr>
        <td>nav</td>
        <td class="numeric">67.73%</td>
        <td class="numeric">18.02%</td>
        <td class="numeric">70.94%</td>
      </tr>
      <tr>
        <td>footer</td>
        <td class="numeric">66.38%</td>
        <td class="numeric">9.59%</td>
        <td class="numeric">67.66%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Uso de elementos e roles de landmark (desktop).",
      sheets_gid="445686890",
      sql_file="landmark_elements_and_roles.sql"
      )
    }}
  </figcaption>
</figure>

{{ figure_markup(
  image="yearly-growth-in-pages-with-element-role.png",
  caption="Crescimento anual de páginas com role de elemento.",
  description="Um gráfico mostrando a porcentagem de páginas que usam atributos `role` de landmark (`footer`, `header`, `main`, `nav`) ao longo de cinco anos. O uso cresceu de forma constante para todas as roles: `nav` lidera, com 66% em 2021, subindo para 71% em 2025, seguido por `footer` (de 65% para 68%), `header` (de 64% para 67%) e `main` (de 35% para 47%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=553285039&format=interactive",
  sheets_gid="445686890",
  sql_file="landmark_elements_and_roles.sql"
  )
}}

Em 2025, a adoção de landmarks ARIA aumentou ligeiramente, impulsionada pelo uso crescente do elemento nativo `<main>`, agora em 47%, um aumento de 3% em relação a 2024. Esse progresso reflete uma melhor conformidade com o HTML semântico e uma estrutura de página mais robusta para os usuários que dependem de ferramentas assistivas.

Usuários de leitores de tela frequentemente navegam por meio de "rotores" ou menus de landmarks para pular entre essas regiões da página. Skip links que apontam para landmarks melhoram a usabilidade ao permitir acesso imediato ao conteúdo principal. Eles contornam blocos repetidos de navegação ou banners. Falaremos sobre skip links em uma seção mais adiante.

A educação contínua sobre o aproveitamento dos landmarks nativos do HTML5 e a redução de roles ARIA redundantes vai melhorar ainda mais as experiências de navegação por teclado e por tecnologias assistivas. O crescimento na adoção de estrutura semântica apoia as metas de acessibilidade e alinha o conteúdo web às boas práticas modernas.

### Hierarquia de títulos

Uma estrutura de títulos coerente funciona como um sumário para uma página web. Ela favorece a acessibilidade, o SEO e a compreensão do usuário. Para usuários de leitores de tela, navegar pelos títulos é uma forma essencial de encontrar informações rapidamente. Os mecanismos de busca também dependem da hierarquia de títulos para entender a organização e a relevância de uma página.

Os títulos devem comunicar a estrutura do documento, e não apenas o estilo visual. Usar tags de título como `<h3>` ou `<h4>` apenas pelo tamanho da fonte quebra a ordem lógica. Isso dificulta a navegação para usuários de tecnologias assistivas e viola o princípio de separar estrutura e apresentação. Em vez disso, os desenvolvedores devem estilizar os títulos com CSS e usar as tags de título de acordo com a hierarquia do conteúdo.

Para relembrar por que a semântica importa, leia <a hreflang="en" href="https://www.jonoalderson.com/conjecture/why-semantic-html-still-matters/">este artigo de Jono Alderson</a>.

Após vários anos de queda, as pontuações de hierarquia de títulos melhoraram quase 2% em 2025, indicando uma atenção renovada à estrutura correta de títulos.

{{ figure_markup(
  caption="Sites em dispositivos móveis aprovados na auditoria do Lighthouse para títulos ordenados corretamente.",
  content="59%",
  classes="big-number",
  sheets_gid="1312474493",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

Ainda assim, o uso indevido de títulos para estilização em vez de estrutura continua comum.

### Skip links

Skip links são recursos de navegação que permitem que usuários de teclado e outras pessoas que usam dispositivos de entrada diferentes do mouse contornem blocos grandes e repetitivos de conteúdo, como os menus de navegação do site, e pulem diretamente para o conteúdo principal da página. Normalmente, um link "pular para o conteúdo principal" aparece como o primeiro elemento focável da página para uma navegação eficiente.

Contornar blocos de conteúdo é um <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/bypass-blocks.html">requisito da WCAG</a>, e implementações básicas continuam sendo a norma.

Existem ferramentas sofisticadas, como o <a hreflang="en" href="https://paypal.github.io/skipto/">SkipTo, de código aberto, do PayPal</a>, para gerar menus dinâmicos com todos os principais landmarks e títulos de uma página. Essa interação mais rica beneficia uma variedade maior de usuários, melhorando a navegabilidade e a usabilidade em geral. Eleanor Hecks escreveu um artigo convincente sobre a <a hreflang="en" href="https://www.smashingmagazine.com/2025/04/what-mean-site-be-keyboard-navigable/">importância da acessibilidade por teclado</a>, assim como a <a hreflang="en" href="https://tetralogical.com/blog/2025/05/09/foundations-keyboard-accessibility/">TetraLogical</a>.

A adoção de skip links permaneceu praticamente estável de 2024 para 2025.

{{ figure_markup(
  caption="Páginas em dispositivos móveis e desktop que provavelmente têm um skip link.",
  content="24%",
  classes="big-number",
  sheets_gid="1734473098",
  sql_file="skip_links.sql"
)
}}

Aproximadamente 24% das páginas em desktop e em dispositivos móveis incluem skip links detectáveis por métodos de análise comuns. Esse número pode subestimar o uso real, já que alguns skip links aparecem mais adiante na página ou apontam para landmarks além dos menus de navegação.

{{ figure_markup(
  image="yearly-growth-in-pages-with-skip-links.png",
  caption="Crescimento anual de páginas com skip links.",
  description="Um gráfico de colunas com várias séries mostrando a porcentagem de páginas com skip links em desktop e em dispositivos móveis ao longo de quatro anos. O uso cresceu de forma constante, de 19,7% em 2021 para 25,65% em desktop e 26,23% em dispositivos móveis em 2025, com os dispositivos móveis consistentemente um pouco acima do desktop nos últimos anos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=688571011&format=interactive",
  sheets_gid="1734473098",
  sql_file="skip_links.sql"
  )
}}

### Títulos de documentos

Um `<title>` de página descritivo é uma necessidade básica. Ele fornece contexto para os usuários que navegam entre abas e janelas do navegador e costuma ser a primeira informação anunciada por um leitor de tela, ajudando os usuários a se orientarem. A WCAG também determina que <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/Understanding/page-titled">toda página deve ter um título significativo</a>.

{{ figure_markup(
  image="title-element-statistics.png",
  caption="Estatísticas do elemento title.",
  description="Um gráfico de barras comparando padrões de uso do elemento title em desktop e em dispositivos móveis. Quase todas as páginas (98%) têm um elemento title em ambas as plataformas, enquanto títulos com quatro ou mais palavras aparecem em 69% das páginas em desktop e em 67% das páginas em dispositivos móveis. Títulos que mudam após a renderização ocorrem em 7% das páginas, tanto em desktop quanto em dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1678943411&format=interactive",
  sheets_gid="480324977",
  sql_file="page_title"
  )
}}

Os dados de 2025 mostram uma ligeira melhora na presença e na descritividade dos títulos de documentos em comparação com os anos anteriores. Aproximadamente 98% dos sites agora incluem um elemento `<title>`, um aumento de 1% em relação a 2024.

Isso é positivo. Mas, apesar dessa alta taxa de inclusão, muitos títulos continuam insuficientemente descritivos. Isso afeta a usabilidade, especialmente para usuários de leitores de tela, que dependem de títulos claros para se orientar.

Houve uma queda de 2% nos sites em dispositivos móveis com títulos de quatro ou mais palavras, o que pode indicar títulos mais curtos ou menos específicos nas páginas para dispositivos móveis. Incluir tanto uma breve descrição do conteúdo da página quanto o nome do site continua sendo a boa prática para melhorar a navegação e o contexto.

Os títulos de documentos continuam sendo um recurso fundamental de acessibilidade que beneficia todos os usuários. Eles fornecem contexto ao navegar entre abas e janelas do navegador. Embora estejam presentes de forma quase universal, melhorar a descritividade e a consistência dos títulos continua sendo um foco importante em 2025 e nos anos seguintes.

### Tabelas

As tabelas HTML apresentam dados em uma grade bidimensional. A acessibilidade depende de estruturá-las com os elementos semânticos apropriados. Usar `<caption>` fornece um contexto crucial para usuários de leitores de tela, enquanto os elementos `<th>` definem cabeçalhos para linhas e colunas, ajudando os usuários a entender as relações dentro dos dados. A <a hreflang="en" href="https://codepen.io/stevef/pen/ByoMebv">ferramenta de Steve Faulkner</a>, lançada em 2025, pode ajudar os desenvolvedores a inspecionar rapidamente a semântica de qualquer elemento HTML.

O uso de `<caption>` permaneceu estável em 2025 em comparação com 2024, com apenas uma pequena porcentagem de sites incluindo legendas. Essa baixa adoção é semelhante à dos anos anteriores: cerca de 1,6% dos sites em desktop incluem legendas, que são um recurso de acessibilidade importante, embora frequentemente esquecido.

As tabelas não devem ser usadas indevidamente para fins de layout. O CSS Flexbox e o Grid cuidam do layout. Quando as tabelas são usadas puramente para layout, o atributo `role="presentation"` remove seu significado semântico para evitar confusão com as tecnologias assistivas.

<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>desktop</th>
        <th>mobile</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Tabelas com legenda</td>
        <td class="numeric">5.6%</td>
        <td class="numeric">4.7%</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>Tabela de apresentação</td>
        <td class="numeric">4.9%</td>
        <td class="numeric">5.4%</td>
        <td class="numeric">3.6%</td>
        <td class="numeric">4.8%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Uso de tabelas.",
      sheets_gid="1701660946",
      sql_file="table_stats.sql"
      )
    }}
  </figcaption>
</figure>

Em 2025, 4,9% das tabelas em dispositivos móveis usam essa técnica, contra 4% em 2024 e 1% em 2022. A ênfase continua sendo o uso correto de elementos HTML semânticos para tornar as tabelas acessíveis.

## Formulários

Os formulários são a forma como os usuários interagem com a web, desde fazer login até fazer uma compra ou compartilhar informações. Garantir que sejam acessíveis é fundamental para que os usuários consigam concluir tarefas e participar plenamente da vida online.

### Elemento `<label>`

O elemento `<label>` continua sendo a forma padrão e recomendada de fornecer nomes acessíveis para campos de entrada. Ao associar programaticamente um texto descritivo a um controle de formulário, normalmente por meio do atributo `for` apontando para o `id` do campo, ele garante que os usuários de tecnologias assistivas entendam claramente quais informações são solicitadas. Rótulos adequados também melhoram a usabilidade ao aumentar a área clicável, já que clicar no rótulo coloca o foco no campo.

{{ figure_markup(
  image="where-inputs-get-their-accessible-names-from.png",
  caption="De onde os campos de entrada obtêm seus nomes acessíveis.",
  description="Um gráfico de barras mostrando as fontes dos nomes acessíveis dos campos de entrada em desktop e em dispositivos móveis. A fonte mais comum é um elemento `<label>` associado, usado em cerca de um terço dos campos (34,27% em desktop e 34,57% em dispositivos móveis), seguido de perto pelo texto de `placeholder` (24,49% em desktop e 25,12% em dispositivos móveis) e por campos sem nenhum nome acessível (24,65% em desktop e 24,93% em dispositivos móveis). Outras fontes, como os atributos `aria-label`, `title` ou `value` e as relações `aria-labelledby`, respondem por apenas uma pequena fração dos campos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1732059331&format=interactive",
  sheets_gid="1144087268",
  sql_file="form_input_name_sources.sql"
  )
}}

Em 2025, cerca de 35% dos campos de entrada em dispositivos móveis recebem seus nomes acessíveis de `<label>`, contra 32% em 2024. Essa é uma tendência positiva.

Também observamos uma redução modesta, de 2%, nos campos que obtêm seus nomes acessíveis apenas do texto de placeholder. O texto de placeholder é menos confiável e não substitui os rótulos. No entanto, a proporção de campos sem nenhum nome acessível permaneceu inalterada em relação ao ano passado, indicando lacunas de acessibilidade persistentes.

Os dados de 2025 mostram uma melhora gradual no uso de `label`. Eles também ressaltam a necessidade de continuar ampliando as práticas adequadas de rotulagem para alcançar plena conformidade e usabilidade em acessibilidade.

### Atributo `placeholder`

O atributo placeholder fornece uma dica ou um exemplo do formato de entrada esperado dentro de um campo de formulário. Mas ele nunca deve substituir o elemento `<label>` como nome acessível desse campo. O texto de placeholder desaparece assim que o usuário começa a digitar, deixando de estar disponível para consulta.

O texto de placeholder também costuma ter um contraste padrão ruim, muitas vezes não atendendo aos requisitos de contraste de cores da WCAG. O suporte dos leitores de tela a placeholders também varia bastante.

A abordagem recomendada é usar rótulos visíveis e associados programaticamente aos campos, com o placeholder servindo apenas como uma dica ou exemplo complementar.

{{ figure_markup(
  image="use-of-placeholders-on-inputs.png",
  caption="Uso de placeholders em campos de entrada.",
  description="Um gráfico de barras comparando a proporção de sites que usam placeholders em campos de entrada e padrões relacionados em desktop e em dispositivos móveis. Cerca de 56% dos sites em desktop e 55% dos sites em dispositivos móveis usam placeholders, enquanto 58% dos sites em desktop e 59% dos sites em dispositivos móveis têm campos sem rótulos. Vale notar que 53% dos sites em desktop e 55% dos sites em dispositivos móveis usam placeholders e, ao mesmo tempo, não têm rótulos nos campos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1130613025&format=interactive",
  sheets_gid="1641253918",
  sql_file="placeholder_but_no_label.sql"
  )
}}

Em 2025, houve uma redução de 2% no uso de texto de placeholder como único nome acessível dos campos de entrada. Apesar dessa tendência positiva, a prática continua comum demais. 53% dos campos em desktop e 55% dos campos em dispositivos móveis dependem exclusivamente do texto de placeholder como nome acessível, o que ainda representa barreiras de acessibilidade significativas.

### Informações obrigatórias

Comunicar que um campo de formulário é obrigatório é essencial para a usabilidade e a acessibilidade. Embora um indicador visual como um asterisco (\*) seja comum, ele sozinho é insuficiente, pois não traz informação semântica.

O atributo `required` do HTML5 oferece uma forma nativa e legível por máquina de indicar que o usuário precisa preencher um campo antes de enviar o formulário. Esse atributo funciona com muitos tipos de entrada, como texto, e-mail, senha, data, checkbox e radio. Os navegadores aplicam a validação, e as tecnologias assistivas transmitem aos usuários o status de obrigatório.

{{ figure_markup(
  image="how-required-inputs-are-specified.png",
  caption="Como os campos obrigatórios são especificados.",
  description="Um gráfico de barras comparando métodos para marcar campos obrigatórios em desktop e em dispositivos móveis. O atributo `required` é o mais comum, com 67% em desktop e 66% em dispositivos móveis, seguido por `aria-required`, com 36% e 37%. Asteriscos visuais aparecem em 18% dos sites em desktop e 19% dos sites em dispositivos móveis, com sobreposições como o uso de `required` e `aria-required` juntos em 9% dos sites em ambas as plataformas.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1477108194&format=interactive",
  sheets_gid="1187751102",
  sql_file="form_required_controls.sql"
  )
}}

Estamos observando um aumento modesto na adoção do atributo required, que subiu 1% em 2025, chegando a 66% em dispositivos móveis. O uso de `aria-required` caiu 3%, para 37% em dispositivos móveis. Isso indica uma transição gradual para um uso mais semântico da validação nativa do HTML em vez do ARIA, que deve complementar, e não substituir, a semântica nativa.

O progresso em 2025 reflete um movimento lento, mas constante, em direção a uma melhor indicação semântica dos campos obrigatórios, melhorando a acessibilidade dos formulários e a experiência do usuário.

### Captchas

Os CAPTCHAs diferenciam humanos de bots automatizados, mitigando atividades maliciosas. A sigla vem de "<i lang="en">Completely Automated Public Turing Test to Tell Computers and Humans Apart</i>" (teste de Turing público completamente automatizado para diferenciar computadores e humanos). Embora os CAPTCHAs cumpram uma função de segurança necessária, eles frequentemente criam barreiras de acessibilidade significativas, em especial para pessoas com deficiências visuais, motoras ou cognitivas.

CAPTCHAs visuais tradicionais podem ser difíceis ou impossíveis de resolver para usuários com deficiência. O W3C recomenda explorar métodos alternativos de verificação que sejam mais inclusivos, como:

- CAPTCHAs de áudio que apresentam desafios falados
- CAPTCHAs "invisíveis" que funcionam em segundo plano, sem ação do usuário
- Incorporar métodos de autenticação multifator ou fluxos de verificação mais simples.

Em 2025, o uso de CAPTCHAs permaneceu praticamente estável em comparação com os anos anteriores.

{{ figure_markup(
  image="captcha-usage-year-over-year.png",
  caption="Uso de CAPTCHAs ano a ano.",
  description="Um gráfico de colunas com várias séries mostrando a porcentagem de sites que usam captchas em desktop e em dispositivos móveis de 2021 a 2025. O uso atingiu o pico em 2022, com 20% em desktop e 19% em dispositivos móveis, depois caiu ligeiramente para 17% e 16% em 2024, mantendo-se estável em 18% e 17% em 2025.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1433910378&format=interactive",
  sheets_gid="1834983243",
  sql_file="captcha_usage.sql"
  )
}}

Vale destacar que o Governo de Luxemburgo lançou uma ferramenta de <a hreflang="en" href="https://accessibilite.public.lu/en/news/2025-09-22-captchas.html">varredura de CAPTCHAs</a>. Ela avalia e monitora as implementações de CAPTCHA nos sites governamentais, com o objetivo de melhorar a conformidade com a acessibilidade no setor público.

Esforços contínuos para substituir ou complementar os CAPTCHAs visuais com opções mais acessíveis são essenciais. Todos os usuários devem conseguir concluir as etapas de verificação sem dificuldades excessivas nem exclusão.

## Mídia na web

A mídia acessível na web exige o fornecimento de formatos alternativos para garantir que o conteúdo possa ser usado por todos. Usuários com deficiência visual se beneficiam de audiodescrições que transmitem informações visuais importantes. Usuários surdos ou com deficiência auditiva dependem de legendas ou de interpretação em língua de sinais para acessar o conteúdo de áudio.

Audiodescrições e legendas não são suficientes. Transcrições são necessárias para conteúdo somente em áudio e somente em vídeo, oferecendo uma alternativa textual completa. Para conteúdo não textual, como imagens, forneça um texto alternativo adequado. Se elas não acrescentarem informação significativa, marque-as como decorativas.

Os princípios e requisitos para mídia acessível permanecem os mesmos entre 2024 e 2025, enfatizando a importância contínua de oferecer experiências multimídia inclusivas para usuários com deficiência.

### Imagens

O atributo `alt` fornece uma descrição textual de uma imagem. Ele é essencial para que usuários de leitores de tela entendam o conteúdo visual. Em 2025, esse atributo continua sendo fundamental para a acessibilidade de imagens, sem mudanças significativas nas taxas de erro em relação aos anos anteriores.

{{ figure_markup(
  caption="Porcentagem de imagens aprovadas na auditoria do Lighthouse para imagens com texto `alt`.",
  content="69%",
  classes="big-number",
  sheets_gid="1312474493",
  sql_file="lighthouse_a11y_audits.sql"
)
}}

Arquivos JPG e PNG continuam dominando as imagens na web, mas há um crescimento animador no uso dos formatos WEBP e SVG. Os arquivos SVG oferecem uma semântica rica que beneficia imagens complexas e interativas.

{{ figure_markup(
  image="most-common-file-extensions-in-alt-text.png",
  caption="Extensões de arquivo mais comuns em texto `alt`.",
  description="Um gráfico de barras mostrando as extensões de arquivo mais comuns encontradas no texto alternativo de imagens em desktop e em dispositivos móveis. As imagens JPEG dominam, com `jpg` em 54,0% em desktop e 53,4% em dispositivos móveis, seguidas por `png`, com 34,5% e 34,6%. Outros formatos, como `jpeg` (4,8% em desktop, 10,1% em dispositivos móveis), `webp`, `svg`, `ico` e `gif`, representam parcelas menores.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1120578928&format=interactive",
  sheets_gid="2115828969",
  sql_file="alt_ending_in_image_extension.sql"
  )
}}

No entanto, notamos um problema que continua persistindo: aproximadamente 8,5% dos textos alternativos de imagens terminam com extensões de arquivo comuns, como `.jpg` ou `.png`. Isso normalmente acontece quando ferramentas de autoria automatizadas inserem nomes de arquivo como texto `alt`. Infelizmente, isso não agrega valor e não ajuda os usuários que dependem de tecnologias assistivas.

{{ figure_markup(
  image="alt-attribute-lengths.png",
  caption="Comprimento dos atributos `alt`.",
  description="Um gráfico de barras agrupadas mostrando a distribuição do comprimento dos atributos `alt` de imagens em desktop e em dispositivos móveis. Cerca de 13–14% das imagens não têm atributo `alt` e 30% usam um `alt` vazio em ambas as plataformas. Das imagens restantes com texto não vazio, a maioria é curta: cerca de 20% têm 10 caracteres ou menos, 17% têm 20 ou menos, e 18% (desktop) e 10% (dispositivos móveis) têm 30 ou menos, enquanto apenas cerca de 1% têm 100 caracteres ou mais e praticamente nenhuma ultrapassa 100 caracteres.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=536884664&format=interactive",
  sheets_gid="785975896",
  sql_file="common_alt_text_length"
  )
}}

Há uma tendência positiva em direção a textos alternativos com 20 a 30 caracteres, que tendem a equilibrar descrição e concisão. Mas cerca de 50% das imagens ainda têm atributos alt vazios ou textos com menos de 10 caracteres. O texto alternativo vazio é apropriado apenas para imagens puramente decorativas. A maioria das imagens, no entanto, transmite informações importantes que merecem descrições significativas e, portanto, se beneficiará de um texto alternativo significativo.

As boas práticas continuam a enfatizar o fornecimento de textos alternativos concisos, porém descritivos, adaptados ao contexto da imagem, evitando nomes de arquivo e usando formatos de arquivo semânticos como SVG quando apropriado. As ferramentas de Inteligência Artificial (IA) também se mostram promissoras. A <a hreflang="en" href="https://www.drupal.org/project/ai_image_alt_text">integração de sugestões de texto alternativo assistidas por IA do Drupal</a> ajuda os autores a criar atributos alt melhores ao fornecer exemplos editáveis. Brian Teeman escreveu uma crítica interessante sobre a <a hreflang="en" href="https://magazine.joomla.org/all-issues/june-2024/ai-generated-alt-text">geração de texto alternativo por IA</a>.

As imagens continuam sendo uma área com oportunidades de melhorias significativas de acessibilidade, apesar do progresso constante.

### Áudio e vídeo

O elemento HTML `<track>` fornece faixas de texto sincronizadas, como legendas descritivas, legendas de tradução e audiodescrições, para elementos de mídia como `<video>` e `<audio>`. Em 2025, esse elemento ainda é subutilizado. Apesar de sua importância para usuários surdos, com deficiência auditiva ou cegos, as taxas de adoção continuam excepcionalmente baixas, abaixo de 1%.

Muitas plataformas de vídeo modernas agora usam com frequência o [HTTP Live Streaming (HLS)](https://en.wikipedia.org/wiki/HTTP_Live_Streaming) em vez do elemento nativo `<track>`. Isso pode contribuir para as baixas estatísticas de uso. Com o HLS, que exige implementação personalizada, os desenvolvedores precisam ser mais intencionais ao incorporar eles mesmos o suporte a legendas. Isso significa que há mais espaço para os desenvolvedores esquecerem as legendas ou as implementarem mal.

As legendas são essenciais para usuários surdos e com deficiência auditiva. Elas também beneficiam espectadores em ambientes barulhentos ou pessoas com dificuldade para compreender a linguagem falada. As audiodescrições permitem que usuários com deficiência visual obtenham contexto sobre o conteúdo visual.

Em comparação com 2024, não vimos um crescimento significativo no uso de `<track>` para legendas descritivas e de tradução, que passou de 0,1% para 0,4% em desktop e de 0,1% para 0,2% em dispositivos móveis. Isso nos mostra que o setor ainda tem um espaço considerável para melhorar.

## Tecnologia assistiva com ARIA

Accessible Rich Internet Applications (ARIA) é um conjunto de atributos HTML para melhorar a acessibilidade do conteúdo web. O ARIA é particularmente valioso para componentes complexos ou personalizados que não podem se tornar acessíveis apenas com HTML nativo. O ARIA aprimora interfaces de usuário dinâmicas e interativas, garantindo que pessoas que usam leitores de tela ou outras tecnologias assistivas consigam entender todos os elementos da página e interagir com eles.

O ARIA deve ser usado com cuidado.

O uso incorreto ou excessivo pode introduzir novas barreiras, causando confusão tanto para os usuários quanto para as ferramentas de acessibilidade. Por exemplo, atributos ARIA que não correspondem à funcionalidade pretendida, roles adicionadas a elementos inadequados ou ARIA redundante podem prejudicar a experiência do usuário e aumentar os erros de acessibilidade.

O trabalho de Adrian Roselli destaca <a hreflang="en" href="https://adrianroselli.com/2025/01/aria-description-does-not-translate.html">as limitações de certas propriedades ARIA</a>, como `aria-description`, e ressalta a importância de entender tanto os pontos fortes quanto as armadilhas do ARIA.

O princípio mais importante do ARIA é:

**Se você puder usar HTML nativo, use.**

Elementos nativos como `<button>`, `<input>` e `<nav>` vêm com acessibilidade embutida que o ARIA não consegue reproduzir completamente. O ARIA deve apenas complementar a semântica nativa onde for necessário, e não substituí-la.

<a hreflang="en" href="https://www.a11y-collective.com/blog/aria-in-html/">Orientações</a> recentes de especialistas, incluindo Florian Schroiff, assim como as boas práticas atuais, reforçam a aplicação do ARIA apenas em elementos personalizados complexos e o cumprimento rigoroso das especificações para evitar exclusão acidental ou falhas de comunicação.

Em 2025, o ARIA continua desempenhando um papel vital, mas às vezes problemático, na acessibilidade web.

### Roles ARIA

As roles ARIA comunicam a finalidade ou o tipo de um elemento às tecnologias assistivas. Em 2025, elas continuam tendo um papel significativo em tornar o conteúdo web acessível. Embora elementos HTML nativos como `<button>` venham com semântica embutida, o ARIA oferece a possibilidade de atribuir roles a componentes personalizados que não têm equivalentes nativos, como interfaces com abas ou componentes `dialog`.

{{ figure_markup(
  image="top-ten-most-common-aria-roles.png",
  caption="As dez roles ARIA mais comuns.",
  description="Um gráfico de barras mostrando as dez roles ARIA mais comuns em páginas de desktop e de dispositivos móveis. `button` é a role mais usada (53,06% em desktop e 53,56% em dispositivos móveis), seguida por `presentation` (42,48% e 41,54%) e `dialog` (34,05% e 36,01%). Outras roles usadas com frequência incluem `search`, `navigation`, `img`, `main`, `region`, `group` e `status`, todas presentes em aproximadamente 15–25% das páginas.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1028393265&format=interactive",
  sheets_gid="2081252628",
  sql_file="common_aria_role",
  width=600,
  height=676
  )
}}

Observamos um aumento de aproximadamente 4% no uso da role ARIA `button`, que chegou a 53% dos sites em desktop e 54% dos sites em dispositivos móveis em 2025. Vimos aumentos semelhantes no uso de roles como `presentation` e `dialog`, enquanto o uso da role `search` permanece estável.

O aumento do uso da role ARIA `button` gera preocupações. Muitas vezes, ele indica que os sites estão aplicando roles como `button` a elementos não semânticos, como `<div>` ou `<span>`. Ou estão atribuindo roles de forma redundante a elementos HTML nativos como `<button>`.

### Uso da role presentation

Aplicar `role="presentation"` ou `role="none"` instrui as tecnologias assistivas a tratar o elemento como puramente de apresentação. Isso remove sua semântica nativa da árvore de acessibilidade. Embora isso possa ser útil para elementos de layout que não transmitem nenhuma informação significativa, o uso excessivo ou indevido pode criar barreiras de acessibilidade significativas.

Por exemplo, aplicar `role="presentation"` a um elemento `<ul>` faz com que toda a semântica da lista, incluindo a dos elementos `<li>` filhos, seja ignorada. Os usuários de leitores de tela perdem informações contextuais e estruturais cruciais, como quantos itens há em uma lista.

Embora a role `presentation` possa ajudar a remover semânticas enganosas quando os elementos são usados de forma puramente decorativa ou para layout, ela deve ser aplicada com moderação e com uma intenção clara.

{{ figure_markup(
  caption="Porcentagem de sites em desktop e em dispositivos móveis que têm pelo menos uma role `presentation`.",
  content="42%",
  classes="big-number",
  sheets_gid="2081252628",
  sql_file="common_aria_role.sql"
)
}}

Em 2025, o uso de `role="presentation"` aumentou 2%, dando continuidade a uma tendência preocupante.

### Rotulagem de elementos com ARIA

Os navegadores mantêm uma árvore de acessibilidade que expõe informações sobre os elementos da página, como seus nomes acessíveis, roles, estados e descrições. As tecnologias assistivas dependem dela para transmitir contexto aos usuários. O nome acessível de um elemento é crucial e geralmente é derivado do conteúdo de texto visível. No entanto, atributos ARIA como `aria-label` e `aria-labelledby` podem ser usados para definir ou sobrescrever explicitamente os nomes acessíveis quando o texto nativo é insuficiente ou indisponível.

{{ figure_markup(
  image="top-10-aria-attributes.png",
  caption="Os 10 atributos ARIA mais usados.",
  description="Um gráfico de barras mostrando os dez atributos ARIA mais comuns em páginas de desktop e de dispositivos móveis. `aria-label` lidera, com 70% em desktop e 68% em dispositivos móveis, seguido de perto por `aria-hidden` (66% em ambos). Outros atributos usados com frequência incluem `aria-expanded` (40% e 38%), `aria-controls` (34% e 33%), `aria-live` (33% e 32%) e `aria-labelledby` (30% e 29%), com o uso diminuindo até `aria-describedby`, com 17% tanto em desktop quanto em dispositivos móveis.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=318641062&format=interactive",
  sheets_gid="1821302308",
  sql_file="common_element_attributes.sql",
  width=780,
  height=676
  )
}}

Em 2025, o uso de quase todos os principais atributos ARIA aumentou. O uso de `aria-label` em desktop subiu 5%, e o de `aria-labelledby`, 3%. O uso de `aria-describedby` em desktop caiu 1%.

Essas mudanças sugerem que os desenvolvedores estão atribuindo nomes acessíveis programaticamente a cada vez mais elementos. Isso pode ser útil, mas também problemático se não for implementado com cuidado.

{{ figure_markup(
  image="button-accessible-name-source.png",
  caption="Origem do nome acessível dos botões.",
  description="Um gráfico de barras mostrando as fontes dos nomes acessíveis dos botões em desktop e em dispositivos móveis. O conteúdo do botão fornece o nome acessível na maioria dos casos (57% em desktop e 55% em dispositivos móveis), seguido pelos atributos `aria-label` (28% e 29%). Cerca de 9% dos botões em desktop e 11% dos botões em dispositivos móveis não têm nome acessível, com parcelas menores vindas dos atributos `title` (1%) e `value` (5% e 4%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=312250756&format=interactive",
  sheets_gid="1995812848",
  sql_file="button_name_sources.sql"
  )
}}

Estamos vendo uma tendência preocupante, com o aumento contínuo, de 4% a 5%, na definição de botões apenas com `aria-label`, sem rótulos visíveis correspondentes. Essa desconexão entre o que o usuário vê e o que as tecnologias assistivas anunciam pode criar confusão e barreiras. Isso vale especialmente para pessoas com deficiências cognitivas ou que usam entrada por voz. Idealmente, o nome acessível e o rótulo visível devem coincidir para proporcionar uma experiência de usuário consistente.

Quase 66% das páginas usam o atributo `aria-label`, mais do que em anos anteriores, o que o torna o atributo ARIA mais usado para nomes acessíveis. Cerca de um quarto das páginas usa `aria-labelledby`.

Embora usar ARIA para melhorar a acessibilidade seja positivo, isso ressalta a importância de testar com tecnologias assistivas e de envolver usuários com deficiência para garantir uma nomeação significativa e precisa.

### Ocultando conteúdo

O atributo `aria-hidden="true"` remove um elemento e todos os seus descendentes da árvore de acessibilidade, tornando o conteúdo invisível para os leitores de tela. Isso é útil para ocultar elementos visuais puramente decorativos ou redundantes que, de outra forma, confundiriam usuários não visuais.

{{ figure_markup(
  caption="Páginas com pelo menos um elemento com o atributo `aria-hidden`.",
  content="66%",
  classes="big-number",
  sheets_gid="2081252628",
  sql_file="common_aria_role.sql"
)
}}

Em 2025, o uso de `aria-hidden` aumentou 3% em comparação com 2024. Aproximadamente 66% dos sites têm algum conteúdo oculto por meio desse atributo ARIA.

Da mesma forma, o atributo `aria-expanded`, que sinaliza se uma seção de conteúdo está expandida ou recolhida, também teve sua adoção ampliada, chegando a 40% dos sites em desktop e 38% dos sites em dispositivos móveis. Esse atributo é importante para comunicar às tecnologias assistivas o estado de widgets de disclosure, como acordeões ou menus expansíveis.

A aplicação criteriosa desses atributos ARIA continua sendo crucial em 2025. Eles ajudam no gerenciamento de conteúdo dinâmico e garantem experiências inclusivas em diferentes dispositivos e para diferentes necessidades dos usuários.

### Texto exclusivo para leitores de tela

Em 2025, uma técnica comum e eficaz de acessibilidade é o uso de texto exclusivo para leitores de tela. Trata-se de um texto visualmente oculto, mas que continua acessível a tecnologias assistivas como os leitores de tela. Essa abordagem costuma ser aplicada para fornecer contexto adicional, instruções ou rótulos descritivos para elementos interativos sem poluir a interface visível.

Os desenvolvedores frequentemente usam classes CSS comuns, como `.sr-only`, `.visually-hidden` ou `.element-invisible`, para obter esse efeito. Essas classes normalmente usam posicionamento fora da tela, recorte ou caixas de tamanho zero para ocultar o texto visualmente, garantindo que ele permaneça na árvore de acessibilidade e possa ser lido pelos leitores de tela.

{{ figure_markup(
  caption="Sites em desktop com uma classe sr-only ou visually-hidden.",
  content="16%",
  classes="big-number",
  sheets_gid="1554469444",
  sql_file="sr_only_classes.sql"
)
}}

O uso dessas classes comuns de texto exclusivo para leitores de tela permaneceu praticamente inalterado entre 2024 e 2025. Alguns sites incluem texto oculto para fornecer aos usuários de leitores de tela um contexto que pode não ficar evidente apenas pelo HTML semântico.

### Conteúdo renderizado dinamicamente

As live regions ARIA são fundamentais para tornar acessível o conteúdo que muda dinamicamente. Elas informam os leitores de tela sobre atualizações no conteúdo da página, como mensagens de validação de formulários, atualizações de status ou feeds ao vivo. Essas atualizações ocorrem sem recarregar a página inteira e, por isso, as live regions são necessárias para que os usuários recebam informações importantes sem interrupções.

<figure>
  <table>
    <thead>
      <tr>
        <th>Role</th>
        <th>Desktop</th>
        <th>Mobile</th>
        <th>Valor implícito de <code>aria-live</code></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>status</td>
        <td class="numeric">15.18%</td>
        <td class="numeric">14.51%</td>
        <td>polite</td>
      </tr>
      <tr>
        <td>alert</td>
        <td class="numeric">7.12%</td>
        <td class="numeric">6.74%</td>
        <td>assertive</td>
      </tr>
      <tr>
        <td>timer</td>
        <td class="numeric">0.91%</td>
        <td class="numeric">0.84%</td>
        <td>off</td>
      </tr>
      <tr>
        <td>log</td>
        <td class="numeric">0.61%</td>
        <td class="numeric">0.55%</td>
        <td>polite</td>
      </tr>
      <tr>
        <td>marquee</td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.10%</td>
        <td>off</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Páginas com roles ARIA de live region e seu valor implícito de `aria-live`.",
      sheets_gid="2081252628",
      sql_file="common_aria_role.sql"
      )
    }}
  </figcaption>
</figure>

Em 2025, cerca de 33% dos sites usam o atributo `aria-live`, um aumento de 4% em relação a 2024. O uso do valor `status` para `role`, que equivale essencialmente a um valor `polite` de `aria-live`, aumentou aproximadamente 5%. Isso sinaliza uma adoção mais ampla de notificações polite, que informam os usuários sobre atualizações não urgentes.

Outras roles ARIA, como `alert`, `timer`, `log` e `marquee`, também têm atributos `aria-live` implícitos com comportamentos predefinidos, permitindo um amplo espectro de casos de uso de live regions.

O aumento do uso de live regions ARIA em 2025 reflete um progresso na comunicação eficaz de atualizações de conteúdo dinâmico, apoiando os usuários que dependem de tecnologias assistivas para interagir com experiências web modernas e responsivas.

## Widgets de personalização do usuário e remediação por overlays

Widgets de acessibilidade e ferramentas de remediação por overlay são scripts de terceiros projetados para melhorar a acessibilidade dos sites. Eles oferecem opções de personalização ao usuário, como ajustes de tamanho de fonte ou de contraste, e correções automatizadas para problemas comuns de acessibilidade.

Esses overlays muitas vezes prometem conformidade por meio de uma solução rápida, mas não dão conta de desafios complexos de acessibilidade que exigem mudanças manuais no código e no design. O <a hreflang="en" href="https://www.edf-feph.org/accessibility-overlays-dont-guarantee-compliance-with-european-legislation/">Fórum Europeu da Deficiência</a> alertou que essas ferramentas podem interferir nas tecnologias assistivas dos próprios usuários, criando conflitos que reduzem a acessibilidade e frustram os usuários.

Embora os overlays possam ajudar a remover algumas barreiras superficiais e oferecer recursos adicionais de personalização, depender deles muitas vezes leva as organizações a deixar de investir em uma acessibilidade adequada. Os overlays geralmente trazem mais desvantagens de usabilidade, segurança e desempenho do que corrigir os problemas no código subjacente.

{{ figure_markup(
  image="pages-using-accessibility-apps-overlays.png",
  caption="Páginas que usam aplicativos de acessibilidade (overlays).",
  description="Um gráfico de colunas com várias séries mostrando a porcentagem de páginas que usam aplicativos de acessibilidade (overlays) em desktop e em dispositivos móveis de 2021 a 2025. O uso cresceu de forma constante: em desktop, de 1,0% para 2,1%, e em dispositivos móveis, de 0,8% para 1,8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=277084081&format=interactive",
  sheets_gid="93717182",
  sql_file="a11y_technology_usage.sql"
  )
}}

Os dados mostram que cerca de 2% dos sites em desktop usam esses aplicativos de acessibilidade. As taxas são ainda menores entre os sites com mais tráfego: 0,2% entre os 1.000 principais. Esse padrão mostra que os overlays são adotados principalmente por sites com menos tráfego e continuam sendo uma solução controversa e imperfeita.

Apesar de um aumento marginal no uso em 2025, a distribuição desses aplicativos de acessibilidade permanece consistente com a de 2024, dominada por fornecedores como <a hreflang="en" href="https://userway.org/">UserWay</a>, <a hreflang="en" href="https://accessibe.com/">AccessiBe</a>, <a hreflang="en" href="https://www.audioeye.com/">AudioEye</a> e <a hreflang="en" href="https://www.equalweb.com/">EqualWeb</a>.

{{ figure_markup(
  image="accessibility-app-usage-by-rank.png",
  caption="Uso de aplicativos de acessibilidade por ranking.",
  description="Um gráfico de colunas com várias séries mostrando a porcentagem de páginas que usam aplicativos de acessibilidade específicos (AccessiBe, AudioEye, EqualWeb, UserWay) por faixa de ranking dos sites, dos 1.000 principais aos 100 milhões principais. O UserWay apresenta o maior uso na maioria das faixas, com pico de 0,81% no grupo dos 10 milhões principais, enquanto o AccessiBe atinge o pico de 0,58% no grupo de 1 milhão principal. O uso tende a ser maior nas faixas intermediárias de ranking (de 10.000 a 10 milhões) em comparação com os sites das faixas mais altas e mais baixas.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1915310442&format=interactive",
  sheets_gid="2094043875",
  sql_file="a11y_technology_usage_by_domain_rank.sql"
  )
}}

### Confusão sobre overlays

Os overlays de acessibilidade e os widgets de personalização, embora tenham crescido marginalmente, cerca de 2%, em 2025, continuam sendo uma fonte significativa de controvérsia e confusão.

Organizações de referência, como a International Association of Accessibility Professionals (IAAP) e o Fórum Europeu da Deficiência (EDF), alertaram explicitamente que os overlays não são uma solução mágica. Eles nunca devem impedir o acesso dos usuários nem interferir em suas tecnologias assistivas, e não devem ser comercializados como algo que deixa um site em total conformidade.

As alegações de marketing muitas vezes criam expectativas irreais nas organizações, gerando riscos jurídicos e práticos. Essas ferramentas não podem substituir o design inclusivo, os testes manuais de acessibilidade e a remediação contínua. Tudo isso é essencial para atender aos padrões de acessibilidade.

O Ato Europeu de Acessibilidade e outras regulamentações enfatizam que a acessibilidade deve ser incorporada aos sites desde a origem. Embora existam overlays de acessibilidade, eles não atendem aos critérios detalhados dos padrões de acessibilidade se o próprio site subjacente não for acessível. Portanto, eles não são uma solução adequada por si sós.

O Bitvtest.de <a hreflang="de" href="https://bitvtest.de/test-methodik/web/beschreibung-des-pruefverfahrens#c761">decidiu recentemente</a> deixar de testar sites que usam uma ferramenta de overlay e proibir neles o uso do seu selo de certificação. O Bitvtest é um serviço profissional de testes de acessibilidade construído em torno do BITV-Test alemão, uma forma estruturada de verificar o quão acessível é um site ou aplicativo.

## O impacto da Inteligência Artificial (IA)

A inteligência artificial (IA) é um amplo campo da ciência da computação voltado à construção de sistemas capazes de realizar tarefas que normalmente exigem inteligência humana. Dentro desse campo, os grandes modelos de linguagem (LLMs) são um tipo específico de sistema de IA treinado com conjuntos de dados muito grandes para aprender padrões estatísticos.

Os LLMs usam esses padrões para gerar e transformar texto, responder a perguntas e seguir instruções, mas não têm compreensão nem intenção no sentido humano. Eles preveem palavras e frases prováveis com base em seus dados de treinamento.

As ferramentas de acessibilidade web dependem cada vez mais de LLMs. Muitas plataformas agora oferecem texto `alt` gerado por IA como forma de lidar com descrições de imagem ausentes, embora a qualidade e a precisão dessas soluções automatizadas variem bastante.

Os desenvolvedores estão incorporando ferramentas de IA, como o <a hreflang="en" href="https://github.com/github/accessibility-scanner">Accessibility Scanner do GitHub</a>, ao seu trabalho diário. Essas ferramentas oferecem feedback instantâneo e recomendações de acessibilidade, facilitando a correção de problemas de acessibilidade.

Mas a IA na acessibilidade não está livre de problemas.

No momento, não há uma forma padronizada de saber se a IA criou ou aprimorou um site ou seu conteúdo. Isso dificulta a avaliação dos sites e deixa os usuários sem saber o que estão vendo.

Alguns especialistas, como a defensora da acessibilidade Léonie Watson, falam de uma "<a hreflang="en" href="https://tetralogical.com/blog/2025/08/08/accessibility-and-the-agentic-web/">web agêntica</a>", em que a IA muda a forma como interagimos com o conteúdo online. Isso levanta questões sobre como os padrões de acessibilidade precisam se adaptar.

Navegadores e extensões com IA estão se popularizando rapidamente. Assistentes de voz e agentes de IA integrados aos navegadores podem em breve dar conta da maior parte das nossas buscas básicas por informação. As pessoas já têm a opção de escolher respostas geradas por IA em vez dos resultados de busca tradicionais. Essa mudança pode ajudar ou prejudicar o design acessível. Tudo depende de essas ferramentas de IA serem, elas próprias, totalmente acessíveis.

Especialistas como Joe Dolson investigaram se a <a hreflang="en" href="https://wpbuilds.com/accessibility/5/">IA consegue construir sozinha sites totalmente acessíveis</a>, destacando tanto o potencial quanto as limitações atuais da tecnologia. As <a hreflang="en" href="https://scottvinkle.com/blogs/work/4-ways-i-use-ai-as-an-accessibility-specialist">experiências de Scott Vinkle na Shopify</a> mostram como a IA pode melhorar a acessibilidade em situações reais.

<a hreflang="en" href="https://www.a11y-collective.com/blog/artificial-intelligence-accessibility/">O blog do The A11Y Collective sobre Inteligência Artificial e Acessibilidade</a> aponta que, embora ferramentas de IA que automatizam texto `alt` ou legendas em tempo real, assim como os assistentes de voz, possam ajudar a acessibilidade em escala, elas ainda têm dificuldades com precisão, contexto, privacidade e viés.

<a hreflang="en" href="https://dri.es/comparing-local-llms-for-alt-text-generation">Uma pesquisa de Dries Buytaert</a> mostra que a IA consegue dar conta de enormes acúmulos de imagens sem descrição, mas a revisão humana ainda é essencial para garantir a qualidade. Ele explora o equilíbrio entre qualidade, privacidade, custo e complexidade para organizações que estão considerando texto alternativo gerado por IA.

A <a hreflang="en" href="https://www.digitalaccesstraining.com/pages/articles?p=ai-and-accessibility-opportunities-and-challenges-for-content-creators">Digital Accessibility Training</a> descreve as oportunidades e os desafios da IA para criadores de conteúdo. As ferramentas de IA viabilizam recursos de acessibilidade em escala, mas levantam preocupações sobre a validade do conteúdo, vieses e uso ético.

Hidde de Vries <a hreflang="en" href="https://hidde.blog/ai-for-accessible-components/">compara como humanos e modelos de linguagem abordam o código de componentes acessíveis</a>. Os humanos baseiam suas decisões de HTML, CSS e ARIA em especificações, necessidades dos usuários, comportamento das tecnologias assistivas e peculiaridades das plataformas, tudo guiado pelas intenções para a interface. Já os LLMs preveem o código provável a partir dos dados de treinamento, o que é problemático porque a maior parte do código existente tem problemas de acessibilidade, e os modelos não têm intenção nem compreensão de usuários específicos.

Adrian Roselli reconhece que os avanços recentes em visão computacional e LLMs podem potencialmente ajudar os leitores a condensar artigos complexos em resumos compreensíveis. No entanto, ele argumenta que <a hreflang="en" href="https://adrianroselli.com/2023/06/no-ai-will-not-fix-accessibility.html">essas ferramentas ainda carecem de contexto e autoria</a>. Elas não conseguem saber por que um conteúdo foi criado, do que depende uma piada ou um meme, nem como uma interface deve funcionar. Suas descrições e sugestões de código podem facilmente errar o foco ou induzir os usuários ao erro.

A IA levanta preocupações éticas significativas que vão além da acessibilidade.

{{ figure_markup(
  caption="Número equivalente de carros a gasolina em emissões de carbono necessárias para treinar um LLM.",
  content="100",
  classes="big-number",
)
}}

Uma questão importante é o impacto ambiental. Um <a hreflang="en" href="https://arxiv.org/ftp/arxiv/papers/2104/2104.10350.pdf">estudo sobre emissões de carbono e o treinamento de grandes redes neurais</a> estimou que treinar um único grande modelo de linguagem, como o GPT‑3, consumiu mais de 1.200 megawatts-hora de eletricidade e produziu cerca de 500–550 toneladas métricas de CO₂ equivalente. Isso é comparável às emissões de mais de 100 carros a gasolina ao longo de toda a sua vida útil. Para mais informações, consulte o capítulo [Sustentabilidade](./sustainability).

Outra preocupação central é como os dados de treinamento são coletados e usados. Vários <a hreflang="en" href="https://natlawreview.com/article/two-major-lawsuits-aim-answer-multi-billion-dollar-question-can-ai-train-your">processos judiciais de grande repercussão</a> alegam que fornecedores de IA coletaram e usaram material protegido por direitos autorais sem permissão ou compensação. Isso incluiu milhões de fotos de banco de imagens e livros.

<a hreflang="en" href="https://www.boia.org/blog/ethics-of-ai-in-accessibility-avoiding-bias-when-using-generative-ai-text">Estudos</a> sobre grandes modelos mostram que eles podem amplificar vieses capacitistas, racistas e outros vieses nocivos presentes em seus dados de treinamento. Isso acaba moldando a forma como deficiência, raça e gênero são descritos, reforçando estigmas em escala.

Olhando para o futuro, está claro para nós que a IA se tornará cada vez mais uma ferramenta da qual desenvolvedores web e criadores de conteúdo dependem. No entanto, a IA deve apoiar a expertise humana, e não substituí-la.

À medida que essas ferramentas melhoram, a comunidade de acessibilidade precisa responder a algumas perguntas importantes em 2026 e nos anos seguintes:

- Como verificamos se o conteúdo gerado por IA é preciso e acessível?
- Que padrões devem reger o uso de IA em conteúdo web?
- Como as tecnologias assistivas vão funcionar com interfaces orientadas por IA?
- A IA pode oferecer acessibilidade igualitária respeitando as necessidades individuais?
- De quais diretrizes éticas precisamos para evitar que a IA reforce vieses ou exclua pessoas?

## Setores e acessibilidade

Esta seção compara as pontuações de acessibilidade entre diversos setores da indústria e da comunidade para identificar padrões e líderes.

### País

Podemos identificar o país de origem de um site pela localização geográfica do servidor (GeoID) ou pelo seu domínio de nível superior (TLD). Ambos os métodos têm limitações. Custos de hospedagem, estratégias de localização de servidores e práticas de propriedade de domínios fazem com que o servidor de um site nem sempre reflita seu público-alvo. TLDs usados globalmente, como `.ai` ou `.io`, não estão necessariamente ligados aos seus países de origem.

{{ figure_markup(
  image="most-accessible-by-geoid-of-server.png",
  caption="Mais acessíveis por GeoID do servidor",
  description="Uma tabela que classifica os países pela pontuação média de acessibilidade em seus domínios de nível superior, com os Estados Unidos na liderança, com 85,63%, seguidos de perto pelo Canadá (84,98%), pelo Reino Unido (84,96%) e pela Austrália (84,59%). A Alemanha (84,53%) e outros países europeus, como os Países Baixos (83,86%) e a França (83,82%), também aparecem bem classificados, enquanto países asiáticos como o Japão (81,54%), a Coreia do Sul (79,39%) e Taiwan (79,19%) têm pontuações menores.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1913573905&format=interactive",
  sheets_gid="134589352",
  sql_file="lighthouse_score_by_country.sql",
  height=500
  )
}}

Em 2025, os Estados Unidos continuam sendo o país mais acessível por GeoID, posição impulsionada por décadas de requisitos de conformidade com a Seção 508 para agências federais e pelos litígios contínuos com base no Título III da ADA. Os TLDs `.edu` e `.gov` também lideram as métricas de acessibilidade, refletindo a conformidade obrigatória para instituições governamentais e educacionais dos EUA.

Também observamos o impacto limitado do Ato Europeu de Acessibilidade em 2025. Embora o Ato tenha entrado plenamente em vigor em 28 de junho de 2025, exigindo que os serviços digitais dos setores público e privado sejam acessíveis em toda a União Europeia, os dados preliminares não mostram nenhum salto expressivo na acessibilidade dos sites sediados na Europa.

Esse atraso provavelmente reflete desafios de implementação, períodos de transição para serviços existentes e o tempo necessário para que as organizações redesenhem e auditem suas ofertas digitais.

A fiscalização legal e a ameaça de litígios continuam sendo os principais impulsionadores da conformidade em acessibilidade, como evidencia a posição de liderança dos Estados Unidos. O impacto total das legislações europeias e globais mais recentes pode levar anos para se refletir nas estatísticas de acessibilidade web, à medida que as organizações avançam em seus cronogramas de implementação e períodos de transição.

Notamos uma tendência relevante surgindo em 2025. Os domínios `.ai` apareceram pela primeira vez nos rankings de acessibilidade e agora superam todos os TLDs, exceto `.edu` e `.gov`. Isso provavelmente reflete a crescente adoção por empresas ligadas à IA, muitas das quais priorizam práticas de desenvolvimento modernas, incluindo acessibilidade.

Originalmente atribuída a [Anguila](https://en.wikipedia.org/wiki/Anguilla), uma pequena ilha do Caribe, em 1995, a extensão de TLD `.ai` permaneceu relativamente obscura por quase 15 anos, até 2009, quando Anguila abriu os registros diretos para o mundo todo. O domínio ficou adormecido durante a maior parte de sua história, até que o boom da inteligência artificial, de 2022 em diante, o transformou em um dos TLDs que mais crescem no mundo.

O catalisador veio com a chegada do ChatGPT, no fim de 2022, que despertou um interesse sem precedentes pela IA. Entre julho de 2022 e julho de 2023, os <a hreflang="en" href="https://domainwheel.com/ai-domains-statistics/">domínios `.ai` registrados dispararam</a> de 75.314 para 196.292, um aumento de 161% em apenas doze meses.

Geograficamente, a América do Norte responde pela maioria dos <a hreflang="en" href="https://techjury.net/industry-analysis/the-rise-of-ai-domains/">registros</a> de domínios `.ai`, com 62,5%, sendo que somente os Estados Unidos respondem por 62,5% de todos os domínios `.ai` registrados. A Ásia vem em seguida, com 18,8%, e a Europa, com 17,2%.

Muitos titulares de domínios `.ai` são startups de tecnologia bem financiadas, apoiadas por capital de risco, com maior probabilidade de usar IA. Ainda está em debate se a IA consegue produzir código mais acessível do que equipes humanas, mas esse é um indicador.

Ao contrário das empresas tradicionais mais antigas, que usam `.com` ou `.org`, as empresas de IA mais novas costumam construir com padrões e ferramentas web contemporâneos, que consideram a acessibilidade desde o início. Essas empresas que usam um domínio `.ai` e vendem produtos de IA muito provavelmente envolveram a IA na construção de seus sites, ao menos consultando-a para obter código ou conteúdo, se não usando-a em configurações agênticas mais automatizadas.

TLDs tradicionais como `.com`, `.org` e `.net` não aparecem entre os líderes em acessibilidade. Isso sugere que o tipo de domínio, por si só, não é um forte indicador de conformidade em acessibilidade.

{{ figure_markup(
  image="accessible-countries-by-top-level-domain-tld.png",
  caption="Países acessíveis por domínio de nível superior (TLD).",
  description="Um gráfico de barras que classifica os domínios de nível superior (TLDs) pela pontuação média de acessibilidade. Os domínios educacionais (.edu) e governamentais (.gov) lideram, com 89,1% e 87,6%, seguidos por .ai (87,2%), .no (87,0%) e .fi (86,5%). TLDs de código de país como .ca (85,9%), .io (85,8%), .se (85,5%), .at (85,4%) e .uk (85,3%) também têm pontuações altas, com TLDs gerais como .de (85,0%) e .co (84,6%) na parte mais baixa do top 20.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=414356016&format=interactive",
  sheets_gid="1037208406",
  sql_file="lighthouse_score_by_tld.sql",
  width=600,
  height=480
  )
}}

O mapa do ranking de TLDs é muito parecido com o de 2024, mas obviamente não inclui o número crescente de TLDs não específicos de países disponíveis atualmente.

{{ figure_markup(
  image="map-accessible-countries-by-tld.png",
  caption="Mapa de países acessíveis por domínio de nível superior (TLD).",
  description="Exibidos visualmente em um mapa-múndi, os países mais acessíveis são a Noruega, com 87%, e a Finlândia, com 86%, seguidas por Canadá, EUA, Reino Unido, Suécia, Irlanda, Austrália, Nova Zelândia, Áustria, Bélgica, Suíça, Dinamarca e África do Sul. A China é o país menos acessível por domínio de nível superior, com cerca de 67%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1554186781&format=interactive",
  sheets_gid="1037208406",
  sql_file="lighthouse_score_by_tld.sql"
  )
}}

### Governo

Os sites governamentais continuam sendo uma arena crucial para demonstrar o compromisso público com a acessibilidade. Mas a implementação varia drasticamente entre as jurisdições. Os dados de 2025 revelam tendências importantes na acessibilidade dos sites governamentais em todo o mundo, influenciadas por legislações recentes, mudanças metodológicas na coleta de dados e mecanismos de fiscalização.

Usamos uma metodologia diferente este ano para conseguir avaliar uma gama mais ampla de domínios que ficaram fora das varreduras em 2024.

Em 2024, amostramos apenas 79 domínios do governo dos Países Baixos. Em 2025, consultamos mais de 10 vezes esse número, com 957 domínios. Da mesma forma, varremos cerca do dobro de domínios de Luxemburgo e da Finlândia. A maior precisão significa que temos um conjunto de dados mais abrangente, mas também uma comparação ano a ano mais complexa.

No Reino Unido, vimos uma melhora para 94% de acessibilidade, um aumento de 2% em relação a 2024. Isso reflete os benefícios de design systems padronizados, como o <a hreflang="en" href="https://www.gov.uk/service-manual/service-standard">Padrão de Serviços Digitais do Governo do Reino Unido</a>, que prioriza a acessibilidade em todos os serviços digitais públicos. Os Países Baixos, Luxemburgo e a Finlândia continuam liderando, com os Países Baixos tendo alcançado 98% em anos anteriores. Eles mantiveram essa posição por meio de estruturas de governança consistentes e da priorização de design systems.

Também nos esforçamos para incluir a Escócia (gov.scot) e o País de Gales (gov.wales). Em 2025, calculamos a média a partir de 19.568 domínios, enquanto em 2024 foram apenas 16.594.

O monitoramento é uma parte essencial da priorização da acessibilidade, e aplaudimos <a hreflang="en" href="https://observatoire.numerique.gouv.fr/observatoire">painéis como o do Governo Francês</a>, que destacam o progresso em diversos indicadores de qualidade de sites, incluindo acessibilidade. Grande parte do código por trás disso é de código aberto. O governo neerlandês também tem um <a hreflang="en" href="https://dashboard.digitoegankelijk.nl/">painel</a> que acompanha quase 9.000 sites e aplicativos. No momento em que este texto foi escrito, 60% de todas as propriedades web monitoradas estavam em conformidade com os requisitos legais.

Os <a hreflang="en" href="https://accessible-eu-centre.ec.europa.eu/accessibility-monitoring_en">Relatórios de Monitoramento de Acessibilidade feitos pelo AccessibleEU</a> são importantes, mas muito mais abstratos. A [Diretiva de Acessibilidade da Web](https://en.wikipedia.org/wiki/Web_Accessibility_Directive) da UE exige que os Estados-membros monitorem e relatem a conformidade em acessibilidade a cada 3 anos. <a hreflang="en" href="https://digital-strategy.ec.europa.eu/en/news/web-accessibility-directive-monitoring-reports-2022-2024">Esses relatórios</a> estão disponíveis publicamente.

O cenário regulatório em evolução da União Europeia teve um impacto significativo na acessibilidade dos sites governamentais em 2025.

A Diretiva de Acessibilidade da Web da UE exige que as organizações do setor público atendam a padrões técnicos específicos. O Ato Europeu de Acessibilidade (EAA), mais amplo, que entrou plenamente em vigor em 28 de junho de 2025, estende os requisitos a organizações do setor privado em setores-chave, como comércio eletrônico, viagens e bancos.

Apesar desse impulso regulatório, os dados de acessibilidade de 2025 não mostram nenhum salto expressivo na conformidade dos sites governamentais europeus, o que sugere que a implementação ainda está em andamento e que o impacto total talvez só se torne visível em 2026.

Os Estados-membros da UE são obrigados a publicar declarações de acessibilidade e a oferecer mecanismos de feedback para que os usuários relatem barreiras. As <a hreflang="en" href="https://cerovac.com/a11y/2025/07/we-need-to-talk-about-your-accessibility-statement/">declarações de acessibilidade</a> são uma parte importante da Diretiva de Acessibilidade da Web da UE, mas, até o momento, não temos uma boa forma de incluí-las nas varreduras de sites. A Funka Foundation nos lembrou das <a hreflang="en" href="https://www.linkedin.com/pulse/yes-nordics-score-well-lets-think-one-step-further-funkafoundation-yczzf/">limitações desse tipo de teste para avaliar conformidade</a>.

{{ figure_markup(
  image="most-accessible-national-government.png",
  caption="Governos nacionais mais acessíveis.",
  description="Um gráfico de barras que classifica os domínios de governos nacionais pela pontuação média de acessibilidade. O Reino Unido lidera, com 94,31%, seguido de perto pelos Países Baixos (93,81%), Finlândia (93,77%), Noruega (93,49%) e Suécia (93,37%). Vários outros governos europeus e da Commonwealth, incluindo Singapura, Dinamarca, Luxemburgo, a União Europeia, Austrália, Áustria, Bélgica, Islândia, Nova Zelândia e Irlanda, também têm pontuação igual ou superior a 90%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=940831164&format=interactive",
  sheets_gid="1855027591",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

O mapa de 2025 é quase indistinguível do de 2024.

{{ figure_markup(
  image="map-accessibility-global-government-websites.png",
  caption="Mapa da acessibilidade dos sites governamentais no mundo.",
  description="O mapa ilustra visualmente os sites governamentais mais acessíveis ao redor do mundo. Os países escandinavos se destacam, assim como muitos outros na Europa. Austrália e Nova Zelândia aparecem em destaque no Pacífico. O Canadá está um pouco mais escuro do que os Estados Unidos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=1960560393&format=interactive",
  sheets_gid="1855027591",
  sql_file="lighthouse_score_by_government.sql"
  )
}}

Nos Estados Unidos, a conformidade dos governos estaduais continua inconsistente, apesar das novas exigências federais. A regra final do Departamento de Justiça (DOJ) sobre o Título II da Lei dos Americanos com Deficiência, publicada em junho de 2024, exige que todas as entidades governamentais estaduais e locais alcancem a conformidade com a WCAG 2.1 AA dentro de prazos específicos: 26 de abril de 2026, para entidades que atendem populações de 50.000 pessoas ou mais, e 26 de abril de 2027, para entidades menores.

Estados como Colorado e Vermont se destacaram ao estabelecer estruturas de governança centralizadas. A <a hreflang="en" href="https://sipa.colorado.gov/">Statewide Internet Portal Authority do Colorado</a> (SIPA) demonstra como a gestão centralizada melhora a acessibilidade em várias agências.

Nevada, Kansas, Califórnia e Nova York tiveram bom desempenho nas amostras de ambos os anos. Mas as médias não indicam que os governos estaduais tenham feito qualquer progresso significativo no cumprimento dos novos requisitos da <a hreflang="en" href="https://www.justice.gov/archives/opa/pr/justice-department-publish-final-rule-strengthen-web-and-mobile-app-access-people">Regra Final do Departamento de Justiça dos EUA de 2024 para Fortalecer o Acesso à Web e a Aplicativos Móveis</a>. Líderes estaduais de tecnologia, na conferência nacional da National Association of State Chief Information Officers (NASCIO), <a hreflang="en" href="https://statescoop.com/accessibility-nascio-state-priority-2025/">reafirmaram a acessibilidade como prioridade máxima</a>.

A Lei dos Americanos com Deficiência (ADA), que <a hreflang="en" href="https://www.access-board.gov/news/2025/07/21/celebrating-35-years-of-americans-with-disabilities-act/">completou 35 anos em julho</a>, foi um trabalho pioneiro que estabeleceu um precedente global.

O <a hreflang="en" href="https://archive.opengovasia.com/2025/03/11/digital-accessibility-singapores-commitment-to-inclusivity/?c=ca">compromisso recente de Singapura com a melhoria da acessibilidade</a>, demonstrado por meio da ferramenta de código aberto <a hreflang="en" href="https://github.com/GovTechSG/oobee">Oobee</a>, mostra um impulso global emergente. O Oobee permite que as organizações façam a varredura de centenas de páginas e gerem relatórios de acessibilidade consolidados, o que o posiciona como um <a hreflang="en" href="https://www.digitalpublicgoods.net/r/oobee">Bem Público Digital</a>.

{{ figure_markup(
  image="most-accessible-us-state-governments.png",
  caption="Os governos estaduais mais acessíveis dos EUA.",
  description="Um gráfico de barras que classifica os sites dos governos de estados e territórios dos EUA pela pontuação média de acessibilidade. New Hampshire lidera, com 94,61%, seguido por Nevada (92,43%), Kansas (91,67%), Nova York (91,45%) e Carolina do Sul (91,07%). Muitos outros estados, incluindo Arizona, Califórnia, Missouri, Montana e Carolina do Norte, também têm pontuações em torno de 90% ou mais, enquanto estados como Nova Jersey (83,91%) e Rhode Island (83,31%) aparecem na parte mais baixa da lista.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=445029634&format=interactive",
  sheets_gid="1855027591",
  sql_file="lighthouse_score_by_government.sql",
  width=600,
  height=500
  )
}}

### Sistemas de Gerenciamento de Conteúdo (CMS)

A escolha do Sistema de Gerenciamento de Conteúdo (CMS) de um site influencia significativamente seus resultados de acessibilidade. Usando dados do <a hreflang="en" href="https://almanac.httparchive.org/en/2024/methodology#wappalyzer">Wappalyzer</a>, o Web Almanac 2025 comparou as pontuações de acessibilidade entre CMSs tradicionais, plataformas e criadores de sites especializados. Isso revelou tanto padrões consistentes quanto exceções notáveis.

{{ figure_markup(
  image="most-accessible-traditional-cms.png",
  caption="CMSs tradicionais mais acessíveis.",
  description="Um gráfico de barras que classifica os sistemas de gerenciamento de conteúdo (CMSs) tradicionais pela pontuação média de acessibilidade. Contentful e Adobe Experience Manager lideram, com pontuações de 88,28% e 88,26%, seguidos por WordPress (85,58%), Contao (85,29%), Drupal (85,22%) e Craft CMS (85,13%). TYPO3 CMS, Odoo, DNN e Joomla completam a lista, com pontuações que vão de 84,71% a 82,11%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=2137638034&format=interactive",
  sheets_gid="419466395",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

Entre os CMSs tradicionais, o <a hreflang="en" href="https://www.sitecore.com/">Sitecore</a> manteve 85% de acessibilidade em 2025, embora seu número de instâncias tenha caído para menos de 10.000. O <a hreflang="en" href="https://business.adobe.com/products/experience-manager/sites/aem-sites.html">Adobe Experience Manager (AEM)</a> e o <a hreflang="en" href="https://www.contentful.com/">Contentful</a> continuam liderando, provavelmente porque as grandes corporações que adotam essas soluções corporativas têm mais recursos para resolver problemas de acessibilidade. O <a hreflang="en" href="https://wordpress.com/">WordPress</a> não apresentou melhora significativa em relação a 2024, mas subiu para o terceiro lugar, refletindo seu domínio de mercado e a crescente consciência sobre acessibilidade de sua base de usuários.

Notavelmente, os cinco principais CMSs tradicionais compartilham padrões de erro consistentes. Contraste de cores, nomes de links e ordem dos títulos dominam como os problemas mais comuns. Esses erros refletem principalmente escolhas de conteúdo, e não limitações das plataformas, já que um CMS não pode ditar a nomeação de links ou a escolha de cores. No entanto, o AEM é o único com `label-content-name-mismatch` entre seus cinco principais erros. O WordPress é o único a ter erros de `meta-viewport`.

Entre os 10 principais CMSs, apenas o <a hreflang="en" href="https://www.dnnsoftware.com/">DNN</a> tem `image-alt` entre os 3 principais erros. Para a maioria dos CMSs tradicionais, `image-alt` e `target-size` aparecem de forma consistente em quarto ou quinto lugar entre os erros do Google Lighthouse.

{{ figure_markup(
  image="most-accessible-website-platform-cms.png",
  caption="CMSs de plataformas de criação de sites mais acessíveis.",
  description="Um gráfico de barras que classifica os sistemas de gerenciamento de conteúdo (CMSs) de plataformas de criação de sites pela pontuação média de acessibilidade. O Wix lidera, com pontuação média de 94,19%, seguido por Squarespace (93,05%), WebNode (91,44%) e Google Sites (90,10%). Outras plataformas, como Webflow, HubSpot CMS Hub, Shopify, Framer Sites, Duda e Weebly, também apresentam um desempenho forte, com pontuações que vão de 89,07% a 85,80%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=408491967&format=interactive",
  sheets_gid="419466395",
  sql_file="lighthouse_score_by_cms.sql"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS de plataforma</th>
        <th>Mais comum</th>
        <th>Segundo mais comum</th>
        <th>Terceiro mais comum</th>
        <th>Quarto mais comum</th>
        <th>Quinto mais comum</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a hreflang="en" href="https://www.wix.com/">Wix</a></td>
        <td>heading-order</td>
        <td>link-name</td>
        <td>color-contrast</td>
        <td>button-name</td>
        <td>target-size</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://www.squarespace.com/">Squarespace</a></td>
        <td>color-contrast</td>
        <td>heading-order</td>
        <td>link-name</td>
        <td>label-content-name-mismatch</td>
        <td>frame-title</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://www.webnode.com/">Webnode</a></td>
        <td>heading-order</td>
        <td>link-name</td>
        <td>frame-title</td>
        <td>color-contrast</td>
        <td>image-redundant-alt</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://workspace.google.com/products/sites/">Google Sites</a></td>
        <td>image-alt</td>
        <td>link-name</td>
        <td>aria-allowed-attr</td>
        <td>heading-order</td>
        <td>color-contrast</td>
      </tr>
      <tr>
        <td><a hreflang="en" href="https://webflow.com/">Webflow</a></td>
        <td>link-name</td>
        <td>color-contrast</td>
        <td>heading-order</td>
        <td>html-has-lang</td>
        <td>target-size</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Principais problemas de auditoria de acessibilidade em plataformas de CMS populares.",
      sheets_gid="419466395",
      sql_file="lighthouse_score_by_cms.sql"
      )
    }}
  </figcaption>
</figure>

Plataformas de criação de sites como Wix, Squarespace e Google Sites superam significativamente os CMSs tradicionais em acessibilidade. Esse desempenho superior provavelmente decorre da abordagem delas. Essas plataformas costumam restringir as escolhas dos usuários por meio de designs baseados em templates e padrões de acessibilidade embutidos, reduzindo as oportunidades para decisões ruins de acessibilidade.

Os dados comprovam que a escolha do CMS tem um impacto significativo nos resultados de acessibilidade, mesmo quando os criadores de conteúdo precisam assumir a responsabilidade final por algumas decisões. Plataformas com restrições de design mais rígidas e padrões de acessibilidade embutidos têm melhor desempenho, enquanto aquelas que oferecem máxima flexibilidade deixam as decisões de acessibilidade para os usuários.

### Frameworks JavaScript de frontend

A escolha do framework JavaScript também influencia significativamente os resultados de acessibilidade de um site. Usando as classificações do <a hreflang="en" href="https://stateofjs.com/en-US">relatório State of JS</a>, examinamos como diferentes frameworks de UI e meta-frameworks se correlacionam com o desempenho em acessibilidade. Isso revelou padrões, mudanças e preocupações emergentes.

{{ figure_markup(
  image="most-accessible-javascript-frontend-ui-frameworks.png",
  caption="Frameworks JavaScript de UI para frontend mais acessíveis.",
  description="Um gráfico de barras que classifica os frameworks JavaScript de UI para frontend pela pontuação média de acessibilidade. O Qwik lidera, com pontuação média de 91,86%, seguido por Stimulus (91,42%) e OpenUI5 (90,23%). Astro (89,22%), Next.js (88,05%), Remix (87,61%), React (87,56%), Ember.js (86,72%), Alpine.js (85,91%), Angular (85,63%) e Preact (85,28%) também alcançam pontuações de acessibilidade relativamente altas.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=430687243&format=interactive",
  sheets_gid="1977955459",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

Em 2025, o <a hreflang="en" href="https://openui5.org/">OpenUI5</a> subiu nos rankings de acessibilidade, enquanto os frameworks que lideravam em 2024 (<a hreflang="en" href="https://stimulus.hotwired.dev/">Stimulus</a>, <a hreflang="en" href="https://remix.run/">Remix</a> e <a hreflang="en" href="https://qwik.dev/">Qwik</a>) mudaram de posição. O Remix aparece tanto na categoria de UI quanto na de meta-frameworks, mas caiu nos rankings em 2025, permitindo o avanço de outros frameworks. Essa volatilidade pode refletir mudanças no tamanho da amostra ou melhorias reais nos frameworks concorrentes. O fato de toda a funcionalidade do Remix ter sido integrada diretamente à versão seguinte do <a hreflang="en" href="https://reactrouter.com/">React Router</a>, tornando o Remix redundante como framework React, também pode ter impacto nos rankings.

Historicamente, Stimulus, Remix e Qwik superaram opções mais populares, como React, <a hreflang="en" href="https://svelte.dev/">Svelte</a> ou <a hreflang="en" href="http://Ember.js">Ember.js</a>, por vários pontos percentuais, provavelmente porque priorizam o aprimoramento progressivo e o HTML semântico.

Entre os meta-frameworks, Remix, <a hreflang="en" href="https://rwsdk.com/">RedwoodJS</a> e <a hreflang="en" href="https://astro.build/">Astro</a> lideravam em 2024, e a queda do Remix permitiu que o <a hreflang="en" href="https://www.gatsbyjs.com/">Gatsby</a> subisse para o terceiro lugar em 2025. A ascensão dos meta-frameworks server-first (SvelteKit, Astro, Remix, Qwik, <a hreflang="en" href="https://fresh.deno.dev/">Fresh</a>, <a hreflang="en" href="https://analogjs.org/">Analog</a>) reflete uma mudança mais ampla do setor em direção a melhores práticas de desempenho e acessibilidade, reduzindo a complexidade do JavaScript no lado do cliente.

A escolha da biblioteca também tem impacto na acessibilidade.

O React oferece máxima flexibilidade e personalização, mas exige que os desenvolvedores implementem a acessibilidade de forma intencional. Seu amplo ecossistema inclui bibliotecas focadas em acessibilidade, como <a hreflang="en" href="https://react-spectrum.adobe.com/react-aria/index.html">React Aria</a> e <a hreflang="en" href="https://reach.tech/">Reach UI</a>, mas a acessibilidade não é imposta por padrão.

O <a hreflang="en" href="https://angular.dev/">Angular</a> oferece recursos robustos de acessibilidade embutidos, convenções estruturadas que promovem o HTML semântico, suporte a atributos ARIA e componentes <a hreflang="en" href="https://material.angular.io/">Material Design</a> com navegação por teclado e suporte a leitores de tela prontos para uso. A estrutura opinativa do Angular tende a guiar os desenvolvedores para práticas mais padronizadas e acessíveis.

O <a hreflang="en" href="http://Vue.js">Vue.js</a> busca encontrar um equilíbrio entre a flexibilidade do React e a estrutura do Angular. O design progressivo do Vue, sua sintaxe de templates clara e sua arquitetura de componentes favorecem a acessibilidade, embora ele dependa mais da disciplina dos desenvolvedores e de plugins de terceiros, como o <a hreflang="en" href="https://github.com/vue-a11y">vue-a11y</a>.

Também observamos que o <a hreflang="en" href="https://github.blog/open-source/social-impact/our-pledge-to-help-improve-the-accessibility-of-open-source-software-at-scale/">GitHub assumiu o compromisso do Global Accessibility Awareness Day (GAAD)</a> de melhorar a acessibilidade do código aberto em escala. Esse compromisso aborda uma lacuna crítica: 90% das empresas usam código aberto, 97% das bases de código contêm componentes de código aberto e estima-se que 70–90% do código das ferramentas comerciais derive de código aberto.

{{ figure_markup(
  image="most-accessible-javascript-meta-frameworks.png",
  caption="Meta-frameworks JavaScript mais acessíveis.",
  description="Um gráfico de barras que classifica os meta-frameworks JavaScript pela pontuação média de acessibilidade. O RedwoodJS lidera, com pontuação média de 92,38%, seguido por Astro (89,22%), Gatsby (88,20%), Next.js (88,05%) e Remix (87,61%). Nuxt.js, AdonisJS, Quasar e Meteor completam a lista, com pontuações que vão de 84,52% a 79,91%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQFD-7C6Jv6q1JyviDsKosRlVwaok7g7nRCQ9NGMw5MaAAohL7EcDejVwgp13Z_T2S_57Zi0YaVb7st/pubchart?oid=208297617&format=interactive",
  sheets_gid="1977955459",
  sql_file="lighthouse_score_by_frontend.sql"
  )
}}

O RedwoodJS continua sendo o mais acessível, seguido por Astro e Gatsby.

## Conclusão

A análise de acessibilidade do Web Almanac 2025 revela um ano de progresso gradual, atenuado por desafios significativos e oportunidades perdidas.

Os testes automatizados continuam sendo essenciais para avaliar a acessibilidade em escala. Mas os dados demonstram que <a hreflang="en" href="https://www.a11y-collective.com/blog/how-to-check-web-accessibility/">apenas medir não garante uma melhoria significativa</a>. A comunidade web precisa ir além das métricas básicas de conformidade para enfrentar os problemas sistêmicos que continuam excluindo milhões de usuários com deficiência.

As melhorias mais notáveis em 2025 surgiram em setores e regiões onde a pressão regulatória e os mecanismos de fiscalização são mais fortes. No entanto, a falta de uma melhora expressiva após o prazo de 28 de junho de 2025 do Ato Europeu de Acessibilidade é instrutiva. O impacto total talvez só fique evidente em 2026 e nos anos seguintes.

A rápida ascensão do domínio `.ai` ao grupo dos TLDs mais acessíveis reflete um padrão importante. Empresas de tecnologia mais novas, apoiadas por capital de risco, tendem a construir com práticas modernas de acessibilidade desde o início, enquanto sites legados muitas vezes continuam inacessíveis. Isso comprova que a acessibilidade é alcançável quando priorizada desde o início do desenvolvimento.

Apesar das melhorias em áreas específicas, as principais barreiras de acessibilidade identificadas em 2024 persistem praticamente inalteradas em 2025.

Contraste de cores, nomeação de links, hierarquia de títulos e texto `alt` de imagens continuam sendo os quatro principais problemas em quase todas as plataformas e frameworks. Essas não são falhas diretas da ferramenta, mas da forma como os autores a utilizam. Os autores têm algum papel em todas essas falhas, de acordo com o <a hreflang="en" href="https://www.w3.org/WAI/planning/arrm/tasks/">Accessibility Roles and Responsibilities Mapping (ARRM)</a> do W3C.

Essa realidade revela uma percepção crucial. Plataformas de CMS, frameworks JavaScript e tecnologias web podem fornecer bases de acessibilidade, mas não podem forçar os criadores de conteúdo a fazer escolhas acessíveis. Abordagens como as <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/atag/">Authoring Tool Accessibility Guidelines (ATAG) 2.0</a> e o novo <a hreflang="en" href="https://www.w3.org/community/atag/">ATAG Community Group</a> do W3C podem ajudar.

As métricas de 2025 sugerem estagnação onde esperávamos uma melhora gradual, evidenciando a distância entre o que é fácil de medir e o que é fácil de corrigir.

O crescimento contínuo dos overlays de acessibilidade (agora em 2% dos sites) é preocupante. Parece que as organizações muitas vezes escolhem atalhos em vez de uma acessibilidade genuína. A IAAP e o Fórum Europeu da Deficiência alertaram explicitamente que os overlays podem interferir nas tecnologias assistivas dos usuários e nunca devem substituir o design acessível. Os dados de 2025 confirmam que os overlays continuam concentrados em sites com menos tráfego, um sinal de que organizações de alta qualidade e com bons recursos estão se afastando deles em direção a soluções reais.

Os dados de 2025 ressaltam que a automação é necessária, mas insuficiente. O Lighthouse e ferramentas semelhantes detectam violações facilmente mensuráveis, mas 50% das imagens na web têm texto `alt` vazio ou inadequado. A hierarquia de títulos pode ser auditada, mas a relevância semântica exige julgamento humano. O contraste de cores pode ser verificado, mas as escolhas de design visual envolvem decisões artísticas subjetivas, embasadas pelos requisitos de acessibilidade.

Nossos resultados de 2025 revelam uma web que continua, em grande parte, inacessível para milhões de pessoas com deficiência.

Embora as melhorias graduais em áreas específicas sejam encorajadoras, as lacunas persistentes em contraste de cores, nomeação de links, estrutura de títulos e descrições de imagens demonstram que a comunidade web ainda não fez da acessibilidade uma prioridade genuína.

A ascensão dos domínios `.ai`, o compromisso do GitHub com o código aberto e prazos regulatórios como os do Ato Europeu de Acessibilidade e da regra final do Título II da ADA trazem a esperança de que 2026 tenha mudanças mais substanciais. Mas isso só acontecerá se as organizações forem além da medição para a responsabilização, da retórica para os recursos e da conformidade para a inclusão genuína.

A web deve funcionar para todos. Enquanto esse princípio não orientar nossas decisões de design, desenvolvimento e implantação, as lacunas de acessibilidade documentadas neste relatório vão persistir.
