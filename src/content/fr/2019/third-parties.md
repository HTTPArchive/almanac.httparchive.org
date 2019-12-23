---
part_number: II
chapter_number: 5
title: Tierces Parties
description: Le chapitre sur les ressources tierces du Web Almanac 2019, qui aborde les tierces parties utilisées, pourquoi elles le sont et les répercussions de leur usage sur le rendu et la confidentialité.
authors: [patrickhulce]
reviewers: [zcorpan, obto, jasti]
translators: [borisschapira]
discuss: 1760
published: 2019-12-23T00:00:00.000Z
last_updated: 2019-12-23T00:00:00.000Z
---

## Introduction

Le web ouvert a été conçu pour être vaste, interconnectable et interopérable. La possibilité d’accéder à de puissantes librairies tierces et de les utiliser sur votre site avec des éléments `<link>` ou `<script>` a décuplé la productivité des développeurs et permis de nouvelles et incroyables expériences web. Par contre, l’immense popularité de quelques fournisseurs tiers pose d’importants problèmes en termes de performances et de confidentialité. Ce chapitre examine la prévalence et l’impact du code tiers sur le web en 2019, les modèles d’utilisation du web qui mènent à la popularité des solutions tierces et les répercussions potentielles sur l’avenir des expériences sur le web.

## Définitions

### "Tierce partie"

Une tierce partie est une entité extérieure à la relation principale entre le site et l’utilisateur. Autrement dit, tous les aspects du site qui ne sont pas directement sous le contrôle du propriétaire du site mais qui sont présents avec son approbation. Par exemple, le script Google Analytics est un exemple de ressource tierce courante.

Les ressources tierces sont :

- Hébergées sur une origine _partagée_ et _publique_.
- Largement utilisées par une variété de sites
- Aucunement influencées par un propriétaire de site individuel

Pour se rapprocher le plus possible de ces objectifs, la définition formelle utilisée tout au long de ce chapitre d’une ressource tierce est une ressource qui provient d’un domaine dont les ressources se trouvent sur au moins 50 pages uniques dans le jeu de données HTTP Archive.

Notez qu’en utilisant ces définitions, le contenu de tiers servi à partir d’un domaine "en propre" est considéré comme du contenu de première partie. Par exemple, les polices Google ou bootstrap.css auto-hébergées sont considérées comme du contenu de première partie. De même, le contenu de première partie servi à partir d’un domaine tiers est considéré comme du contenu tiers. Par exemple, les images de première partie diffusées via un CDN sur un domaine tiers sont considérées comme du contenu tiers.

### Catégories de fournisseurs

