---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Polices d'écriture
description: Chapitre Polices d'écriture du web Almanac 2019 couvrant l'endroit d'où les polices sont chargées, les formats de police, la performance de leur chargement, les polices variables et les polices de couleur.
authors: [zachleat]
reviewers: [hyperpress, AymenLoukil]
analysts: [tjmonsi, rviscomi]
editors: [tunetheweb]
translators: [arigaud-ca]
discuss: 1761
results: https://docs.google.com/spreadsheets/d/108g6LXdC3YVsxmX1CCwrmpZ3-DmbB8G_wwgQHX5pn6Q/
zachleat_bio: Zach est Développeur Web au <a hreflang="en" href="https://www.filamentgroup.com/">Filament Group</a>. Il est actuellement obsédé par les <a hreflang="en" href="https://www.zachleat.com/web/fonts/">polices Web</a> et les <a hreflang="en" href="https://www.zachleat.com/web/introducing-eleventy/">générateurs de sites statiques</a>. Son <a hreflang="en" href="https://www.zachleat.com/web/speaking/">CV d'orateur</a> comprend des conférences dans huit pays différents lors d'événements tels que <span lang="en">JAMstack_conf</span>, <span lang="en">Beyond Tellerrand</span>, <span lang="en">Smashing Conference</span>, <span lang="en">CSSConf</span> et <a hreflang="en" href="https://www.zachleat.com/web/whitehouse/">La Maison Blanche</a>. Il aide également la troupe <a hreflang="en" lang="en" href="http://nejsconf.com/">NEJS CONF</a> et le <a hreflang="en" lang="en" href="http://nebraskajs.com">Meetup NebraskaJS</a>.
featured_quote: Les polices Web permettent une typographie belle et fonctionnelle sur le Web. L'utilisation de polices web renforce non seulement la conception, mais démocratise un sous-ensemble de la conception, car elle permet un accès plus facile à ceux qui n'ont peut-être pas de compétences en conception particulièrement solides. Cependant, malgré tout le bien qu'elles peuvent faire, les polices Web peuvent également nuire gravement aux performances de votre site si elles ne sont pas chargées correctement.
featured_stat_1: 74,9&nbsp;%
featured_stat_label_1: Requêtes de polices qui utilisent Google fonts
featured_stat_2: 29&nbsp;%
featured_stat_label_2: Pourcentage de pages contenant un lien vers une feuille de style Google Fonts
featured_stat_3: 718
featured_stat_label_3: Requêtes principales de polices depuis une unique page
---

## Introduction

Les polices Web permettent une typographie belle et fonctionnelle sur le web. L'utilisation des polices Web permet non seulement de renforcer le design, mais aussi de démocratiser un sous-ensemble du design, car elle permet un accès plus facile à ceux qui n'ont pas forcément de solides compétences en matière de design. Cependant, malgré tout le bien qu'elles peuvent faire, les polices web peuvent également nuire considérablement aux performances de votre site, si elles ne sont pas chargées correctement.

Sont-elles un atout pour le web&nbsp;? Offrent-elles plus d'avantages que d'inconvénients&nbsp;? Les sentiers des standards du web sont-ils suffisamment pavés pour encourager les meilleures pratiques de chargement des polices web par défaut&nbsp;? Et si ce n'est pas le cas, que faut-il changer&nbsp;? Voyons si nous pouvons répondre à ces questions en examinant comment les polices de caractères sont utilisées sur le web aujourd'hui.

## Où avez-vous obtenu ces polices de caractères pour le web&nbsp;?

La première et la plus importante question&nbsp;: la performance. Un chapitre entier est consacré à la [performance](./performance), mais nous allons ici approfondir un peu les questions de performance spécifiques aux polices.

L'utilisation de polices web hébergées permet une mise en œuvre et une maintenance faciles, mais l'auto-hébergement offre les meilleures performances. Étant donné que les polices web par défaut rendent le texte invisible pendant leur chargement (phénomène également connu sous le nom de <a hreflang="en" lang="en" href="https://css-tricks.com/fout-foit-foft/">Flash of Invisible Text</a>, ou FOIT), les performances des polices web peuvent être plus critiques que celles des éléments non bloquants comme les images.

### Les polices sont-elles hébergées sur le même serveur ou par un serveur différent&nbsp;?

La distinction entre l'auto-hébergement et l'hébergement tiers est de plus en plus pertinente dans un monde [HTTP/2](./http), où l'écart de performance entre un même hôte et une connexion vers un hôte différent peut être plus important. Les requêtes vers un même hôte présentent l'énorme avantage d'un meilleur potentiel de priorisation par rapport aux autres requêtes vers ce même hôte dans la cascade.

