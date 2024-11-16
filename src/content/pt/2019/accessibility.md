---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Acessibilidade
description: Capítulo de acessibilidade do Web Almanac de 2019 cobrindo facilidade de leitura, mídia, facilidade de navegação e compatibilidade com tecnologias assistivas.
hero_alt: Hero image of a robot with a blue, human accessibility icon on its front scanning a web page, while Web Almanac characters check some labels.
authors: [nektarios-paisios, foxdavidj, kleinab]
reviewers: [ljme]
analysts: [dougsillars, rviscomi, foxdavidj]
editors: [foxdavidj]
translators: [eduqg]
discuss: 1764
results: https://docs.google.com/spreadsheets/d/16JGy-ehf4taU0w4ABiKjsHGEXNDXxOlb__idY8ifUtQ/
nektarios-paisios_bio: Nektarios Paisios é um engenheiro de software que trabalha com acessibilidade do Chrome nos últimos 5 anos. Ele se concentra principalmente em tornar o Chrome compatível com software auxiliar de terceiros, como leitores e ampliadores de tela. Antes de trabalhar na acessibilidade do Chrome, Nektarios trabalhou em várias outras funções na empresa, como acessibilidade do GSuite e anúncios gráficos. Nektarios é Ph.D. em Ciência da Computação pela New York University.
foxdavidj_bio: David Fox é o principal pesquisador de usabilidade e fundador da LookZook, uma empresa obcecada em descobrir tudo o que há para saber sobre a construção de experiências na Web que atendem às expectativas do usuário. Ele é um psicólogo de sites que procura sites para aprender não apenas com o que os usuários estão enfrentando, mas por que e como melhorar sua experiência. Ele também é colaborador do Google Chromium, palestrante e fornecedor de seminários on-line e treinamento em UX.
kleinab_bio: Abigail Klein é engenheira de software do Google. Ela trabalhou na acessibilidade da web do Google Docs, Sheets e Slides, onde adicionou  <a hreflang="en" href="https://www.blog.google/outreach-initiatives/accessibility/whats-you-say-present-captions-google-slides/">legendas automáticas para a Apresentações Google</a>, além de melhorar o suporte ao leitor de tela, braille, ampliador de tela e alto contraste. Atualmente, ela trabalha com acessibilidade no Google Chrome e ChromeOS. Ela é bacharel e mestre em ciência da computação pelo MIT, onde co-fundou uma hackathon de tecnologia assistiva e foi assistente de laboratório e palestrante convidada da classe de tecnologia assistida.
featured_quote: A acessibilidade na web é essencial para uma sociedade inclusiva e igualitária. À medida que mais de nossas vidas sociais e profissionais mudam para o mundo online, torna-se ainda mais importante para as pessoas com deficiência poderem participar de todas as interações online sem barreiras. Assim como os arquitetos de edifícios podem criar ou não recursos de acessibilidade, como rampas para cadeiras de rodas, os desenvolvedores da web podem ajudar ou atrapalhar com a tecnologia assistiva que usuários dependem.
featured_stat_1: 22%
featured_stat_label_1: Sites usando contraste de cor suficient
featured_stat_2: 50%
featured_stat_label_2: Sites sem atributos alt de imagem
featured_stat_3: 14%
featured_stat_label_3: Sites usando um link para pular
---

## Introdução

A acessibilidade na web é essencial para uma sociedade inclusiva e igualitária. À medida que mais de nossas vidas sociais e profissionais mudam para o mundo online, torna-se ainda mais importante para as pessoas com deficiência poderem participar de todas as interações online sem barreiras. Assim como os arquitetos de edifícios podem criar ou não recursos de acessibilidade, como rampas para cadeiras de rodas, os desenvolvedores da web podem ajudar ou atrapalhar na adoção de tecnologias assistivas de que os usuários dependem.

Ao pensar sobre usuários com deficiências, devemos lembrar que suas jornadas de usuário são frequentemente as mesmas, eles apenas usam ferramentas diferentes. Essas ferramentas populares incluem, mas não se limitam a: leitores de tela, ampliadores de tela, zoom do navegador ou do tamanho do texto e controles de voz.

Frequentemente, melhorar a acessibilidade do seu site traz benefícios para todos. Embora normalmente pensamos nas pessoas com deficiência como pessoas com deficiências permanentes, qualquer pessoa pode ter uma deficiência temporária ou situacional. Por exemplo, alguém pode ser cego de forma permanente, ter uma infecção ocular temporária ou, circunstancialmente, estar ao ar livre sob um sol forte. Tudo isso pode explicar por que alguém não consegue ver sua tela. Todos têm deficiências situacionais e, portanto, melhorar a acessibilidade de sua página web irá melhorar a experiência de todos os usuários em qualquer situação.

As <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/quickref/">Diretrizes de acessibilidade de conteúdo da Web</a> (Web Content Accessibility Guidelines - WCAG) aconselham sobre como tornar um site acessível. Essas diretrizes foram usadas como base para nossa análise. No entanto, em muitos casos, é difícil analisar programaticamente a acessibilidade de um site. Por exemplo, a plataforma da web fornece várias maneiras de obter resultados funcionais semelhantes, mas o código que os alimenta pode ser completamente diferente. Portanto, nossa análise é apenas uma aproximação da acessibilidade geral da web.

