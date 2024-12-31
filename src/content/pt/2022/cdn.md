---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CDN
description: Capítulo sobre CDN do Web Almanac de 2022 cobrindo a adoção de CDNs, principais fornecedores de CDN, o impacto das CDNs no TLS, adoção de HTTP/2+, Brotli e Client Hints.
hero_alt: Hero image of Web Almanac characters extending a plug from a cloud into a web page.
authors: [harendra, joeviggiano]
reviewers: [ytkoka]
analysts: [harendra, joeviggiano]
editors: [tunetheweb]
translators: [HakaCode]
results: https://docs.google.com/spreadsheets/d/1ySETT2IZ9ae5_VUphxUol2ZU3P1RJvcSVjDU5BgnK5A/
harendra_bio: Haren Bhandari é Arquiteto de Soluções na Amazon Web Services. Antes de ingressar na Amazon Web Services, Haren trabalhava na Akamai Technologies e possui uma vasta experiência com CDNs.
joeviggiano_bio: Joe Viggiano é Arquiteto de Soluções de Mídia e Entretenimento na Amazon Web Services, ajudando clientes a entregar conteúdo de mídia em grande escala.
featured_quote: A CDN tem sido uma parte vital de muitos sites para proporcionar uma experiência de usuário suave. Após a COVID-19, a necessidade de CDNs só aumentou devido à migração de muitos negócios físicos para o ambiente online, ao aumento das videoconferências, dos jogos online e do streaming de vídeo.
featured_stat_1: 62%
featured_stat_label_1: Sites entre os 1.000 principais que utilizam uma CDN.
featured_stat_2: 3x
featured_stat_label_2: Negociação TLS mais rápida com CDN no p90.
featured_stat_3: 47%
featured_stat_label_3: Domínios utilizando Brotli via CDNs.
---

## Introdução

Este capítulo fornece insights sobre o estado atual do uso de CDNs. As CDNs estão desempenhando um papel cada vez mais importante na entrega de conteúdo aos usuários ao redor do mundo — até mesmo para sites menores, facilitando a entrega de conteúdo estático e de terceiros, como bibliotecas JavaScript, fontes e outros conteúdos. Outro aspecto crucial das CDNs que discutiremos neste capítulo é o papel que elas desempenham na adoção de novos padrões, como TLS e versões de HTTP.

Acreditamos que as CDNs continuarão a desempenhar um papel vital no futuro, não apenas para a entrega de conteúdo, mas também para a segurança do conteúdo. Recomendamos que os usuários considerem as CDNs tanto do ponto de vista de desempenho quanto de segurança.

## O que é uma CDN?

Uma Content Delivery Network (CDN) é uma rede de servidores proxy distribuídos geograficamente. O objetivo de uma CDN é fornecer alta disponibilidade e desempenho para o conteúdo web. Ela faz isso distribuindo o conteúdo mais próximo dos usuários finais, além de suportar tecnologias avançadas para entregar o conteúdo de maneira ideal.

Devido à explosão de conteúdo web, como vídeos e imagens, as CDNs têm sido uma parte vital de muitos sites para proporcionar uma experiência de usuário fluida. Após a COVID-19, a necessidade de CDNs aumentou ainda mais, devido ao grande número de empresas físicas migrando para o ambiente online, ao aumento das conferências web, dos jogos online e do streaming de vídeo.

Durante os primeiros dias, uma CDN era uma rede simples de servidores proxy que:

1. Cachear conteúdo (como HTML, imagens, folhas de estilo, JavaScript, vídeos, etc.)
2. Reduzir as conexões de rede para que os usuários finais acessem o conteúdo
3. Descarregar a terminação de conexões TCP dos data centers que hospedam as propriedades da web

Eles ajudaram principalmente os proprietários de sites a melhorar o tempo de carregamento das páginas e a descarregar o tráfego da infraestrutura que hospeda essas propriedades da web.