Les recommandations pour réduire les coûts de performance du chargement des polices web à partir d'un autre hôte comprennent l'utilisation des fonctions `preconnect`, `dns-prefetch` et `preload` [resource hints](./resource-hints), mais les polices web hautement prioritaires devraient être fournies par le même hôte afin de minimiser leur impact sur les performances. Ceci est particulièrement important pour les polices utilisées par des contenus à prééminence visuelle ou pour des corps de texte occupant la majorité d'une page.

{{ figure_markup(
  image="fig1.png",
  caption="Les stratégies d'hébergement de polices web les plus populaires.",
  description="Graphique à barres montrant la popularité des stratégies d'hébergement tierces-parties et d'auto-hébergement pour les polices web. 75&nbsp;% des pages web mobiles utilisent des hébergements tierces-parties et 25&nbsp;% des auto-hébergements. Les sites web en version ordinateur de bureau ont une utilisation similaire.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1546332659&format=interactive"
  )
}}

Le fait que les trois quarts soient hébergés sur des serveurs tierces-parties n'est peut-être pas surprenant compte tenu de la domination de Google Fonts dont nous parlerons [ci-dessous](#quels-sont-les-hébergeurs-tierces-parties-les-plus-populaires-).

Google fournit des polices en utilisant des fichiers CSS tiers hébergés sur https://fonts.googleapis.com. Les développeurs font des requêtes vers ces feuilles de style en utilisant les balises `<link>` dans leur code. Bien que ces feuilles de style soient bloquantes, elles sont très petites. Cependant, les fichiers de police sont hébergés sur un autre domaine, `https://fonts.gstatic.com`. Le modèle consistant à exiger deux rebonds séparés vers deux domaines différents fait de `preconnect` une excellente option ici pour la deuxième requête qui ne sera pas découverte avant le téléchargement de la feuille de style.

Notez que si `preload` pourrait être un ajout intéressant pour charger les fichiers de police plus haut dans la cascade de requêtes (rappelez-vous que `preconnect` établit la connexion, il ne demande pas le contenu du fichier), `preload` n'est pas encore disponible avec Google Fonts. Google Fonts génère des URL uniques pour leurs fichiers de police <a hreflang="en" href="https://github.com/google/fonts/issues/1067">qui sont susceptibles de changer</a>.

### Quels sont les hébergeurs tierces-parties les plus populaires&nbsp;?

<figure>
  <table>
    <thead>
      <tr>
        <th scope="col">Hébergeur</th>
        <th scope="col">Ordinateur de bureau</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>fonts.gstatic.com</td>
        <td class="numeric">75,4&nbsp;%</td>
        <td class="numeric">74,9&nbsp;%</td>
      </tr>
      <tr>
        <td>use.typekit.net</td>
        <td class="numeric">7,2&nbsp;%</td>
        <td class="numeric">6,6&nbsp;%</td>
      </tr>
      <tr>
        <td>maxcdn.bootstrapcdn.com</td>
        <td class="numeric">1,8&nbsp;%</td>
        <td class="numeric">2,0&nbsp;%</td>
      </tr>
      <tr>
        <td>use.fontawesome.com</td>
        <td class="numeric">1,1&nbsp;%</td>
        <td class="numeric">1,2&nbsp;%</td>
      </tr>
      <tr>
        <td>static.parastorage.com</td>
        <td class="numeric">0,8&nbsp;%</td>
        <td class="numeric">1,2&nbsp;%</td>
      </tr>
      <tr>
        <td>fonts.shopifycdn.com</td>
        <td class="numeric">0,6&nbsp;%</td>
        <td class="numeric">0,6&nbsp;%</td>
      </tr>
      <tr>
        <td>cdn.shopify.com</td>
        <td class="numeric">0,5&nbsp;%</td>
        <td class="numeric">0,5&nbsp;%</td>
      </tr>
      <tr>
        <td>cdnjs.cloudflare.com</td>
        <td class="numeric">0,4&nbsp;%</td>
        <td class="numeric">0,5&nbsp;%</td>
      </tr>
      <tr>
        <td>use.typekit.com</td>
        <td class="numeric">0,4&nbsp;%</td>
        <td class="numeric">0,4&nbsp;%</td>
      </tr>
      <tr>
        <td>netdna.bootstrapcdn.com</td>
        <td class="numeric">0,3&nbsp;%</td>
        <td class="numeric">0,4&nbsp;%</td>
      </tr>
      <tr>
        <td>fast.fonts.net</td>
        <td class="numeric">0,3&nbsp;%</td>
        <td class="numeric">0,3&nbsp;%</td>
      </tr>
      <tr>
        <td>static.dealer.com</td>
        <td class="numeric">0,2&nbsp;%</td>
        <td class="numeric">0,2&nbsp;%</td>
      </tr>
      <tr>
        <td>themes.googleusercontent.com</td>
        <td class="numeric">0,2&nbsp;%</td>
        <td class="numeric">0,2&nbsp;%</td>
      </tr>
      <tr>
        <td>static-v.tawk.to</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,3&nbsp;%</td>
      </tr>
      <tr>
        <td>stc.utdstc.com</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,2&nbsp;%</td>
      </tr>
      <tr>
        <td>cdn.jsdelivr.net</td>
        <td class="numeric">0,2&nbsp;%</td>
        <td class="numeric">0,2&nbsp;%</td>
      </tr>
      <tr>
        <td>kit-free.fontawesome.com</td>
        <td class="numeric">0,2&nbsp;%</td>
        <td class="numeric">0,2&nbsp;%</td>
      </tr>
      <tr>
        <td>open.scdn.co</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,1&nbsp;%</td>
      </tr>
      <tr>
        <td>assets.squarespace.com</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,1&nbsp;%</td>
      </tr>
      <tr>
        <td>fonts.jimstatic.com</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,2&nbsp;%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 20 des hébergements de polices de caractère par requêtes.") }}</figcaption>
