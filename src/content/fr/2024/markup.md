---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Markup
description: Chapitre sur le balisage (Markup) de l'édition 2024 du Web Almanac, couvrant les données du document (doctypes, compression, langues, conformité HTML, taille du document), l'utilisation des éléments et attributs HTML, las attributs de données (data attributes) et les réseaux sociaux.
hero_alt: Image d'illustration des personnages du Web Almanac habillés en ouvriers du bâtiment, assemblant une page web à partir de blocs d'éléments HTML.
authors: [guaca]
reviewers: [bkardell, j9t, zcorpan]
analysts: [guaca]
editors: []
translators: [mika943]
guaca_bio: Estela Franco est une spécialiste de la performance web et du SEO technique chez Schneider Electric. En dehors de cela, elle adore être connectée à la communauté. C'est pourquoi elle est conférencière internationale, Google Developer Expert en technologies web, ambassadrice Storyblok, co-organisatrice du Barcelone Web Performance Meetup et co-fondatrice de la communauté Mujeres en SEO.
results: https://docs.google.com/spreadsheets/d/1TtOMr_w58HvqNBv4RIWX021Lxm6m5ajYOcRykrPdAJc/
featured_quote: Chaque site web, chaque application web et chaque interaction en ligne commence par le HTML en son cœur, ce qui en fait l'un des standards du web les plus essentiels.
featured_stat_1: 92.8%
featured_stat_label_1: Documents utilisant le doctype HTML
featured_stat_2: 32 KB
featured_stat_label_2: Taille médiane de transfert du document HTML
featured_stat_3: 29%
featured_stat_label_3: Éléments qui sont des `div`
doi: 10.5281/zenodo.14065478
---

## Introduction

Le web tel que nous le connaissons repose sur les fondations du HTML. Chaque site web, chaque application web et chaque interaction en ligne commence par le HTML en son cœur, ce qui en fait l'un des standards du web les plus essentiels. C'est le langage qui structure le contenu, définit les relations et communique avec les navigateurs, garantissant que ce que nous créons puisse être vu, utilisé et compris par les utilisateurs du monde entier. Ce chapitre est dédié à la compréhension de la manière dont le HTML continue de façonner le web en 2024, en explorant les tendances de son utilisation, l'essor des éléments personnalisés (custom elements) und la façon dont les développeurs exploitent les nouvelles fonctionnalités pour concevoir des sites web plus accessibles, efficaces et pérennes.

L'édition de cette année apporte une perspective plus large, car notre ensemble de données comprend désormais non seulement les pages d'accueil, mais aussi une grande variété de pages secondaires. En analysant des pages au-delà des simples portes d'entrée des sites web, nous sommes en mesure de capturer un aperçu plus riche et plus précis de la façon dont le HTML est utilisé à travers différents types de contenus et de contextes. Des articles de blog et pages produits aux écrans de connexion et archives d'articles, cette portée élargie nous donne des informations plus approfondies sur l'application du HTML dans le monde réel.

Nous encourageons les lecteurs à plonger plus profondément dans les données, à explorer leurs propres conclusions et à rejoindre la conversation sur l'avenir du langage fondamental du web.

## Généralités

Commençons par certains des aspects les plus généraux d'un document de balisage. Dans cette section, nous abordons les types de documents, leur taille, la langue ainsi que la compression.

### Doctypes

<figure>
  <table>
    <thead>
      <tr>
        <th>Doctype</th>
        <th><a href="https://hsivonen.fi/doctype/" target="_blank">Mode de rendu</a></th>
        <th>Ordinateur</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`<!doctype html>`</td>
        <td>mode standard</td>
        <td class="numeric">91.7%</td>
        <td class="numeric">92.8%</td>
      </tr>
      <tr>
        <td>`html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"`</td>
        <td>mode presque standard</td>
        <td class="numeric">3.4%</td>
        <td class="numeric">2.7%</td>
      </tr>
      <tr>
        <td>Pas de doctype</td>
        <td>mode quirks (quirks mode)</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">2.2%</td>
      </tr>
      <tr>
        <td>`html public "-//w3c//dtd xhtml 1.0 strict//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-strict.dtd"`</td>
        <td>mode standard</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td>`html public "-//w3c//dtd html 4.01 transitional//en" "http://www.w3.org/tr/html4/loose.dtd"`</td>
        <td>mode presque standard</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>`html public "-//w3c//dtd html 4.01 transitional//en"`</td>
        <td>mode quirks</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Utilisation des doctypes.",
      sheets_gid="1243074845",
      sql_file="doctype.sql",
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  content="92.8%",
  caption="Pages mobiles utilisant le doctype HTML standard.",
  classes="big-number",
  sheets_gid="1243074845",
  sql_file="doctype.sql",
) }}

93 % de toutes les pages mobiles utilisent le doctype HTML standard, à savoir `<!DOCTYPE html>`.

C'est 3 points de pourcentage de plus que [les données de 2022](../2022/markup#doctypes). Le fait surprenant concerne le deuxième plus populaire : `XHTML 1.1 Transitional` — qui disparaît pourtant lentement (2,7 %, contre 3,9 % en 2022).

### Taille du document

La taille du document d'une page correspond à la quantité d'octets HTML transférés sur le réseau, compression incluse.

{{ figure_markup(
  image="document_trends.png",
  caption="Taille médiane de transfert du document HTML.",
  description="Diagramme en barres montrant la taille médiane de transfert du document HTML. En 2022, la médiane était de 31 Ko sur ordinateur et 29 sur mobile. En 2023, 30 Ko sur ordinateur und 29 Ko sur mobile. Et en 2024, 33 Ko sur ordinateur und 32 Ko sur mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1823253654&format=interactive",
  sheets_gid="1730786160",
  sql_file="document_trends.sql"
  )
}}

Après une légère baisse en 2023, la taille de transfert HTML a augmenté cette année par rapport à 2022 et 2023.

Bien que la médiane semble raisonnable, examinons de plus près les autres percentiles.

