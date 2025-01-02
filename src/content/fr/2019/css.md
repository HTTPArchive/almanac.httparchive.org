---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: Chapitre CSS du Web Almanac 2019, couvrant les couleurs, unités, sélecteurs, mises en page, typographies et polices, espacements, décoration, animation et media queries.
hero_alt: Hero image of Web Almanac characters measuring and painting a web page.
authors: [una, argyleink]
reviewers: [meyerweb, huijing]
analysts: [rviscomi]
editors: [rachellcostello]
translators: [nico3333fr]
discuss: 1757
results: https://docs.google.com/spreadsheets/d/1uFlkuSRetjBNEhGKWpkrXo4eEIsgYelxY-qR9Pd7QpM/
una_bio: Una Kravets est une conférencière internationale basée à Brooklyn, rédactrice technique et <i lang="en">Developer Advocate</i> pour <i lang="en">Material Design</i> chez Google. Una anime la série web <a hreflang="en" lang="en" href="https://www.youtube.com/watch?v=YK8GZBx3hpg">Designing the Browser</a> et le podcast développeur <a hreflang="en" lang="en" href="https://spec.fm/podcasts/toolsday">Toolsday</a>. Suivez-la sur <a href="https://x.com/una">Twitter</a> pour découvrir ses réflexions sur les CSS créatifs, les expériences utilisateurs et les meilleures pratiques de développement web.
argyleink_bio: Adam Argyle est un membre de l’équipe <i lang="en">Google Chrome Developer Relations</i>, spécialisé dans le CSS. C’est un accro du web avec une soif insatiable de super UX & UI. Retrouvez-le sur le web <a href="https://x.com/argyleink">@argyleink</a> ou consultez son site <a hreflang="en" href="https://nerdy.dev">https://nerdy.dev</a>.
featured_quote: Les feuilles de style en cascade (CSS) sont utilisées pour peindre, mettre en forme et organiser visuellement le contenu des pages Web. Leurs capacités couvrent des concepts aussi simples que la couleur du texte ou la perspective 3D. Elles disposent également de possibilités pour permettre aux développeurs de gérer différentes tailles d’écran, différents contextes de visualisation, ainsi que l’impression. CSS aide les développeurs et développeuses à gérer le contenu et à s’assurer qu’il s’adapte correctement aux personnes.
featured_stat_1: 5%
featured_stat_label_1: Pages utilisant les propriétés personnalisées
featured_stat_2: 2%
featured_stat_label_2: Sites qui utilisent CSS Grid
featured_stat_3: 780
featured_stat_label_3: Nombre de chiffres pour la plus grande valeur de z-index
---

## Introduction

Les feuilles de style en cascade (CSS) sont utilisées pour peindre, mettre en forme et organiser visuellement le contenu des pages Web. Leurs capacités couvrent des concepts aussi simples que la couleur du texte ou la perspective 3D. Elles disposent également de possibilités pour permettre aux développeurs de gérer différentes tailles d’écran, différents contextes de visualisation, ainsi que l’impression. CSS aide les développeurs et développeuses à gérer le contenu et à s’assurer qu’il s’adapte correctement aux personnes.

Lorsque vous décrivez CSS à celles et ceux qui ne sont pas familiers avec les technologies Web, il peut être utile de le considérer comme le langage pour peindre les murs de la maison&nbsp;: décrivant la taille et la position des fenêtres et des portes, ainsi que des décorations florissantes telles que du papier peint ou des plantes. La tournure amusante de cette histoire est que, selon la personne qui traverse la maison, un même code peut adapter la maison aux préférences ou aux contextes de cette personne spécifique&nbsp;!

Dans ce chapitre, nous allons inspecter, compter et extraire des données sur la façon dont CSS est utilisé sur le Web. Notre objectif est de comprendre de manière globale quelles fonctionnalités sont utilisées, comment elles sont utilisées et comment CSS se développe et est adopté.

Prêt à fouiller dans des données fascinantes&nbsp;?! Beaucoup des nombres suivants peuvent être petits, mais ne commettez pas l’erreur de les voir comme insignifiants&nbsp;! De nombreuses années peuvent être nécessaires avant que de nouvelles choses s’imposent le Web.

## Couleur

La couleur fait partie intégrante du thème et du style sur le Web. Voyons comment les sites Web ont tendance à l’utiliser.

### Types de couleurs

L’hexadécimal est de loin le moyen le plus populaire de décrire la couleur, avec 93&nbsp;% d’utilisation, suivi par RVB, et enfin HSL. Fait intéressant, les développeurs tirent pleinement parti de la transparence alpha en ce qui concerne ces types de couleurs&nbsp;: HSLA et RGBA sont beaucoup plus populaires que HSL et RGB, avec presque le double d’utilisation&nbsp;! Même si la transparence alpha a été ajoutée plus tard à la spécification Web, HSLA et RGBA sont pris en charge <a hreflang="en" href="https://caniuse.com/#feat=css3-colors">depuis IE9</a>, vous pouvez donc continuer et les utiliser également&nbsp;!

{{ figure_markup(
  image="fig1.png",
  caption="Popularité des formats de couleurs.",
  description="Diagramme à barres montrant l’adoption des formats de couleur HSL, HSLA, RVB, RVBA et hexadécimal. L’hexadécimal est utilisé sur 93&nbsp;% des pages de bureau, RGBA sur 83&nbsp;%, RVB sur 22&nbsp;%, HSLA 19&nbsp;% et HSL 1&nbsp;%. L’adoption sur les ordinateurs de bureau et les appareils mobiles est similaire pour tous les formats de couleur sauf HSL, pour lesquels l’adoption du mobile est de 9&nbsp;% (9 fois plus élevée).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1946838030&format=interactive"
  )
}}

### Sélection de couleurs

Il existe <a hreflang="en" href="https://www.w3.org/TR/css-color-4/#named-colors">148 couleurs CSS nommées</a>, sans compter les valeurs spéciales «`transparent`» et «`currentcolor`». Vous pouvez les utiliser par leur nom de chaîne pour un style plus lisible. Les couleurs nommées les plus populaires sont sans surprise «`black`» et «`white`», suivis de «`red`» et «`blue`».

{{ figure_markup(
  image="fig2.png",
  caption="Top des couleurs nommées.",
  description="Diagramme circulaire montrant les couleurs nommées les plus populaires. Le blanc est le plus populaire à 40&nbsp;%, puis le noir à 22&nbsp;%, le rouge à 11&nbsp;% et le bleu à 5&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1985913808&format=interactive",
  width=600,
  height=415,
  data_width=600,
  data_height=415
  )
}}