</figure>

La domination de Google Fonts ici était à la fois surprenante et non surprenante. Elle n'était pas surprenante dans la mesure où je m'attendais à ce que le service soit le plus populaire et surprenant par la simple domination de sa popularité. 75&nbsp;% des demandes de polices c'est étonnant. TypeKit était en deuxième position,avec un pourcentage à un chiffre, la bibliothèque Bootstrap occupant une troisième place encore plus éloignée.

{{ figure_markup(
  caption="Pourcentage des pages qui incluent un lien vers des feuilles de style Google Fonts dans l'entête (<code><head></code>) du document.",
  content="29&nbsp;%",
  classes="big-number"
)
}}

Si l'utilisation élevée des Google Fonts ici est très impressionnante, il est également à noter que seulement 29&nbsp;% des pages comprenaient un élément Google Fonts `<link>`. Cela pourrait signifier plusieurs choses&nbsp;:

- Lorsque des pages utilisent des Google Fonts, elles utilisent _beaucoup_ de Google Fonts. Elles sont fournies sans coût monétaire, après tout. Peut-être sont-elles utilisées dans un éditeur WYSIWYG populaire&nbsp;? Cela semble être une explication très probable.
- Ou il se pourrait de façon plus improbable que beaucoup de gens utilisent les Google Fonts avec `@import` au lieu de `<link>`.
- Ou, si nous voulons aller plus loin dans des scénarios très improbables, cela pourrait signifier que beaucoup de gens utilisent des polices Google avec un [HTTP `Link:` header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Link) à la place.

{{ figure_markup(
  caption="Pourcentage des pages qui incluent un lien vers des feuilles de style Google Fonts comme premier noeud dans l'entête du document (<code><head></code>).",
  content="0,4&nbsp;%",
  classes="big-number"
)
}}

La documentation de Google Fonts encourage que le `<link>` pour le CSS Google Fonts soit placé comme premier enfant dans le `<head>` d'une page. C'est une demande forte&nbsp;! Dans la pratique, ce n'est pas courant car seulement un demi pour cent de toutes les pages (environ 20 000 pages) ont suivi ce conseil.

De plus, si une page utilise les éléments `preconnect` ou `dns-prefetch` comme `<link>`, ceux-ci passeront de toute façon avant les polices CSS de Google. Lisez la suite pour en savoir plus sur des indications de ressources.

### Accélérer l'hébergement tierce-partie

Comme mentionné ci-dessus, un moyen très simple d'accélérer les demandes de polices Web sur un hébergement tierce-partie est d'utiliser la fonction `preconnect` [resource hint](./resource-hints).

{{ figure_markup(
  caption="Pourcentage des pages mobiles qui se préconnectent à un serveur de polices web.",
  content="1,7&nbsp;%",
  classes="big-number"
)
}}

Ouah&nbsp;! Moins de 2&nbsp;% des pages utilisent <a hreflang="en" lang="en" href="https://web.dev/uses-rel-preconnect">`preconnect`</a>&nbsp;! Étant donné que Google Fonts est à 75&nbsp;%, cela devrait être plus élevé&nbsp;! Développeurs&nbsp;: si vous utilisez Google Fonts, utilisez `preconnect`&nbsp;! Google Fonts&nbsp;: faites plus de prosélytisme avec `preconnect`&nbsp;!