{{ figure_markup(
  image="document_size_distribution.png",
  caption="Distribution de la taille de transfert du document HTML.",
  description="Diagramme en barres montrant les 10e, 25e, 50e, 75e et 90e percentiles de la taille de transfert. Les valeurs pour le mobile sont respectivement de 6, 13, 32, 71 et 147 Ko. Les valeurs pour l'ordinateur sont respectivement de 6, 14, 33, 73 et 148 Ko.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1780108383&format=interactive",
  sheets_gid="619373506",
  sql_file="document_size_distribution.sql"
  )
}}

La distribution par percentile révèle qu'au 10e percentile, les fichiers HTML ne pèsent que 6 Ko, tandis qu'au 90e percentile, ils atteignent jusqu'à 147 Ko. Ces extrêmes mettent en évidence une variation significative dans la manière dont les développeurs structurent leurs pages.

### Compression

Dans le contexte de l'analyse des fichiers de documents HTML, la compression continue de jouer un rôle crucial dans l'amélioration des temps de chargement et des performances globales.

{{ figure_markup(
  image="content_encoding.png",
  caption="Encodage du contenu (content-encoding) du document HTML.",
  description="Diagramme en barres empilées, montrant que 36 % des documents HTML sur ordinateur et 37 % sur mobile sont compressés avec Brotli, 53 % sur ordinateur et 52 % sur mobile sont compressés avec Gzip, et 11 % des documents HTML sur ordinateur et mobile ne sont pas compressés du tout.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1114599297&format=interactive",
  sheets_gid="1573442294",
  sql_file="content_encoding.sql"
  )
}}

Une tendance notable est la popularité croissante du format de compression Brotli (`br`). En 2024, Brotli est utilisé sur 37 % des pages mobiles, une augmentation constante par rapport aux 28 % de 2023.

Bien que `gzip` reste la méthode de compression la plus largement utilisée (52 % sur mobile), son utilisation a légèrement diminué par rapport à l'année précédente à mesure que `br` gagne du terrain (58 % en 2022).

Malgré ces améliorations, un petit pourcentage de fichiers HTML (10,5 % sur mobile) est toujours servi sans aucune compression, ce qui représente des opportunités d'optimisation manquées.

### Langue du document

{{ figure_markup(
  content="5,625",
  caption="Instances uniques de codes d'attribut lang sur mobile.",
  classes="big-number",
  sheets_gid="134927112",
  sql_file="distinct_lang.sql",
) }}

Dans notre analyse, nous avons rencontré 5 625 instances uniques de l'attribut `lang` sur l'élément `html` sur mobile.