Le présent chapitre classe les fournisseurs tiers dans l’une de ces grandes catégories. Une brève description est incluse ci-dessous et la correspondance entre chaque domaine et sa catégorie peut être trouvée dans le [dépôt third-party-web](https://github.com/patrickhulce/third-party-web/blob/8afa2d8cadddec8f0db39e7d715c07e85fb0f8ec/data/entities.json5).

- **Publicité (Ad)** - affichage et mesures relatives aux annonces
- **Télémétrie (Analytics)** - suivi du comportement des visiteurs du site
- **CDN** - fournisseurs de services communément utilisés, publics comme privés
- **Contenu (Content)** - fournisseurs qui facilitent la tâche des éditeurs et hébergent du contenu syndiqué
- **Relation Client (Customer Success)** - fonctionnalités de support et de gestion de la relation client
- **Hébergement (Hosting)** - fournisseurs qui hébergent n’importe quel contenu de leurs utilisateurs
- **Marketing** - fonctionnalités de vente, de génération de prospects et d’email marketing
- **Social** - réseaux sociaux et leurs intégrations affiliées
- **Gestionnaires de tags (Tag Manager)** - fournisseur dont le seul rôle est de gérer l’inclusion d’autres tiers
- **Services (Utility)** - code qui contribue à la réalisation des objectifs du propriétaire du site en termes de services
- **Video** - fournisseurs qui hébergent un contenu vidéo quelconque de leurs utilisateurs
- **Autre (Other)** - activité non classée ou considérée comme non conforme

<aside>
  <strong>Note sur les CDN</strong> : d’après les critères que nous utilisons, seuls sont comptabilisés dans la catégorie CDN les fournisseurs qui fournissent des ressources sur des domaines de CDN <strong>publics</strong> (par exemple bootstrapcdn.com, cdnjs.cloudflare.com, etc.). Cela n’inclut <strong>pas</strong> les ressources qui sont simplement servies sur un CDN. Exemple : même si vous mettez Cloudflare devant une page, nous la considérerons comme une première partie.
</aside>

### Quelques réserves

- Toutes les données présentées ici sont basées sur une sollicitation à froid, sans interaction. Ces valeurs seraient rapidement très différentes après l’interaction d’un utilisateur ou d’une utilisatrice.
- Environ 84 % de tous les domaines tiers (en volume) ont été identifiés et catégorisés. Les 16 % restants appartiennent à la catégorie "Autres".

## Données

<figure>
  <div class="big-number">93,59 %</div>
  <figcaption>Figure 1. Pourcentage des pages destinées aux ordinateurs de bureau qui comprennent au moins une ressource tierce.</figcaption>
</figure>

Le code tiers est partout. 93 % des pages comprennent au moins une ressource tierce, 76 % des pages émettent une requête vers un domaine de télémétrie, une page requête, en médiane, du contenu en provenance d’au moins 9 domaines tiers _uniques_, ce qui représente 35 % de l’activité réseau totale. 10 % des pages, les plus "actives", émettent plus de 175 requêtes vers des ressources tierces. Il n’est pas exagéré de dire que les tierces parties font partie intégrante du web.

<figure>
  <div class="big-number">55,63 %</div>
  <figcaption>Figure 2. Pourcentage de pages destinées aux ordinateurs de bureau qui comprennent au moins une ressource publicitaire.</figcaption>
</figure>

### Catégories

Si l’omniprésence du contenu tiers n’est pas surprenante, la répartition du contenu de tiers par type de fournisseur est peut-être plus intéressante.

Alors que la publicité pourrait être l’exemple le plus visible de contenus tiers sur le web, les fournisseurs de services de télémétrie sont la catégorie de tiers la plus courante avec 76 % des sites incluant au moins une requête de ce type. Les CDN à 63 %, les annonces à 57 %, et les services comme Sentry, Stripe et Google Maps SDK à 56 % suivent de près en deuxième, troisième et quatrième position pour apparaître sur la plupart des plate-formes web. La popularité de ces catégories constitue le fondement de nos usage sur le web, décrits plus loin dans ce chapitre.

### Fournisseurs

Un nombre relativement restreint de fournisseurs dominent le paysage des services tiers : les 100 premiers domaines représentent 30 % des requêtes réseau sur le web. Des moteurs comme Google, Facebook et YouTube sont en tête avec des pourcentages entiers de parts de marché chacun, mais des entités plus petites comme Wix et Shopify représentent aussi une partie substantielle de la popularité des tiers.

Bien que l’on puisse dire beaucoup de choses sur la popularité et l’impact de chaque fournisseur sur la performance, nous laissons au lecteur et à d’autres outils conçus à cet effet, tels que [third-party-web](https://thirdpartyweb.today), le soin de faire faire une analyse plus objective de ces questions.

<figure markdown>
Rang | Domaines tiers | Pourcentage des requêtes
-- | -- | --
1 | `fonts.gstatic.com` | 2,53 %
2 | `www.facebook.com` | 2,38 %
3 | `www.google-analytics.com` | 1,71 %
4 | `www.google.com` | 1,17 %
5 | `fonts.googleapis.com` | 1,05 %
6 | `www.youtube.com` | 0,99 %
7 | `connect.facebook.net` | 0,97 %
8 | `googleads.g.doubleclick.net` | 0,93 %
9 | `cdn.shopify.com` | 0,76 %
10 | `maps.googleapis.com` | 0,75 %

<figcaption>Figure 3. Top 10 des domaines tiers les plus populaires.</figcaption>
</figure>

<figure markdown>
Rang | URL de ressource tierce | Pourcentage des requêtes
-- | -- | --
1 | `https://www.google-analytics.com/analytics.js` | 0,64 %
2 | `https://connect.facebook.net/en_US/fbevents.js` | 0,20 %
3 | `https://connect.facebook.net/signals/plugins/inferredEvents.js ?v=2.8.51` | 0,19 %
4 | `https://staticxx.facebook.com/connect/xd_arbiter.php ?version=44` | 0,16 %
5 | `https://fonts.gstatic.com/s/opensans/v16/mem8YaGs126MiZpBA-UFVZ0b.woff2` | 0,13 %
6 | `https://www.googletagservices.com/activeview/js/current/osd.js ?cb=%2Fr20100101` | 0,12 %
7 | `https://fonts.gstatic.com/s/roboto/v18/KFOmCnqEu92Fr1Mu4mxK.woff2` | 0,11 %
8 | `https://googleads.g.doubleclick.net/pagead/id` | 0,11 %
9 | `https://fonts.gstatic.com/s/roboto/v19/KFOmCnqEu92Fr1Mu4mxK.woff2` | 0,10 %
10 | `https://www.googleadservices.com/pagead/conversion_async.js` | 0,10 %

<figcaption>Figure 4. Top 10 des requêtes les plus populaires.</figcaption>
</figure>

### Types de ressources

La répartition du volume de contenu par type de ressource donne également un aperçu de la façon dont le code tiers est utilisé sur le web. Alors que les requêtes sur le domaine principal sont composées à 56 % d’images, à 23 % de scripts, à 14 % de CSS, et seulement à 4 % de HTML, les requêtes vers des domaines tiers contienne davantage de scripts et de code HTML (32 % de scripts, 34 % d’images, 12 % HTML, et seulement 6 % de CSS). On pourrait penser que le code d’une tierce partie est moins souvent utilisé pour faciliter la conception et plus fréquemment pour faciliter ou observer les interactions que le code du domaine principal, mais une ventilation des types de ressources par type de tierce partie apporte de la nuance à cette idée. Alors que les CSS et les images sont majoritairement issus du domaine principal (respectivement 70 % et 64 %), les polices sont largement servies par des fournisseurs tiers, avec seulement 28 % provenant du domaie principal. Nous explorerons plus en détails ces usages plus loin dans ce chapitre.

<figure>
  <a href="/static/images/2019/05_Third_Parties/fig5.png">
    <img src="/static/images/2019/05_Third_Parties/fig5.png" alt="Figure 5. Pourcentage de requêtes de ressources tierces par catégorie et par type de contenu." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="600" data-width="600" data-height="387" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRO5jS8JpjYdTr9poYmpyw-BL1LPQtfzHx_1hLRk9lgwkHQERuyELgF_rQ-4CpTbdbAyI9u1ggtPlLQ/pubchart ?oid=488955458&amp ;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">Graphique montrant la répartition des types de contenu pour chaque catégorie de tiers. Les images et les scripts constituent la majorité des requêtes pour chaque catégorie. Les requêtes CDN présentent une proportion particulièrement importante de polices d’écriture.</div>
  <figcaption id="fig5-caption">Figure 5. Pourcentage de requêtes de ressources tierces par catégorie et par type de contenu.</figcaption>
</figure>

Ces données regorgent d’autres faits amusants. Les pixels de suivi (requêtes d’images situées sur des domaines de télémétrie) représentent 1,6 % de toutes les requêtes réseau. Les réseaux sociaux comme Facebook et Twitter délivrent six fois plus de vidéos que les fournisseurs dédiés comme YouTube et Vimeo (probablement parce que l’intégration par défaut de YouTube est composée d’un peu de HTML et d’une prévisualisation mais pas une vidéo en lecture automatique). Enfin, il existe plus de requêtes pour des images du domaine principal que tous les scripts combinés.

### Nombre de requêtes

49 % de toutes les requêtes pointent vers des tiers. Avec 51 %, le domaine principal conserve garde donc la tête, puisqu’il héberge la moitié des ressources web. Mais les sites qui utilisent des ressources tierces doivent le faire de manière importante car même si un peu moins de la moitié de toutes les requêtes proviennent de tiers, un petit nombre de pages n’en référencent pas du tout. En détails : aux 75e, 90e et 99e percentiles, la quasi-totalité de la page est constituée de contenu de tiers. En fait, pour certains sites s’appuyant fortement sur des plates-formes WYSIWYG distribuées comme Wix et SquareSpace, le document racine est parfois la seule requête sur le domaine principal !

< !-- insert graphic of metric 05_11 -->

Le nombre de demandes émises par chaque fournisseur tiers varie aussi considérablement selon la catégorie. Bien que les services de télémétrie soient la catégorie de tiers la plus répandue sur les sites web, ils ne représentent que 7 % de toutes les requêtes réseau vers des tiers. Les publicités, en revanche, se trouvent sur environ 20 % de sites en moins, mais elles représentent 25 % de toutes les requêtes réseau vers des tiers. L’impact disproportionné de leurs ressources par rapport à leur popularité sera un thème que nous ne manquerons pas d’approfondir dans les données restantes.

### Poids en octets

Bien que 49 % des requêtes proviennent de tiers, leur part sur le web en termes d’octets est un peu plus faible, atteignant seulement 28 %. Il en va de même pour la répartition par types de ressources. Les polices d’écriture tierces représentent 72 % de toutes les polices d’écritures, mais seulement 53 % des octets correspondant aux polices d’écriture ; 74 % des requêtes concernent des documents HTML tiers, mais ils ne représentent que 39 % des octets HTML ; 68 % des requêtes vidéo viennent de tiers, mais ne représentent que 31 % des octets vidéo. Tout cela semble indiquer que les fournisseurs tiers sont des intendants responsables qui maintiennent la taille de leurs réponses à un niveau bas. Dans la plupart des cas, c’est effectivement. Enfin, jusqu’à ce que vous examiniez les scripts.

Bien qu’ils servent 57 % des scripts, les tiers représentent 64 % des octets de script, ce qui signifie que leurs scripts sont en moyenne plus volumineux que les scripts des domaines principaux. C’est un signe avant-coureur de l’impact de leurs performances qui sera présenté dans les prochaines sections.

<figure>
  <a href="/static/images/2019/05_Third_Parties/fig7.png">
    <img src="/static/images/2019/05_Third_Parties/fig7.png" alt="Figure 7. Répartition des octets de ressource par catégorie de tiers." aria-labelledby="fig7-caption" aria-describedby="fig7-description"  width="600" data-width="600" data-height="387" data-seamless data-frameborder="0" data-scrolling="no" data-src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRO5jS8JpjYdTr9poYmpyw-BL1LPQtfzHx_1hLRk9lgwkHQERuyELgF_rQ-4CpTbdbAyI9u1ggtPlLQ/pubchart ?oid=1167032693&amp ;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">Graphique montrant la répartition des octets pour chaque type de contenu par catégorie de tiers. Les images et les scripts sont répartis de manière relativement égale entre les catégories. 80 % des polices proviennent de CDN. La vidéo provient de tiers spécialisés en "Contenus".</div>
  <figcaption id="fig7-caption" >Figure 7. Répartition des octets de ressource par catégorie de tiers.</figcaption>
</figure>

< !--

```<insert graphic of metric 05_12>```
-->

En ce qui concerne les fournisseurs tiers spécifiques, on trouve les mêmes poids-lourds en tête du classement du nombre de requêtes, qu’en tête du classement des poids en octets. Les seuls à ne pas respecter cette tendance sont les fournisseurs très médiatiques que sont YouTube, Shopify et Twitter, qui se hissent en tête des tableaux d’impact en poids.

< !--```<insert table of metric 05_07>```-->

### Exécution de scripts

57 % du temps d’exécution des scripts provient de scripts tiers, et les 100 premiers domaines représentent déjà 48 % de la durée totale d’exécution des scripts sur le web. Cela souligne l’impact considérable que quelques entités bien définies ont réellement sur les performances du web. Ce sujet est étudié plus en profondeur dans la section [Répercussions > Performance](#performance).

< !--```<insert graphic of metric 05_05>```-->

< !--```<insert graphic of metric 05_13>```-->

La répartition par catégorie de l’exécution des scripts suit largement celle du nombre de requêtes. Ici aussi, la publicité est la plus imposante. Les scripts publicitaires représentent 25 % du temps d’exécution de scripts tiers, les fournisseurs de services d’hébergement et les fournisseurs liés aux réseaux sociaux arrivant en deuxième position, à 12 %.

< !--```<insert table of metric 05_08>```-->

< !--```<insert table of metric 05_10>```-->

Bien que l’on puisse dire beaucoup de choses sur la popularité et l’impact sur le rendement de chaque fournisseur, cette analyse plus subjective est laissée à la discrétion du lecteur et d’autres outils conçus à cette fin, comme le [third-party-web](https://thirdpartyweb.today).

## Types d’utilisation

Pourquoi les propriétaires de sites utilisent-ils un code tiers ? Comment ces contenus tiers peuvent-ils désormais représenter plus de la moitié des requêtes réseau ? Que font toutes ces requêtes ? Les réponses à ces questions se trouvent dans les trois principaux modèles d’utilisation des ressources tierces. En général, les propriétaires de sites font appel à des tiers pour générer et consommer les données de leurs utilisateurs, monétiser leurs expériences sur le site et simplifier le développement web.

### Générer et consommer des données

La télémétrie est la catégorie de tiers la plus populaire sur le web et pourtant, elle est peu visible pour l’utilisateur. Considérez le volume d’information en jeu pendant la durée de vie d’une visite sur le Web : le contexte de l’utilisateur·ice, le dispositif, le navigateur, la qualité de la connexion, la localisation, les interactions avec la page, la durée de la session, l’information selon laquelle il ou elle a déjà visité le site ou cette page, etc. sont générés en permanence. Il est difficile, encombrant et coûteux de maintenir des outils qui permettent d’entreposer, de normaliser et d’analyser des séries chronologiques de données de cette ampleur. Bien que rien n’exige catégoriquement que la télémétrie relève du domaine des fournisseurs tiers, l’attrait grandissant pour la compréhension de vos utilisateur·ice·s, la grande complexité de l’espace des problèmes et l’importance croissante accordée à la gestion respectueuse et responsable des données font naturellement apparaître la télémétrie comme un modèle d’utilisation tiers très répandu.

Mais il y a aussi un revers à la médaille pour les données des utilisateurs : la consommation. Alors que les outiles de télémétrie consistent à générer des données sur les visiteurs et visiteuses de votre site, d’autres ressources tierces se concentrent sur la consommation de données sur ces personnes, en provenance d’autres sources. Les fournisseurs sociaux s’inscrivent parfaitement dans ce schéma d’utilisation. Un propriétaire de site _doit_ utiliser les ressources Facebook s’il souhaite intégrer à son site des informations provenant du profil Facebook d’une personne. Tant que les propriétaires de sites sont intéressés à personnaliser leur expérience avec les widgets des réseaux sociaux et à tirer parti des réseaux sociaux de leurs visiteurs et visiteuses pour accroître leur audience, les intégrations sociales resteront probablement la chasse gardée de fournisseurs ters dans le futur.

### Monétiser le trafic web

Le modèle ouvert du web ne sert pas toujours les intérêts financiers des personnes créatrices de contenu aussi bien qu’elles le souhaiteraient et de nombreux propriétaires de sites ont recours à la publicité pour monétiser leurs sites. Comme l’établissement de relations directes avec les annonceurs et la négociation de contrats de prix est un processus relativement difficile et long, cette responsabilité est en grande partie assumée par des fournisseurs tiers qui se chargent de la publicité ciblée et des appels d’offres en temps réel. L’opinion publique globalement négative, la popularité de la technologie de blocage des publicités et les mesures réglementaires prises sur les principaux marchés mondiaux tels que l’Europe constituent la plus grande menace à la poursuite du recours à des fournisseurs tiers pour la monétisation. Bien qu’il soit peu probable que les propriétaires de sites concluent soudainement leurs propres contrats publicitaires ou construisent des réseaux publicitaires sur mesure, d’autres modèles de monétisation comme les <span lang="en">paywalls</span> et des expériences comme le [<span lang="en">Basic Attention Token</span>](https://basicattentiontoken.org/) du navigateur Brave ont une réelle chance de secouer, à l’avenir, le paysage de la publicité de tiers.

### Simplifier le développement

Plus que tout autre usage, les ressources tierces sont surtout utilisées pour simplifier l’expérience de développement web. Il est possible que même des modes d’utilisation antérieurs s’inscrivent dans ce schéma. Qu’il s’agisse d’analyser le comportement des utilisateurs, de communiquer avec les annonceurs ou de personnaliser l’expérience utilisateur, les ressources tierces sont utilisées pour faciliter le développement initial du site.

Les fournisseurs d’hébergement sont l’exemple le plus extrême de ce schéma. Certains de ces fournisseurs permettent même à n’importe qui sur Terre de devenir propriétaire d’un site sans avoir besoin de compétences techniques. Ils fournissent l’hébergement des ressources, des outils pour construire des sites sans aucune compétence en matière de programmation et des services d’enregistrement de domaines.

Le reste des fournisseurs tiers ont également tendance à s’inscrire dans ce schéma d’utilisation. Qu’il s’agisse de l’hébergement d’une bibliothèque d’utilitaires telle que jQuery pour l’utilisation par les développeurs frontaux mis en cache sur les serveurs de périphérie de Cloudflare ou d’une vaste bibliothèque de polices d’écriture usuelles, servies à partir du très populaire CDN de Google, le contenu de tiers est une autre façon de soulager le propriétaire du site et, peut-être, simplement, de lui faciliter un peu la tâche pour offrir une expérience agréable.

## Répercussions

### Performance

L’impact des contenus de tiers sur la [performance](./performance) n’est ni catégoriquement bon ni mauvais. Il y a de bons et de mauvais acteurs dans toutes les catégories et les différents types de tiers ont des niveaux d’influence variables.

Le point positif : les polices de caractères et les styles partagés par des domaines tiers sont, en moyenne, plus efficaces que celles de leurs homologues du domaine principal.

Les catégories Utilitaires, CDN et Contenu sont les meilleures en termes de performances, au sein du paysage des performances tierces. Elles offrent des versions optimisées du même type de contenu qui serait autrement servi par des ressources du domaine principal. Google Fonts et Typekit proposent des polices optimisées qui sont en moyenne plus petites que les polices de première partie, Cloudflare CDN propose une version minifiée des bibliothèques open source qui pourraient être accidentellement servies en mode développement par certains propriétaires de sites, le SDK Google Maps fournit efficacement des cartes complexes qui pourraient, sinon, être naïvement livrées sous forme de grandes images.

Le mauvais : un très petit nombre d’entités génère une très grande partie du temps d’exécution de JavaScript, alors qu’elles ne fournissent qu’un petit ensemble de fonctionnalités, très limité, sur les pages.

Les publicités, les fournisseurs de services de réseautage social, d’hébergement et certains fournisseurs de services de télémétrie exercent une influence des plus négatives sur la performance du web. Alors que les fournisseurs d’hébergement fournissent la majorité du contenu d’un site et ont naturellement un impact plus important sur les performances que les autres catégories de tiers, ils servent également des sites presque entièrement statiques qui exigent, dans la plupart des cas, très peu de JavaScript, ce qui ne devrait pas justifier le volume de temps d’exécution des scripts. Les autres catégories qui nuisent aux performances ont cependant encore moins d’excuses. Elles jouent un rôle très limité sur chaque page sur laquelle elles apparaissent et pourtant elles prennent rapidement le dessus sur une majorité de ressources. Par exemple, le bouton " J’aime " de Facebook et les widgets des réseaux sociaux associés occupent un espace extraordinairement réduit sur l’écran et ne représentent qu’une fraction de la plupart des expériences web, et pourtant l’impact médian sur les pages avec des tiers sociaux est de près de 20 % de leur temps d’exécution JavaScript total. La situation est similaire pour l’analyse - les bibliothèques de suivi ne contribuent pas directement à l’expérience utilisateur perçue, et pourtant l’impact du 90e percentile sur les pages avec des tiers d’analyse est de 44 % de leur temps d’exécution JavaScript total.

Le bon côté de ce petit nombre d’entités jouissant d’une si grande part de marché est qu’un effort très limité et concentré peut avoir un impact énorme sur le web dans son ensemble. L’amélioration des performances chez les quelques premiers hébergeurs peut améliorer de 2 à 3 % de _toutes_ les requêtes web.

### Confidentialité

L’abondance des fournisseurs de services de télémétrie et la forte concentration de l’exécution des scripts posent deux problèmes majeurs de confidentialité pour les visiteurs des sites : les propriétaires de sites sont très nombreux à pister leurs utilisateurs avec des scripts tiers, permettant à une poignée d’entreprises de recevoir des informations sur une grande partie du trafic web.

L’intérêt des propriétaires de sites pour la compréhension et l’analyse du comportement des utilisateurs n’est pas malveillant en soi, mais le caractère généralisé et plutôt dissimulé du pistage sur le web soulève des préoccupations légitimes. Les utilisateurs et utilisatrices, les entreprises et les autorités législatives en ont pris conscience  ces dernières années, aboutissant aux réglementations sur la protection de la vie privée telles que le [RGPD](https://fr.wikipedia.org/wiki/R%C3 %A8glement_g%C3 %A9n%C3 %A9ral_sur_la_protection_des_donn%C3 %A9es) en Europe et le [CCPA](https://en.wikipedia.org/wiki/California_Consumer_Privacy_Act) en Californie. Il est essentiel de s’assurer que les équipes de développement traitent les données des utilisateurs et utilisatrices de manière responsable, qu’elles les traitent avec respect et qu’elles soient transparentes quant aux données recueillies pour que la télémétrie demeure la catégorie de tiers la plus populaire et pour s’assurer que l’analyse du comportement des utilisateurs reste en symbiose avec l’amélioration de la valeur d’usage pour les utilisateurs et utilisatrices.

La forte concentration de l’exécution des scripts est excellente au regard de l’impact potentiel des futures améliorations de performance, mais moins excitante pour ses implications en termes de confidentialité. 29 % de _tous_ les temps d’exécution de scripts sur le web proviennent uniquement de scripts sur des domaines appartenant à Google ou à Facebook. C’est un pourcentage très important du temps CPU qui est contrôlé par ces deux seules entités. Il est essentiel de s’assurer que les mêmes protections de la vie privée que celles dont bénéficient les fournisseurs de services de télémétrie sont également appliquées dans les autres catégories : services, publicités, réseaux sociaux et développement.

### Sécurité

Bien que le sujet de la sécurité soit traité plus en profondeur dans le chapitre [Sécurité](./sécurité), les conséquences de l’introduction de dépendances externes sur votre site en matière de sécurité sont indissociables de la protection de la vie privée. Permettre à des tiers d’exécuter des JavaScript arbitraires leur donne un contrôle total sur votre page. Quand un script peut contrôler le DOM et `window`, il peut tout faire. Même si le code n’a pas de problèmes de sécurité, il peut introduire un point unique de défaillance, [ce qui a été reconnu comme un problème potentiel depuis un certain temps maintenant](https://www.stevesouders.com/blog/2010/06/01/frontend-spof/).

[Auto-héberger du contenu de tierces parties](https://csswizardry.com/2019/05/self-host-your-static-assets/) répond à certaines des préoccupations mentionnées ici – et à d’autres. De plus, comme les navigateurs [partitionnement de plus en plus les caches HTTP](https://chromestatus.com/feature/5730772021411840), les avantages du chargement direct à partir de la tierce partie semblent plus que jamais incertains. Cette méthode est peut-être meilleure pour de nombreux cas d’utilisation, même si elle rend la mesure de son impact plus difficile.

## Conclusion

Le contenu tiers est partout. Cela n’est guère surprenant ; le principe de base du web est de permettre l’interconnexion et la mise en relation. Dans ce chapitre, nous avons examiné les contenus de tiers en termes de ressources hébergées en dehors du domaine principal. Si nous avions inclus les contenus tiers auto-hébergés (par exemple, les bibliothèques open source communes hébergées sur le domaine principal), l’utilisation de contenus tiers aurait été encore plus importante !

Bien que la [réutilisation dans les technologies informatiques](https://en.wikipedia.org/wiki/Code_reuse) soit généralement une pratique exemplaire, les tiers sur le web introduisent des dépendances qui ont un impact considérable sur la performance, la confidentialité et la sécurité d’une page. L’auto-hébergement et la sélection minutieuse des fournisseurs peuvent grandement contribuer à atténuer ces effets.

Indépendamment de la question importante de savoir comment les contenus de tiers sont ajoutés à une page, la conclusion est la même : les tiers font partie intégrante du web !
