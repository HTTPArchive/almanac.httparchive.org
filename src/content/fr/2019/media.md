---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Media
description: Chapitre Média du Web Almanac 2019 couvrant les tailles et formats des fichiers d’images, les images adaptatives, les Indications Client, le lazy loading, l’accessibilité et la vidéo.
hero_alt: Hero image of Web Almanac characters projecting an image onto a screen while other Web Almanac characters walk to cinema seats with popcorn to watch the projection.
authors: [colinbendell, dougsillars]
reviewers: [ahmadawais, eeeps]
analysts: [dougsillars, rviscomi]
editors: [tunetheweb]
translators: [borisschapira]
discuss: 1759
results: https://docs.google.com/spreadsheets/d/1hj9bY6JJZfV9yrXHsoCRYuG8t8bR-CHuuD98zXV7BBQ/
colinbendell_bio: Colin fait partie du <i lang="en">CTO Office</i> de <a hreflang="en" href="https://cloudinary.com/">Cloudinary</a> et est co-auteur du livre O’Reilly <a hreflang="en" lang="en" href="https://www.oreilly.com/library/view/high-performance-images/9781491925799/">High Performance Images</a>. Il passe une grande partie de son temps à l’intersection des données à haut volume, des médias, des navigateurs et des standards. Vous le trouverez twittant en tant que <a href="https://x.com/colinbendell">@colinbendell</a> et sur son blog <a hreflang="en" href="https://bendell.ca/">https://bendell.ca</a>.
dougsillars_bio: Doug Sillars est un nomade numérique indépendant qui travaille à l’intersection de la performance et des médias. Il tweete sous <a href="https://x.com/dougsillars">@dougsillars</a>, et blogue régulièrement sur <a hreflang="en" href="https://dougsillars.com">dougsillars.com</a>.
featured_quote: Les images, les animations et les vidéos constituent une partie significative de l’expérience Web. Elles sont importantes pour de nombreuses raisons&nbsp;&colon; elles aident à raconter des histoires, à faire participer le public et à fournir une expression artistique d’une manière qui, souvent, ne peut pas être facilement produite avec d’autres technologies du web. L’importance de ces ressources médias peut être démontrée de deux façons&nbsp;&colon; par le volume d’octets téléchargés pour une page, mais aussi par la quantité de pixels utilisés pour afficher ces médias.
featured_stat_1: 1 Mo
featured_stat_label_1: taille médiane d’une page d’accueil
featured_stat_2: 60 %
featured_stat_label_2: des images sont des JPEG
featured_stat_3: 2 %
featured_stat_label_3: des pages utilisent l’élément `<picture>`
---

## Introduction
Les images, les animations et les vidéos constituent une partie significative de l’expérience Web. Elles sont importantes pour de nombreuses raisons&nbsp;: elles aident à raconter des histoires, à faire participer le public et à fournir une expression artistique d’une manière qui, souvent, ne peut pas être facilement produite avec d’autres technologies du web. L’importance de ces ressources médias peut être démontrée de deux façons&nbsp;: par le volume d’octets téléchargés pour une page, mais aussi par la quantité de pixels utilisés pour afficher ces médias.

D’un point de vue purement octet, HTTP Archive a <a hreflang="en" href="https://legacy.httparchive.org/interesting.php#bytesperpage">historiquement remarqué</a> qu’en moyenne, plus de deux tiers des octets proviennent de ressources associées aux médias. Du point de vue de la distribution, nous pouvons voir que pratiquement chaque page web dépend d’images et de vidéos. Même au dixième percentile, nous constatons que 44&nbsp;% des octets proviennent des médias et peuvent atteindre 91&nbsp;% du total des octets au 90e percentile des pages.

{{ figure_markup(
  image="fig1_bytes_images_and_video_versus_other.png",
  caption="Octets de pages web&nbsp;: image et vidéo par rapport au reste.",
  description="Diagramme à barres montrant qu’au 10e percentile, 44,1&nbsp;% des octets de page sont des médias, au 25e percentile, 52,7&nbsp;% sont des médias, au 50e percentile, 67,0&nbsp;% sont des médias, au 75e percentile, 81,7&nbsp;% sont des médias et au 90e percentile, 91,2&nbsp;% sont des médias.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1189524305&format=interactive"
  )
}}

Bien que les médias soient essentiels pour l’expérience visuelle, l’impact de ce volume élevé d’octets a deux effets secondaires.

Tout d’abord, la surcharge du réseau nécessaire pour télécharger ces octets peut être importante. Dans les environnements où le réseau est cellulaire ou lent (comme dans les cafés ou en cas de <i lang="en">tethering</i> dans un Uber), cela peut ralentir considérablement la [performance de la page](./performance). Les images sont une requête de moindre priorité du navigateur, mais elles peuvent facilement bloquer le téléchargement des CSS et des scripts JavaScript, amenant à retarder le rendu de la page. Cependant, à d’autres moments, le contenu de l’image est le signal visuel qui indique à l’utilisateur que la page est prête. Quand les transferts de contenu visuel sont lents, ils peuvent ainsi donner la perception d’une page web lente.

