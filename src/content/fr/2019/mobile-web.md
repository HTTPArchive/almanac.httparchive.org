---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Web Mobile
description: Chapitre sur les web mobile du Web Almanac 2019, couvrant le chargement des pages, du contenu textuel, du zoom et de la mise à l’échelle, des boutons et des liens, ainsi que de la facilité à remplir les formulaires.
authors: [foxdavidj]
reviewers: [AymenLoukil, logicalphase]
analysts: [ymschaap, rviscomi]
editors: [rviscomi]
translators: [borisschapira]
discuss: 1767
results: https://docs.google.com/spreadsheets/d/1dPBDeHigqx9FVaqzfq7CYTz4KjllkMTkfq4DG4utE_g/
foxdavidj_bio: David Fox est <i lang="en">lead usability researcher</i> et fondateur de LookZook, une entreprise obsédée par tout ce qu’il y a à savoir sur la création d’expériences Web qui répondent aux attentes des utilisateurs. Il est un psychologue de sites Web qui fouille dans ces derniers pour apprendre non seulement avec quels problèmes les utilisateurs se débattent, mais pourquoi et comment améliorer au mieux leur expérience. Il est également un contributeur, un conférencier et un fournisseur de Google Chromium de webinaires et de formations UX.
featured_quote: Depuis 2007, le web mobile s’est développé à un rythme explosif. Aujourd’hui, 13 ans plus tard, le mobile représente 59&nbsp;% de toutes les recherches et 58,7&nbsp;% de tout le trafic web, selon les données de Akamai mPulse en juillet 2019. Ce n’est plus un usage secondaire, mais la principale façon dont les gens vivent le web. Alors, étant donné l’importance du mobile, quel genre d’expérience offrons-nous à nos visiteurs et visiteuses&nbsp;? Quels sont les points faibles&nbsp;? C’est ce que nous allons découvrir.
featured_stat_1: 65 %
featured_stat_label_1: des sites sont victimes de déplacements de contenu moyens ou importants pendant le chargement
featured_stat_2: 32 %
featured_stat_label_2: des sites désactivent le zoom
featured_stat_3: 34 %
featured_stat_label_3: des sites ont des cibles d'appui de tailles suffisantes
---

## Introduction

Remontons un instant dans le temps, jusqu’à l’année 2007. Le «&nbsp;web mobile&nbsp;» n’est pour l’instant que balbutiant, et pour de bonnes raisons. Pourquoi&nbsp;? Les navigateurs mobiles ne prennent pas ou peu en charge le CSS, ce qui signifie que les sites ne ressemblent pas du tout à leur version sur ordinateur de bureau –&nbsp;certains navigateurs ne peuvent afficher que du texte. Les écrans sont incroyablement petits et ne peuvent afficher que quelques lignes de texte à la fois. Et en guise de souris, de minuscules touches fléchées utilisées pour «&nbsp;tabuler&nbsp;». Il va sans dire que naviguer sur le web avec un téléphone est un véritable sacerdoce. Mais tout est sur le point de changer.

Au milieu de sa présentation, Steve Jobs prend l’iPhone qu’il vient juste de dévoiler, s’assoit et commence à surfer sur le web d’une manière dont nous n’avions jamais rêvé auparavant. Un grand écran et un navigateur complet affichant les sites web dans toute leur splendeur. Et surtout, en surfant sur le web à l’aide du dispositif de pointage le plus intuitif connu de l’Homme&nbsp;: ses doigts. Plus besoin de tabulations avec de minuscules touches fléchées.

Depuis 2007, le web mobile s’est développé à un rythme explosif. Aujourd’hui, 13 ans plus tard, le mobile représente <a hreflang="en" href="https://www.merkleinc.com/thought-leadership/digital-marketing-report">59&nbsp;% de toutes les recherches</a> et 58,7&nbsp;% de tout le trafic web, selon les données de <a hreflang="en" href="https://developer.akamai.com/akamai-mpulse-real-user-monitoring-solution">Akamai mPulse</a> de juillet 2019. Ce n’est plus un usage secondaire, mais la principale façon dont les gens vivent le web. Alors, étant donné l’importance du mobile, quel genre d’expérience offrons-nous à nos visiteurs et visiteuses&nbsp;? Quels sont les points faibles&nbsp;? C’est ce que nous allons découvrir.

## L’expérience de chargement des pages

La première partie de l’expérience du web mobile que nous avons analysée est celle que nous connaissons tous et toutes le mieux&nbsp;: _l’expérience de chargement des pages_. Mais avant de commencer à plonger dans nos découvertes, assurons-nous d’être en phase sur la définition du profil-type des personnes sur mobiles. Cela vous aidera non seulement à reproduire ces résultats, mais aussi à mieux comprendre ces personnes.

