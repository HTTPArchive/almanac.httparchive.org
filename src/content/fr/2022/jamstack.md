---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Jamstack
description: Le chapitre Jamstack de l'Almanach du Web 2022 couvre la quantification des sites Jamstack, la croissance de Jamstack, les frameworks de Jamstack et l'hébergement.
hero_alt: Hero image of the Web Almanac chracters using a large gas cylinder with script markings on the front to inflate a web page.
authors: [seldo, whitep4nth3r]
reviewers: [tunetheweb]
analysts: [seldo, tunetheweb]
editors: [DesignrKnight]
translators: [Xav83]
seldo_bio: Laurie est développeur web depuis 1996, avec des pauses occasionnelles pour trouver des entreprises comme <a hreflang="en" href="https://www.crunchbase.com/organization/snowball-factory">awe.sm</a> (2010) et <a hreflang="en" href="https://npmjs.com/">npm</a> (2014). Il travaille actuellement  en tant qu 'Évangéliste de données chez <a hreflang="en" href="https://netlify.com">Netlify</a>. Il adore créer des sites plus grands et meilleurs. Il pense qu'un des meilleurs moyens de faire cela est d'encourager plus de personnes à faire du développement web, en leur enseignant les techniques existantes et en construisant les outils et les services qui rendent le développement web plus facile, afin qu'ils aient moins de choses à apprendre.
whitep4nth3r_bio: Salma écrit du code pour votre divertissement. Elle est une live streameuse, ingénieure logicielle et formatrice de développeurs, et aime aider les gens à se lancer dans la technologie. Après une carrière de professeur de musique et de comedienne, Salma a fait la transition vers la technologie en 2014, se spécialisant dans le développement front-end et le leadership technologique pour les startups, les agences et le commerce électronique mondial. Elle travaille actuellement dans les relations avec les développeurs. <a hreflang="en" href="https://twitch.tv/whitep4nth3r">Suivez Salma sur Twitch</a> pour voir ce qu'elle construit actuellement.
results: https://docs.google.com/spreadsheets/d/1yfNaj25ToezMwQLKdYP6Qh7AUoX9zMdKMSRVC8JlZMY/
featured_quote: Même si nous ne pouvons pas revendiquer savoir exactement quel pourcentage du web est Jamstack, nous pouvons dire qu'environ 3% du web est Jamstack-y, et que ce groupe a grandi fortement lors des 3 dernières années - un grand signe pour la communauté Jamstack.
featured_stat_1: ~3%
featured_stat_label_1: Sites Jamstack-y sur le web en 2022
featured_stat_2: 106%
featured_stat_label_2: Croissance des sites Jamstack-y depuis 2020
featured_stat_3: 36%
featured_stat_label_3: Sites Jekyll qui sont Jamstack-y
---

## Introduction