Com o tempo, os serviços oferecidos pelos provedores de CDN evoluíram além do cache e da descarga de largura de banda/conexões. Devido à sua natureza distribuída e à grande capacidade de rede distribuída, os CDNs se mostraram extremamente eficientes em lidar com ataques [Distribuídos de Negação de Serviço (DDoS)](https://pt.wikipedia.org/wiki/Ataque_de_nega%C3%A7%C3%A3o_de_servi%C3%A7o#Ataque_distribu%C3%ADdo) em larga escala. A computação na borda é outro serviço que ganhou popularidade nos últimos anos. Muitos fornecedores de CDN oferecem serviços de computação na borda que permitem aos proprietários de sites executar códigos simples na borda da rede.

Outros serviços oferecidos pelos fornecedores de CDN incluem:

* [Firewalls de Aplicações Web (WAF)](https://en.wikipedia.org/wiki/Web_application_firewall) hospedados na nuvem
* Soluções de gerenciamento de bots
* Soluções de "clean pipe" (centros de dados para limpeza)
* Soluções de gerenciamento de imagens e vídeos

Há benefícios para os proprietários de sites ao aproximar a lógica e os fluxos de trabalho das aplicações web dos usuários finais. Isso elimina a viagem de ida e volta e a largura de banda que uma solicitação HTTP/HTTPS exigiria. Também lida com os requisitos de escalabilidade quase instantânea para a origem. Um efeito colateral disso é que os Provedores de Serviços de Internet (ISPs) também se beneficiam da gestão de escalabilidade, o que melhora a capacidade de sua infraestrutura.

### Advertências e Isenções de Responsabilidade

Como em qualquer estudo observacional, existem limites para o escopo e o impacto que podem ser medidos. As estatísticas coletadas sobre o uso de CDNs para o Web Almanac concentram-se mais nas tecnologias aplicáveis em uso e não têm a intenção de medir o desempenho ou a eficácia de um fornecedor específico de CDN. Embora isso garanta que não estamos inclinados a favor de nenhum fornecedor de CDN, também significa que os resultados são mais generalizados.

Estes são os limites da nossa [metodologia de teste](./methodology):

- **Latência de rede simulada:** Usamos uma conexão de rede dedicada que modela o tráfego de forma sintética.

- **Localização geográfica única:** Os testes são realizados a partir de um único data center e não podem avaliar a distribuição geográfica de muitos provedores de CDN.

- **Eficácia do cache:** Cada CDN utiliza tecnologia proprietária e muitas, por razões de segurança, não expõem o desempenho do cache.

- **Localização e internacionalização:** Assim como a distribuição geográfica, os efeitos de idioma e domínios específicos de cada região também são opacos para esses testes.

- **Detecção de CDN:** Isso é feito principalmente através da resolução de DNS e cabeçalhos HTTP. A maioria dos CDNs usa um CNAME de DNS para mapear um usuário para um data center otimizado. No entanto, alguns CDNs usam IPs Anycast ou respostas diretas A+AAAA de um domínio delegado, o que oculta a cadeia de DNS. Em outros casos, sites usam múltiplos CDNs para equilibrar entre fornecedores, o que é oculto da análise de uma única solicitação do nosso rastreador.

Tudo isso influencia nossas medições.

Mais importante ainda, esses resultados refletem o suporte a recursos específicos (por exemplo, TLSv1.3, HTTP/2) por site, mas não refletem o uso real de tráfego. O YouTube é mais popular do que `www.example.com`, mas ambos aparecerão como iguais em nosso conjunto de dados.

Com isso em mente, aqui estão algumas estatísticas que foram intencionalmente não medidas no contexto de um CDN:

1. Tempo até o Primeiro Byte (TTFB)
2. Tempo de Ida e Volta do CDN
3. Métricas de Web Vitals
4. Desempenho de "Cache hit" versus "cache miss"

Embora algumas dessas métricas possam ser medidas com o conjunto de dados do HTTP Archive e outras usando o conjunto de dados do CrUX, as limitações de nossa metodologia e o uso de múltiplos CDNs por alguns sites tornam a medição difícil e podem levar a atribuições incorretas. Por essas razões, decidimos não medir essas estatísticas neste capítulo.

Não observamos diferenças notáveis entre dispositivos móveis e desktop, então, para evitar repetições, os dados fornecidos neste capítulo são principalmente para uso em dispositivos móveis, a menos que indicado de outra forma.

## Adoção de CDN

Uma página da web é composta pelos seguintes componentes principais:

1. Página HTML base (por exemplo, `www.example.com/index.html`—frequentemente disponível com um nome mais amigável, como apenas `www.example.com`).
2. Conteúdo de primeira parte incorporado, como imagens, CSS, fontes e arquivos JavaScript no domínio principal (`www.example.com`) e nos subdomínios (por exemplo, `images.example.com`, ou `assets.example.com`).
3. Conteúdo de terceiros (por exemplo, Google Analytics, anúncios) servido de domínios de terceiros.

{{ figure_markup(
  image="cdn-usage-hosted.png",
  caption="Uso de CDN versus recursos hospedados em dispositivos móveis.",
  description="Gráfico de barras do uso de CDN versus recursos hospedados, dividido por origem e CDN. Para o conteúdo HTML, 71% das solicitações vêm da origem e 29% dos CDNs. Para o conteúdo de subdomínio, 53% origem e 47% CDN. E para o conteúdo de terceiros, 33% origem e 67% CDN.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=41983383&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

O gráfico acima mostra a divisão de cada tipo de solicitação para CDNs versus recursos hospedados em dispositivos móveis — como mencionado na introdução, figuras quase idênticas foram observadas para desktops. Observa-se que os CDNs são frequentemente utilizados para entregar conteúdo estático, como imagens, folhas de estilo, JavaScript e fontes. Esse tipo de conteúdo não muda com frequência, tornando-o um bom candidato para cache nos servidores proxy dos CDNs. Ainda assim, vemos que os CDNs são usados com mais frequência para esse tipo de recurso — especialmente para conteúdo de terceiros.

Os CDNs podem proporcionar um desempenho melhor na entrega de conteúdo não estático, além de frequentemente otimizar as rotas e utilizar os mecanismos de transporte mais eficientes. No entanto, observamos que o uso de CDNs para servir HTML ainda fica consideravelmente atrás dos outros dois tipos de conteúdo.

{{ figure_markup(
  image="cdn-usage-hosted-comparison.png",
  caption="Tendências para o conteúdo servido por CDN em dispositivos móveis",
  description="Este gráfico mostra as tendências para o conteúdo servido por CDN nos últimos anos. A tendência geral é que o uso de CDN está aumentando. Para os conteúdos servidos de subdomínios, observamos um aumento ainda maior.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=2141710369&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

Comparado ao [ano de 2021](../2021/cdn) , constatamos que o uso de CDN tem aumentado de forma constante. Houve um grande aumento no uso de CDN para o conteúdo servido a partir de subdomínios, e um aumento menor para HTML, enquanto o uso de CDN por terceiros permaneceu relativamente estático.

Essas são algumas das possíveis razões que podem ser atribuídas a esse aumento:

* Pós-pandemia, muitos negócios levaram uma grande parte de suas operações físicas para o online. Isso colocou muita pressão em seus servidores, e descobriram que era muito mais eficiente servir o conteúdo estático através de CDNs para descarregar através de cache e entrega mais rápida.
* Esse aumento não foi visto em 2021, pois muitos negócios ainda estavam tentando encontrar a solução ideal para seus problemas. Na verdade, observamos uma diminuição no uso de CDN para o tipo de conteúdo de subdomínio e de terceiros.
* Os sites passaram a confiar em servir conteúdo de terceiros através de domínios de terceiros em vez de seus próprios domínios. O fato de a quantidade de conteúdo servido a partir de domínios de terceiros ter aumentado em 3% durante esse período apoia essa suposição.

Quanto à página HTML base, o padrão tradicional tem sido servir o HTML base a partir da origem, e esse padrão continuou, já que a maioria das páginas base ainda é servida a partir da origem. No entanto, houve um aumento de 4% nas páginas base servidas por CDNs. A tendência de páginas HTML base sendo servidas a partir de CDNs está claramente em ascensão.

Aqui estão algumas das razões prováveis para o aumento:
* CDNs podem melhorar o tempo de carregamento da página HTML base, o que pode ser de alta importância para melhorar a experiência do cliente e manter os usuários engajados.
* Usar DNS distribuído fornecido por CDNs é mais simples e rápido.
* É mais fácil planejar a Recuperação de Desastres se a maior parte do conteúdo, incluindo a página HTML base, for enviada através de CDNs. CDNs frequentemente oferecem uma funcionalidade de failover para alternar automaticamente para o site alternativo quando o site principal se torna instável ou indisponível.

Embora tenhamos observado a adoção de CDN em diferentes tipos de conteúdo, vamos analisar esses dados sob um ponto de vista diferente a seguir—com base na popularidade do site.

{{ figure_markup(
  image="cdn-usage-ranking-desktop.png",
  caption="Uso de CDN por popularidade do site em dispositivos móveis.",
  description="Este gráfico de barras oferece uma visão do uso de CDN em sites móveis, dividido por top 1.000, 10.000, 100.000, 1 milhão e 10 milhões de sites populares, conforme os dados do Google CRUX. Para os top 1.000 e 10.000 sites, a adoção de CDN é superior a 60%. A adoção diminui para sites com menor popularidade.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1175849008&format=interactive",
  sheets_gid="1207165933",
  sql_file="cdn_usage_by_site_rank.sql"
  )
}}

Analisando o uso de CDN para sites com base em sua popularidade—com dados do Google Chrome UX Report—os top 1.000-10.000 contribuem para o maior uso de CDN. Para os sites mais bem classificados, é compreensível que as empresas investam em CDN para desempenho e outros benefícios, mas mesmo para os top 1.000.000 sites, houve um aumento de cerca de 7% na quantidade de conteúdo entregue através de CDNs [comparado a 2021](../2021/cdn#fig-3). Esse aumento no uso de CDN para sites com menor popularidade pode ser atribuído ao fato de que houve um aumento nas opções gratuitas e acessíveis de CDNs, além de muitas soluções de hospedagem oferecerem CDNs incluídos nos serviços.

## Principais provedores de CDN

Os provedores de CDN podem ser amplamente classificados em 2 segmentos:

1. CDN Genérico (Akamai, Cloudflare, CloudFront, Fastly, etc.)
2. CDN Especializado (Netlify, WordPress, etc.)

CDNs genéricos atendem às necessidades do mercado em massa. Seus serviços incluem:

* Entrega de sites
* Entrega de APIs para aplicativos móveis
* Transmissão de vídeo
* Serviços de computação na borda
* Ofertas de segurança na web

Isso atrai um conjunto maior de indústrias e é refletido nos dados.

{{ figure_markup(
  image="top-cdns-html.png",
  caption="Principais CDNs para requisições de HTML em dispositivos móveis.",
  description="Gráfico de caixa mostrando os principais provedores de CDN que atendem a solicitações de HTML. A Cloudflare lidera a lista, servindo 52% das solicitações de HTML, seguida pelo Google com 22%, Fastly com 9%, CloudFront com 6% e Akamai e Automattic com 3%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1688291462&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

A figura acima mostra os principais provedores de CDN para solicitações de HTML base. Os principais fornecedores nesta categoria são Cloudflare, Google, Fastly, Amazon CloudFront, Akamai e Automattic.

{{ figure_markup(
  image="top-cdns-subdomain.png",
  caption="Principais CDNs para solicitações de subdomínio em dispositivos móveis.",
  description="O gráfico de caixa mostra os principais provedores de CDN que atendem solicitações de subdomínio. A Cloudflare lidera a lista, servindo 35% das solicitações de subdomínio, seguida pela CloudFront com 18%, Google com 17%, Automattic com 9%, Akamai com 5% e Fastly com 3%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1743984972&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

Para as solicitações de subdomínio, podemos observar um maior uso de provedores como Amazon e Google. Isso ocorre porque muitos usuários têm seu conteúdo hospedado nos serviços de nuvem que eles oferecem, e os usuários utilizam as ofertas de CDN junto com seus serviços de nuvem. Isso ajuda os usuários a escalar suas aplicações e a aumentar o desempenho de suas aplicações.

{{ figure_markup(
  image="top-cdns-3p.png",
  caption="Principais CDNs para solicitações de terceiros em dispositivos móveis.",
  description="Gráfico de caixa mostrando os principais provedores de CDN que atendem solicitações de terceiros. O Google lidera a lista, atendendo 48% das solicitações de terceiros, seguido pelo Cloudflare com 15%, CloudFront com 12%, Akamai com 6%, Facebook com 5% e Fastly com 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1502237125&format=interactive",
  sheets_gid="2085205637",
  sql_file="top_cdns.sql"
  )
}}

Analisando os domínios de terceiros, vê-se uma tendência diferente nos principais provedores de CDN. O Google lidera a lista antes dos provedores de CDN genéricos, e o Facebook também ganha destaque. Isso é respaldado pelo fato de que muitos proprietários de domínios de terceiros exigem CDNs mais do que outras indústrias. Para os grandes provedores de terceiros—como Google e Facebook—isso os obriga a investir na construção de uma CDN especialmente projetada. Uma CDN especialmente projetada é aquela otimizada para um fluxo de trabalho específico de entrega de conteúdo.

Por exemplo, uma CDN construída especificamente para entregar anúncios será otimizada para:

- Alta operação de entrada e saída (I/O)
- Gerenciamento eficaz de conteúdo de [cauda longa](https://pt.wikipedia.org/wiki/Cauda_longa)
- Proximidade geográfica com empresas que necessitam de seus serviços

Isso significa que as CDNs construídas especificamente atendem aos requisitos exatos de um segmento de mercado específico, ao contrário de uma solução de CDN genérica. Soluções genéricas podem atender a um conjunto mais amplo de requisitos, mas não são otimizadas para uma indústria ou mercado específico.

## Uso de TLS

Com as CDNs configuradas nos fluxos de trabalho de solicitação-resposta, a conexão TLS do usuário final termina na CDN. Por sua vez, a CDN estabelece uma segunda conexão TLS independente, que vai da CDN ao host de origem. Essa quebra no fluxo de trabalho da CDN permite que a CDN defina os parâmetros TLS do usuário final. As CDNs também tendem a fornecer atualizações automáticas para protocolos da Internet. Isso permite que os proprietários de sites recebam esses benefícios sem precisar fazer alterações em sua origem.

### Impacto da adoção do TLS

Os gráficos abaixo mostram que a adoção da versão mais recente do TLS tem sido muito maior para o conteúdo servido por CDNs em comparação com o servido pela origem.

{{ figure_markup(
  image="tls-version-mobile.png",
  caption="Distribuição da versão do TLS para HTML (móvel).",
  description="Gráfico de barras mostrando o uso das versões do TLS em solicitações móveis servidas por CDN e origem. Os CDNs serviram 87% das solicitações usando TLS 1.3 e 13% das solicitações com TLS 1.2. Por outro lado, a origem serviu 42% das solicitações por meio do TLS 1.3 e 58% das solicitações com TLS 1.2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=755535896&format=interactive",
  sheets_gid="2008253446",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

Comparado ao [ano de 2021](../2021/cdn#tls-adoption-impact),  para o conteúdo HTML móvel, a adoção do TLS v1.3 aumentou em 5%, enquanto para o conteúdo servido pela origem, a adoção do TLS v1.3 aumentou em 10%.

{{ figure_markup(
  image="tls-version-mobile-3p.png",
  caption="Distribuição da versão do TLS para solicitações de terceiros (móvel).",
  description="Gráfico de barras mostrando o uso das versões do TLS em solicitações de terceiros no desktop, servido por CDN e origem. Os CDNs serviram 88% das solicitações de terceiros usando TLS 1.3 e 12% usando TLS 1.2. A origem, por outro lado, serviu 26% das solicitações sobre TLS 1.3 e 74% das solicitações sobre TLS 1.2.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1995157146&format=interactive",
  sheets_gid="2008253446",
  sql_file="distribution_of_tls_versions_cdn_vs_origin.sql"
  )
}}

No cenário de segurança atual, é importante que o conteúdo seja entregue através da versão mais recente do TLS. Pode-se ver pelos dados acima que a transição para o TLS v1.3 foi muito mais rápida para os CDNs em comparação com a origem. Isso demonstra o benefício adicional de segurança ao usar CDNs para a entrega de conteúdo.

### Impacto no desempenho do TLS

A lógica comum dita que, quanto menos saltos um pedido-resposta HTTPS precisa atravessar, mais rápido será o tempo de ida e volta.

{{ figure_markup(
  image="tls-negotiation-desktop.png",
  caption="Negociação de TLS para HTML - CDN vs origem (desktop)",
  description="Este gráfico de barras fornece uma visão sobre o tempo de conexão TLS (em milissegundos) nos percentis de 10º, 25º, 50º, 75º e 90º para CDN e origem. Como pode ser visto no gráfico, o tempo de negociação TLS é geralmente mais rápido para CDNs.",
  chart_url="https://docs.google.com/spreadsheets/u/1/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1669978107&format=interactive",
  sheets_gid="1644442668",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

{{ figure_markup(
  image="tls-negotiation-mobile.png",
  caption="Negociação TLS de HTML - CDN vs origem (mobile)",
  description="Este gráfico de barras fornece uma visão sobre o tempo de conexão TLS (em milissegundos) nos percentis de 10º, 25º, 50º, 75º e 90º para CDN e origem. Como pode ser visto no gráfico, o tempo de negociação TLS é geralmente mais rápido para CDNs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1577806460&format=interactive",
  sheets_gid="1644442668",
  sql_file="distribution_of_tls_time_cdn_vs_origin.sql"
  )
}}

Como pode ser visto nas figuras acima, o tempo de negociação TLS é geralmente muito melhor com CDNs. Isso é ainda mais evidente ao comparar os dados de desktop e móvel, onde o maior _Round Trip Time_ (RTT) [usado pelo nosso rastreador móvel](./methodology#webpagetest) resulta em tempos de negociação TLS muito maiores.

Os CDNs ajudaram a reduzir significativamente os tempos de conexão TLS. Isso se deve à sua proximidade com o usuário final e à adoção de protocolos TLS mais recentes que otimizam a negociação TLS. Os CDNs têm vantagem sobre a origem em todos os percentis. Nos percentis P10 e P25, os CDNs são quase 1,5 vezes mais rápidos do que a origem no tempo de configuração TLS. A diferença aumenta ainda mais quando atingimos a mediana e acima, onde os CDNs são quase 2 vezes mais rápidos (móvel) e quase 3 vezes mais rápidos (desktop). Usuários no 90º percentil usando um CDN terão um desempenho melhor do que os usuários no 50º percentil em conexões diretas com a origem.

Isso é particularmente importante considerando que todos os sites precisam estar em TLS atualmente. Um desempenho ótimo nesta camada é essencial para as outras etapas que seguem a conexão TLS. Nesse sentido, os CDNs são capazes de mover mais usuários para faixas percentuais mais baixas em comparação com as conexões diretas com a origem.

## Adoção do HTTP/2+

A especificação do HTTP/2 foi introduzida pela primeira vez em 2015 e recebeu amplo suporte, com a maioria dos navegadores principais adotando-a antes do final do ano. O protocolo da camada de aplicação HTTP não era atualizado desde o HTTP 1.1 em 1997 e, desde então, o tráfego da web, tipos de conteúdo, tamanho de conteúdo, design de sites, plataformas, aplicativos móveis e mais evoluíram significativamente. Assim, havia a necessidade de um protocolo que pudesse atender às exigências do tráfego web moderno, e esse protocolo foi realizado com o HTTP/2.

Apesar da empolgação em torno do HTTP/2 e a promessa de redução de latência e outras funcionalidades, a adoção dependia de atualizações no lado do servidor para suportar o novo protocolo de aplicação. As CDNs podem ajudar a superar o desafio das novas implementações para os proprietários de sites, e isso também se aplica ao protocolo ainda mais recente HTTP/3. Uma conexão HTTP termina no nível da CDN, e isso permite que os proprietários de sites entreguem seus sites e subdomínios via HTTP/2 e HTTP/3 sem a necessidade de atualizar sua própria infraestrutura para suportá-los. Benefícios semelhantes também foram observados com a adoção de versões mais recentes do TLS.

As CDNs atuam como um proxy para preencher a lacuna, fornecendo uma camada para consolidar nomes de host e roteando o tráfego para os pontos finais relevantes com mudanças mínimas em sua infraestrutura de hospedagem. Recursos como priorização de conteúdo na fila e push do servidor podem ser gerenciados do lado das CDNs e algumas CDNs até fornecem soluções automatizadas para executar esses recursos sem qualquer input dos proprietários dos sites, oferecendo assim um impulso para a adoção do HTTP/2.

<p class="note">Observe que, devido ao funcionamento do HTTP/3 (veja o capítulo sobre [HTTP](./http) para mais informações), o HTTP/3 frequentemente não é utilizado para conexões iniciais. Por isso, estamos medindo "HTTP/2+", já que muitas dessas conexões HTTP/2 podem, na verdade, ser HTTP/3 para visitantes recorrentes (presumimos que nenhum servidor implementa HTTP/3 sem HTTP/2).</p>

{{ figure_markup(
  image="cdn-http-versions-mobile.png",
  caption="Distribuição das versões HTTP para HTML (mobile).",
  description="Este gráfico de barras mostra a adoção das versões HTTP em solicitações de HTML para dispositivos móveis, tanto em CDNs quanto em origens. Para solicitações de HTML para dispositivos móveis servidas por CDNs, 84% foram entregues com o protocolo HTTP/2 ou superior, enquanto as solicitações servidas pela origem tiveram 43% entregues com HTTP/2 ou superior.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1385171364&format=interactive",
  sheets_gid="542001559",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

Há contrastes marcantes no gráfico acima, com uma alta adoção de HTTP/2+ por domínios em CDNs em comparação com aqueles que não utilizam uma CDN.

Em 2021, [quase 40% do conteúdo servido a partir de origens adotou HTTP/2](../2021/cdn#http2-http2-or-better-adoption), enquanto no mesmo período, 81% do conteúdo servido por CDNs usava HTTP/2. Para as origens, esse número cresceu 3 pontos percentuais, enquanto para as CDNs, cresceu 6 pontos percentuais—ampliando ainda mais a lacuna considerável que já existia. Isso demonstra como as CDNs permitiram que os proprietários de sites aproveitassem os protocolos mais recentes desde um estágio muito inicial, sem precisar fazer alterações na origem.

{{ figure_markup(
  image="cdn-http-versions-mobile-3p.png",
  caption="Distribuição das versões HTTP para requisições de terceiros (mobile).",
  description="Este gráfico de barras mostra a adoção das versões HTTP em requisições de terceiros para dispositivos móveis, tanto de CDN quanto de origem. Para essas requisições de terceiros servidas por CDNs, 88% foram entregues com o protocolo HTTP/2 ou superior, enquanto as requisições servidas pela origem tinham 50% entregues com HTTP/2 ou superior.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=983285021&format=interactive",
  sheets_gid="542001559",
  sql_file="distribution_of_http_versions_cdn_vs_origin.sql"
  )
}}

Os domínios de terceiros foram ainda mais rápidos em adotar novos protocolos, como vimos em nosso estudo anterior. Em 2022, observamos uma nova diminuição na participação do HTTP/1.1 para domínios de terceiros, embora nossos dados não tenham conseguido identificar um número maior de protocolos utilizados neste ano, o que justifica uma investigação mais aprofundada.

Os domínios de terceiros precisam de um desempenho consistente em todas as condições de rede, e é aí que o HTTP/2+ agrega valor. Em junho de 2022, o Internet Engineering Task Force (IETF) publicou o [HTTP/3 RFC](https://www.theregister.com/2022/06/07/http3_rfc_9114_published/) para levar a web do TCP para o UDP. Muitos provedores de CDN foram rápidos em adotar o suporte ao HTTP/3, alguns antes mesmo da publicação formal do RFC, e ao longo do tempo devemos ver os proprietários de sites adotando o HTTP/3, especialmente com o tráfego de redes móveis tendo uma maior contribuição para o tráfego total da internet. Fique atento para mais informações em 2023.

## Adoção do Brotli

O conteúdo entregue pela internet utiliza compressão para reduzir o tamanho da carga útil. Uma carga útil menor significa que é mais rápido entregar o conteúdo do servidor ao usuário final. Isso faz com que os sites carreguem mais rapidamente e proporcionem uma melhor experiência ao usuário final. Para imagens, essa compressão é tratada por formatos de arquivo de imagem como JPEG, WEBP, AVIF—consulte o capítulo [Mídia](./media) para mais informações sobre isso. Para ativos textuais da web—como HTML, JavaScript e folhas de estilo— a compressão foi tradicionalmente tratada pelo formato de arquivo [_Gzip_](https://pt.wikipedia.org/wiki/Gzip) O Gzip existe desde 1992. Ele fez um bom trabalho em reduzir o tamanho das cargas úteis de texto, mas uma nova compressão de ativos de texto pode ser melhor do que o Gzip ao usar o formato de compressão [_Brotli_](https://en.wikipedia.org/wiki/Brotli).

Semelhante à adoção do TLS e HTTP/2, o Brotli passou por uma fase de adoção gradual em plataformas da web. No momento da redação, o Brotli é <a hreflang="en" href="https://caniuse.com/brotli">suportado por mais de 96%</a> dos navegadores web globalmente. No entanto, nem todos os sites comprimem ativos de texto no formato Brotli. Isso ocorre devido tanto à falta de suporte quanto ao maior tempo necessário para comprimir um ativo de texto no formato Brotli em comparação com a compressão Gzip. Além disso, a infraestrutura de hospedagem precisa ter compatibilidade com versões anteriores para servir ativos comprimidos em Gzip para plataformas mais antigas que não suportam o formato Brotli, o que pode adicionar complexidade.

O impacto disso é observado quando comparamos sites que utilizam CDN com aqueles que não utilizam CDN.

{{ figure_markup(
  image="cdn-compression-mobile.png",
  caption="Distribuição dos tipos de compressão (móvel).",
  description="Este gráfico de barras mostra a adoção do Brotli em comparação com o Gzip em solicitações móveis, divididas entre CDN e origem. As CDNs serviram 47% das solicitações no formato Brotli comprimido e 57,3% das solicitações no formato Gzip comprimido. Por outro lado, a origem serviu 25% das solicitações no formato Brotli e 77% no formato Gzip.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1836100530&format=interactive",
  sheets_gid="2043216080",
  sql_file="distribution_of_compression_types_cdn_vs_origin.sql"
  )
}}

Tanto a CDN quanto a Origem mostraram um aumento na adoção do Brotli [em comparação com o ano anterior](../2021/cdn#brotli-adoption). Observamos que a adoção do Brotli nas CDNs cresceu 5 pontos percentuais, enquanto a Origem cresceu quase 4 pontos percentuais. Veremos se essa tendência continuará em 2023 ou se atingimos o ponto de saturação.

## Adoção de Client Hints

_Client Hints_ permite que um servidor web solicite proativamente dados do cliente, e essas informações são enviadas como parte dos cabeçalhos HTTP. O cliente pode fornecer informações como dispositivo, preferências do agente do usuário e rede. Com base nas informações fornecidas, o servidor pode determinar os recursos mais otimizados para responder ao cliente que fez a solicitação. Os Client Hints foram introduzidos primeiro nos navegadores Google Chrome e, embora outros navegadores baseados no Chromium tenham adotado, outros navegadores populares têm suporte limitado ou nenhum suporte para Client Hints.

O CDN, os servidores de origem e o navegador cliente devem todos suportar Client Hints para que sejam utilizados adequadamente. Como parte do fluxo, o CDN pode apresentar o cabeçalho HTTP `Accept-CH` ao cliente para solicitar quais Client Hints um cliente deve incluir nas solicitações subsequentes. Medimos as respostas dos clientes onde o CDN forneceu este cabeçalho dentro da solicitação e o medimos em todas as solicitações de CDN registradas como parte de nossos testes.

{{ figure_markup(
  image="cdn-client-hints-mobile.png",
  caption="Comparação de Client Hints (mobile)",
  description="Este gráfico de barras mostra o uso de Client Hints em CDNs. Atualmente, apenas 0,43% das solicitações possuem Client Hints.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=1567266649&format=interactive",
  sheets_gid="2048261739",
  sql_file=""
  )
}}

Para clientes de desktop e mobile, vimos que menos de 1% das solicitações utilizam Client Hints, indicando que a adoção de Client Hints ainda está em seus estágios iniciais.

## Adoção de formatos de imagem

Os CDNs têm sido tradicionalmente usados para armazenar em cache, comprimir e entregar conteúdo estático, como imagens, desde o seu início. Desde então, muitos CDNs adicionaram a capacidade de alterar dinamicamente imagens, tanto no formato quanto no tamanho, para otimizar a imagem para diferentes casos de uso.

Isso pode ser feito automaticamente, com base no agente do usuário ou nos client hints, ou enviando parâmetros adicionais na string de consulta, onde o processamento na borda interpretará e modificará a imagem na resposta de acordo. Isso permite que os operadores de sites carreguem uma única imagem de alta resolução e a modifiquem dinamicamente para quando imagens de menor qualidade ou menor resolução forem necessárias, como em miniaturas.

{{ figure_markup(
  image="cdn-image-formats-mobile.png",
  caption="Distribuição de Formatos de Imagem (móvel).",
  description="Este gráfico de barras mostra a adoção do Brotli em CDNs e origem em requisições móveis. As CDNs serviram 42,6% das requisições no formato comprimido Brotli e 57,3% no formato comprimido gzip. Por outro lado, a origem serviu 21,2% das requisições no formato comprimido Brotli e 78,7% no formato comprimido gzip.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRZQqyyKiQWgICD_a0WaEAmfZyFN_Zi3wVuQnZxsXqwZ_1JQg2x7GpRw4CTkX4gKvurzoCQ6YokkdpM/pubchart?oid=293872923&format=interactive",
  sheets_gid="571877353"
  )
}}

Em ambas as plataformas, desktop e móvel, os formatos de imagem dominantes foram JPG (JPEG) e PNG. O JPG oferece um formato de arquivo comprimido com perdas, otimizando o tamanho. O PNG, ou Portable Graphics Format, suporta compressão sem perdas, o que significa que nenhum dado é perdido durante a compressão da imagem, no entanto, o tamanho da imagem é geralmente maior do que o de um JPG. Para mais informações sobre JPG vs PNG, visite [o site da Adobe](https://www.adobe.com/br/creativecloud/file-types/image/comparison/jpeg-vs-png.html).

## Conclusão

A partir do nosso estudo contínuo nos últimos anos, podemos ver que as CDNs não só têm sido vitais para os proprietários de sites, garantindo a entrega confiável de conteúdo do origin para qualquer usuário ao redor do mundo, como também desempenharam um papel fundamental na adoção de novos [padrões de segurança](./security) e da web.

De maneira geral, observamos um aumento no uso de CDNs em todos os aspectos. Notamos que as CDNs desempenharam um papel significativo na adoção de novos padrões de segurança da web, como o TLS 1.3, com uma porcentagem muito maior de tráfego usando TLS 1.3 vindo das CDNs.

Quanto à adoção de novos padrões e tecnologias da web, como HTTP/2 e compressão Brotli, novamente vimos as CDNs liderando o caminho. Percentuais muito maiores de sites servidos por CDNs adotaram esses novos padrões. Do ponto de vista do usuário final, isso é um desenvolvimento muito positivo, pois eles poderão utilizar o site com segurança e obter a melhor experiência possível.

Também estamos começando a analisar novas métricas, como Client Hints e adoção de formatos de imagem, a partir deste ano. Seremos capazes de obter mais insights à medida que coletamos mais dados para o próximo ano.

Existem limitações nas percepções que podemos deduzir sobre as CDNs a partir de observações externas, uma vez que é difícil conhecer os detalhes secretos que as impulsionam nos bastidores. No entanto, fizemos uma varredura dos domínios e comparamos os que estão em CDNs com aqueles que não estão. Podemos ver que as CDNs têm sido um facilitador para que os sites adotem novos protocolos da web, desde a camada de rede até a camada de aplicação.

Esse papel das CDNs é extremamente valioso e continuará sendo assim. Os provedores de CDN também são uma parte fundamental da <a hreflang="en" href="https://www.ietf.org/">Internet Engineering Task Force (IETF)</a>, onde ajudam a moldar o futuro da internet. Eles continuarão desempenhando um papel crucial no auxílio às indústrias habilitadas pela internet para operar de maneira fluida, confiável e rápida.

Estamos ansiosos para o próximo ano, para coletar mais dados e fornecer insights úteis aos nossos leitores.