Commençons par le téléphone dont dispose ce profil-type. Le téléphone Android moyen <a hreflang="en" href="https://web.archive.org/web/20190921115844/https://www.idc.com/getdoc.jsp?containerId=prUS45115119">coûte ~250 dollars (environ 230 € hors taxe)</a>, et l’un des <a hreflang="en" href="https://web.archive.org/web/20190812221233/https://deviceatlas.com/blog/most-popular-android-smartphones">téléphones les plus populaires</a> de cette gamme est le Samsung Galaxy S6. C’est donc probablement le type de téléphone utilisé, qui est concrètement 4 fois plus lent qu’un iPhone 8. Ce profil-type n’a pas accès à une connexion 4G rapide, mais plutôt à une connexion 2G (<a hreflang="en" href="https://www.gsma.com/r/mobileeconomy/">29&nbsp;%</a> du temps) ou 3G (<a hreflang="en" href="https://www.gsma.com/r/mobileeconomy/">28&nbsp;%</a> du temps). En synthèse, voici ce que donne ce profil-type&nbsp;:

<figure>
<table>
  <tr>
    <th>Type de connexion</th>
    <td><a hreflang="en" href="https://www.gsma.com/r/mobileeconomy/">2G ou 3G</a></td>
  </tr>
  <tr>
    <th>Latence</th>
    <td>300 - 400&nbsp;ms</td>
  </tr>
  <tr>
    <th>Bande passante (descendante)</th>
    <td>0.4 - 1,6&nbsp;Mbps</td>
  </tr>
  <tr>
    <th>Modèle</th>
    <td><a hreflang="en" href="https://www.gsmarena.com/samsung_galaxy_s6-6849.php">Galaxy S6</a> — <a hreflang="en" href="https://www.notebookcheck.net/A11-Bionic-vs-7420-Octa_9250_6662.247596.0.html">4× plus lent</a> qu’un iPhone 8 (score Octane V2)</td>
  </tr>
</table>
<figcaption>{{ figure_link(caption="Profil-type, cible mobile.") }}</figcaption>
</figure>

J’imagine que des personnes seront surprises par ces résultats. Il se peut que les conditions soient bien pires que celles avec lesquelles vous avez testé votre site. Mais maintenant que nous sommes sur la même longueur d’onde en ce qui concerne le profil d’une personne sur mobile, commençons.

### Des pages surchargées de JavaScript

La quantité de code JavaScript sur le web mobile est alarmante. Selon le <a hreflang="en" href="https://httparchive.org/reports/state-of-javascript?start=2016_05_15&end=2019_07_01&view=list#bytesJs">rapport JavaScript</a> de HTTP Archive, en médiane, un site mobile demande aux téléphones de télécharger 375&nbsp;Ko de JavaScript. En supposant un taux de compression de 70&nbsp;%, cela signifie qu’en médiane, les téléphones doivent analyser, compiler et exécuter 1,25&nbsp;Mo de JavaScript.

Pourquoi est-ce un problème&nbsp;? Parce que les sites qui chargent autant de JS peuvent prendre plus de <a hreflang="en" href="https://httparchive.org/reports/loading-speed?start=earliest&end=2019_07_01&view=list#ttci">10 secondes</a> pour devenir durablement interactifs. En d’autres termes, votre page peut sembler entièrement chargée, mais lorsqu’une personne clique sur l’un de vos boutons ou menus, il peut ne rien se passer parce que le JavaScript n’a pas fini de s’exécuter. Dans le pire des scénarios, les personnes concernées se sentiront obligées de cliquer sur le bouton pendant plus de 10 secondes, en attendant le moment magique où quelque chose se passe enfin. Pensez à combien cela peut être déroutant et frustrant.

{{ figure_markup(
  video="https://www.youtube.com/embed/Lx1cYJAVnzA",
  video_width=560,
  video_height=315,
  image="fig2.png",
  caption="Exemple d’une expérience pénible où l’on attend que JS se charge.",
  description="Vidéo montrant deux pages web en train de se charger. Sur chaque page, un doigt tape à plusieurs reprises sur un bouton tout au long de la vidéo, sans effet. Il y a une horloge qui fait tic-tac à partir de 0 seconde en haut, et un premier visage d'emoji heureux pour chaque site web, qui commence à devenir moins heureux lorsque l'horloge passe 6 secondes, les yeux écarquillés à 8 secondes, en colère à 10 secondes, vraiment en colère à 13 secondes et pleurant à 19 secondes, peu de temps après que la vidéo se soit terminée.",
  width=610,
  height=343
  )
}}

