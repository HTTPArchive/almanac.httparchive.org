---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Performance
description: Chapitre Performance du Web Almanac 2020 couvrant les Signaux Web Essentiels (Core Web Vitals), le score de performance de Lighthouse, le First Contentful Paint (FCP) et le Time to First Byte (TTFB).
authors: [thefoxis]
reviewers: [borisschapira, rviscomi, foxdavidj, noamr, Zizzamia]
analysts: [max-ostapenko, dooman87]
editors: [tunetheweb]
translators: [borisschapira]
thefoxis_bio: Karolina est <em lang="en">Product Design Lead</em> chez <a hreflang="en" lang="en" href="https://calibreapp.com/">Calibre</a>, travaillant à la création de la plate-forme de surveillance de la vitesse la plus complète. Elle réalise la curation de la <a hreflang="en" lang="en" href="https://perf.email/">Performance Newsletter</a>, votre source d’informations et de ressources sur la performance. Karolina <a hreflang="en" href="https://calibreapp.com/blog/category/web-platform">écrit aussi fréquemment</a> sur la façon dont la performance affecte l’expérience d’utilisation.
discuss: 2045
results: https://docs.google.com/spreadsheets/d/164FVuCQ7gPhTWUXJl1av5_hBxjncNi0TK8RnNseNPJQ/
featured_quote: De mauvaises performances ne se traduisent pas seulement par de la frustration ou des effets négatifs sur les objectifs commerciaux, elles créent de véritable barrières à l’entrée. La pandémie mondiale de cette année a rendu ces obstacles encore plus évidents.
featured_stat_1: 25 %
featured_stat_label_1: de sites avec un bon FCP sur mobile
featured_stat_2: 18 %
featured_stat_label_2: de sites avec un bon TTFB sur mobile
featured_stat_3: 4 %
featured_stat_label_3: de sites avec un score de performance inchangé dans LH6
---

## Introduction

Il est incontestable que la lenteur a un effet néfaste sur l’expérience d’utilisation en général et, par conséquent, sur les conversions. Mais de mauvaises performances ne se traduisent pas seulement par de la frustration ou des effets négatifs sur les objectifs commerciaux, elles créent de véritable barrières à l’entrée. La pandémie mondiale de cette année <a hreflang="en" href="https://www.weforum.org/agenda/2020/04/coronavirus-covid-19-pandemic-digital-divide-internet-data-broadband-mobbile/">a rendu ces obstacles encore plus évidents</a>. Avec le développement de l’apprentissage à distance, du télétravail et de la socialisation en ligne, c’est toute notre vie qui s’est soudainement retrouvée sur Internet. La mauvaise connectivité et le manque d’accès à des appareils performants ont rendu ce changement douloureux, voire impossible, pour beaucoup. Ce fut un véritable test, mettant en évidence les inégalités de connectivité, d’appareils et de vitesse dans le monde entier.

Les outils de performance continuent d’évoluer pour décrire ces divers aspects de l’expérience d’utilisation et faciliter la recherche des problèmes sous-jacents. Depuis [le chapitre Performance de l’année dernière](../2019/performance), de nombreux développements importants ont eu lieu dans le domaine qui ont déjà transformé notre approche de la surveillance de la vitesse.

Par exemple, une version majeure du populaire outil d’audit de qualité, <span lang="en">Lighthouse</span> 6 (<a hreflang="en" href="https://calibreapp.com/blog/how-performance-score-works">l’algorithme du célèbre score de performance a considérablement changé</a>), et les scores ont également évolué. Les <a hreflang="en" href="https://calibreapp.com/blog/core-web-vitals">Signaux Web Essentiels (<span lang="en">Core Web Vitals</span>)</a>, un ensemble de nouveaux indicateurs décrivant différents aspects de l’expérience d’utilisation, sont désormais disponibles. Ils seront l’un des facteurs de classement des résultats de recherche à l’avenir, attirant l’attention de la communauté du développement sur de nouveaux signaux de vitesse.

Dans ce chapitre, nous examinerons les données de performance de terrain fournies par le <a hreflang="en" lang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">Chrome User Experience Report (CrUX)</a> à travers la lentille de ces ajouts ainsi que l’analyse d’une poignée d’autres mesures pertinentes. Il est important de noter qu’en raison des limitations d’iOS, les résultats du CrUX mobile n’incluent pas les appareils utilisant le système d’exploitation mobile d’Apple. Ce fait affectera indéniablement notre analyse, en particulier lorsque nous examinerons les valeurs des indicateurs de performances par pays.

Allons-y.

## Le score de performance de <span lang="en">Lighthouse</span> {le-score-de-performance-de-lighthouse}

En mai 2020, <a hreflang="en" href="https://github.com/GoogleChrome/lighthouse/releases/tag/v6.0.0">est sorti <span lang="en">Lighthouse</span> 6</a>. La nouvelle version majeure du très populaire logiciel d’audit de performance a apporté des changements notables à son algorithme de score de performance. Le score de performance est une représentation de haut niveau de la vitesse du site. Dans <span lang="en">Lighthouse</span> 6, le score est mesuré avec une échelle de six indicateurs, au lieu de cinq auparavant : le <span lang="en">First Meaningful Paint</span> et le <span lang="en">First CPU Idle</span> ont été supprimés et remplacés par le <span lang="en">Largest Contentful Paint</span> (LCP), le <span lang="en">Total Blocking Time</span> (TBT, l’équivalent en laboratoire du <span lang="en">First Input Delay</span>) et le <span lang="en">Cumulative Layout Shift</span> (CLS).