Le deuxième impact est le coût financier pour l’utilisateur. C’est un aspect souvent ignoré, car il ne constitue pas une charge pour le propriétaire du site web mais pour l’utilisateur final. Il a été rapporté que certains marchés, [comme le Japon](https://x.com/yoavweiss/status/1195036487538003968?s=20), enregistrent une baisse des achats des étudiants vers la fin du mois, lorsque les limites de données sont atteintes, et que les utilisateurs ne peuvent pas voir le contenu visuel.

En outre, le coût financier de la visite de ces sites web dans différentes parties du monde est disproportionné. Au niveau de la médiane et du 90e percentile, le volume des octets d’images est respectivement de 1&nbsp;Mo et de 1,9&nbsp;Mo. En utilisant <a hreflang="en" href="https://whatdoesmysitecost.com/#gniCost">WhatDoesMySiteCost.com</a> et en regardant le revenu national brut (RNB) par habitant, on peut voir qu’à Madagascar, le chargement d’une seule page web au 90e percentile coûterait à un utilisateur 2,6&nbsp;% du revenu brut quotidien. En revanche, en Allemagne, ce coût serait de 0,3&nbsp;% du revenu brut quotidien.

{{ figure_markup(
  image="fig2_total_image_bytes_per_web_page_mobile.png",
  caption="Total des octets d’images par page web (mobile).",
  description="La page web médiane sur le mobile nécessite 1&nbsp;Mo d’images et 4,9&nbsp;Mo au 90e percentile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2025280105&format=interactive"
  )
}}

Si on ne considère que les octets par page, on ne tient compte que du coût en performance pour la page et l’utilisateur, mais on néglige les avantages. Ces octets sont importants pour le rendu des pixels à l’écran. C’est pourquoi nous pouvons aussi mesurer la prédominance des images et des ressources vidéo en examinant le nombre de pixels média utilisés par page.

Il y a trois mesures à prendre en compte lorsqu’on regarde le volume des pixels&nbsp;: les pixels CSS, les pixels naturels et les pixels de l’écran.

* Les _pixels CSS_ se mesurent dans la mise en page CSS. Cette mesure se concentre sur les boîtes englobantes dans lesquelles une image ou une vidéo pourrait être étirée ou comprimée. Elle ne prend pas non plus en compte les pixels réels du fichier ni les pixels d’affichage à l’écran.
* Les _pixels naturels_ se réfèrent aux pixels logiques représentés dans un fichier. Si vous chargiez cette image dans GIMP ou Photoshop, les dimensions du fichier de pixels seraient les pixels naturels.
* Les _pixels de l’écran_ se réfèrent à l’électronique physique de l’écran. Avant les téléphones mobiles et les écrans modernes à haute résolution, il existait une relation 1:1 entre les pixels CSS et les points LED d’un écran. Cependant, comme les appareils mobiles sont tenus plus près de l'œil et que les écrans d’ordinateurs portables sont plus proches que les anciens terminaux <i lang="en">mainframe</i>, les écrans modernes ont un rapport plus élevé entre les pixels physiques et les pixels CSS traditionnels. Ce rapport est appelé &laquo;&nbsp;<span lang="en">Device-Pixel-Ratio</span>&nbsp;&raquo; ou, plus communément, &laquo;&nbsp;affichage Retina™&nbsp;&raquo;.

{{ figure_markup(
  image="fig3_image_pixel_per_page_mobile_css_v_actual.png",
  caption="Pixels d’image par page (mobile)&nbsp;: pixels CSS par rapport aux pixels naturels.",
  description="Une comparaison des pixels CSS alloués au contenu de l’image par rapport aux pixels d’image naturels pour les mobiles, montrant le 10e percentile (0,07&nbsp;MP réels, 0,04&nbsp;MP CSS), le 25e percentile (0,38&nbsp;MP réel, 0,18&nbsp;MP CSS), le 50e percentile (1,6&nbsp;MP réel, 0,65&nbsp;MP CSS), le 75e percentile (5,1&nbsp;MP réel, 1,8&nbsp;MP CSS), et le 90e percentile (12&nbsp;MP réel, 4,6&nbsp;MP CSS)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2027393897&format=interactive"
  )
}}

{{ figure_markup(
  image="fig4_image_pixel_per_page_desktop_css_v_actual.png",
  caption="Pixels d’image par page (ordinateurs de bureau)&nbsp;: pixels CSS par rapport aux pixels naturels.",
  description="Une comparaison des pixels CSS alloués au contenu de l’image par rapport aux pixels d’image naturels pour les ordinateurs de bureau, montrant le 10e percentile (0,09&nbsp;MP réels, 0,05&nbsp;MP CSS), le 25e percentile (0,52&nbsp;MP réel, 0,29&nbsp;MP CSS), le 50e percentile (2,1&nbsp;MP réel, 1,1&nbsp;MP CSS), le 75e percentile (6,0&nbsp;MP réel, 2,78&nbsp;MP CSS), et le 90e percentile (14&nbsp;MP réel, 6,3&nbsp;MP CSS)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1364487787&format=interactive"
  )
}}

En regardant le volume de pixels CSS et le volume de pixels naturels, on peut voir que le site web médian a une mise en page qui affiche un mégapixel (MP) de contenu média. Au 90e percentile, le volume de pixels de la mise en page CSS passe à 4,6&nbsp;MP et 6,3&nbsp;MP respectivement pour les mobiles et les ordinateurs de bureau. Cela est intéressant non seulement parce que la mise en page adaptative (<i lang="en">responsive</i>) est probablement différente, mais aussi parce que la forme du matériel est différente. En bref, la mise en page pour mobiles offre moins d’espace alloué aux médias que celle pour ordinateurs de bureau.

En revanche, le volume de pixels naturels, ou de fichiers, est entre 2 et 2,6 fois le volume de la mise en page. La page web de bureau médiane envoie 2,1&nbsp;MP de contenu en pixels qui est affiché dans 1,1&nbsp;MP d’espace de mise en page. Au 90e percentile sur mobile, nous voyons 12 MP comprimés en 4,6 MP.

Bien sûr, le format d’un appareil mobile est différent de celui d’un ordinateur de bureau. Un appareil mobile est plus petit et généralement tenu en mode portrait, tandis qu’un ordinateur de bureau est plus grand et utilisé principalement en mode paysage. Comme mentionné précédemment, un appareil mobile a également un ratio de pixels de l’appareil (Device Pixel Ratio, DPR) plus élevé parce qu’il est tenu beaucoup plus près de l'œil, ce qui nécessite plus de pixels par pouce que ce dont vous auriez besoin sur un panneau d’affichage à Times Square. Ces différences obligent à modifier la mise en page et les utilisateurs de téléphones portables font plus souvent défiler un site pour consommer la totalité du contenu.

Les mégapixels sont une métrique difficile car elle est largement abstraite. Une façon pratique d’exprimer ce volume de pixels utilisé sur une page web est de le représenter sous forme de rapport par rapport à la surface d’affichage.

Pour le terminal mobile utilisé pour le parcours des pages web, nous avons un affichage de `512 x 360`, soit 0,18&nbsp;MP de contenu CSS (à ne pas confondre avec l’écran physique qui est de `3x` ou 3^2 pixels de plus, soit 1,7&nbsp;MP). En divisant ce volume de pixels de visualisation par le nombre de pixels CSS alloués aux images, on obtient un volume de pixels relatif.

Si nous avions une image qui remplissait parfaitement tout l’écran, le taux de remplissage serait de 1x le taux de pixel. Bien sûr, il est rare qu’un site web remplisse toute la surface de la page avec une seule image. Le contenu des médias a tendance à se mélanger avec le design et d’autres contenus. Une valeur supérieure à 1x implique que la mise en page oblige l’utilisateur à faire défiler l’image pour voir le contenu supplémentaire.

<aside class="note">Remarque&nbsp;: ceci ne concerne que la mise en page CSS, à la fois pour le ratio de pixels et le volume du contenu de la mise en page. Il ne s’agit pas d’évaluer la pertinence des images adaptatives ou la pertinence de fournir des contenus à haute densité de pixels.</aside>

{{ figure_markup(
  image="fig5_image_pixel_volume_v_css_pixels.png",
  caption="Volume des pixels des images en fonction de la taille de l’écran (pixels CSS).",
  description="Une comparaison du volume de pixels requis par page par rapport à la taille réelle de l’écran en pixels CSS, montrant le 10e percentile (20&nbsp;% mobile, 2&nbsp;% bureau), le 25e percentile (97&nbsp;% mobile, 13&nbsp;% bureau), le 50e percentile (354&nbsp;% mobile, 46&nbsp;% bureau), le 75e percentile (1003&nbsp;% mobile, 123&nbsp;% bureau), et le 90e percentile (2477&nbsp;% mobile, 273&nbsp;% bureau).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1889020047&format=interactive"
  )
}}

Au niveau de la page web médiane sur ordinateur de bureau, 46&nbsp;% de l’affichage est occupé par des images et de la vidéo. En revanche, sur un téléphone portable, le volume de pixels des médias remplit 3,5 fois la taille réelle de l’écran. La mise en page comporte plus de contenu qu’il n’est possible d’en remplir dans un seul écran, ce qui oblige l’utilisateur à faire défiler les pages. Au minimum, il y a 3,5 pages de contenu défilant par site (en supposant une saturation de 100&nbsp;%). Au 90e percentile pour les mobiles, ce chiffre augmente considérablement pour atteindre 25 fois la taille de la fenêtre&nbsp;!

Les ressources médias sont essentielles pour l’expérience utilisateur.

## Images

Un grand nombre d’articles ont déjà été écrits sur la gestion et l’optimisation des images afin de réduire les octets et d’optimiser l’expérience utilisateur. C’est un sujet important et critique pour beaucoup, car ce sont les médias imaginatifs qui définissent l’expérience d’une marque. Par conséquent, l’optimisation des images et du contenu vidéo est un exercice d’équilibre entre la mise en œuvre des bonnes pratiques pouvant aider à réduire les octets transférés sur le réseau et la préservation de la fidélité de l’expérience recherchée.

Si les stratégies utilisées pour les images, les vidéos et les animations sont globalement similaires, les approches spécifiques peuvent être très différentes. En général, ces stratégies se résument à&nbsp;:

* **Formats de fichier** - utiliser le format de fichier optimal
* **Responsive** - appliquer des techniques d’images adaptatives pour ne transférer que les pixels qui seront affichés à l’écran
* **Lazy loading** - ne transférer les contenus que lorsqu’un être humain les verra
* **Accessibilité** - garantir une expérience de qualité pour tous les êtres humains

<aside class="note">Un avertissement concernant l’interprétation de ces résultats. Les pages web explorées pour le Web Almanac ont été explorées sur un navigateur Chrome. Cela implique que toute négociation de contenu qui pourrait mieux s’appliquer à Safari ou Firefox pourrait ne pas être représentée dans cet ensemble de données. Par exemple, l’utilisation de formats de fichiers comme JPEG2000, JPEG-XR, HEVC et HEIC est absente car ceux-ci ne sont pas pris en charge par Chrome. Cela ne signifie pas que le web ne contient pas ces autres formats ou expériences. De même, Chrome supporte en natif le <i lang="en">lazy loading</i> (depuis la version 76), ce qui n’est pas encore disponible dans les autres navigateurs. Pour en savoir plus sur ces réserves, consultez notre <a href="./methodology">Méthodologie</a>.</aside>

Il est rare de trouver une page web qui n’utilise pas d’images. Au fil des ans, de nombreux formats de fichiers différents sont apparus pour aider à présenter le contenu sur le web, chacun répondant à un problème différent. Il existe principalement 4 principaux formats d’images universels&nbsp;: JPEG, PNG, GIF et SVG. En outre, Chrome a enrichi le catalogue de médias et a ajouté la prise en charge d’un cinquième format d’image&nbsp;: WebP. D’autres navigateurs ont également ajouté la prise en charge des formats JPEG2000 (Safari), JPEG-XL (IE et Edge) et HEIC (WebView uniquement dans Safari).

Chaque format a ses propres mérites et a des utilisations idéales pour le web. Un résumé très simplifié se décomposerait ainsi&nbsp;:

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Format</th>
        <th scope="col" class="width-45">Points forts</th>
        <th scope="col" class="width-45">Inconvénients</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>JPEG</td>
        <td><ul><li>Supporté universellement</li><li>Idéal pour les contenus photographiques</li></ul></td>
        <td><ul><li>Il y a toujours une perte de qualité</li><li>La plupart des décodeurs ne peuvent pas traiter les photos à grande profondeur en octets provenant d’appareils photo modernes (> 8 octets par canal)</li><li>Pas de support de la transparence</li></ul></td>
      </tr>
      <tr>
      <td>PNG</td>
        <td><ul><li>Comme JPEG et GIF, bénéficie d’un large support</li><li>Sans perte</li><li>Supporte la transparence, l’animation et une grande profondeur d’octets</li></ul></td>
        <td><ul><li>Fichiers beaucoup plus volumineux que le JPEG</li><li>Pas idéal pour le contenu photographique</li></ul></td>
      </tr>
      <tr>
        <td>GIF</td>
        <td><ul><li>Le prédécesseur de PNG, est surtout connu pour ses animations</li><li>Sans perte</li></ul></td>
        <td><ul><li>En raison de la limitation des 256 couleurs, il y a toujours une perte visuelle due à la conversion</li><li>Fichiers très volumineux pour les animations</li></ul></td>
      </tr>
      <tr>
        <td>SVG</td>
        <td><ul><li>Un format vectoriel qui peut être redimensionné sans augmenter la taille du fichier</li><li>Elle est basée sur les mathématiques plutôt que sur les pixels et crée des lignes lisses</li></ul></td>
<td><ul><li>Non utile pour les contenus photographiques ou autres contenus tramés</li></ul></td>
      </tr>
      <tr>
        <td>WebP</td>
        <td><ul><li>Un format de fichier plus récent qui peut produire des images sans perte comme le PNG et des images avec perte comme le JPEG</li><li>Il <a hreflang="en" href="https://developers.google.com/speed/webp/faq">prétend être 30&nbsp;% plus affichage que</a> le JPEG, alors que d’autres données suggèrent que la réduction médiane des fichiers se situe <a hreflang="en" href="https://cloudinary.com/state-of-visual-media-report/">entre 10 et 28&nbsp;% suivant le volume de pixels</a>.</li></ul></td>
        <td><ul><li>Contrairement au JPEG, il est limité à un sous-échantillonnage chromatique qui rendra certaines images floues.</li><li>Ne bénéficie pas d’un support généralisé. Uniquement les écosystèmes Chrome, Firefox et Android.</li><li>Support de fonctionnalités fragmenté suivant les versions de navigateur</li></ul></td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Explication des principaux formats de fichiers.") }}</figcaption>
</figure>

### Formats d’images

Dans l’ensemble, à travers l’ensemble des pages, nous voyons en effet la prédominance de ces formats. Le JPEG, l’un des plus anciens formats du web, est de loin le format d’image le plus utilisé avec 60&nbsp;% des requêtes d’image et 65&nbsp;% de tous les octets d’image. Il est intéressant de noter que le PNG est le deuxième format d’image le plus utilisé&nbsp;: 28&nbsp;% des requêtes d’images et des octets. La généralisation de son support ainsi que la précision des couleurs et la créativité de son contenu expliquent probablement sa large utilisation. En revanche, le SVG, le GIF et le WebP partagent presque la même utilisation avec 4&nbsp;%.

{{ figure_markup(
  image="fig7_image_format_usage.png",
  caption="Utilisation des formats d’image.",
  description="Une carte arborescente montrant que le JPEG est utilisé 60,27&nbsp;% du temps, le PNG 28,2&nbsp;%, le WebP 4,2&nbsp;%, le GIF 3,67&nbsp;% et le SVG 3,63&nbsp;%.",
  width=600,
  height=376
  )
}}

Bien entendu, les pages web n’utilisent pas toutes le contenu des images de la même manière. Certaines dépendent des images plus que d’autres. Il suffit de regarder la page d’accueil de `google.com` pour voir très peu d’images par rapport à un site d’information typique. En effet, le site web médian compte 13 images, 61 images au 90e percentile, et un nombre impressionnant de 229 images au 99e percentile.

{{ figure_markup(
  image="fig8_image_format_usage_per_page.png",
  caption="Utilisation des formats d’image par page.",
  description="Un diagramme à barres montrant qu’au 10e percentile&nbsp;: aucun format d’image n’est utilisé&nbsp;; au 25e percentile&nbsp;: trois JPG et quatre PNG sont utilisés&nbsp;; au 50e percentile&nbsp;: neuf JPG, quatre PNG et un GIF sont utilisés&nbsp;; au 75e percentile&nbsp;: 39 JPEG, 18 PNG, deux SVG et deux GIF sont utilisés et au 99e percentile&nbsp;: 119 JPG, 49 PNG, 28 WebP, 19 SVG et 14 GIF sont utilisés.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=294858455&format=interactive"
  )
}}

Bien que la page médiane comporte neuf JPEG et quatre PNG, et que les GIF n’aient été utilisés que dans les 25&nbsp;% de pages les plus importantes, cela ne rend pas compte du taux d’adoption. L’utilisation et la fréquence de chaque format par page ne donnent pas d’indications sur l’adoption des formats plus modernes. Plus précisément, quel pourcentage de pages comprend au moins une image dans chaque format&nbsp;?

{{ figure_markup(
  image="fig9_pages_using_at_least_1_image.png",
  caption="Pourcentage de pages utilisant au moins une image.",
  description="Un diagramme à barres montrant que les JPEG sont utilisés sur 90&nbsp;% des pages, les PNG sur 89&nbsp;%, les WebP sur 9&nbsp;%, les GIF sur 37&nbsp;% et les SVG sur 22&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1024386063&format=interactive"
  )
}}

Ceci explique pourquoi, même au 90e percentile des pages, la fréquence de WebP est toujours nulle&nbsp;; seules 9&nbsp;% des pages web contiennent ne serait-ce qu’une seule ressource. De nombreuses raisons peuvent expliquer que le WebP ne soit pas le bon choix pour une image, mais l’adoption des bonnes pratiques médias, comme l’adoption du WebP lui-même, n’en est encore qu’à ses débuts.

### Taille des fichiers d’images

Il y a deux façons de considérer la taille des fichiers d’images&nbsp;: les octets absolus par ressource et les octets par pixel.

{{ figure_markup(
  image="fig10_image_format_size.png",
  caption="Taille du fichier (Ko) par format d’image.",
  description="Un tableau montrant qu’au 10e percentile, 4&nbsp;Ko de JPEG, 2&nbsp;Ko de PNG et 2&nbsp;Ko de GIF sont utilisés&nbsp;; au 25e percentile, 9&nbsp;Ko de JPG, 4&nbsp;Ko de PNG, 7&nbsp;Ko de WebP, et 3&nbsp;Ko de GIF sont utilisés&nbsp;; au 50e percentile, 24&nbsp;Ko de JPG, 11&nbsp;Ko de PNG, 17&nbsp;Ko de WebP, 6&nbsp;Ko de GIF, et 1&nbsp;Ko de SVG sont utilisés&nbsp;; au 75e percentile, 68&nbsp;Ko de JPEG, 43&nbsp;Ko de PNG, 41&nbsp;Ko de WebP, 17&nbsp;Ko de GIF et 2&nbsp;Ko de SVG sont utilisés&nbsp;; au 90e percentile, 116&nbsp;Ko de JPG, 152&nbsp;Ko de PNG, 90&nbsp;Ko de WebP, 87&nbsp;Ko de GIF et 8&nbsp;Ko de SVG sont utilisés."
)
}}

Grâce à ces informations, nous pouvons commencer à avoir une idée de la taille d’une ressource typique sur le web. Cependant, cela ne nous donne pas encore une idée du volume de pixels représentés à l’écran pour ces distributions de fichiers. Pour ce faire, nous pouvons diviser chaque octet de ressource par le volume naturel de pixels de l’image. Un faible nombre d’octets par pixel indique une transmission plus efficace du contenu visuel.

{{ figure_markup(
  image="fig11_bytes_per_pixel.png",
  caption="Octets par pixel.",
  description="Un graphique en chandeliers japonais montrant qu’au 10e percentile, nous avons 0,1175 octets par pixel pour le JPEG, 0,1197 pour le PNG, 0,1702 pour le GIF, 0,0586 pour le WebP et 0,0293 pour le SVG. Au 25e percentile, nous avons 0,1848 octets par pixel pour les JPEG, 0,2874 pour les PNG, 0,3641 pour les GIF, 0,1025 pour les WebP et 0,174 pour les SVG. Au 50e percentile, nous avons 0,2997 octets par pixel pour les JPEG, 0,6918 pour les PNG, 0,7967 pour les GIF, 0,183 pour les WebP et 0,6766 pour les SVG. Au 75e percentile, nous avons 0,5456 octets par pixel pour les JPEG, 1,4548 pour les PNG, 2,515 pour les GIF, 0,3272 pour les WebP et 1,9261 pour les SVG. Au 90e percentile, nous avons 0,9822 octets par pixel pour les JPEG, 2,5026 pour les PNG, 8,5151 pour les GIF, 0,6474 pour les WebP et 4,1075 pour les SVG.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1379541850&format=interactive"
  )
}}

Alors qu’auparavant, il semblait que les fichiers GIF étaient plus petits que les JPEG, nous pouvons maintenant voir clairement que la raison pour laquelle les ressources JPEG sont plus importantes est due au volume des pixels. Il n’est probablement pas surprenant que le GIF présente une très faible densité de pixels par rapport aux autres formats. Par ailleurs, alors que le PNG peut gérer une grande profondeur de bits et ne souffre pas du flou du sous-échantillonnage chromatique, il est environ deux fois plus lourd que le JPG ou le WebP pour un même volume de pixels.

Il est à noter que le volume de pixels utilisé pour le SVG est la taille de l’élément DOM à l’écran (en pixels CSS). Bien qu’il soit considérablement plus petit pour la taille des fichiers, cela indique que les SVG sont généralement utilisés dans des parties plus petites de la mise en page. C’est pourquoi le ratio d’octets par pixel semble moins bon que le ratio du PNG.

Là encore, il convient de souligner que cette comparaison de la densité des pixels n’est pas une comparaison à images équivalentes. Il s’agit plutôt de rendre compte d’une expérience utilisateur classique. Comme nous le verrons plus loin, il existe des techniques qui peuvent être utilisées pour optimiser et réduire davantage les octets par pixel, dans chacun de ces formats.

### Optimisation du format d’image

Choisir le meilleur format possible en fonction d’une expérience est un art qui consiste à équilibrer les capacités du format et à réduire le nombre total d’octets. Pour les pages web, l’un des objectifs est d’aider à améliorer les performances du web en optimisant les images. Cependant, dans chaque format, il existe des caractéristiques supplémentaires qui peuvent contribuer à réduire le nombre d’octets.

Certaines de ces caractéristiques peuvent avoir un impact sur l’ensemble de l’expérience. Par exemple, les JPEG et les WebP peuvent utiliser la _quantification_ (communément appelée _niveaux de qualité_) et le _sous-échantillonnage chromatique_, qui peuvent réduire les bits stockés dans l’image sans avoir d’impact sur l’expérience visuelle. Comme les MP3 pour la musique, cette technique dépend d’un bug dans l'œil humain et permet d’obtenir la même expérience malgré la perte des données de couleur. Cependant, ces techniques ne sont pas adaptées à toutes les images, et peuvent créer des images grossières ou floues, déformer les couleurs ou rendre illisibles les superpositions de texte.

D’autres particularités du format permettent de simplement organiser le contenu et nécessitent parfois une connaissance du contexte. Par exemple, en appliquant l’encodage progressif à un JPEG, on réorganise les pixels en couches de balayage, ce qui permet au navigateur de terminer la mise en page plus rapidement et, en même temps, de réduire le volume des pixels.

Un des contrôles de [<span lang="en">Lighthouse</span>](./methodology#lighthouse) est un test A/B comparant la ligne de base avec un JPEG progressif. Cela donne une indication sur la possibilité d’optimiser davantage les images dans leur ensemble avec des techniques sans perte et éventuellement avec des techniques avec perte comme l’utilisation de différents niveaux de qualité.

{{ figure_markup(
  image="fig12_percentage_optimized_images.png",
  caption="Pourcentage d’images &laquo;&nbsp;optimisées&nbsp;&raquo;.",
  description="Diagramme à barres montrant qu’au 10e percentile, 100&nbsp;% des images sont optimisées, de même au 25e percentile. Au 50e percentile, 98&nbsp;% des images sont optimisées (2&nbsp;% ne le sont pas). Au 75e percentile, 83&nbsp;% des images sont optimisées (17&nbsp;%, non), et au 90e percentile, 59&nbsp;% des images sont optimisées et 41&nbsp;% ne le sont pas.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1569150767"
  )
}}

Les gains obtenus dans ce test A/B <span lang="en">Lighthouse</span> ne concernent pas seulement les réductions potentielles en termes d’octets, qui peuvent s’élever à plusieurs Mo au 95e percentile, ils démontrent également l’amélioration des performances des pages.

{{ figure_markup(
  image="fig13_project_perf_improvements_image_optimization.png",
  caption='Projection que fait <span lang="en">Lighthouse</span> de l’amélioration des performances des pages grâce à l’optimisation des images.',
  description="Diagramme à barres montrant qu’au 10e percentile, 0&nbsp;ms pourrait être sauvée, de même au 25e percentile. Au 50e percentile, 150&nbsp;ms pourraient être sauvées. Au 75e percentile, 1460&nbsp;ms pourraient être sauvées et 90e percentile, 5720&nbsp;ms pourraient être sauvées.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=167590779"
  )
}}

### Images adaptatives

Un autre axe d’amélioration des performances des pages consiste à utiliser des images adaptatives. Cette technique vise à réduire le nombre d’octets d’image en diminuant les pixels supplémentaires qui ne sont pas affichés à l’écran en raison du rétrécissement de l’image. Au début de ce chapitre, vous avez vu que la page web médiane sur ordinateur utilisait un MP d’espace réservé pour les images mais transférait 2,1&nbsp;MP de volume de pixels réels. Comme il s’agissait d’un test DPR 1x, 1,1&nbsp;MP de pixels ont été transférés sur le réseau, mais n’ont pas été affichés. Pour réduire cette surcharge, nous pouvons utiliser l’une des deux (éventuellement trois) techniques suivantes&nbsp;:

* **Le balisage HTML** - utiliser une combinaison d’éléments `<picture>` et `<source>` avec les attributs `srcset` et `sizes` permet au navigateur de choisir la meilleure image à partir des dimensions du <span lang="en">viewport</span> et la densité de l’affichage.
* **Indices Client** - permet de déléguer le choix des images éventuellement redimensionnées à la négociation de contenu HTTP.
* **BONUS**&nbsp;: des bibliothèques JavaScript pour retarder le chargement des images jusqu’à ce que le JavaScript puisse s’exécuter, inspecter le DOM du navigateur et injecter l’image correcte en fonction du conteneur.

### Utilisation du balisage HTML

La méthode la plus courante pour implémenter des images adaptatives est de construire une liste d’images alternatives en utilisant soit `<img srcset>` soit `<source srcset>`. Si le `srcset` est basé sur le DPR, le navigateur peut sélectionner la bonne image dans la liste sans information supplémentaire. Cependant, la plupart des implémentations utilisent également `<img sizes>` pour aider à indiquer au navigateur comment effectuer le calcul de mise en page nécessaire pour sélectionner l’image correcte dans le `srcset` basé sur les dimensions des pixels.

{{ figure_markup(
  image="fig14_html_usage_of_responsive_images.png",
  caption="Pourcentage de pages utilisant des images adaptatives avec HTML.",
  description="Un diagramme à barres montre que 18&nbsp;% des images utilisent `sizes`, 21&nbsp;% `srcset` et 2&nbsp;% `images`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=582530039&format=interactive"
  )
}}

L’utilisation nettement plus faible de `<picture>` n’est pas surprenante dans la mesure où cet élément est le plus souvent utilisé pour des gabarits adaptatifs avancés en termes de [direction artistique](https://developer.mozilla.org/docs/Apprendre/HTML/Comment/Ajouter_des_images_adaptatives_%C3%A0_une_page_web#D%C3%A9cision_de_nature_artistique).

### Utilisation de sizes

L’utilité de `srcset` dépend généralement de la précision de la requête média `size`. Sans `sizes`, le navigateur supposera que la balise `<img>` remplira toute la fenêtre d’affichage au lieu d’un composant plus petit. Il est intéressant de noter qu’il existe cinq modèles courants que les développeurs web ont adoptés pour les `<img sizes>`&nbsp;:

* **`<img sizes="100vw">`** - cela indique que l’image remplira la largeur de la fenêtre de visualisation (le comportement par défaut).
* **`<img sizes="200px">`** - ceci est utile pour les navigateurs qui sélectionnent sur la base du DPR.
* **`<img sizes="(max-width: 300px) 100vw, 300px">`** - c’est le deuxième modèle de conception le plus populaire. C’est celui qui est généré automatiquement par WordPress et probablement par quelques autres plateformes. Il semble être généré automatiquement en fonction de la taille de l’image originale (dans ce cas, 300&nbsp;px).
* **`<img sizes="(max-width: 767px) 89vw, (max-width: 1000px) 54vw, ...">`** - ce modèle est le modèle de conception sur-mesure qui est aligné avec la mise en page CSS. Chaque point de rupture a un calcul différent pour les tailles à utiliser.

<figure>
  <table>
    <thead>
      <tr>
        <th><code>&lt;img sizes&gt;</code></th>
        <th>Fréquence (millions)</th>
        <th>%</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>(max-width: 300px) 100vw, 300px</code></td>
        <td class="numeric">1.47</td>
        <td class="numeric">5&nbsp;%</td>
      </tr>
      <tr>
        <td><code>(max-width: 150px) 100vw, 150px</code></td>
        <td class="numeric">0.63</td>
        <td class="numeric">2&nbsp;%</td>
      </tr>
      <tr>
        <td><code>(max-width: 100px) 100vw, 100px</code></td>
        <td class="numeric">0.37</td>
        <td class="numeric">1&nbsp;%</td>
      </tr>
      <tr>
        <td><code>(max-width: 400px) 100vw, 400px</code></td>
        <td class="numeric">0.32</td>
        <td class="numeric">1&nbsp;%</td>
      </tr>
      <tr>
        <td><code>(max-width: 80px) 100vw, 80px</code></td>
        <td class="numeric">0.28</td>
        <td class="numeric">1&nbsp;%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Pourcentage de pages utilisant modèle de conception <code>sizes</code> le plus populaire.") }}</figcaption>
</figure>

* **`<img sizes="auto">`** - c’est l’utilisation la plus populaire, qui n’est en fait pas normalisée et qui est un artefact de l’utilisation de la bibliothèque JavaScript `lazy_sizes`. Celle-ci utilise du code côté client pour injecter un meilleur calcul des `sizes` pour le navigateur. L’inconvénient de cette méthode est qu’elle dépend du chargement du JavaScript et du DOM pour être totalement prête, ce qui retarde considérablement le chargement des images.

{{ figure_markup(
  image="fig16_top_patterns_of_img_sizes.png",
  caption="Principaux modèles de conception de `<img sizes>`.",
  description="Diagramme à barres montrant que 11,3 millions d’images utilisent 'img sizes=`(max-width: 300px) 100vw, 300px`', 1,60 million utilisent 'auto', 1,00 million utilisent 'img sizes=`(max-width : 767px) 89vw...etc.`', 0,23 million utilisent '100vw' et 0,13 million utilisent '300px'.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=663985412&format=interactive"
  )
}}

### Indications Client

Les Indications Client, ou <a hreflang="en" href="https://web.dev/user-agent-client-hints/"><span lang="en">Client Hints</span></a> permettent aux créateurs et créatrices de contenus de déplacer le redimensionnement des images vers la négociation de contenu HTTP. De cette manière, vous n’avez pas besoin de surcharger votre balisage HTML avec des `<img srcset>`, et vous reposer à la place sur la capacité du serveur ou du <a hreflang="en" href="https://cloudinary.com/blog/client_hints_and_responsive_images_what_changed_in_chrome_67">CDN d’images à sélectionner l’image optimale</a> suivant le contexte. Cela permet de simplifier le HTML et permet aux serveurs d’origine de s’adapter au fil du temps et de déconnecter les couches de contenu et de présentation.

Pour activer les Indications Client, la page web doit envoyer un signal au navigateur en utilisant soit un en-tête HTTP supplémentaire `Accept-CH: DPR, Width, Viewport-Width` _ou_ en ajoutant dans le balisage HTML `<meta http-equiv="Accept-CH" content="DPR, Width, Viewport-Width">`. Le choix de l’une ou l’autre technique dépend de l’équipe qui la met en œuvre et les deux sont proposées pour des raisons de commodité.

{{ figure_markup(
  image="fig17_usage_of_accept-ch_http_v_html.png",
  caption="Utilisation de l’en-tête <code>Accept-CH</code> comparé à son équivalent <code><meta></code> tag.",
  description="Graphique en barres montrant que 71&nbsp;% utilisent le `meta http-equiv`, 30&nbsp;% utilisent l’en-tête HTTP `Accept-CH` et 1&nbsp;% utilisent les deux.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=284657706&format=interactive"
  )
}}

L’utilisation de la balise `<meta>` en HTML pour énoncer les Indications Client est beaucoup plus courante que l’en-tête HTTP. Cela reflète probablement la facilité avec laquelle on peut modifier les gabarits HTML par rapport à l’ajout d’en-têtes HTTP dans les outils intermédiaires. Cependant, si l’on considère l’utilisation de l’en-tête HTTP, plus de 50&nbsp;% de ces cas proviennent d’une seule plate-forme SaaS (Mercado).

En observant la manière dont les Indications Client sont énoncées, on peut voir que la majorité des pages les utilisent pour les trois cas d’utilisation originaux&nbsp;: `DPR`, `ViewportWidth` et `Width`. Bien sûr, l’Indication Client `Width` nécessite l’utilisation de `<img sizes>` pour que le navigateur ait suffisamment de contexte sur la mise en page.

{{ figure_markup(
  image="fig18_enabled_client_hints.png",
  caption="Indications Client actives.",
  description="Un graphique en anneau montrant que 26,1&nbsp;% des Indications Client utilisent `dpr`, 24,3&nbsp;% `viewport-width`, 19,7&nbsp;% `width`, 6,7&nbsp;% `save-data`, 6,1&nbsp;% `device memory`, 6,0&nbsp;% `downlink`, 5,6&nbsp;% `rtt` et 5,6&nbsp;% `ect`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=1878506264&format=interactive"
  )
}}

Les Indications Client liés au réseau, `downlink`, `rtt`, et `ect`, ne sont disponibles que sur Chrome pour Android.

### <i lang="en">Lazy loading</i> {lazy-loading}

L’amélioration des performances des pages web peut être partiellement caractérisée comme un jeu de miroirs&nbsp;: sans les supprimer, on décale les éléments les plus lents en dehors de la zone d’usage de l’utilisateur. Par exemple, le <span lang="en">lazy loading</span> d’images est une de ces illusions où les images et les contenus médias ne sont chargés que lorsque l’utilisateur fait défiler la page. Cela améliore les performances perçues, même sur des réseaux lents, et évite à l’utilisateur de télécharger des octets qui ne sont pas visualisés autrement.

<!-- markdownlint-disable-next-line MD051 -->
Plus tôt, dans la <a hreflang="en" href="#fig-5">Figure 5</a>, nous avons montré que le volume de contenu d’image au 75e percentile est bien plus important que ce qui pourrait théoriquement être affiché sur un seul écran de bureau ou de téléphone portable. L’audit <span lang="en">Lighthouse</span> concernant les <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/offscreen-images">images hors champs</a> confirme ce soupçon. La page web médiane contient 27&nbsp;% d’images situées nettement sous la partie visible de la page. Ce pourcentage passe à 84&nbsp;% au 90e percentile.

{{ figure_markup(
  image="fig19_lighthouse_audit_offscreen.png",
  caption='Audit <span lang="en">Lighthouse</span>&nbsp;: Hors-Écran.',
  description="Un diagramme à barres montrant qu’au 10e percentile, 0&nbsp;% des images sont hors champ, au 25e percentile, 2&nbsp;% sont hors champ, au 50e percentile, 27&nbsp;% sont hors champ, au 75e percentile, 64&nbsp;% sont hors champ et au 90e percentile, 84&nbsp;% des images sont hors champ.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=2123391693&format=interactive"
  )
}}

L’audit <span lang="en">Lighthouse</span> nous indique qu’il y a un certain nombre de situations qui peuvent être difficiles à détecter, comme par exemple l’utilisation de substituts de qualité.

Le <i lang="en">Lazy Loading</i> <a hreflang="en" href="https://developers.google.com/web/fundamentals/performance/lazy-loading-guidance/images-and-video">peut être implémenté</a> de différentes manières en incluant une combinaison de <i lang="en">Intersection Observers</i>, <i lang="en">Resize Observers</i>, ou en utilisant des bibliothèques JavaScript comme <a hreflang="en" href="https://github.com/aFarkas/lazysizes">lazySizes</a>, <a hreflang="en" href="https://github.com/ApoorvSaxena/lozad.js">lozad</a>, ou une poignée d’autres.

En août 2019, Chrome 76 a été lancé avec le support du <i lang="en">lazy loading</i> basé sur des balises utilisant `<img loading="lazy">`. Alors que l’instantané des sites web utilisés pour le Web Almanac 2019 utilisait les données de juillet 2019, plus de 2&#8239;509 sites web utilisaient déjà cette fonctionnalité.

### Accessibilité

Au cœur de l’accessibilité des images se trouve la balise `alt`. Lorsque la balise `alt` est ajoutée à une image, ce texte peut être utilisé pour décrire l’image à un utilisateur ou une utilisatrice qui ne peut pas la voir (soit en raison d’un handicap, soit d’une mauvaise connexion Internet).

Nous pouvons détecter toutes les balises d’images contenues dans les fichiers HTML de l’ensemble de données. Sur 13 millions de balises d’images sur les ordinateurs de bureau et 15 millions sur les téléphones portables, 91,6&nbsp;% des images ont une balise `alt` présente. À première vue, il semble que l’accessibilité des images soit en très bonne santé sur le web. Cependant, après un examen plus approfondi, les perspectives ne sont pas aussi bonnes. Si nous examinons la longueur des balises `alt` présentes dans l’ensemble de données, nous constatons que la longueur médiane de la balise `alt` est de six caractères. Cela correspond à une balise `alt` vide (apparaissant comme `alt=""`). Seulement 39&nbsp;% des images utilisent un texte `alt` de plus de six caractères. La valeur médiane du &laquo;&nbsp;vrai&nbsp;&raquo; texte `alt` est de 31 caractères, dont 25 décrivent réellement l’image.

## Vidéo

Alors que les images dominent les médias diffusés sur les pages web, les vidéos commencent à jouer un rôle majeur dans la diffusion de contenu sur le web. Selon HTTP Archive, nous constatons que 4,06&nbsp;% des sites de bureau et 2,99&nbsp;% des sites mobiles hébergent eux-mêmes des fichiers vidéo. En d’autres termes, les fichiers vidéo ne sont pas hébergés par des sites web comme YouTube ou Facebook.

### Formats vidéo

Les vidéos peuvent être diffusées avec de nombreux formats et lecteurs différents. Les formats dominants pour les téléphones portables et les ordinateurs de bureau sont le &laquo;&nbsp;.ts&nbsp;&raquo; (segments de streaming HLS) et le &laquo;&nbsp;.mp4&nbsp;&raquo; (le MPEG H264)&nbsp;:

{{ figure_markup(
  image="fig20_video_files_by_extension.png",
  caption="Nombre de fichiers vidéo par extension.",
  description="Un diagramme à barres montrant que 1&#8239;283&#8239;439 fichiers 'ts' sont utilisés sur ordinateurs de bureau (792&#8239;952 sur mobiles), 729&#8239;757&#8239;000 'mp4' sur les ordinateurs de bureau (662&#8239;015 sur mobiles), 38&#8239;591 de 'webm' sur ordinateurs de bureau (32&#8239;417 sur mobiles), 22&#8239;194 fichiers 'mov' sur ordinateurs de bureau (14&#8239;986 sur mobiles), 17&#8239;338 fichiers 'm4s' sur ordinateurs de bureau (16&#8239;046 sur mobiles), 7&#8239;466 fichiers 'm4v' sur ordinateurs de bureau (6&#8239;169 sur mobiles).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=999894252&format=interactive"
  )
}}

D’autres formats sont également utilisés, notamment `webm`, `mov`, `m4s` et `m4v` (segments de streaming MPEG-DASH). Il est clair que la majorité des flux sur le web sont en HLS, et que le format principal pour les vidéos statiques est le `mp4`.

La taille médiane des vidéos pour chaque format est indiquée ci-dessous&nbsp;:

{{ figure_markup(
  image="fig21_median_vidoe_file_size_by_extension.png",
  caption="Taille médiane de fichier par extension vidéo.",
  description="Un diagramme à barres montrant la taille moyenne du fichier 'ts' à 335&nbsp;Ko pour le bureau (156&nbsp;Ko pour le mobile), 'mp4' à 175&nbsp;Ko pour le bureau (128&nbsp;Ko pour le mobile), 'webm' à 359&nbsp;Ko pour le bureau (192&nbsp;Ko pour le mobile), 'mov' à 128&nbsp;Ko pour le bureau (96&nbsp;Ko pour le mobile), 'm4s' à 324&nbsp;Ko pour le bureau (246&nbsp;Ko pour le mobile), et 'm4v' à 383&nbsp;Ko pour le bureau (161&nbsp;Ko pour le mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=821311770&format=interactive"
  )
}}

Les valeurs médianes sont plus petites sur les mobiles, ce qui signifie probablement que certains sites qui ont de très grandes vidéos sur le bureau les désactivent pour les mobiles, et que les flux vidéo servent des versions plus petites de vidéos sur des écrans plus petits.

### Taille des fichiers vidéo

Lors de la diffusion de vidéos sur le web, la plupart des vidéos sont livrées avec le lecteur vidéo HTML5. Il est possible de personnaliser le lecteur vidéo HTML afin de diffuser des vidéos à des fins diverses. Par exemple, pour diffuser automatiquement une vidéo, les paramètres `auto-play` et `muted` seront ajoutés. L’attribut `controls` permet à l’utilisateur de démarrer/arrêter et de parcourir la vidéo. En analysant les balises vidéo dans l’archive HTTP, nous sommes en mesure de voir l’utilisation de chacun de ces attributs&nbsp;:

{{ figure_markup(
  image="fig22_html_video_tag_attributes_usage.png",
  caption="Utilisation des attributs de la balise video HTML.",
  description="Un diagramme à barres indiquant que pour ordinateur de bureau&nbsp;: `autoplay` à 11,84&nbsp;%, `buffered` à 0&nbsp;%, `controls` à 12,05&nbsp;%, `crossorigin` à 0,45&nbsp;%, `currenttime` à 0,01&nbsp;%, `disablepictureinpicture` à 0,01&nbsp;%, `disableremoteplayback` à 0,01&nbsp;%, `duration` à 0. 05&nbsp;%, `height` à 7,33&nbsp;%, `intrinsicsize` à 0&nbsp;%, `loop` à 14,57&nbsp;%, `mute` à 13,92&nbsp;%, `playsinline` à 6,49&nbsp;%, `poster` à 8,98&nbsp;%, `preload` à 11,62&nbsp;%, `src` à 3,67&nbsp;%, `use-credentials` à 0&nbsp;%, et `width` à 9&nbsp;%. Et pour les mobiles, `autoplay` à 12,38&nbsp;%, `buffered` à 0&nbsp;%, `controls` à 13,88&nbsp;%, `crossorigin` à 0,16&nbsp;%, `currenttime` à 0,01&nbsp;%, `disablepictureinpicture` à 0,01&nbsp;%, `disableremoteplayback` à 0,02&nbsp;%, `duration` à 0. 09&nbsp;%, `height` à 6,54&nbsp;%, `intrinsicsize` à 0&nbsp;%, `loop` à 14,44&nbsp;%, `mute` à 13,55&nbsp;%, `playsinline` à 6,15&nbsp;%, `poster` à 9,29&nbsp;%, `preload` à 10,34&nbsp;%, `src` à 4,13&nbsp;%, `use-credentials` à 0&nbsp;%, et `width` à 9,03&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=593556050&format=interactive"
  )
}}

Les attributs les plus courants sont `autoplay`, `muted` et `loop`, suivis par `preload`, `width` et `height`. L’attribut `loop` est utilisé dans les vidéos de fond, et aussi lorsque les vidéos sont utilisées pour remplacer des GIF animés, il n’est donc pas surprenant de voir qu’il est souvent utilisé sur les pages d’accueil des sites web.

Si la plupart des attributs sont utilisés de manière similaire sur les ordinateurs de bureau et les téléphones portables, certains présentent des différences significatives. Les deux attributs qui présentent la plus grande différence entre le mobile et le bureau sont `width` et `height`, avec 4&nbsp;% de sites en moins qui utilisent ces attributs sur le mobile. Il est intéressant de noter une légère augmentation de l’attribut `poster` (placer une image sur la fenêtre vidéo avant la lecture) sur le mobile.

Du point de vue de l’accessibilité, la balise `<track>` peut être utilisée pour ajouter des légendes ou des sous-titres. Il existe des données dans les archives HTTP sur la fréquence d’utilisation de la balise `<track>`, mais après examen, la plupart des instances de l’ensemble de données ont été commentées ou pointées vers un élément renvoyant une erreur `404`. Il semble que de nombreux sites utilisent des scripts JavaScript ou HTML génériques et ne suppriment pas la piste `track`, même lorsqu’elle n’est pas utilisée.

### Lecteurs vidéo

Le lecteur vidéo natif HTML5 ne fonctionne pas pour une lecture plus avancée (et pour lire des flux vidéo). Il existe quelques vidéothèques populaires qui sont utilisées pour lire la vidéo&nbsp;:

{{ figure_markup(
  image="fig23_top_javascript_video_players.png",
  caption="Principaux lecteurs vidéo JavaScript.",
  description="Diagramme à barres montrant que 'flowplayer' est utilisé par 3&nbsp;365 sites de bureau (3&nbsp;400 mobiles), 'hls' par 52&nbsp;375 sites de bureau (40&nbsp;925 mobiles), 'jwplayer' par 110&nbsp;280 sites de bureau (96&nbsp;945 mobiles), 'shaka' par 325 sites de bureau (275 mobiles) et 'video' par 377&nbsp;990 sites de bureau (391&nbsp;330 mobiles)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSViHIntdF6-bHAI0cl1HelY_X8rR4lf0P3W2Y8I5SyVMxG-ptggTHfWA0qrrU47RvuAydLE6Zex6L3/pubchart?oid=215677194&format=interactive"
  )
}}

Le plus populaire (et de loin) est video.js, suivi de JWPLayer et HLS.js. Les auteurs admettent qu’il est possible qu’il existe d’autres fichiers portant le nom &laquo;&nbsp;video.js&nbsp;&raquo; qui ne soient pas de la même bibliothèque de lecture vidéo.

## Conclusion
Presque toutes les pages web utilisent des images et des vidéos dans une certaine mesure pour améliorer l’expérience utilisateur et donner du sens. Ces fichiers médias utilisent une grande quantité de ressources et représentent un pourcentage important du poids des sites web (et ils ne vont pas disparaître&nbsp;!). L’utilisation de formats alternatifs, le <i lang="en">lazy loading</i>, les images adaptatives et l’optimisation des images peuvent contribuer grandement à réduire la taille des médias sur le web.