Un des plus gros problèmes en écrivant à propos de Jamstack, c'est définir qu'est-ce que la Jamstack est, exactement. Ici, nous avons trois différentes définitions (nous avons mis l'emphase sur certains mots):

1. Des sites rapides et sécurisés et des applications délivrées en fichiers de pré-rendus et les servant directement depuis un RDC, supprimant la nécessité de gérer un exécuter des serveurs web.

2. Jamstack est une **architecture** désignée pour rendre le web **plus rapide**, plus sécurisé, et plus facile à mettre à l'échelle. Il est construit sur de nombreux outils et flux de travail que les développeurs adorent, et qui apportent un maximum de productivité.

3. Jamstack est une **approche architecturale** qui **découple**  la couche d'expérience web de la donnée et de la logique utilisateur, améliorant la flexibilité, la capacité de mise à l'échelle, **la performance**, et la maintenabilité.

Les trois définition précédentes viennent de <a hreflang="en" href="https://jamstack.org/">Jamstack.org</a>: respectivement en <a hreflang="en" href="https://web.archive.org/web/20200331214426/https://jamstack.org/">2020</a>, <a hreflang="en" href="https://web.archive.org/web/20210924115533/https://jamstack.org/what-is-jamstack/">2021</a>, et <a hreflang="en" href="https://web.archive.org/web/20220809174445/https://jamstack.org/">2022</a>. Il est difficile de penser à une source qui fasse plus autorité pour la définition de Jamstack, il est donc juste de dire que la définition est une sorte de cible mouvante.

Mais, comme les mots en gras le démontre, il est clair qu'il y a une certaine continuité: les sites devraient être rapides, ils devraient être pré-rendus, et ils devraient être utilisé avec une approche architectural qui découple "où on récupère vos données" de "comment vous rendez vos données". Même s'il est difficile de trouver une définition précise, les développeurs Jamstack savent ce que vous voulez dire quand vous dites "Jamstack": vous avez un site qui charge rapidement, rend beaucoup de son contenu utile en une fois, à la construction, et récupère des données supplémentaires (si nécessaire) via JavaScript.

<p class="note">Avertissement: les deux auteurs de ce rapport étaient des employés de Netlify. Netlify a inventé le terme Jamstack et détient Jamstack.org. Ce rapport et l'analyse sous-jacente ont été relus et approuvés par d'autres personnes non affilié à Netlify.</p>

## Quantifier la Jamstack: qu'est-ce qui compte?

Mais le problème devient plus compliqué quand vous essayez de créer l'almanach Web 2022. Quand nous avons à faire à des millions de sites web, "Je le saurais quand je le verrais" ne peut pas être votre définition. Comment quantifions-nous la Jamstack? Comment pouvons-nous l'identifier précisément afin que nous puissions apprendre à ce sujet? Commençons par nous poser une série de questions.

### Est-ce que tous les sites statiques sont des sites Jamstack?

Cela devrait être un "oui" évident: si la page est un simple HTML qui est rendu en une seule fois, alors il semble certain que cela devrait être Jamstack. Mais qu'en est-il de toutes ces pages construites par des gens dans les années 90, avant que le JavaScript devienne populaire et que la plupart des sites étaient statiques? Sont-ils Jamstack? On dirait que non, tous les sites statiques ne sont pas des sites Jamstack. Donc nous avons essayé de comprendre pourquoi.

Nous avons atterri sur l'aspect "RDC" de la définition précédente de Jamstack: il n'y a pas de fournisseur spécifique de RDC, mais une partie de la définition est précisément la partie sur le "pré-rendu", qui implique que: vous devez traiter quelque chose, et ensuite le mettre en cache. Donc un site Jamstack doit être mis en cache (peu importe que vous le mettiez en cache vous même, ou que vous utilisiez un RDC).

Cela produit un autre cas particulier: beaucoup de sites sont cachés! Même des sites complètement dynamiques mettent souvent des éléments en cache for quelques minutes, afin d'éviter des pics de chargements, et, de nos jours, beaucoup de sites se servent de RDC, ce qui est intrinsèquement un cache, même si l'architecture du site ne repose sur aucun modèle Jamstack. Donc, quelle est la différence entre un site avec un cache normal, et un site Jamstack? La cacheabilité est une partie, mais que faut-il d'autre?

### Est-ce qu'un site Jamstack doit utiliser du JavaScript?

Nous avons décidé qu'un site Jamstack ne doit pas nécessairement utiliser du JavaScript. Beaucoup de sites Jamstack le font, bien sûr: le "J" de Jamstack a été utilisé pour représenter "JavaScript", après tout. Mais, même la plus vieille des définition de Jamstack disait explicitement que l'utilisation du JavaScript était optionnel – un site complètement statique sans JavaScript est bien toujours Jamstack.

### Est-ce qu'utiliser la Jamstack signifie utiliser un framework spécifique?

Il y a définitivement plusieurs frameworks auxquels les gens pensent quand ils pensent à la Jamstack; à tel point que les versions 2020 et 2021 de l'Almanach du Web [défini la Jamstack exclusivement par les frameworks utilisés](../2021/jamstack), se concentrant sur les Générateurs de Site Statiques (GSS). Cela semble assez logique, mais nous avons pensé que cela représentait des problèmes.

Premièrement, qu'en est-il des frameworks que l'on ne peut pas facilement détecter? Par exemple, <a hreflang="en" href="https://www.11ty.dev/">Eleventy</a>, un choix populaire et en pleine croissance dans la Jamstack, ne laisse aucune trace dans le HTML généré; il est invisible pour l'utilisateur final (par défaut, bien que l'on puisse ajouter un <a hreflang="en" href="https://www.11ty.dev/docs/data-eleventy-supplied/#eleventy-variable">tag de générateur</a> si l'on veut). Sans compter les frameworks qui, disons le poliment, se trompent.

Deuxièmement: il y a beaucoup de frameworks! Il y en a une douzaine de gros et des milliers de petits. Même pour ceux que l'on peut trouver, nous n'avons pas toujours un bon moyen de les détecter. De plus, nous sommes d'accord qu'il est définitivement possible de construire un site qui semble "Jamstack-y" sans utiliser de framework. Un HTML pur peut définitivement être Jamstack.

Troisièmement: utiliser un framework qui est populaire avec des développeurs Jamstack ne garantit pas que le site que vous allez construire sera un site Jamstack. Si pour des raisons architecturales, le processus de rendu est très lent, ou que chaque page est rendue dynamiquement, ce ne sera pas un site Jamstack même si vous utilisez le même framework que beaucoup de sites Jamstack. Tous les sites ne doivent pas être Jamstack, et c'est totalement acceptable.

Nous avons donc décidé d'ignorer les frameworks en tant que partie de la définition cette fois, même si, vous verrez plus tard, les frameworks auxquels vous avez pu pensez se trouveront dans les résultats malgré tout.

### Est-ce qu'un site Jamstack doit être performant?

La seule fonctionnalité commune aux trois définitions de la Jamstack était la _performance_. Mais "rapide" est une terme flou quand on parle de site web: si vous avez passé un peu de temps à lire l'Almanach du Web, vous saurait qu'il y a des douzaines de métriques que l'on peut utiliser afin de mesurer la performance d'un site, et qu'il y a beaucoup de bons arguments pour chacune d'entre elles.

Nous avons donc beaucoup réfléchi au ressenti d'un site Jamstack. La première chose a été qu'un site Jamstack rend son contenu initial très rapidement. De tous les métriques que nous avons utilisé, nous avons décidé que l'une de celles qui capture le mieux cette idée est <a hreflang="en" href="https://web.dev/articles/lcp">Largest Contentful Paint</a>, ou LCP. C'est une mesure du temps qu'il faut pour rendre l'élément le plus gros de la page. On peut récupérer du contenu en plus avec des API, ou non, et toujours être Jamstack, mais on doit rendre quelque chose de substantiel rapidement.

## Définir les métriques

Si vous n'êtes pas intéressé par les tenants et les aboutissants de comment nous avons choisi une définition précise de la Jamstack que nous pouvons représenter comme des requêtes dans l'archive HTTP, vous pouvez passez les deux prochaines sections, en toute sécurité, et vous diriger vers [la croissance de la Jamstack](#la-croissance-de-la-jamstack). La compréhension de notre méthodologie n'est pas nécessaire afin que vous obteniez des informations exploitables.

Nous savions que nous voulions mesurer: les sites qui chargent la plupart de leur contenu très rapidement, et qui peuvent être mis en cache. Après beaucoup d'expérimentation avec différentes méthodes de mesures, nous sommes parvenus à trouver quelques métriques spécifiques.

**Largest Contentful Paint (LCP)**: nous avons la distribution de nous les temps LCP sur toutes les pages, récupérer la médiane de vrais données utilisateurs provenant du <a hreflang="en" href="https://developer.chrome.com/docs/crux">Rapport Chrome UX</a>, et nous avons décidé que tous les site se trouvant égale ou sous la médiane, comptent comme "changeant la plupart de son contenu assez rapidement". Cela donnait 2.4 secondes sur les appareils portables, et 2.0 secondes sur les appareils de bureau.

**Cumulative Layout Shift (CLS)**: nous avons voulu éviter les sites qui chargent très vite un squelette mais qui prennent ensuite beaucoup plus de temps pour récupérer du vrai contenu. Le plus proche que nous avons pu obtenir est la métrique <a hreflang="en" href="https://web.dev/articles/cls">Cumulative Layout Shift</a>, une mesure qui nous dit combien de fois la structure page "saute" pendant le chargement. Même s'il y a des moyens de tricher sur la mesure CLS, nous pensons toujours que c'est une approximation raisonnable pour ce que nous essayons de mesurer. Nous aimons cette mesure parce que nous sentons que les sites qui "sautent" beaucoup sont aussi ceux qui semblent être le moins "Jamstack-y", un mot que nous allons finir par utiliser souvent. A nouveau, nous avons utilisé la médiane des données du rapport de Chrome UX.

<p class="note">Les données du rapport Chrome UX arrondissent les données CLS à la valeur la plus proche, à 0.05 près, que qui est une honte, car la vrai médiane semble se trouver autour de 0.02-0.03, donc, sur appareil portable, il arrondi à 0, et sur appareil de bureau, cela est arrondi à 0.05. Puisque 0 exclu un énorme nombre de pages, nous avons décidé d'utiliser 0.05 comme le meilleur seuil disponible, à la fois pour les appareils portables et ceux de bureaux.</a>

**Mise en cache**: cela a été particulièrement difficile à quantifier, puisque la plupart des pages d'accueil, même sur les sites Jamstack, demandent des revalidation même si elles sont, en pratique, en cache depuis longtemps. Nous sommes partis sur une combinaison d'entêtes HTTP intégrant `Age`, `Cache-Control`, et `Expires` que nous avons trouvé en commun dans les pages qui pouvaient être en cache pendant longtemps.

Nous avons d'abord pensé que nous avions besoin d'une autre mesure afin d'exclure les "petits" sites – sites qui chargent très rapidement car ce sont juste des pages "A venir bientôt" ou des pages "Hello world" que personne ne visiterait dans la vrai vie – mais les données de l'Archive HTTP est défini par leur <a hreflang="en" href="https://developer.chrome.com/docs/crux/methodology#popularity-eligibility">popularité selon les visites des utilisateurs de Chrome</a>, et très peu de ces sites sont assez souvent visités pour apparaître dans l'échantillon (même si example.com est dedans!).

Une bonne question est: pourquoi ne pas utiliser les valeurs <a hreflang="en" href="https://web.dev/articles/vitals">Core Web Vitals</a> pour ces métriques? Pour LCP, nos valeurs étaient presque les mêmes que CWV. Pour CLS, l'équipe CWV a explicitement <a hreflang="en" href="https://web.dev/defining-core-web-vitals-thresholds/#achievability-3">assoupli les exigences</a> (leur seuil est plus du double de la médiane) ce qui, nous pensions, n'étaient pas représentatif d'une expérience Jamstack. Nous avons donc décidé qu'il était plus équitable de choisir la médiane pour les deux. Et CWV n'a pas de métrique pour la "cacheabilité".

## "Jamstack-y": un avertissement

Nous voulons être clairs: Il s'agit d'une définition très très flou de "Jamstack". En fait, nous avons commencé à utiliser le terme "Jamstack-y" en faisant ce travail.

La plus grosse source d'erreur est fondamentale: la définition de la Jamstack est à propos d'_architecture_, mais l'architecture n'est pas quelque chose que nous pouvons déterminer en déroulant minutieusement le HTML généré, seulement de manière grossière. Il n'y a simplement pas de moyen de regarder un tas de HTML et dire si le front-end et le back-end sont découplés. Dons, nos mesure, même en étant le mieux que nous puissions faire, sont une estimation grossière, et nous ne voulons pas mal la représenter.

Cette méthodologie, à la fois, sous-évalue et sur-évalue le nombre de site Jamstack:

* Si votre site est statique mais n'est pas découplé (par exemple, les sites <a hreflang="en" href="https://www.squarespace.com/">SquareSpace</a> et <a hreflang="en" href="https://www.wix.com/">Wix</a>  sont clairement fortement couplé à leur back-ends) mais sont très performant, nous les avons donc compté à tort.
* Si votre site Jamstack est découplé mais que vous mettez à jour votre contenu très fréquemment, votre stratégie de mise en cache peut être différente de ce que nous avons recherché et nous ne vous avons pas compté.
* Si votre site Jamstack affiche son rendu très lentement, même s'il est bien découplé, votre nombre LCP sera haut et nous ne vous aurons pas compté.
* Inversement, si votre site dynamique non-Jamstack est très rapide, nous avons pu le prendre pour un site Jamstack par erreur.

Malgré tout cela, nous pensons que l'estimation des sites "Jamstack-y" de cette année est une amélioration par rapport à la définition strictement focalisé sur les GSS et donne une meilleure appréhension de où se trouvent réellement le web aujourd'hui, ce qui est, après tout, l'objectif de l'Almanach.

## La croissance de la Jamstack

En appliquant notre nouveau critère, nous avons mesuré le pourcentage des sites dans l'Archive HTTP qui peut être qualifié comme "Jamstack". Comme les mesures que nous utilisions en 2020 et 2021 sont très différentes, nous avons aussi re-mesuré ces échantillons en utilisant les définitions de 2022.

{{ figure_markup(
  caption="Sites Jamstack.",
  description="Diagramme à barres montrant le pourcentage de sites Jamstack sur appareils de bureau et portable en 2020, 2021 et 2022. En 2020, il était de 1.7% pour les 2 types d'appareils, en 2021, il était de 2.2% et 2.1% respectivement pour chaque type d'appareil, et en 2022 il était de 2.7% sur les appareils de bureau et de 3.6% sur les appareils portable.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=2132409776&format=interactive",
  sheets_gid="1131487846",
  sql_file="jamstack_counts.sql",
  image="jamstack-counts.png"
  )
}}

Notre conclusion principale est que 3.6% des sites web mobiles en 2022 semblent "Jamstack-y" et que cette tendance a augmenté de plus de 100% depuis 2020. Sur appareil de bureau, 2.7% des sites sont Jamstack-y et ce nombre est aussi en augmentation, la différence entre les deux groupes étant conduite principalement par un nombre différent de sites atteignant le seuil CLS, qui varie beaucoup par appareil à cause des différences de mise en page. Vous pouvez encore voir ci-dessus les différentes mises en garde en rapport avec la manière dont nous avons approximé ces résultats.

Les chiffres historiques, avec cette nouvelle définition, sont [considérablement plus élevé que ceux mesuré l'année dernière](../2021/jamstack#adoption-of-ssgs) quand nous nous basions seulement sur l'adoption pure des technologies utilisées. Ce n'est peut être pas surprenant quand nous considérons les limites à détecter certaines technologies, couplées avec l'inclusion de technologies qui n'étaient précédemment pas considérés comme Jamstack.

Quand nous, en tant qu'humain, avons échantillonné aléatoirement les sites dans l'ensemble que nous avons identifiés, nous avons surtout été satisfait de trouver des sites qui, avec notre meilleur capacité d'analyse, semblaient et ressemblaient à ce que des sites Jamstack sont censés être.

Afin que vous puissiez juger par vous mêmes, et pour être totalement honnête, voici les 10 sites "Jamstack-y" de notre échantillon, sélectionné de manière complètement aléatoire, sans aucune retouche:

- <a hreflang="en" href="https://www.cazador-del-sol.de/">www.cazador-del-sol.de</a>
- <a hreflang="en" href="https://snpbooks.org/">snpbooks.org</a>
- <a hreflang="en" href="https://eikounoayumi.jp/">eikounoayumi.jp</a>
- <a hreflang="en" href="https://rochesteronline.precollegeprograms.org/">rochesteronline.precollegeprograms.org</a>
- <a hreflang="en" href="https://surveyforcustomers.com/">surveyforcustomers.com</a>
- <a hreflang="en" href="https://www.shopmate.eu/">www.shopmate.eu</a>
- <a hreflang="en" href="https://docs.saleor.io/">docs.saleor.io</a>
- <a hreflang="en" href="https://www.wildeyebrewing.ca/">www.wildeyebrewing.ca</a>
- <a hreflang="en" href="https://360insurancegroup.com/">360insurancegroup.com</a>
- <a hreflang="en" href="https://144onthehill.co.uk/">144onthehill.co.uk</a>

Que ce soit exactement 3.6% (ou 2.7% sur appareil de bureaux) du web qui soit Jamstack - ce que, parce que la définition de la Jamstack repose sur des choix architecturaux que nous ne pouvons vérifier, nous ne pouvons pas affirmer - ce dont nous pouvons être sûr, c'est que la Jamstack grandi.Le pourcentage des site qui répondent à tous les critères, a continué de grandir, année après année. Le web devient de plus en plus "Jamstack-y".

Bien sûr, puisque notre définition est composée de deux métriques de performance et d'une métrique de mise en cache, une raison pour laquelle nous pourrions avoir tort viendrait du fait que le web soit devenu plus performant en général. Afin de vérifier cela, nous divisons les métriques (c'est des données concernant les appareils portables; les données concernant les appareils de bureaux n'était pas significativement différentes):

{{ figure_markup(
  caption="Changement dans les métriques Jamstack au cours du temps pour les appareils portables.",
  description="Graphique en ligne montrant les changements des trois métriques Jamstack en 2020, 2021 et 2022. Après avoir été largement constant entre 2020 et 2021, le pourcentage de CLS a augmenté au cours de la dernière année (de 48% à 61%), comme l'a été le LCP dans une moindre mesure (de 44% à 50%). Le pourcentage de cacheabilité est resté constant, à 11%, au cours des trois années.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=806511079&format=interactive",
  sheets_gid="1068922155",
  sql_file="percentage_jamstack_criteria_per_year.sql",
  image="changes-in-jamstack-counts-over-time.png"
  )
}}

Comme vous pouvez le voir, il y a eu de légères améliorations dans nos métriques de 2020 à 2022. Cependant, même les plus petits nombres ici - le pourcentage des sites qui répondent à notre critère de mise en cache - est de 11-14% du web, en fonction de l'année et des appareils que nous regardons. Notre ensemble de sites Jamstack est l'intersection de ces deux ensembles; l'ensemble des sites qui répondent aux trois critères à la fois est beaucoup plus petits que chacun des ensembles individuels.

Donc, nous avons vraiment regardé à chacun des sous-ensembles distincts des sites, et l'ensemble grandi bien plus rapidement que la performance du web le fait dans son ensemble. Nous ne mesurons pas juste "combien de sites rapides il y a".

## Les frameworks Jamstack-y

Étant satisfait du fait que les sites Jamstack-y sont vraiment réels et identifiables, nous pouvons maintenant nous poser quelques questions à leur sujet. C'est  là où ça devient amusant: parce que notre définition de Jamstack-y n'inclut pas de framework, nous pouvons regarder tous ces sites et voir quels sont les frameworks qui apparaissent le plus souvent dans la Jamstack.

Nous avons utilisé les identifiants de framework fourni par Wappalyzer, ce qui signifie que (comme nous l'avons mentionné plus tôt) certains des frameworks "invisibles" comme Eleventy ne peuvent pas être comptés ou analysés.

Wappalyzer a une distinction arbitraire entre les "frameworks web" et les "frameworks JavaScript". Voici le top 10 des frameworks JavaScript pour la totalité du web:

{{ figure_markup(
  caption="Frameworks JavaScript utilisés par tous les sites.",
  description="Graphique en barre montrant que React est utilisé par 8.2% des sites Jamstack sur appareils de bureaux et par 8.1% des sites Jamstack sur appareil portable, GSAP l'est par 6.9% et 7.7% respectivement, Vue.js par 3.1% et 2.8%, RequireJS par 2.3% et 2.3%, styled-components par 1.9% et 1.8%, Handlebars par 1.8% et 1.5%, Backbone.js par 1.7% et 1.4%, AngularJS par 1.4% et 1.1%, Mustache par 1.1% et 1.3%, et enfin MooTools est utilisé par 0.9% des sites Jamstack sur appareils de bureaux et par 1.1% des sites Jamstack sur appareil portable.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=1813867996&format=interactive",
  sheets_gid="496656547",
  sql_file="jamstack_javascript_frameworks.sql",
  image="all-sites-javascript-frameworks.png",
  width=600,
  height=489
  )
}}

Et voici le top 10 des sites Jamstack:

{{ figure_markup(
  caption="Frameworks JavaScript utilisés par des sites Jamstack.",
  description="Graphique en barre montrant que React est utilisé par 12.0% des sites Jamstack sur appareils de bureaux et par 12.5% des sites Jamstack sur appareil portable, GSAP par respectivement 6.4% et 7.3%, Stimulus par 6.0% et 5.6%, RequireJS par 3.4% et 4.5%, Vue.js par 2.3% et 1.9%, styled-components par 1.5% et 1.6%, Mustache par 0.7% et 1.8%, AMP par 1.0% et 1.5%, Emotion par 1.3% et 0.8%, et enfin Gatsby est utilisé par 1.2% des sites Jamstack sur appareils de bureaux et par 0.8% des sites Jamstack sur appareil portable.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=691994111&format=interactive",
  sheets_gid="496656547",
  sql_file="jamstack_javascript_frameworks.sql",
  image="jamstack-javascript-frameworks.png",
  width=600,
  height=489
  )
}}

Vous pouvez voir que React est le plus populaire dans la Jamstack et dans le web en général, ainsi que Gatsby. Maintenant regardons les "frameworks web", comme les définit arbitrairement Wappalyzer:

{{ figure_markup(
  caption="Frameworks web utilisé par tous les sites.",
  description="Graphique en barre montrant que Microsoft ASP.NET est utilisé par 8.4% des sites sur appareils de bureaux et par 6.7% des sites sur appareil portable, Ruby on Rails par respectivement 1.4% et 1.1%, Laravel par 1.0% et 1.0%, Express par 0.8% et 0.7%, Next.js par 0.8% et 0.7%, CodeIgniter par 0.7% et 0.7%, Nuxt.js par 0.5% et 0.4%, Django par 0.3% et 0.3%, Helix Ultimate par 0.3% et 0.3%, et enfin Yii est utilisé par 0.3% des sites sur appareils de bureaux et par 0.2% des sites sur appareil portable.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=193748603&format=interactive",
  sheets_gid="1751614355",
  sql_file="jamstack_web_frameworks.sql",
  image="all-sites-web-frameworks.png",
  width=600,
  height=493
  )
}}

Une bonne question ici est: pourquoi Next.js et Nuxt.js sont considérés comme des frameworks web, mais Vue.js et React sont considérés comme des frameworks JavaScript? Mais, en laissant ça de côté, nous voyons que le framework Microsoft's ASP.Net est extrêmement populaire à travers le web, ainsi que Ruby on Rails. A quoi est-ce que cela ressemble dans la Jamstack ?

{{ figure_markup(
  caption="Framework web utilisé par des sites Jamstack.",
  description="Graphique de barre montrant que Microsoft ASP.NET est utilisé par 3.5% des sites Jamstack sur appareils de bureaux et par 3.1% des sites Jamstack sur appareil portable, Symfony par respectivement 2.1% et 1.8%, Next.js par 1.8% et 1.4%, Ruby on Rails par 0.7% et 0.8%, Nuxt.js par 0.6% et 0.4%, CodeIgniter par 0.4% et 0.4%, Django par 0.4% et 0.3%, Express par 0.4% et 0.3%, et enfin Laravel et Yii sont utilisé par 0.2% ) la fois pour les sites Jamstack sur appareils de bureaux et portable.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=1904684465&format=interactive",
  sheets_gid="1751614355",
  sql_file="jamstack_web_frameworks.sql",
  image="jamstack-web-frameworks.png",
  width=600,
  height=493
  )
}}

Comme vous pouvez le voir, même si le numéro un des framework web reste inchangé, ASP.Net est bien moins populaire dans la Jamstack, tout comme Ruby on Rails. En revanche, le favori de la Jamstack, Next.js, grimpe de la cinquième à la troisième place, et Nuxt.js passe de la septième place à la cinquième place. Une autre surprise est Symfony, qui n'est pas dans le top concernant tous les sites (il est 11ème) mais grimpe jusqu'à la seconde place dans l'ensemble Jamstack.

Puisque Next.js et Nuxt.js sont deux des plus gros frameworks dans la communauté Jamstack, ce n'est pas une grosse surprise, mais il était encore appréciable de voir notre définition framework-agnostique correctement identifiée les sites "Jamstack-y".

A première vue, il peut sembler surprenant que ASP.Net est encore #1 dans le groupe Jamstack-y, et encore plus étonnant de voir Symfony (basé sur PHP) arrivé #2. Mais il n'y a aucune raison vous empêchant de construire un site moderne et performant en utilisant ASP.NET ou PHP: Jamstack est une approche architecturale, non une liste de technologies spécifiques, nous espérons donc que ceux travaillant avec ces technologies moins tendance seront encouragés par ces résultats.

Qu'en est-il des GSS? Wappalyzer les a dans une catégorie séparée: voici les nombres pour les sites Jamstack-y et les sites en général (note: nous avons ajouté Nuxt.js et Next.js manuellement dans cette liste; Wappalyzer ne les considère pas comme GSS mais ils peuvent tous les deux être utilisés de cette manière et nous avons pensé qu'il serait utile de les considérer). Voici les données pour tous les sites:

{{ figure_markup(
  caption="GGS utilisés et détectables par tous les sites.",
  description="Graphique de barre montrant que Next.js est utilisé par 0.74% des sites pour les appareils de bureau et 0.63% pour les sites sur les appareils portables, Nuxt.js respectivement par 0.45% et 0.40%, Gatsby par 0.22% et 0.21%, Hugo par 0.09% et 0.06%, Jekyll par 0.07% et 0.03%, Docusaurus par 0.02% et 0.01%, Hexo par 0.02% et 0.00%, Gridsome par 0.01% et 0.01%, et enfin SitePad et Astro sont utilisés à 0.00% à la fois par les sites pour appareils portables et portables.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=582270948&format=interactive",
  sheets_gid="1299424402",
  sql_file="jamstack_ssgs.sql",
  image="all-sites-web-frameworks.png",
  width=600,
  height=496
  )
}}

Et voilà les données pour les sites Jamstack:

{{ figure_markup(
  caption="GSS détectables et utilisés par les sites Jamstack.",
  description="Graphique de barre montrant que Next.js est utilisé par 1.79% des sites Jamstack sur les appareils de bureau et par 1.40% des sites Jamstack sur les appareils portables, Gatsby respectivement par 1.19% et 0.81%, Hugo par 0.77% et 0.49%, Jekyll par 0.85% et 0.34%, Nuxt.js par 0.56% et 0.41%, Docusaurus par 0.19% et 0.09%, Hexo par 0.16% et 0.04%, Gridsome par 0.05% et 0.03%, Octopress par 0.02% et 0.01%, et enfin Astro est utilisé par 0.02% des sites Jamstack sur les appareils de bureau et par 0.01% des sites Jamstack sur les appareils portables.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=1349389169&format=interactive",
  sheets_gid="1299424402",
  sql_file="jamstack_ssgs.sql",
  image="jamstack-web-frameworks.png",
  width=600,
  height=496
  )
}}

Comme vous pouvez le voir, il s'agit à peu près de la même liste, presque dans le même ordre, même si Nuxt descend de quelques places. Cela fait sens intuitivement, puisque l'on s'attendrait à ce que les sites générés par des GSS peuvent être qualifiés comme Jamstack-y, même s'ils ne sont clairement pas le seul moyen d'atteindre cet objectif architectural.

Les GSS représentent aussi un plus gros pourcentage de tous les sites Jamstack que dans l'ensemble de tous les sites, indiquant qu'un GSS est un moyen assez efficace d'avoir un site Jamstack. Cependant, utiliser un GSS ne garantit pas que vous aurez un site Jamstack. Regarder le nombre total de certains de ces frameworks dans notre échantillon:

<figure>
  <table>
    <thead>
      <tr>
        <th>GSS</th>
        <th>Tous les sites</th>
        <th>Les sites Jamstack</th>
        <th>Jamstack %</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Next.js</td>
        <td class="numeric">39,928</td>
        <td class="numeric">2,651</td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>Nuxt.js</td>
        <td class="numeric">24,600</td>
        <td class="numeric">824</td>
        <td class="numeric">3%</td>
      </tr>
      <tr>
        <td>Gatsby</td>
        <td class="numeric">12,014</td>
        <td class="numeric">1,765</td>
        <td class="numeric">15%</td>
      </tr>
      <tr>
        <td>Hugo</td>
        <td class="numeric">5,071</td>
        <td class="numeric">1,135</td>
        <td class="numeric">22%</td>
      </tr>
      <tr>
        <td>Jekyll</td>
        <td class="numeric">3,531</td>
        <td class="numeric">1,259</td>
        <td class="numeric">36%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="GSS en tant que pourcentage des sites Jamstack sites (sur appareils de bureau).",
      sheets_gid="1299424402",
      sql_file="jamstack_ssgs.sql",
    ) }}
  </figcaption>