L'attribut HTML `lang` joue un rôle important pour aider les lecteurs d'écran et les moteurs de recherche à comprendre la langue du contenu d'une page web. Cependant, fait intéressant, Google Search ignore l'attribut `lang` lors de la détermination de la langue d'une page car [ils ont identifié qu'« il est presque toujours faux »](https://www.youtube.com/watch?v=isW-Ke-AJJU&t=3354s). Cela peut expliquer pourquoi `en` reste dominant dans l'ensemble de données, avec 44,2 % des pages sur ordinateur et 40,5 % sur mobile l'utilisant comme attribut de langue principal, même si la langue réelle du contenu peut différer.

{{ figure_markup(
  image="popular_lang.png",
  caption="Codes de langue HTML les plus populaires, sans inclure la région.",
  description="Diagramme en barres montrant l'utilisation des langues pour les dix langues principales de notre ensemble de données. 40 % utilisent l'anglais, 13 % ne sont pas définis, l'espagnol, le japonais, l'allemand, le français, le portugais, le russe, l'italien et le néerlandais ayant divers pourcentages mineurs d'utilisation, de 6 % à 2 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1428231971&format=interactive",
  sheets_gid="546119077",
  sql_file="lang.sql",
  width=600,
  height=520
  )
}}

De plus, 13 % des pages n'ont aucun attribut `lang` configuré, ce qui montre que de nombreux sites web omettent de fournir cet indicateur.

Si nous cumulons les pourcentages des valeurs d'attribut `lang` non anglophones et non « non définies », nous captons toujours environ 46 % du total des pages, reflétant la nature véritablement mondiale du contenu web. Cependant, comme mentionné ci-dessus, il est important de se rappeler qu'une proportion élevée de valeurs `en` ne signifie pas toujours que le contenu est en anglais, compte tenu des fréquentes erreurs de configuration de l'attribut `lang`.

{{ figure_markup(
  image="popular_regional_lang.png",
  caption="Codes de langue HTML les plus populaires, région incluse.",
  description="Diagramme en barres montrant l'utilisation des langues, région incluse, pour les dix langues principales de notre ensemble de données. 22 % utilisent l'anglais, 15 % l'anglais américain, le japonais, l'espagnol, le portugais brésilien, l'anglais britannique, l'allemand d'Allemagne, le russe et l'allemand ayant divers pourcentages mineurs d'utilisation, de 5 % à 2 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=672282298&format=interactive",
  sheets_gid="546119077",
  sql_file="lang.sql",
  width=600,
  height=520
  )
}}

En ce qui concerne les langues autres que l'anglais, le `ja` (japonais) et l' `es` (espagnol) se distinguent comme faisant partie des choix les plus populaires, utilisés sur environ 5 à 6 % des pages.

La variante régionale la plus courante, `en-us`, apparaît sur 16,7 % des pages sur ordinateur und 15 % des pages sur mobile.

Malgré les problèmes liés aux valeurs incorrectes de l'attribut lang, celui-ci joue toujours un rôle essentiel dans l'amélioration de l'accessibilité. Pour les utilisateurs de lecteurs d'écran, configurer correctement l'attribut `lang` reste une pratique essentielle du développement web moderne.

### Commentaires

Les commentaires HTML sont des extraits de texte que les développeurs incluent dans leur code pour laisser des notes ou des explications sans affecter l'affichage visuel de la page web. Ces commentaires sont entourés de balises `` et ne sont pas interprétés par les navigateurs, ce qui signifie que les utilisateurs ne les verront jamais. Bien qu'utiles pendant le processus de développement, les commentaires HTML ne sont pas nécessaires dans le code de production, car ils augmentent légèrement la taille du fichier sans aucun avantage pour les utilisateurs finaux.

{{ figure_markup(
  content="86%",
  caption="Pages mobiles contenant au moins un commentaire.",
  classes="big-number",
  sheets_gid="1268900609",
  sql_file="comments.sql",
) }}

Selon notre analyse, 86 % des pages mobiles contiennent encore au moins un commentaire.

En plus des commentaires réguliers, il existe un type spécifique appelé **commentaires conditionnels**. Ils étaient autrefois largement utilisés pour cibler des versions spécifiques d'Internet Explorer (IE), permettant aux développeurs de fournir des styles ou des scripts personnalisés que seuls les anciens navigateurs IE allaient traiter.

```html
<!--[if IE]>
<link rel="stylesheet" href="ie-only-styles.css">
<![endif]-->
```

Avec les navigateurs modernes et le retrait d'Internet Explorer, les commentaires conditionnels sont devenus obsolètes. Malgré cela, **26 %** des pages mobiles contiennent encore des commentaires conditionnels, probablement en raison d'un code hérité qui n'a jamais été nettoyé, ou parce que certains sites continuent de prendre en charge d'anciennes versions d'Internet Explorer pour des raisons de compatibilité.

## Éléments

Dans cette section, nous explorerons les éléments HTML — quels sont les éléments couramment utilisés, à quelle fréquence ils apparaissent et lesquels vous êtes susceptible de trouver sur une page type. Nous nous pencherons également sur les éléments personnalisés (custom) et obsolètes. Et pour clarifier la situation : la « divite » (divitis) existe-t-elle toujours ? Oui, tout à fait.

### Diversité des éléments

Pour les pages sur ordinateur comme sur mobile, les données montrent que le 10e percentile comporte 22 éléments distincts, tandis que le 90e percentile atteint 44 éléments sur ordinateur et 43 sur mobile. Le nombre médian d'éléments distincts pour les pages mobiles est resté stable à 32 cette année, [le même qu'en 2022](../2022/markup#element-diversity), et seulement légèrement supérieur aux [31 observés in 2021](../2021/markup#element-diversity).

{{ figure_markup(
  image="distinct_elements_per_page.png",
  caption="Distribution du nombre de types d'éléments distincts par page.",
  description="Diagramme en barres montrant les 10e, 25e, 50e, 75e et 90e percentiles des éléments distincts par page. Les valeurs pour le mobile sont respectivement de 22, 27, 32, 38 et 43. Les valeurs pour l'ordinateur sont respectivement de 22, 27, 33, 38 et 44.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1344861022&format=interactive",
  sheets_gid="1098213395",
  sql_file="element_count_distribution.sql"
  )
}}

Cependant, on note quelques différences lorsque l'on vérifie la distribution globale des éléments par page. Les données montrent une légère baisse [par rapport à 2022](../2022/markup#element-diversity). Pour le mobile, le nombre médian d'éléments est passé de 653 en 2022 à 594 en 2024. À l'extrémité inférieure, le 10e percentile pour le mobile affiche une légère baisse, passant de 192 à 180. Le 90e percentile montre également une diminution modeste, les pages mobiles passant de 1 832 à 1 716. Cette réduction globale suggère que les pages deviennent un peu plus légères en termes de quantité d'éléments HTML utilisés.

{{ figure_markup(
  image="elements_per_page.png",
  caption="Distribution du nombre total d'éléments par page.",
  description="Diagramme en barres montrant les 10e, 25e, 50e, 75e et 90e percentiles du nombre total d'éléments par page. Les valeurs pour le mobile sont respectivement de 180, 342, 594, 1 010 et 1 716.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1742977516&format=interactive",
  sheets_gid="1098213395",
  sql_file="element_count_distribution.sql"
  )
}}

### Éléments les plus utilisés

Les éléments suivants sont utilisés le plus fréquemment :

<figure>
  <table>
    <thead>
      <tr>
        <th>2021</th>
        <th>2022</th>
        <th>2023</th>
        <th>2024</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`div`</td>
        <td>`div`</td>
        <td>`div`</td>
        <td>`div`</td>
      </tr>
      <tr>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
        <td>`a`</td>
      </tr>
      <tr>
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
        <td>`span`</td>
      </tr>
      <tr>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
        <td>`li`</td>
      </tr>
      <tr>
        <td>`img`</td>
        <td>`img`</td>
        <td>`script`</td>
        <td>`script`</td>
      </tr>
      <tr>
        <td>`script`</td>
        <td>`script`</td>
        <td>`img`</td>
        <td>`img`</td>
      </tr>
      <tr>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
        <td>`p`</td>
      </tr>
      <tr>
        <td>`link`</td>
        <td>`link`</td>
        <td>`link`</td>
        <td>`link`</td>
      </tr>
      <tr>
        <td>`meta`</td>
        <td>`i`</td>
        <td>`meta`</td>
        <td>`path`</td>
      </tr>
      <tr>
        <td>`i`</td>
        <td>`meta`</td>
        <td>`path`</td>
        <td>`meta`</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Éléments les plus utilisés.",
      sheets_gid="248650818",
      sql_file="element_frequency.sql",
    ) }}
  </figcaption>
</figure>

La liste reste globalement cohérente avec les années précédentes, mais certains changements se sont produits.

{{ figure_markup(
  content="29%",
  caption="Pourcentage d'éléments qui sont des éléments div.",
  classes="big-number",
  sheets_gid="248650818",
  sql_file="element_frequency.sql",
) }}

`<div>` reste de loin l'élément le plus dominant. La « divite » est donc toujours d'actualité, und il ne semble pas que cela change dans les prochaines années.