En fait, si vous utilisez les Google Fonts, allez-y et ajoutez ceci à votre `<head>` si ce n'est pas déjà fait&nbsp;:

```html
<link rel="preconnect" href="https://fonts.gstatic.com/">
```

### Les polices de caractères les plus populaires

<figure>
  <table>
      <thead>
        <tr>
          <th>Rang</th>
          <th>Famille de police</th>
          <th>Ordinateur de bureau</th>
          <th>Mobile</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="numeric">1</td>
          <td>Open Sans</td>
          <td class="numeric">24&nbsp;%</td>
          <td class="numeric">22&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">2</td>
          <td>Roboto</td>
          <td class="numeric">15&nbsp;%</td>
          <td class="numeric">19&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">3</td>
          <td>Montserrat</td>
          <td class="numeric">5&nbsp;%</td>
          <td class="numeric">4&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">4</td>
          <td>Source Sans Pro</td>
          <td class="numeric">4&nbsp;%</td>
          <td class="numeric">3&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">5</td>
          <td>Noto Sans JP</td>
          <td class="numeric">3&nbsp;%</td>
          <td class="numeric">3&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">6</td>
          <td>Lato</td>
          <td class="numeric">3&nbsp;%</td>
          <td class="numeric">3&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">7</td>
          <td>Nanum Gothic</td>
          <td class="numeric">4&nbsp;%</td>
          <td class="numeric">2&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">8</td>
          <td>Noto Sans KR</td>
          <td class="numeric">3&nbsp;%</td>
          <td class="numeric">2&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">9</td>
          <td>Roboto Condensed</td>
          <td class="numeric">2&nbsp;%</td>
          <td class="numeric">2&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">10</td>
          <td>Raleway</td>
          <td class="numeric">2&nbsp;%</td>
          <td class="numeric">2&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">11</td>
          <td>FontAwesome</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">12</td>
          <td>Roboto Slab</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">13</td>
          <td>Noto Sans TC</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">14</td>
          <td>Poppins</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">15</td>
          <td>Ubuntu</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">16</td>
          <td>Oswald</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">17</td>
          <td>Merriweather</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">18</td>
          <td>PT Sans</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">19</td>
          <td>Playfair Display</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
        <tr>
          <td class="numeric">20</td>
          <td>Noto Sans</td>
          <td class="numeric">1&nbsp;%</td>
          <td class="numeric">1&nbsp;%</td>
        </tr>
      </tbody>
    </table>
  <figcaption>{{ figure_link(caption="Top 20 des familles de polices de caractère en pourcentage de toutes les déclarations.") }}</figcaption>
</figure>

Il n'est pas surprenant ici que les principales entrées semblent correspondre de manière très similaire à la <a hreflang="en" href="https://fonts.google.com/?sort=popularity">Liste des Google Fonts classées par popularité</a>.

## Quels sont les formats de police utilisés&nbsp;?

<a hreflang="en" href="https://caniuse.com/#feat=woff2">WOFF2 est assez bien pris en charge</a> dans les navigateurs web aujourd'hui. Google Fonts sert WOFF2, un format qui offre une meilleure compression que son prédécesseur WOFF, qui était lui-même déjà une amélioration par rapport aux autres formats de police existants.

{{ figure_markup(
  image="fig7.png",
  caption="Popularité des types MIME de polices web.",
  description="Graphique à barres indiquant la popularité des types de police MIME pour le web. WOFF2 est utilisé pour 74&nbsp;% des polices, suivi de WOFF avec 13&nbsp;%, octet-stream à 6&nbsp;% , TTF pour 3&nbsp;% , plain 2&nbsp;% , HTML 1&nbsp;% , SFNT 1&nbsp;% , et moins de 1&nbsp;% pour tous les autres types. Les ordinateurs de bureau et les téléphones mobiles ont des distributions similaires.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=998584594&format=interactive"
  )
}}

De mon point de vue, on pourrait argumenter en faveur de l'utilisation exclusive de WOFF2 pour les polices Web après avoir vu les résultats ici. Je me demande d'où vient l'utilisation à deux chiffres de WOFF&nbsp;? Peut-être que les développeurs continuent de fournir des polices web pour Internet Explorer&nbsp;?

La troisième place `octet-stream` (et `plain` un peu plus bas) semble suggérer que beaucoup de serveurs web sont mal configurés, envoyant un type MIME incorrect avec les requêtes de fichiers de polices web.