</figure>

Pour tous les GSS, le pourcentage de sites qui peuvent être qualifiés comme Jamstack-y selon notre définition est inférieur au nombre total de sites utilisant ce framework. Jekyll fait le mieux avec plus d'un tiers des sites Jekyll qui répondent aussi à nos critères. Next et Nuxt ont des pourcentages assez bas ce qui est attendu puisque même s'ils peuvent être utilisés comme GSS, ils sont aussi fréquemment utilisés pour faire des sites dynamiques et nous n'avons pas de moyen de déterminer dans quel mode ils sont configurés.

## L'hébergement Jamstack-y

Nous nous sommes aussi intéressés à où les gens hébergent leur site Jamstack-y. Y a-t-il un motif? Encore une fois, nous avons utilisé les données de Wappalyzer afin d'identifier les technologies, cette fois en utilisant la catégorie Plateforme en tant que service(Paas).

{{ figure_markup(
  caption="Les PaaS utilisées par tous les sites.",
  description="Graphique en barre montrant que Amazon Web Services est utilisé par 7.2% des sites sur les appareils de bureau et par 5.9% des sites sur les appareils portables, WP Engine respectivement par 1.7% et 1.1%, Azure par 1.1% et 0.9%, WordPress.com par 0.8% et 1.1%, SiteGround par 0.7% et 0.6%, Heroku par 0.4% et 0.3%, Kinsta par 0.4% et 0.3%, Flywheel par 0.3% et 0.2%, Aruba.it par 0.2% et 0.4%, et finalement Netlify est utilisé par 0.3% des sites sur les appareils de bureau et par 0.2% des sites sur les appareils portables.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=966567769&format=interactive",
  sheets_gid="351874654",
  sql_file="jamstack_paas.sql",
  image="all-sites-paas.png",
  width=600,
  height=473
  )
}}