Allons plus loin et examinons une autre mesure qui se concentre davantage sur _comment_ chaque page utilise JavaScript. Par exemple, a-t-elle vraiment besoin d’autant de JavaScript pendant qu’elle se charge&nbsp;? Nous appelons cette mesure le <i lang="en">JavaScript Bloat Score</i> (en français, score de surcharge de JavaScript), basé sur le <a hreflang="en" href="https://www.webbloatscore.com/">web bloat score</a>. L’idée derrière tout cela est la suivante&nbsp;:

- JavaScript est souvent utilisé pour générer et modifier la page lors de son chargement&nbsp;;
- il est également livré sous forme de texte au navigateur. Il se compresse donc bien et devrait être livré plus rapidement qu’une simple capture d’écran de la page&nbsp;;
- ainsi, si la quantité totale de JavaScript qu’une page télécharge (sans compter les images, CSS, etc.) est supérieure à une capture d’écran PNG du viewport, nous utilisons beaucoup trop de JavaScript. À ce stade, il serait plus rapide d’envoyer cette capture d’écran pour obtenir l’état initial de la page&nbsp;!

<p class="note">Le <strong>JavaScript Bloat Score</strong> est défini comme suit&nbsp;: (taille totale du JavaScript) / (taille de la capture d’écran PNG du port d’affichage). Tout nombre supérieur à 1 signifie qu’il est plus rapide d’envoyer une capture d’écran.</p>

Quels en sont les résultats&nbsp;? Sur les plus de 5 millions de sites web analysés, 75,52&nbsp;% étaient surchargés de JavaScript. Nous avons encore un long chemin à parcourir.

Notez que nous n’avons pas été en mesure de capturer et de mesurer les captures d’écran de plus de 5 millions de sites que nous avons analysés. Nous avons plutôt pris un échantillon aléatoire de 1000 sites pour trouver la taille médiane des captures d’écran (140&nbsp;Ko), puis nous avons comparé la taille de téléchargement de JavaScript de chaque site à ce nombre.

Pour une analyse plus approfondie des effets de JavaScript, consultez <a hreflang="en" href="https://medium.com/@addyosmani/the-cost-of-javascript-in-2018-7d8950fbb5d4">«&nbsp;<i lang="en">The Cost of JavaScript</i>&nbsp;» (le coût de JavaScript) écrit en 2018</a> par Addy Osmani.

### Utilisation de <span lang="en">Service Workers</span> {utilisation-de-service-workers}

Les navigateurs chargent généralement toutes les pages de la même manière. Ils donnent la priorité au téléchargement de certaines ressources par rapport à d’autres, suivent les mêmes règles de mise en cache, etc. Grâce aux <a hreflang="en" href="https://developers.google.com/web/fundamentals/primers/service-workers" lang="en">Service Workers</a>, nous avons maintenant un moyen de contrôler directement la façon dont nos ressources sont gérées par la couche réseau, ce qui permet souvent d’améliorer considérablement le temps de chargement des pages.

Mais bien qu’ils soient disponibles depuis 2016 et mis en œuvre sur tous les principaux navigateurs, seuls 0,64&nbsp;% des sites les utilisent&nbsp;!

### Déplacement du contenu pendant le chargement

L’une des plus belles réussites du web est la façon dont les pages web se chargent progressivement. Les navigateurs téléchargent et affichent le contenu dès qu’ils le peuvent, afin que les utilisateurs puissent y accéder le plus rapidement possible. Cependant, cela peut avoir un effet négatif si vous ne concevez pas votre site dans cette optique. Plus précisément, le contenu peut changer de position au fur et à mesure que les ressources se chargent, ce qui nuit à l’expérience utilisateur.

{{ figure_markup(
  image="example-of-a-site-shifting-content-while-it-loads-lookzook.gif",
  caption="Exemple de décalage du contenu qui distrait le lecteur. CLS total de 42,59&nbsp;%. Image reproduite avec l’aimable autorisation de LookZook",
  description="Une vidéo montrant le chargement progressif d’un site web. Le texte s’affiche rapidement, mais à mesure que les images continuent à se charger, le texte se déplace de plus en plus vers le bas de la page, ce qui rend la lecture très frustrante. Le CLS calculé pour cet exemple est de 42,59&nbsp;%. Image reproduite avec l’aimable autorisation de LookZook",
  width=360,
  height=640
  )
}}

Imaginez que vous êtes en train de lire un article quand, tout à coup, une image se charge et repousse le texte que vous lisez tout en bas de l’écran. Vous devez maintenant chercher où vous étiez ou simplement abandonner la lecture de l’article. Ou, pire encore, vous commencez à cliquer sur un lien juste avant qu’une annonce se charge au même endroit, ce qui se traduit par un clic accidentel sur l’annonce au lieu du lien.

