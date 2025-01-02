---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: Chapitre SEO du web Almanac 2019. Découvrez des statistiques sur le contenu, les meta tags, l'indexation, les liens, la performance web.
hero_alt: Hero image of various web pages beneath a search field with Web Almanac characters shine a light on the pages and make various checks.
authors: [ymschaap, rachellcostello, AVGP]
reviewers: [clarkeclark, andylimn, AymenLoukil, catalinred, mattludwig]
analysts: [ymschaap]
editors: [rachellcostello]
translators: [AymenLoukil]
discuss: 1765
results: https://docs.google.com/spreadsheets/d/1uARtBWwz9nJOKqKPFinAMbtoDgu5aBtOhsBNmsCoTaA/
ymschaap_bio: Fondateur d’une agence de conseil en SEO technique <a hreflang="en" href="https://build.amsterdam/">build.amsterdam</a>. Auparavant, il a fondé plusieurs sociétés Web qui ont atteint plus d’un milliard d’utilisateurs. Il blogue sur ses dernières aventures depuis 2005 sur <a hreflang="en" href="https://yvoschaap.com/">yvoschaap.com</a>.
rachellcostello_bio: Rachel Costello est technical SEO & Content Manager chez <a hreflang="en" href="https://www.deepcrawl.com/">DeepCrawl</a> et une conférencière internationale qui passe son temps à rechercher et à communiquer sur les derniers développements dans le SEO. Rachel gère actuellement la production de <a hreflang="en" href="https://www.deepcrawl.com/knowledge/white-papers/">livres blancs sur les techniques de référencement </a> et des articles de recherche pour DeepCrawl, et est une chroniqueuse régulière pour <a hreflang="en" href="https://www.searchenginejournal.com/author/rachel-costello/">Search Engine Journal</a>.
AVGP_bio: Martin Splitt est un DevRel au sein de l’équipe Écosystème Web chez Google, où il travaille à garder le Web découvrable.
featured_quote: L’optimisation pour les moteurs de recherche (SEO) n'est pas seulement un passe-temps ou un projet parallèle pour les spécialistes du marketing digital, ce métier est crucial pour le succès d'un site web. Le but principal du référencement naturel est de s'assurer qu’un site internet est optimisé pour les robots des moteurs de recherche qui ont besoin d’explorer et d'indexer ses pages, ainsi que pour les utilisateurs qui naviguent et consomment des contenus. Le référencement a un impact sur tous ceux qui travaillent sur un site web, du développeur qui le construit au marketeur digital qui en fait la promotion auprès de nouveaux clients potentiels.
featured_stat_1: 346
featured_stat_label_1: mots par page, en médiane
featured_stat_2: 11 %
featured_stat_label_2: des pages n’ont pas de titres HTML (Hn)
featured_stat_3: 15 %
featured_stat_label_3: des sites sont éligibles aux résultats enrichis
---

## Introduction

L'optimisation pour les moteurs de recherche (SEO) n'est pas seulement un passe-temps ou un projet parallèle pour les spécialistes du marketing digital, ce métier est crucial pour le succès d'un site web. Le but principal du référencement naturel est de s'assurer qu'un site internet est optimisé pour les robots des moteurs de recherche qui ont besoin d'explorer et d'indexer ses pages, ainsi que pour les utilisateurs qui naviguent et consomment des contenus. Le référencement a un impact sur tous ceux qui travaillent sur un site web, du développeur qui le construit au marketeur digital qui en fait la promotion auprès de nouveaux clients potentiels.

Mettons en perspective l'importance du référencement naturel. En avril 2019, l'industrie du référencement a regardé avec horreur et fascination <a hreflang="en" href="https://www.bbc.co.uk/news/business-47877688">ASOS signaler une baisse de revenus de 87 %</a> après une "année difficile". La marque a attribué ce résultat à une baisse de classement et de visibilité dans les moteurs de recherche survenue après le lancement de plus de 200 microsites et à des changements importants dans la navigation de leur site web, entre autres changements techniques. Ouch.

L'objectif du chapitre SEO du web Almanac est d'analyser les éléments des sites web qui ont un impact sur l'exploration et l'indexation des contenus pour les moteurs de recherche et, par conséquence, sur leurs performances. Dans ce chapitre, nous allons voir dans quelle mesure les sites web les plus fréquentés sont prêts à offrir une excellente expérience aux utilisateurs et aux moteurs de recherche, et quels sont ceux qui ont encore du travail à faire.