Et voici les données correspondant aux sites Jamstack:

{{ figure_markup(
  caption="Les PaaS utilisées par les sites Jamstack.",
  description="Graphique de bar montrant que Amazon Web Services est utilisé par 10.8% des sites Jamstack sur les appareils de bureau et par 9.4% des sites Jamstack sur les appareils portables, GitHub Pages respectivement par 4.6% et 2.0%, Netlify par 2.4% et 1.7%, Pantheon par 2.1% et 1.7%, Vercel par 1.6% et 1.1%, Acquia Cloud Platform par 1.4% et 1.2%, Cloudways par 0.7% et 0.9%, Azure par 0.7% et 0.7%, Platform.sh par 0.4% et 0.3%, et enfin Heroku par 0.3% des sites Jamstack sur les appareils de bureau et par 0.2% des sites Jamstack sur les appareils portables.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSVe-RPqA23n5VYyvNGcmljPDWPhiBqlMFOQFp5vc4CKT_u5Zd6cldCKUVg56FoqRyaarvvMTs-uY4c/pubchart?oid=437110555&format=interactive",
  sheets_gid="351874654",
  sql_file="jamstack_paas.sql",
  image="jamstack-paas.png",
  width=600,
  height=473
  )
}}

Le géant du web Amazon Web Services est, sans surprise, dominant sur les deux ensembles, mais il y a des différences significatives entre les préférences globales et ceux des développeurs Jamstack-y.

