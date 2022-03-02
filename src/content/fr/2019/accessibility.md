---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Accessibilité
description: Chapitre Accessibilité du web Almanac 2019, couvrant la facilité de lecture, les medias, l’aisance de navigation et la compatibilité avec les technologies d’assistance.
authors: [nektarios-paisios, foxdavidj, kleinab]
reviewers: [ljme]
analysts: [dougsillars, rviscomi, foxdavidj]
editors: [foxdavidj]
translators: [nico3333fr]
discuss: 1764
results: https://docs.google.com/spreadsheets/d/16JGy-ehf4taU0w4ABiKjsHGEXNDXxOlb__idY8ifUtQ/
nektarios-paisios_bio: Nektarios Paisios est un <i lang="en">software engineer</i> travaillant sur l’accessibilité de Chrome depuis 5 ans. Il se concentre principalement sur la compatibilité de Chrome avec les logiciels d’assistance tiers tels que les lecteurs d’écran et les loupes d’écran. Avant de travailler sur l’accessibilité de Chrome, Nektarios a occupé divers autres postes au sein de l’entreprise, tels que l’accessibilité GSuite et les annonces publicitaires. Nektarios est titulaire d’un doctorat en informatique de l’Université de New York.
foxdavidj_bio: David Fox est <i lang="en">lead usability researcher</i> et fondateur de LookZook, une entreprise obsédée par tout ce qu’il y a à savoir sur la création d’expériences Web qui répondent aux attentes des utilisateurs. Il est un psychologue de sites Web qui fouille dans ces derniers pour apprendre non seulement avec quels problèmes les utilisateurs se débattent, mais pourquoi et comment améliorer au mieux leur expérience. Il est également un contributeur, un conférencier et un fournisseur de Google Chromium de webinaires et de formations UX.
kleinab_bio: Abigail Klein est <i lang="en">Software Engineer</i> chez Google. Elle a travaillé sur l’accessibilité web de Google Docs, Sheets et Slides où elle a ajouté les <a hreflang="en" href="https://www.blog.google/outreach-initiatives/accessibility/whats-you-say-present-captions-google-slides/">légendes automatiques de Google Slides</a>, ainsi que l’amélioration du lecteur d’écran, du braille, de la loupe d’écran et de la prise en charge du contraste élevé. Elle travaille actuellement sur l’accessibilité de Google Chrome et ChromeOS. Elle détient un baccalauréat et une maîtrise en informatique du MIT, où elle a cofondé un hackathon de technologie d’assistance et a été assistante de laboratoire et conférencière invitée de la classe de technologie d’assistance.
featured_quote: L’accessibilité sur le web est essentielle pour une société inclusive et équitable. Alors que nos vies sociales et professionnelles se déplacent de plus en plus vers le monde en ligne, il devient encore plus important pour les personnes handicapées de pouvoir participer à toutes les interactions en ligne sans barrières. Tout comme les architectes en bâtiment peuvent créer ou omettre des fonctionnalités d’accessibilité telles que des rampes pour fauteuils roulants, les développeurs et développeuses web peuvent aider ou entraver la technologie d’assistance sur laquelle les utilisateurs se basent.
featured_stat_1: 22 %
featured_stat_label_1: Sites ayant des contrastes de couleurs insuffisants
featured_stat_2: 50 %
featured_stat_label_2: Sites ayant des attributs alt manquants
featured_stat_3: 14 %
featured_stat_label_3: Sites utilisant des liens d’évitement
---

## Introduction

L’accessibilité sur le web est essentielle pour une société inclusive et équitable. Alors que nos vies sociales et professionnelles se déplacent de plus en plus vers le monde en ligne, il devient encore plus important pour les personnes handicapées de pouvoir participer à toutes les interactions en ligne sans barrières. Tout comme les architectes en bâtiment peuvent créer ou omettre des fonctionnalités d’accessibilité telles que des rampes pour fauteuils roulants, les développeurs et développeuses web peuvent aider ou entraver la technologie d’assistance sur laquelle les utilisateurs se basent.

Lorsque nous pensons aux utilisateurs handicapés, nous devons nous rappeler que leur parcours utilisateur est souvent le même — ils utilisent simplement des outils différents. Ces outils populaires incluent, sans s’y limiter&nbsp;: les lecteurs d’écran, les loupes d’écran, le zoom global ou de la taille du texte du navigateur et les commandes vocales.

Souvent, l’amélioration de l’accessibilité des sites présente des avantages pour tout le monde. Alors que nous considérons généralement les personnes handicapées comme des personnes ayant une incapacité permanente, tout le monde peut avoir une incapacité temporaire ou situationnelle. Par exemple, une personne peut être aveugle en permanence, avoir une infection oculaire temporaire ou, à l’occasion, être à l’extérieur sous un soleil éclatant. Tout cela pourrait expliquer pourquoi quelqu’un ne peut pas voir son écran. Tout le monde a des handicaps situationnels, et donc améliorer l’accessibilité de votre page web améliorera l’expérience de tous les utilisateurs dans toutes les situations.

Les <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/quickref/">directives pour l’accessibilité du contenu web</a> (WCAG) donnent des conseils sur comment rendre un site web accessible. Ces lignes directrices ont servi de base à notre analyse. Cependant, dans de nombreux cas, il est difficile d’analyser programmatiquement l’accessibilité d’un site web. Par exemple, la plate-forme web offre plusieurs façons d’obtenir des résultats fonctionnels similaires, mais le code sous-jacent qui les alimente peut être complètement différent. Par conséquent, notre analyse n’est qu’une approximation de l’accessibilité globale du web.

Nous avons réparti nos informations les plus intéressantes en quatre catégories&nbsp;: facilité de lecture, médias sur le web, facilité de navigation dans les pages et compatibilité avec les technologies d’assistance.

Aucune différence significative d’accessibilité n’a été trouvée entre le bureau et le mobile pendant les tests. En conséquence, toutes nos mesures présentées sont le résultat de notre analyse de bureau, sauf indication contraire.

## Facilité de lecture