Le nouvel algorithme de notation donne la priorité à la nouvelle génération d'indicateurs des performance&nbsp;: les Signaux Web Essentiels (<em lang="en">Core Web Vitals</em>) et baisse la priorité des <span lang="en">First Contentful Paint</span> (FCP), <span lang="en">Time to Interactive</span> (TTI) et <span lang="en">Speed Index</span>, puisque leurs poids respectifs dans le score diminuent. L’algorithme met désormais aussi nettement l’accent sur trois aspects de l’expérience d’utilisation : *l’interactivité* (<span lang="en">Total Blocking Time</span> et <span lang="en">Time to Interactive</span>), la *stabilité visuelle* (<span lang="en">Cumulative Layout Shift</span>) et les *chargements perçus* (<span lang="en">First Contentful Paint</span>, <span lang="en">Speed Index</span> et <span lang="en">Largest Contentful Paint</span>).

En outre, le score est désormais calculé en utilisant différents points de référence pour les ordinateurs de bureau et les téléphones portables. En pratique, cela signifie qu’il sera moins indulgent sur ordinateur de bureau (en attendant des sites web rapides) et plus souple sur mobile (puisque les performances de référence sur mobile sont moins rapides que sur ordinateur de bureau). Vous pouvez comparer la différence de score de votre <span lang="en">Lighthouse</span> 5 et 6 dans <a hreflang="en" href="https://googlechrome.github.io/lighthouse/scorecalc/">le calculateur de score</a>. Alors, comment les scores ont-ils réellement changé&nbsp;?

{{ figure_markup(
  image="performance-change-in-lighthouse-score.png",
  caption="Différence de score de performance Lighthouse entre les versions 5 et 6.",
  description="Diagramme à colonnes montrant l’évolution du score de performance entre les versions 5 et 6. Le pourcentage le plus élevé de sites web (4 %) n’a observé aucune modification du score, et le nombre de sites dont le score a diminué est supérieur à celui des améliorations de score.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=786955541&format=interactive",
  sheets_gid="518150031",
  sql_file="lh6_vs_lh5_performance_score_02.sql"
  )
}}

Ci-dessus, nous observons que 4 % des sites web n’ont enregistré aucun changement dans leur score de performance, mais le nombre de sites ayant enregistré des changements négatifs dépasse celui des sites dont le score s’est amélioré. Les notes de performance se sont détériorées (avec la courbe de diminution la plus marquée dans la zone des 10-25 points), ce qui est illustré encore plus directement ci-dessous :

{{ figure_markup(
  image="performance-lighthouse-score-distributions-yoy.png",
  caption="Distribution des notes de performance dans Lighthouse 5 et 6.",
  description="Diagramme de dispersion indiquant le pourcentage de sites ayant obtenu une note de 0 à 100 dans Lighthouse 5 et 6. Avec l’algorithme de Lighthouse 6, le pourcentage de sites ayant un score entre 0 et 25 augmente, et le nombre de sites ayant un score entre 50 et 100 diminue.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=926035471&format=interactive",
  sheets_gid="1303574513",
  sql_file="lh6_vs_lh5_performance_score_distribution.sql"
  )
}}

En comparant <span lang="en">Lighthouse</span> 5 et 6, nous pouvons directement observer comment la répartition des points a changé. Avec l’algorithme de <span lang="en">Lighthouse</span> 6, nous observons une augmentation du pourcentage de pages recevant des notes entre 0 et 25 et une diminution entre 50 et 100. Alors que dans <span lang="en">Lighthouse</span> 5, nous avons vu 3 % des pages recevant une note de 100, dans <span lang="en">Lighthouse</span> 6, ce chiffre est tombé à seulement 1 %.

Ces changements globaux ne sont pas inattendus compte tenu d’une multitude de modifications apportées à l’algorithme lui-même.

## <span lang="en">Core Web Vitals</span> : le <span lang="en">Largest Contentful Paint</span> {core-web-vitals-le-largest-contentful-paint}

Le <span lang="en">Largest Contentful Paint</span> (LCP) est une mesure temporelle de référence qui indique le moment où le plus grand élément <a hreflang="en" href="https://web.dev/lcp/#what-elements-are-considered">au-dessus du pli</a> (<a href="https://www.fasterize.com/fr/blog/core-web-vitals-google-quest-ce-que-le-largest-contentful-paint-lcp/">traduction française</a>) a été affiché.

### LCP par matériel