Creusons un peu plus loin et regardons les valeurs de `format()` utilisées dans la propriété `src:` des déclarations `@font-face`&nbsp;:

{{ figure_markup(
  image="fig8.png",
  caption="Popularité des formats de police dans les déclarations <code>@font-face</code>.",
  description="Diagramme à barres indiquant la popularité des types de police MIME pour le web. WOFF2 est utilisé pour 74&nbsp;% des polices, suivi de WOFF avec 13&nbsp;%, octet-stream à 6&nbsp;% , TTF pour 3&nbsp;% , plain 2&nbsp;% , HTML 1&nbsp;% , SFNT 1&nbsp;% , et moins de 1&nbsp;% pour tous les autres types. Les ordinateurs de bureau et les téléphones mobiles ont des distributions similaires.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=700778025&format=interactive"
  )
}}

J'espérais voir <a hreflang="en" href="https://caniuse.com/#feat=svg-fonts">les polices SVG</a> sur le déclin. Elles sont boguées et leur implémentation a été supprimée de tous les navigateurs sauf Safari. Il est temps de les laisser tomber.

Le point de données SVG ici me fait aussi me demander avec quel type MIME vous utilisez ces polices SVG. Je ne vois pas `image/svg+xml` nulle part dans la Figure 6.7. Quoi qu'il en soit, ne vous inquiétez pas pour cela, débarrassez-vous simplement d'elles&nbsp;!

### WOFF2 seulement

<figure>
  <table>
    <thead>
      <tr>
        <th>Rang</th>
        <th>Combinaisons de format</th>
        <th>Ordinateur de bureau</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>woff2</td>
        <td class="numeric">84,0&nbsp;%</td>
        <td class="numeric">81,9&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>svg, truetype, woff</td>
        <td class="numeric">4,3&nbsp;%</td>
        <td class="numeric">4,0&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>svg, truetype, woff, woff2</td>
        <td class="numeric">3,5&nbsp;%</td>
        <td class="numeric">3,2&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td>eot, svg, truetype, woff</td>
        <td class="numeric">1,3&nbsp;%</td>
        <td class="numeric">2,9&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td>woff, woff2</td>
        <td class="numeric">1,8&nbsp;%</td>
        <td class="numeric">1,8&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">6</td>
        <td>eot, svg, truetype, woff, woff2</td>
        <td class="numeric">1,2&nbsp;%</td>
        <td class="numeric">2,1&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">7</td>
        <td>truetype, woff</td>
        <td class="numeric">0,9&nbsp;%</td>
        <td class="numeric">1,1&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">8</td>
        <td>woff</td>
        <td class="numeric">0,7&nbsp;%</td>
        <td class="numeric">0,8&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">9</td>
        <td>truetype</td>
        <td class="numeric">0,6&nbsp;%</td>
        <td class="numeric">0,7&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">10</td>
        <td>truetype, woff, woff2</td>
        <td class="numeric">0,6&nbsp;%</td>
        <td class="numeric">0,6&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">11</td>
        <td>opentype, woff, woff2</td>
        <td class="numeric">0,3&nbsp;%</td>
        <td class="numeric">0,2&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">12</td>
        <td>svg</td>
        <td class="numeric">0,2&nbsp;%</td>
        <td class="numeric">0,2&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">13</td>
        <td>eot, truetype, woff</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,2&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">14</td>
        <td>opentype, woff</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,1&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">15</td>
        <td>opentype</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,1&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">16</td>
        <td>eot</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,1&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">17</td>
        <td>opentype, svg, truetype, woff</td>
        <td class="numeric">0,1&nbsp;%</td>
        <td class="numeric">0,0&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">18</td>
        <td>opentype, truetype, woff, woff2</td>
        <td class="numeric">0,0&nbsp;%</td>
        <td class="numeric">0,0&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">19</td>
        <td>eot, truetype, woff, woff2</td>
        <td class="numeric">0,0&nbsp;%</td>
        <td class="numeric">0,0&nbsp;%</td>
      </tr>
      <tr>
        <td class="numeric">20</td>
        <td>svg, woff</td>
        <td class="numeric">0,0&nbsp;%</td>
        <td class="numeric">0,0&nbsp;%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Top 20 des combinaisons de format de polices.") }}</figcaption>
</figure>