La langue impacte également la couleur. Il y a plus d’exemples du «`gray`» américain que du «`grey`» britannique. Presque toutes les instances de <a hreflang="en" href="https://www.rapidtables.com/web/color/gray-color.html">couleurs grises</a> («`gray`», «`lightgray`», «`darkgray`», «`slategray`», etc.) avaient presque le double de l’utilisation en étant orthographiées avec un «a» au lieu d’un «e». Si les «`gray`»/«`grey`» étaient combinés, ils se classeraient plus haut que le bleu, en quatrième place. Cela pourrait expliquer pourquoi «`silver`» est mieux classé que «`grey`» avec un «e» dans les graphiques&nbsp;!

### Nombre de couleurs

Combien de différentes couleurs de polices sont utilisées sur le Web&nbsp;? Ce n’est donc pas le nombre total de couleurs uniques&nbsp;; c’est plutôt le nombre de couleurs différentes utilisées uniquement pour le texte. Les chiffres de ce graphique sont assez élevés et, par expérience, nous savons que sans les variables CSS, l’espacement, les tailles et les couleurs peuvent rapidement vous échapper et se fragmenter en de nombreuses valeurs minuscules dans vos styles. Ces chiffres reflètent une difficulté de gestion du style, et nous espérons que cela vous aidera à créer une perspective à rapporter à vos équipes ou projets. Comment pouvez-vous réduire ce nombre à un montant gérable et raisonnable&nbsp;?

{{ figure_markup(
  image="fig3.png",
  caption="Répartition des couleurs par page.",
  description="202/5000 Distribution montrant les 10e, 25e, 50e, 75e et 90e percentile de couleurs par page sur bureau et mobile. Sur le bureau, la distribution est de 8, 22, 48, 83 et 131. Les pages mobiles ont tendance à avoir plus de couleurs de 1 à 10.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1361184636&format=interactive"
  )
}}

### Duplication des couleurs

Eh bien, nous sommes curieux de savoir combien de couleurs en double sont présentes sur une page. Sans un système CSS de classes réutilisables étroitement gérées, les doublons sont assez faciles à créer. Il s’avère que la médiane contient suffisamment de doublons pour que cela vaille la peine de faire une passe pour les unifier avec des propriétés personnalisées.

{{ figure_markup(
  image="fig4.png",
  caption="Répartition des couleurs en double par page.",
  description="Diagramme à barres montrant la répartition des couleurs par page. La page de bureau médiane a 24 couleurs en double. Le 10e percentile est composé de 4 couleurs en double et le 90e percentile est de 62. Les distributions de bureau et mobiles sont similaires.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=326531498&format=interactive"
  )
}}

## Unités

Avec CSS, il existe de nombreuses façons d’obtenir le même résultat visuel en utilisant différents types d’unités&nbsp;: `rem`, `px`, `em`, `ch`, ou même `cm`&nbsp;! Alors, quels types d’unités sont les plus populaires&nbsp;?

{{ figure_markup(
  image="fig5.png",
  caption="Popularité des types d’unités.",
  description="Diagramme à barres de la popularité de divers types d’unités. `px` et `em` sont utilisés sur plus de 90&nbsp;% des pages. `rem` est le deuxième type d’unité le plus populaire sur 40&nbsp;% des pages et la popularité diminue rapidement pour les types d’unités restants.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=540111393&format=interactive"
  )
}}

### Longueur et taille

Sans surprise, dans la figure 2.5 ci-dessus, `px` est le type d’unité le plus utilisé, avec environ 95&nbsp;% des pages Web utilisant des pixels sous une forme ou une autre (cela peut être la taille des éléments, la taille de la police, etc.). Cependant, l’unité `em` est presque aussi populaire, avec environ 90&nbsp;% d’utilisation. C’est plus de deux fois plus populaire que l’unité `rem`, qui n’a que 40&nbsp;% de fréquence dans les pages Web. Si vous vous demandez quelle est la différence, `em` est basé sur la taille de police parente, tandis que `rem` est basé sur la taille de police de base définie sur la page. Il ne change pas par composant comme `em` pourrait le faire, et permet ainsi d’ajuster uniformément tous les espacements.

En ce qui concerne les unités basées sur l’espace physique, l’unité `cm` (centimètre) est de loin la plus populaire, suivie de `in` (pouces), puis de `Q`. Nous savons que ces types d’unités sont particulièrement utiles pour les feuilles de style d’impression, mais nous ne savions même pas que l’unité `Q` existait avant cette enquête&nbsp;! Et vous&nbsp;?

<aside class="note">Une version antérieure de ce chapitre parlait de la popularité inattendue de l’unité <code>Q</code>. Grâce à la <a hreflang="en" href="https://discuss.httparchive.org/t/chapter-2-css/1757/6">discussion de la communauté</a> concernant ce chapitre, nous avons identifié qu’il s’agissait d’un bogue dans notre analyse et avons mis à jour la figure 2.5 en conséquence.</aside>

### Unités basées sur la taille de fenêtre (<i lang="en">viewport</i> {unites-basees-sur-la-taille-de-fenetre-viewport}

Nous avons constaté des différences plus importantes pour les unités basées sur le <i lang="en">viewport</i> entre les appareils mobiles et les ordinateurs de bureau. 36,8&nbsp;% des sites mobiles utilisent `vh` (hauteur de <i lang="en">viewport</i>), alors que seuls 31&nbsp;% des sites pour ordinateur le font. Nous avons également constaté que `vh` est plus courant que `vw` (largeur de <i lang="en">viewport</i>) d’environ 11&nbsp;%. `vmin` (<i lang="en">viewport</i> minimum) est plus populaire que `vmax` (<i lang="en">viewport</i> maximum), avec environ 8&nbsp;% d’utilisation de `vmin` sur mobile tandis que `vmax` n’est utilisé que par 1&nbsp;% des sites Web.

### Propriétés personnalisées (<i lang="en">custom properties</i>) {proprietes-personnalisees-custom-properties}

Les propriétés personnalisées sont ce que beaucoup appellent les variables CSS. Elles sont cependant plus dynamiques qu’une variable statique classique&nbsp;! Elles sont très puissantes et en tant que communauté, nous découvrons encore leur potentiel.

{{ figure_markup(
  caption="Pourcentage de pages utilisant des propriétés personnalisées.",
  content="5&nbsp;%",
  classes="big-number"
)
}}

Nous avons eu l’impression que c’était une information passionnante, car elle montre une croissance saine de l’un de nos ajouts CSS préférés. Elles étaient disponibles dans tous les principaux navigateurs depuis 2016 ou 2017, il est donc juste de dire qu’elles sont assez récentes. De nombreuses personnes sont encore en train de passer de leurs variables de préprocesseur CSS aux propriétés personnalisées CSS. Nous estimons qu’il faudra encore quelques années avant qu’elles ne deviennent la norme.

## Sélecteurs

### Sélecteurs via ID vs classes

CSS a plusieurs façons pour cibler des éléments dans la page, alors opposons donc les ID et les classes pour voir ce qui est le plus répandu&nbsp;! Les résultats ne devraient pas être trop surprenants&nbsp;: les classes sont plus populaires&nbsp;!

