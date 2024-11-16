---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: WebAssembly
description: Capítulo sobre WebAssembly do Web Almanac de 2022, abordando o uso, linguagens e recursos pós-MVP.
hero_alt: Hero image of Web Almanac chracters performing scientific experiments on various code symbols resulting in 1's and 0's coming out the other end.
authors: [ColinEberhardt]
reviewers: [binji, RReverser]
analysts: [JamieWhitMac]
editors: [tunetheweb]
translators: [HakaCode]
ColinEberhardt_bio: Colin é CTO na empresa <a hreflang="en" href="https://www.scottlogic.com/">Scott Logic</a> e é um prolífico autor técnico, blogueiro e palestrante em diversas tecnologias. Ele é membro do conselho da <a hreflang="en" href="https://www.finos.org/">FINOS</a>, que promove a colaboração de código aberto no setor financeiro. Além disso, ele é muito ativo no GitHub, contribuindo para diversos projetos diferentes.
results: https://docs.google.com/spreadsheets/d/11jyABro0fKtuN6INnYP9pJlv5QWwp0jfJyTsGfKgScg/
featured_quote: Apesar de ser uma tecnologia de nicho, o WebAssembly já está agregando valor à web. Existem várias aplicações web que se beneficiam significativamente dessa tecnologia.
featured_stat_1: 383
featured_stat_label_1: Unique WebAssembly binaries discovered
featured_stat_2: 34.9%
featured_stat_label_2: Mobile sites using Amazon IVS
featured_stat_3: 72.8%
featured_stat_label_3: Modules using Emscripten
---

## Introdução

WebAssembly, ou Wasm, é um recém-chegado à família de tecnologias web (JavaScript, HTML, CSS), tornando-se um padrão oficialmente reconhecido pelo W3C em dezembro de 2019.

O WebAssembly introduz uma nova máquina virtual no navegador, que trabalha ao lado e em estreita colaboração com a máquina virtual JavaScript. É relativamente leve em comparação, com um conjunto de instruções pequeno e um modelo de isolamento rigoroso (o WebAssembly não possui I/O por padrão). Um dos principais motivadores para o desenvolvimento do WebAssembly foi fornecer um destino de compilação para uma ampla variedade de linguagens de programação (C++, Rust, Go etc.), permitindo que os desenvolvedores escrevam novas aplicações web ou portem aplicações existentes com um conjunto mais amplo de ferramentas.

Exemplos de destaque do uso do WebAssembly incluem sua <a hreflang="en" href="https://blog.chromium.org/2019/06/webassembly-brings-google-earth-to-more.html">use within Google Earth</a>, onde a aplicação desktop em C++ agora está disponível no navegador, <a hreflang="en" href="https://www.figma.com/blog/webassembly-cut-figmas-load-time-by-3x/">Figma</a>, uma ferramenta de design baseada em navegador que obteve melhorias significativas de desempenho com o uso dessa tecnologia, e mais recentemente o <a hreflang="en" href="https://web.dev/ps-on-the-web/">Photoshop</a> que utiliza o WebAssembly por motivos semelhantes.

## Metodologia