{{ figure_markup(
  image="top_elements.png",
  caption="Fréquence des principaux éléments HTML.",
  description="Diagramme en barres montrant la fréquence des 15 principaux éléments HTML. `div` est le plus utilisé (28,7 % sur mobile), suivi par `a` (12,6 %), `span` (11,2 %), `li` (7,7 %) und `script` (3,9 %). Le reste des 15 éléments comprend `img`, `p`, `link`, `path`, `meta`, `i`, `option`, `ul`, `br` und `td`, avec des valeurs allant de 3,3 % à 1,3 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1080941706&format=interactive",
  sheets_gid="248650818",
  sql_file="element_frequency.sql",
  width=600,
  height=656
  )
}}

Après `<div>`, l'élément `<a>` reste un acteur clé, solidement ancré à la deuxième place. En tant que colonne vertébrale des hyperliens, il joue un rôle critique dans la navigation, guidant les parcours des utilisateurs à travers les sites.

L'un des changements notables de ces dernières années a été l'utilisation accrue de `<script>`. En 2023, il a dépassé `<img>` en popularité, reflétant la dépendance croissante envers JavaScript pour le contenu dynamique, l'interactivité, la logique front-end und les campagnes de tracking marketing. Cette tendance s'est poursuivie en 2024, consolidant `<script>` comme le cinquième élément le plus utilisé.

Un autre changement marquant est l'émergence de `<path>`, qui est entré dans le top 10 en 2023. En 2024, il a dépassé `<meta>`, illustrant l'utilisation croissante des graphiques vectoriels évolutifs (SVG) pour los icônes, les illustrations und les éléments graphiques.

L'adoption des principaux éléments HTML sur les plateformes d'ordinateurs et mobiles reste uniformément élevée, reflétant leur rôle fondateur dans le développement web moderne. Les éléments `<html>`, `<head>` und `<body>` sont presque omniprésents, apparaissant sur plus de 99,7 % des pages sur ordinateur und sur mobile.

{{ figure_markup(
  image="popularity_of_top_elements.png",
  caption="Popularité des principaux éléments HTML.",
  description="Diagramme en barres montrant que les balises `html` und `head` sont utilisées sur 99,8 % des pages mobiles, `body` sur 99,7 %, `meta` sur 99,2 % und `title` sur 99,1 %. `div`, `link`, `a`, `script`, `img`, `span`, `p`, `li`, `ul` und `style` constituent le reste du top 15 des éléments HTML, avec des valeurs allant de 98,8 % à 86,2 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1748599287&format=interactive",
  sheets_gid="1606033584",
  sql_file="element_popularity.sql",
  width=600,
  height=656
  )
}}

On remarque au passage que 0,9 % des pages mobiles n'ont pas de balise `<title>`, un chiffre similaire aux [données de 2022](../2022/markup#top-elements) (1 %).

Les éléments suivants, `<link>`, `<a>`, `<script>` und `<img>`, affichent également de forts taux d'adoption. Il est aussi intéressant de noter l'utilisation croissante du SVG (Scalable Vector Graphics), même si cette balise ne fait pas partie du top 15. L'adoption de `<svg>` sur mobile est passée de 45,5 % en 2022 à 51,6 % en 2024, marquant un virage important vers des graphiques plus scalables et indépendants de la résolution sur le web.

### Éléments personnalisés (custom elements)

Les éléments personnalisés, facilement reconnaissables à leurs noms contenant un trait d'union, ont une fois de plus marqué notre analyse cette année, démontrant leur importance continue pour étendre les fonctionnalités natives du HTML.

{{ figure_markup(
  image="custom_elements_adoption.png",
  caption="Utilisation des éléments personnalisés par année.",
  description="Diagramme en barres montrant l'évolution de l'utilisation des éléments personnalisés. En 2022, 2,9 % des sites sur ordinateur et 3,6 % des sites mobiles utilisaient des éléments personnalisés. En 2023, 5,1 % des sites sur ordinateur et 5,4 % des sites mobiles les utilisaient. Et en 2024, 7,7 % des sites sur ordinateur et 7,9 % des sites mobiles utilisent des éléments personnalisés.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1066623750&format=interactive",
  sheets_gid="1091925040",
  sql_file="custom_elements_adoption.sql"
  )
}}

L'utilisation des éléments personnalisés a connu une augmentation significative ces dernières années, les taux d'adoption grimpant de **3,6 %** sur mobile en 2022 à **7,9 %** en 2024. Cette hausse met en lumière une tendance croissante chez les développeurs et au sein des technologies à exploiter les éléments personnalisés pour concevoir des expériences web plus riches und plus interactives.

Cependant, les éléments personnalisés nécessitent généralement du JavaScript supplémentaire pour activer leurs fonctionnalités und leur interactivité. Cette exigence est particulièrement évidente lorsque l'on examine le poids en JavaScript des pages web.

{{ figure_markup(
  image="custom_elements_js_bytes_distribution.png",
  caption="Distribution des Ko de JS lors de l'utilisation d'éléments personnalisés.",
  description="Diagramme en barres montrant la distribution des kilo-octets de JavaScript (JS) utilisés sur les pages mobiles qui intègrent des éléments personnalisés. Le graphique compare l'utilisation de JavaScript à différents percentiles (10e, 25e, 50e, 75e et 90e) entre les pages avec éléments personnalisés (indiquées par 'TRUE') et les pages sans éléments personnalisés ('FALSE'). 10e percentile : 80 Ko (FALSE) vs 412 Ko (TRUE) ; 25e percentile : 229 Ko (FALSE) vs 864 Ko (TRUE) ; 50e percentile (médiane) : 522 Ko (FALSE) vs 1 286 Ko (TRUE) ; 75e percentile : 1 016 Ko (FALSE) vs 1 784 Ko (TRUE) ; 90e percentile : 1 623 Ko (FALSE) vs 2 357 Ko (TRUE). Globalement, les pages utilisant des éléments personnalisés tendent à embarquer nettement plus de JavaScript à tous les percentiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1795165204&format=interactive",
  sheets_gid="1492660858",
  sql_file="custom_elements_js_bytes_distribution.sql"
  )
}}