{{ figure_markup(
  image="performance-lcp-by-device.png",
  caption="Performance agrégée du LCP répartie par type d’appareil.",
  description="Diagramme à barres montrant que 53 % des expériences sur les sites web de bureau et 43 % des expériences sur les sites web mobiles sont classées comme bonnes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=696629857&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

Dans le graphique ci-dessus, on peut observer qu’entre 43 % et 53 % des sites web ont de bonnes performances en matière de LCP (en dessous de 2,5 s) : la majorité des sites web parviennent à hiérarchiser et à charger rapidement leurs médias critiques et au-dessus du pli. Pour une mesure relativement nouvelle, c’est un bon signal. Le léger écart entre les ordinateurs de bureau et les téléphones portables est probablement dû à la variation de la vitesse du réseau, des capacités des appareils et de la taille des images (les grandes images spécifiques aux ordinateurs de bureau mettront plus de temps à être téléchargées et affichées).

### LCP par répartition géographique

{{ figure_markup(
  image="performance-lcp-by-geo.png",
  caption="Les performances agrégées du LCP réparties par pays.",
  description="Diagramme à barres montrant que les pourcentages les plus élevés de bonnes performances du LCP sont répartis entre les pays européens et asiatiques. La République de Corée est en tête avec 76 % de bonnes mesures, tandis que l’Inde est en dernière position avec 16 % de bonnes mesures.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1936626175&format=interactive",
  width="645",
  height="792",
  sheets_gid="263037691",
  sql_file="web_vitals_by_country.sql"
  )
}}

Le pourcentage le plus élevé de bonnes mesures du LCP est principalement réparti entre les pays européens et asiatiques, la République de Corée (Corée du Sud) étant en tête avec 76 % de bonnes mesures. La Corée du Sud est un leader constant en matière de vitesse de téléphonie mobile, avec une impressionnante vitesse de téléchargement de 145 Mo/s <a hreflang="en" href="https://www.speedtest.net/global-index">selon le Speedtest Global Index</a> pour le mois d’octobre. Le Japon, la République tchèque, Taïwan, l’Allemagne et la Belgique sont également quelques pays qui offrent des débits mobiles élevés et fiables. L’Australie, bien que leader en matière de vitesse des réseaux mobiles, est désavantagée par la lenteur des connexions de bureau et la latence, ce qui la place dans la partie inférieure du classement ci-dessus.

L’Inde reste la dernière de notre série de données, avec seulement 16 % de bonnes expériences. Alors que la population de personnes se connectant à Internet pour la première fois ne cesse de croître, les vitesses des réseaux mobiles et de bureau sont <a hreflang="en" href="https://www.opensignal.com/reports/2020/04/india/mobile-network-experience">toujours un problème</a>, avec des téléchargements moyens de 10 Mo/s pour la 4G, 3 Mo/s pour la 3G et moins de 50 Mo/s pour le bureau.

### LCP par type de connexion

{{ figure_markup(
  image="performance-lcp-by-connection-type.png",
  caption="Performance agrégée des LCP répartie par type de connexion.",
  description="Diagramme à barres montrant que 48 % des sites web ont un bon LCP sur la 4G. Le nombre de sites web bien notés diminue à 8 % sur la 3G, 1 % sur la 2G, 0 % sur la 2G lente et 18 % sur les connexions hors ligne.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=97874305&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

Comme le LCP est un indicateur permettant de voir quand le plus grand élément au-dessus du pli a été affiché (y compris les images, les vidéos ou les éléments de type bloc contenant du texte), il n’est pas surprenant que les mesures soient médiocres lorsque le réseau est lent.

Il existe une corrélation évidente entre la vitesse du réseau et de meilleures performances du LCP, mais même sur la 4G, seuls 48 % des résultats sont classés comme bons, ce qui laisse la moitié des analyses dans la cas « à améliorer ». L’automatisation de l’optimisation des médias, la transmission des bonnes dimensions et des bons formats, ainsi que l’optimisation pour le mode  « <span lang="en">Low Data</span> », pourraient aider à faire bouger les choses. Apprenez-en plus sur <a hreflang="en" href="https://web.dev/optimize-lcp/">l’optimisation du LCP dans ce guide</a> (<a href="https://www.fasterize.com/fr/blog/core-web-vitals-google-comment-optimiser-le-largest-contentful-paint-lcp/">traduction française</a>).

## <span lang="en">Core Web Vitals</span> : le <span lang="en">Cumulative Layout Shift</span> {core-web-vitals-cumulatice-layout-shift}

Le <span lang="en">Cumulative Layout Shift</span> (CLS) quantifie la façon dont les éléments affichés à l’écran se déplacent pendant la visite de la page. Il permet de déterminer le degré de mouvement inattendu sur vos sites web afin d’évaluer l’expérience d’utilisation, plutôt que d’essayer de mesurer une partie spécifique de l’interaction à l’aide d’une unité comme les secondes ou les millisecondes.

En ce sens, le CLS est un nouveau type de mesure holistique de l’UX, différent des autres mesures mentionnées dans ce chapitre.

### CLS par matériel

{{ figure_markup(
  image="performance-cls-by-device.png",
  caption="Performance globale du CLS répartie par type d’appareil.",
  description="Le graphique à barres montre que plus de la moitié des sites web ont un bon CLS, avec 54 % sur le bureau et 60 % sur le mobile. Dans les deux cas, seuls 21 % des sites web sont classés comme ayant une mauvaise qualité.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1672696367&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

Selon les données du CrUX, tant pour les appareils de bureau que pour les appareils mobiles, plus de la moitié des sites web ont un bon score CLS. Il y a une légère différence (6 points de pourcentage) entre le nombre de sites web bien notés pour les ordinateurs de bureau et les téléphones portables, ce qui favorise ces derniers. On peut supposer que les téléphones sont en tête des bonnes notes CLS en raison des expériences optimisées pour les mobiles qui ont tendance à être moins riches en fonctionnalités et en images.

### CLS par répartition géographique

{{ figure_markup(
  image="performance-cls-by-geo.png",
  caption="Performance agrégée des CLS par pays.",
  description="Graphique à barres montrant que les 28 premiers pays ont au moins 50 % des sites web qui font état d’un bon CLS. Les résultats modérés (« à améliorer ») se maintiennent entre 11 et 15 % dans l’ensemble.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1861585123&format=interactive",
  width="645",
  height="792",
  sheets_gid="47865955",
  sql_file="web_vitals_by_country.sql"
  )
}}

Les performances du CLS dans les différentes régions géographiques sont majoritairement bonnes, avec au moins 56 % des sites ayant une bonne note. C’est une excellente nouvelle pour la stabilité visuelle perçue. Nous pouvons observer les mêmes pays en tête, comme nous l’avons vu dans la répartition géographique du LCP - République de Corée, Japon, Tchéquie, Allemagne, Pologne.

La stabilité visuelle est moins affectée par la géographie et la latence que d’autres mesures, comme le LCP. La différence de pourcentage de bonnes notes entre le pays en tête et le pays en queue de peloton est de 61 % pour le LCP et de seulement 13 % pour le CLS. Le pourcentage de sites web ayant obtenu une note modérée est relativement faible dans l’ensemble, laissant place à 19 à 29 % de mauvaises expériences dans l’ensemble. Il existe de nombreux facteurs qui peuvent contribuer à un mauvais CLS - apprenez comment les traiter dans le <a hreflang="en" href="https://web.dev/optimize-cls/">guide d’optimisation du <span lang="en">Cumulative Layout Shift</span></a> (<a href="https://www.fasterize.com/fr/blog/core-web-vitals-google-comment-optimiser-le-cumulative-layout-shift-cls/">traduction française</a>).

### CLS par type de connexion

{{ figure_markup(
  image="performance-cls-by-connection-type.png",
  caption="Performance agrégée du CLS répartie par type de connexion.",
  description="Diagramme à barres montrant une répartition égale des mesures bonnes, à améliorer et mauvaises du CLS. Hors-ligne et 4G sont en tête avec respectivement 70 % et 64 % de bonnes expériences.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=151288279&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

La répartition des scores CLS est raisonnablement homogène pour la plupart des types de connexion, à l’exception des connexions hors ligne et de la 4G. Dans le scénario hors ligne, on peut supposer que les <span lang="en">Service Workers</span> délivrent les sites web. Par conséquent, il n’y a pas de retard dans le téléchargement causé par le type de connexion, ce qui explique la part la plus importante de bonnes notes.

Il est difficile de tirer des conclusions définitives sur la 4G, mais on peut supposer que les connexions 4G+ sont peut-être utilisées comme méthode d’accès à Internet sur les appareils de bureau. Si cette hypothèse était valable, les polices de caractères et les images du web pourraient être mises en cache de manière importante, ce qui a un effet positif sur les mesures du CLS.

## <span lang="en">Core Web Vitals</span> : le <span lang="en">First Input Delay</span> {core-web-vitals-le-first-input-delay}

Le <span lang="en">First Input Delay</span> (FID) mesure le temps entre la première interaction d’un utilisateur ou d’une utilisatrice et le moment où le navigateur est capable de répondre à cette interaction. Le FID est un bon indicateur du degré d’interactivité de vos sites web.

### FID par matériel

{{ figure_markup(
  image="performance-fid-by-device.png",
  caption="Performance agrégée du FID répartie par type d’appareil.",
  description="Diagramme à barres montrant les pourcentages élevés de bonnes performances du FID sur ordinateur de bureau (100 %) et sur téléphone portable (80 %).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2090682651&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

Il est relativement rare de voir de bons scores répartis sur un pourcentage aussi élevé de sites web. Sur le bureau, sur la base du 75e percentile des distributions des sites, 100 % des sites font état de temps rapides pour le FID, ce qui signifie que le nombre de personnes subissant des retards d’interaction est très faible.

Sur mobile, 80 % des sites sont classés comme bons. Une explication probable est la capacité réduite du CPU par rapport à un ordinateur de bureau, la latence du réseau sur les mobiles (qui entraîne un retard dans le téléchargement et l’exécution des scripts) ainsi que l’efficacité de la batterie et les limites de température, qui plafonnent le potentiel du CPU des appareils mobiles. Tous ces facteurs ont une incidence directe sur les mesures d’interactivité comme le FID.

### FID par répartition géographique

{{ figure_markup(
  image="performance-fid-by-geo.png",
  caption="Performance agrégée du FID répartie par pays.",
  description="Diagramme à barres présentant les excellentes performances du FID par pays. Les 28 premiers pays font état de 79 % à 97 % de bonnes expériences en matière de FID et de pratiquement aucune mauvaise expérience.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1107653062&format=interactive",
  width="645",
  height="792",
  sheets_gid="2120295762",
  sql_file="web_vitals_by_country.sql"
  )
}}

La répartition géographique des scores du FID confirme les conclusions du tableau agrégé des appareils, partagé précédemment. Au pire, 79 % des sites web ont un bon FID, avec un impressionnant 97 % en première position, la République de Corée étant de nouveau en tête. Il est intéressant de noter que certains des principaux prétendants au classement CLS et LCP, tels que la République tchèque, la Pologne, l’Ukraine et la Fédération de Russie, se retrouvent ici au bas du classement.

Encore une fois, il n’est pas facile de déterminer les raisons de cette situation. Si l’on suppose que le FID est en corrélation avec les capacités d’exécution de JavaScript, les pays où les appareils les plus performants sont plus chers et traités comme des articles de luxe devraient afficher un meilleur FID. La Pologne est un bon exemple - avec l’un des <a hreflang="en" href="https://qz.com/1106603/where-the-iphone-x-is-cheapest-and-most-expensive-in-dollars-pounds-and-yuan/">prix les plus élevés pour l’iPhone</a> en comparaison du marché US, combiné avec des [revenus relativement faibles](https://en.wikipedia.org/wiki/List_of_European_countries_by_average_wage#Net_average_monthly_salary), un seul salaire n’est pas suffisant pour acheter le produit phare d’Apple. Pour contraster, les Australiens touchant <a hreflang="en" href="https://www.news.com.au/finance/average-australian-salary-how-much-you-have-to-earn-to-be-better-off-than-most/news-story/6fcdde092e87872b9957d2ab8eda1cbd">un salaire moyen</a> pourraient acheter un iPhone avec une semaine de salaire. Heureusement, le pourcentage de sites web ayant une faible note se situe pour la plupart à 0, à quelques exceptions près (1 à 2 %), ce qui indique une réaction relativement rapide lors d’une interaction.

### FID par type de connexion

{{ figure_markup(
  image="performance-fid-by-connection-type.png",
  caption="Performance agrégée du FID répartie par type de connexion.",
  description="Diagramme à barres montrant une distribution élevée et constante des bonnes performances du FID sur différents types de réseaux. Les réseaux hors ligne, 3G et 4G sont en tête avec plus de 80 % des sites web bien notés.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=808962538&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

Nous pouvons observer une corrélation directe entre la vitesse du réseau et la rapidité du FID, allant de 73 % sur les réseaux 2G à 87 % sur les réseaux 4G. Des réseaux plus rapides permettent un téléchargement plus rapide des scripts, ce qui accélère le début de l’analyse et réduit le nombre de tâches bloquant le fil conducteur. De tels résultats sont encourageants, surtout lorsque le taux d’expériences de sites mal notés ne dépasse pas 5 %.

## <span lang="en">First Contentful Paint</span> {first-contentful-paint}

<span lang="en">First Contentful Paint</span> (FCP) mesure la première fois que le navigateur a affiché un texte, une image, un canvas non blanc ou un contenu SVG. Le FCP est un bon indicateur de la vitesse perçue, car il indique le temps d’attente avant de voir les premiers signes de chargement d’un site.

### FCP par matériel

{{ figure_markup(
  image="performance-fcp-desktop-distribution.png",
  caption="Distribution de sites web présentant des performances rapides, moyennes et lentes en matière de FCP sur les ordinateurs de bureau.",
  description="Distribution des sites web ayant des performances rapides, moyennes et lentes sur le bureau. La distribution des sites web rapides semble linéaire avec un renflement au milieu. Il y a plus d’expériences de FCP rapides et lentes par rapport à 2019, tandis que le nombre d’expériences moyennes diminue en raison des changements de catégorisation du FCP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1953305743&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

{{ figure_markup(
  image="performance-fcp-mobile-distribution.png",
  caption="Distribution de sites web ayant des performances rapides, moyennes et lentes sur le mobile.",
  description="Distribution de sites web ayant des performances rapides, moyennes et lentes sur le bureau. La distribution des sites web rapides semble linéaire, avec un moindre renflement que celui observé sur le graphique des ordinateurs de bureau. Le nombre d’expériences rapides et lentes du FCP est plus élevé qu’en 2019, tandis que le nombre d’expériences moyennes diminue en raison des changements de catégorisation du FCP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=38297781&format=interactive",
  sheets_gid="2122167666",
  sql_file="web_vitals_distribution_by_device.sql"
  )
}}

Dans les graphiques ci-dessus, les distributions de FCP sont réparties entre les ordinateurs de bureau et les téléphones portables. [Par rapport à l’année dernière](../2019/performance#fcp-by-device), on constate une diminution notable des relevés FCP moyens, tandis que le pourcentage d’expériences d’utilisation rapides et lentes a augmenté quel que soit le type d’appareil. Nous pouvons toujours observer la même tendance, à savoir que les personnes utilisant des téléphones portables connaissent plus fréquemment des FCP plus lents que celles qui utilisent des ordinateurs de bureau. Dans l’ensemble, ces personnes sont plus susceptibles d’avoir une bonne ou une mauvaise expérience, plutôt qu’une expérience moyenne.

{{ figure_markup(
  image="performance-fcp-mobile-year-on-year.png",
  caption="Une comparaison de la distribution des sites web ayant un bon FCP, un FCP nécessitant d’être amélioré et un FCP ayant une mauvaise performance mobile entre 2019 et 2020.",
  description="Diagramme à barres montrant la manière dont ont évolué la répartition des bons FCP, des FCP à améliorer et des mauvais FCP sur mobiles entre 2019 et 2020. En 2020, 75 % des sites web ont un FCP de moindre qualité.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=2037503700&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

En comparant le FCP sur les appareils mobiles sur une base annuelle, nous observons moins de bonnes expériences et plus d’expériences modérées et mauvaises. 75 % des sites web ont un FCP inférieur à la moyenne. Nous pouvons supposer que ce pourcentage élevé de mesures de FCP inférieures à l’idéal est une source de frustration et de dégradation de l’expérience d’utilisation.

De nombreux facteurs peuvent retarder le rendu, comme la latence du serveur (mesurée par une poignée d’indicateurs, tels que [<span lang="en">Time to First Byte</span> (TTFB)](#time-to-first-byte) et RTT), le blocage des requêtes JavaScript, ou la manipulation inappropriée des polices personnalisées, pour n’en citer que quelques-uns.

### FCP par répartition géographique

{{ figure_markup(
  image="performance-fcp-by-geo.png",
  caption="Performance agrégée du FCP, répartie par pays.",
  description="Graphique à barres montrant que seuls 7 pays sur 28 ont plus de 40 % de sites web avec de bonnes performances du FCP. Le nombre de bons et de mauvais résultats augmente par rapport à 2019 en raison des changements dans les plages de valeurs du FCP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=78259488&format=interactive",
  sheets_gid="1708427314",
  width="645",
  height="792",
  sql_file="web_vitals_by_country.sql"
  )
}}

Avant d’approfondir l’analyse, il convient de mentionner que dans le chapitre sur les performances de 2019, les seuils de classification « bon » et « mauvais » étaient différents de ceux de 2020. En 2019, les sites avec un FCP inférieur à 1 s étaient considérés comme bons, tandis que ceux avec un FCP supérieur à 3 s étaient classés comme mauvais. En 2020, ces fourchettes sont passées à 1,5 s pour les bons et à 2,5 s pour les mauvais.

Ce changement signifie que la distribution se déplacerait vers des sites web mieux notés et moins bien notés. Nous pouvons observer cette tendance par rapport aux [résultats de l’année dernière](../2019/performance#fcp-by-geography), à mesure que le pourcentage de bon et de mauvais sites web augmente. Les dix premières régions géographiques ayant le taux le plus élevé de sites web rapides restent relativement inchangées par rapport à 2019, avec l’ajout de la République Tchèque et de la Belgique et la chute des États-Unis et du Royaume-Uni. La République de Corée est en tête avec 62 % des sites web qui déclarent un FCP rapide, soit près du double de l’année dernière (ce qui, une fois encore, est probablement dû à la redistribution des résultats). Les autres pays en tête du classement doublent également le nombre de bonnes expériences.

Alors que le pourcentage des résultats moyens (« à améliorer ») diminue, le nombre de sites ayant de mauvais résultats augmente, ce qui est particulièrement prononcé dans le bas du classement avec les régions d’Amérique latine et d’Asie du Sud.

Là encore, il existe plusieurs facteurs ayant une incidence négative sur le FCP, tels que les mauvaises valeurs du TTFB, mais il est difficile de les confirmer sans le contexte nécessaire. Par exemple, si nous devions analyser les performances de pays spécifiques, tels que l’Australie, nous trouverions étonnamment qu’elles se situent dans la partie inférieure. L’Australie a l’un des niveaux de pénétration des smartphones les plus élevés au monde, l’un des réseaux de téléphonie mobile les plus rapides et des niveaux de revenus moyens relativement élevés. On pourrait facilement supposer qu’il devrait être plus élevé. Cependant, compte tenu de la lenteur des connexions fixes, de la latence et de l’absence de représentation d’iOS dans le CrUX, son positionnement commence à être plus logique. Avec un exemple comme celui-ci (que nous n’avons effleuré qu’en surface), nous pouvons voir à quel point il serait difficile de comprendre le contexte de chacun des pays.

### FCP par type de connexion

{{ figure_markup(
  image="performance-fcp-by-connection-type.png",
  caption="Performance agrégée du FCP, répartie par type de connexion.",
  description="Graphique à barres montrant que seuls 31 % des sites web font état d’un bon FCP sur la 4G. Hors ligne, ce chiffre tombe à 10 %, tandis que les autres types de connexion fournissent presque exclusivement des expériences médiocres au regard du FCP.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1949864731&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

Comme d’autres mesures, le FCP est affecté par les vitesses de connexion. Sur la 3G, seulement 2 % des expériences sont bonnes, tandis que sur la 4G, 31 %. Ce n’est pas un niveau de performance idéal pour le FCP, mais il [s’est amélioré depuis 2019](../2019/performance#fcp-by-effective-connection-type) dans certains domaines, qui pourraient à nouveau être influencés par le changement de catégorisation des bonnes et mauvaises performances. Nous constatons la même augmentation du pourcentage de bons et de mauvais sites web, ce qui réduit le nombre de sites moyens (« à améliorer »).

Cette tendance illustre l’aggravation de la fracture numérique, où les expériences sur des réseaux plus lents et des appareils potentiellement moins performants sont toujours plus mauvaises. L’amélioration du FCP sur les connexions lentes est en corrélation directe avec l’amélioration du TTFB, que nous observons dans le [graphique des performances agrégées du TTFB par type de connexion](#ttfb-par-type-de-connexion). Un TTFB faible = un FCP faible.

Le choix d’un <a hreflang="en" href="https://ismyhostfastyet.com/">hébergeur</a> ou d’un <a hreflang="en" href="https://www.cdnperf.com/">CDN</a> aura un effet en cascade sur la vitesse. En prenant ces décisions afin d’optimiser au mieux la livraison de contenu, on contribuera à améliorer le FCP et le TTFB, en particulier sur les réseaux les plus lents. Le FCP est également fortement influencé par le temps de chargement des polices, de sorte que <a hreflang="en" href="https://web.dev/font-display/">s’assurer que le texte est visible pendant le téléchargement des polices sur le web</a> est également une stratégie intéressante (en particulier lorsque, sur des connexions plus lentes, ces ressources seront coûteuses à récupérer).

En examinant les statistiques « hors ligne », nous pouvons déduire qu’un nombre important de questions relatives au FCP ne _sont pas_ corrélées au type de réseau. Nous n’observons pas de gains significatifs dans cette catégorie, ce qui serait le cas si cette affirmation était vraie. Il semblerait que le rendu ne soit pas tant retardé par la récupération de JavaScript, mais qu’il soit affecté par l’analyse et l’exécution.

## <span lang="en">Time to First Byte</span> {time-to-first-byte}

Le <span lang="en">Time to First Byte</span> (TTFB) est le temps écoulé entre la requête initiale du contenu HTML et la réception du premier octet par le navigateur. Les problèmes de rapidité de traitement des requêtes peuvent rapidement se répercuter sur d’autres mesures de performance, car ils retardent non seulement le rendu, mais aussi la récupération des ressources.

### TTFB par matériel

{{ figure_markup(
  image="performance-ttfb-by-device.png",
  caption="Performance agrégée du TTFB répartie par type d’appareil.",
  description="Graphique en barres montrant que 76 % des sites web ont un mauvais TTFB sur les ordinateurs de bureau et 83 % sur les téléphones portables. Le nombre de sites web présentant un bon TTFB ne dépasse pas 24 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1981576071&format=interactive",
  sheets_gid="1270303192",
  sql_file="web_vitals_by_device.sql"
  )
}}

Sur les ordinateurs de bureau, 76 % des sites web ont un « mauvais » TTFB, tandis que sur les téléphones portables, ce pourcentage passe à 83 %. On peut supposer que les données montrent que la TTFB est une mesure souvent négligée, alors que la plupart des mesures et des efforts se concentrent sur le <span lang="en">front-end</span> et le rendu visuel, et non sur la diffusion des ressources et le travail côté serveur. Un TTFB élevé aura un impact direct et négatif sur une pléthore d’autres signaux de performance, ce qui est un domaine qui doit encore être abordé.

### TTFB par répartition géographique

{{ figure_markup(
  image="performance-ttfb-by-geo.png",
  caption="Performance agrégée du TTFB répartie par pays.",
  description="Graphique à barres montrant que les performances du TTFB sont régulièrement médiocres, avec seulement 4 pays sur 28 ayant plus de 30 % de sites web avec un bon TTFB. Un nombre important de sites web sont classés comme nécessitant une amélioration (toujours au-dessus de 40 %), la proportion de sites médiocres augmentant à mesure que la position dans le classement diminue.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=1135415956&format=interactive",
  width="645",
  height="792",
  sheets_gid="1440255644",
  sql_file="web_vitals_by_country.sql"
  )
}}

La comparaison des données géographiques du TTFB de cette année avec [les résultats de 2019](../2019/performance#ttfb-by-geo) montre une fois de plus que les sites web sont plus rapides, mais comme pour le FCP, les seuils ont changé. Auparavant, nous considérions les TTFB inférieurs à 200 ms comme rapides et supérieurs à 1000 ms comme lents. En 2020, la TTFB en dessous de 500 ms est bonne et au-dessus de 1500 ms, mauvaise. Des changements aussi importants dans la classification peuvent expliquer que nous observons des changements significatifs, comme une augmentation de 36 % des bonnes expériences de sites web en République de Corée ou de 22 % à Taïwan. Dans l’ensemble, nous observons toujours les mêmes régions en tête, telles que l’Asie-Pacifique et certaines régions européennes.

### TTFB par type de connexion

{{ figure_markup(
  image="performance-ttfb-by-connection-type.png",
  caption="Performances agrégées du TTFB réparties par type de connexion.",
  description="Graphique à barres montrant que le TTFB est fortement influencé par le type de connexion avec seulement 21 % et 22 % de bonnes expériences sur la 4G et hors ligne, respectivement. Les autres types de connexion ne fournissent pratiquement aucune bonne expérience de TTFB (à l’exception de 1 % sur la 3G).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=810992122&format=interactive",
  sheets_gid="306222260",
  sql_file="web_vitals_by_ect.sql"
  )
}}

Le TTFB est affecté par la latence du réseau et le type de connexion. Plus la latence est élevée et plus la connexion est lente, plus les mesures de la TTFB sont mauvaises, comme nous pouvons l’observer ci-dessus. Même sur les connexions mobiles considérées comme rapides (4G), seuls 21 % des sites web ont un TTFB rapide. Il n’y a pratiquement aucun site classé comme rapide en dessous de la 4G.

Si on examine <a hreflang="en" href="https://www.speedtest.net/insights/blog/content/images/2020/02/Ookla_Mobile-Speeds-Poster_2020.png">les vitesses de téléphonie mobile dans le monde pour la période décembre 2018-novembre 2019</a>, on constate que, dans le monde, les connexions mobiles ne sont pas à haut débit. Ces vitesses et normes technologiques pour les réseaux cellulaires (comme la 5G) ne sont pas réparties de manière égale et affectent le TTFB. Par exemple, <a hreflang="en" href="https://www.mobilecoveragemaps.com/map_ng#7/8.744/7.670">voir cette carte des réseaux au Nigeria</a> - la plupart des régions du pays ont une couverture 2G et 3G, avec une faible portée en 4G.

Ce qui est surprenant, c’est le nombre relativement identique de bons résultats de TTFB entre les sources hors ligne et 4G. En ce qui concerne les travailleurs du secteur des services, on pourrait s’attendre à ce que certains des problèmes liés au TTFB soient atténués, mais cette tendance ne se reflète pas dans le graphique ci-dessus.

## Utilisation des <span lang="en">Performance Observers</span> {utilisation-des-performance-observers}

Il existe des dizaines de mesures différentes, orientées utilisation, qui peuvent être utilisées pour évaluer les sites web et les applications. Cependant, il arrive que les mesures prédéfinies ne correspondent pas tout à fait à nos scénarios et besoins spécifiques. <a href="https://developer.mozilla.org/en-US/docs/Web/API/PerformanceObserver">L’API <span lang="en">PerformanceObserver</span></a> nous permet d’obtenir des données de mesure personnalisées grâce à <a href="https://developer.mozilla.org/en-US/docs/Web/API/User_Timing_API">l’API <span lang="en">User Timing</span></a>, <a href="https://developer.mozilla.org/en-US/docs/Web/API/Long_Tasks_API">l’API <span lang="en">Long Task</span></a>, <a hreflang="en" href="https://web.dev/custom-metrics/#event-timing-api">l’API <span lang="en">Event Timing</span></a> et <a hreflang="en" href="https://web.dev/custom-metrics/">une poignée d’autres API de bas niveau</a>. Par exemple, avec leur aide, nous pourrions enregistrer les transitions temporelles entre les pages ou quantifier l’hydratation des applications en <span lang="en">Server Side Rendering</span> (SSR, rendues côté serveur).

{{ figure_markup(
  image="performance-performance-observer-usage.png",
  caption="Usage des Performance Observer par type de matériel.",
  description="Graphique en barres montrant que l’adoption de l’API Performance Observer est faible, à 6,6 % sur les ordinateurs de bureau et 7 % sur les téléphones portables.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3ukFCTxx__dTBLwDQ3K_hCtXdLRGOGUYdR_TO043n_aCTdcwkxPUku9Qfoal6BESiV5RMtd0nEbqT/pubchart?oid=632678090&format=interactive",
  sheets_gid="934401790",
  sql_file="performance_observer.sql"
  )
}}

Le graphique ci-dessus montre que <span lang="en">PerformanceObserver</span> est utilisé par 6 à 7 % des sites suivis, selon le type d’appareil. Ces sites utiliseront les API de bas niveau pour créer des mesures personnalisées et l’API <span lang="en">PerformanceObserver</span> pour les rassembler, puis les utiliseront éventuellement avec d’autres outils de rapport de performance. De tels taux d’adoption pourraient indiquer la tendance à s’appuyer sur des mesures prédéfinies (par exemple, provenant de Lighthouse), mais sont également impressionnants pour une API relativement spécialisée.

## Conclusion

L’UX n’est pas seulement un continuum, mais dépend également d’une grande variété de facteurs. Pour tenter de comprendre l’état de la performance sans exclure les expériences inférieures et défavorisées, nous devons l’aborder de manière intersectionnelle. Chaque visite de site web raconte une histoire. Notre statut socio-économique personnel et celui de notre pays dictent le type de matériel et de fournisseur d’accès Internet que nous pouvons nous permettre. Notre lieu de résidence a une incidence sur la latence (nous, Australiens, ressentons régulièrement cette douleur), et l’économie dicte la couverture disponible du réseau cellulaire. Quels sont les sites web que nous visitons ? Pourquoi les visitons-nous ? Le contexte est essentiel non seulement pour analyser les données, mais aussi pour développer l’empathie et l’attention nécessaires à l’élaboration d’expériences accessibles et rapides pour tous.

En surface, nous avons vu des signaux optimistes concernant les nouvelles mesures de performance que sont les Signaux Web Essentiels. Au moins la moitié des expériences sont bonnes sur les ordinateurs de bureau et les appareils mobiles, _si_ nous ne nous focalisons pas à des expériences systématiquement mauvaises sur les réseaux plus lents pour le <span lang="en">Largest Contentful Paint</span>. Bien que les nouvelles mesures puissent suggérer que les problèmes de performance soient en train d’être résolus, l’absence d’améliorations significatives du <span lang="en">First Contentful Paint</span> et du <span lang="en">Time to First Byte</span> donne à réfléchir. Ce sont les mêmes types de réseaux qui sont les plus désavantagés que pour le <span lang="en">Largest Contentful Paint</span>, ainsi que les connexions rapides et les ordinateurs de bureau. Le score de performance montre également une baisse de la vitesse (ou peut-être une représentation plus précise que ce que nous avons mesuré dans le passé).

Ce que les données nous montrent, c’est que nous devons continuer à investir dans l’amélioration des performances dans certains cas (tels qu’une connectivité plus lente) que nous ne connaissons souvent pas en raison de multiples aspects de notre privilège (pays à revenu moyen ou élevé, salaires élevés et nouveaux appareils performants). Il souligne également qu’il reste encore beaucoup à faire dans les domaines de l’accélération des premiers rendus (LCP et FCP) et de la livraison des ressources (TTFB). Souvent, les performances sont considérées comme une question intrinsèquement <span lang="en">front-end</span>, alors que de nombreuses améliorations importantes peuvent être réalisées en aval et grâce à des choix d’infrastructures appropriés. Là encore, l’expérience d’utilisation est un continuum qui dépend de divers facteurs, et nous devons la traiter de manière globale.

Les nouvelles mesures apportent de nouvelles manières d’analyser l’expérience d’utilisation, mais nous ne devons pas oublier les signaux existants. Concentrons-nous sur les domaines qui ont le plus besoin d’être améliorés et qui entraîneront des changements positifs dans l’expérience des personnes les plus mal desservies. Un internet rapide et accessible est un droit humain.