Alors, comment mesurer à quel point nos sites se transforment&nbsp;? Dans le passé, c’était assez difficile (voire impossible), mais grâce à la nouvelle <a hreflang="en" href="https://web.dev/layout-instability-api" lang="en">Layout Instability API</a> (en français, «&nbsp;API relatives à l’instabilité de la mise en page&nbsp;»), nous pouvons le faire en deux étapes&nbsp;:

1. via l’API <em lang="en">Layout Instability</em>, vous pouvez mesurer l’impact de chaque mouvement dans la page. Cette mesure vous est communiqué sous la forme d’un pourcentage de la quantité de contenu du viewport (la fenêtre de visualisation) qui a changé.

2. additionnez tous les changements que vous avez relevés. Le résultat est ce que nous appelons le score de <a hreflang="en" href="https://web.dev/layout-instability-api#a-cumulative-layout-shift-score">Cumulative Layout Shift</a> (CLS).

Comme chaque visiteur peut avoir un CLS différent, afin d’analyser cette mesure sur le web avec le [Chrome UX Report](./methodology#chrome-ux-report) (CrUX), nous rangeons chaque expérience dans l’un de ces trois ensembles distincts&nbsp;:

- **Petit** CLS&nbsp;: regroupe les expériences ayant des CLS _en dessous de 5&nbsp;%_. C’est-à-dire que la page est globalement stable&nbsp;; ne varie pas beaucoup voire pas du tout. Pour mettre les choses en perspective, la page de la vidéo ci-dessus a un CLS de 42,59&nbsp;%.
- **Grand** CLS&nbsp;: regroupe les expériences ayant un CLS de _100&nbsp;% ou plus_. Il peut s’agir de nombreuses petites variations individuelles ou d’un nombre plus réduit de changements importants et significatifs.
- CLS **moyen**&nbsp;: tout ce qui se situe entre le petit et le grand.

Que constatons-nous lorsque nous regardons le CLS sur le web&nbsp;?

1. Près de deux sites sur trois (65,32&nbsp;%) ont des CLS moyens ou grands pour 50&nbsp;% ou plus de toutes les expériences utilisateurs.

2. 20,52&nbsp;% des sites ont des CLS importants pour au moins la moitié de toutes les expériences des utilisateurs. Cela représente environ un site sur cinq. N’oubliez pas que la vidéo de la figure 12.3 n’a qu’un CLS de 42,59&nbsp;%. Ces expériences sont donc encore pires&nbsp;!

Nous pensons que cette situation est due en grande partie au fait que les sites web ne fournissent pas une largeur et une hauteur explicites pour les ressources qui se chargent après que le texte a été affiché à l’écran, comme les publicités et les images. Avant que les navigateurs puissent afficher une ressource à l’écran, ils doivent savoir quelle surface la ressource occupera. À moins qu’une taille explicite ne soit fournie via des attributs CSS ou HTML, les navigateurs n’ont aucun moyen de connaître la taille réelle de la ressource. Ils affichent donc celle-ci avec une largeur et une hauteur de 0&nbsp;px jusqu’à ce qu’elle soit chargée. Lorsque la ressource est chargée et que les navigateurs savent enfin quelle est sa taille, ils déplacent le reste du contenu de la page, créant ainsi une instabilité dans la mise en page.

### Demandes d’autorisation

Ces dernières années, la démarcation entre les sites web et les applications «&nbsp;App Store&nbsp;» n’a cessé de s’estomper. Au point qu'aujourd’hui, vous avez la possibilité de demander l’accès au microphone, à la caméra vidéo, à la géolocalisation, à la possibilité d’afficher des notifications, etc.

Bien que cela ait ouvert encore plus de possibilités aux équipes de développement, le fait de demander inutilement ces autorisations peut inciter les utilisateurs et utilisatrices à se méfier de votre page web. C’est pourquoi nous recommandons de toujours lier une demande de permission à une action de la personne utilisant le site, par exemple en appuyant sur le bouton «&nbsp;Trouver des cinémas près de chez moi&nbsp;».

Actuellement, 1,52&nbsp;% des sites demandent des autorisations sans aucune intervention. Il est encourageant de voir un nombre aussi faible. Cependant, il est important de noter que nous n’avons pu analyser que les pages d’accueil. Ainsi, par exemple, les sites ne demandant des autorisations que sur leurs pages de contenu (par exemple, leurs articles de blog) n’ont pas été pris en compte. Voir notre page [Méthodologie](./methodology) pour plus d’informations.

## Contenu textuel

L’objectif premier d’une page web est de fournir un contenu exploitable par les utilisateurs et utilisatrices. Ce contenu peut être une vidéo YouTube ou un éventail d’images mais, le plus souvent, il s’agit simplement du texte de la page. Il va sans dire qu’il est extrêmement important de s’assurer que notre contenu textuel est lisible pour nos visiteurs. Car si les visiteurs ne peuvent pas le lire, il n’y a plus rien à faire, et ils partiront. Il y a deux éléments clés à vérifier pour s’assurer que votre texte est lisible&nbsp;: le contraste des couleurs et la taille des polices.

### Des couleurs contrastées

Lorsque nous concevons nos sites, nous avons tendance à être dans des conditions plus favorables et à avoir de bien meilleurs yeux que bon nombre de nos visiteurs. Les visiteurs peuvent être daltoniens et incapables de distinguer la couleur du texte et du fond. [1 femme sur 200 et 1 homme sur 12](http://www.cvrl.org/people/stockman/pubs/1999%20Genetics%20chapter%20SSJN.pdf) d’origine européenne sont daltoniens. Pensez aussi que des personnes peuvent consulter la page au moment où le soleil crée des reflets sur leur écran, ce qui peut également nuire à la lisibilité.

Pour nous aider à surmonter ces problèmes, il existe des <a hreflang="en" href="https://dequeuniversity.com/rules/axe/2.2/color-contrast">directives d’accessibilité</a> que nous pouvons suivre pour choisir nos couleurs de texte et de fond. Comment respectons-nous ces lignes directrices&nbsp;? Seuls 22,04&nbsp;% des sites donnent à l’ensemble de leur texte un contraste de couleur suffisant. Cette valeur est en fait une limite inférieure, car nous n’avons pu analyser que les textes avec un fond plein. Les images et les fonds dégradés n’ont pas pu être analysés.

{{ figure_markup(
  image="example-of-good-and-bad-color-contrast-lookzook.svg",
  caption="Exemple de ce à quoi ressemble un texte dont le contraste des couleurs est insuffisant. Avec l’aimable autorisation de LookZook",
  description="Quatre cases colorées de tons marron et gris avec du texte blanc superposé à l’intérieur créant deux colonnes, une où la couleur de fond n’est pas assez colorée par rapport au texte blanc et une où la couleur de fond est recommandée par rapport au texte blanc. Le code hexadécimal de chaque couleur est affiché, le blanc est <code>#FFFFFF</code>, la nuance claire du fond marron est <code>#FCA469</code>, et la nuance recommandée du fond marron est <code>#BD5B0E</code>. Les équivalents en niveaux de gris sont respectivement <code>#B8B8B8</code> et <code>#707070</code>. Image reproduite avec l’aimable autorisation de LookZook",
  width=568,
  height=300
  )
}}

Pour des statistiques sur le daltonisme dans d’autres groupes démographiques, voir <a hreflang="en" href="https://web.archive.org/web/20180304115406/http://www.allpsych.uni-giessen.de/karl/colbook/sharpe.pdf">ce document</a>.

### Taille des polices

La deuxième partie de la lisibilité consiste à s’assurer que le texte est suffisamment grand pour être lu facilement. C’est important pour tous les types d'utilisateurs, mais surtout pour les personnes âgées. Les tailles de police inférieures à 12&nbsp;px ont tendance à être plus difficiles à lire.

Sur l’ensemble du web, nous avons constaté que 80,66&nbsp;% des pages web répondent à ce critère de référence.

## Zoom, mise à l’échelle et rotation des pages

### Zoom et mise à l’échelle

Il est incroyablement difficile de concevoir un site qui fonctionne parfaitement sur des dizaines de milliers de tailles d’écran et de dispositifs. Certaines personnes ont besoin d’une taille de police plus importante pour lire, zoomer sur les images de vos produits, ou ont besoin d’un bouton plus grand parce qu’il est trop petit et a échappé à votre équipe d’assurance qualité. C’est pour de telles raisons que les fonctions de zoom et de mise à l’échelle des appareils sont si importantes&nbsp;: elles permettent aux gens de modifier nos pages pour qu’elles répondent à leurs besoins.

Il existe de très rares cas où la désactivation est acceptable, par exemple lorsque la page en question est un jeu en ligne utilisant des commandes tactiles. Si cette option est laissée activée dans ce cas, les téléphones des joueurs feront un zoom avant et arrière chaque fois que le joueur tapera deux fois sur le jeu, ce qui rendra l’expérience inutilisable.

Pour cette raison, les équipes de développement ont la possibilité de désactiver cette fonctionnalité en définissant l’une des deux propriétés suivantes dans la balise meta viewport&nbsp;:

1. `user-scalable` défini à `0` ou `no`

2. `maximum-scale` défini à `1`, `1.0`, etc.

{{ figure_markup(
  image="fig5.png",
  caption="Pourcentage de sites web de bureau et mobiles qui activent ou désactivent la possibilité de zoomer&nbsp;/&nbsp;la mise à l’échelle.",
  description="Diagramme à barres verticales groupées intitulé «&nbsp;Le zoom et la mise à l’échelle sont-ils activés&nbsp;?&nbsp;» mesurant les données en pourcentage, allant de 0 à 80 par incréments de 20, par rapport au type d’appareil, regroupées en bureau et mobile. Activé sur le bureau&nbsp;: 75,46&nbsp;%&nbsp;; bureau désactivé 24,54&nbsp;%&nbsp;; mobile activé&nbsp;: 67,79&nbsp;%&nbsp;; Mobile désactivé&nbsp;: 32,21&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQcVHQTKIULwgs3f2Jy8IQiHwVAJjKoHrfcvwYX5UAlb4s3bsEA2owiku4c14YZiJeG8H8acgSUul2N/pubchart?oid=655301645&format=interactive",
  width=600,
  height=370,
  data_width=600,
  data_height=370
  )
}}

Cependant, les équipes de développement ont tellement abusé de cette fonctionnalité qu’aujourd’hui, près d’un site sur trois (32,21&nbsp;%) la désactive, et Apple (à partir d’iOS 10) ne permet plus aux équipes de développement web de désactiver le zoom. Safari Mobile ignore simplement <a hreflang="en" href="https://archive.org/details/ios-10-beta-release-notes">la balise</a>. Tous les sites, quoi qu’il en soit, peuvent être zoomés et mis à l’échelle sur les nouveaux appareils Apple, qui représentent plus de <a hreflang="en" href="https://gs.statcounter.com/">11&nbsp;%</a> de tout le trafic web dans le monde&nbsp;!

### Rotation des pages

Certains appareils mobiles peuvent être tournés afin que votre site web soit affiché au format préféré des utilisateurs et utilisatrices. Cependant, les gens ne gardent pas toujours la même orientation tout au long d’une session. Lorsqu’ils remplissent des formulaires, ils peuvent passer en mode paysage pour utiliser le clavier plus grand. Ou bien, lorsqu’ils naviguent sur les produits, certains peuvent préférer les images de produits plus grandes que leur propose le mode paysage. En raison de ces types de cas d’utilisation, il est très important de ne pas les priver de cette capacité intégrée des appareils mobiles. Et la bonne nouvelle, c’est que nous n’avons trouvé pratiquement aucun site qui désactive cette fonction. Seuls 87 sites au total (soit 0,0016&nbsp;%) désactivent cette fonction. C’est fantastique.

## Boutons et liens

### Cibles d’appui

Nous sommes habitués à avoir des dispositifs de pointage précis, comme des souris, lorsque nous utilisons des ordinateurs de bureau, mais c’est une autre histoire sur mobile. Sur mobile, nous interagissons avec les sites grâce à ces outils volumineux et imprécis que nous appelons des doigts. En raison de leur imprécision, nous appuyons constamment sur des liens et des boutons sur lesquels nous ne voulions pas appuyer.

Il peut être difficile de concevoir des cibles d’appui appropriées pour atténuer ce problème en raison de la grande variété de taille des doigts. Cependant, de nombreuses recherches ont été menées et il existe des <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/tap-targets">normes</a> sûres concernant la taille des boutons et la distance qui doit les séparer.

{{ figure_markup(
  image="example-of-easy-to-hit-tap-targets-lookzook.png",
  caption="Normes de dimensionnement et d’espacement des cibles d’appui. Image reproduite avec l’aimable autorisation de LookZook.",
  description="Un diagramme montrant deux exemples de boutons difficiles à toucher. Le premier exemple montre deux boutons sans espacement entre eux. L’exemple ci-dessous montre les mêmes boutons mais avec l’espacement recommandé (8&nbsp;px ou 1-2&nbsp;mm). Le second exemple montre un bouton beaucoup trop petit pour être appuyé&nbsp;; l’exemple ci-dessous montre le même bouton agrandi à la taille recommandée de 40-48&nbsp;px (environ 8&nbsp;mm). Image reproduite avec l’aimable autorisation de LookZook",
  width=800,
  height=430
  )
}}

À l’heure actuelle, 34,43&nbsp;% des sites ont des cibles d’appui suffisamment grandes. Nous avons donc encore beaucoup de chemin à parcourir avant que les erreurs liées aux «&nbsp;gros doigts&nbsp;» soient derrière nous.

### Libellés des boutons

Certains designers aiment utiliser des icônes à la place du texte&nbsp;; elles peuvent donner à nos sites un aspect plus net et plus élégant. Mais si vous et tous les membres de votre équipe savez ce que ces icônes signifient, beaucoup de vos visiteurs et visiteuses ne le sauront pas. C’est même le cas de la fameuse icône «&nbsp;hamburger&nbsp;»&nbsp;! Si vous ne nous croyez pas, faites des tests utilisateurs et voyez à quel point ils peuvent être confus. Vous serez stupéfait·e.

C’est pourquoi il est important d’éviter toute confusion et d’ajouter du texte complémentaire et des étiquettes à vos boutons. À l’heure actuelle, au moins 28,59&nbsp;% des sites incluent un bouton avec une seule icône sans texte complémentaire.

<p class="note">Note&nbsp;: le nombre indiqué ci-dessus n’est qu’une limite inférieure. Au cours de notre analyse, nous n’avons inclus que les boutons utilisant des icônes de police sans texte complémentaire. Cependant, de nombreux boutons utilisent désormais des SVG au lieu d’icônes de police, aussi les inclurons-nous également dans les prochaines exécutions.</p>

## Champs de formulaire sémantique

Qu’il s’agisse de s’inscrire à un nouveau service, d’acheter quelque chose en ligne ou même de recevoir des notifications de nouveaux messages sur un blog, les champs de formulaire sont une partie essentielle du web et sont utilisés quotidiennement. Malheureusement, ces champs sont tristement célèbres parce qu’ils sont très pénibles à remplir sur un téléphone portable. Heureusement, ces dernières années, les navigateurs ont donné aux équipes de développement de nouveaux outils pour faciliter le remplissage de ces champs que nous ne connaissons que trop bien. Voyons donc à quel point ils ont été utilisés.

### Nouveaux types de saisie

Dans le passé, `text` et `password` étaient parmi les seuls types de saisie (`<input>`) disponibles pour les équipes de développement, car ils répondaient à presque tous nos besoins sur ordinateurs de bureau. Ce n’est pas le cas pour les appareils mobiles. Les claviers mobiles sont incroyablement petits, et une tâche simple, comme la saisie d’une adresse électronique, peut obliger les utilisateurs à passer d’un clavier à l’autre&nbsp;: le clavier standard et le clavier à caractères spéciaux pour le symbole `@`. La simple saisie d’un numéro de téléphone peut être difficile en utilisant les minuscules chiffres du clavier par défaut.

De nombreux [nouveaux types de saisies](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#Form_%3Cinput%3E_types) ont été introduits depuis, permettant aux équipes de développement d’informer les navigateurs du type de données attendu et permettant aux navigateurs de fournir des claviers personnalisés spécifiquement pour ces types de saisie. Par exemple, le type `email` permet au navigateur de fournir un clavier alphanumérique comprenant le symbole `@`, et le type `tel`, un clavier numérique.

Lors de l’analyse des sites contenant une saisie d’email, 56,42&nbsp;% utilisent `type="email"`. De même, pour les saisies de numéros de téléphone, `type="tel"` est utilisé 36,7&nbsp;% du temps. Les autres nouveaux types de saisie ont un taux d’adoption encore plus faible.

<figure>
  <table>
    <tr>
      <th>Type</th>
      <th>Fréquence (pages)</th>
    </tr>
    <tr>
      <td>phone</td>
      <td class="numeric">1,917</td>
    </tr>
    <tr>
      <td>name</td>
      <td class="numeric">1,348</td>
    </tr>
    <tr>
      <td>textbox</td>
      <td class="numeric">833</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Types de saisie invalides les plus couramment utilisés") }}</figcaption>
</figure>

Assurez-vous de bien vous informer et de renseigner les autres sur la grande quantité de types de saisie disponibles et vérifiez que vous n’avez pas de fautes de frappe, à l’image des plus courantes, reprises dans la figure 12.7 ci-dessus.

### Activation de l’autocomplétion pour les saisies

L’attribut [`autocomplete`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) de l’élément `<input>` permet aux gens de remplir les champs du formulaire en un seul clic. Ils remplissent des tonnes de formulaires, souvent avec exactement les mêmes informations à chaque fois. Conscients de ce fait, les navigateurs ont commencé à stocker ces informations de manière sécurisée afin de pouvoir les réutiliser. Tout ce que les équipes de développement doivent faire, c’est utiliser cet attribut `autocomplete` pour indiquer aux navigateurs quelle est l’information exacte à remplir, et le navigateur fait le reste.

{{ figure_markup(
  caption="Pourcentage des pages utilisant <code>autocomplete</code>.",
  content="29,62&nbsp;%",
  classes="big-number"
)
}}

Actuellement, seules 29,62&nbsp;% des pages comportant des champs de saisie utilisent cette fonction.

### Saisie des champs de mot de passe

Permettre aux utilisateurs de copier et de coller leurs mots de passe dans votre page leur permet d’utiliser un gestionnaire de mots de passe. Les gestionnaires de mots de passe aident les utilisateurs à générer (et à mémoriser) des mots de passe forts et à les remplir automatiquement sur les pages web. Seulement 0,02&nbsp;% des pages web testées désactivent cette fonctionnalité.

<p class="note">Note&nbsp;: Bien que cela soit très encourageant, il s’agit peut-être d’une sous-estimation en raison de l’exigence de notre <a href="./methodology">méthodologie</a> de ne tester que les pages d’accueil. Les pages intérieures, comme les pages de connexion, ne sont pas testées.</p>

## Conclusion

Pendant plus de 13 ans, nous avons traité le web *mobile* de façon accessoire, comme une vulgaire alternative aux sites pour ordinateurs de bureau. Mais il est temps que cela change. Le web mobile est maintenant *le* web, et les sites pour ordinateurs de bureau tombent en désuétude. Il y a maintenant 4 milliards de smartphones actifs dans le monde, couvrant 70&nbsp;% de tous les utilisateurs potentiels. Qu’en est-il des ordinateurs de bureau&nbsp;? Ils sont actuellement 1,6 milliard et représentent de moins en moins d’utilisateurs du web chaque mois.

Comment nous débrouillons-nous pour répondre aux besoins des utilisateurs de téléphones portables&nbsp;? Selon nos recherches, même si 71&nbsp;% des sites font des efforts pour adapter leur site au mobile, ils sont loin d’atteindre leur objectif. Les pages mettent une éternité à se charger et deviennent inutilisables en raison d’un abus de JavaScript, le texte est souvent impossible à lire, l’interaction avec les sites en cliquant sur des liens ou des boutons est source d’erreurs et d’exaspération, et des tonnes de fonctionnalités formidables inventées pour atténuer ces problèmes (<span lang="en">Service Workers</span>, saisie automatique, zoom, nouveaux formats d’image, etc) sont à peine utilisées.

Le web mobile existe maintenant depuis assez longtemps pour qu’il y ait toute une génération d’enfants pour qui c’est le seul internet qu’ils aient jamais connu. Et quel genre d’expérience leur donnons-nous&nbsp;? Nous les ramenons essentiellement à l’ère du modem (heureusement qu’AOL vend encore ces CD qui offrent 1000 heures d’accès gratuit à l’internet)&nbsp;!

{{ figure_markup(
  image="america-online-1000-hours-free.jpg",
  caption='1000 heures d’AOL gratuites, image issue de <a hreflang="en" href="https://archive.org/details/America_Online_1000_Hours_Free_for_45_Days_Version_7.0_Faster_Than_Ever_AM402R28">archive.org</a>.',
  description="Une photo d’un CD-ROM AOL offrant 1000 heures gratuites.",
  width=300,
  height=285
  )
}}

<p class="note" data-markdown="1">Notes&nbsp;:

1. Nous avons considéré que les sites faisant un effort en matière de mobile sont ceux qui adaptent leur design à des écrans plus petits. Ou plutôt, ceux qui ont au moins un point de rupture CSS à 600&nbsp;px ou moins.

2. Les utilisateurs et utilisatrices potentielles, ou le marché total adressable, se composent des personnes âgées de 15 ans et plus&nbsp;: soit <a hreflang="en" href="https://www.prb.org/international/geography/world">5,7 milliards de personnes</a>.

3. <a hreflang="en" href="https://gs.statcounter.com/platform-market-share/desktop-mobile-tablet/worldwide/#monthly-201205-201909">Les part de marché du web sur ordinateurs de bureau</a> sont en déclin depuis des années, tout comme <a hreflang="en" href="https://www.merkleinc.com/thought-leadership/digital-marketing-report">la recherche sur ces matériels</a>

4. Le nombre total de smartphones actifs a été trouvé en additionnant le nombre de téléphones Android et iPhone actifs (rendus publics par Apple et Google), et un peu de maths pour prendre en compte les téléphones chinois connectés à Internet. <a hreflang="en" href="https://www.ben-evans.com/benedictevans/2019/5/28/the-end-of-mobile">Plus d’infos ici</a>.

5. Le nombre de 1,6 milliards d’ordinateurs de bureau est calculé à partir de nombres rendus publics par <a hreflang="en" href="https://web.archive.org/web/20181030132235/https://news.microsoft.com/bythenumbers/en/windowsdevices">Microsoft</a> et <a hreflang="en" href="https://web.archive.org/web/20190628161024/https://appleinsider.com/articles/18/10/30/apple-passes-100m-active-mac-milestone-thanks-to-high-numbers-of-new-users">Apple</a>. Il n’inclut pas les ordinateurs Linux.
</p>