Dividimos nossos insights mais interessantes em quatro categorias: facilidade de leitura, mídia na web, facilidade de navegação na página e compatibilidade com tecnologias assistivas.

Nenhuma diferença significativa na acessibilidade foi encontrada entre desktop e dispositivos móveis durante o teste. Como resultado, todas as nossas métricas apresentadas são o resultado de nossa análise de desktop, a menos que indicado de outra forma.

## Facilidade de leitura

O objetivo principal de uma página web é fornecer conteúdo com o qual os usuários desejam se envolver. Esse conteúdo pode ser um vídeo ou uma variedade de imagens, mas muitas vezes é simplesmente o texto da página. É extremamente importante que nosso conteúdo textual seja legível para nossos leitores. Se os visitantes não conseguem ler uma página web, eles não conseguem interagir com ela, o que acaba fazendo com que eles saiam. Nesta seção, veremos três áreas em que os sites tiveram dificuldades.

### Contraste de cor

Existem muitos casos em que os visitantes do seu site podem não conseguir vê-lo perfeitamente. Os visitantes podem ser daltônicos e incapazes de distinguir entre a fonte e a cor de fundo ([1 em cada 12 homens e 1 em 200 mulheres](http://www.cvrl.org/people/stockman/pubs/1999%20Genetics%20chapter%20SSJN.pdf) de ascendência europeia). Talvez eles estejam simplesmente lendo enquanto o sol está alto e criando toneladas de brilho na tela - prejudicando significativamente a visão. Ou talvez eles simplesmente tenham envelhecido e seus olhos não consigam distinguir as cores tão bem como antes.

Para garantir que o seu site seja legível nessas condições, é fundamental que o texto tenha contraste de cor suficiente com o fundo. Também é importante considerar quais contrastes serão mostrados quando as cores forem convertidas para tons de cinza.

{{ figure_markup(
  image="example-of-good-and-bad-color-contrast-lookzook.svg",
  caption="Exemplo de como é o texto com contraste de cor insuficiente. Cortesia de LookZook",
  description="Quatro caixas coloridas de tons de marrom e cinza com texto branco sobreposto dentro, criando duas colunas. A coluna da esquerda diz Muito levemente colorido e tem a cor de fundo marrom escrita como <code>#FCA469</code>. A coluna da direita diz Recomendado e a cor de fundo marrom é escrita como <code>#BD5B0E</code>. A caixa superior em cada coluna tem um fundo marrom com texto branco <code>#FFFFFF</code> e a caixa inferior tem um fundo cinza com branco text <code>#FFFFFF</code>. Os equivalentes em tons de cinza são <code>#B8B8B8</code> e <code>#707070</code> respectivamente. Cortesia de LookZook",
  width=568,
  height=300
  )
}}

Apenas 22,04% dos sites deram contraste de cor suficiente a todo o texto. Ou em outras palavras: 4 em cada 5 sites têm texto que se mistura facilmente com o fundo, tornando-o ilegível.

<p class = "note"> Observe que não foi possível analisar nenhum texto dentro das imagens, portanto, nossa métrica relatada é um limite superior do número total de sites que passaram no teste de contraste de cor. </p>

### Ampliando (zoom) e dimensionando páginas

Usar um <a hreflang="en" href="https://accessibleweb.com/question-answer/minimum-font-size/">tamanho de fonte legível</a> e <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/quickref/#target-size">tamanho alvo</a> ajuda os usuários a ler e interagir com seu site. Mas mesmo os sites que seguem perfeitamente todas essas diretrizes não podem atender às necessidades específicas de cada visitante. É por isso que recursos do dispositivo, como a pinça para aplicar zoom e dimensionamento, são tão importantes: eles permitem que os usuários ajustem suas páginas para que suas necessidades sejam atendidas. Ou, no caso de sites particularmente inacessíveis que usam fontes e botões minúsculos, dá aos usuários a chance de usar o site.

Existem raros casos em que a desativação do escalonamento é aceitável, como quando a página em questão é um jogo baseado na web que usa controles de toque. Se deixado ativado neste caso, os telefones dos jogadores irão aumentar e diminuir o zoom cada vez que o jogador tocar duas vezes no jogo, ironicamente tornando-o inacessível.

Por causa disso, os desenvolvedores têm a capacidade de desativar esse recurso definindo uma das duas propriedades a seguir na [meta tag viewport](https://developer.mozilla.org/docs/Web/HTML/Viewport_meta_tag):

1. `user-scalable` definido como `0` ou `no`

2. `maximum-scale` definida como `1`, `1.0`, etc

Infelizmente, os desenvolvedores abusaram tanto disso que quase um em cada três sites no celular (32,21%) desabilita esse recurso e a Apple (a partir do iOS 10) não permite mais que os desenvolvedores da web desabilitem o zoom. O Safari para dispositivos móveis simplesmente <a hreflang="en" href="https://archive.org/details/ios-10-beta-release-notes">ignora a tag</a>. Todos os sites, não importa o quê, podem ser ampliados e dimensionados em dispositivos iOS mais recentes.

{{ figure_markup(
  image="fig2.png",
  caption="Porcentagem de sites que desativam o zoom e o dimensionamento em comparação ao tipo de dispositivo.",
  description="Dados de porcentagem de medição vertical, variando de 0 a 80 em incrementos de 20, vs. o tipo de dispositivo, agrupado em desktop e dispositivos móveis. Habilitado em desktop: 75,46%; Desabilitado em desktop 24,54%; Habilitado em dispositivos móveis: 67,79%; Desabilitado em dispositivos móveis: 32,21%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=2053904956&format=interactive"
  )
}}

### Identificação de idioma

A web está cheia de uma quantidade incrível de conteúdo. No entanto, há um porém: existem mais de 1.000 idiomas diferentes no mundo, e o conteúdo que você procura pode não estar escrito em um em que você seja fluente. Nos últimos anos, fizemos grandes avanços em tecnologias de tradução e você provavelmente usou um deles na web (por exemplo, Google Tradutor).

Para facilitar esse recurso, os motores de tradução precisam saber em que idioma suas páginas estão escritas. Isso é feito usando o [atributo `lang`](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/lang). Sem isso, os computadores devem adivinhar em que idioma sua página está escrita. Como você pode imaginar, isso leva a muitos erros, especialmente quando as páginas usam vários idiomas (por exemplo, a navegação da página é em inglês, mas o conteúdo da postagem está em japonês).

Esse problema é ainda mais encontrado em tecnologias assistivas de conversão de texto em fala, como leitores de tela, onde, se nenhum idioma tiver sido especificado, eles tendem a ler o texto no idioma padrão do usuário.

Das páginas analisadas, 26,13% não especificam um idioma com o atributo `lang`. Isso deixa mais de um quarto das páginas suscetíveis a todos os problemas descritos acima. As boas notícias? De sites que usam o atributo `lang`, eles especificam um código de idioma válido corretamente 99,68% das vezes.

### Conteúdo de distração

Alguns usuários, como aqueles com deficiências cognitivas, têm dificuldade em se concentrar na mesma tarefa por longos períodos de tempo. Esses usuários não querem lidar com páginas que incluem muitos movimentos e animações, especialmente quando esses efeitos são puramente cosméticos e não relacionados à tarefa em questão. No mínimo, esses usuários precisam encontrar uma maneira de desligar todas as animações que distraem.

Infelizmente, nossos resultados indicam que animações em loop infinito são bastante comuns na web, com 21,04% das páginas usando-as por meio de animações CSS infinitas ou [`<marquee>`](https://developer.mozilla.org/docs/Web/HTML/Element/marquee) e elementos [`<blink>`](https://developer.mozilla.org/docs/Web/HTML/Element/blink).

É interessante notar, entretanto, que a maior parte desse problema parece ser em algumas folhas de estilo populares de terceiros que incluem animações CSS em loop infinito por padrão. Não foi possível determinar quantas páginas realmente usaram esses estilos de animação.

## Mídia na web

### Texto alternativo nas imagens

As imagens são uma parte essencial da experiência na web. Eles podem contar histórias poderosas, chamar a atenção e provocar emoções. Mas nem todos podem ver essas imagens que utilizamos para contar partes de nossas histórias. Felizmente, em 1995, o HTML 2.0 forneceu uma solução para esse problema: <a hreflang="en" href="https://webaim.org/techniques/alttext/">o atributo alt</a>. O atributo alt fornece aos desenvolvedores da web a capacidade de adicionar uma descrição textual às imagens que usamos, de modo que, quando alguém não consegue ver nossas imagens (ou as imagens não carregam), eles podem ler o texto alternativo para uma descrição. O texto alternativo os preenche com a parte da história que, de outra forma, eles teriam perdido.

Embora os atributos alt existam há 25 anos, 49,91% das páginas ainda não fornecem atributos alt para algumas de suas imagens e 8,68% das páginas nunca os usam.

### Legendas para áudio e vídeo

Assim como as imagens contam histórias poderosas, o áudio e o vídeo também são para chamar a atenção e expressar ideias. Quando o conteúdo de áudio e vídeo não é legendado, os usuários que não conseguem ouvir esse conteúdo perdem grande do conteúdo na web. Uma das coisas mais comuns que ouvimos de usuários surdos ou com deficiência auditiva é a necessidade de incluir legendas em todo o conteúdo de áudio e vídeo.

De sites usando elementos [`<audio>`](https://developer.mozilla.org/docs/Web/HTML/Element/Audio) ou [`<video>`](https://developer.mozilla.org/docs/Web/HTML/Element/Video), apenas 0,54% fornecem legendas (conforme medido por aqueles que incluem o elemento [`<track>`](https://developer.mozilla.org/docs/Web/Guide/Audio_and_video_delivery/Adding_captions_and_subtitles_to_HTML5_video)). Observe que alguns sites têm soluções personalizadas para fornecer legendas de vídeo e áudio aos usuários. Não foi possível detectar essas soluções personalizadas e, portanto, a porcentagem real de sites que utilizam legendas é um pouco maior.

## Facilidade de navegação na página

Ao abrir o menu em um restaurante, a primeira coisa que você provavelmente fará é ler todos os cabeçalhos das seções: aperitivos, saladas, prato principal e sobremesa. Isso permite que você leia um menu para todas as opções e pule rapidamente para os pratos mais interessantes para você. Da mesma forma, quando um visitante abre uma página web, seu objetivo é encontrar as informações nas quais está mais interessado - o motivo pelo qual ele veio para a página em primeiro lugar. Para ajudar os usuários a encontrar o conteúdo desejado o mais rápido possível (e evitar que eles pressionem o botão Voltar), tentamos separar o conteúdo de nossas páginas em várias seções visualmente distintas, por exemplo: um cabeçalho do site para navegação, vários cabeçalhos em nossos artigos para que os usuários possam lê-los rapidamente, um rodapé para outros recursos externos e muito mais.

Embora isso seja excepcionalmente importante, precisamos ter o cuidado de marcar nossas páginas para que os computadores de nossos visitantes possam perceber essas seções distintas também. Por quê? Enquanto a maioria dos leitores usa um mouse para navegar nas páginas, muitos outros dependem de teclados e leitores de tela. Essas tecnologias dependem muito de quão bem seus computadores entendem sua página.

### Títulos

Os títulos não são úteis apenas visualmente, mas também para leitores de tela. Eles permitem que os leitores de tela saltem rapidamente de uma seção para outra e ajudam a indicar onde uma seção termina e a outra começa.

Para evitar confundir os usuários de leitores de tela, certifique-se de nunca pular um nível de título. Por exemplo, não vá direto de um H1 para um H3, pulando o H2. Por que esto é bom? Porque essa é uma mudança inesperada que fará com que o usuário leitor da tela pensar que perdeu uma parte do conteúdo. Isso pode fazer com que eles comecem a procurar o que podem ter perdido, mesmo que não haja nada faltando. Além disso, você ajudará todos os seus leitores ao manter um design mais consistente.

Com isso dito, aqui estão nossos resultados:

1. 89,36% das páginas usam cabeçalhos de alguma forma. Isso é impressionante.
2. 38,6% das páginas pulam níveis de título.
3. Estranhamente, os H2s são encontrados em mais sites do que os H1s.

{{ figure_markup(
  image="fig3.png",
  caption="Popularidade dos níveis de título.",
  description="Gráfico de barras verticais medindo dados percentuais, variando de 0 a 80 em incrementos de 20 vs barras que representam cada nível de título h1 a h6. H1: 63,25%; H2: 67,86%; H3: 58,63%; H4: 36,38% ; H5: 14,64%; H6: 6,91%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1123601243&format=interactive"
  )
}}

### A role main

A [role main](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Roles/Main_role) indica aos leitores de tela onde o conteúdo principal de uma página web começa para que os usuários possam ir direto. Sem isso, os usuários leitores de tela precisam pular manualmente sua navegação sempre que acessam uma nova página do site. Obviamente, isso é bastante frustrante.

Encontramos apenas uma em cada quatro páginas (26,03%) que inclui um marco principal. E, surpreendentemente, 8,06% das páginas continham erroneamente mais de um ponto de referência principal, deixando esses usuários adivinhando qual ponto de referência contém o conteúdo principal real.

{{ figure_markup(
  image="fig4.png",
  caption="Porcentagem de páginas pelo número de pontos de referência main.",
  description="Gráfico de barras verticais exibindo dados percentuais, variando de 0 a 80 em incrementos de 20 vs barras que representam o número de pontos de referência main por página de 0 a 4. Fonte: Arquivo HTTP (julho de 2019). Zero: 73,97 %; Um: 17,97%; Dois: 7,41%; Três: 0,15%; 4: 0,06%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1420590464&format=interactive"
  )
}}

### Elementos de seção HTML

Desde que o HTML5 foi lançado em 2008 e se tornou o padrão oficial em 2014, existem muitos elementos HTML para ajudar os computadores e leitores de tela a entender o layout e a estrutura de nossa página.

Elementos como [`<header>`](https://developer.mozilla.org/docs/Web/HTML/Element/header), [`<footer>`](https://developer.mozilla.org/docs/Web/HTML/Element/footer), [`<navigation>`](https://developer.mozilla.org/docs/Web/HTML/Element/nav), e [`<main>`](https://developer.mozilla.org/docs/Web/HTML/Element/main) indicam onde estão os tipos específicos de conteúdo e permitem que os usuários acessem rapidamente sua página. Eles estão sendo amplamente usados ​​na web, com a maioria deles sendo usados ​​em mais de 50% das páginas (`<main>` sendo o valor atípico).

Outros elementos como [`<article>`](https://developer.mozilla.org/docs/Web/HTML/Element/article), [`<hr>`](https://developer.mozilla.org/docs/Web/HTML/Element/hr), e [`<aside>`](https://developer.mozilla.org/docs/Web/HTML/Element/aside) ajudam os leitores a compreender o conteúdo principal de uma página. Por exemplo, `<article>` diz onde um artigo termina e outro começa. Esses elementos não são usados ​​tanto, com cada um sentado em cerca de 20% de uso. Nem todos eles pertencem a todas as páginas da web, então essa não é necessariamente uma estatística alarmante.

Todos esses elementos são projetados principalmente para suporte de acessibilidade e não têm efeito visual, o que significa que você pode substituir os elementos existentes por eles com segurança e não sofrer consequências indesejadas.

{{ figure_markup(
  image="fig5.png",
  caption="Uso de vários elementos semânticos HTML.",
  description="Gráfico de barras verticais com barras para cada tipo de elemento vs porcentagem de páginas que variam de 0 a 60 em incrementos de 20. nav: 53,94%; header: 54,82%; footer: 55,92%; main: 18,47%; aside: 16,99% ; article: 22,59%; hr: 19,1%; section: 36,55%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=708035719&format=interactive"
  )
}}

### Outros elementos HTML usados ​​para navegação

Muitos leitores de tela populares também permitem que os usuários naveguem pulando rapidamente por links, listas, itens de lista, iframes e campos de formulário, como campos de edição, botões e caixas de listagem. A Figura 9.6 detalha a frequência com que vimos as páginas usando esses elementos.

{{ figure_markup(
  image="fig6.png",
  caption="Outros elementos HTML usados ​​para navegação.",
  description="Gráfico de barras verticais com barras para cada tipo de elemento vs porcentagem de páginas que variam de 0 a 100 em incrementos de 25. a: 98.22%; ul: 88.62%; input: 76.63%; iframe: 60.39%; button: 56.74%; select: 19.68%; textarea: 12.03%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=389034849&format=interactive"
  )
}}

### Skip Links

Um <a hreflang="en" href="https://webaim.org/techniques/skipnav/">skip link</a> é um link colocado na parte superior de uma página que permite que leitores de tela ou usuários apenas com teclado acessem diretamente o conteúdo principal. Ele efetivamente "pula" todos os links de navegação e menus no topo da página. Os links para ignorar são especialmente úteis para usuários de teclado que não usam um leitor de tela, pois esses usuários geralmente não têm acesso a outros modos de navegação rápida (como pontos de referência e títulos). 14,19% das páginas em nossa amostra apresentaram skip links.

Se você gostaria de ver um skip link em ação, você pode! Basta fazer uma pesquisa rápida no Google e clicar em <kbd>tab</kbd> assim que acessar as páginas de resultados da pesquisa. Você será saudado com um link anteriormente oculto, exatamente como o da Figura 9.7.

{{ figure_markup(
  image="example-of-a-skip-link-on-google.com.png",
  caption="Qual é a aparência de um link para pular no google.com.",
  description="Captura de tela da página de resultados de pesquisa do Google para a pesquisa 'http archive'. O link visível 'Skip to main content' é cercado por um destaque azul e uma caixa amarela sobreposta com uma seta vermelha apontando para o skip link lê-se 'A skip link on google.com'.",
  width=600,
  height=333
  )
}}

Na verdade, você não precisa nem mesmo sair deste site, pois nós <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/645">os usamos aqui também</a>!

É difícil determinar com precisão o que é um skip link ao analisar sites. Para esta análise, se encontramos um link âncora (`href=#header1`) dentro dos primeiros 3 links na página, nós o definimos como uma página com um skip link. Portanto, 14,19% é um limite superior estrito.

### Atalhos

Teclas de atalho definidas por meio de <a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts">`aria-keyshortcuts`</a> ou [`accesskey`](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/accesskey) podem ser usados ​​de duas maneiras:

1. Ativando um elemento na página, como um link ou botão.

2. Dando um certo elemento ao foco da página. Por exemplo, mudar o foco para uma determinada entrada na página, permitindo que um usuário comece a digitar nela.

A adoção de <a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts">`aria-keyshortcuts`</a> esteve quase ausente em nossa amostra, sendo usada apenas em 159 sites de mais de 4 milhões analisados. O atributo [`accesskey`](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/accesskey) foi usado com mais frequência, sendo encontrado em 2,47% das páginas da web (1,74% no celular ) Acreditamos que o maior uso de atalhos no desktop deve-se aos desenvolvedores que esperam que os sites móveis sejam acessados ​​apenas por meio de uma tela de toque e não de um teclado.

O que é especialmente surpreendente aqui é que 15,56% dos sites para celular e 13,03% dos sites para desktop que usam teclas de atalho atribuem o mesmo atalho a vários elementos diferentes. Isso significa que os navegadores precisam adivinhar qual elemento deve possuir essa tecla de atalho.

### Tabelas

As tabelas são uma das principais maneiras de organizar e expressar grandes quantidades de dados. Muitas tecnologias assistivas, como leitores de tela e interruptores (que podem ser usados ​​por usuários com deficiências motoras), podem ter recursos especiais que lhes permitem navegar por esses dados tabulares com mais eficiência.

#### Títulos

Dependendo da maneira como uma tabela específica é estruturada, o uso de cabeçalhos de tabela torna mais fácil ler as colunas ou linhas sem perder o contexto sobre a quais dados aquela coluna ou linha específica se refere. Ter que navegar em uma tabela sem linhas ou colunas de cabeçalho é uma experiência inferior para um usuário de leitor de tela. Isso ocorre porque é difícil para um usuário de leitor de tela controlar sua posição em uma tabela sem cabeçalhos, especialmente quando a tabela é muito grande.

Para marcar cabeçalhos de tabela, basta usar a tag [`<th>`](https://developer.mozilla.org/docs/Web/HTML/Element/th) (em vez de [`<td>`](https://developer.mozilla.org/docs/Web/HTML/Element/td)), ou qualquer um das regras ARIA [`columnheader`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Roles/Table_Role) ou [`rowheader`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Roles/Table_Role). Apenas 24,5% das páginas com tabelas marcam suas tabelas com um desses métodos. Portanto, os três quartos das páginas que optam por incluir tabelas sem cabeçalhos estão criando sérios desafios para os usuários de leitores de tela.

Usar `<th>` e `<td>` era de longe o método mais comumente usado para marcar cabeçalhos de tabela. O uso dos papéis `columnheader` e `rowheader` era quase inexistente, com apenas 677 sites no total usando-os (0,058%).

#### Legendas

As legendas das tabelas por meio do elemento [`<caption>`](https://developer.mozilla.org/docs/Web/HTML/Element/caption) são úteis para fornecer mais contexto para leitores de todos os tipos. Uma legenda pode preparar o leitor para receber as informações que sua mesa está compartilhando e pode ser especialmente útil para pessoas que podem se distrair ou ser interrompidas facilmente. Eles também são úteis para pessoas que podem perder seu lugar em uma mesa grande, como um usuário de leitor de tela ou alguém com deficiência intelectual ou de aprendizado. Quanto mais fácil você permitir que os leitores entendam o que estão analisando, melhor.

Apesar disso, apenas 4,32% das páginas com tabelas apresentam legendas.

## Compatibilidade com tecnologias assistivas

### O uso de ARIA

Uma das especificações mais populares e amplamente utilizadas para acessibilidade na web é o padrão <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/aria/">Accessible Rich Internet Applications</a> (ARIA). Este padrão oferece uma grande variedade de atributos HTML adicionais para ajudar a transmitir o propósito por trás dos elementos visuais (ou seja, seu significado semântico) e de quais tipos de ações eles são capazes.

Usar o ARIA de maneira correta e apropriada pode ser desafiador. Por exemplo, das páginas que utilizam atributos ARIA, encontramos 12,31% com valores inválidos aos seus atributos. Isso é problemático porque qualquer erro no uso de um atributo ARIA não tem efeito visual na página. Alguns desses erros podem ser detectados com o uso de uma ferramenta de validação automatizada, mas geralmente exigem o uso prático de software de assistência real (como um leitor de tela). Esta seção examinará como o ARIA é usado na web e, especificamente, quais partes do padrão são mais predominantes.

{{ figure_markup(
  image="fig8.png",
  caption="Porcentagem do total de páginas vs atributo ARIA.",
  description="Gráfico de barras verticais exibindo dados de porcentagem, variando de 0 a 25 em incrementos de 5, vs. barras que representam cada atributo. `aria-hidden`: 23.46%, `aria-label`: 17.67%, `aria-expanded`: 8.68%, `aria-current`: 7.76%, `aria-labelledby`: 6.85%, `aria-controls`: 3.56%, `aria-haspopup`: 2.62%, `aria-invalid`: 2.68%, `aria-describedby`: 1.69%, `aria-live`: 1.04%, `aria-required`: 1%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=792161340&format=interactive"
  )
}}

#### O atributo `role`

O atributo "role" é o atributo mais importante em toda a especificação ARIA. É usado para informar ao navegador qual é o propósito de um determinado elemento HTML (ou seja, o significado semântico). Por exemplo, um elemento `<div>`, visualmente estilizado como um botão usando CSS, deve receber a função ARIA de `button`.

Atualmente, 46,91% das páginas usam pelo menos um atributo de função ARIA. Na Figura 9.9 abaixo, compilamos uma lista dos dez valores de função ARIA mais amplamente usados.

{{ figure_markup(
  image="fig9.png",
  caption="Top 10 papéis ária.",
  description="Gráfico de barras verticais com barras para cada tipo de função vs porcentagem de sites usando variando de 0 a 25 em incrementos de 5. Navigation: 20.4%; search: 15.49%; main: 14.39%; banner: 13.62%; contentinfo: 11.23%; button: 10.59%; dialog: 7.87%; complementary: 6.06%; menu: 4.71%; form: 3.75%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=176877741&format=interactive"
  )
}}

Observando os resultados na Figura 9.9, encontramos dois insights interessantes: a atualização de estruturas de IU pode ter um impacto profundo na acessibilidade na web e o número impressionante de sites que tentam tornar os diálogos acessíveis.

##### Atualizar estruturas de IU pode ser o caminho a seguir para acessibilidade na web

Os 5 principais papéis, todos aparecendo em 11% das páginas ou mais, são papéis de referência. Eles são usados ​​para auxiliar a navegação, não para descrever a funcionalidade de um widget, como uma caixa de combinação. Este é um resultado surpreendente porque o principal motivador por trás do desenvolvimento do ARIA foi dar aos desenvolvedores web a capacidade de descrever a funcionalidade de widgets feitos de elementos HTML genéricos (como um `<div>`).

Suspeitamos que algumas das estruturas de IU da web mais populares incluem funções de navegação em seus modelos. Isso explicaria a prevalência de atributos de referência. Se essa teoria estiver correta, a atualização de estruturas de interface do usuário populares para incluir mais suporte de acessibilidade pode ter um grande impacto na acessibilidade da web.

Outro resultado que aponta para esta conclusão é o fato de que atributos ARIA mais "avançados", mas igualmente importantes, não parecem ser usados. Esses atributos não podem ser facilmente implantados por meio de uma estrutura de interface do usuário porque podem precisar ser personalizados com base na estrutura e na aparência visual de cada site individualmente. Por exemplo, descobrimos que os atributos `posinset` e `setsize` foram usados ​​apenas em 0,01% das páginas. Esses atributos informam a um usuário de leitor de tela quantos itens estão em uma lista ou menu e qual item está selecionado no momento. Portanto, se um usuário com deficiência visual estiver tentando navegar por um menu, poderá ouvir anúncios de índice como: "Página inicial, 1 de 5", "Produtos, 2 de 5", "Downloads, 3 de 5" etc.

##### Muitos sites tentam tornar os diálogos acessíveis

A popularidade relativa da [regra de caixa de diálogo](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/Roles/dialog_role) se destaca porque tornar as caixas de diálogo acessíveis para usuários de leitores de tela é muito desafiador. Portanto, é animador ver cerca de 8% das páginas analisadas se preparando para o desafio. Novamente, suspeitamos que isso pode ser devido ao uso de algumas estruturas de IU.

#### Rótulos em elementos interativos

A maneira mais comum de um usuário interagir com um site é por meio de seus controles, como links ou botões para navegar no site. No entanto, muitas vezes os usuários de leitores de tela não conseguem dizer qual ação um controle executará depois de ativado. Frequentemente, o motivo dessa confusão é a falta de um rótulo textual. Por exemplo, um botão exibindo um ícone de seta apontando para a esquerda para indicar que é o botão "Voltar", mas não contém nenhum texto real.

Apenas cerca de um quarto (24,39%) das páginas que usam botões ou links incluem rótulos textuais com esses controles. Se um controle não estiver rotulado, um usuário de leitor de tela pode ler algo genérico, como a palavra "botão" em vez de uma palavra significativa como "Pesquisar".

Botões e links quase sempre são incluídos na ordem das guias e, portanto, têm visibilidade extremamente alta. Navegar em um site usando a tecla tab é uma das principais maneiras pelas quais os usuários que usam apenas o teclado exploram seu site. Assim, o usuário tem certeza de encontrar seus botões e links sem rótulos se eles estiverem se movendo pelo seu site usando a tecla tab.

### Acessibilidade de controles de formulário

Preencher formulários é uma tarefa que muitos de nós fazemos todos os dias. Quer estejamos fazendo compras, agendando viagens ou nos candidatando a um emprego, os formulários são a principal forma de os usuários compartilharem informações com páginas da web. Por isso, é extremamente importante garantir que seus formulários estejam acessíveis. O meio mais simples de fazer isso é fornecer rótulos (por meio dos elementos [`<label>`](https://developer.mozilla.org/docs/Web/HTML/Element/label), [`aria-label`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-label_attribute) ou [`aria-labelledby`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Usando_o_atributo_aria-labelledby)) para cada uma de suas entradas. Infelizmente, apenas 22,33% das páginas fornecem rótulos para todas as entradas de formulário, o que significa que 4 em cada 5 páginas têm formulários que podem ser muito difíceis de preencher.

#### Indicadores de campos obrigatórios e inválidos

Quando encontramos um campo com um grande asterisco vermelho próximo a ele, sabemos que é um campo obrigatório. Ou quando clicamos em enviar e somos informados de que há entradas inválidas, qualquer coisa destacada em uma cor diferente precisa ser corrigida e então reenviada. No entanto, pessoas com pouca ou nenhuma visão não podem confiar nessas dicas visuais, e é por isso que os atributos de entrada HTML `required`, `aria-required` e `aria-invalid` são tão importantes. Eles fornecem leitores de tela com o equivalente a asteriscos vermelhos e campos realçados em vermelho. Como um bom bônus, quando você informar aos navegadores quais campos são obrigatórios, eles irão [validar partes de seus formulários](https://developer.mozilla.org/docs/Web/Guide/HTML/Forms/Form_validation) para vocês. Não requer JavaScript.

Das páginas que usam formulários, 21,73% usam `required` ou `aria-required` ao marcar os campos obrigatórios. Apenas um em cada cinco sites faz uso disso. Esta é uma etapa simples para tornar seu site acessível e desbloquear recursos úteis do navegador para todos os usuários.

Também descobrimos que 3,52% dos sites com formulários usam `aria-invalid`. No entanto, como muitos formulários só usam esse campo depois que informações incorretas são enviadas, não foi possível determinar a verdadeira porcentagem de sites que usam essa marcação.

#### IDs duplicados

Os IDs podem ser usados ​​em HTML para vincular dois elementos. Por exemplo, o elemento [`<label>`](https://developer.mozilla.org/docs/Web/HTML/Element/label) funciona dessa maneira. Você especifica o ID do campo de entrada que este rótulo está descrevendo e o navegador os vincula. O resultado? Os usuários agora podem clicar neste rótulo para focar no campo de entrada, e os leitores de tela usarão esse rótulo como a descrição.

Infelizmente, 34,62% ​​dos sites têm IDs duplicados, o que significa que em muitos sites a ID especificada pelo usuário pode se referir a várias entradas diferentes. Portanto, quando um usuário clica no rótulo para selecionar um campo, ele pode acabar <a hreflang="en" href="https://www.deque.com/blog/unique-id-attributes-matter/">selecionando algo diferente</a> do que pretendia. Como você pode imaginar, isso pode ter consequências negativas em algo como um carrinho de compras.

Esse problema é ainda mais encontrado para leitores de tela porque seus usuários podem não conseguir verificar visualmente o que está selecionado. Além disso, muitos atributos ARIA, como [`aria-describedby`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-describedby_attribute) e [`aria-labelledby`](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Usando_o_atributo_aria-labelledby), funciona de forma semelhante ao elemento de rótulo detalhado acima. Portanto, para tornar seu site acessível, remover todos os IDs duplicados é um bom primeiro passo.

## Conclusão

Pessoas com deficiência não são as únicas com necessidades de acessibilidade. Por exemplo, qualquer pessoa que sofreu uma lesão temporária no pulso teve dificuldade em tocar em pequenos pontos de toque. A visão geralmente diminui com a idade, tornando o texto escrito em fontes pequenas difícil de ler. A destreza dos dedos não é a mesma em todos os grupos etários, tornando mais difícil tocar nos controles interativos ou passar pelo conteúdo de sites móveis para uma porcentagem considerável de usuários.

Da mesma forma, o software assistivo não é voltado apenas para pessoas com deficiência, mas para melhorar a experiência do dia a dia de todos:
- A recente popularidade da assistência por voz, tanto em dispositivos móveis quanto em casa, demonstrou que controlar um dispositivo de computação usando comandos de voz é desejável e essencial para muitos usuários. Comandos de voz como esses costumavam ser apenas um recurso de acessibilidade, mas agora estão se transformando em um produto comum.
- Os motoristas se beneficiariam de um recurso de leitura de tela que, enquanto mantêm os olhos na estrada, lê longos trechos de texto como notícias em voz alta.
- As legendas são apreciadas não apenas por pessoas que não podem ouvir um vídeo, mas também por pessoas que desejam assistir a um vídeo em um restaurante barulhento ou em uma biblioteca.

Depois que um site é construído, geralmente é difícil adaptar a acessibilidade às estruturas e widgets existentes do site. Acessibilidade não é algo que pode ser facilmente espalhado depois, mas precisa fazer parte do processo de design e implementação. Infelizmente, seja por falta de conhecimento ou por ferramentas de teste fáceis de usar, muitos desenvolvedores não estão familiarizados com as necessidades de todos os seus usuários e os requisitos do software auxiliar que usam.

Embora não sejam conclusivos, nossos resultados indicam que o uso de padrões de acessibilidade como ARIA e as práticas recomendadas de acessibilidade (por exemplo, usando texto alternativo) são encontrados em uma parte (considerável, mas não substancial) da web. Superficialmente, isso é encorajador, mas suspeitamos que muitas dessas tendências positivas se devem à popularidade de certos frameworks de IU. Por um lado, isso é decepcionante porque os desenvolvedores da Web não podem simplesmente confiar em estruturas de IU para injetar em seus sites suporte de acessibilidade. Por outro lado, é encorajador ver o grande efeito que os frameworks de IU podem ter na acessibilidade da web.

A próxima fronteira, em nossa opinião, é tornar os widgets disponíveis por meio de estruturas de interface do usuário mais acessíveis. Uma vez que muitos widgets complexos usados ​​livremente (por exemplo, seletores de calendário) são originados de uma biblioteca de IU, seria ótimo que esses widgets estivessem acessíveis imediatamente. Esperamos que, quando coletarmos nossos resultados da próxima vez, o uso de funções complexas ARIA implementadas de forma mais adequada esteja aumentando - significando que widgets mais complexos também se tornaram acessíveis. Além disso, esperamos ver mídias mais acessíveis, como imagens e vídeos, para que todos os usuários possam desfrutar da riqueza da web.