{{ figure_markup(
  image="fig7.png",
  caption="Popularité des types de sélecteurs par page.",
  description="Diagramme à barres montrant l’adoption des sélecteur par ID et par classe. Les classes sont utilisées sur 95&nbsp;% des pages de bureau et mobiles. Les identifiants sont utilisés sur 89&nbsp;% des pages de bureau et 87&nbsp;% des pages mobiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1216272563&format=interactive"
  )
}}

Un bon tableau de suivi tel que celui qui suit, montrant que les classes occupent 93&nbsp;% des sélecteurs trouvés dans une feuille de style.

{{ figure_markup(
  image="fig8.png",
  caption="Popularité des types de sélecteurs, par sélecteur.",
  description="Diagramme à barres montrant que 94&nbsp;% des sélecteurs incluent le sélecteur de classe pour ordinateur de bureau et mobile, tandis que 7&nbsp;% des sélecteurs de bureau incluent le sélecteur par ID (8&nbsp;% pour mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=351006989&format=interactive"
  )
}}

### Sélecteurs par attributs

CSS a des sélecteurs de comparaison très puissants. Ce sont des sélecteurs comme `[target="_blank"]`, `[attribute^="value"]`, `[title~="rad"]`, `[attribute$="-rad"]` ou `[attribut*="valeur"]`. Les utilisez-vous&nbsp;? Vous pensez qu’ils sont beaucoup utilisés&nbsp;? Comparons comment ceux-ci sont utilisés avec les ID et les classes sur le Web.

{{ figure_markup(
  image="fig9.png",
  caption="Popularité des opérateurs par sélecteur d’attribut ID.",
  description="Diagramme à barres montrant la popularité des opérateurs utilisés par les sélecteurs d’attributs d’ID. Environ 4&nbsp;% des pages de bureau et mobiles utilisent `*=` et `^=`. 1&nbsp;% des pages utilisent `=` et `$=`. 0&nbsp;% utilise `~=`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=695879874&format=interactive"
  )
}}

{{ figure_markup(
  image="fig10.png",
  caption="Popularité des opérateurs par sélecteur d’attribut de classe.",
  description="Diagramme à barres montrant la popularité des opérateurs utilisés par les sélecteurs d’attributs de classe. 57&nbsp;% des pages utilisent des `*=`. 36&nbsp;% utilisent `^=`. 1&nbsp;% utilise `=` et `$=`. 0&nbsp;% utilise `~=`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=377805296&format=interactive"
  )
}}

Ces opérateurs sont beaucoup plus populaires avec les sélecteurs de classe que les identifiants, ce qui semble naturel puisqu’une feuille de style a généralement moins de sélecteurs d’identifiants que de sélecteurs de classe, mais il reste agréable de voir les utilisations de toutes ces combinaisons.

### Classes par élément

Avec la montée en puissance des approches CSS comme OOCSS, <i lang="en">Atomic CSS</i> et <i lang="en">functional CSS</i> qui peuvent utiliser 10 classes ou plus sur un élément pour créer son design, peut-être verrions-nous des tendances intéressantes. La requête une fois revenue est malheureusement assez peu intéressante, la médiane sur mobile et ordinateur de bureau étant d’une classe par élément.

{{ figure_markup(
  caption="Le nombre médian de noms de classes par attribut class (bureau et mobile).",
  content="1",
  classes="big-number"
)
}}

## Disposition

### <i lang="en">Flexbox</i> {flexbox}

