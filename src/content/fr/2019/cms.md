---
part_number: III
chapter_number: 14
title: CMS
description: Chapitre CMS de l'Almanach Web 2019 couvrant l'adoption des CMS, la façon dont les solutions CMS sont construites, l'expérience utilisateur des sites web propulsés par les CMS et l'innovation des CMS.
authors: [ernee, amedina]
reviewers: []
translators: [JustinyAhin]
discuss: 
published: 
last_updated: 
---

## Introduction

Le terme général **Système de gestion de contenu (SGC)** désigne les systèmes permettant aux personnes et aux organisations de créer, de gérer et de publier du contenu. Un CMS pour le contenu web, plus précisément, est un système visant à créer, gérer et publier du contenu à consommer et à expérimenter via le web ouvert.

Chaque CMS met en œuvre un sous-ensemble d'un large éventail de capacités de gestion de contenu et les mécanismes correspondants pour permettre aux utilisateurs de construire facilement et efficacement des sites web autour de leur contenu. Ce contenu est souvent stocké dans un certain type de base de données, ce qui permet aux utilisateurs de le réutiliser partout où cela est nécessaire pour leur stratégie de contenu. Les CMS offrent également des capacités d'administration visant à faciliter le téléversement et la gestion du contenu par les utilisateurs, selon leurs besoins.

Le type et la portée du support fourni par les CMS pour la construction de sites varient considérablement; certains fournissent des modèles prêts à l'emploi qui sont "hydratés" par le contenu de l'utilisateur, et d'autres exigent une participation beaucoup plus importante de l'utilisateur pour la conception et la construction de la structure du site.

Lorsque nous parlons des CMS, nous devons tenir compte de tous les éléments qui jouent un rôle dans la viabilité d'un tel système pour fournir une plate-forme de publication de contenu sur le web. Tous ces composants forment un écosystème autour de la plate-forme du CMS, et ils incluent les fournisseurs d'hébergement, les développeurs d'extension, les agences de développement, les constructeurs de sites, etc. Ainsi, lorsque nous parlons d'un CMS, nous faisons généralement référence à la fois à la plate-forme elle-même et à l'écosystème qui l'entoure.

### Pourquoi les créateurs de contenu utilisent-ils un CMS ?

Au début des temps ("de l'évolution du web"), l'écosystème du web était alimenté par une simple boucle de croissance, où les utilisateurs pouvaient devenir des créateurs simplement en visualisant la source d'une page web, en faisant du copier-coller selon leurs besoins, et en adaptant la nouvelle version avec des éléments individuels comme des images.