Notre étude se base sur des données de [Lighthouse](./methodology#lighthouse), de [Chrome UX Report](./methodology#chrome-ux-report), et l'analyse des balises HTML. Nous nous sommes concentrés sur les fondements du SEO comme la balise `<title>`, les différents types de liens HTML, le contenu et la vitesse de chargement, mais aussi d'autres aspects techniques du référencement à savoir l'indexation, les données structurées, l'internationalisation, et les pages accélérées pour mobile (AMP) à travers 5 millions de sites web.

Nos métriques personnalisées fournissent des informations qui, jusqu'à présent, n'avaient pas été exposées auparavant. Nous sommes maintenant en mesure de faire des constats sur l'adoption et la mise en œuvre d'éléments tels que des balises `link` avec attribut `hreflang`, l'éligibilité des résultats enrichis, l'utilisation de la balise `title` et même la navigation basée sur les ancres pour les applications d'une seule page (SPA).

<aside class="note">Remarque&nbsp;: nos données se limitent à l'analyse des pages d'accueil uniquement et n'ont pas été collectées à partir d'analyses de toutes les pages des sites web. Cela aura un impact sur de nombreuses mesures dont nous discuterons, nous avons donc ajouté toutes les limitations pertinentes à chaque fois que nous mentionnons une mesure personnalisée. En savoir plus sur ces limitations dans notre <a href="./methodology">méthodologie</a>.</aside>

Lisez la suite pour en savoir plus sur l'état actuel du web et sa compatibilité pour les moteurs de recherche.

## Fondamentaux

Les moteurs de recherche ont un processus en trois étapes&nbsp;: l'exploration, l'indexation et le positionnement. Pour être optimisé pour les moteurs de recherche, une page doit être découvrable, compréhensible et contenir un contenu de qualité qui fournirait de la valeur à un utilisateur qui consulte les pages de résultats des moteurs de recherche (SERP).

Nous voulions analyser dans quelle mesure le web répond aux normes de base des meilleures pratiques SEO, donc nous avons évalué les éléments sur les pages, tels que le contenu principal, les balises `meta` et les liens internes. Jetons un coup d'œil sur les résultats.

### Contenu

Pour pouvoir comprendre ce qu'est une page web et décider pour quelles requêtes de recherche elle fournit les réponses les plus pertinentes, un moteur de recherche doit être capable de découvrir et d'accéder à son contenu. Mais quel contenu les moteurs de recherche trouvent-ils actuellement? Pour vous aider à répondre à cette question, nous avons créé deux mesures personnalisées: le nombre de mots et les en-têtes.

#### Nombre de mots

Nous avons évalué le contenu des pages en recherchant des groupes d'au moins 3 mots et en comptant le nombre total de mots trouvés. Nous avons trouvé 2,73 % des pages sur ordinateur qui ne comportaient aucun groupe de mots, ce qui signifie qu'elles n'ont pas de contenu principal pour aider les moteurs de recherche à comprendre le sujet du site web.

{{ figure_markup(
  image="fig1.png",
  caption="Distribution du nombre de mots par page.",
  description="Distribution du nombre de mots par page. Le nombre médian de mots par page de bureau est de 346 et 306 pour les pages mobiles. Les pages de bureau contiennent plus de mots dans les centiles, jusqu'à 120 mots au 90e centile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=190546113&format=interactive"
  )
}}

La page d'accueil médiane du bureau contient 346 mots et la page d'accueil médiane du mobile a un nombre de mots légèrement inférieur à 306 mots. Cela montre que les sites mobiles offrent un peu moins de contenu à leurs utilisateurs, mais à plus de 300 mots, c'est toujours une quantité raisonnable à lire. Cela est particulièrement vrai pour les pages d'accueil qui contiennent naturellement moins de contenu que les pages d'article, par exemple. Dans l'ensemble, la distribution des mots est large, avec entre 22 mots au 10e centile et jusqu'à 1 361 au 90e centile.

#### Éléments d'entête

Nous avons également examiné si les pages sont structurées de manière à fournir le bon contexte pour le contenu qu'elles contiennent. Les éléments d'en-tête (`H1`, `H2`, `H3`, etc.) sont utilisés pour formater et structurer une page et rendre le contenu plus facile à lire et à analyser. Malgré l’importance des titres, 10,67&nbsp;% des pages ne en comportent pas.

{{ figure_markup(
  image="fig2.png",
  caption="Répartition du nombre de titres par page.",
  description="Répartition du nombre de titres par page. Répartition des titres par page. Le nombre médian d'en-têtes par page de bureau et mobile est de 10. Aux 10, 25, 75 et 90e centiles, le nombre d'en-têtes par page de bureau est de 0, 3, 21 et 39. C'est légèrement plus élevé que la distribution d'en-têtes mobiles par page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=676369575&format=interactive"
  )
}}

Le nombre médian d'éléments de titre par page est de 10. Les titres contiennent 30 mots sur les pages mobiles et 32 mots sur les pages de bureau. Cela implique que les sites web qui utilisent des titres mettent beaucoup d'efforts pour s'assurer que leurs pages sont lisibles, descriptives et décrivent clairement la structure de la page et le contexte du moteur de recherche.

{{ figure_markup(
  image="fig3.png",
  caption="Répartition du nombre de caractères dans le premier H1 par page.",
  description="Répartition du nombre de caractères dans le premier H1 par page. Les distributions de bureau et mobile sont presque identiques, avec les 10, 25, 50, 75 et 90e centiles sous la forme: 6, 11, 19, 31 et 47 caractères.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1380411857&format=interactive"
  )
}}

En termes de longueur de titre spécifique, la longueur médiane du premier élément `H1` trouvé sur le bureau est de 19 caractères.

Pour obtenir des conseils sur la façon de gérer les `H1` et les rubriques pour le référencement et l'accessibilité, jetez un œil à cette <a hreflang="en" href="https://www.youtube.com/watch?v=zyqJJXWk0gk">réponse vidéo de John Mueller</a> dans le Ask Google Série de webmasters.

### Balises meta

Les balises meta nous permettent de donner des instructions et des informations spécifiques aux robots des moteurs de recherche sur les différents éléments et contenus d'une page. Certaines balises meta peuvent transmettre des éléments tels que le sujet principal de la page, ainsi que la façon dont la page doit être explorée et indexée. Nous voulions évaluer si les sites web exploitaient ou non les opportunités offertes par les balises meta.

#### Balise title

{{ figure_markup(
  caption="Pourcentage des pages mobiles qui ont une balise title",
  content="97 %",
  classes="big-number"
)
}}

Les titres de page sont un moyen important de communiquer l'objectif d'une page à un utilisateur ou à un moteur de recherche. Les balises sont également utilisées comme en-têtes dans le SERPS et comme titre pour l'onglet du navigateur lors de la visite d'une page, il n'est donc pas surprenant de voir que 97,1 % des pages mobiles ont un titre de document.

{{ figure_markup(
  image="fig5.png",
  caption="Distribution de la longueur du titre par page.",
  description="Répartition du nombre de caractères par élément de titre par page. Les 10, 25, 50, 75 et 90e centiles des longueurs de titre pour le bureau sont&nbsp;: 4, 9, 20, 40 et 66 caractères. La distribution mobile est très similaire",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1015017335&format=interactive"
  )
}}

Même si <a hreflang="en" href="https://moz.com/learn/seo/title-tag">Google affiche généralement les 50 à 60 premiers caractères d'un titre de page</a> dans une page de résultats de recherche. La longueur médiane `title` de la balise ne comportait que 21 caractères pour les pages mobiles et 20 caractères pour les pages de bureau. Même le 75e centile est toujours inférieur à la longueur préconisée. Cela suggère que certains SEO et rédacteurs de contenu ne profitent pas de l'espace qui leur est alloué par les moteurs de recherche pour décrire leurs pages d'accueil dans les SERP.

#### Meta descriptions

Par rapport à la balise `title`, moins de pages ont implémenté une méta description. Seulement 64,02 % des pages d'accueil mobiles ont une méta description. Étant donné que Google réécrit souvent les descriptions méta dans le SERP en réponse à la requête de l'internaute, les propriétaires de sites web accordent peut-être moins d'importance à l'inclusion des metas descriptions.

{{ figure_markup(
  image="fig6.png",
  caption="Distribution des pages par longueurs de meta description.",
  description="Répartition du nombre de caractères par méta description par page. Les 10, 25, 50, 75 et 90e centiles des longueurs de titre pour le bureau sont&nbsp;: 9, 48, 123, 162 et 230 caractères. La distribution mobile est légèrement supérieure de moins de 10 caractères à un centile donné.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1750266149&format=interactive"
  )
}}

La longueur médiane de la description de la méta était également inférieure à la <a hreflang="en" href="https://moz.com/learn/seo/meta-description">longueur recommandée de 155 à 160 caractères</a>, les pages de bureau ayant des descriptions de 123 caractères. Fait intéressant, les méta descriptions étaient toujours plus longues sur mobile que sur ordinateur, malgré les SERP mobiles ayant traditionnellement une limite de pixels plus courte. Cette limite n'a été étendue que récemment, donc peut-être qu'un plus grand nombre de propriétaires de sites web ont testé l'impact d'avoir des méta descriptions plus longues et plus descriptives pour les résultats mobiles.

#### Attributs Alt pour les images

Compte tenu de l'importance de l'attribut `Alt` pour le référencement et l'accessibilité, il est loin d'être idéal de voir que seulement 46,71 % des pages mobiles utilisent des attributs `alt` sur toutes leurs images. Cela signifie qu'il y a encore des améliorations à faire pour rendre les images sur le web plus accessibles aux utilisateurs et compréhensibles pour les moteurs de recherche. En savoir plus sur ces problèmes dans le chapitre [Accessibilité](./accessibility).

### Indexabilité

Pour afficher le contenu d'une page aux utilisateurs dans les SERP, les robots des moteurs de recherche doivent d'abord être autorisés à accéder à cette page et à l'indexer. Certains des facteurs qui influent sur la capacité d'un moteur de recherche à explorer et à indexer des pages sont les suivants:

- Codes de réponse HTTP
- Balise `noindex`
- Balise link canonical
- Le fichier `robots.txt` (exploration)

#### Codes de réponses HTTP

Il est recommandé de conserver un code de réponse HTTP `200 OK` pour toutes les pages importantes que vous souhaitez voir indexées par les moteurs de recherche. La majorité des pages testées étaient accessibles aux moteurs de recherche, 87,03 % des demandes HTML initiales sur le bureau renvoyant un code d'état `200`. Les résultats étaient légèrement inférieurs pour les pages mobiles, avec seulement 82,95 % des pages renvoyant un code d'état `200`.

Le code de réponse suivant le plus fréquemment trouvé sur mobile était le `302`, une redirection temporaire, qui a été trouvée sur 10,45 % des pages mobiles. C'était plus élevé que sur le bureau, avec seulement 6,71 % des pages d'accueil du bureau renvoyant un code d'état `302`. Cela pourrait être dû au fait que les <a hreflang="en" href="https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls">pages d'accueil mobiles étaient des alternatives</a> vers une page de bureau équivalente, comme sur des sites non responsive qui ont des versions distinctes du site web pour chaque appareil.

<aside class="note">Remarque&nbsp;: nos résultats n'incluaient pas les codes d'état 4xx ou 5xx.</aside>

#### `noindex`

La directive `noindex` peut être indiquée dans le `HTML` ou bien dans les entêtes HTTP `X-Robots`. Une directive `noindex` indique essentiellement à un moteur de recherche de ne pas inclure cette page dans ses SERPs, mais la page sera toujours accessible aux utilisateurs lorsqu'ils naviguent sur le site web. Les directives `noindex` sont généralement ajoutées aux versions en double des pages qui servent le même contenu, ou aux pages de faible qualité qui n'apportent aucune valeur aux utilisateurs qui arrivent sur un site web à partir d'une recherche organique, telles que les pages de recherche filtrées, à facettes ou internes.

96,93 % des pages mobiles ont réussi [l'audit d'indexation de Lighthouse](https://developers.google.com/web/tools/lighthouse/audits/indexing), ce qui signifie que ces pages ne contenaient pas de directive `noindex`. Cependant, cela signifie que 3,07 % des pages d'accueil mobiles ont une directive `noindex`, ce qui est préoccupant et signifie que Google n'a pas pu indexer ces pages.

<aside class="note">Les sites web inclus dans notre recherche proviennent de <a href="./methodology#chrome-ux-report">Chrome UX Report</a>, qui exclut les site web non publiques. Il s'agit d'une source importante de biais, car nous ne sommes pas en mesure d'analyser les sites que Chrome juge non publics. Plus de détails sur notre <a href="./methodology#websites">méthodologie</a>.</aside>

#### Canonicalisation

Les balises canoniques sont utilisées pour spécifier les pages en double et leurs alternatives préférées, afin que les moteurs de recherche puissent consolider l'autorité qui pourrait être répartie sur plusieurs pages du groupe sur une seule page principale pour un meilleur classement.

48,34 % des pages d'accueil mobiles ont été <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/canonical">détectées</a> avoir une balise canonique. Les balises canoniques auto-référencées ne sont pas essentielles et les balises canoniques sont généralement requises pour les pages en double. Les pages d'accueil sont rarement dupliquées ailleurs sur le site, il n'est donc pas surprenant de constater que moins de la moitié des pages ont une balise canonique.

#### robots.txt

L'une des méthodes les plus efficaces pour contrôler l'exploration des moteurs de recherche est le fichier [robots.txt]. Il s'agit d'un fichier qui se trouve sur le domaine racine d'un site web et spécifie quelles URL et chemins d'URL doivent être interdits à l'exploration par les moteurs de recherche.

Il était intéressant de constater que seulement 72,16 % des sites mobiles ont un `robots.txt` valide, <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/robots">selon Lighthouse</a>. Les principaux problèmes que nous avons constatés sont répartis entre 22 % des sites n'ayant aucun fichier `robots.txt` et ~ 6 % servant un fichier `robots.txt` non valide, et échouent ainsi à l'audit. Bien qu'il existe de nombreuses raisons valables de ne pas avoir de fichier `robots.txt`, comme avoir un petit site web qui n'a pas <a hreflang="en" href="https://webmasters.googleblog.com/2017/01/what-crawl-budget-means-for-googlebot.html">de soucis de budget de crawl</a>, avoir un `robots.txt` invalide peut être problématique surtout avec le Mobile First Index.

### Liens

Les liens sont l'un des attributs les plus importants d'une page web. Les liens aident les moteurs de recherche à découvrir de nouvelles pages pertinentes à ajouter à leur index et à naviguer sur les sites web. 96 % des pages web de notre ensemble de données contiennent au moins un lien interne et 93 % contiennent au moins un lien externe vers un autre domaine. La petite minorité de pages qui n'ont pas de liens internes ou externes passeront à côté de l'immense valeur que les liens transmettent aux pages cibles.

Le nombre de liens internes et externes inclus sur les pages de bureau était constamment supérieur au nombre trouvé sur les pages mobiles. Souvent, un espace limité sur une fenêtre plus petite entraîne moins de liens à inclure dans la conception d'une page mobile par rapport au bureau.

Il est important de garder à l'esprit que moins de liens internes sur la version mobile d'une page <a hreflang="en" href="https://moz.com/blog/internal-linking-mobile-first-crawl-paths">pourraient causer un problème</a> pour votre site web. Avec le Mobile-First index, si une page est uniquement liée à partir de la version bureau, Google ne prendra pas compte de ses liens si le site fait partie de l'index Mobile.

{{ figure_markup(
  image="fig7.png",
  caption="Répartition du nombre de liens internes par page.",
  description="Répartition du nombre de liens internes par page. Les 10, 25, 50, 75 et 90e centiles de liens internes pour les ordinateurs de bureau sont&nbsp;: 7, 29, 70, 142 et 261. La distribution mobile est beaucoup plus faible, de 30 liens au 90e centile et 10 à la médiane.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=534496673&format=interactive"
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="Répartition du nombre de liens externes par page.",
  description="Répartition du nombre de liens externes par page. Les 10, 25, 50, 75 et 90e centiles de liens externes pour ordinateur de bureau sont&nbsp;: 1, 4, 10, 22 et 51. La distribution mobile est beaucoup plus faible, de 11 liens au 90e centile et 2 au médian",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1997009875&format=interactive"
  )
}}

La page de bureau médiane comprend 70 liens internes (même site), tandis que la page mobile médiane comporte 60 liens internes. Le nombre médian de liens externes par page suit une tendance similaire, avec des pages de bureau comprenant 10 liens externes et des pages mobiles 8.

{{ figure_markup(
  image="fig9.png",
  caption="Répartition du nombre de liens d'ancrage par page.",
  description="Répartition du nombre de liens d'ancrage par page. Les 10, 25, 50, 75 et 90e centiles d'ancrage interne pour le bureau sont&nbsp;: 0, 0, 0, 1 et 3. La distribution sur mobile est identique.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=1852200766&format=interactive"
  )
}}

Les liens d'ancrage, qui pointent vers une certaine position de défilement sur la même page, ne sont pas très populaires. Plus de 65 % des pages d'accueil n'ont pas de liens d'ancrage. Cela est probablement dû au fait que les pages d'accueil ne contiennent généralement pas de contenu long.

Il y a de bonnes nouvelles de notre analyse de la métrique de texte du lien descriptif. 89,94 % des pages mobiles réussissent [l'audit de texte du lien descriptif de Lighthouse](https://developers.google.com/web/tools/lighthouse/audits/descriptive-link-text). Cela signifie que ces pages n'ont pas de liens génériques "cliquez ici", "aller", "ici" ou "en savoir plus", mais utilisent un texte de lien plus significatif qui aide les utilisateurs et les moteurs de recherche à mieux comprendre le contexte des pages et comment elles se connectent les unes aux autres.

## Avancé

Avoir un contenu descriptif et utile sur une page qui n'est pas bloquée des moteurs de recherche avec une directive `noindex` ou `Disallow` n'est pas suffisant pour qu'un site web réussisse dans la recherche organique. Ce ne sont que les bases. Il y a beaucoup plus que ce qui peut être fait pour améliorer les performances d'un site web et son apparence dans les SERPs.

Certains des aspects les plus complexes sur le plan technique qui ont gagné en importance dans l'indexation et le classement réussi des sites web comprennent la performance web (vitesse de chargement), les données structurées, l'internationalisation, la sécurité et la compatibilité mobile.

### Performance web

La vitesse de chargement des sites mobiles a été d'abord <a hreflang="en" href="https://webmasters.googleblog.com/2018/01/using-page-speed-in-mobile-search.html">annoncée comme facteur de positionnement</a> par Google en 2018. La vitesse n'est pas un nouvel objectif pour Google. En 2010, il a été <a hreflang="en" href="https://webmasters.googleblog.com/2010/04/using-site-speed-in-web-search-ranking.html">révélé que la vitesse avait été introduite comme facteur de classement</a>.

Un site web à chargement rapide est également essentiel pour une bonne expérience utilisateur. Les utilisateurs qui doivent attendre, même quelques secondes, pour qu'un site se charge ont tendance à rebondir et à essayer un autre résultat de l'un de vos concurrents qui se charge rapidement et répond à leurs attentes de performances.

Les métriques que nous avons utilisées pour notre analyse de la vitesse de chargement sur le web sont basées sur le [<i lang="en">Chrome UX Report</i>](./methodology#chrome-ux-report) (CrUX), qui recueille des données auprès des utilisateurs réels de Chrome. Ces données montrent qu'un que 48 % des sites web sont étiquetés comme **lents**. Un site web est considéré lent s'il présente plus de 25 % d'expériences FCP (<i lang="en">First Contentful Paint</i>) plus lentes que 3 secondes _ou_ 5 % d'expériences FID (<i lang="en">First input Delay</i>) plus lentes que 300 ms.

{{ figure_markup(
  image="fig10.png",
  caption="Distribution des performances des expériences utilisateur par type d'appareil.",
  description="Distribution des performances des expériences utilisateur des ordinateurs de bureau, des téléphones et des tablettes. Ordinateur de bureau&nbsp;: 2 % rapide, 52 % modéré, 46 % lent. Téléphone&nbsp;: 1 % rapide, 41 % modéré, 58 % lent. Tablette&nbsp;: 0 % rapide, 35 % modérée, 65 % lente.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSrPaauIA_G4AySC09FX4fK5DsJ8DWhJGUQE0obrBe9HGSA8geyq3KwFi531jg9Ll9auE3x_UEwnF8g/pubchart?oid=2083126642&format=interactive"
  )
}}

Segmentée par type d'appareil, cette image est encore plus sombre pour la tablette (65 %) et le mobile (58 %).

Bien que les chiffres soient inquiétants pour la vitesse du web, la bonne nouvelle est que les experts et les outils SEO se concentrent de plus en plus sur les défis techniques de l'accélération des sites. Vous pouvez en savoir plus sur l'état des performances web dans le chapitre [Performances](./performance).

### Données structurées

Les données structurées permettent aux propriétaires de sites web d'ajouter des données sémantiques supplémentaires à leurs pages web, en ajoutant des extraits de code [JSON-LD](https://en.wikipedia.org/wiki/JSON-LD) ou des [microdonnées](https://developer.mozilla.org/docs/web/HTML/Microdonn%C3%A9es), par exemple. Les moteurs de recherche analysent ces données pour mieux comprendre ces pages et utilisent parfois le balisage pour afficher des informations pertinentes supplémentaires dans les résultats de la recherche. Les types de données structurées les plus courants sont&nbsp;:

- <a hreflang="en" href="https://developers.google.com/search/docs/data-types/review-snippet">Review</a>
- <a hreflang="en" href="https://developers.google.com/search/docs/data-types/product">Product</a>
- <a hreflang="en" href="https://developers.google.com/search/docs/data-types/local-business">Local Bussiness</a>
- <a hreflang="en" href="https://developers.google.com/search/docs/data-types/movie">Movie</a>
- et <a hreflang="en" href="https://developers.google.com/search/docs/guides/search-gallery">D'autres</a>

La <a hreflang="en" href="https://developers.google.com/search/docs/guides/enhance-site">visibilité supplémentaire</a> que les données structurées peuvent fournir aux sites web est intéressante pour les propriétaires de sites, car elle peut aider à créer plus d'opportunités de trafic . Par exemple, le [schéma de FAQ] relativement nouveau (https://developers.google.com/search/docs/data-types/faqpage) doublera la taille de votre extrait sur les pages de résultats de recherche.

Au cours de nos recherches, nous avons constaté que seuls 14,67 % des sites sont éligibles pour des résultats riches sur mobile. Fait intéressant, l'admissibilité au site de bureau est légèrement inférieure à 12,46 %. Cela suggère que les propriétaires de sites peuvent faire beaucoup plus pour optimiser la façon dont leurs pages d'accueil apparaissent dans la recherche.

Parmi les sites avec un balisage de données structuré, les cinq types les plus implémentés sont:

1. `WebSite` (16,02 %)
2. `SearchAction` (14,35 %)
3. `Organization` (12,89 %)
4. `WebPage` (11,58 %)
5. `ImageObject` (5,35 %)

Fait intéressant, l'un des types de données les plus populaires qui déclenche une fonctionnalité de moteur de recherche est `SearchAction`, qui alimente la <a hreflang="en" href="https://developers.google.com/search/docs/data-types/sitelinks-searchbox">boîte de recherche des liens annexes</a>.

Les cinq principaux types de balisage conduisent tous à une plus grande visibilité dans les résultats de recherche de Google, ce qui pourrait être le facteur d'une adoption plus répandue de ces types de données structurées.

Étant donné que nous n'avons examiné que les pages d'accueil, les résultats pourraient sembler très différents si nous considérions également les pages intérieures.

Les étoiles d'avis ne se trouvent que sur 1,09 % des pages d'accueil du web (via <a hreflang="en" href="https://schema.org/AggregateRating">AggregateRating</a>). En outre, le [QAPage] nouvellement introduit (https://schema.org/QAPage) n'est apparu que dans 48 cas, et le <a hreflang="en" href="https://schema.org/FAQPage">FAQPage</a> à une fréquence légèrement plus élevée de 218 fois. Ces deux derniers décomptes devraient augmenter à l'avenir alors que nous effectuons davantage d'analyses et approfondissons l'analyse Web Almanac.

### Internationalisation

L'internationalisation est l'un des aspects les plus complexes du référencement naturel, même [selon certains employés de la recherche Google](https://x.com/JohnMu/status/965507331369984002). L'internationalisation du référencement se concentre sur la diffusion du bon contenu à partir d'un site web avec plusieurs versions linguistiques ou nationales et sur le ciblage du contenu vers la langue et l'emplacement spécifiques de l'utilisateur.

Alors que 38,40 % des sites de bureau (33,79 % sur mobile) ont l'attribut HTML `lang` réglé sur anglais, seulement 7,43 % (6,79 % sur mobile) des sites contiennent également un attribut `hreflang` de balise `link` pointant vers une autre version linguistique. Cela suggère que la grande majorité des sites web que nous avons analysés n'offrent pas de versions distinctes de leur page d'accueil qui nécessiteraient un ciblage linguistique - sauf si ces versions distinctes existent mais n'ont pas été configurées correctement.

<figure>
  <table>
    <thead>
      <tr>
        <th><code>hreflang</code></th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>en</td>
        <td class="numeric">12.19 %</td>
        <td class="numeric">2.80 %</td>
      </tr>
      <tr>
        <td>x-default</td>
        <td class="numeric">5.58 %</td>
        <td class="numeric">1.44 %</td>
      </tr>
      <tr>
        <td>fr</td>
        <td class="numeric">5.23 %</td>
        <td class="numeric">1.28 %</td>
      </tr>
      <tr>
        <td>es</td>
        <td class="numeric">5.08 %</td>
        <td class="numeric">1.25 %</td>
      </tr>
      <tr>
        <td>de</td>
        <td class="numeric">4.91 %</td>
        <td class="numeric">1.24 %</td>
      </tr>
      <tr>
        <td>en-us</td>
        <td class="numeric">4.22 %</td>
        <td class="numeric">2.95 %</td>
      </tr>
      <tr>
        <td>it</td>
        <td class="numeric">3.58 %</td>
        <td class="numeric">0.92 %</td>
      </tr>
      <tr>
        <td>ru</td>
        <td class="numeric">3.13 %</td>
        <td class="numeric">0.80 %</td>
      </tr>
      <tr>
        <td>en-gb</td>
        <td class="numeric">3.04 %</td>
        <td class="numeric">2.79 %</td>
      </tr>
      <tr>
        <td>de-de</td>
        <td class="numeric">2.34 %</td>
        <td class="numeric">2.58 %</td>
      </tr>
      <tr>
        <td>nl</td>
        <td class="numeric">2.28 %</td>
        <td class="numeric">0.55 %</td>
      </tr>
      <tr>
        <td>fr-fr</td>
        <td class="numeric">2.28 %</td>
        <td class="numeric">2.56 %</td>
      </tr>
      <tr>
        <td>es-es</td>
        <td class="numeric">2.08 %</td>
        <td class="numeric">2.51 %</td>
      </tr>
      <tr>
        <td>pt</td>
        <td class="numeric">2.07 %</td>
        <td class="numeric">0.48 %</td>
      </tr>
      <tr>
        <td>pl</td>
        <td class="numeric">2.01 %</td>
        <td class="numeric">0.50 %</td>
      </tr>
      <tr>
        <td>ja</td>
        <td class="numeric">2.00 %</td>
        <td class="numeric">0.43 %</td>
      </tr>
      <tr>
        <td>tr</td>
        <td class="numeric">1.78 %</td>
        <td class="numeric">0.49 %</td>
      </tr>
      <tr>
        <td>it-it</td>
        <td class="numeric">1.62 %</td>
        <td class="numeric">2.40 %</td>
      </tr>
      <tr>
        <td>ar</td>
        <td class="numeric">1.59 %</td>
        <td class="numeric">0.43 %</td>
      </tr>
      <tr>
        <td>pt-br</td>
        <td class="numeric">1.52 %</td>
        <td class="numeric">2.38 %</td>
      </tr>
      <tr>
        <td>th</td>
        <td class="numeric">1.40 %</td>
        <td class="numeric">0.42 %</td>
      </tr>
      <tr>
        <td>ko</td>
        <td class="numeric">1.33 %</td>
        <td class="numeric">0.28 %</td>
      </tr>
      <tr>
        <td>zh</td>
        <td class="numeric">1.30 %</td>
        <td class="numeric">0.27 %</td>
      </tr>
      <tr>
        <td>sv</td>
        <td class="numeric">1.22 %</td>
        <td class="numeric">0.30 %</td>
      </tr>
      <tr>
        <td>en-au</td>
        <td class="numeric">1.20 %</td>
        <td class="numeric">2.31 %</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Les 25 valeurs <code>hreflang</code> les plus utilisées.") }}</figcaption>
</figure>

À côté de l'anglais, les langues les plus courantes sont le français, l'espagnol et l'allemand. Ils sont suivis de langues ciblées vers des zones géographiques spécifiques comme l'anglais pour les américains (`en-us`) ou des combinaisons plus obscures comme l'espagnol pour l'irlandais (`es-ie`).

L'analyse n'a pas vérifié la bonne mise en œuvre, par exemple si les différentes versions linguistiques se lient correctement les unes aux autres. Cependant, en examinant la faible adoption d'une version x-default (seulement 3,77 % sur ordinateur et 1,30 % sur mobile), <a href="https://support.google.com/webmasters/answer/189077?hl=fr">comme cela est recommandé</a>, c'est un indicateur que cet élément est complexe et pas toujours facile à bien faire.

### Exploration des SPA (<i lang="en">Single Page Application</i>) {exploration-des-spa-single-page-application}

Les applications monopages (SPA) construites avec des frameworks comme React et Vue.js ont leur propre complexité SEO. Les sites web utilisant une navigation basée sur le hachage, rendent particulièrement difficile pour les moteurs de recherche de les explorer et de les indexer correctement. Par exemple, Google avait une solution de contournement "AJAX crawling scheme" qui s'est avérée complexe pour les moteurs de recherche ainsi que pour les développeurs, elle a donc été <a hreflang="en" href="https://webmasters.googleblog.com/2015/10/deprecating-our-ajax-crawling-scheme.html">déconseillée en 2015</a>.

Le nombre de SPA testés avait un nombre relativement faible de liens servis via des URL de hachage, avec 13,08 % des pages mobiles React utilisant des URL de hachage pour la navigation, 8,15 % des pages mobiles Vue.js les utilisant et 2,37 % des pages angulaires mobiles les utiliser. Ces résultats étaient également très similaires pour les pages de bureau. Cela est positif à voir du point de vue du référencement, compte tenu de l'impact que les URL de hachage peuvent avoir sur la découverte de contenu.

Le nombre plus élevé d'URL de hachage dans les pages React est surprenant, en particulier contrairement au nombre plus faible d'URL de hachage trouvées sur les pages angulaires. Les deux frameworks favorisent l'adoption de packages de routage où [API historique](https://developer.mozilla.org/docs/web/API/History) est la valeur par défaut pour les liens, au lieu de s'appuyer sur des URL de hachage. Vue.js <a hreflang="en" href="https://github.com/vuejs/rfcs/pull/40">envisage de passer à l'utilisation de l'API Historique par défaut</a> ainsi que dans la version 3 de leur package `vue-router`.

### AMP

AMP (<i lang="en">Accelerated Mobile Pages</i>, Pages Mobiles Accélérées en français) a été introduit pour la première fois en 2015 par Google en tant que framework HTML open source. Il fournit des composants et une infrastructure aux sites web pour offrir une expérience plus rapide aux utilisateurs, en utilisant des optimisations telles que la mise en cache, le chargement différé et des images optimisées. Notamment, Google a adopté cela pour son moteur de recherche, où les pages AMP sont également servies à partir de leur propre CDN. Cette fonctionnalité est devenue plus tard une proposition de normes sous le nom <a hreflang="en" href="https://wicg.github.io/webpackage/draft-yasskin-http-origin-signed-responses.html">échanges HTTP signés</a>.

Malgré cela, seulement 0,62 % des pages d'accueil mobiles contiennent un lien vers une version AMP. Compte tenu de la visibilité de ce projet, cela suggère qu'il a été relativement peu adopté. Cependant, AMP peut être plus utile pour diffuser des pages d'articles, de sorte que notre analyse axée sur la page d'accueil ne reflétera pas l'adoption sur d'autres types de page.

### Securité

Le passage en HTTPS par défaut, était un fort changement sur le web ces dernières années. HTTPS empêche le trafic du site web d'être intercepté sur les réseaux Wi-Fi publics, par exemple, où les données d'entrée des utilisateurs sont ensuite transmises de manière non sécurisée. Google a fait pression pour que les sites adoptent le HTTPS, et a même fait du <a hreflang="en" href="https://webmasters.googleblog.com/2014/08/https-as-ranking-signal.html">HTTPS un signal de classement SEO</a>. Chrome a également pris en charge le passage aux pages sécurisées en étiquetant les pages non HTTPS comme <a hreflang="en" href="https://www.blog.google/products/chrome/milestone-chrome-security-marking-http-not-secure/">non sécurisées</a> dans le navigateur.

Pour plus d'informations et des conseils de Google sur l'importance du HTTPS et comment l'adopter, veuillez consulter <a hreflang="en" href="https://developers.google.com/web/fundamentals/security/encrypt-in-transit/why-https">Pourquoi le HTTPS est important</a>.

Nous avons constaté que 67,06 % des sites web sur ordinateur sont désormais servis via HTTPS. Un peu moins de la moitié des sites web n'ont toujours pas migré vers HTTPS et fournissent des pages non sécurisées à leurs utilisateurs. C'est un nombre important. Les migrations peuvent être un travail difficile, donc cela pourrait être une raison pour laquelle le taux d'adoption n'est pas plus élevé, mais une migration HTTPS nécessite généralement un certificat SSL et une simple modification du fichier `.htaccess`. Il n'y a aucune vraie raison de ne pas passer en HTTPS.

Le [Rapport de transparence HTTPS] de Google (https://transparencyreport.google.com/https/overview) signale une adoption de 90 % de HTTPS pour les 100 principaux domaines non Google (ce qui représente 25 % de tout le trafic de sites web dans le monde). La différence entre ce nombre et le nôtre pourrait s'expliquer par le fait que des sites relativement plus petits adoptent le HTTPS à un rythme plus lent.

En savoir plus sur l'état de la sécurité dans le chapitre [Sécurité](./security).

## Conclusion

Grâce à notre analyse, nous avons observé que la majorité des sites web suivent les bonnes pratiques, dans la mesure où leurs pages d'accueil sont explorables, indexables et incluent le contenu clé requis pour bien se classer dans les pages de résultats des moteurs de recherche. Toutes les personnes qui possèdent un site web ne sont pas du tout au courant du SEO, sans parler des directives de meilleures pratiques, il est donc prometteur de voir que tant de sites ont couvert les bases.

Cependant, il manque plus de sites que prévu en ce qui concerne certains des aspects les plus avancés du référencement et de l'accessibilité. La vitesse du site est l'un de ces facteurs avec lesquels de nombreux sites web ont du mal, en particulier sur mobile. C'est un problème important, car la performance est l'un des plus gros contributeurs à l'UX, ce qui peut avoir un impact sur les classements. Le nombre de sites web qui ne sont pas encore desservis via HTTPS est également problématique, compte tenu de l'importance de la sécurité et de la sécurité des données des utilisateurs.

Il y a beaucoup plus de sujets que nous pouvons étudier pour en savoir plus sur les meilleures pratiques du référencement. Cela est essentiel en raison de la nature évolutive de l'industrie de la recherche et de la vitesse à laquelle les changements se produisent. Les moteurs de recherche apportent des milliers d'améliorations à leurs algorithmes chaque année, et nous devons suivre si nous voulons que nos sites web atteignent plus de visiteurs dans la recherche organique.