[Flexbox](https://developer.mozilla.org/docs/Web/CSS/CSS_Flexible_Box_Layout/Concepts_de_base_flexbox) est une disposition qui, une fois appliquée à un conteneur, dirige et aligne ses enfants&nbsp;: c’est-à-dire qu’elle aide à la mise en page d’une manière contraignante. Elle a connu un début assez difficile sur le Web, car sa spécification a subi deux ou trois changements assez drastiques entre 2010 et 2013. Heureusement, elle s’est installée et a été implémentée sur tous les navigateurs en 2014. Compte tenu de cet historique, son taux d’adoption a évolué lentement, mais plusieurs années se sont écoulées depuis&nbsp;! Elle est maintenant très populaire et de nombreux articles à son sujet expliquent comment en tirer parti, mais elle est encore nouvelle comparée à d’autres méthodes de mise en page.

{{ figure_markup(
  image="fig12.png",
  caption="Adoption de Flexbox.",
  description="Graphique à barres montrant que 49&nbsp;% des pages de bureau et 52&nbsp;% des pages mobiles utilisant flexbox.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2021161093&format=interactive"
  )
}}

Un certain succès illustré ici, car près de 50&nbsp;% du Web utilise Flexbox dans ses feuilles de style.

### Grid

Comme Flexbox, [Grid](https://developer.mozilla.org/docs/Web/CSS/CSS_Grid_Layout) a également traversé quelques variantes de spécifications au début de sa durée de vie, mais sans changer les implémentations dans les versions publiques des navigateurs. Microsoft avait Grid dans les premières versions de Windows 8, comme moteur de mise en page principal pour son design à défilement horizontal. Il y a d’abord été éprouvé, transféré vers le Web, puis renforcé par les autres navigateurs jusqu’à sa sortie finale en 2017. Il a connu un lancement très réussi car presque tous les navigateurs ont publié leurs implémentations en même temps, donc les développeurs et développeuses Web se sont réveillés un jour avec un superbe support de Grid. Aujourd’hui, à la fin de 2019, Grid est toujours un jeune premier, car les gens découvrent encore sa puissance et ses capacités.

{{ figure_markup(
  caption="Pourcentage de sites Web utilisant Grid.",
  content="2&nbsp;%",
  classes="big-number"
)
}}

Cela montre à quel point la communauté de développement Web a relativement peu exercé et exploré son dernier outil de mise en page. Nous attendons avec impatience l’avènement de Grid comme moteur de mise en page principal lors de la conception d’un site. Pour nous, auteurs, nous aimons utiliser les grilles&nbsp;: nous les recherchons généralement en premier, puis nous recomposons sa complexité à mesure que nous réalisons et itérons sur la mise en page. Il reste à voir ce que le reste du monde fera de cette puissante fonctionnalité CSS au cours des prochaines années.

### Modes d’écriture

Le Web et CSS sont des fonctionnalités de plate-forme internationale, et les modes d’écriture offrent un moyen pour HTML et CSS d’indiquer la direction de lecture et d’écriture préférées d’un utilisateur ou une utilisatrice dans nos éléments.

{{ figure_markup(
  image="fig14.png",
  caption="Popularité des valeurs de direction.",
  description="Diagramme à barres montrant la popularité des valeurs de direction `ltr` et `rtl`. `ltr` est utilisé par 32&nbsp;% des pages de bureau et 40&nbsp;% des pages mobiles. `rtl` est utilisé par 32&nbsp;% des pages sur ordinateur de bureau et 36&nbsp;% des pages mobiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=136847988&format=interactive"
  )
}}

## Typographie

### Polices web par page

Combien de polices Web chargez-vous sur votre page Web&nbsp;: 0&nbsp;? Dix&nbsp;? Le nombre médian de polices Web par page est de 3&nbsp;!

{{ figure_markup(
  image="fig15.png",
  caption="Répartition du nombre de polices Web chargées par page.",
  description="Répartition du nombre de polices Web chargées par page. Sur les ordinateurs de bureau, les 10e, 25e, 50e, 75e et 90e centiles sont&nbsp;: 0, 1, 3, 6 et 9. Ceci est légèrement supérieur à la distribution mobile qui a une police de moins dans les 75e et 90e centiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1453570774&format=interactive"
  )
}}

### Familles de polices populaires

Une suite naturelle à la question précédente est&nbsp;: de quelles polices s’agit-il&nbsp;?! Concepteurs et conceptrices, approchez-vous, car vous pourrez maintenant voir si vos choix correspondent à ce qui est populaire ou non.

{{ figure_markup(
  image="fig16.png",
  caption="Top des polices web.",
  description="Diagramme à barres des polices les plus populaires. Parmi les pages sur ordinateurs de bureau, ce sont Open Sans (24&nbsp;%), Roboto (15&nbsp;%), Montserrat (5&nbsp;%), Source Sans Pro (4&nbsp;%), Noto Sans JP (3&nbsp;%) et Lato (3&nbsp;%). Sur mobile, les différences les plus notables sont qu’Open Sans est utilisé 22&nbsp;% du temps (contre 24&nbsp;%) et Roboto est utilisé 19&nbsp;% du temps (jusqu’à 15&nbsp;%).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1883567922&format=interactive",
  width=600,
  height=450,
  data_width=600,
  data_height=450
  )
}}

Open Sans est le grand gagnant ici, avec près de 1 déclaration CSS `@font-family` sur 4 le spécifiant. Nous avons définitivement utilisé Open Sans dans des projets d’agences.

Il est également intéressant de noter les différences entre l’adoption des ordinateurs de bureau et des mobiles. Par exemple, les pages mobiles utilisent Open Sans un peu moins souvent que le bureau. En même temps, ils utilisent également Roboto un peu plus souvent.

### Tailles de police

C’est amusant, car si vous demandiez à un utilisateur combien de tailles de police il pense qu’il y a sur une page, il répondra généralement un nombre de 5 ou certainement moins de 10. Est-ce la réalité&nbsp;? Même dans un design system, combien de tailles de police y a-t-il&nbsp;? Nous avons interrogé le Web et avons trouvé que la médiane était de 40 sur mobile et de 38 sur ordinateur. Il serait peut-être temps de réfléchir sérieusement aux propriétés personnalisées ou de créer des classes réutilisables pour vous aider à afficher votre grille typographique.

{{ figure_markup(
  image="fig17.png",
  caption="Répartition du nombre de tailles de police distinctes par page.",
  description="Diagramme à barres montrant la répartition des différentes tailles de police par page. Pour les pages de bureau, les 10e, 25e, 50e, 75e et 90e centiles sont&nbsp;: 8, 20, 40, 66 et 92 comme tailles de police. La distribution de bureau diverge du mobile au 75e centile, où elle est plus grande de 7 à 13 tailles distinctes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1695270216&format=interactive"
  )
}}

## Espacement

### Marges

Une marge est l’espace en dehors des éléments, comme l’espace que vous exigez lorsque vous écartez les bras. On pourrait penser que cela ne sert souvent qu’à l’espacement entre les éléments, mais ce n’est pas limité à cet effet. Dans un site Web ou une application, l’espacement joue un rôle important dans l’expérience d’utilisation et la conception. Voyons combien de code d’espacement de marge il y a  dans une feuille de style, d’accord&nbsp;?

{{ figure_markup(
  image="fig18.png",
  caption="Répartition du nombre de valeurs de marge distinctes par page.",
  description="Diagramme à barres montrant la distribution des valeurs de marge distinctes par page. Pour les pages sur ordinateur de  bureau, les 10e, 25e, 50e, 75e et 90e centiles sont&nbsp;: 12, 47, 96, 167 et 248 valeurs de marge distinctes. La distribution de bureau diverge du mobile au 75e centile, où elle est inférieure de 12 à 31 valeurs distinctes.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=4233531&format=interactive"
  )
}}

C’est beaucoup, semble-t-il&nbsp;! La page de bureau médiane a 96 valeurs de marge distinctes et 104 sur mobile. Cela crée de nombreux cas d’espacements uniques dans votre conception. Nous sommes curieux de savoir&nbsp;: combien de marges avez-vous sur votre site&nbsp;? Comment pouvons-nous rendre tous ces espacements plus gérables&nbsp;?

### Propriétés logiques (<i lang="en">Logical properties</i>) {proprietes-logiques-logical-properties}

{{ figure_markup(
  caption="Pourcentage de pages de bureau et mobiles qui incluent des propriétés logiques.",
  content="0.6&nbsp;%",
  classes="big-number"
)
}}

Nous estimons que l’hégémonie de `margin-left` et `padding-top` sera de durée limitée, bientôt complétée par leur syntaxe de propriété logique. Bien que nous soyons optimistes, l’utilisation actuelle est assez faible à 0,67&nbsp;% d’utilisation sur les pages de bureau. Pour nous, cela ressemble à un changement d’habitude que nous devrons développer en tant qu’industrie, tout en formant, espérons-le, de nouveaux développeurs et développeuses à utiliser la nouvelle syntaxe.

### z-index

La superposition verticale, ou l’empilement, peut être gérée avec `z-index` en CSS. Nous étions curieux de savoir combien de valeurs différentes les gens utilisent pour leurs sites. La plage de ce que `z-index` accepte est théoriquement infinie, limitée uniquement par les limitations des variables du navigateur. Tous ces empilements sont-ils utilisés&nbsp;? Voyons voir&nbsp;!

{{ figure_markup(
  image="fig20.png",
  caption="Distribution du nombre de valeurs distinctes de <code>z-index</code> par page.",
  description="Diagramme à barres montrant la distribution des valeurs de z-index distinctes par page. Pour les pages de bureau, les 10e, 25e, 50e, 75e et 90e centiles sont&nbsp;: 1, 7, 16, 26 et 36 valeurs distinctes. La distribution des ordinateurs de bureau est beaucoup plus élevée que celle des mobiles, avec jusqu’à 16 valeurs distinctes au 90e centile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1320871189&format=interactive"
  )
}}

### Valeurs de z-index populaires

D’après notre expérience de travail, n’importe quel nombre avec des 9 semblait être le choix le plus populaire. Même si nous avons appris à utiliser le plus petit nombre possible, ce n’est pas la norme communautaire. Alors qu’est-ce alors&nbsp;?! Si les gens ont besoin de choses en plus, quels sont les nombres `z-index` les plus populaires&nbsp;? Déposez votre verre, le résultat est tellement drôle que vous pourriez le renverser.

{{ figure_markup(
  image="fig21.png",
  caption="Valeurs <code>z-index</code> les plus fréquemment utilisées.",
  description="Nuage de points de toutes les valeurs de z-index connues et du nombre de fois qu’elles sont utilisées, à la fois pour les ordinateurs de bureau et les mobiles. 1 et 2 sont les plus fréquemment utilisés, mais les autres valeurs populaires explosent par ordre de grandeur: 10, 100, 1 000, et ainsi de suite jusqu’aux nombres avec des centaines de chiffres.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1169148473&format=interactive"
  )
}}

{{ figure_markup(
  caption="La plus grande valeur connue de <code>z-index</code>.",
  content="999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999&nbsp;!important",
  classes="really-big-number"
)
}}

## Décoration

### Filtres

Les filtres sont un moyen amusant et efficace de modifier les pixels que le navigateur a l’intention de dessiner sur l’écran. Il s’agit d’un effet de post-traitement effectué sur une version aplatie de l’élément, du nœud ou du calque auquel il est appliqué. Photoshop les a rendus faciles à utiliser, puis Instagram les a rendus accessibles au grand public grâce à des combinaisons stylisées et sur mesure. Ils existent depuis 2012 environ, il y en a 10 et ils peuvent être combinés pour créer des effets uniques.

{{ figure_markup(
  caption="Pourcentage de pages qui incluent une feuille de style avec la propriété <code>filter</code>.",
  content="78&nbsp;%",
  classes="big-number"
)
}}

Nous avons été ravis de voir que 78&nbsp;% des feuilles de style contiennent la propriété `filter`&nbsp;! Ce nombre était également si élevé qu’il semblait un peu louche, alors nous avons creusé et avons cherché à expliquer le nombre élevé. Parce que, soyons honnêtes, les filtres sont biens, mais ils ne font pas partie de toutes nos applications et projets. Sauf que&nbsp;!

Après une enquête plus approfondie, nous avons découvert que la feuille de style de <a hreflang="en" href="https://fontawesome.com">FontAwesome</a> est livrée avec une utilisation de `filter`, ainsi qu’une intégration <a hreflang="en" href="https://youtube.com">YouTube</a>. Par conséquent, nous pensons que `filter` s’est faufilé par la porte arrière en se mêlant à quelques feuilles de style très populaires. Nous pensons également que la présence de `-ms-filter` aurait également pu être incluse, contribuant au pourcentage d’utilisation élevé.

### Modes de fusion

Les modes de fusion sont similaires aux filtres en ce sens qu’ils sont un effet de post-traitement qui s’exécute sur une version aplatie de leurs éléments cibles, mais qui sont assez singuliers, dans le sens qu’ils se préoccupent de la convergence des pixels. Dit d’une autre manière, les modes de fusion sont la façon dont 2 pixels devraient avoir un impact mutuel lorsqu’ils se chevauchent. Quel que soit l’élément en haut ou en bas, la manière dont le mode de fusion manipule les pixels sera affectée. Il existe 16 modes de fusion - voyons lesquels sont les plus populaires.

{{ figure_markup(
  caption="Pourcentage de pages qui incluent une feuille de style avec la propriété <code>*-blend-mode </code>.",
  content="8&nbsp;%",
  classes="big-number"
)
}}

Dans l’ensemble, l’utilisation des modes de fusion est beaucoup plus faible que celle des filtres, mais elle est encore suffisante pour être considérée comme modérément utilisée.

Dans une prochaine édition du Web Almanac, il serait bien de creuser l’utilisation du mode de fusion pour avoir une idée des modes exacts que les développeurs et développeuses utilisent, comme multiplier, écran, couleur, éclaircir, etc.

## Animation

### Transitions

CSS a ce formidable pouvoir d’interpolation qui peut être simplement utilisé en écrivant une seule règle sur la façon de faire la transition de ces valeurs. Si vous utilisez CSS pour gérer les états de votre application, à quelle fréquence utilisez-vous des transitions pour effectuer la tâche&nbsp;? Interrogeons le Web&nbsp;!

{{ figure_markup(
  image="fig25.png",
  caption="Répartition du nombre de transitions par page.",
  description="Diagramme à barres montrant la répartition des transitions par page. Pour les pages de bureau, les 10e, 25e, 50e, 75e et 90e centiles sont&nbsp;: 0, 2, 16, 49 et 118 transitions. La distribution des ordinateurs de bureau est bien inférieure à celle des mobiles, avec jusqu’à 77 transitions au 90e centile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=419145172&format=interactive"
  )
}}

C’est plutôt bien&nbsp;! Nous avons vu `animate.css` comme une bibliothèque populaire à inclure, qui apporte une tonne d’animations de transition, mais il est toujours agréable de voir que les gens considèrent les effets de transition pour leurs interfaces.

### Animations d’images clés

Les animations d’images clés (<i lang="en">keyframe</i>) CSS sont une excellente solution pour vos animations ou transitions plus complexes. Ils vous permettent d’être plus explicite, ce qui offre un meilleur contrôle sur les effets. Ils peuvent être petits, comme un unique effet, ou être plus complexes avec de nombreux effets composés via <i lang="en">keyframe</i> dans une animation plus riche. Le nombre médian d’animations via <i lang="en">keyframe</i> par page est bien inférieur à celui des transitions CSS.

{{ figure_markup(
  image="fig26.png",
  caption="Répartition du nombre d’images clés par page.",
  description="Diagramme à barres montrant la répartition des images clés par page. Pour les pages mobiles, les 10e, 25e, 50e, 75e et 90e centiles sont&nbsp;: 0, 0, 3, 18 et 76 images clés. La distribution mobile est légèrement supérieure à celle des ordinateurs de bureau, de 6 images clés aux 75e et 90e percentiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=11848448&format=interactive"
  )
}}

## Requêtes de media (<i lang="en">media queries</i>) {requetes-de-media-queries}

Les <i lang="en">media queries</i> permettent à CSS de se connecter à diverses variables au niveau du système afin de s’adapter de manière appropriée à l’utilisation du visiteur. Certaines de ces <i lang="en">media queries</i> peuvent gérer les styles d’impression, les styles d’écran du projecteur et la taille de la fenêtre/de l’écran. Pendant longtemps, les <i lang="en">media queries</i> ont été principalement exploitées pour leur connaissance de la fenêtre d’affichage. Les concepteurs et les développeurs pouvaient adapter leurs mises en page aux petits écrans, aux grands écrans, etc. Plus tard, le Web a commencé à apporter de plus en plus de fonctionnalités et de possibilités, ce qui signifie que les <i lang="en">media queries</i> peuvent désormais gérer les fonctionnalités d’accessibilité en plus des fonctionnalités de la fenêtre.

Un bon point de départ avec les <i lang="en">media queries</i>&nbsp;: combien sont utilisées par page&nbsp;? À combien de moments ou de contextes différents la page type a-t-elle envie de satisfaire&nbsp;?

{{ figure_markup(
  image="fig27.png",
  caption='Répartition du nombre de <i lang="en">media queries</i> par page.',
  description='Diagramme à barres montrant la répartition des <i lang="en">media queries</i> par page. Pour les pages de bureau, les 10e, 25e, 50e, 75e et 90e centiles sont&nbsp;: 0, 3, 14, 27 et 43 media-queries. La distribution de bureau est similaire à la distribution mobile.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1892465673&format=interactive"
  )
}}

### Tailles populaire des points d’arrêt (breakpoints) des media queries

Pour les <i lang="en">media queries</i> basées sur la fenêtre d’affichage, tout type d’unité CSS peut être passé dans l’expression de requête pour évaluation. Autrefois, les gens passaient `em` et `px` dans la requête, mais plus d’unités ont été ajoutées au fil du temps, ce qui nous rendait très curieux de savoir quels types de tailles étaient couramment trouvables sur le Web. Nous supposons que la plupart des <i lang="en">media queries</i> suivront les tailles d’appareils courants, mais au lieu de supposer, examinons les données&nbsp;!

{{ figure_markup(
  image="fig28.png",
  caption='Valeurs les plus fréquemment utilisées dans les <i lang="en">media queries</i>.',
  description='Diagramme à barres des valeurs les plus courantes utilisées avec les <i lang="en">media queries</i>. 768px et 767px sont respectivement les plus populaires à 23&nbsp;% et 16&nbsp;%. La liste tombe rapidement après cela, avec 992px utilisé 6&nbsp;% du temps et 1200px utilisé 4&nbsp;% du temps. Le bureau et le mobile ont une utilisation similaire.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1353707515&format=interactive"
  )
}}

La figure 2.28 ci-dessus montre qu’une partie de nos hypothèses était correcte&nbsp;: il y a certainement une grande quantité de tailles spécifiques aux téléphones, mais il y en a aussi qui ne le sont pas. Il est également intéressant de voir comment les pixels sont très dominants, avec quelques entrées utilisant `em` au-delà de la portée de ce graphique.

### Utilisation du portrait vs paysage

La valeur la plus populaire semble être `768px`, ce qui a attisé notre curiosité. Cette valeur a-t-elle été principalement utilisée pour passer à une mise en page portrait, car elle pourrait être basée sur l’hypothèse que `768px` représente la fenêtre de portrait mobile typique&nbsp;? Nous avons donc lancé une requête pour voir la popularité de l’utilisation des modes portrait et paysage&nbsp;:

{{ figure_markup(
  image="fig29.png",
  caption='Adoption des modes d’orientation des <i lang="en">media queries</i>.',
  description='Diagramme à barres montrant l’adoption des modes d’orientation portrait et paysage des <i lang="en">media queries</i>. 31&nbsp;% des pages spécifient paysage, 8&nbsp;% spécifient portrait et 7&nbsp;% spécifient les deux. L’adoption est la même pour les pages de bureau et mobiles.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=295845630&format=interactive"
  )
}}

Fait intéressant, `portrait` n’est pas beaucoup utilisé, alors que `landscape` l’est beaucoup plus. Nous ne pouvons que supposer que `768px` a été suffisamment fiable comme cas de mise en page de portrait pour être raisonnablement atteint. Nous supposons également que les utilisateurs d’un ordinateur de bureau, qui testent leur travail, ne peuvent pas déclencher le portrait pour voir leur disposition mobile aussi facilement qu’ils peuvent simplement réduire le navigateur. Difficile à dire, mais les données sont fascinantes.

### Types d’unités les plus populaires

Dans les <i lang="en">media queries</i> de largeur et de hauteur que nous avons vues jusqu’à présent, les pixels semblent être l’unité dominante de choix pour les développeurs qui cherchent à adapter leur interface utilisateur aux fenêtres. Nous voulions cependant questionner plus avant ce point et jeter un coup d’œil aux types d’unités que les gens utilisent. Voici ce que nous avons trouvé.

{{ figure_markup(
  image="fig30.png",
  caption='Adoption d’unités dans les <i lang="en">breakpoints</i> des <i lang="en">media queries</i>.',
  description='Diagramme à barres montrant 75&nbsp;% <i lang="en">breakpoints</i> des <i lang="en">media queries</i> spécifiant les pixels, 8&nbsp;% spécifiant ems et 1&nbsp;% spécifiant les rems.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=305563768&format=interactive"
  )
}}

### `min-width` vs `max-width`

Lorsque les gens écrivent une <i lang="en">media query</i>, visent-ils généralement une taille de fenêtre située au-dessus ou en dessous d’une plage spécifique, _ou_ les deux, ou encore si elle se situe entre une plage de tailles&nbsp;? Demandons au web&nbsp;!

{{ figure_markup(
  image="fig31.png",
  caption='Adoption des propriétés utilisées dans les <i lang="en">breakpoints</i> des <i lang="en">media queries</i>',
  description="Diagramme à barres montrant que 74&nbsp;% des pages de bureau utilisent `max-width`, 70&nbsp;% `min-width` et 68&nbsp;% utilisant les deux propriétés. L’adoption est similaire pour les pages mobiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2091525146&format=interactive"
  )
}}

Aucun gagnant clair ici, `max-width` et `min-width` sont presque à égalité.

### Impression et vocalisation

Les sites Web ressemblent à du papier numérique, non&nbsp;? En tant qu’utilisateurs et utilisatrices, il est généralement connu que vous pouvez simplement lancer l’impression à partir de votre navigateur et transformer ce contenu numérique en contenu physique. Un site Web n’est pas obligé de se changer pour ce cas d’utilisation, mais il le peut s’il le souhaite&nbsp;! Moins connue est la possibilité d’ajuster votre site Web dans le cas où il est lu par un outil ou un robot. Alors, à quelle fréquence ces fonctionnalités sont-elles exploitées&nbsp;?

{{ figure_markup(
  image="fig32.png",
  caption='Adoption des medias `all`, `print`, `screen` et `speech` pour les <i lang="en">media queries</i>.',
  description='Diagramme à barres montrant 35&nbsp;% des pages de bureau utilisent le type de requête `all`, 46&nbsp;% utilisent `print`, 72&nbsp;% utilisent `screen` et 0&nbsp;% utilisent `speech`. L’adoption est inférieure d’environ 5&nbsp;% pour les ordinateurs de bureau par rapport aux mobiles.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=939890574&format=interactive"
  )
}}

## Statistiques au niveau de la page

### Feuilles de styles

Combien de feuilles de style référencez-vous à partir de votre page d’accueil&nbsp;? Combien pour vos applications&nbsp;? Servez-vous en plus ou moins sur mobile ou bureau&nbsp;? Voici un tableau pour tout ce monde&nbsp;!

{{ figure_markup(
  image="fig33.png",
  caption="Répartition du nombre de feuilles de style chargées par page.",
  description="Répartition du nombre de feuilles de style chargées par page. Ordinateurs de bureau et mobiles ont des distributions identiques aux 10e, 25e, 50e, 75e et 90e centiles&nbsp;: 1, 3, 6, 12 et 20 feuilles de style par page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1377313548&format=interactive"
  )
}}

### Noms des feuilles de style

Comment nommez-vous vos feuilles de style&nbsp;? Avez-vous été cohérent tout au long de votre carrière&nbsp;? Avez-vous lentement convergé ou régulièrement divergé&nbsp;? Ce graphique montre un petit aperçu de la popularité des bibliothèques, mais aussi un aperçu des noms populaires des fichiers CSS.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Noms des feuilles de style</th>
        <th scope="col">Bureau</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>style.css</td>
        <td class="numeric">2.43&nbsp;%</td>
        <td class="numeric">2.55&nbsp;%</td>
      </tr>
      <tr>
        <td>font-awesome.min.css</td>
        <td class="numeric">1.86&nbsp;%</td>
        <td class="numeric">1.92&nbsp;%</td>
      </tr>
      <tr>
        <td>bootstrap.min.css</td>
        <td class="numeric">1.09&nbsp;%</td>
        <td class="numeric">1.11&nbsp;%</td>
      </tr>
      <tr>
        <td>BfWyFJ2Rl5s.css</td>
        <td class="numeric">0.67&nbsp;%</td>
        <td class="numeric">0.66&nbsp;%</td>
      </tr>
      <tr>
        <td>style.min.css?ver=5.2.2</td>
        <td class="numeric">0.64&nbsp;%</td>
        <td class="numeric">0.67&nbsp;%</td>
      </tr>
      <tr>
        <td>styles.css</td>
        <td class="numeric">0.54&nbsp;%</td>
        <td class="numeric">0.55&nbsp;%</td>
      </tr>
      <tr>
        <td>style.css?ver=5.2.2</td>
        <td class="numeric">0.41&nbsp;%</td>
        <td class="numeric">0.43&nbsp;%</td>
      </tr>
      <tr>
        <td>main.css</td>
        <td class="numeric">0.43&nbsp;%</td>
        <td class="numeric">0.39&nbsp;%</td>
      </tr>
      <tr>
        <td>bootstrap.css</td>
        <td class="numeric">0.40&nbsp;%</td>
        <td class="numeric">0.42&nbsp;%</td>
      </tr>
      <tr>
        <td>font-awesome.css</td>
        <td class="numeric">0.37&nbsp;%</td>
        <td class="numeric">0.38&nbsp;%</td>
      </tr>
      <tr>
        <td>style.min.css</td>
        <td class="numeric">0.37&nbsp;%</td>
        <td class="numeric">0.37&nbsp;%</td>
      </tr>
      <tr>
        <td>styles__ltr.css</td>
        <td class="numeric">0.38&nbsp;%</td>
        <td class="numeric">0.35&nbsp;%</td>
      </tr>
      <tr>
        <td>default.css</td>
        <td class="numeric">0.36&nbsp;%</td>
        <td class="numeric">0.36&nbsp;%</td>
      </tr>
      <tr>
        <td>reset.css</td>
        <td class="numeric">0.33&nbsp;%</td>
        <td class="numeric">0.37&nbsp;%</td>
      </tr>
      <tr>
        <td>styles.css?ver=5.1.3</td>
        <td class="numeric">0.32&nbsp;%</td>
        <td class="numeric">0.35&nbsp;%</td>
      </tr>
      <tr>
        <td>custom.css</td>
        <td class="numeric">0.32&nbsp;%</td>
        <td class="numeric">0.33&nbsp;%</td>
      </tr>
      <tr>
        <td>print.css</td>
        <td class="numeric">0.32&nbsp;%</td>
        <td class="numeric">0.28&nbsp;%</td>
      </tr>
      <tr>
        <td>responsive.css</td>
        <td class="numeric">0.28&nbsp;%</td>
        <td class="numeric">0.31&nbsp;%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Noms de feuilles de style les plus fréquemment utilisés.") }}</figcaption>
</figure>

Regardez tous ces noms de fichiers créatifs&nbsp;! `style`, `styles`, `main`, `default`, `all`. L’un se démarque cependant, le voyez-vous&nbsp;? `BfWyFJ2Rl5s.css` prend la quatrième place pour les plus populaires. Nous avons fait quelques recherches et notre meilleure hypothèse est qu’il est lié aux boutons «J’aime» de Facebook. Savez-vous quel est ce fichier&nbsp;? Laissez un commentaire, car nous aimerions entendre l’histoire.

### Poids de la feuille de style

Quel est le poids de ces feuilles de style&nbsp;? Est-ce que notre embonpoint CSS est quelque chose à craindre&nbsp;? À en juger par ces données, CSS n’est pas le principal coupable du gonflement des pages.

{{ figure_markup(
  image="fig35.png",
  caption="Distribution du nombre d’octets de feuille de style (Ko) chargés par page.",
  description="Distribution du nombre d’octets de feuilles de style chargés par page. Les 10e, 25e, 50e, 75e et 90e centiles de la page de bureau sont&nbsp;: 8, 26, 62, 129 et 240&nbsp;Ko. La distribution de bureau est légèrement supérieure à la distribution mobile de 5 à 10&nbsp;Ko.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=2132635319&format=interactive"
  )
}}

Voir le chapitre [Poids des pages](./page-weight) pour un aperçu plus détaillé du nombre d’octets que les sites Web chargent pour chaque type de contenu.

### Bibliothèques

Il est commun, populaire, pratique et puissant d’utiliser une bibliothèque CSS pour lancer un nouveau projet. Bien que vous ne soyez peut-être pas du genre à rechercher une bibliothèque, nous avons interrogé le Web en 2019 pour voir lesquelles sont en tête du peloton. Si les résultats vous étonnent, comme pour nous, c’est un indice intéressant de la petite taille d’une bulle dans laquelle nous vivons. Les choses peuvent sembler extrêmement populaires, mais lorsque le Web est réellement interrogé, la réalité est un peu différente.

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Bibliothèque</th>
        <th scope="col">Bureau</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td lang="en">Bootstrap</td>
        <td class="numeric">27.8&nbsp;%</td>
        <td class="numeric">26.9&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">animate.css</td>
        <td class="numeric">6.1&nbsp;%</td>
        <td class="numeric">6.4&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">ZURB Foundation</td>
        <td class="numeric">2.5&nbsp;%</td>
        <td class="numeric">2.6&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">UIKit</td>
        <td class="numeric">0.5&nbsp;%</td>
        <td class="numeric">0.6&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">Material Design Lite</td>
        <td class="numeric">0.3&nbsp;%</td>
        <td class="numeric">0.3&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">Materialize CSS</td>
        <td class="numeric">0.2&nbsp;%</td>
        <td class="numeric">0.2&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">Pure CSS</td>
        <td class="numeric">0.1&nbsp;%</td>
        <td class="numeric">0.1&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">Angular Material</td>
        <td class="numeric">0.1&nbsp;%</td>
        <td class="numeric">0.1&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">Semantic-ui</td>
        <td class="numeric">0.1&nbsp;%</td>
        <td class="numeric">0.1&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">Bulma</td>
        <td class="numeric">0.0&nbsp;%</td>
        <td class="numeric">0.0&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">Ant Design</td>
        <td class="numeric">0.0&nbsp;%</td>
        <td class="numeric">0.0&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">tailwindcss</td>
        <td class="numeric">0.0&nbsp;%</td>
        <td class="numeric">0.0&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">Milligram</td>
        <td class="numeric">0.0&nbsp;%</td>
        <td class="numeric">0.0&nbsp;%</td>
      </tr>
      <tr>
        <td lang="en">Clarity</td>
        <td class="numeric">0.0&nbsp;%</td>
        <td class="numeric">0.0&nbsp;%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Pourcentage de pages qui incluent une bibliothèque CSS donnée.") }}</figcaption>
</figure>

Ce graphique suggère que <a hreflang="en" href="https://getbootstrap.com/"><span lang="en">Bootstrap</span></a> est une bibliothèque précieuse à connaître pour vous aider à trouver un emploi. Regardez toutes les opportunités qui vous sont offertes&nbsp;! Il convient également de noter qu’il ne s’agit que d’un signal positif&nbsp;: les calculs ne totalisent pas 100&nbsp;% car tous les sites n’utilisent pas de bibliothèque CSS. Un peu plus de la moitié de tous les sites _n’utilisent pas_ de bibliothèque CSS connue. Très intéressant, non&nbsp;?!

### Resets CSS

Les <i lang="en">resets</i> CSS ont l’intention de normaliser ou de créer une base de référence pour les éléments Web natifs. Au cas où vous ne le sauriez pas, chaque navigateur propose sa propre feuille de style pour tous les éléments HTML, et chaque navigateur prend ses propres décisions sur l’apparence ou le comportement de ces éléments. Les <i lang="en">resets</i> ont examiné ces fichiers, trouvé leur terrain d’entente (ou non) et aplani toutes les différences afin que vous, en tant que développeur ou développeuse, puissiez styliser dans un navigateur et avoir une confiance raisonnable que l’apparence soit la même dans un autre.

Voyons donc combien de sites en utilisent un&nbsp;! Leur existence semble tout à fait raisonnable, alors combien de personnes sont d’accord avec leurs choix et les utilisent sur leurs sites&nbsp;?

{{ figure_markup(
  image="fig37.png",
  caption='Adoption des <i lang="en">resets</i> CSS.',
  description='Diagramme à barres montrant l’adoption de trois <i lang="en">resets</i> CSS&nbsp;: Normalize.css (33&nbsp;%), Reset CSS (3&nbsp;%) et Pure CSS (0&nbsp;%). Il n’y a aucune différence d’adoption entre les pages de bureau et mobiles.',
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1318910215&format=interactive"
  )
}}

Il s’avère qu’environ un tiers du Web utilise <a hreflang="en" href="https://necolas.github.io/normalize.css">`normalize.css`</a>, ce qui pourrait être considéré comme une approche douce, en tout cas plus que celle d’un pur <i lang="en">reset</i> CSS. Nous avons regardé un peu plus en profondeur, et il s’avère que <span lang="en">Bootstrap</span> inclut `normalize.css`, ce qui représente probablement une grande partie de son utilisation. Il convient également de noter que `normalize.css` a plus d’adoption que <span lang="en">Bootstrap</span>, donc il y a beaucoup de gens qui l’utilisent seul.

### `@supports` et `@import`

CSS `@supports` est un moyen pour le navigateur de vérifier si une combinaison propriété-valeur particulière est analysée comme valide, puis d’appliquer des styles si la vérification est vraie.

{{ figure_markup(
  image="fig38.png",
  caption="Popularité des règles CSS «@».",
  description="Diagramme à barres montrant la popularité des règles `@import` et `@supports`. Sur le bureau, `@import` est utilisé sur 28&nbsp;% des pages et `@supports` sur 31&nbsp;%. Pour mobile, `@import` est utilisé sur 26&nbsp;% des pages et `@supports` sur 29&nbsp;%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQO5CabwLwQ5Lj1_9bbEFnFM1qEqCorymaBHrcaNiMSJ7sYDKHUI5iish5VAS-SxN447UTW-1-5-OjE/pubchart?oid=1739611283&format=interactive"
  )
}}

Étant donné que `@supports` a été implémenté dans la plupart des navigateurs en 2013, il n’est pas trop surprenant de constater une utilisation et une adoption élevées. Nous sommes impressionnés par le soin des développeurs et développeuses ici. C’est un code attentionné&nbsp;! 30&nbsp;% de tous les sites Web vérifient la prise en charge avant d’utiliser certaines propriétés.

Une suite intéressante à cela est qu’il y a plus d’utilisation de `@supports` que de `@import`&nbsp;! Nous ne nous attendions pas à ça&nbsp;! `@import` est supporté dans les navigateurs depuis 1994.

## Conclusion

Il y a tellement plus ici à creuser&nbsp;! Beaucoup de résultats nous ont étonné et nous ne pouvons qu’espérer qu’ils vous ont également surpris. Cet ensemble de données surprenant a rendu le résumé très amusant et nous a laissé de nombreux indices et pistes à explorer si nous voulons rechercher le _pourquoi_ de certains des résultats.

Quels résultats avez-vous trouvés les plus alarmants&nbsp;?
Quels résultats vous donnent envie d’inspecter votre code rapidement&nbsp;?

Nous avons estimé que le plus grand avantage de ces résultats est que les propriétés personnalisées offrent le meilleur rapport qualité-prix en termes de performances, de factorisation et d’évolutivité pour vos feuilles de style. Nous sommes impatients de parcourir à nouveau les feuilles de style d’Internet, à la recherche de nouvelles idées et de friandises provocantes. Contactez [@una](https://x.com/una) ou [@argyleink](https://x.com/argyleink) dans les commentaires avec vos requêtes, questions et affirmations. Nous serions ravis de les entendre&nbsp;!
