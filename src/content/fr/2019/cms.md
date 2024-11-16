---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CMS
description: Chapitre CMS de l'Almanach Web 2019 couvrant l'adoption des CMS, la façon dont les solutions CMS sont construites, l'expérience utilisateur des sites web propulsés par les CMS et l'innovation des CMS.
hero_alt: Hero image of Web Almanac charactes on a type writer writing a web page.
authors: [ernee, amedina]
reviewers: [sirjonathan]
analysts: [rviscomi]
editors: [rviscomi]
translators: [JustinyAhin]
discuss: 1769
results: https://docs.google.com/spreadsheets/d/1FDYe6QdoY3UtXodE2estTdwMsTG-hHNrOe9wEYLlwAw/
ernee_bio: Renee Johnson est consultante en développement et conception de produits web, passionnée de WordPress, et organisatrice et bénévole fréquente de WordCamp. Elle travaille actuellement avec l’équipe des relations avec les développeurs de systèmes de gestion de contenu chez Google en tant que spécialiste du support produit.
amedina_bio: Alberto Medina est <i lang="en">Developer Advocate</i> dans l’équipe Écosystèmes de Contenus Web chez Google, spécialisé dans la progression de la qualité des contenus sur le web via des technologies innovantes comme Amp, et l’usage d’APIS web modernes. Le travail actuel d’Alberto se focalise sur les systèmes de gestion de contenus puisqu’il dirige une équipe au sein des Écosystèmes de Contenus appellée Relation avec les Équipe de Développement CMS.
featured_quote: Le terme général Système de gestion de contenu (SGC, ou CMS pour Content Management System en anglais) désigne les systèmes permettant aux personnes et aux organisations de créer, de gérer et de publier du contenu. Un CMS pour le contenu web, plus précisément, est un système visant à créer, gérer et publier du contenu à consommer et à expérimenter via le web ouvert. Chaque CMS met en œuvre un sous-ensemble d’un large éventail de capacités de gestion de contenu et les mécanismes correspondants pour permettre aux utilisateurs de construire facilement et efficacement des sites web autour de leur contenu.
featured_stat_1: 40 %
featured_stat_label_1: des pages web sont propulsées par un CMS
featured_stat_2: 74 %
featured_stat_label_2: des sites utilisant un CMS utilisent WordPress
featured_stat_3: 1,232 Ko
featured_stat_label_3: poids des images sur page CMS (bureau)
---

## Introduction

Le terme général **Système de gestion de contenu (SGC, ou CMS pour Content Management System en anglais)** désigne les systèmes permettant aux personnes et aux organisations de créer, de gérer et de publier du contenu. Un CMS pour le contenu web, plus précisément, est un système visant à créer, gérer et publier du contenu à consommer et à expérimenter via le web ouvert.

Chaque CMS met en œuvre un sous-ensemble d'un large éventail de capacités de gestion de contenu et les mécanismes correspondants pour permettre aux utilisateurs de construire facilement et efficacement des sites web autour de leur contenu. Ce contenu est souvent stocké dans un certain type de base de données, ce qui permet aux utilisateurs de le réutiliser partout où cela est nécessaire pour leur stratégie de contenu. Les CMS offrent également des capacités d'administration visant à faciliter le téléversement et la gestion du contenu par les utilisateurs, selon leurs besoins.

Le type et la portée du support fourni par les CMS pour la construction de sites varient considérablement ; certains fournissent des modèles prêts à l'emploi qui sont "hydratés" par le contenu de l'utilisateur, et d'autres exigent une participation beaucoup plus importante de l'utilisateur à la conception et à la construction de la structure du site.

Lorsque nous parlons des CMS, nous devons tenir compte de tous les éléments qui jouent un rôle dans la viabilité d'un tel système pour fournir une plate-forme de publication de contenu sur le web. Tous ces composants forment un écosystème autour de la plate-forme du CMS, et ils incluent les fournisseurs d'hébergement, les développeurs d'extension, les agences de développement, les constructeurs de sites, etc. Ainsi, lorsque nous parlons d'un CMS, nous faisons généralement référence à la fois à la plate-forme elle-même et à l'écosystème qui l'entoure.

### Pourquoi les créateurs de contenu utilisent-ils un CMS ?

Au début des temps ("de l'évolution du web"), l'écosystème du web était alimenté par une simple boucle de croissance, où les utilisateurs pouvaient devenir des créateurs simplement en visualisant la source d'une page web, en faisant du copier-coller selon leurs besoins, et en adaptant la nouvelle version avec des éléments individuels comme des images.

Au fur et à mesure de son évolution, le web est devenu plus puissant, mais aussi plus compliqué. En conséquence, cette simple boucle de croissance a été rompue et il n'était plus possible que n'importe quel utilisateur devienne un créateur. Pour ceux qui pouvaient poursuivre le chemin de la création de contenu, la route devenait ardue et difficile à parcourir. Le <a hreflang="en" href="https://medinathoughts.com/2018/05/17/progressive-wordpress/">fossé des capacités d'utilisation</a>, c'est-à-dire la différence entre ce qui peut être fait sur le web et ce qui est réellement fait, a augmenté régulièrement.

{{ figure_markup(
  image="web-evolution.png",
  caption="Graphique illustrant l'augmentation des fonctionnalités du web de 1999 à 2018.",
  description="Sur la gauche, intitulée circa 1999, nous avons un diagramme à barres avec deux barres montrant que ce qui peut être fait est proche de ce qui est réellement fait. Sur la droite, intitulée 2018, nous avons un diagramme en bâtons similaire, mais ce qui peut être fait est beaucoup plus grand, et ce qui est fait est légèrement plus grand. L'écart entre ce qui peut être fait et ce qui est réellement fait a beaucoup augmenté.",
  width=600,
  height=492
  )
}}