Cet ensemble de données semble indiquer que la majorité des gens utilisent déjà WOFF2 uniquement dans leurs blocs `@font-face`. Mais cela est bien sûr trompeur, si l'on se fie à notre discussion précédente sur la domination des polices Google dans l'ensemble des données. Google Fonts utilise des méthodes de détection pour servir un fichier CSS simplifié et n'inclut que le `format()` le plus moderne. Il n'est pas surprenant que WOFF2 domine les résultats ici pour cette raison, car la prise en charge de WOFF2 par les navigateurs est assez courante depuis un certain temps déjà.

Il est important de noter que ces données particulières ne soutiennent ni ne contredisent vraiment l'idée d'utiliser uniquement WOFF2 pour le moment, mais cela reste une idée tentante.

## Lutter contre le texte invisible

Le premier outil dont nous disposons pour lutter contre le comportement par défaut de chargement des polices web soit l'invisibilité pendant le chargement (aussi appelé FOIT), est `font-display`. Ajouter `font-display: swap` à votre bloc `@font-face` est un moyen facile de dire au navigateur d'afficher le texte de remplacement pendant le chargement de la police web.

La fonction <a hreflang="en" href="https://caniuse.com/#feat=mdn-css_at-rules_font-face_font-display">Support du navigateur</a> est également très utile. Internet Explorer et les versions antérieures à Chromium Edge ne sont pas pris en charge, mais ils affichent également un texte de remplacement par défaut lors du chargement d'une police Web (les FOIT ne sont pas autorisés ici). Pour nos tests dans Chrome, quelle est la fréquence d'utilisation de la fonction `font-display`&nbsp;?

{{ figure_markup(
  caption="Pourcentage des pages mobiles qui utilisent le style <code>font-display</code>.",
  content="26&nbsp;%",
  classes="big-number"
)
}}

Je suppose que cela va augmenter au fil du temps, surtout maintenant que <a hreflang="en" href="https://www.zachleat.com/web/google-fonts-display/">Google Fonts ajoute `font-display` à tous les nouveaux extraits de code</a> copiés de leur site.

Si vous utilisez les Google Fonts, mettez à jour vos snippets&nbsp;! Si vous n'utilisez pas les Google Fonts, utilisez `font-display`&nbsp;! Pour en savoir plus sur l'affichage des polices, consultez le site [MDN](https://developer.mozilla.org/fr/docs/Web/CSS/@font-face/font-display).

Voyons voir quelles sont les valeurs les plus populaires de `font-display`&nbsp;:

{{ figure_markup(
  image="fig11.png",
  caption="Valeurs de l'utilisation de <code>font-display</code>",
  description="Diagramme à barres montrant l'utilisation du style d'affichage des polices. 2,6&nbsp;% des pages mobiles définissent ce style comme `swap`, 1,5&nbsp;% comme `auto`, 0,7&nbsp;% comme `block`, 0,4&nbsp;% comme `fallback`, 0,2&nbsp;% comme optionnel et 0,1&nbsp;% comme `swap` entre guillemets, ce qui n'est pas valide. La distribution des ordinateurs de bureau est similaire, sauf que l'utilisation de `swap` est inférieure de 0,4 point de pourcentage et que l'utilisation de `auto` est supérieure de 0,1 point de pourcentage.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1988783738&format=interactive"
  )
}}

Comme moyen facile d'afficher du texte de remplacement pendant le chargement d'une police Web, `font-display: swap` règne en maître et est la valeur la plus courante. `swap` est également la valeur par défaut utilisée par les nouveaux extraits de code de Google Fonts. Je me serais attendu à ce que `optional` (seulement rendu si mis en cache) soit un peu plus utilisé ici car quelques éminents développeurs évangélistes ont fait pression pour cela, mais pas de dés.

## Combien de polices de caractères pour le web sont trop nombreuses&nbsp;?

C'est une question qui nécessite une certaine nuance. Comment sont utilisées les polices de caractères&nbsp;? Pour quelle quantité de contenu sur la page&nbsp;? Où se trouve ce contenu dans la mise en page&nbsp;? Comment les polices sont-elles rendues&nbsp;? Au lieu de la nuance, plongeons dans une analyse générale et approfondie, centrée sur le nombre de demandes.

{{ figure_markup(
  image="fig12.png",
  caption="Distribution des requêtes de police par page.",
  description="Graphique à barres indiquant la répartition des demandes de polices par page. Les 10, 25, 50, 75 et 90e percentiles pour le bureau sont&nbsp;: 0, 1, 3, 6 et 9 demandes de polices. La distribution pour les mobiles est identique jusqu'aux 75e et 90e percentiles, où les pages mobiles demandent une police de moins.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=451821825&format=interactive"
  )
}}

La page web médiane fait trois demandes de polices de caractères web. Au 90e percentile, elle a demandé six et neuf polices web sur le mobile et le bureau, respectivement.

{{ figure_markup(
  image="fig13.png",
  caption="Histogram of web fonts requested per page.",
  description="Histogramme montrant la répartition du nombre de demandes de polices par page. Le nombre de demandes de polices le plus répandu est 0 pour 22&nbsp;% des pages pour ordinateur de bureau. La distribution tombe à 9&nbsp;% des pages ayant une police, puis atteint un maximum de 10&nbsp;% pour 2 à 4 polices avant de diminuer à mesure que le nombre de polices augmente. Les distributions pour les ordinateurs de bureau et les téléphones mobiles sont similaires, bien que la distribution pour les téléphones mobiles penche légèrement vers une réduction du nombre de polices par page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1755200484&format=interactive"
  )
}}

Il est intéressant de constater que les demandes de polices de caractères sur le web semblent être assez stables sur les ordinateurs de bureau et les téléphones portables. Je suis heureux de constater que la <a hreflang="en" href="https://css-tricks.com/snippets/css/using-font-face/#article-header-id-6">recommandation de cacher les blocs `@font-face` dans les requêtes `@media`</a> n'a pas été retenue (ne vous faites pas d'idées).