Le principal objectif d’une page web est de fournir du contenu avec lequel les utilisateurs souhaitent interagir. Ce contenu peut être une vidéo ou un assortiment d’images, mais souvent c’est simplement le texte sur la page. Il est extrêmement important que nos contenus textuels soient lisibles pour nos lecteurs. Si les visiteurs ne peuvent pas lire une page web, ils ne peuvent pas interagir avec, ce qui se termine par un abandon de leur part. Dans cette section, nous examinerons trois domaines dans lesquels les sites ont connu des difficultés.

### Contraste des couleurs

Il existe de nombreux cas où les visiteurs de votre site peuvent ne pas le voir parfaitement. Les visiteurs peuvent être daltoniens et être dans l’impossibilité de faire la distinction entre la police et la couleur d’arrière-plan ([1 homme sur 12 et 1 femme sur 200](http://www.cvrl.org/people/stockman/pubs/1999%20Genetics%20chapter%20SSJN.pdf) en Europe). Peut-être qu’ils lisent simplement en extérieur avec un soleil créant des tonnes de reflets sur leur écran — ce qui nuit considérablement à leur vision. Ou peut-être qu’ils ont simplement vieilli et que leurs yeux ne peuvent pas distinguer les couleurs aussi bien qu’auparavant.

Afin de vous assurer que votre site web soit lisible dans ces conditions, un contraste de couleur suffisant entre le texte et son arrière-plan est capital. Il est également important de prendre en compte les contrastes qui seront affichés lorsque les couleurs seront converties en niveaux de gris.

{{ figure_markup(
  image="example-of-good-and-bad-color-contrast-lookzook.svg",
  caption="Exemple de texte présentant un contraste de couleurs insuffisant. Gracieusement mis à disposition par LookZook",
  description="Quatre boîtes colorées de nuances marron et grises avec, par-dessus, du texte blanc à l’intérieur créant deux colonnes. La colonne de gauche indique «&nbsp;Trop légèrement coloré&nbsp;» et a la couleur de fond marron écrite comme `#FCA469`. La colonne de droite indique «&nbsp;Recommandé&nbsp;» et la couleur d’arrière-plan marron est écrite comme `#BD5B0E`. La zone supérieure de chaque colonne a un fond marron avec du texte blanc `#FFFFFF` et la zone inférieure a un fond gris avec du texte blanc `#FFFFFF`. Les équivalents en niveaux de gris sont respectivement <code>#B8B8B8</code> et <code>#707070</code>. Gracieusement mis à disposition par LookZook",
  width=568,
  height=300
  )
}}

Seuls 22,04&nbsp;% des sites ont donné à l’ensemble de leurs textes un contraste de couleurs suffisant. En d’autres termes&nbsp;: 4 sites sur 5 ont un texte qui se confond facilement avec son arrière-plan, le rendant illisible.

<p class="note">Notez que nous n’avons pas été en mesure d’analyser du texte pris dans des images, de sorte que notre statistique est une limite supérieure du nombre total de sites web réussissant le test de contraste des couleurs.</p>

### Zoom et mise à l’échelle des pages

Utiliser une <a hreflang="en" href="https://accessibleweb.com/question-answer/minimum-font-size/">taille de police lisible</a> et <a hreflang="en" href="https://www.w3.org/WAI/WCAG21/quickref/#target-size">une taille de cible raisonnablement grande</a> aide les utilisateurs à lire et à interagir avec votre site web. Mais même les sites web qui suivent parfaitement toutes ces directives ne peuvent pas répondre aux besoins spécifiques de chaque visiteur. C’est pourquoi les fonctionnalités de l’appareil telles que le pincement au zoom et la mise à l’échelle sont si importantes&nbsp;: elles permettent aux utilisateurs de modifier vos pages pour répondre à leurs besoins. Ou dans le cas de sites particulièrement inaccessibles utilisant de minuscules polices et boutons, cela donne aux utilisateurs la possibilité même d’utiliser le site.

Il existe de rares cas où la désactivation de la mise à l’échelle est acceptable, comme lorsque la page en question est un jeu web utilisant des commandes tactiles. Si laissé activé dans ce cas, les téléphones des joueurs et joueuses feront un zoom avant et arrière à chaque fois qu’ils tapoteront deux fois sur le jeu, ce qui —&nbsp;ironiquement&nbsp;— le rendra inaccessible.

De fait, les développeurs et développeuses ont la possibilité de désactiver cette fonctionnalité en définissant l’une des deux propriétés suivantes dans la [balise meta viewport](https://developer.mozilla.org/fr/docs/Web/HTML/Viewport_meta_tag)&nbsp;:

1. `user-scalable` mis à `0` ou `no`&nbsp;;

2. `maximum-scale` mis à `1`, `1.0`, etc.

Malheureusement, les développeurs et développeuses web en ont tellement abusé que près d’un site sur trois sur mobile (32,21&nbsp;%) désactive cette fonctionnalité, et Apple (à partir d’iOS 10) ne leur permet plus de désactiver le zoom. Safari mobile <a hreflang="en" href="https://archive.org/details/ios-10-beta-release-notes">ignore simplement la balise</a>. Tous les sites, quels qu’ils soient, peuvent être zoomés et mis à l’échelle sur les nouveaux appareils iOS.

{{ figure_markup(
  image="fig2.png",
  caption="Pourcentage de sites qui désactivent le zoom et la mise à l’échelle par rapport au type d’appareil.",
  description="Graphes verticaux en pourcentages, allant de 0 à 80 de 20 en 20, par rapport au type d’appareil, regroupées en ordinateur de bureau et mobile. Bureau activé&nbsp;: 75,46&nbsp;%&nbsp;; Bureau désactivé&nbsp;: 24,54&nbsp;%&nbsp;; Mobile activé&nbsp;: 67,79&nbsp;%&nbsp;; Mobile désactivé&nbsp;: 32,21&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=2053904956&format=interactive"
  )
}}

### Identification de la langue

Le web regorge de merveilleuses quantités de contenus. Cependant, il y a un hic&nbsp;: plus de 1000 langues différentes existent dans le monde, et le contenu que vous recherchez peut ne pas être écrit dans une langue que vous maîtrisez. Ces dernières années, nous avons fait de grands progrès dans les technologies de traduction et vous avez probablement utilisé l’un d’eux sur le web (par exemple, <i lang="en">Google translate</i>).

Afin de faciliter cette fonctionnalité, les moteurs de traduction doivent savoir dans quelle langue vos pages sont écrites. Cela se fait en utilisant [l’attribut `lang`](https://developer.mozilla.org/fr/docs/Web/HTML/Attributs_universels/lang). Sans cela, les ordinateurs doivent deviner dans quelle langue votre page est écrite. Comme vous pouvez l’imaginer, cela conduit à de nombreuses erreurs, en particulier lorsque les pages utilisent plusieurs langues (par exemple, la navigation de votre page est en anglais, mais le contenu de la publication est en japonais).

Ce problème est encore plus prononcé sur les technologies d’assistance de synthèse vocale telles que les lecteurs d’écran qui, si aucune langue n’a été spécifiée, ont tendance à lire le texte dans la langue utilisateur par défaut.

Sur les pages analysées, 26,13&nbsp;% ne spécifient pas de langue avec l’attribut `lang`. Cela laisse plus d’un quart des pages affectées par tous les problèmes décrits ci-dessus. La bonne nouvelle&nbsp;? Les sites utilisant l’attribut `lang` spécifient correctement un code de langue valide 99,68&nbsp;% du temps.

### Contenus détournant l’attention

Certains utilisateurs, comme ceux qui ont des troubles cognitifs, ont du mal à se concentrer sur la même tâche pendant de longues périodes. Ces utilisateurs ne veulent pas avoir affaire à des pages qui contiennent beaucoup de mouvements et d’animations, surtout lorsque ces effets sont purement cosmétiques et non liés à la tâche à accomplir. Au minimum, ces utilisateurs ont besoin d’un moyen de désactiver toutes les animations parasitant l’attention.

Malheureusement, nos résultats indiquent que les animations en boucle infinie sont assez courantes sur le web, avec 21,04&nbsp;% des pages les utilisant via des animations CSS infinies ou via [`<marquee>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/marquee) et [`<blink>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/blink).

Il est intéressant de noter cependant que le nœud du problème semble être quelques feuilles de style tierces populaires qui incluent par défaut des animations CSS en boucle infinie. Nous n’avons pas pu déterminer le nombre de pages utilisant réellement ces styles d’animation.

## Médias sur le web

### Texte alternatif sur les images

Les images sont une part essentielle de l’expérience web. Elles peuvent raconter des histoires puissantes, attirer l’attention et susciter des émotions. Mais tout le monde ne peut pas voir ces images sur lesquelles nous nous appuyons pour raconter des parties de nos histoires. Heureusement, en 1995, HTML 2.0 a fourni une solution à ce problème&nbsp;: [l’attribut `alt`](http://www.pompage.net/traduction/Bien-utiliser-le-texte-alternatif). L’attribut `alt` offre aux développeurs et développeuses web la possibilité d’ajouter une description textuelle aux images utilisées, de sorte que lorsqu’une personne ne peut pas voir ces images (ou si les images ne peuvent pas se charger), elle peut lire le texte de remplacement pour en avoir une description. Le texte alternatif les renseigne sur la partie de l’histoire qu’elles auraient autrement manquée.

Même si les attributs `alt` existent depuis 25 ans, 49,91&nbsp;% des pages ne fournissent toujours pas d’attributs `alt` pour certaines de leurs images, et 8,68&nbsp;% des pages ne les utilisent pas du tout.

### Légendes pour l’audio et la vidéo

Tout comme les images sont de puissants vecteurs, il en va de même pour l’audio et la vidéo qui attirent l’attention et expriment des idées. Lorsque les contenus audio et vidéo ne sont pas sous-titrés, les utilisateurs qui ne peuvent pas entendre ces contenus passent à côté de grandes parties du web. L’une des choses les plus courantes que nous entendons des utilisateurs sourds ou malentendants est la nécessité d’inclure des sous-titres pour tous les contenus audio et vidéo.

Sur les sites utilisant [`<audio>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/audio) ou [`<video>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/video), seuls 0,54&nbsp;% fournissent des légendes (comptabilisées par le [`<track>`](https://developer.mozilla.org/en-US/docs/Web/Guide/Audio_and_video_delivery/Adding_captions_and_subtitles_to_HTML5_video)). Notez que certains sites web ont des solutions personnalisées pour fournir des sous-titres vidéo et audio aux utilisateurs. Nous n’avons pas pu les détecter et le pourcentage réel de sites utilisant des sous-titres est donc légèrement plus élevé.

## Facilités de navigation dans les pages

Lorsque vous ouvrez le menu dans un restaurant, la première chose à faire est probablement de lire tous les en-têtes de section&nbsp;: apéritifs, salades, plats principaux et desserts. Cela vous permet de vous orienter dans un menu et de passer rapidement aux plats les plus intéressants pour vous. De même, lorsqu’une personne ouvre une page web, son objectif est de trouver les informations qui l’intéresse le plus — la raison pour laquelle il est venu sur la page en premier lieu. Afin d’aider les utilisateurs à trouver le contenu souhaité aussi rapidement que possible (et leur éviter d’appuyer sur le bouton «&nbsp;précédent&nbsp;»), nous essayons de structurer le contenu de nos pages en plusieurs sections visuellement distinctes, par exemple&nbsp;: un en-tête de site pour la navigation, diverses rubriques dans nos articles pour que les utilisateurs puissent les analyser rapidement, un pied de page pour d’autres ressources, et plus encore.

C’est extrêmement important, nous devons prendre soin de baliser nos pages afin que les ordinateurs de nos visiteurs puissent également percevoir ces sections distinctes. Pourquoi&nbsp;? Alors que la plupart des lecteurs utilisent une souris pour parcourir les pages, de nombreux autres s’appuient sur des claviers et des lecteurs d’écran. Ces technologies dépendent fortement de la façon dont leurs ordinateurs comprennent votre page.

### En-têtes

Les en-têtes sont non seulement utiles visuellement, mais aussi pour les lecteurs d’écran. Ils permettent à ces derniers de passer rapidement d’une section à l’autre et aident à indiquer où se termine une section et où commence une autre.

Afin d’éviter de dérouter les utilisateurs de lecteurs d’écran, assurez-vous de ne jamais sauter un niveau de titre. Par exemple, ne passez pas directement d’un `h1` à un `h3` en sautant le `h2`. Pourquoi est-ce un gros problème&nbsp;? Parce qu’il s’agit d’un changement inattendu, ce qui amènera un utilisateur ou une utilisatrice de lecteur d’écran à penser qu’il ou elle a manqué un morceau de contenu. Cela pourrait l’amener à chercher partout ce qu’il pourrait avoir manqué, même s’il ne manque rien. De plus, vous aiderez tous vos lecteurs en ayant une conception plus cohérente.

Cela étant dit, voici nos résultats&nbsp;:

1. 89,36&nbsp;% des pages utilisent des titres d’une manière ou d’une autre&nbsp;; impressionnant&nbsp;;
2. 38,6&nbsp;% des pages sautent des niveaux de titre&nbsp;;
3. Curieusement, les `h2` se trouvent sur plus de sites que les `h1`.

{{ figure_markup(
  image="fig3.png",
  caption="Popularité des en-têtes.",
  description="Graphique à barres verticales mesurant des données de pourcentage, allant de 0 à 80 de 20 en 20, par rapport aux barres représentant chaque niveau de `h1` à `h6`. `h1`&nbsp;: 63,25&nbsp;%&nbsp;; `h2`&nbsp;: 67,86&nbsp;%&nbsp;; `h3`&nbsp;: 58,63&nbsp;%&nbsp;; `h4`&nbsp;: 36,38&nbsp;%&nbsp;; `h5`&nbsp;: 14,64&nbsp;%; `h6`&nbsp;: 6,91&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1123601243&format=interactive"
  )
}}

### Zone de contenu principale

Une [zone de contenu principale <i lang="en">`main`</i>](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Main_role) indique aux lecteurs d’écran où commence le contenu principal d’une page web afin que les utilisateurs puissent y aller directement. Sans cela, les utilisateurs de lecteurs d’écran doivent tabuler manuellement votre navigation chaque fois qu’ils accèdent à une nouvelle page de votre site. Évidemment, c’est plutôt frustrant.

Nous avons constaté qu’une seule page sur quatre (26,03&nbsp;%) comprend une zone de contenu principale. Et étonnamment, 8,06&nbsp;% des pages contenaient par erreur plus d’une zone de contenu principale, laissant ces utilisateurs deviner laquelle contient le contenu principal réel.

{{ figure_markup(
  image="fig4.png",
  caption="Pourcentage des pages selon leur nombre d’éléments `main`.",
  description="Graphique à barres verticales affichant des pourcentages de données allant de 0 à 80 de 20 en 20, par rapport à des barres représentant le nombre de repères «&nbsp;principaux&nbsp;» par page de 0 à 4. Source: HTTP Archive (juillet 2019). Zéro&nbsp;: 73,97&nbsp;%&nbsp;; Un&nbsp;: 17,97&nbsp;%&nbsp;; Deux&nbsp;: 7,41&nbsp;%&nbsp;; Trois&nbsp;: 0,15&nbsp;%&nbsp;; 4&nbsp;: 0,06&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=1420590464&format=interactive"
  )
}}

### Éléments de section HTML

Depuis que HTML5 a été publié en 2008 et est devenu la norme officielle en 2014, il existe de nombreux éléments HTML pour aider les ordinateurs et les lecteurs d’écran à comprendre nos mises en page et nos structures.

Des éléments comme [`<header>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/header), [`<footer>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/footer), [`<navigation>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/nav) et [`<main>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/main) indiquent où se situent des types de contenu spécifiques et permettent aux utilisateurs de parcourir rapidement votre page. Celles-ci sont largement utilisées sur le web, la plupart d’entre elles étant utilisées sur plus de 50&nbsp;% des pages (`<main>` étant la valeur la plus utilisée).

D’autres comme [`<article>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/article), [`<hr>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/hr) et [`<aside>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/aside) aident les lecteurs à comprendre le contenu principal d’une page. Par exemple, `<article>` indique où se termine un article et où commence un autre. Ces éléments ne sont pas autant utilisés, chacun étant à environ 20&nbsp;% d’utilisation. Tous ces éléments ne sont pas pertinents pour chaque page web, ce n’est donc pas nécessairement une statistique alarmante.

Tous ces éléments sont principalement conçus pour la prise en charge de l’accessibilité et n’ont aucun effet visuel, ce qui signifie que vous pouvez remplacer en toute sécurité les éléments existants et ne subir aucune conséquence involontaire.

{{ figure_markup(
  image="fig5.png",
  caption="Utilisation de divers éléments sémantiques HTML.",
  description="Graphique à barres verticales avec des barres pour chaque type d’élément par rapport au pourcentage de pages allant de 0 à 60 de 20 en 20. `nav`&nbsp;: 53,94&nbsp;%&nbsp;; `header`&nbsp;: 54,82&nbsp;%&nbsp;; `footer`&nbsp;: 55,92&nbsp;%&nbsp;; `main`&nbsp;: 18,47&nbsp;%&nbsp;; `aside`&nbsp;: 16,99&nbsp;%&nbsp;; `article`&nbsp;: 22,59&nbsp;%&nbsp;; `hr`&nbsp;: 19,1&nbsp;%&nbsp;; `section`&nbsp;: 36,55&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=708035719&format=interactive"
  )
}}

### Autres éléments HTML utilisés pour la navigation

De nombreux lecteurs d’écran populaires permettent également aux utilisateurs de naviguer en parcourant rapidement les liens, les listes, les éléments de liste, les iframes et les champs de formulaire tels que les champs d’édition, les boutons et les zones de liste. La figure 9.6 détaille la fréquence à laquelle nous avons vu des pages utilisant ces éléments.

{{ figure_markup(
  image="fig6.png",
  caption="Autres éléments HTML utilisés pour la navigation",
  description="Graphique à barres verticales avec des barres pour chaque type d’élément par rapport au pourcentage de pages allant de 0 à 100 de 25 en 25. `a`&nbsp;: 98,22&nbsp;%&nbsp;; `ul`&nbsp;: 88,62&nbsp;%&nbsp;; `input`: 76,63&nbsp;%&nbsp;; `iframe`: 60,39&nbsp;%&nbsp;; `button`&nbsp;: 56,74&nbsp;%&nbsp;; `select`&nbsp;: 19,68&nbsp;%&nbsp;; `textarea`&nbsp;: 12,03&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=389034849&format=interactive"
  )
}}

### Liens d’évitement

Un <a hreflang="en" href="https://webaim.org/techniques/skipnav/">lien d’évitement</a> est un lien placé en haut d’une page qui permet aux lecteurs d’écran ou aux utilisateurs de clavier d’accéder directement au contenu principal. Il «&nbsp;saute&nbsp;» efficacement tous les liens et menus de navigation en haut de la page. Les liens d’évitement sont particulièrement utiles aux utilisateurs de clavier qui n’utilisent pas de lecteur d’écran, car ces utilisateurs n’ont généralement pas accès à d’autres modes de navigation rapide (comme les zones de contenus principales et les en-têtes). 14,19&nbsp;% des pages de notre échantillon avaient des liens d’évitement.

Si vous souhaitez voir un lien d’évitement en action par vous-même, vous pouvez&nbsp;! Faites simplement une recherche rapide sur Google et tapez sur «&nbsp;<kbd>Tab</kbd>&nbsp;» dès que vous atterrissez sur les pages de résultats de recherche. Vous serez accueilli avec un lien précédemment masqué, comme celui sur la figure 9.7.

{{ figure_markup(
  image="example-of-a-skip-link-on-google.com.png",
  caption="Ce à quoi un lien d’évitement ressemble sur google.com.",
  description="Capture d’écran de la page de résultats de recherche Google pour la recherche «&nbsp;http archive&nbsp;». Le lien visible «&nbsp;Passer au contenu principal&nbsp;» est entouré d’un surlignage bleu et une boîte jaune superposée avec une flèche rouge pointant vers le lien de saut indique en anglais «&nbsp;Un lien d’évitement sur google.com&nbsp;».",
  width=600,
  height=333
  )
}}

En fait, vous n’avez même pas besoin de quitter ce site, car nous <a hreflang="en" href="https://github.com/HTTPArchive/almanac.httparchive.org/pull/645">les utilisons ici aussi</a>&nbsp;!

Il est difficile de déterminer avec précision ce qu’est un lien d’évitement lors de l’analyse des sites. Pour cette analyse, si nous avons trouvé un lien-ancre (`href=#heading1`) dans les 3 premiers liens de la page, nous l’avons défini comme une page avec un lien d’évitement. Donc, 14,19&nbsp;% est une limite supérieure stricte.

### Raccourcis

Des raccourcis clavier définis via <a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts">`aria-keyshortcuts`</a> ou [`accesskey`](https://developer.mozilla.org/fr/docs/Web/HTML/Attributs_universels/accesskey) peuvent être utilisés de deux manières&nbsp;:

1. activer un élément sur la page, comme un lien ou un bouton&nbsp;;

2. donner le focus à un certain élément de la page. Par exemple, déplacer le focus sur un champ de la page, permettant à l’utilisateur ou l’utilisatrice de commencer à taper dedans.

L’adoption de <a hreflang="en" href="https://www.w3.org/TR/wai-aria-1.1/#aria-keyshortcuts">`aria-keyshortcuts`</a> était quasiment absente de notre échantillon, elle n’était utilisée que sur 159 sites sur plus de 4 millions analysés. L’attribut [`accesskey`](https://developer.mozilla.org/fr/docs/Web/HTML/Attributs_universels/accesskey) a été utilisé plus fréquemment, se trouvant sur 2,47&nbsp;% des pages web (1,74&nbsp;% sur les mobiles). Nous pensons que l’utilisation accrue des raccourcis sur le bureau est due au fait que les développeurs et développeuses s’attendent à ce que les sites mobiles ne soient accessibles que via un écran tactile et non un clavier.

Ce qui est particulièrement surprenant ici, c’est que 15,56&nbsp;% des sites mobiles et 13,03&nbsp;% des sites de bureau qui utilisent des touches de raccourci attribuent le même raccourci à plusieurs éléments différents. Cela signifie que les navigateurs doivent deviner à quel élément se rapporte cette touche de raccourci.

### Tableaux

Les tableaux sont l’un des principaux moyens par lesquels nous organisons et exprimons de grandes quantités de données. De nombreuses technologies d’assistance comme les lecteurs d’écran et les commutateurs (qui peuvent être utilisés par les utilisateurs handicapés moteurs) peuvent avoir des fonctionnalités spéciales leur permettant de naviguer plus efficacement dans ces données tabulaires.

#### En-têtes

Selon la façon dont un tableau est structuré, l’utilisation des en-têtes de tableau facilite la lecture entre les colonnes ou les lignes sans perdre le contexte auxquelles cette colonne ou ligne particulière fait référence. Devoir naviguer dans un tableau sans lignes ou colonnes d’en-tête est une expérience médiocre pour un utilisateur ou une utilisatrice de lecteur d’écran. En effet, il est difficile pour ce dernier de garder ne pas perdre le fil dans un tableau sans en-têtes, en particulier lorsque ledit tableau est assez grand.

Pour baliser les en-têtes de tableau, utilisez simplement la balise [`<th>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/th) (au lieu de [`<td>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/td)), ou l’un des rôles ARIA [`columnheader`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Table_Role) ou [`rowheader`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Table_Role). Seulement 24,5&nbsp;% des pages contenant des tableaux ont balisé ces derniers avec l’une ou l’autre de ces méthodes. Ainsi, les trois quarts des pages qui choisissent d’inclure des tableaux sans en-têtes créent de sérieuses complications pour les utilisateurs de lecteurs d’écran.

L’utilisation de `<th>` et `<td>` était de loin la méthode la plus couramment utilisée pour baliser les en-têtes de tableau. L’utilisation des rôles `columnheader` et `rowheader` était presque inexistante avec seulement 677 sites au total les utilisant (0,058&nbsp;%).

#### Légendes

La légende (ou titre) de tableau via l’élément [`<caption>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/caption) est utile pour fournir plus de contexte aux lecteurs de toutes sortes. Une légende peut préparer un lecteur à saisir les informations que votre tableau partage, et elle peut être particulièrement utile pour les personnes qui peuvent être distraites ou interrompues facilement. Elles sont également utiles pour les personnes qui peuvent se perdre dans un grand tableau, comme une personne utilisant un lecteur d’écran ou ayant une déficience cognitive ou intellectuelle. Plus il est facile pour les lecteurs de comprendre ce qu’ils analysent, mieux c’est.

Malgré cela, seulement 4,32&nbsp;% des pages avec des tableaux fournissent des légendes à ces derniers.

## Compatibilité avec les technologies d’assistance

### L’utilisation d’ARIA

L’une des spécifications les plus populaires et les plus utilisées pour l’accessibilité sur le web est la norme <a hreflang="en" href="https://www.w3.org/WAI/standards-guidelines/aria/">Accessible Rich Internet Applications</a> (ARIA). Cette norme offre un large éventail d’attributs HTML supplémentaires pour aider à transmettre l’objectif derrière les éléments visuels (c’est-à-dire leur signification sémantique) et les types d’actions dont ils sont capables.

L’utilisation correcte et appropriée d’ARIA peut être difficile. Par exemple, sur les pages utilisant des attributs ARIA, 12,31&nbsp;% ont des valeurs non valides en attribut. Cela est problématique car toute erreur dans l’utilisation d’un attribut ARIA n’a aucun effet visuel sur la page. Certaines de ces erreurs peuvent être détectées à l’aide d’un outil de validation automatisé, mais généralement elles nécessitent l’utilisation réelle d’un logiciel d’assistance (comme un lecteur d’écran). Cette section examinera comment ARIA est utilisé sur le web, et en particulier quelles parties de la norme sont les plus répandues.

{{ figure_markup(
  image="fig8.png",
  caption="Pourcentage du nombre total de pages par rapport aux attributs ARIA.",
  description="Graphique à barres verticales affichant des données en pourcentage, allant de 0 à 25 de 5 en 5, par rapport aux barres représentant chaque attribut. `aria-hidden`&nbsp;: 23,46&nbsp;%, `aria-label`&nbsp;: 17,67&nbsp;%, `aria-expanded`&nbsp;: 8,68&nbsp;%, `aria-current`&nbsp;: 7,76&nbsp;%, `aria-labelledby`&nbsp;: 6,85&nbsp;%, `aria-controls`&nbsp;: 3,56&nbsp;%, `aria-haspopup`&nbsp;: 2,62&nbsp;%, `aria-invalid`&nbsp;: 2,68&nbsp;%, `aria-describedby`&nbsp;: 1,69&nbsp;%, `aria-live`&nbsp;: 1,04&nbsp;%, `aria-required`&nbsp;: 1&nbsp;%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=792161340&format=interactive"
  )
}}

#### L’attribut `role`

L’attribut `role` est le plus important de toute la spécification ARIA. Il est utilisé pour informer le navigateur de la finalité d’un élément HTML donné (c’est-à-dire la signification sémantique). Par exemple, un élément `<div>` ayant via CSS le visuel d’un bouton devrait se voir attribuer le rôle ARIA de `button`.

Actuellement, 46,91&nbsp;% des pages utilisent au moins un attribut de rôle ARIA. Dans la figure 9.9 ci-dessous, nous avons compilé une liste des dix valeurs de rôles ARIA les plus utilisées.

{{ figure_markup(
  image="fig9.png",
  caption="Top 10 des rôles ARIA.",
  description="Graphique à barres verticales avec des barres pour chaque type de rôle par rapport au pourcentage de sites utilisant de 0 à 25 de 5 en 5. `navigation`&nbsp;: 20,4&nbsp;%&nbsp;; `search`&nbsp;: 15,49&nbsp;%&nbsp;; `main`&nbsp;: 14,39&nbsp;%&nbsp;; `banner`&nbsp;: 13,62&nbsp;%&nbsp;; `contentinfo`&nbsp;: 11,23&nbsp;%&nbsp;; `button`&nbsp;: 10,59&nbsp;%&nbsp;; `dialog`&nbsp;: 7,87&nbsp;%&nbsp;; `complementary`&nbsp;: 6,06&nbsp;%&nbsp;; `menu`&nbsp;: 4,71&nbsp;%&nbsp;; `form`&nbsp;: 3,75&nbsp;%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSG3DTnx7j-YT1hnQpQYjDRD-rCSF1dXbgva-iJQZKdCKIt34ojGMDRhx74fF93CpPg7oGW_C68fWGT/pubchart?oid=176877741&format=interactive"
  )
}}

En examinant les résultats de la figure 9.9, nous avons trouvé deux informations intéressantes&nbsp;: la mise à jour des <i lang="en">frameworks</i> d’interface pourrait avoir un impact profond sur l’accessibilité sur le web, et le nombre impressionnant de sites tentant de rendre les modales accessibles.

##### Mettre à jour les <i lang="en">frameworks</i> d’interface pourrait être la voie à suivre pour l’accessibilité du web {mettre-à-jour-les-frameworks-d’interface-pourrait-être-la-voie-à-suivre-pour-l’accessibilité-du-web}

Les 5 premiers rôles, tous apparaissant sur 11&nbsp;% des pages ou plus, sont des rôles de type <i lang="en">landmark</i>. Ils sont utilisés pour faciliter la navigation, pas pour décrire les fonctionnalités d’un widget, comme une zone de liste déroulante. C’est un résultat surprenant, car le principal facteur de motivation du développement d’ARIA était justement de donner aux développeurs et développeuses web la possibilité de décrire la fonctionnalité de widgets constitués d’éléments HTML génériques (comme un `<div>`).

Nous pensons que certains des <i lang="en">frameworks</i> d’interface les plus populaires incluent des rôles de navigation dans leurs modèles. Cela expliquerait la prévalence d’attributs de type <i lang="en">landmark</i>. Si cette théorie est correcte, la mise à jour des <i lang="en">frameworks</i> d’interface populaires pour inclure davantage de prise en charge de l’accessibilité peut avoir un impact énorme sur l’accessibilité du web.

Un autre résultat amenant à cette conclusion est le fait que les attributs ARIA plus «&nbsp;avancés&nbsp;» mais tout aussi importants ne semblent pas du tout être utilisés. Ces attributs ne peuvent pas être facilement déployés via des <i lang="en">frameworks</i> d’interface, car ils doivent être personnalisés en fonction de la structure et de l’apparence visuelle de chaque site, individuellement. Par exemple, nous avons constaté que les attributs `posinset` et `setsize` n’étaient utilisés que sur 0,01&nbsp;% des pages. Ces attributs indiquent à un utilisateur ou une utilisatrice de lecteur d’écran combien d’éléments se trouvent dans une liste ou un menu et quel élément est actuellement sélectionné. Ainsi, si une personne malvoyante essaie de naviguer dans un menu, il peut entendre des annonces d’index telles que&nbsp;: «&nbsp;Accueil, 1 sur 5&nbsp;», «&nbsp;Produits, 2 sur 5&nbsp;», «&nbsp;Téléchargements, 3 sur 5&nbsp;», etc.

##### De nombreux sites tentent de rendre les modales accessibles

La popularité relative du [rôle `dialog`](https://developer.mozilla.org/fr/docs/Accessibilit%C3%A9/ARIA/Techniques_ARIA/Utiliser_le_r%C3%B4le_dialog) se démarque, car rendre les modales accessibles aux utilisateurs de lecteurs d’écran est très difficile. Il est donc passionnant de voir environ 8&nbsp;% des pages analysées relever le défi. Encore une fois, nous pensons que cela pourrait être dû à l’utilisation de certains <i lang="en">frameworks</i> d’interface.

#### Étiquettes sur les éléments interactifs

La façon la plus courante qu’a un utilisateur pour interagir avec un site web consiste à utiliser ses contrôles, tels que des liens ou des boutons, pour naviguer sur le site web. Cependant, de nombreuses fois les utilisateurs de lecteurs d’écran ne sont pas en mesure de dire quelle action un contrôle effectuera une fois activé. Souvent, la raison de cette confusion est due à l’absence d’une étiquette textuelle. Par exemple, un bouton affichant une icône de flèche pointant vers la gauche pour indiquer qu’il s’agit du bouton «&nbsp;Retour&nbsp;», mais ne contenant aucun texte réel.

Seulement environ un quart (24,39&nbsp;%) des pages qui utilisent des boutons ou des liens incluent des étiquettes textuelles avec ces commandes. Si un contrôle n’est pas étiqueté, une personne utilisant un lecteur d’écran peut lire quelque chose de générique, comme le mot «&nbsp;bouton&nbsp;» au lieu d’un mot significatif comme «&nbsp;Rechercher&nbsp;».

Les boutons et les liens sont presque toujours inclus dans l’ordre de tabulation et ont donc une visibilité extrêmement élevée. La navigation sur un site web à l’aide de la touche de tabulation est l’un des principaux moyens par lesquels les personnes qui utilisent uniquement le clavier explorent votre site web. Ainsi, une personne est sûre de rencontrer vos boutons et liens sans étiquette si elle se déplace sur votre site web à l’aide de la touche de tabulation.

### Accessibilité des contrôles de formulaire

Remplir des formulaires est une tâche que beaucoup d’entre nous accomplissent chaque jour. Que nous achetions, réservions un voyage ou postulions, les formulaires sont le principal moyen utilisé pour partager des informations avec des pages web. Pour cette raison, il est extrêmement important de s’assurer que vos formulaires sont accessibles. Le moyen le plus simple d’y parvenir est de fournir des étiquettes (via l’élément [`<label>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/Label), [`aria-label`](https://developer.mozilla.org/fr/docs/Accessibilit%C3%A9/ARIA/Techniques_ARIA/Utiliser_l_attribut_aria-label) ou [`aria-labelledby`](https://developer.mozilla.org/fr/docs/Accessibilit%C3%A9/ARIA/Techniques_ARIA/Utiliser_l_attribut_aria-labelledby)) pour chacune de vos entrées. Malheureusement, seulement 22,33&nbsp;% des pages fournissent des étiquettes pour toutes leurs entrées de formulaire, ce qui signifie que 4 pages sur 5 ont des formulaires qui peuvent être très difficiles à remplir.

#### Indicateurs des champs obligatoires et invalides

Lorsque nous rencontrons un champ avec un gros astérisque rouge à côté, nous savons que c’est un champ obligatoire. Ou lorsque nous appuyons sur «&nbsp;Soumettre&nbsp;» et que nous sommes informés qu’il y avait des entrées non valides, tout ce qui est mis en surbrillance dans une couleur différente doit être corrigé puis soumis à nouveau. Cependant, les personnes malvoyantes ou sans vision ne peuvent pas se fier à ces repères visuels, c’est pourquoi les attributs d’entrée HTML `required`, `aria-required` et `aria-invalid` sont si importants. Ils fournissent aux lecteurs d’écran l’équivalent d’astérisques rouges et de champs surlignés en rouge. En prime, lorsque vous informez les navigateurs des champs obligatoires, ils [valideront des parties de vos formulaires](https://developer.mozilla.org/fr/docs/Web/Guide/HTML/Formulaires/Validation_donnees_formulaire) pour vous. Aucun JavaScript requis.

Sur les pages utilisant des formulaires, 21,73&nbsp;% utilisent `required` ou `aria-required` lors du balisage des champs obligatoires. Seul un site sur cinq en fait usage. Il s’agit d’une étape simple pour rendre votre site accessible qui déverrouille des fonctionnalités de navigateur utiles pour tous les utilisateurs.

Nous avons également constaté que 3,52&nbsp;% des sites avec des formulaires utilisent `aria-invalid`. Cependant, étant donné que de nombreux formulaires n’utilisent ce champ qu’une fois que des informations incorrectes ont été soumises, nous n’avons pas pu déterminer le pourcentage réel de sites utilisant ce balisage.

#### `id`s dupliqués

Les `id` peuvent être utilisés en HTML pour lier deux éléments ensemble. Par exemple, l’élément [`<label>`](https://developer.mozilla.org/fr/docs/Web/HTML/Element/Label) fonctionne de cette façon. Vous spécifiez l’`id` du champ de saisie que cette étiquette décrit et le navigateur les relie. Le résultat&nbsp;? Les utilisateurs peuvent maintenant cliquer sur cette étiquette pour se concentrer sur le champ de saisie et les lecteurs d’écran utiliseront cette étiquette comme description.

Malheureusement, 34,62&nbsp;% des sites ont des `id` en double, ce qui signifie que sur de nombreux sites, l’`id` spécifié par l'utilisateur peut faire référence à plusieurs entrées différentes. Ainsi, lorsqu’une personne clique sur l’étiquette pour sélectionner un champ, il peut finir par <a hreflang="en" href="https://www.deque.com/blog/unique-id-attributes-matter/">sélectionner quelque chose de différent</a> que ce qui était souhaité. Comme vous pouvez l’imaginer, cela pourrait avoir des conséquences négatives dans un cas comme un panier d’achat.

Ce problème est encore plus prononcé pour les lecteurs d’écran, car leurs utilisateurs peuvent ne pas être en mesure de vérifier visuellement ce qui est sélectionné. De plus, de nombreux attributs ARIA, tels que [`aria-describedby`](https://developer.mozilla.org/fr/docs/Accessibilit%C3%A9/ARIA/Techniques_ARIA/Utiliser_l_attribut_aria-describedby) et [`aria-labelledby`](https://developer.mozilla.org/fr/docs/Accessibilit%C3%A9/ARIA/Techniques_ARIA/Utiliser_l_attribut_aria-labelledby),   fonctionnent de manière similaire à l’élément d’étiquette détaillé ci-dessus. Donc, pour rendre votre site accessible, la suppression de tous les `id` en double est une bonne première étape.

## Conclusion

Les personnes handicapées ne sont pas les seules à avoir des besoins d’accessibilité. Par exemple, toute personne qui a subi une blessure temporaire au poignet a eu du mal à taper sur de petites cibles. La vue diminue souvent avec l’âge, ce qui rend le texte écrit en petites polices difficile à lire. La dextérité des doigts n’est pas la même pour toutes les tranches d’âge, ce qui rend plus difficile l’utilisation de commandes interactives ou le balayage de contenu sur des sites web mobiles pour un pourcentage important d’utilisateurs.

De même, les logiciels d’assistance ne s’adressent pas seulement aux personnes handicapées mais améliorent l’expérience quotidienne de chacun&nbsp;:
- la popularité récente de l’assistance vocale, à la fois sur les appareils mobiles et à domicile, a démontré que le contrôle d’un appareil informatique à l’aide de commandes vocales est à la fois souhaitable et essentiel pour de nombreux utilisateurs. Les commandes vocales comme celles-ci n’étaient auparavant qu’une fonctionnalité d’accessibilité, mais se transforment désormais en un produit traditionnel&nbsp;;
- les conducteurs bénéficieraient d’une fonction de lecture d’écran qui, tout en gardant les yeux sur la route, lit à haute voix de longs textes comme des actualités&nbsp;;
- les sous-titres sont appréciés non seulement par les personnes qui ne peuvent pas entendre une vidéo, mais aussi par les personnes qui veulent regarder une vidéo dans un restaurant bruyant ou dans une bibliothèque.

Une fois un site web créé, il est souvent difficile de moderniser l’accessibilité par-dessus les structures et widgets du site existants. L’accessibilité n’est pas quelque chose qui peut être facilement saupoudré par la suite, mais doit plutôt faire partie du processus de conception et de mise en œuvre. Malheureusement, par manque de sensibilisation ou d'outils de test faciles à utiliser, de nombreux développeurs et développeuses ne connaissent pas les besoins de tous leurs utilisateurs et les exigences des logiciels d’assistance qu’ils utilisent.

Bien qu’ils ne soient pas concluants, nos résultats indiquent que l’utilisation de normes d’accessibilité comme ARIA et les meilleures pratiques d’accessibilité (par exemple, utiliser du texte alternatif) se trouvent sur une partie *importante, mais non substantielle* du web. À première vue, cela est encourageant, mais nous soupçonnons que bon nombre de ces tendances positives sont dues à la popularité de certains <i lang="en">frameworks</i> d’interface. D’une part, cela est décevant, car les développeurs et développeuses web ne peuvent pas simplement s’appuyer sur des <i lang="en">frameworks</i> d’interface pour injecter dans leurs sites un support d’accessibilité. D’un autre côté cependant, il est encourageant de voir à quel point les <i lang="en">frameworks</i> d’interface peuvent avoir un effet sur l’accessibilité du web.

À notre avis, la prochaine frontière est de rendre les widgets disponibles via les <i lang="en">frameworks</i> d’interface plus accessibles. Étant donné que de nombreux widgets complexes utilisés (par exemple, les sélecteurs de calendrier) proviennent d’une bibliothèque d’interface utilisateur, il serait formidable que ces widgets soient accessibles dès la sortie de la boîte. Nous espérons que lorsque nous collecterons nos résultats la prochaine fois, l’utilisation de rôles ARIA complexes plus correctement mis en œuvre augmentera -&nbsp;ce qui signifie que des widgets plus complexes auront également été rendus accessibles. De plus, nous espérons voir des médias plus accessibles, comme des images et des vidéos, afin que toutes les personnes utilisant le web puissent profiter de sa richesse.