O WebAssembly é um alvo de compilação, distribuído como módulos binários. Por esse motivo, enfrentamos vários desafios ao analisar o seu uso na web. O Web Almanac de 2021, que é a primeira edição que incluiu o WebAssembly, possui uma [seção detalhada sobre a metodologia utilizada](../2021/webassembly#methodology), e as respectivas ressalvas. As descobertas aqui, nesta edição de 2022, seguiram a mesma metodologia. A única melhoria adicionada é um mecanismo para determinar o idioma usado para criar os módulos do WebAssembly. A precisão dessa análise é abordada com mais detalhes na seção correspondente.

## Quão amplamente o WebAssembly está sendo utilizado?

Encontramos 3.204 solicitações confirmadas de WebAssembly em desktop e 2.777 em dispositivos móveis. Esses módulos são utilizados em 2.524 domínios em desktop e 2.216 domínios em dispositivos móveis, o que representa 0,06% e 0,04% de todos os domínios em desktop e dispositivos móveis, respectivamente.

Isso representa uma modesta redução no número de módulos que descobrimos no rastreamento, uma redução de 16% nas solicitações em desktop e 12% em dispositivos móveis. Isso não significa necessariamente que o WebAssembly esteja em declínio. Ao interpretar essa mudança, vale a pena observar o seguinte:

- Embora você possa usar o WebAssembly para criar todo tipo de conteúdo baseado na web, seu principal benefício é encontrado em aplicativos de negócios mais complexos, com grandes bases de código, que muitas vezes têm vários anos de existência (por exemplo, Google Earth, Photoshop, AutoCAD). Esses "apps" web não são tão numerosos quanto os sites e nem sempre estão disponíveis para o rastreamento do Almanac, que é baseado principalmente nas páginas iniciais, onde o WebAssembly pode ser menos comum.
- Como veremos em uma seção posterior, grande parte do uso do WebAssembly que encontramos vem de um número relativamente pequeno de bibliotecas de terceiros. Como resultado, uma pequena alteração em qualquer uma dessas bibliotecas terá um impacto significativo no número de módulos que encontramos.

Encontramos um número ligeiramente menor (-13%) de módulos WebAssembly servidos para navegadores móveis. Isso não reflete as capacidades do WebAssembly nos navegadores móveis, que geralmente têm suporte excelente. Em vez disso, provavelmente se deve à prática padrão de [progressive enhancement](https://developer.mozilla.org/docs/Glossary/Progressive_Enhancement), onde, nesses casos, os recursos mais avançados que requerem o WebAssembly não são suportados para usuários móveis.

{{ figure_markup(
  caption="Número de respostas Wasm.",
  description="Gráfico de barras mostrando o número total de respostas Wasm nos conjuntos de dados de desktop e mobile, bem como o número de arquivos únicos. O número de arquivos únicos é muito menor - apenas 383 de um total de 3.204 respostas no desktop e 310 de um total de 2.777 no mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1842699031&format=interactive",
  sheets_gid="2142789475",
  sql_file="counts.sql",
  image="counts.png"
  )
}}

Ao aplicarmos uma função de hash nos módulos WebAssembly, podemos determinar quantos desses 3.204 módulos - no desktop - são únicos. Ao remover a duplicação de módulos, o número total reduz aproximadamente em um fator de 10, com 383 módulos únicos servidos para navegadores de desktop e 310 para mobile. Isso indica uma quantidade significativa de reutilização - diferentes sites usando o mesmo código WebAssembly, provavelmente através de módulos compartilhados.

Uma proporção significativa de solicitações wasm são feitas a partir de domínios externos, reforçando ainda mais a ideia de que eles são reutilizados. É importante notar que isso aumentou significativamente em relação ao ano passado (67,2% em comparação com 55,2%).

{{ figure_markup(
  caption="Uso de WebAssembly em domínios externos (Cross-origin).",
  description="Gráfico de barras mostrando que 67,2% do uso de WebAssembly em desktop e 60,9% em dispositivos móveis são de origem externa (cross-origin).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=2039142493&format=interactive",
  sheets_gid="491240617",
  sql_file="cross_domain.sql",
  image="cross_domain.png"
  )
}}

Esses módulos de WebAssembly diferem consideravelmente em tamanho, sendo os menores com apenas alguns kilobytes, enquanto os maiores têm 7,3 megabytes. Ao examinarmos em mais detalhes o tamanho não comprimido, observamos que a mediana (50º percentil) é de 835 kilobytes.

Os módulos menores de WebAssembly provavelmente estão sendo usados para funcionalidades bem específicas, como preenchimento de recursos do navegador ou tarefas simples de criptografia. Os módulos maiores provavelmente são aplicativos inteiros compilados para WebAssembly.

{{ figure_markup(
  caption="Tamanhos das respostas não comprimidas.",
  description="Gráfico de barras mostrando a distribuição dos tamanhos das respostas não comprimidas em desktop e mobile nos percentis 25, 50, 75 e 90. Notavelmente, nos 10 percentis temos 23 KB, mediana em cerca de 835 KB e 90 percentis em 4,87 MB em desktop, e 3,24 MB em mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=736723663&format=interactive",
  sheets_gid="1169986524",
  sql_file="module_sizes.sql",
  image="uncompressed_resp_sizes.png"
  )
}}

Claramente, o WebAssembly não é amplamente utilizado, e em vez de ver um crescimento no uso, estamos observando uma contração modesta.

## Para que o WebAssembly está sendo usado?

{{ figure_markup(
  caption="Bibliotecas populares de WebAssembly.",
  description="Gráfico de barras mostrando as 10 principais bibliotecas nos conjuntos de dados de desktop e mobile, mesclados em um único gráfico. Cada biblioteca é exibida juntamente com a porcentagem de solicitações de Wasm que podem ser atribuídas a ela. A lista é a seguinte: Amazon IVS (33,5% em desktop e 34,9% em mobile), Hyphenopoly (8,2% e 12,1%), Blazor (6,2% e 8,5%), ArcGIS (6,7% e 6,0%), CanvasKit (7,7% e 2,7%), Tableau (5,2% e 3,0%), Draco (3,2% e 3,1%), Xat (1,6% e 1,5%) e Hewlett Packard Enterprise (HPE) (1,6% e 0,8%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1535512737&format=interactive",
  sheets_gid="721946887",
  sql_file="popular_by_name.sql",
  image="popular_by_name.png"
  )
}}

- <a hreflang="en" href="https://aws.amazon.com/ivs/">Amazon IVS (Amazon Interactive Video Service)</a> - Aqui, o WebAssembly provavelmente é usado como um codec de vídeo, permitindo a decodificação consistente de vídeo independente do suporte ao codec do navegador do usuário.
- <a hreflang="en" href="https://mnater.github.io/Hyphenopoly/">Hyphenopoly</a> - Este é um módulo npm que fornece um polyfill para hifenização CSS. O algoritmo principal é enviado como um módulo WebAssembly, proporcionando uma pequena pegada e desempenho consistente.
- <a hreflang="en" href="https://dotnet.microsoft.com/en-us/apps/aspnet/web-apps/blazor">Blazor</a> - O Microsoft Blazor é uma plataforma - runtime e biblioteca de interface do usuário - que suporta o desenvolvimento de aplicações web usando a plataforma .NET e C#.
- <a hreflang="en" href="https://developers.arcgis.com/javascript/latest/">ArcGIS</a> - Uma suíte abrangente de ferramentas para construir aplicações de mapeamento interativas. O desempenho é uma preocupação principal para a equipe do ArcGIS, e eles utilizam várias tecnologias como WebGL para alcançar isso. Especificamente, o WebAssembly é usado para permitir projeções rápidas do lado do cliente.
- <a hreflang="en" href="https://skia.org/docs/user/modules/canvaskit/">CanvasKit</a> - Essa biblioteca oferece capacidades mais avançadas do que a API padrão Canvas2D. É implementada por meio do Skia, uma biblioteca gráfica escrita em C++, que é compilada para WebAssembly permitindo a execução no navegador.
- <a hreflang="en" href="https://www.tableau.com/">Tableau</a> - Uma ferramenta popular para criar visualizações interativas. Não está claro se o WebAssembly é usado como parte do produto principal deles ou se está sendo usado apenas para os painéis específicos que foram encontrados durante o rastreamento.
- <a hreflang="en" href="https://google.github.io/draco/">Draco</a> - Uma biblioteca para compressão e descompressão de malhas geométricas 3D e nuvens de pontos. É escrita em C++ e o uso do WebAssembly permite sua utilização no navegador.
- <a hreflang="en" href="https://xat.com/">Xat</a> - Uma rede social. Não está claro para que eles estão usando o WebAssembly.
- <a hreflang="en" href="https://www.hpe.com/us/en/home.html">Hewlett Packard Enterprise</a> - Não está claro para que eles estão usando o WebAssembly.

Ao observarmos as bibliotecas populares do WebAssembly, podemos ver que seu uso é bastante específico, muitas vezes sendo utilizado para tarefas específicas de cálculos numéricos ou aproveitando grandes e maduros conjuntos de código em C++, trazendo suas capacidades para a web sem a necessidade de portar para JavaScript.

## Que linguagens as pessoas estão usando?

O WebAssembly é um formato binário e, como resultado, muitas informações do código-fonte - como a linguagem de programação, a estrutura do aplicativo e os nomes das variáveis - são obfuscadas ou completamente perdidas durante o processo de compilação.

No entanto, os módulos geralmente têm exportações e importações que nomeiam funções dentro do ambiente de hospedagem - a execução de JavaScript dentro do navegador - que descrevem a interface do módulo. A maioria das cadeias de ferramentas do WebAssembly cria uma pequena quantidade de código JavaScript, com o propósito de 'vinculação', tornando mais fácil integrar módulos em aplicativos JavaScript. Essas vinculações muitas vezes possuem nomes de função reconhecíveis que estão presentes nas exportações ou importações dos módulos, proporcionando um mecanismo confiável para identificar a linguagem usada para criar o módulo.

Aprimoramos o projeto <a hreflang="en" href="https://github.com/HTTPArchive/wasm-stats">wasm-stats</a>, que fornece análises específicas para WebAssembly ao rastreador, adicionando código que inspeciona exportações / importações para identificar padrões comuns que indicam a linguagem usada para criar um determinado módulo. Como exemplo, se um módulo importa um módulo com o nome `wbindgen` , isso é uma referência a código gerado pelo <a hreflang="en" href="https://crates.io/crates/wasm-bindgen">wasm-bindgen</a>  e um claro indicativo de que o módulo foi escrito em Rust.

Em alguns casos, os nomes de exportação/importação são minificados, tornando mais difícil identificar a linguagem de origem. No entanto, o Emscripten (uma cadeia de ferramentas de C++) possui uma convenção distintiva para nomes minificados, o que significa que podemos ter uma confiança relativa de que os módulos que exibem esse padrão foram gerados usando o Emscripten.

{{ figure_markup(
  caption="Uso de linguagens no WebAssembly.",
  description="Provável Emscripten (63,8% no desktop e 61,1% no mobile), Desconhecido (11,7% e 16,9%), Emscripten (13,3% e 11,8%), Rust (8,0% e 6,0%), Blazor (2,7% e 3,5%) e Go (0,6% e 0,7%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1942715596&format=interactive",
  sheets_gid="915015663",
  sql_file="language_usage.sql",
  image="language_usage.png"
  )
}}

Analisando os resultados, descobrimos que, no desktop, 72,8% dos módulos foram muito provavelmente criados usando o Emscripten e, como resultado, são muito provavelmente escritos em C++. Em seguida, a linguagem mais popular é o Rust, com 6,0%, seguida por Blazor (C#) com 3,5%. Também encontramos um pequeno número de módulos escritos em Go.

Notavelmente, 16,9% dos módulos não possuíam uma linguagem identificável. <a hreflang="en" href="https://www.assemblyscript.org/">AssemblyScript</a>  é uma linguagem popular específica para WebAssembly que não fornece pistas óbvias nos módulos que produz. Sabemos que Hypehnopoly, que representa 8,2% de todos os módulos, usa AssemblyScript, e isso representa quase metade desses módulos "não identificados".

É interessante contrastar esses resultados com a <a hreflang="en" href="https://blog.scottlogic.com/2022/06/20/state-of-wasm-2022.html">State of WebAssembly 2022 survey</a>, onde Rust foi a linguagem mais utilizada com maior frequência. No entanto, um número significativo de respondentes dessa pesquisa estava usando o WebAssembly para aplicações fora do navegador.

## Quais recursos estão sendo utilizados?

O lançamento inicial do WebAssembly foi considerado um MVP (Produto Viável Mínimo). De acordo com outros padrões da web, ele está em constante evolução sob a governança do World Wide Web Consortium (W3C). Este ano marcou o anúncio do rascunho do <a hreflang="en" href="https://www.w3.org/TR/wasm-core-2/">WebAssembly v2 draft</a>, adicionando vários novos recursos.

{{ figure_markup(
  caption="Uso de extensões pós-MVP.",
  description="Gráfico de barras mostrando o total de módulos, juntamente com o número de módulos que utilizam diversas extensões pós-MVP. Os números totais, como mencionado no início do artigo, são de 3.204 e 2.777 em desktop e mobile, respectivamente. As operações de extensão de sinal (sign extension ops) se destacam e foram encontradas em um grande número desses módulos - 2.850 em desktop e 2.378 em mobile. As demais extensões têm números tão baixos que mal aparecem no gráfico. Cada uma das propostas de atomics, BigInt imports/exports, bulk memory, SIMD e mutable imports/exports foi encontrada em apenas até 38 módulos em desktop e até 28 módulos em mobile. Propostas como multi-value, non-trapping float-to-int conversions, reference types e tail calls não foram encontradas em nenhum módulo em ambos os conjuntos de dados.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZqlPK0L45J7IoVgmLcuRut9-M2nhaDMhs8cHtCLZacS7pkIqvEhHfdcYNSoEotQp0-Rs_RRslZ8sT/pubchart?oid=1935172150&format=interactive",
  sheets_gid="1865524955",
  sql_file="proposals.sql",
  image="proposals.png"
  )
}}

Analisamos as funcionalidades pós-MVP que estão sendo utilizadas e encontramos que a _extensão de sinal_ (um aprimoramento relativamente simples que adiciona operadores que permitem estender os valores inteiros para uma maior profundidade de bits) foi de longe a mais utilizada. Isso não representa uma [diferença significativa em relação ao resultado encontrado na análise do ano passado.](../2021/webassembly#whats-the-usage-of-post-mvp-extensions).

Vale ressaltar que, enquanto os desenvolvedores web se deparam com a escolha de quais recursos de HTML / JavaScript / CSS utilizar, com o WebAssembly essa decisão muitas vezes é tomada pelos desenvolvedores da cadeia de ferramentas. Como resultado, é provável que veremos um aumento na adoção de recursos pós-MVP quando uma determinada cadeia de ferramentas determinar que eles são agora uma opção viável.

## Conclusões

WebAssembly é indiscutivelmente uma tecnologia de nicho quando se trata da web, e há uma grande chance de que sempre seja assim. Embora o WebAssembly tenha trazido uma ampla variedade de linguagens para a web - C++, Rust, Go, AssemblyScript, C# e outras - ainda não é possível usá-las de forma intercambiável com o JavaScript. Para a grande maioria dos sites, onde o conteúdo é relativamente estático (renderizado em HTML com CSS) e com uma quantidade modesta de interatividade (por meio do JavaScript), simplesmente não há uma razão convincente para usar o WebAssembly no momento.

Existem algumas propostas significativas que podem mudar isso no futuro. Inicialmente, o WebIDL, que foi substituído por Interface Types, que por sua vez foi substituído pela especificação Component Model. Essas mudanças podem resultar em um futuro onde será possível trocar facilmente o JavaScript por qualquer outra linguagem de programação, mas por enquanto, isso simplesmente não é o caso.

Apesar de ser uma tecnologia de nicho, o WebAssembly já está agregando valor à web. Existem várias aplicações web que se beneficiam muito dessa tecnologia. No entanto, as aplicações web muitas vezes não são visíveis para a 'busca' que serve de base para este estudo.

Por fim, as características principais do tempo de execução do WebAssembly - multi-linguagem, leve e seguro - estão tornando-o uma escolha popular para uma ampla gama de aplicações não relacionadas ao navegador.  A pesquisa <a hreflang="en" href="https://blog.scottlogic.com/2022/06/20/state-of-wasm-2022.html">State of WebAssembly 2022 survey</a> sviu um aumento significativo no número de pessoas usando essa tecnologia para aplicações serverless, containerização e plug-ins. O futuro do WebAssembly pode ser como uma tecnologia web de nicho, mas também como um tempo de execução totalmente mainstream em uma ampla variedade de outras plataformas.