Cela dit, les requêtes de polices de caractères faites sur les appareils mobiles sont légèrement plus nombreuses. J'ai l'impression que moins de polices sont disponibles sur les appareils mobiles, ce qui signifie moins d'occurrences `local()` dans les CSS de Google Fonts, et donc moins de requêtes sur le réseau pour ces polices.

### Vous ne voulez pas gagner ce prix

{{ figure_markup(
  caption="Le plus grand nombre de demandes de polices Web sur une seule page.",
  content="718",
  classes="big-number"
)
}}

Le prix de la page qui demande le plus de polices web est attribué à un site qui a fait **718** requêtes de polices web&nbsp;!

Après avoir plongé dans le code, toutes ces 718 requêtes vont à Google Fonts&nbsp;! Il semble qu'un plugin d'optimisation <span lang="en">"Above the Page fold"</span> pour WordPress qui ne fonctionne pas bien soit devenu défectueux sur ce site et demande (DDoS-ing&nbsp;?) toutes les polices Google&nbsp;!

Il est ironique qu'un plugin d'optimisation des performances puisse rendre vos performances bien pires&nbsp;!

## Une correspondance plus précise avec `unicode-range`.

{{ figure_markup(
  caption="Pourcentage des pages mobiles qui déclarent une police web avec la propriété <code>unicode-range</code>.",
  content="56&nbsp;%",
  classes="big-number"
)
}}