WP Engine, Azure, et WordPress.com, extrèmement populaire sur le web, en général, perdent significativement en popularité dans l'ensemble Jamstack. GitHub pages, qui est #11 sur le web en général, est #2 dans l'ensemble Jamstack. Pendant ce temps, Netlify et Vercel, chouchous des développeurs Jamstack, occupent les places #3 et #5, alors que au niveau global du web, Netlify est à la place #10 et Vercel est #14 (non affiché). Pantheon et Acqui Cloud Platform, qui ne sont pas dans le top 10 général, font un saut significatif de la 11ème à la 4ème place et de la 12ème à la 6ème place respectivement.

Le changement de popularité relative de certains de ces hébergements par rapport au web en général est peut être surprenant étant donné qu'ils ne sont pas tous des noms familiers, donc nous avons pensé qu'il serait intéressant de regarder comment les préférences de plateformes ont changé entre 2021 et 2022 dans nos ensembles. En utilisant des données sur les appareils portables, voici comment le pourcentage des sites Jamstack utilisant diverses plateformes ont changé entre 2021 et 2022:

<figure>
  <table>
    <thead>
      <tr>
        <th>PaaS</th>
        <th class="numeric">2021</th>
        <th class="numeric">2022</th>
        <th>Changement</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Amazon Web Services</td>
        <td class="numeric">7.00%</td>
        <td class="numeric">9.45%</td>
        <td class="numeric">2.45%</td>
      </tr>
      <tr>
        <td>GitHub Pages</td>
        <td class="numeric">2.62%</td>
        <td class="numeric">1.99%</td>
        <td class="numeric">-0.63%</td>
      </tr>
      <tr>
        <td>Pantheon</td>
        <td class="numeric">1.97%</td>
        <td class="numeric">1.70%</td>
        <td class="numeric">-0.27%</td>
      </tr>
      <tr>
        <td>Netlify</td>
        <td class="numeric">1.68%</td>
        <td class="numeric">1.72%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>Acquia Cloud Platform</td>
        <td class="numeric">1.37%</td>
        <td class="numeric">1.18%</td>
        <td class="numeric">-0.20%</td>
      </tr>
      <tr>
        <td>Vercel</td>
        <td class="numeric">0.50%</td>
        <td class="numeric">1.10%</td>
        <td class="numeric">0.60%</td>
      </tr>
      <tr>
        <td>Cloudways</td>
        <td></td>
        <td class="numeric">0.91%</td>
        <td class="numeric">N/A</td>
      </tr>
      <tr>
        <td>Azure</td>
        <td></td>
        <td class="numeric">0.67%</td>
        <td class="numeric">N/A</td>
      </tr>
      <tr>
        <td>Platform.sh</td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.29%</td>
        <td class="numeric">0.02%</td>
      </tr>
      <tr>
        <td>Heroku</td>
        <td class="numeric">0.28%</td>
        <td class="numeric">0.22%</td>
        <td class="numeric">-0.05%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="GSS en tant que pourcentage de sites Jamstack (sur appareils de bureau).",
      sheets_gid="1299424402",
      sql_file="jamstack_ssgs.sql",
    ) }}
  </figcaption>