C'est ici qu'un CMS joue un rôle très important en permettant à des utilisateurs ayant différents degrés d'expertise technique d'entrer facilement dans la boucle de l'écosystème web en tant que créateurs de contenu. En abaissant la barrière d'entrée pour la création de contenu, les CMS activent la boucle de croissance du web en transformant les utilisateurs en créateurs. D'où leur popularité.

### L'objectif de ce chapitre

Il y a beaucoup d'aspects intéressants et importants à analyser et de questions auxquelles répondre dans notre quête pour comprendre le monde des CMS et son rôle dans le présent et le futur du web. Bien que nous reconnaissions l'immensité et la complexité du monde des plateformes CMS, et que nous ne revendiquions pas une connaissance omnisciente couvrant tous les aspects impliqués sur toutes les plateformes CMS, nous revendiquons notre fascination pour cet univers et nous apportons une expertise approfondie sur certains de ses acteurs principaux.

Dans ce chapitre, nous cherchons à explorer la surface du vaste univers des CMS, en essayant d'éclairer notre compréhension collective du statu quo de ces écosystèmes et du rôle qu'ils jouent dans la perception des utilisateurs sur la façon dont le contenu peut être consommé et expérimenté sur le web. Notre but n'est pas de fournir une vue exhaustive du paysage des CMS ; nous allons plutôt discuter de quelques aspects liés au paysage des CMS en général, et des caractéristiques des pages web générées par ces systèmes. Cette première édition du Web Almanac établit une base de référence, et à l'avenir nous aurons l'avantage de pouvoir comparer les données avec cette version pour l'analyse des tendances.

## Adoption des CMS

{{ figure_markup(
  caption="Pourcentage de pages web propulsées par un CMS.",
  content="40%",
  classes="big-number"
)
}}

Aujourd'hui, nous remarquons que plus de 40% des pages web sont propulsées par une plateforme CMS ; 40.01% pour les mobiles et 39.61% pour les ordinateur de bureau plus précisément.

Il existe d'autres ensembles de données qui suivent la part de marché des plateformes CMS, comme <a hreflang="en" href="https://w3techs.com/technologies/history_overview/content_management">W3Techs</a>, et ils reflètent des pourcentages plus élevés de plus de 50% de pages web propulsées par des plateformes CMS. De plus, ils indiquent également que les plateformes CMS sont en expansion, jusqu'à 12 % de croissance d'une année à l'autre dans certains cas ! L'écart entre notre analyse et celle de W3Tech pourrait s'expliquer par une différence dans les méthodologies de recherche. Vous pouvez en lire plus sur la nôtre sur la page [Méthodologie](./methodology).

En gros, cela signifie qu'il existe de nombreuses plateformes CMS disponibles sur le marché. L'image suivante montre une vue réduite du paysage CMS.

{{ figure_markup(
  image="cms-logos.png",
  caption="Les principaux systèmes de gestion de contenu.",
  description="Logos des principaux fournisseurs de CMS, notamment WordPress, Drupal, Wix, etc.",
  width=600,
  height=559
  )
}}

Certains d'entre eux sont open source (par exemple WordPress, Drupal, et autres) et d'autres sont propriétaires ( comme AEM, et autres). Certaines plates-formes CMS peuvent être utilisées sur des formules "gratuites" hébergées ou auto-hébergées, et il existe également des options avancées pour utiliser ces plates-formes sur des formules de niveau supérieur, y compris au sein des entreprises. Dans son ensemble, le secteur des CMS est un univers complexe et fédéré d' *écosystèmes CMS*, tous séparés et en même temps entrelacés dans le vaste tissu du web.

Cela signifie également qu'il y a des centaines de millions de sites web propulsés par des plateformes CMS, et un ordre de grandeur plus élevé d'utilisateurs accédant au web et consommant du contenu à travers ces plateformes. Ainsi, ces plateformes jouent un rôle clé pour nous permettre de réussir dans notre quête collective d'un web toujours vert, sain et dynamique.

### Le paysage des CMS

Une grande partie du web aujourd'hui est alimentée par un type de plateforme CMS ou un autre. Il existe des statistiques recueillies par différentes organisations qui reflètent cette réalité. En regardant les jeux de données [Chrome UX Report](./methodology#chrome-ux-report) (CrUX) et HTTP Archive, nous arrivons à une image qui est cohérente avec les statistiques publiées ailleurs, bien que quantitativement les proportions décrites puissent être différentes en tant que reflet de la spécificité des jeux de données.

En examinant les pages web servies sur les appareils de bureau et mobiles, nous observons une répartition approximative de 60-40 dans le pourcentage de ces pages qui ont été générées par une sorte de plateforme CMS, et celles qui ne le sont pas.

{{ figure_markup(
  image="fig4.png",
  caption="Pourcentage de sites web desktop et mobiles qui utilisent un CMS.",
  description="Diagramme en bâtons montrant que 40 % des sites web desktop et 40 % des sites web mobiles sont construits à l'aide d'un CMS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1644425372&format=interactive"
  )
}}

Les pages web propulsées par les CMS sont générées par un large ensemble des plateformes CMS existantes. Le choix de ces plateformes est très vaste, et de nombreux facteurs peuvent être pris en compte lorsqu'on décide d'utiliser l'une ou l'autre, notamment:

* Fonctionnalité de base
* Création/édition de workflows et expérience
* Barrière d'entrée
* Possibilité de personnalisation
* Communauté
* Et beaucoup d'autres.