Au fur et à mesure de son évolution, le web est devenu plus puissant, mais aussi plus compliqué. En conséquence, cette simple boucle de croissance a été rompue et il n'était plus possible que n'importe quel utilisateur devienne un créateur. Pour ceux qui pouvaient poursuivre le chemin de la création de contenu, la route devenait ardue et difficile à parcourir. Le [fossé des capacités d'utilisation] (https://medinathoughts.com/2018/05/17/progressive-wordpress/), c'est-à-dire la différence entre ce qui peut être fait sur le web et ce qui est réellement fait, a augmenté régulièrement.

<figure>
  <a href="/static/images/2019/14_CMS/web-evolution.png">
    <img src="/static/images/2019/14_CMS/web-evolution.png" aria-labelledby="fig1-caption" aria-describedby="fig1-description" alt="Figure 1. Chart illustrating the increase in web capabilities from 1999 to 2018." width="600">
  </a>
  <div id="fig1-description" class="visually-hidden">On the left, labeled circa 1999, we have a bar chart with two bars showing what can be done is close to what is actually done. On the right, labeled 2018, we have a similar bar chart but what can be done is much larger, and what is done is slightly larger. The gap between what can be done and what is actually done has greatly increased.</div>
  <figcaption id="fig1-caption">Figure 1. Chart illustrating the increase in web capabilities from 1999 to 2018.</figcaption>
</figure>

C'est ici qu'un CMS joue un rôle très important en permettant à des utilisateurs ayant différents degrés d'expertise technique d'entrer facilement dans la boucle de l'écosystème web en tant que créateurs de contenu. En abaissant la barrière d'entrée pour la création de contenu, les CMS activent la boucle de croissance du web en transformant les utilisateurs en créateurs. D'où leur popularité.

### L'objectif de ce chapitre

Il y a beaucoup d'aspects intéressants et importants à analyser et de questions auxquelles répondre dans notre quête pour comprendre le monde des CMS et son rôle dans le présent et le futur du web. Bien que nous reconnaissions l'immensité et la complexité du monde des plateformes CMS, et que nous ne revendiquions pas une connaissance omnisciente couvrant tous les aspects impliqués sur toutes les plateformes CMS, nous revendiquons notre fascination pour cet univers et nous apportons une expertise approfondie sur certains de ses acteurs principaux.

Dans ce chapitre, nous cherchons à explorer la surface du vaste univers des CMS, en essayant d'éclairer notre compréhension collective du statu quo des ses écosystèmes et du rôle qu'ils jouent dans la perception des utilisateurs sur la façon dont le contenu peut être consommé et expérimenté sur le web. Notre but n'est pas de fournir une vue exhaustive du paysage des CMS ; nous allons plutôt discuter de quelques aspects liés au paysage des CMS en général, et des caractéristiques des pages web générées par ces systèmes. Cette première édition du Web Almanac établit une base de référence, et à l'avenir nous aurons l'avantage de pouvoir comparer les données avec cette version pour l'analyse des tendances.

## Adoption des CMS

<figure>
  <div class="big-number">40%</div>
  <figcaption>Figure 2. Percent of web pages powered by a CMS.</figcaption>
</figure>

Aujourd'hui, nous remarquons que plus de 40% des pages web sont propulsées par une plateforme CMS ; 40.01% pour les mobiles et 39.61% pour les desktop plus précisément.

Il existe d'autres ensembles de données qui suivent la part de marché des plateformes CMS, comme [W3Techs](https://w3techs.com/technologies/history_overview/content_management), et ils reflètent des pourcentages plus élevés de plus de 50% de pages web propulsées par des plateformes CMS. De plus, ils indiquent également que les plateformes CMS sont en expansion, jusqu'à 12 % de croissance d'une année à l'autre dans certains cas ! L'écart entre notre analyse et celle de W3Tech pourrait s'expliquer par une différence dans les méthodologies de recherche. Vous pouvez en lire plus sur la nôtre sur la page [Méthodologie](./methodology).

En gros, cela signifie qu'il existe de nombreuses plateformes CMS disponibles sur le marché. L'image suivante montre une vue réduite du paysage CMS.

<figure>
  <a href="/static/images/2019/14_CMS/cms-logos.png">
    <img src="/static/images/2019/14_CMS/cms-logos.png" aria-labelledby="fig3-caption" aria-describedby="fig3-description" alt="Figure 3. The top content management systems." width="600">
  </a>
  <div id="fig3-description" class="visually-hidden">Logos of the top CMS providers, including WordPress, Drupal, Wix, etc.</div>
  <figcaption id="fig3-caption">Figure 3. The top content management systems.</figcaption>
</figure>

Certains d'entre eux sont open source (par exemple WordPress, Drupal, et autres) et d'autres sont propriétaires ( comme AEM, et autres). Certaines plates-formes CMS peuvent être utilisées sur des formules "gratuites" hébergées ou auto-hébergées, et il existe également des options avancées pour utiliser ces plates-formes sur des formules de niveau supérieur, y compris au sein des entreprises. Dans son ensemble, le secteur des CMS est un univers complexe et fédéré d' *écosystèmes CMS*, tous séparés et en même temps entrelacés dans le vaste tissu du web.

Cela signifie également qu'il y a des centaines de millions de sites web propulsés par des plateformes CMS, et un ordre de grandeur plus élevé d'utilisateurs accédant au web et consommant du contenu à travers ces plateformes. Ainsi, ces plateformes jouent un rôle clé pour nous permettre de réussir dans notre quête collective d'un web toujours vert, sain et dynamique. 

### Le paysage des CMS

Une grande partie du web aujourd'hui est alimentée par un type de plateforme CMS ou un autre. Il existe des statistiques recueillies par différentes organisations qui reflètent cette réalité. En regardant les jeux de données [Chrome UX Report](./methodology#chrome-ux-report) (CrUX) et HTTP Archive, nous arrivons à une image qui est cohérente avec les statistiques publiées ailleurs, bien que quantitativement les proportions décrites puissent être différentes en tant que reflet de la spécificité des jeux de données.

En examinant les pages web servies sur les appareils de bureau et mobiles, nous observons une répartition approximative de 60-40 dans le pourcentage de ces pages qui ont été générées par une sorte de plateforme CMS, et celles qui ne le sont pas.

<figure>
  <a href="/static/images/2019/14_CMS/fig4.png">
    <img src="/static/images/2019/14_CMS/fig4.png" alt="Figure 4. Percent of desktop and mobile websites that use a CMS." aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1644425372&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">Bar chart showing that 40% of desktop and 40% of mobile websites are built using a CMS.</div>
  <figcaption id="fig4-caption">Figure 4. Percent of desktop and mobile websites that use a CMS.</figcaption>
</figure>

Les pages web propulsées par les CMS sont générées par un large ensemble des plateformes CMS existantes. Le choix de ces plateformes est très vaste, et de nombreux facteurs peuvent être pris en compte lorsqu'on décide d'utiliser l'une ou l'autre, notamment:

* Fonctionnalité de base
* Création/édition de workflows et expérience
* Barrière d'entrée
* Possibilité de personnalisation
* Communauté
* Et beaucoup d'autres.

Les jeux de données CrUX et HTTP Archive contiennent des pages web propulsées par un ensemble d'environ 103 plateformes CMS. La plupart de ces plates-formes sont très petites en termes de part de marché relative. Pour les besoins de notre analyse, nous nous concentrerons sur les principales plates-formes CMS en termes de leur impact sur le web, tel que reflété par les données. Pour une analyse complète, [voir la feuille de calcul des résultats de ce chapitre] (https://docs.google.com/spreadsheets/d/1FDYe6QdoY3UtXodE2estTdwMsTG-hHNrOe9wEYLlwAw/edit#gid=0).

<figure>
  <a href="/static/images/2019/14_CMS/fig5.png">
    <img src="/static/images/2019/14_CMS/fig5.png" alt="Figure 5. Top CMS platforms as a percent of all CMS websites." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" data-data-width="600" data-height="600" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=1652315665&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">Bar chart showing WordPress making up 75% of all CMS websites. The next biggest CMS, Drupal, has about 6% of the CMS market share. The rest of the CMSs quickly shrink in adoption to less than 1%.</div>
  <figcaption id="fig5-caption">Figure 5. Top CMS platforms as a percent of all CMS websites.</figcaption>
</figure>
 
Les principales plates-formes CMS présentes dans les jeux de données sont indiquées ci-dessus à la figure 5. WordPress est utilisé par 74,19 % des sites web utilisant un CMS pour les téléphones mobiles et 73,47 % des sites web utilisant un CMS pour les ordinateurs de bureau. Sa domination dans le milieu des CMS peut être attribuée à un certain nombre de facteurs dont nous parlerons plus loin, mais c'est un acteur _major_. Les plateformes open source comme Drupal et Joomla, et les solutions SaaS propriétaires comme Squarespace et Wix, complètent le top 5 des CMS. La diversité de ces plateformes reflète l'écosystème des CMS, composé de nombreuses plateformes où la démographie des utilisateurs et le parcours de création de sites web varient. Ce qui est également intéressant, c'est la longue liste des plateformes CMS de petites tailles qui se trouvent dans le top 20. Des offres d'entreprise aux applications propriétaires développées en interne pour une utilisation spécifique à un secteur, les systèmes de gestion de contenu fournissent une infrastructure personnalisable permettant aux groupes de gérer, de publier et de faire des affaires sur le web. 

Le [projet WordPress] (https://fr.wordpress.org/about/) définit sa mission en ces termes : "*démocratiser la publication*". Certains de ses principaux objectifs sont de faciliter l'utilisation et de rendre le logiciel libre et disponible à tous pour créer du contenu sur le web. Un autre élément important est la communauté inclusive que le projet promeut. Dans presque toutes les grandes villes du monde, on peut trouver un groupe de personnes qui se réunissent régulièrement pour se rencontrer, partager et coder dans un effort de compréhension et de construction sur la plate-forme WordPress. La participation aux rencontres locales et aux événements annuels, ainsi que la participation aux réseaux basés sur le web sont quelques unes des façons dont les contributeurs, les experts, les entreprises et les passionnés de WordPress participent à sa communauté globale.

La faible barrière d'entrée et les ressources pour aider les utilisateurs (en ligne et en personne) à publier sur la plateforme et à développer des extensions (plugins) et des thèmes contribuent à sa popularité. La disponibilité et l'économie autour des extensions et des thèmes WordPress contribuent également à réduire la complexité dans la mise en œuvre de la conception et des fonctionnalités web recherchées. Non seulement ces aspects favorisent sa portée et son adoption par les nouveaux venus, mais ils permettent également de maintenir au fil du temps son utilisation régulière. 

La plateforme open source WordPress est propulsée et soutenue par des bénévoles, la WordPress Foundation, et des acteurs majeurs de l'écosystème web. En gardant ces facteurs à l'esprit, le fait que WordPress soit le principal système de gestion de contenu (CMS) est tout à fait logique.

## Comment sont construits les sites propulsés par un CMS

Indépendamment des nuances spécifiques et des particularités des différentes plateformes CMS, leur objectif final est de produire des pages web qui seront mises à la disposition des utilisateurs par le biais de la vaste portée du web ouvert. La différence entre les pages web propulsées par un CMS et celles qui ne le sont pas est que dans le premier cas, la plate-forme CMS prend la plupart des décisions sur la façon dont le résultat final est construit, tandis que dans le second, il n'y a pas de telles couches d'abstraction et les décisions sont toutes prises par les développeurs, soit directement, soit via des configurations de bibliothèques. 

Dans cette section, nous examinons brièvement le statu quo de l'espace CMS en termes de caractéristiques de leur résultat (par exemple, les ressources totales utilisées, les statistiques sur les images, entre autres), et nous les comparons avec celles de l'écosystème web en général.

### Utilisation totale des ressources

Les éléments de base de tout site web constituent également un site web géré par un CMS : [HTML](. /markup), [CSS](. /css), [JavaScript](. /javascript), et [media](. /media) (images et vidéo). Les CMS offrent aux utilisateurs des fonctionnalités de gestion puissamment optimisées pour intégrer ces ressources afin de créer des expériences web. Bien que ce soit l'un des aspects les plus inclusifs de ces applications, il est possible qu'il ait des effets négatifs sur le web en général.

<figure>
  <a href="/static/images/2019/14_CMS/fig6.png">
    <img src="/static/images/2019/14_CMS/fig6.png" alt="Figure 6. Distribution of CMS page weight." aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=991628102&amp;format=interactive">
  </a>
  <div id="fig6-description" class="visually-hidden">Bar chart showing the distribution of CMS page weight. The median desktop CMS page weighs 2.3 MB. At the 10th percentile it is 0.7 MB, 25th percentile 1.2 MB, 75th percentile 4.2 MB, and 90th percentile 7.4 MB. Desktop values are very slightly higher than mobile.</div>
  <figcaption id="fig6-caption">Figure 6. Distribution of CMS page weight.</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/14_CMS/fig7.png">
    <img src="/static/images/2019/14_CMS/fig7.png" alt="Figure 7. Distribution of CMS requests per page." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlIvQce5DSZ4KnDyHErJhLJvnond89U_cNFewvtIhI2uV4Ff4og0e7X8bRFO28eBGKJ2uYlJyXLUBH/pubchart?oid=140872807&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">Bar chart showing the distribution of CMS requests per page. The median desktop CMS page loads 86 resources. At the 10th percentile it loads 39 resources, 25th percentile 57 resources, 75th percentile 127 resources, and 90th percentile 183 resources. Desktop is consistently higher than mobile by a small margin of 3-6 resources.</div>
  <figcaption id="fig7-caption">Figure 7. Distribution of CMS requests per page.</figcaption>
</figure>

Dans les figures 6 et 7 ci-dessus, nous voyons que la page médiane sur un CMS sur un desktop charge 86 ressources et pèse 2,29 Mo. L'utilisation des ressources des pages mobiles n'est pas très loin derrière avec 83 ressources et 2,25 Mo.

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
  <figcaption>Figure 8. Distribution of desktop CMS page kilobytes per resource type.</figcaption>
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
  <figcaption>Figure 9. Distribution of mobile CMS page kilobytes per resource type.</figcaption>
</figure>

Lorsque nous regardons de plus près les types de ressources qui se chargent sur les pages sur les CMS sur mobile ou sur desktop, les images et la vidéo apparaissent immédiatement comme les principaux contributeurs à leur poids.

L'impact n'est pas nécessairement en corrélation avec le nombre de requêtes, mais plutôt avec la quantité de données associées à ces requêtes individuelles. Par exemple, dans le cas des ressources vidéo dont seulement deux demandes sont faites à la médiane, elles ont un poids de plus de 1Mo. Les expériences multimédias s'accompagnent également de l'utilisation de scripts pour intégrer l'interactivité, fournir des fonctionnalités et des données, pour ne citer que quelques cas d'utilisation. Sur les pages mobiles comme sur les pages desktop, ces ressources sont les troisièmes plus lourdes.

Avec nos expériences des CMS qui sont saturées de ces ressources, nous devons considérer l'impact que cela a sur les visiteurs du site web sur le front-end - leur expérience est-elle rapide ou lente ? De plus, lorsque l'on compare l'utilisation des ressources mobiles et desktop, la quantité de requêtes et le poids ne montrent que peu de différence. Cela signifie que la même quantité et le même poids de ressources alimentent à la fois les expériences CMS sur mobile et sur desktop. La variation de la vitesse de connexion et de la qualité des appareils mobiles ajoute [une autre couche de complexité] (https://medinathoughts.com/2017/12/03/the-perils-of-mobile-web-performance-part-iii/). Plus tard dans ce chapitre, nous utiliserons les données du CrUX pour évaluer l'expérience des utilisateurs dans l'écosystème des CMS.
### Ressources tierces

Soulignons un sous-ensemble spécifique de ressources pour évaluer leur impact dans l'écosystème des CMS. Les ressources [Tierce partie](./third-parties) sont celles qui proviennent d'origines n'appartenant pas au nom de domaine ou aux serveurs du site de destination. Elles peuvent être des images, des vidéos, des scripts ou d'autres types de ressources. Parfois, ces ressources sont combinées entre elles, comme par exemple avec l'intégration d'une `iframe`. Nos données révèlent que la quantité médiane de ressources tierces sur desktop et sur mobile est très similaire.

La quantité médiane de requêtes tierces sur les pages CMS mobiles est de 15 et pèse 264,72 Ko, tandis que la médiane de ces requêtes sur les pages CMS desktop est de 16 et pèse 271,56 Ko. (Il est à noter que cela exclut les ressources 3P considérées comme faisant partie de l'"hébergement").