</figure>

GitHub Pages, Pantheon, Acquia Cloud Platform et Heroku apparaissent tous comme déclinant en popularité en tant que choix pour héberger un site Jamstack, alors que AWS, Netlify, Vercel, et Platform.sh deviennent de plus en plus populaire. A noter que Cloudways ou Azure ne sont pas dans les données Paas de 2021, nous ne pouvons donc pas les comparer. Nous pouvons supposer que AWS, Netlify et Vercel sont en train de grandir en popularité parce qu'ils ne sont pas seulement une offre d'hébergement mais aussi une suite d'outils pour les processus de travail des développeurs.

Absent de toutes les listes de plateformes est le géant du web Cloudflare, qui est catégorisé par Wappalyzer en tant que CDN plutôt que PaaS. Bien que Cloudflare a une offre Paas qui est très Jamstack-y, appelé Cloudflare Pages, les données de Wappalyzer ne font pas de distinctions entre "hébergé par un CDN" et "héberge des éléments sur ce CDN", et donc nous n'avons pas pu l'inclure dans cette analyse. L'auteur croit que Cloudflare est une option très populaire d'hébergement de sites Jamstack, mais nous n'avons aucune donnée permettant de vérifier cela.

## Conclusion

La leçon la plus importante que nous avons retenu de l'analyse de cette année est que la Jamstack est difficile à mesurer seulement en regardant les données de l'Archive HTTP. Néanmoins, notre capacité à utiliser une approche de mesure qui était agnostique à la fois à propos de la plateforme et du framework ainsi que notre capacité à trouver des dans les données résultantes, de fortes corrélation en rapport avec des plateformes et des frameworks Jamstack "connus" était un signe encourageant que nous avons fait des progrès dans notre manière d'identifier les sites Jamstack dans l'Archive.