Les jeux de données CrUX et HTTP Archive contiennent des pages web propulsées par un ensemble d'environ 103 plateformes CMS. La plupart de ces plates-formes sont très petites en termes de part de marché relative. Pour les besoins de notre analyse, nous nous concentrerons sur les principales plates-formes CMS en termes de leur impact sur le web, tel que reflété par les données. Pour une analyse complète, <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1FDYe6QdoY3UtXodE2estTdwMsTG-hHNrOe9wEYLlwAw/edit#gid=0">voir la feuille de calcul des résultats de ce chapitre</a>.

{{ figure_markup(
  image="fig5.png",
  caption="Principales plateformes CMS en pourcentage de tous les sites web CMS.",
  description="Diagramme en bâtons montrant que WordPress représente 75% de tous les sites web créés avec un CMS. Le deuxième plus grand CMS, Drupal, a environ 6% de la part de marché des CMS. Le reste des CMS se réduit rapidement à moins de 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1652315665&format=interactive",
  width=600,
  height=600,
  data_width=600,
  data_height=600
  )
}}

Les principales plates-formes CMS présentes dans les jeux de données sont indiquées ci-dessus à la figure 14.5. WordPress est utilisé par 74,19 % des sites web utilisant un CMS pour les téléphones mobiles et 73,47 % des sites web utilisant un CMS pour les ordinateurs de bureau. Sa domination dans le milieu des CMS peut être attribuée à un certain nombre de facteurs dont nous parlerons plus loin, mais c'est un acteur _major_. Les plateformes open source comme Drupal et Joomla, et les solutions SaaS propriétaires comme Squarespace et Wix, complètent le top 5 des CMS. La diversité de ces plateformes reflète l'écosystème des CMS, composé de nombreuses plateformes où la démographie des utilisateurs et le parcours de création de sites web varient. Ce qui est également intéressant, c'est la longue liste des plateformes CMS de petites tailles qui se trouvent dans le top 20. Des offres d'entreprise aux applications propriétaires développées en interne pour une utilisation spécifique à un secteur, les systèmes de gestion de contenu fournissent une infrastructure personnalisable permettant aux groupes de gérer, de publier et de faire des affaires sur le web.

Le <a href="https://fr.wordpress.org/about/">projet WordPress</a> définit sa mission en ces termes : "*démocratiser la publication*". Certains de ses principaux objectifs sont de faciliter l'utilisation et de rendre le logiciel libre et disponible à tous pour créer du contenu sur le web. Un autre élément important est la communauté inclusive que le projet promeut. Dans presque toutes les grandes villes du monde, on peut trouver un groupe de personnes qui se réunissent régulièrement pour se rencontrer, partager et coder dans un effort de compréhension et de construction sur la plate-forme WordPress. La participation aux rencontres locales et aux événements annuels, ainsi que la participation aux réseaux basés sur le web sont quelques unes des façons dont les contributeurs, les experts, les entreprises et les passionnés de WordPress participent à sa communauté globale.

La faible barrière d'entrée et les ressources pour aider les utilisateurs (en ligne et en personne) à publier sur la plateforme et à développer des extensions (plugins) et des thèmes contribuent à sa popularité. La disponibilité et l'économie autour des extensions et des thèmes WordPress contribuent également à réduire la complexité dans la mise en œuvre de la conception et des fonctionnalités web recherchées. Non seulement ces aspects favorisent sa portée et son adoption par les nouveaux venus, mais ils permettent également de maintenir au fil du temps son utilisation régulière.

La plateforme open source WordPress est propulsée et soutenue par des bénévoles, la WordPress Foundation, et des acteurs majeurs de l'écosystème web. En gardant ces facteurs à l'esprit, le fait que WordPress soit le principal système de gestion de contenu (CMS) est tout à fait logique.

## Comment sont construits les sites propulsés par un CMS

Indépendamment des nuances spécifiques et des particularités des différentes plateformes CMS, leur objectif final est de produire des pages web qui seront mises à la disposition des utilisateurs par le biais de la vaste portée du web ouvert. La différence entre les pages web propulsées par un CMS et celles qui ne le sont pas est que dans le premier cas, la plate-forme CMS prend la plupart des décisions sur la façon dont le résultat final est construit, tandis que dans le second, il n'y a pas de telles couches d'abstraction et les décisions sont toutes prises par les développeurs, soit directement, soit via des configurations de bibliothèques.

Dans cette section, nous examinons brièvement le statu quo de l'espace CMS en termes de caractéristiques de leur résultat (par exemple, les ressources totales utilisées, les statistiques sur les images, entre autres), et nous les comparons avec celles de l'écosystème web en général.

### Utilisation totale des ressources

Les éléments de base de tout site web constituent également un site web géré par un CMS : [HTML](. /markup), [CSS](. /css), [JavaScript](. /javascript), et [media](. /media) (images et vidéo). Les CMS offrent aux utilisateurs des fonctionnalités de gestion puissamment optimisées pour intégrer ces ressources afin de créer des expériences web. Bien que ce soit l'un des aspects les plus inclusifs de ces applications, il est possible qu'il ait des effets négatifs sur le web en général.

{{ figure_markup(
  image="fig6.png",
  caption="Répartition du poids des pages sur les CMS.",
  description="Diagramme en bâtons montrant la distribution du poids des pages CMS. La page CMS moyenne sur ordinateur de bureau pèse 2.3 MB. Au 10e percentile, elle pèse 0,7 Mo, au 25e percentile, 1,2 Mo, au 75e percentile, 4,2 Mo et au 90e percentile, 7,4 Mo. Les valeurs pour les ordinateurs de bureau sont très légèrement supérieures à celles des mobiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=991628102&format=interactive"
  )
}}