[`unicode-range`](https://developer.mozilla.org/fr/docs/Web/CSS/%40font-face/unicode-range) est une excellente propriété CSS qui permet au navigateur de savoir précisément quels points de code la page souhaite utiliser dans le fichier de police. Si la déclaration `@font-face` a une `unicode-range`, le contenu de la page doit correspondre à l'un des points de code de la plage avant que la police ne soit demandée. C'est une très bonne chose.

C'est une autre mesure qui, je pense, a été faussée par l'utilisation des Google Fonts, car Google Fonts utilise la "plage unicode" (`unicode-range`) dans la plupart (sinon la totalité) de ses CSS. Je m'attendrais à ce que cela soit moins fréquent du côté des utilisateurs, mais peut-être qu'il sera possible de filtrer les demandes de Google Fonts dans la prochaine édition de l'Almanach.

## Ne demandez pas de police web si la police système existe

{{ figure_markup(
  caption="Pourcentage de pages mobile qui déclarent une police web avec la propriété <code>local()</code>.",
  content="59&nbsp;%",
  classes="big-number"
)
}}

`local()` est une belle façon de référencer une police système dans votre `@font-face` `src`. Si la police `local()` existe, il n'est pas du tout nécessaire de faire une requête pour une police web. Cette propriété est utilisée de manière extensive et controversée par Google Fonts, et il s'agit donc probablement d'un autre exemple de données biaisées si nous essayons de glaner des modèles du côté des utilisateurs.

Il convient également de noter ici que des personnes plus intelligentes que moi (Bram Stein de TypeKit) ont déclaré que <a hreflang="en" href="https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html">l'utilisation de `local()` peut être imprévisible car les versions de polices installées peuvent être obsolètes et peu fiables</a>.

## Polices condensées et `font-stretch`

{{ figure_markup(
  caption="Pourcentage des pages pour ordinateurs de bureau et pour mobile qui comportent un style avec la propriété <code>font-stretch</code>.",
  content="7&nbsp;%",
  classes="big-number"
)
}}

Historiquement, `font-stretch` a souffert d'un mauvais support des navigateurs et n'était pas une propriété `@font-face` bien connue. En savoir plus sur [`font-stretch` sur MDN](https://developer.mozilla.org/fr/docs/Web/CSS/font-stretch). Mais <a hreflang="en" href="https://caniuse.com/#feat=css-font-stretch">le support des navigateurs</a> s'est élargi.

Il a été suggéré que l'utilisation de polices condensées sur des fenêtres d'affichage plus petites permet d'afficher plus de texte, mais cette approche n'est pas couramment utilisée. Cela dit, le fait que cette propriété soit utilisée un demi-point de pourcentage de plus sur les ordinateurs de bureau que sur les téléphones mobiles est inattendu, et 7&nbsp;% semble beaucoup plus élevé que ce que j'aurais prédit.

## Les polices variables sont l'avenir

[Les polices variables](https://developer.mozilla.org/fr/docs/Web/CSS/CSS_Fonts/Variable_Fonts_Guide) permettent d'inclure plusieurs poids et styles de police dans un seul fichier.

{{ figure_markup(
  caption="Pourcentage des pages qui incluent une police variable.",
  content="1,8&nbsp;%",
  classes="big-number"
)
}}

Avec 1,8&nbsp;%, c'est plus que prévu, encore que je sois enthousiaste de voir ce décollage. <a hreflang="en" href="https://developers.google.com/fonts/docs/css2">Google Fonts v2</a> inclut un certain support pour les polices variables.

{{ figure_markup(
  image="fig19.png",
  caption="Usage of `font-variation-settings` axes.",
  description="Graphique à barres montrant l'utilisation de la propriété font-variation-settings. 42&nbsp;% des propriétés des pages pour ordinateur de bureau sont réglées sur la valeur `opsz`, 32&nbsp;% sur `wght`, 16&nbsp;% sur `wdth`, 2&nbsp;% ou moins sur `roun`, `crsb`, `slnt`, `inln`, et plus. Les différences les plus notables entre les pages pour ordinateur de bureau et les pages mobiles sont l'utilisation à 26&nbsp;% de `opsz`, 38&nbsp;% de `wght` et 23&nbsp;% de `wdth`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=699343351&format=interactive"
  )
}}

Dans l'optique de ce vaste ensemble de données, il s'agit d'échantillons de très petite taille - prenez ces résultats avec des pincettes. Cependant, l'axe `opsz`, qui est le plus courant sur les pages desktop, est notable, avec `wght` et `wdth` à la traîne. D'après mon expérience, les démos d'introduction aux polices variables sont généralement basées sur le poids.

## Les polices de couleur pourraient-elles aussi être l'avenir&nbsp;?

{{ figure_markup(
  caption="Nombre de pages pour ordinateurs de bureau incluant une police de couleur.",
  content="117",
  classes="big-number"
)
}}

Leur utilisation est pratiquement inexistante ici, mais vous pouvez consulter l'excellente ressource <a hreflang="en" lang="en" href="https://www.colorfonts.wtf/">Color Fonts&nbsp;! WTF&nbsp;?</a> pour plus d'informations. Semblable (mais pas du tout) au format SVG pour les polices (qui est mauvais et qui disparaît), cela vous permet d'intégrer le SVG dans les fichiers OpenType, ce qui est génial et cool.

## Conclusion

Le point le plus important ici est que Google Fonts domine la conversation sur les polices de caractères sur le web. Les approches qu'ils ont adoptées pèsent lourdement sur les données que nous avons enregistrées ici. Les points positifs sont un accès facile aux polices web, de bons formats de police (WOFF2), et des configurations gratuites de `unicode-range`. Les inconvénients sont les défauts de performance liés à l'hébergement par des tiers, les requêtes vers des hôtes différents et l'absence d'accès au `preload`.

Je suis convaincu que nous assisterons à l'avenir à la montée en puissance des polices variables. Ce phénomène devrait s'accompagner d'une diminution des demandes de polices sur le web, car les polices variables combinent plusieurs fichiers de polices individuels en un seul fichier de police composite. Mais l'histoire nous a montré que ce qui se passe généralement, est que nous optimisons une chose puis que nous en ajoutons d'autres pour combler le poste vacant.

Il sera très intéressant de voir si la popularité des polices de couleur augmente. Je pense qu'elles occuperont une place beaucoup plus importante que les polices variables, mais il se peut que l'espace réservé aux polices des icônes soit une bouée de sauvetage.

Faites en sorte que ces polices restent givrées.