Même si nous ne pouvons clamer savoir exactement quel pourcentage du web est Jamstack, nous pouvons dire qu'environ 3% du Web est Jamstack-y, et que ce groupe a fortement grandi durant les 3 dernières années - un grand signe pour la communauté Jamstack.

Nous avons aussi trouvé que certains frameworks et que certaines plateformes d'hébergement sont plus populaires dans les sites Jamstack que dans le reste du web. Cela peut venir du fait qu'ils sont meilleurs pour répondre à nos critères, ou cela peut aussi venir des développeurs Jamstack qui peuvent avoir une préférence pour ces outils en particulier.

Bien sûr, si la communauté Jamstack préfère certaines plateformes et frameworks, cela devient une tendance auto-alimenté: il y aura plus de documentation et de tutoriels sur comment obtenir des sites Jamstack utilisant ces outils, ce qui, à son tour, rendra plus simple la construction de site Jamstack utilisant ces outils. Donc, bien que nous pensions (et les données le démontrent) que vous pouvez atteindre des résultats Jamstack-y avec n'importe quelle technologies, nous espérons que vous trouverez ces données utiles pour identifier les outils et les plateformes qui peuvent vous permettre facilement d'avoir un site Jamstack.

Nous pensons aussi que la dernière leçon intéressante de cet exercice de quantification de "ce qui compte en tant que Jamstack" est que maintenant, en tant que développeur, vous avez une cible plus claire vers laquelle aller lorsque vous construisez un site Jamstack. Cela ne veut pas dire que vous devez choisir un framework puis ensuite l'oublier: l'important est le résultat. En analysant vos temps LCP et CLS, vous pouvez quantifier si vos efforts sont "Jamstack-y", ce qui est une chose utile si vous pouvez l'automatiser.