{{ figure_markup(
  image="fig7.png",
  caption="Répartition des requêtes des CMS par page.",
  description="Diagramme en bâtons montrant la répartition des requêtes des CMS par page. La page CMS moyenne sur ordinateur de bureau charge 86 ressources. Au 10e percentile, elle charge 39 ressources, au 25e percentile 57 ressources, au 75e percentile 127 ressources et au 90e percentile 183 ressources. Le desktop est constamment plus élevé que le mobile par une petite marge de 3-6 ressources.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=140872807&format=interactive"
  )
}}

Dans les figures 6 et 7 ci-dessus, nous voyons que la page médiane sur un CMS sur un ordinateur de bureau charge 86 ressources et pèse 2,29 Mo. L'utilisation des ressources des pages mobiles n'est pas très loin derrière avec 83 ressources et 2,25 Mo.

La médiane indique le point médian où toutes les pages du CMS se situent soit au-dessus, soit au-dessous. En bref, la moitié de toutes les pages web sur un CMS chargent moins de requêtes et sont moins lourdes, tandis que l'autre moitié charge plus de requêtes et est plus lourde. Au 10e percentile, les pages mobiles et sur bureau ont moins de 40 requêtes et pèsent moins de 1 Mo, mais au 90e percentile, nous avons des pages avec plus de 170 requêtes et pesant 7 Mo, soit presque trois fois plus que la médiane.

Comment sont les pages CMS par rapport aux pages du web dans son ensemble ? Dans le chapitre [Poids de la page](. /page-weight), nous trouvons quelques données révélatrices sur l'utilisation des ressources. À la médiane, les pages de bureau chargent 74 requêtes et pèsent 1,9 Mo, et les pages mobiles sur le Web chargent 69 requêtes et pèsent 1,7 Mo. La page CMS moyenne dépasse ce chiffre. Les pages sur les CMS surpassent également les ressources sur le web au 90e percentile, mais avec une marge plus faible. En bref : les pages sur les CMS pourraient être classées parmi les plus lourdes.

<figure>
  <table>
    <thead>
      <tr>
        <th>percentile</th>
        <th>image</th>
        <th>video</th>
        <th>script</th>
        <th>font</th>
        <th>css</th>
        <th>audio</th>
        <th>html</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">1,233</td>
        <td class="numeric">1,342</td>
        <td class="numeric">456</td>
        <td class="numeric">140</td>
        <td class="numeric">93</td>
        <td class="numeric">14</td>
        <td class="numeric">33</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">2,766</td>
        <td class="numeric">2,735</td>
        <td class="numeric">784</td>
        <td class="numeric">223</td>
        <td class="numeric">174</td>
        <td class="numeric">97</td>
        <td class="numeric">66</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">5,699</td>
        <td class="numeric">5,098</td>
        <td class="numeric">1,199</td>
        <td class="numeric">342</td>
        <td class="numeric">310</td>
        <td class="numeric">287</td>
        <td class="numeric">120</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Répartition des kilo-octets des pages CMS de bureau par type de ressources.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>percentile</th>
        <th>image</th>
        <th>video</th>
        <th>script</th>
        <th>css</th>
        <th>font</th>
        <th>audio</th>
        <th>html</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">50</td>
        <td class="numeric">1,264</td>
        <td class="numeric">1,056</td>
        <td class="numeric">438</td>
        <td class="numeric">89</td>
        <td class="numeric">109</td>
        <td class="numeric">14</td>
        <td class="numeric">32</td>
      </tr>
      <tr>
        <td class="numeric">75</td>
        <td class="numeric">2,812</td>
        <td class="numeric">2,191</td>
        <td class="numeric">756</td>
        <td class="numeric">171</td>
        <td class="numeric">177</td>
        <td class="numeric">38</td>
        <td class="numeric">67</td>
      </tr>
      <tr>
        <td class="numeric">90</td>
        <td class="numeric">5,531</td>
        <td class="numeric">4,593</td>
        <td class="numeric">1,178</td>
        <td class="numeric">317</td>
        <td class="numeric">286</td>
        <td class="numeric">473</td>
        <td class="numeric">123</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Répartition des kilo-octets des pages CMS de bureau par type de ressources.") }}</figcaption>
</figure>

Lorsque nous regardons de plus près les types de ressources qui se chargent sur les pages sur les CMS sur mobile ou sur desktop, les images et la vidéo apparaissent immédiatement comme les principaux contributeurs à leur poids.

L'impact n'est pas nécessairement en corrélation avec le nombre de requêtes, mais plutôt avec la quantité de données associées à ces requêtes individuelles. Par exemple, dans le cas des ressources vidéo dont seulement deux demandes sont faites à la médiane, elles ont un poids de plus de 1Mo. Les expériences multimédias s'accompagnent également de l'utilisation de scripts pour intégrer l'interactivité, fournir des fonctionnalités et des données, pour ne citer que quelques cas d'utilisation. Sur les pages mobiles comme sur les pages sur ordinateur de bureau, ces ressources sont les troisièmes plus lourdes.

Avec nos expériences des CMS qui sont saturées de ces ressources, nous devons considérer l'impact que cela a sur les visiteurs du site web sur le front-end - leur expérience est-elle rapide ou lente ? De plus, lorsque l'on compare l'utilisation des ressources mobiles et ordinateur de bureau, la quantité de requêtes et le poids ne montrent que peu de différence. Cela signifie que la même quantité et le même poids de ressources alimentent à la fois les expériences CMS sur mobile et sur ordinateur de bureau. La variation de la vitesse de connexion et de la qualité des appareils mobiles ajoute <a hreflang="en" href="https://medinathoughts.com/2017/12/03/the-perils-of-mobile-web-performance-part-iii/">une autre couche de complexité</a>. Plus tard dans ce chapitre, nous utiliserons les données du CrUX pour évaluer l'expérience des utilisateurs dans l'écosystème des CMS.

