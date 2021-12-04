---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Indices de Ressources
description: Chapitre sur les indices de ressources du Web Almanac 2019, couvrant les usages de dns-prefetch, preconnect, preload, prefetch, les indices de priorités et le lazy loading natif.
authors: [khempenius]
reviewers: [andydavies, tunetheweb, yoavweiss]
analysts: [rviscomi]
editors: [rviscomi]
translators: [borisschapira]
discuss: 1774
results: https://docs.google.com/spreadsheets/d/14QBP8XGkMRfWRBbWsoHm6oDVPkYhAIIpfxRn4iOkbUU/
khempenius_bio: Katie Hempenius est ingénieur dans l’équipe Chrome où elle travaille à rendre le web plus rapide.
featured_quote: Les indices de ressources fournissent des "suggestions" au navigateur sur les ressources qui seront rapidement nécessaires. L’action que le navigateur entreprend à la suite de cet indice varie selon le type d’indice ; différents indices déclenchent différentes actions. Lorsqu’ils sont utilisés correctement, ils peuvent améliorer les performances de la page en donnant une longueur d'avance aux actions importantes, par anticipation.
featured_stat_1: 29 %
featured_stat_label_1: des sites utilisent `dns-prefetch`
featured_stat_2: 88 %
featured_stat_label_2: des indices de ressources utilisent l’attribut `as`
featured_stat_3: 0.04 %
featured_stat_label_3: des pages utilisent des indices de priorité
---

## Introduction

Les <a hreflang="en" href="https://www.w3.org/TR/resource-hints/">indices de ressources</a> fournissent des "suggestions" au navigateur sur les ressources qui seront rapidement nécessaires. L'action que le navigateur entreprend à la suite de cet indice varie selon le type d'indice&nbsp;; différents indices déclenchent différentes actions. Lorsqu'ils sont utilisés correctement, ils peuvent améliorer les performances de la page en donnant une longueur d'avance aux actions importantes, par anticipation.

<a hreflang="en" href="https://youtu.be/YJGCZCaIZkQ?t=1956">Quelques exemples</a> d'amélioration de performance suite à l'usage d'indices des ressources&nbsp;:

* Jabong a réduit son Time To Interactive de 1,5 seconde en préchargeant les scripts critiques.
* Barefoot Wine a réduit le Time To Interactive des futures pages de 2,7 secondes en préchargeant les liens visibles.
* Chrome.com a réduit sa latence de 0,7 seconde en se préconnectant à des domaines critiques.

La plupart des navigateurs actuels prennent en charge quatre indices de ressources distincts&nbsp;: `dns-prefetch`, `preconnect`, `preload` et `prefetch`.

### `dns-prefetch`