Sur ce graphique, nous pouvons voir qu'à la médiane, les pages avec des éléments personnalisés utilisent 1 286 Ko de JavaScript, tandis que les pages sans éléments personnalisés n'en requièrent que 522 Ko. Ainsi, bien que l'essor des éléments personnalisés représente une évolution précieuse dans le développement web — permettant aux développeurs de créer des composants modulaires und réutilisables — il est essentiel de prendre en compte les implications de leur utilisation sur le poids des pages.

Examinons maintenant de plus près le top 10 des éléments personnalisés :

{{ figure_markup(
  image="custom_element_popularity.png",
  caption="Popularité des éléments personnalisés.",
  description="Diagramme en barres horizontales indiquant le pourcentage de pages utilisant chaque élément : `wow-image` (2,7 % sur mobile), `rs-module-wrap`, `rs-module`, `rs-slides` und `rs-slide` (1,6 % sur mobile), `rs-sbg-wrap`, `rs-sbg`, `rs-sbg-px` und `rs-progress` (1,5 % sur mobile), et `predictive-search` (1,4 % sur mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=300723169&format=interactive",
  sheets_gid="1606033584",
  sql_file="element_popularity.sql",
  width=600,
  height=656
  )
}}

Comme dans [l'édition 2022](../2022/markup#custom-elements), la plupart des 10 premiers éléments personnalisés sont dominés par les éléments `rs-*` issus de <a hreflang="en" href="https://www.sliderrevolution.com/">Slider Revolution</a>. Cependant, cette année, nous voyons un nouveau vainqueur (surprenant) : l'élément `wow-image`, utilisé par le paquet <a hreflang="en" href="https://www.npmjs.com/package/@wix/image"><code>@wix/image</code></a> sur los sites Wix.

Le dernier élément de cette liste du top 10 de cette année est également un nouveau venu : `predictive-search`, un composant Shopify qui affiche des suggestions de résultats à mesure que vous tapez.

### Éléments obsolètes

Il existe actuellement <a hreflang="en" href="https://html.spec.whatwg.org/multipage/obsolete.html#non-conforming-features">29 éléments obsolètes et dépréciés</a> selon la spécification HTML. Et à l'exception de `keygen`, tous apparaissent encore dans certaines (ou de nombreuses) pages de l'ensemble de données de cette année.

{{ figure_markup(
  image="obsolete_elements.png",
  caption="Popularité des éléments obsolètes.",
  description="Diagramme en barres montrant le pourcentage de pages web utilisant des éléments HTML obsolètes spécifiques sur les appareils ordinateurs et mobiles. `font` est le plus utilisé, présent sur 4,5 % des pages mobiles, suivi par `center` (4,5 % des pages mobiles). Le reste de la liste inclut `marquee`, `nobr`, `big`, `param`, `strike`, `frame`, `frameset` und `noframes`, avec des valeurs s'étalant de 0,9 % à 0,1 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=496158499&format=interactive",
  sheets_gid="1523691472",
  sql_file="obsolete_elements.sql",
  width=600,
  height=656
  )
}}

Si l'on compare ces résultats [à ceux de 2022](../2022/markup#obsolete-elements), on constate un déclin lent mais régulier de leur utilisation. Une amélioration notable est la baisse de l'utilisation de l'élément `<center>`, qui est passé de 6,1 % sur les sites mobiles l'année dernière à 4,5 % cette année. Cela marque une diminution significative und a permis à l'élément `<font>` de dépasser `<center>` en tant que balise obsolète la plus couramment utilisée, désormais présente sur 4,5 % des pages mobiles. Fait intéressant, malgré cette tendance positive, certains sites à forte visibilité, comme la page d'accueil de Google, s'appuient toujours sur l'élément `<center>` dans leur code.

## Attributs

Cette section se concentre sur la manière dont les attributs sont utilisés dans les documents und explore les schémas d'utilisation de `data-*` und du balisage social.

### Principaux attributs

En HTML, les attributs sont des paires clé-valeur associées aux éléments qui fournissent des informations supplémentaires ou modifient le comportement de l'élément. Ces attributs sont fondamentaux pour définir des caractéristiques telles que los styles, les classes, les liens und le comportement au sein de la page web. Ils influencent souvent la manière dont les éléments sont affichés ou manipulés par les utilisateurs und les scripts. Par exemple, l'attribut `src` dans une balise `<img>` définit la source de l'image, tandis que l'attribut `href` dans une balise `<a>` spécifie la destination du lien.

Pour une année de plus, l'attribut le plus utilisé de loin est `class`, avec 48 milliards d'occurrences dans notre ensemble de données mobiles, représentant 33 % de tous les attributs utilisés.

{{ figure_markup(
  image="attribute_usage.png",
  caption="Fréquence des principaux attributs.",
  description="Diagramme en barres montrant la fréquence des 10 principaux attributs HTML. `class` est le plus utilisé (33 % sur mobile), suivi par `href` (8 % sur mobile), `id` (6 % sur mobile), `style` (5 % sur mobile) und `src` (3 % sur mobile). Le reste du top 10 est composé de `type`, `rel`, `title`, `alt` und `value`, avec des valeurs allant de 3 % à 1 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=975284651&format=interactive",
  sheets_gid="927974312",
  sql_file="attributes.sql",
  width=600,
  height=558
  )
}}

Et lorsque l'on s'intéresse aux attributs utilisés par page, on constate que les suivants sont présents sur la quasi-totalité d'entre elles :

{{ figure_markup(
  image="popularity_attribute_usage.png",
  caption="Popularité des principaux attributs.",
  description="Diagramme en barres montrant l'utilisation des 10 principaux attributs HTML. `href` est le plus utilisé (présent sur 99 % des pages mobiles), suivi par `src` (99 % sur mobile), `content` (99 % sur mobile), `name` (99 % sur mobile) und `class` (99 % sur mobile). Le reste du top 10 comprend `type`, `rel`, `id`, `style` und `alt`, mit des valeurs s'étalant de 98 % à 92 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1479935889&format=interactive",
  sheets_gid="927974312",
  sql_file="attributes.sql",
  width=600,
  height=558
  )
}}

### Attributs `data-*`

Jetons maintenant un coup d'œil à un sous-ensemble d'attributs : les attributs `data-*`. Le HTML permet aux développeurs de définir des attributs personnalisés qui commencent par `data-`. Ces attributs sont conçus pour stocker des informations supplémentaires spécifiques à la page ou à l'application, telles que des données personnalisées, des annotations ou des informations d'état. Ils offrent un moyen d'intégrer des métadonnées privées et non standard qui ne rentrent dans aucun attribut HTML prédéfini, ce qui les rend particulièrement utiles lorsqu'il n'existe aucun attribut ou balise existant pour gérer cette information spécifique. Les attributs `data-*` sont privés à l'application und peuvent être facilement récupérés ou manipulés via JavaScript, offrant une méthode flexible pour gérer le contenu dynamique ou les états des données.

{{ figure_markup(
  content="90%",
  caption="Pages contenant au moins un attribut data-*.",
  classes="big-number",
  sheets_gid="156537288",
  sql_file="data_attribute_total.sql",
) }}

Les données globales montrent que 90 % des documents analysés utilisent au moins un attribut `data-*`. Plongeons plus en détail dans ces données.

{{ figure_markup(
  image="data_attribute_popularity.png",
  caption="Popularité des principaux attributs data.",
  description="Diagramme en barres montrant la popularité des 10 principaux attributs HTML `data-*`. `data-id` est le plus utilisé (présent sur 24 % des pages mobiles), suivi par `data-load-time` (20 % sur mobile), `data-tagging-id` (20 % sur mobile), `data-src` (19 % on mobile) und `data-toggle` (19 % sur mobile). Le reste du top 10 inclut `data-type`, `data-target`, `data-name`, `data-href` und `data-testid`, avec des valeurs comprises entre 17 % et 10 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1117739253&format=interactive",
  sheets_gid="1682300906",
  sql_file="data_attributes.sql",
  width=600,
  height=558
  )
}}

L'analyse de la popularité des attributs `data-*` de 2022 à 2024 révèle des évolutions intéressantes. Cette année, `data-id` est le plus populaire, utilisé sur 24 % des pages mobiles, une augmentation significative par rapport aux 19 % de 2022. Cette progression marque également un bond important, passant de la cinquième place en 2022 à la première place cette année.

Un autre changement notable est l'apparition de nouveaux éléments dans la liste : `data-load-time` und `data-tagging-id` apparaissent sur 20 % des pages en 2024, occupant les deuxième und troisième positions du classement. Ces attributs ne faisaient pas partie des attributs `data-*` identifiés en 2022, indiquant que le suivi des performances und le marquage (tagging) sont devenus plus importants dans le développement web moderne.

{{ figure_markup(
  image="data_attribute_frequency.png",
  caption="Fréquence des principaux attributs data.",
  description="Diagramme en barres montrant la fréquence des 10 principaux attributs HTML `data-*`. `data-id` est le plus utilisé (5,8 % du total des attributs `data-*` sur les pages mobiles), suivi par `data-element_type` (4,1 % sur mobile), `data-testid` (2,8 % sur mobile), `data-src` (2,2 % sur mobile) und `data-widget_type` (2,1 % sur mobile). Le reste du top 10 est composé de `data-value`, `data-name`, `data-settings`, `data-type` und `data-toggle`, avec des valeurs allant de 1,4 % à 0,9 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1977102777&format=interactive",
  sheets_gid="1682300906",
  sql_file="data_attributes.sql",
  width=600,
  height=558
  )
}}

### Balisage social (Social markup)

Le balisage social fait référence à l'ensemble des balises meta intégrées dans les documents HTML pour améliorer la façon dont le contenu web est partagé und affiché sur les plateformes de réseaux sociaux. Ces balises fournissent des métadonnées essentielles, telles que les titres, descriptions, images und URL, garantissant que lorsque les utilisateurs partagent une page web, des plateformes comme Facebook, X (anciennement Twitter) und LinkedIn puissent extraire les bonnes informations. Les standards de balisage social les plus courants incluent l'Open Graph (`og:`) und les Twitter Cards (`twitter:`), qui offrent tous deux une expérience de partage plus riche und mieux contrôlée en définissant l'apparence du contenu dans les aperçus.

{{ figure_markup(
  image="social_meta_nodes.png",
  caption="Popularité des principaux nœuds meta sociaux.",
  description="Diagramme en barres montrant la popularité des 10 principaux nœuds meta sociaux HTML. `og:title` est le plus utilisé (présent sur 61 % des pages mobiles), suivi par `og:url` (58 % sur mobile), `og:type` (56 % sur mobile), `og:description` (53 % sur mobile) und `og:site_name` (49 % sur mobile). Le reste du top 10 inclut `og:image`, `twitter:card`, `og:locale`, `twitter:title` und `twitter:description`, avec des valeurs s'étendant de 46 % à 24 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1759203973&format=interactive",
  sheets_gid="1216284092",
  sql_file="meta_node_names.sql",
  width=600,
  height=604
  )
}}

Selon les données de 2024, les balises meta Open Graph les plus fréquemment utilisées sont `og:title` (utilisée par 61 % des pages mobiles) und `og:url` (58 %). Ces balises définissent le titre und l'URL canonique du contenu partagé, suivies de près par `og:type` (56 %) und `og:description` (53 %), qui offrent des indications sur le type de contenu und un bref résumé.
Les balises meta spécifiques à Twitter comme `twitter:card` (45 %) und `twitter:description` (24 %) restent également largement utilisées, même si la plateforme s'appelle désormais « X », illustrant un décalage dans la mise à jour de la terminologie à travers la toile.

## Divers

Dans les sections précédentes, nous avons fourni un aperçu du HTML en général, ainsi que de l'adoption des éléments und attributs les plus couramment utilisés. Dans cette section, nous mènerons une analyse plus approfondie de certains cas particuliers, notamment les fenêtres d'affichage (viewports), les favicons, les boutons, les champs de saisie (inputs) und los liens.

### Spécifications de la fenêtre d'affichage (`viewport`)

La balise meta `viewport` spécifie comment le contenu doit être mis à l'échelle sur divers appareils en définissant des propriétés telles que `width` (largeur) und `initial-scale` (échelle initiale). Une configuration courante, `width=device-width,initial-scale=1`, garantit que la page s'adapte à la largeur totale de l'écran und se charge au bon niveau de zoom sur les appareils mobiles.

{{ figure_markup(
  image="meta_viewports.png",
  caption="Spécifications de la balise meta viewport.",
  description="Diagramme en barres montrant la popularité des 10 principales configurations de meta viewport HTML. `width=device-width,initial-scale=1` est la plus utilisée (présente sur 50 % des pages mobiles de notre ensemble de données), suivie par `(vide)` (5 % sur mobile), `width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0` (4 % sur mobile), `width=device-width,initial-scale=1,shrink-to-fit=no` (4 % sur mobile) und `width=device-width,initial-scale=1,maximum-scale=1` (4 % sur mobile). Le reste du top 10 comprend des variantes désactivant le zoom ou fixant des largeurs minimales, avec des valeurs allant de 4 % à 2 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=8726003&format=interactive",
  sheets_gid="1271081388",
  sql_file="meta_viewports.sql",
  width=600,
  height=604
  )
}}

En termes d'utilisation actuelle, la configuration la plus courante est `width=device-width,initial-scale=1`, présente sur 50 % des pages mobiles. Fait intéressant, 5,4 % des pages analysées sur mobile n'ont aucune balise viewport. Ces pages ne sont donc pas conçues pour les expériences mobiles. Les autres configurations incluent des variations comme `width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0`, qui désactive le zoom par l'utilisateur, présente sur 4,4 % des pages mobiles.

### Favicons

Les favicons, ces petites icônes associées aux sites web, jouent un rôle important dans l'amélioration de l'expérience utilisateur und de la reconnaissance de la marque. Ces icônes sont affichées dans les onglets des navigateurs, les signets und même sur les écrans d'accueil des mobiles lorsque les utilisateurs enregistrent des sites. L'un des aspects les plus intéressants des favicons est qu'elles peuvent fonctionner même sans balisage HTML explicite. Les favicons prennent en charge divers formats d'image, notamment le `.png`, le `.ico`, le `.jpg` und le `.svg`.

{{ figure_markup(
  image="favicons.png",
  caption="Popularité des types de favicons.",
  description="Diagramme en barres montrant la popularité des types de favicons. Le format `png` est le plus utilisé (présent sur 42 % des pages mobiles de notre ensemble de données), suivi par `ico` (27 % sur mobile), `NO_ICON` (pas d'icône déclarée sur 18 % sur mobile), `jpg` (7 % sur mobile) und `svg` (1 % sur mobile).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=516732845&format=interactive",
  sheets_gid="1487566181",
  sql_file="favicons.sql"
  )
}}

En 2024, le format `.png` est le plus couramment utilisé pour les favicons déclarées par des balises `<link rel="icon">`, apparaissant sur 42 % des pages mobiles, contre 35 % en 2021. En revanche, l'utilisation des fichiers `.ico` a diminué, passant de 33 % en 2021 à 27 %, probablement en raison du fait que les développeurs abandonnent ce format au profit d'autres options comme le `.png` und le `.svg`. Il convient toutefois de souligner que les favicons au format `.svg` <a hreflang="en" href="https://caniuse.com/link-icon-svg">ne sont pas prises en charge par Safari</a>.

Fait notable, environ 18 % des pages manquent encore de favicon, montrant une légère amélioration par rapport aux 22 % qui n'en avaient pas en 2021.

### Boutons und types de champs de saisie (inputs)

Les boutons dans le développement web ont fait l'objet de fréquents débats en raison de leur double fonctionnalité und de leurs cas d'utilisation variés. La controverse tourne généralement autour du choix entre l'élément natif `<button>` und les liens d'ancrage (`<a>`), ou même des éléments `div` stylisés faisant office de boutons. Nous n'entrerons pas dans ce débat, mais nous examinerons les données pour analyser son utilisation.

{{ figure_markup(
  content="73%",
  caption="Pages mobiles utilisant au moins un élément button.",
  classes="big-number",
  sheets_gid="1606033584",
  sql_file="element_popularity.sql",
) }}

73 % des pages mobiles utilisent au moins un élément `<button>`, une augmentation significative par rapport aux [65,5 % de 2021](../2021/markup#button-and-input-types). Comme en 2021, nous n'avons pas exécuté de requête pour les boutons de type `input`, mais le chapitre sur l'Accessibilité contient des informations complémentaires très intéressantes sur les boutons. Vous devriez le lire aussi !

{{ figure_markup(
  image="buttons.png",
  caption="Popularité des types de boutons.",
  description="Diagramme en barres montrant la popularité des types de boutons. Le `<button>` générique est le plus utilisé (présent sur 47 % des pages mobiles de notre ensemble de données), suivi par `<button type=button>` (45 % sur mobile), `<button type=submit>` (34 % sur mobile) und `<button type=reset>` (1 % sur mobile). Les chiffres sur ordinateur sont légèrement plus élevés mais restent dans une marge d'un point de pourcentage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=2146901303&format=interactive",
  sheets_gid="753312353",
  sql_file="buttons.sql"
  )
}}

Voici un aperçu plus détaillé de la répartition :

* L'élément générique `<button>` apparaît sur 46,5 % des pages mobiles. Ce bouton n'a pas de comportement par défaut, il permet donc à des scripts côté client d'écouter les événements de l'élément.
* 44,7 % des pages mobiles utilisent `<button type="button">`, qui est généralement employé pour des actions non associées à des soumissions de formulaires (par exemple, déclencher des fonctions JavaScript).
* La variante `<button type="submit">`, utilisée spécifiquement pour la soumission de formulaires, est présente sur 34,1 % des pages mobiles.
* `<button type="reset">` est relativement rare, visible sur seulement 1,4 % des pages mobiles, ce qui indique que la réinitialisation de formulaires est moins courante ou que los développeurs optent pour des solutions sur mesure.

En dehors des boutons, certains éléments `input` sont également interprétés und utilisés comme des boutons.

{{ figure_markup(
  image="input_buttons.png",
  caption="Popularité des boutons utilisant des types input.",
  description="Diagramme en barres montrant la popularité des types d'input utilisés comme boutons. `<input type=\"submit\">` est le plus utilisé (présent sur 25 % des pages mobiles de notre ensemble de données), suivi par `<input type=\"button\">` (3 % sur mobile) und `<input type=\"image\">` (1 % sur mobile). L'ordinateur affiche des valeurs légèrement plus élevées mais proches à un point de pourcentage près.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQTldh1hYi8-zIRgmK_v6IhpKuUOPTAhBxStogg3rt1L6isaX6v8dgODs7WiJ_udh7ZvHnvrTZLlXkW/pubchart?oid=1616034217&format=interactive",
  sheets_gid="1115291405",
  sql_file="buttons.sql"
  )
}}

Les données indiquent que 25,2 % des pages mobiles de notre ensemble de données possèdent au moins un élément `<input type="submit">`, 2,8 % ont au moins un élément `<input type="button">` und 1,1 % ont au moins un élément `<input type="image">`.

### Cibles de liens (Link targets)

Par le passé, si vous pointiez vers une page avec un attribut `target="_blank"` pour l'ouvrir dans un nouvel onglet, la page cible pouvait accéder à votre page d'origine via `window.opener`, ce qui pouvait être exploité pour mener des actions malveillantes. Pour éviter cela, les développeurs devaient ajouter un attribut `rel="noopener"` aux liens contenant `target="_blank"`. La valeur `noopener` garantit que le nouvel onglet n'a pas accès à l'objet `window.opener`. De plus, `noreferrer` était souvent associé à `noopener` pour empêcher le passage des informations de référent (referrer) au nouvel onglet.

Dans les navigateurs modernes, ce problème de sécurité a été résolu : désormais, lorsque `target="_blank"` est utilisé, les navigateurs appliquent automatiquement `rel="noopener"` en arrière-plan. Cela signifie que, dans la plupart des cas, les développeurs n'ont plus besoin d'inclure manuellement `noopener` dans les attributs de leurs liens pour esquiver cette faille de sécurité. Malgré cela, on constate toujours une utilisation généralisée de `noopener` und `noreferrer` sur de nombreuses pages web, probablement en raison de codes hérités ou de développeurs prudents quant à la compatibilité entre navigateurs.

<figure>
<table>
  <thead>
    <tr>
      <th>Lien</th>
      <th>Ordinateur</th>
      <th>Mobile</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Contient `target="_blank"`</td>
      <td class="numeric">81%</td>
      <td class="numeric">81%</td>
    </tr>
    <tr>
      <td>Utilise parfois `target="_blank"` avec `noopener` und `noreferrer`</td>
      <td class="numeric">77%</td>
      <td class="numeric">76%</td>
    </tr>
    <tr>
      <td>Contient `target="_blank"` sans `noopener` ni `noreferrer`</td>
      <td class="numeric">68%</td>
      <td class="numeric">67%</td>
    </tr>
    <tr>
      <td>Contient `target="_blank"` avec `noopener`</td>
      <td class="numeric">25%</td>
      <td class="numeric">24%</td>
    </tr>
    <tr>
      <td>Utilise toujours `target="_blank"` avec `noopener` und `noreferrer`</td>
      <td class="numeric">23%</td>
      <td class="numeric">24%</td>
    </tr>
    <tr>
      <td>Contient `target="_blank"` avec `noopener` und `noreferrer`</td>
      <td class="numeric">20%</td>
      <td class="numeric">19%</td>
    </tr>
    <tr>
      <td>Contient `target="_blank"` avec `noreferrer`</td>
      <td class="numeric">3%</td>
      <td class="numeric">3%</td>
    </tr>
  </tbody>
</table>
  <figcaption>{{ figure_link(
    caption="Adoption de diverses combinaisons d'attributs de liens.",
    sheets_gid="411740281",
    sql_file="links.sql"
  ) }}</figcaption>
</figure>

Au vu des données, 81 % des pages exploitent `target="_blank"`. Étrangement, 76 % des pages incluent au moins un lien `target="_blank"` mit `noopener` und `noreferrer`, tandis que 67 % possèdent `target="_blank"` sans `noopener` ni `noreferrer`. De plus, 24 % des pages mobiles associent systématiquement les liens `target="_blank"` à `noopener` und `noreferrer`.

## Conclusion

L'analyse de l'utilisation du HTML en 2024 révèle des tendances und des enseignements majeurs qui soulignent son évolution und la pertinence continue de ce langage fondamental dans le développement web.

L'une des conclusions les plus notables est la standardisation croissante autour du doctype HTML, 93 % des pages mobiles utilisant désormais le standard `<!DOCTYPE html>`. Cela témoigne d'une évolution positive vers le respect des standards du web, bien que le XHTML reste présent.

La taille des documents a connu une légère augmentation, indiquant une tendance vers des pages plus complexes, mais l'utilisation de la compression — en particulier Brotli — s'est généralisée, ce qui améliore les performances de chargement. Toutefois, l'absence persistante de compression sur environ 10 % des fichiers HTML suggère qu'il reste des opportunités d'optimisation pour de nombreux développeurs.

L'essor de l'utilisation des éléments personnalisés, qui est passée de 3,6 % à 7,9 %, signale une volonté grandissante de concevoir des expériences web plus riches und plus interactives. La présence d'éléments obsolètes, bien qu'en diminution, rappelle la nécessité d'une maintenance continue du code und de l'adoption des standards modernes.

De manière surprenante, la liste des principaux attributs `data-*` affiche des changements majeurs, avec un top 3 entièrement renouvelé. L'usage de `data-id`, `data-load-time` und `data-tagging-id` laisse penser que le suivi des performances und le marquage ont pris une importance cruciale dans le développement web actuel.

Cependant, certaines réalités restent immuables d'une année sur l'autre. La « divite » est toujours bien installée, und `class` demeure le souverain incontesté de l'univers des attributs.