### Ressources tierces

Soulignons un sous-ensemble spécifique de ressources pour évaluer leur impact dans l'écosystème des CMS. Les ressources [Tierce partie](./third-parties) sont celles qui proviennent d'origines n'appartenant pas au nom de domaine ou aux serveurs du site de destination. Elles peuvent être des images, des vidéos, des scripts ou d'autres types de ressources. Parfois, ces ressources sont combinées entre elles, comme par exemple avec l'intégration d'une `iframe`. Nos données révèlent que la quantité médiane de ressources tierces sur ordinateur de bureau et sur mobile est très similaire.

La quantité médiane de requêtes tierces sur les pages CMS mobiles est de 15 et pèse 264,72 Ko, tandis que la médiane de ces requêtes sur les pages CMS sur ordinateur de bureau est de 16 et pèse 271,56 Ko. (Il est à noter que cela exclut les ressources 3P considérées comme faisant partie de l' "hébergement".

{{ figure_markup(
  image="fig10.png",
  caption="Répartition du poids des tierces parties (en Ko) sur les pages CMS.",
  description="Diagramme en bâtons des percentiles 10, 25, 50, 75 et 90 représentant la distribution des kilo-octets de tierces parties sur les pages CMS pour les ordinateurs de bureau et les mobiles. Le poids médian (50e percentile) des pages de bureau de tierces parties est de 272 Ko. Le 10e percentile est de 27 Ko, le 25e de 104 Ko, le 75e de 577 Ko et le 90e de 940 Ko. Le mobile est légèrement plus petit dans les petits percentiles et légèrement plus grand dans les grands percentiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=354803312&format=interactive"
  )
}}

{{ figure_markup(
  image="fig11.png",
  caption="Répartition du nombre de requêtes de tiers sur les pages CMS.",
  description="Diagramme en bâtons des percentiles 10, 25, 50, 75 et 90 représentant la distribution des requêtes de tierces-parties sur les pages CMS sur ordinateur de bureau et mobile. Le nombre médian (50e percentile) de requêtes de tierces-parties sur ordinateur de bureau est de 16. Le 10e percentile est 3, le 25e 7, le 75e 31 et le 90e 52. Les ordinateurs de bureau et les mobiles ont des distributions presque équivalentes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=699762709&format=interactive"
  )
}}

Nous savons que la valeur médiane indique qu'au moins la moitié des pages Web des CMS sont envoyées avec plus de ressources tierces que ce que nous signalons ici. Au 90e percentile, les pages des CMS peuvent livrer jusqu'à 52 ressources à environ 940 Ko, ce qui représente une augmentation considérable.

Étant donné que les ressources tierces proviennent de domaines et de serveurs distants, le site de destination a peu de contrôle sur la qualité et l'impact de ces ressources sur sa performance. Cette imprévisibilité pourrait entraîner des fluctuations de vitesse et affecter l'expérience de l'utilisateur, ce que nous allons bientôt explorer.

### Statistiques sur les images

{{ figure_markup(
  image="fig12.png",
  caption="Répartition du poids des images (KB) sur les pages CMS.",
  description="Diagramme en bâtons des percentiles 10, 25, 50, 75 et 90 représentant la distribution des kilo-octets d'images sur les pages CMS bureau et mobile. Le poids médian (50e percentile) des images sur bureau est de 1 232 Ko. Le 10e percentile est de 198 Ko, le 25e de 507 Ko, le 75e de 2 763 Ko et le 90e de 5 694 Ko. Les ordinateurs de bureau et les mobiles ont des distributions presque équivalentes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1615220952&format=interactive"
  )
}}

{{ figure_markup(
  caption="Nombre médian de kilo-octets d'images chargés par page CMS sur ordinateur de bureau.",
  content="1,232 KB",
  classes="big-number"
)
}}

Rappelez-vous des figures 8 et 9 précédentes, les images sont un grand contributeur au poids total des pages des CMS. Les figures 12 et 13 ci-dessus montrent que la page médiane des CMS sur ordinateur de bureau a 31 images et un poids total de 1 232 Ko, tandis que la page médiane des CMS sur mobile a 29 images et un poids total de 1 263 Ko. Encore une fois, les différences de poids de ces ressources sont très faibles, tant pour les expériences de bureau que pour les expériences mobiles. Le chapitre [Poids de la page](. /page-weight) montre en outre que les ressources en images dépassent largement le poids médian des pages ayant la même quantité d'images sur l'ensemble du Web, qui est de 983 Ko et de 893 Ko pour ordinateur de bureau et pour mobile respectivement. Le verdict : Les pages des CMS envoient des images lourdes.

Quels sont les formats courants que l'on trouve sur les pages CMS sur ordinateur de bureau et mobile ? D'après nos données, les images JPG sont en moyenne le format d'image le plus populaire. Les formats PNG et GIF suivent, tandis que les formats comme SVG, ICO et WebP suivent de manière significative, avec environ un peu plus de 2% et 1%.

{{ figure_markup(
  image="fig14.png",
  caption="Adoption de formats d'images sur les pages CMS.",
  description="Diagramme en bâtons illustrant l'adoption de formats d'images sur les pages CMS pour les ordinateurs de bureau et les mobiles. Le JPEG représente près de la moitié de tous les formats d'image, le PNG en représente un tiers, le GIF un cinquième, et les 5% restants sont partagés entre le SVG, l'ICO et le WebP. Les ordinateurs de bureau et les téléphones portables ont une adoption presque équivalente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=98218771&format=interactive"
  )
}}

Cette segmentation n'est peut-être pas surprenante étant donné les cas d'utilisation courants pour ces types d'images. Les SVG pour les logos et les icônes sont courants, tout comme les JPEG sont omniprésents. Le WebP est encore un format optimisé relativement nouveau avec <a hreflang="en" href="https://caniuse.com/#search=webp">adoption croissante des navigateurs</a>. Il sera intéressant de voir comment cela aura un impact sur son utilisation dans les prochaines années dans le monde des CMS.

## Expérience utilisateur sur les sites web propulsés par des CMS

Le succès en tant que créateur de contenu web est lié à l'expérience utilisateur. Des facteurs tels que l'utilisation des ressources et d'autres statistiques concernant la composition des pages web sont des indicateurs importants de la qualité d'un site en termes de bonnes pratiques suivies lors de sa conception. Cependant, nous souhaitons en fin de compte faire la lumière sur la façon dont les utilisateurs vivent réellement le web lorsqu'ils consomment et s'engagent avec le contenu généré par ces plateformes.

Pour y parvenir, nous orientons notre analyse vers des <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/user-centric-performance-metrics">mesures de performance perçues par les utilisateurs</a>, qui sont enregistrées dans le jeu de données du CrUX. Ces mesures se rapportent d'une certaine manière à <a hreflang="en" href="https://paulbakaus.com/tutorials/performance/the-illusion-of-speed/">la façon dont nous, en tant qu'humains, percevons le temps</a>.

<figure>
  <table>
    <thead>
      <tr>
        <th>Durée</th>
        <th>Perception</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>< 0.1 secondes</td>
        <td>Instant</td>
      </tr>
      <tr>
        <td>0.5-1 seconde</td>
        <td>Immédiat</td>
      </tr>
      <tr>
        <td>2-5 secondes</td>
        <td>Point d'abandon</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Comment les humains perçoivent les courtes durées de temps.") }}</figcaption>
</figure>

Si les événements se produisent dans un délai de 0,1 seconde (100 millisecondes), pour nous tous, ils se produisent pratiquement instantanément. Et lorsque les événements durent plus de quelques secondes, la probabilité que nous poursuivions notre chemin sans attendre plus longtemps est très élevée. C'est très important pour les créateurs de contenu qui cherchent un succès continu sur le Web, car cela nous indique à quelle vitesse nos sites doivent se charger si nous voulons acquérir, engager et conserver notre base d'utilisateurs.

Dans cette section, nous examinons trois dimensions importantes qui peuvent éclairer notre compréhension de la façon dont les utilisateurs font l'expérience des pages web propulsées par les CMS dans la nature :

* First Contentful Paint (FCP)
* First Input Delay (FID)
* Scores Lighthouse

### First Contentful Paint

Le <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/first-contentful-paint">First Contentful Paint</a> mesure le temps qui s'écoule entre le début de la navigation et le premier affichage d'un contenu tel que du texte ou une image. Une expérience FCP réussie, ou pouvant être qualifiée de "rapide", implique la rapidité avec laquelle les éléments du DOM sont chargés pour assurer à l'utilisateur que le site web se charge avec succès. Bien qu'un bon score FCP ne soit pas une garantie que le site correspondant offre un bon UX, un mauvais FCP garantit presque certainement le contraire.

{{ figure_markup(
  image="fig16.png",
  caption="Répartition moyenne des expériences de FCP entre les CMS.",
  description="Diagramme en bâtons de la distribution moyenne des expériences de FCP par CMS. Voir la figure 14.17 ci-dessous pour un tableau des données des cinq CMS les plus populaires.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1644531590&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>Rapide<br>(&lt; 1000ms)</th>
        <th>Moderé</th>
        <th>Lent<br>(&gt;= 3000ms)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">24.33%</td>
        <td class="numeric">40.24%</td>
        <td class="numeric">35.42%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">37.25%</td>
        <td class="numeric">39.39%</td>
        <td class="numeric">23.35%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">22.66%</td>
        <td class="numeric">46.48%</td>
        <td class="numeric">30.86%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">14.25%</td>
        <td class="numeric">62.84%</td>
        <td class="numeric">22.91%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">26.23%</td>
        <td class="numeric">43.79%</td>
        <td class="numeric">29.98%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Répartition moyenne des expériences de FCP entre les CMS.") }}</figcaption>
</figure>

Le FCP dans l'écosystème des CMS tend surtout à se situer dans la plage des valeurs moyennes. La nécessité pour les plateformes CMS d'interroger le contenu d'une base de données, de l'envoyer, puis de le rendre dans le navigateur, pourrait être un facteur qui contribue au retard que connaissent les utilisateurs. Les charges de ressources dont nous avons discuté dans les sections précédentes pourraient également jouer un rôle. De plus, certaines de ces instances sont sur un hébergement partagé ou dans des environnements qui ne sont peut-être pas optimisés pour les performances, ce qui pourrait également avoir un impact sur l'expérience dans le navigateur.

WordPress montre notamment des expériences FCP modérées et lentes sur le mobile et le bureau. Wix se situe fortement dans les expériences FCP moyennes sur sa plateforme propriétaire. TYPO3, une plateforme CMS open-source d'entreprise, a des expériences rapides et constantes sur mobile et sur ordinateur de bureau. TYPO3 annonce des fonctionnalités intégrées de performance et d'évolutivité qui peuvent avoir un impact positif pour les visiteurs du site web en frontend.

### First Input Delay

Le <a hreflang="en" href="https://developers.google.com/web/updates/2018/05/first-input-delay">First Input Delay</a> (FID) mesure le temps écoulé entre le moment où un utilisateur interagit pour la première fois avec votre site (c'est-à-dire lorsqu'il clique sur un lien, tape sur un bouton ou utilise une option paramétrée en JavaScript) et le moment où le navigateur est réellement capable de répondre à cette interaction. Du point de vue de l'utilisateur, un FID "rapide" serait une réponse immédiate à ses actions sur un site plutôt qu'une expérience retardée. Ce délai (un point sensible) pourrait être en corrélation avec l'interférence d'autres aspects du chargement du site lorsque l'utilisateur essaie d'interagir avec le site.

Le FID dans l'écosystème CMS tend généralement vers des expériences rapides à la fois pour les ordinateurs de bureau et les mobiles en moyenne. Cependant, ce qui est remarquable, c'est la différence significative entre les expériences mobiles et sur ordinateur de bureau.

{{ figure_markup(
  image="fig18.png",
  caption="Répartition moyenne des expériences de FID entre les CMS.",
  description="Diagramme en bâtons de la distribution moyenne des expériences de FCP par CMS. Voir la figure 14.19 ci-dessous pour un tableau des données des cinq CMS les plus populaires.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=625179047&format=interactive"
  )
}}

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>Rapide<br>(&lt; 100ms)</th>
        <th>Moderé</th>
        <th>Lent<br>(&gt;= 300ms)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">80.25%</td>
        <td class="numeric">13.55%</td>
        <td class="numeric">6.20%</td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">74.88%</td>
        <td class="numeric">18.64%</td>
        <td class="numeric">6.48%</td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">68.82%</td>
        <td class="numeric">22.61%</td>
        <td class="numeric">8.57%</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">84.55%</td>
        <td class="numeric">9.13%</td>
        <td class="numeric">6.31%</td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">63.06%</td>
        <td class="numeric">16.99%</td>
        <td class="numeric">19.95%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Répartition moyenne des expériences de FID pour les cinq CMS les plus populaires.") }}</figcaption>
</figure>

Bien que cette différence soit présente dans les données du FCP, le FID a des écarts de performances plus importants. Par exemple, la différence entre les expériences FCP rapides pour les téléphones portables et les ordinateurs de bureau pour Joomla est d'environ 12,78 %, pour les expériences FID, la différence est significative : 27,76 %. La qualité des appareils mobiles et des connexions pourrait jouer un rôle dans les écarts de performance que nous constatons ici. Comme nous l'avons souligné précédemment, il y a une petite marge de différence entre les ressources envoyées aux versions ordinateur de bureau et mobile d'un site web. L'optimisation pour l'expérience mobile (interactive) devient plus évidente avec ces résultats.

### Scores Lighthouse

[Lighthouse](./methodology#lighthouse) est un outil automatisé et open-source conçu pour aider les développeurs à évaluer et à améliorer la qualité de leurs sites web. Un aspect clé de l'outil est qu'il fournit un ensemble d'audits pour évaluer le statut d'un site web en termes de **performance**, **accessibilité**, **applications web progressives**, et plus encore. Pour les besoins de ce chapitre, nous nous intéressons à deux catégories de vérifications spécifiques : les PWA et l'accessibilité.

#### PWA

Le terme **Progressive Web App** ([PWA](./pwa)) fait référence aux expériences d'utilisateurs sur le Web qui sont considérées comme étant <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps#reliable">fiables</a>, <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps#fast">rapides</a> et <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps#engaging">engageantes</a>. Lighthouse fournit un ensemble de vérifications qui donnent une note PWA entre 0 ( la plus mauvaise) et 1 ( la meilleure). Ces vérifications sont basées sur la <a hreflang="en" href="https://developers.google.com/web/progressive-web-apps/checklist#baseline">Checklist de référence des PWA</a>, qui contient 14 critères. Lighthouse a automatisé des vérifications pour 11 des 14 exigences. Les trois autres ne peuvent être vérifiées que manuellement. Chacune des 11 vérifications automatisées des PWA a une pondération égale, de sorte que chacune d'entre elles contribue à environ 9 points à votre note PWA.

{{ figure_markup(
  image="fig20.png",
  caption="Distribution des notes Lighthouse de la catégorie PWA pour les pages CMS.",
  description="Diagramme en bâtons montrant la distribution des notes Lighthouse de la catégorie PWA pour toutes les pages CMS. La note la plus fréquente est de 0,3 pour 22 % des pages CMS. Il y a deux autres pics dans la distribution : 11 % des pages avec un score de 0,15 et 8 % des pages avec un score de 0,56. Moins de 1% des pages obtiennent un score supérieur à 0,6.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1812566020&format=interactive"
  )
}}

{{ figure_markup(
  image="fig21.png",
  caption="Notes Lighthouse médianes de la catégorie PWA par CMS.",
  description="Diagramme en bâtons montrant la note médiane Lighthouse PWA par CMS. Le score médian pour les sites web WordPress est de 0,33. Les cinq prochains CMS (Joomla, Drupal, Wix, Squarespace et 1C-Bitrix) ont tous un score médian de 0,3. Les CMS avec les meilleurs scores PWA sont Jimdo avec un score de 0,56 et TYPO3 à 0,41.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1071586621&format=interactive"
  )
}}

#### Accessibilité

Un site web accessible est un site conçu et développé pour que les personnes souffrant d'un handicap puissent les utiliser. Lighthouse fournit un ensemble de vérifications de l'accessibilité et retourne une moyenne pondérée de toutes ces vérifications (voir la section <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1Cxzhy5ecqJCucdf1M0iOzM8mIxNc7mmx107o5nj38Eo/edit#gid=1567011065">Détails des scores</a> pour une liste complète de la pondération de chaque vérification).

Chaque audit d'accessibilité est réussi ou échoué, mais contrairement aux autres audits de Lighthouse, une page ne reçoit pas de points pour avoir partiellement réussi un audit d'accessibilité. Par exemple, si certains éléments ont des noms compréhensibles par les lecteurs d'écran, mais pas d'autres, cette page obtient un 0 pour l'audit *des noms compréhensibles par les lecteurs d'écran*.

{{ figure_markup(
  image="fig22.png",
  caption="Distribution des scores d'accessibilité de Lighthouse pour les pages CMS.",
  description="Diagramme en bâtons montrant la distribution des scores d'accessibilité Lighthouse des pages CMS. La distribution est fortement asymétrique vers les scores les plus élevés avec un mode d'environ 0,85.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=764428981&format=interactive"
  )
}}

{{ figure_markup(
  image="fig23.png",
  caption="Notes médianes Lighthouse d'accessibilité par CMS.",
  description="Diagramme en bâtons montrant la note Lighthouse médiane d'accessibilité par CMS. La plupart des CMS obtiennent un score d'environ 0,75. Parmi les valeurs les plus aberrantes, on retrouve Wix avec un score médian de 0,93 et 1-C Bitrix avec un score de 0,65.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=940747460&format=interactive"
  )
}}

Actuellement, seulement 1,27% des pages d'accueil des CMS sur mobiles obtiennent un score parfait de 100%. Parmi les meilleurs CMS, Wix prend la tête en ayant le plus haut score médian d'accessibilité sur ses pages mobiles. Dans l'ensemble, ces chiffres sont lamentables quand on considère le nombre de sites web (la part du web qui est propulsée par des CMS) qui sont inaccessibles à un segment significatif de notre population. Autant les expériences numériques ont un impact sur de nombreux aspects de notre vie, autant cela devrait être un impératif pour nous encourager à *construire des expériences web accessibles dès le départ*, et à poursuivre le travail pour faire du web un espace inclusif.

## Innovation en matière de CMS

Bien que nous ayons pris un instantané du paysage actuel de l'écosystème des CMS, celui-ci est en pleine évolution. Dans le cadre des efforts visant à remédier aux lacunes en matière de [performance](./performance) et d'expérience utilisateur, nous constatons que des systèmes expérimentaux sont intégrés à l'infrastructure des CMS à la fois dans des cas couplés et découplés/headless. Des bibliothèques et des frameworks tels que React.js, ses dérivés comme Gatsby.js et Next.js, et le dérivé Nuxt.js de Vue.js font de légères avancées.

<figure>
  <table>
    <thead>
      <tr>
        <th>CMS</th>
        <th>React</th>
        <th>Nuxt.js,<br>React</th>
        <th>Nuxt.js</th>
        <th>Next.js,<br>React</th>
        <th>Gatsby,<br>React</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WordPress</td>
        <td class="numeric">131,507</td>
        <td class="numeric"></td>
        <td class="numeric">21</td>
        <td class="numeric">18</td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Wix</td>
        <td class="numeric">50,247</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Joomla</td>
        <td class="numeric">3,457</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Drupal</td>
        <td class="numeric">2,940</td>
        <td class="numeric"></td>
        <td class="numeric">8</td>
        <td class="numeric">15</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>DataLife Engine</td>
        <td class="numeric">1,137</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Adobe Experience Manager</td>
        <td class="numeric">723</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric">7</td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Contentful</td>
        <td class="numeric">492</td>
        <td class="numeric">7</td>
        <td class="numeric">114</td>
        <td class="numeric">909</td>
        <td class="numeric">394</td>
      </tr>
      <tr>
        <td>Squarespace</td>
        <td class="numeric">385</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">340</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>TYPO3 CMS</td>
        <td class="numeric">265</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric">1</td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Weebly</td>
        <td class="numeric">263</td>
        <td class="numeric"></td>
        <td class="numeric">1</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Jimdo</td>
        <td class="numeric">248</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric">2</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">223</td>
        <td class="numeric"></td>
        <td class="numeric">1</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>SDL Tridion</td>
        <td class="numeric">152</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
      <tr>
        <td>Craft CMS</td>
        <td class="numeric">123</td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
        <td class="numeric"></td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Adoption (nombre de sites web mobiles) de React et des frameworks connexes par CMS.") }}</figcaption>
</figure>

Nous voyons également des fournisseurs et des agences d'hébergement offrant des plateformes d'expérience numérique (DXP) comme solutions holistiques utilisant des CMS et d'autres technologies intégrées comme boîte à outils pour les stratégies d'entreprise axées sur le client. Ces innovations témoignent d'un effort pour créer des solutions clés en main, basées sur des CMS, qui permettent aux utilisateurs (et leurs utilisateurs finaux) d'obtenir par défaut le meilleur UX lors de la création et de la consommation du contenu de ces plateformes. L'objectif: de bonnes performances par défaut, une richesse de fonctionnalités et d'excellents environnements d'hébergement.

## Conclusions

L'espace des CMS est d'une importance primordiale. La grande partie du web dont ces applications propulsent et la masse critique d'utilisateurs qui créent et consultent ses pages sur une variété de terminaux et de connexions ne doivent pas être banalisées. Nous espérons que ce chapitre et les autres qui se trouvent ici dans le Web Almanac inspireront plus de recherche et d'innovation pour aider à rendre cet espace meilleur. Des enquêtes approfondies nous fourniraient un meilleur contexte sur les forces, les faiblesses et les opportunités que ces plateformes offrent au web dans son ensemble. Les systèmes de gestion de contenu peuvent avoir un impact sur la préservation de l'intégrité du web ouvert. Continuons à les faire avancer !