Le rôle de [`dns-prefetch`](https://developer.mozilla.org/en-US/docs/Learn/Performance/dns-prefetch) est de lancer une résolution DNS par anticipation. On peut ainsi anticiper la résolution DNS de tierces parties. Par exemple, la résolution DNS d'un CDN, d'un fournisseur de polices d'écriture ou d'une API en tierce partie.

### `preconnect`

<a hreflang="en" href="https://web.dev/uses-rel-preconnect">`preconnect`</a> initie une connexion anticipée, y compris la résolution DNS, la poignée de main TCP et la négociation TLS. Cette fonctionnalité est utile pour établir une connexion avec une tierce partie. Les utilisations de `preconnect` sont très similaires à celles de `dns-prefetch`, mais `preconnect` est moins bien supporté par les navigateurs. Cependant, si vous n'avez pas besoin du support d'IE 11, `preconnect` est probablement un meilleur choix.

### `preload`

<a hreflang="en" href="https://medium.com/reloading/preload-prefetch-and-priorities-in-chrome-776165961bbf">`preload`</a> initie une requête au plus tôt. Il permet de charger des ressources importantes plutôt que d'attendre que l'analyseur les découvre plus tardivement. Par exemple, si une image importante ne peut être découverte qu'une fois que le navigateur a reçu et analysé la feuille de style, il est peut-être judicieux de précharger l'image.

### `prefetch`

<a hreflang="en" href="https://calendar.perfplanet.com/2018/all-about-prefetching/">`prefetch`</a> lance une requête de faible priorité. C'est utile pour charger les ressources qui seront utilisées lors du chargement de la page suivante (plutôt que de la page actuelle). Une utilisation courante de `prefetch` est le chargement de ressources dont l'application "prédit" qu'elles seront utilisées lors du chargement de la page suivante. Ces prédictions peuvent être basées sur des signaux tels que le mouvement de la souris de l'utilisateur ou des scénarios&#8239;/&#8239;parcours utilisateurs courants.

## Syntaxe

97&nbsp;% des usages d'indices de ressources sont spécifiés par le tag [`<link>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link). Par exemple&nbsp;:

```html
<link rel="prefetch" href="shopping-cart.js">
```

Seuls 3&nbsp;% des indices de ressources proviennent [d'en-têtes HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Link) permettant de les spécifier. Par exemple&nbsp;:

```
Link: <https://example.com/shopping-cart.js>; rel=prefetch
```

Comme l'utilisation des indices de ressources dans les en-têtes HTTP est très faible, le reste de ce chapitre se concentrera uniquement sur l'analyse de l'utilisation des indices de ressources passant par la balise `<link>`. Cependant, il convient de noter que dans les années à venir, l'utilisation des indices de ressources dans les en-têtes HTTP pourrait augmenter avec l'adoption de [HTTP/2 Push](./http#http2-push). En effet, HTTP/2 Push réutilise l'en-tête HTTP de préchargement `Link` comme un signal permettant de pousser des ressources.

## Les indices de ressources

<p class="note">Note: il n'y a pas de différence notable entre l'usage des indices de ressources sur les pages web destinées aux ordinateurs ou périphériques mobiles. C'est pourquoi, par souci de concision, ce chapitre n'inclut que les statistiques relatives aux mobiles.</p>

<figure>
  <table>
    <tr>
     <th>Type d'indice de ressource</th>
     <th>Utilisation (pourcentage de sites)</th>
    </tr>
    <tr>
     <td><code>dns-prefetch</code>
     </td>
     <td>29&nbsp;%
     </td>
    </tr>
    <tr>
     <td><code>preload</code>
     </td>
     <td>16&nbsp;%
     </td>
    </tr>
    <tr>
     <td><code>preconnect</code>
     </td>
     <td>4&nbsp;%
     </td>
    </tr>
    <tr>
     <td><code>prefetch</code>
     </td>
     <td>3&nbsp;%
     </td>
    </tr>
    <tr>
     <td><code>prerender</code> (déprécié)
     </td>
     <td>0,13&nbsp;%
     </td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Adoption des indices de ressources.") }}</figcaption>
</figure>

La popularité relative de `dns-prefetch` n'est pas surprenante&nbps;: c'est une API bien connue (elle est apparue pour la première fois en <a hreflang="en" href="https://caniuse.com/#feat=link-rel-dns-prefetch">2009</a>), elle est prise en charge par tous les principaux navigateurs et c'est le moins "coûteux" de tous les indices de ressources. Parce que `dns-prefetch` n'effectue que des recherches DNS, il consomme très peu de données et il y a donc très peu d'inconvénients à l'utiliser. `dns-prefetch` est particulièrement utile dans les situations de latence élevée.

Cela étant dit, si un site n'a pas besoin de supporter IE11 et les versions inférieures, passer de `dns-prefetch` à `preconnect` est probablement une bonne idée. À une époque où le HTTPS est omniprésent, `preconnect` permet d'améliorer les performances tout en restant peu risqué. Notez que contrairement à `dns-prefetch`, `preconnect` initie non seulement la recherche DNS, mais aussi la poignée de main TCP et la négociation TLS. La [chaîne de certificats] (https://knowledge.digicert.com/solution/SO16297.html) est téléchargée pendant la négociation TLS et cela coûte généralement quelques kilo-octets.

`prefetch` est utilisé par 3&nbsp;% des sites, ce qui en fait l'indice de ressources le moins utilisé. Cette faible utilisation peut s'expliquer par le fait que `prefetch` est utile pour améliorer le chargement des pages suivantes, plutôt que celui de la page actuelle. Ainsi, il sera négligé si un site se concentre uniquement sur l'amélioration de sa page d'accueil, ou sur les performances de la première page consultée.

<figure>
  <table>
    <tr>
     <th>Indice de ressource</th>
     <th>Indices de ressources par page&nbsp;:<br>Médiane</th>
     <th>Indices de ressources par page&nbsp;:<br>90e percentile</th>
    </tr>
    <tr>
     <td><code>dns-prefetch</code>
     </td>
     <td>2
     </td>
     <td>8
     </td>
    </tr>
    <tr>
     <td><code>preload</code>
     </td>
     <td>2
     </td>
     <td>4
     </td>
    </tr>
    <tr>
     <td><code>preconnect</code>
     </td>
     <td>2
     </td>
     <td>8
     </td>
    </tr>
    <tr>
     <td><code>prefetch</code>
     </td>
     <td>1
     </td>
     <td>3
     </td>
    </tr>
    <tr>
     <td><code>prerender</code> (déprécié)
     </td>
     <td>1
     </td>
     <td>1
     </td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Médiane en 90e percentile du nombre d'indices de ressources utilisés sur les pages en utilisant au moins un.") }}</figcaption>
</figure>

Les indices de ressources sont plus efficaces lorsqu'ils sont utilisés de manière sélective (_"quand tout est important, rien ne l'est"_). La figure 19.2 ci-dessus montre le nombre d'indices de ressources sur les pages en utilisant au moins un. Bien qu'il n'existe pas de règle précise pour définir ce qu'est un nombre approprié d'indices de ressources, il semble que la plupart des sites les utilisent de manière appropriée.

## L'attribut `crossorigin`

La plupart des ressources "traditionnelles" récupérées sur le web (les [images](./media), les [feuilles de style](./css) et les [scripts](./javascript)) sont récupérées sans avoir à activer le partage de ressources entre origines multiples (en anglais, <i lang="en">Cross-Origin Resource Sharing</i> ou [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)). Cela signifie que si ces ressources sont extraites d'un serveur `Cross-Origin`, par défaut, leur contenu ne peut pas être relu par la page, en raison de la politique `Same-Origin`.

Dans certains cas, la page peut choisir d'aller chercher la ressource à l'aide de CORS si elle a besoin d'en lire le contenu. Le système CORS permet au navigateur de "demander la permission" et d'accéder à ces ressources d'origines mixtes.

Pour les types de ressources plus récentes (par exemple les polices, les requêtes `fetch()`, les modules ES), le navigateur demande par défaut ces ressources en utilisant CORS et provoque l'échec total des requêtes si le serveur ne lui accorde pas la permission d'accéder aux ressources.

<figure>
  <table>
    <tr>
     <th>Valeur <code>crossorigin</code></th>
     <th>Utilisation</th>
     <th>Explication</th>
    </tr>
    <tr>
     <td>Non définie
     </td>
     <td>92&nbsp;%
     </td>
     <td>Si l'attribut <code>crossorigin</code> est absent, la requête suivra la politique d'origine unique.
     </td>
    </tr>
    <tr>
     <td>anonyme (ou équivalent)
     </td>
     <td>7&nbsp;%
     </td>
     <td>Exécute une requête <code>crossorigin</code> qui ne comprend pas d'identifiant.
     </td>
    </tr>
    <tr>
     <td>use-credentials
     </td>
     <td>0,47&nbsp;%
     </td>
     <td>Exécute une requête <code>crossorigin</code> qui inclut des identifiants.
     </td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Adoption de l'attribut <code>crossorigin</code> en pourcentage du nombre d'indices de ressources.") }}</figcaption>
</figure>

Dans le contexte des indices de ressources, l'utilisation de l'attribut `crossorigin` leur permet de correspondre au mode CORS des ressources auxquelles ils sont censés correspondre et indique les références à inclure dans la requête. Par exemple, `anonymous` active le mode CORS et indique qu'aucun identifiant ne doit être inclus pour ces requêtes `cross-origin`&nbsp;:

```html
<link rel="prefetch" href="https://other-server.com/shopping-cart.css" crossorigin="anonymous">
```

Bien que d'autres éléments HTML prennent en charge l'attribut `crossorigin`, cette analyse ne porte que sur l'utilisation avec des indices de ressources.

## L'attribut `as`

`as` est un attribut qui doit être utilisé avec le indices de ressources `preload` pour informer le navigateur du type (par exemple, image, script, style, etc.) de la ressource demandée. Cela aide le navigateur à classer correctement la requête par ordre de priorité et à appliquer la politique de sécurité du contenu (ou <i lang="en">Content Security Policy</i>, <a hreflang="en" href="https://developers.google.com/web/fundamentals/security/csp">CSP</a>). La CSP est un mécanisme de [sécurité](./security), exprimé par un en-tête HTTP, qui contribue à atténuer l'impact des attaques XSS et d'autres attaques malveillantes en déclarant une liste de sources fiables ; seul le contenu de ces sources peut alors être rendu ou exécuté.

{{ figure_markup(
  caption="Pourcentage des indices de ressources qui utilisent l'attribut <code>as</code>.",
  content="88&nbsp;%",
  classes="big-number"
)
}}

88&nbsp;% des indices de ressources utilisent l'attribut `as`. Quand `as` est spécifié, il est utilisé de façon écrasante pour les scripts : 92&nbsp;% de l'utilisation concerne les scripts, 3&nbsp;% les polices et 3&nbsp;% les styles. Ce n'est pas surprenant étant donné le rôle prépondérant que les scripts jouent dans l'architecture de la plupart des sites ainsi que la fréquence élevée à laquelle les scripts sont utilisés comme vecteurs d'attaque (d'où l'importance particulière de leur appliquer la bonne CSP).

## Le futur

Pour le moment, il n'y a pas de propositions visant à élargir le jeu actuel d'indices de ressources. Cependant, les indices de priorités et le <i lang="en">lazy loading</i> natif sont deux technologies proposées qui s'apparentent aux indices de ressources dans la mesure où elles fournissent, elles aussi, des API pour optimiser le processus de chargement.

### Les indices de priorités

Les <a hreflang="en" href="https://wicg.github.io/priority-hints/">indices de priorités</a> sont une API permettant d'exprimer des priorités dans la récupération de certaines ressources&nbsp;: `high` (haute), `low` (basse), ou `auto`. Ils peuvent être utilisés avec un large éventail de balises HTML&nbsp;: spécifiquement `<image>`, `<link`>, `<script>` et `<iframe>`.

<figure class="figure-block">
<div class="code-block floating-card">
  <pre role="region" aria-label="Code 0" tabindex="0"><code>&lt;carousel>
  &lt;img src="cat1.jpg" importance="high">
  &lt;img src="cat2.jpg" importance="low">
  &lt;img src="cat3.jpg" importance="low">
&lt;/carousel></code></pre></div>
<figcaption>{{ figure_link(caption="Exemple HTML d'utilisation d'indices de priorités sur un carrousel d'images.") }}</figcaption>
</figure>

Par exemple, si vous disposez d'un carrousel d'images, des indices de priorités pourraient être utilisés pour prioriser l'image que les utilisateurs voient immédiatement et déprioriser les images ultérieures.

{{ figure_markup(
  caption="Taux d'adoption des indices de priorités.",
  content="0,04&nbsp;%",
  classes="big-number"
)
}}

Les indices de priorités sont <a hreflang="en" href="https://www.chromestatus.com/feature/5273474901737472">mis en œuvre</a> et peuvent être testés au moyen d'un drapeau de fonctionnalité dans les versions 70 et supérieures du navigateur Chromium. Étant donné qu'il s'agit encore d'une technologie expérimentale, il n'est pas surprenant qu'elle soit utilisée par 0,04&nbsp;% des sites.

85 % de l'utilisation des indices de priorités se fait avec les balises `<img>`. Les indices de priorités sont surtout utilisés pour déprioriser des ressources : 72&nbsp;% de l'utilisation est `importance="low"` ; 28&nbsp;% de l'utilisation est `importance="high"`.

### Le <i lang="en">lazy loading</i> natif {le-lazy-loading-natif}

Le <a hreflang="en" href="https://web.dev/native-lazy-loading"><i lang="en">lazy loading</i> natif</a> est une API native permettant de différer le chargement des images et des iframes situées hors écran. Cela permet de libérer des ressources lors du chargement initial de la page et d'éviter de charger des ressources qui ne sont jamais utilisées. Auparavant, cette technique ne pouvait être réalisée qu'à l'aide de bibliothèques [JavaScript](./javascript) tierces.

L'API pour le <i lang="en">lazy loading</i> natif se présente comme telle&nbsp;: `<img src="cat.jpg" loading="lazy">`.

Le <i lang="en">lazy loading</i> natif est disponible dans les navigateurs basés sur le Chrome 76 et plus. L'API a été annoncée trop tard pour être incluse dans l'ensemble de données du Web Almanac de cette année, mais il faut la surveiller pour l'année prochaine.

## Conclusion

Dans l'ensemble, ces données semblent suggérer qu'il est pertinent de poursuivre l'adoption des indices de ressources. La plupart des sites gagneraient à adopter et&nbsp;/&nbsp;ou à passer de `dns-prefetch` à `preconnect`. Un sous-ensemble de sites beaucoup plus restreint pourrait bénéficier de l'adoption de la fonction `prefetch` et&nbsp;/&nbsp;ou `preload`. Utiliser avec succès `prefetch` et `preload` peut être plus délicat, ce qui tend à limiter leur adoption, mais les bénéfices potentiels sont également plus importants. Le HTTP/2 Push et la maturation des technologies d'apprentissage machine sont également susceptibles d'accroître l'adoption de `preload` et `prefetch`.
