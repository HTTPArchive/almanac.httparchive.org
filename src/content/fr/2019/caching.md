---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Mise en cache
description: Le chapitre sur la mise en cache de Web Almanac couvre la gestion de la mise en cache, sa validité, les TTLs, les headers Vary, les cookies, l'AppCache, les service workers et d'autres possibilités.
authors: [paulcalvano]
reviewers: [foxdavidj, bkardell]
analysts: [paulcalvano, foxdavidj]
editors: [tunetheweb]
translators: [allemas]
discuss: 1771
results: https://docs.google.com/spreadsheets/d/1mnq03DqrRBwxfDV05uEFETK0_hPbYOynWxZkV3tFgNk/
paulcalvano_bio: Paul Calvano est architecte performance web chez <a hreflang="en" href="https://www.akamai.com/">Akamai</a>, où il aide les entreprises à améliorer les performances de leurs sites web. Il est également co-responsable du projet HTTP Archive. Vous pouvez le retrouver en train de tweeter à l’adresse <a href="https://x.com/paulcalvano">@paulcalvano</a>, en bloguant sur <a hreflang="en" href="https://paulcalvano.com">http://paulcalvano.com</a> et partager ses recherches HTTP Archive à <a hreflang="en" href="https://discuss.httparchive.org">https://discuss.httparchive.org</a>.
featured_quote: La mise en cache est une technique permettant de réutiliser un contenu précédemment téléchargé. Elle offre un avantage significatif en termes de performance en évitant de rejouer de coûteuses requêtes. La mise en cache facilite la montée en charge d'une application, en réduisant le trafic sur le réseau à destination du serveur d'origine. Un vieux dicton dit que "la requête la plus rapide est celle que vous n'avez pas à faire " et la mise en cache est l'un des principaux moyens d'éviter d'avoir à refaire des requêtes.
featured_stat_1: 27 %
featured_stat_label_1: des réponses n’utilisent aucun en-tête de cache
featured_stat_2: 39 %
featured_stat_label_2: des réponses utilisent l’en-tête `Vary`
featured_stat_3: 82 %
featured_stat_label_3: des sites pourraient économiser 1 Mo en optimisant le cache
---

## Introduction

La mise en cache est une technique permettant de réutiliser un contenu précédemment téléchargé. Elle offre un avantage significatif en termes de [performance](./performance) en évitant de rejouer de coûteuses requêtes. La mise en cache facilite la montée en charge d'une application, en réduisant le trafic sur le réseau à destination du serveur d'origine. Un vieux dicton dit que "la requête la plus rapide est celle que vous n'avez pas à faire " et la mise en cache est l'un des principaux moyens d'éviter d'avoir à refaire des requêtes.

La mise en cache sur le web s'appuie sur trois principes fondamentaux&nbsp;: mettre en cache autant que possible, aussi longtemps que possible et aussi près que possible des utilisateurs finaux.

**Mettre en cache autant que vous le pouvez.** Lorsque l'on s'intéresse aux données pouvant être mises en cache, il est important de débuter en identifiant les réponses statiques et dynamiques, qui évoluent ou non en fonction du contexte d'appel. Généralement, les réponses statiques, ne changeant pas, peuvent être mises en cache. Mettre en cache les réponses statiques permettra de les partager entre les utilisateurs. Les contenus dynamiques nécessitent, quant à eux, une analyse plus poussée.

**Mettre en cache aussi longtemps que possible.** La durée de mise en cache d'une ressource dépend fortement de sa sensibilité et de son contenu. Une ressource JavaScript versionnée peut être mise en cache pendant très longtemps, alors qu'une ressource non versionnée peut nécessiter une durée de cache plus courte afin de garantir aux utilisateurs de disposer des données a jour.

**Cachez le plus près possible des utilisateurs finaux.** Une mise en cache proche des utilisateurs réduit les temps de téléchargement en réduisant les latences réseau. Par exemple, pour une ressource mise en cache sur le navigateur de l'utilisateur, la requête ne sera jamais envoyée sur le réseau et le temps de téléchargement sera aussi rapide que les I/O de la machine. Pour les premiers visiteurs, ou les visiteurs qui n'ont pas encore leurs données cachées, un CDN est généralement la prochaine localisation d'une ressource cachée. Dans la plupart des cas, il sera plus rapide de récupérer une ressource à partir d'un cache local ou d'un CDN que sur le serveur d'origine.

Les architectures Web impliquent généralement <a hreflang="en" href="https://blog.yoav.ws/tale-of-four-caches/">une mise en cache en plusieurs niveaux</a>. Par exemple une requête HTTP peut être mise en cache de différentes manière&nbsp;:

* dans le cache du navigateur&nbsp;;
* dans le cache d'un <i lang="en">service worker</i> dans le navigateur&nbsp;;
* dans une passerelle partagée&nbsp;;
* au niveau des CDN, qui offrent la possibilité de mettre en cache à proximité des utilisateurs&nbsp;;
* dans un proxy de cache en amont des applications pour réduire la charge sur les serveurs back-end&nbsp;;
* au niveau de l'application et de la base de données.

Ce chapitre explique comment les ressources sont mises en cache dans les navigateurs Web.

## Présentation de la mise en cache HTTP

Pour qu'un client HTTP mette en cache une ressource, il doit répondre a deux questions&nbsp;:

* "Combien de temps dois-je mettre en cache&nbsp;?"
* "Comment puis-je valider que le contenu est encore frais&nbsp;?"

Lorsqu'un navigateur Web envoie une réponse à un client, il inclut généralement dans sa réponse des en-têtes qui indiquent si la ressource peut être mise en cache, pour combien de temps et quel est son âge. La RFC 7234 traite plus en détail de ce point dans la section <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.2">4.2 (Freshness)</a> et <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.3">4.3 (Validation)</a>.

Les en-têtes de réponse HTTP généralement utilisées pour transmettre la durée de vie sont&nbsp;:

* <i lang="en">`Cache-Control`</i> vous permet de configurer la durée de vie du cache (c'est-à-dire sa durée de validité).
* `Expires` fournit une date ou une heure d'expiration (c.-à-d. quand exactement celle-ci expire).

`Cache-Control` est prioritaire si les deux champs sont renseignés. Ces en-têtes sont [abordés plus en détail ci-dessous](#cache-control-vs-expires).

Les en-têtes de réponse HTTP permettant de valider les données stockées en cache, c'est à dire donner les informations nécessaires pour comparer une ressource à sa contrepartie côté serveur&nbsp;:

* `Last-Modified` indique quand la ressource a été modifiée pour la dernière fois.
* `ETag` fournit l'identifiant unique d'une ressource.

`ETag` est prioritaire si les deux en-têtes sont renseignés. Ces en-têtes sont [abordés plus en détail ci-dessous](#validation-de-la-fraîcheur-des-informations).

L'exemple ci-dessous contient un extrait d'un en-tête requête/réponse du fichier main.js de HTTP Archive. Ces en-têtes indiquent que la ressource peut être mise en cache pendant 43&nbsp;200 secondes (12 heures), et qu'elle a été modifiée pour la dernière fois il y a plus de deux mois (différence entre les en-têtes `Last-Modified` et `Date`).

```
> GET /static/js/main.js HTTP/1.1
> Host: httparchive.org
> User-agent: curl/7.54.0
> Accept: */*

< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-Modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

L'outil <a hreflang="en" href="https://redbot.org/">RedBot.org</a> vous permet d'entrer une URL et de voir un rapport détaillé de la façon dont la réponse sera mise en cache en fonction de ses en-têtes. Par exemple,<a hreflang="en" href="https://redbot.org/?uri=https%3A%2F%2Fhttparchive.org%2Fstatic%2Fjs%2Fmain.js">un test pour l'URL ci-dessus</a> produirait ce qui suit&nbsp;:

{{ figure_markup(
  image="ch16_fig1_redbot_example.jpg",
  caption="Informations de RedBot relatives au <code>Cache-Control</code>.",
  description="Exemple de réponse Redbot montrant des informations détaillées sur le moment où la ressource a été modifiée ; si les caches peuvent la stocker ; pour combien de temps elle peut être considérée valide ; si nécessaire les avertissements.",
  width=600,
  height=138
  )
}}

Si aucun en-tête de mise en cache n'est renseigné dans la réponse, alors <a hreflang="en" href="https://paulcalvano.com/index.php/2018/03/14/http-heuristic-caching-missing-cache-control-and-expires-headers-explained/">l'application peut mettre en cache en suivant une heuristique générique</a>. La plupart des clients implémentent une variation de l'heuristique suggérée par le RFC, qui est 10&nbsp;% du temps depuis le `Last-Modified`. Toutefois, certains peuvent mettre la réponse en cache indéfiniment. Il est donc important de définir des règles de mise en cache spécifiques pour s'assurer que vous maîtrisez la cachabilité.

72&nbsp;% des réponses HTTP sont servies avec un en-tête `Cache-Control`, et 56&nbsp;% des réponses sont servies avec un en-tête `Expires`. Cependant, 27&nbsp;% des réponses n'utilisaient ni l'un ni l'autre, et peuvent alors être mises en cache en suivant cette heuristique. C'est un constat partagé par les sites pour ordinateurs de bureau et les sites mobiles.

{{ figure_markup(
  image="fig2.png",
  caption="Présence des en-tête HTTP <code>Cache-Control</code> et <code>Expires</code>.",
  description="Ces deux diagrammes à barres identiques pour le mobile et les ordinateurs de bureau montrent que 72&nbsp;% des requêtes utilisent des en-têtes Cache-Control et que 56&nbsp;% utilisent Expires et les 27&nbsp;% n'utilisent aucun des deux.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1611664016&format=interactive"
  )
}}

## Quel type de contenu met-on en cache&nbsp;? {quel-type-de-contenu-met-on-en-cache}

Une ressource mise en cache est stockée par le client pendant un certain temps et peut être réutilisée ultérieurement. Pour les requêtes HTTP, 80&nbsp;% des réponses peuvent certainement être mises en cache, ce qui signifie qu'un système de cache peut les stocker. En dehors de ça,

* 6&nbsp;% des requêtes ont un <i lang="en">Time To Live</i> (TTL) de 0 seconde, qui invalide immédiatement une entrée en cache.
* 27&nbsp;% sont mis en cache par heuristique, à cause d'un `Cache-Control` manquant en en-tête.
* 47&nbsp;% sont mis en cache pendant plus de 0 seconde.

Les autres réponses ne peuvent pas être stockées dans le cache du navigateur.

{{ figure_markup(
  image="fig3.png",
  caption="Distribution des réponses pouvant être mises en cache.",
  description="Un graphique à barres superposées montrant que 20&nbsp;% des réponses pour ordinateurs de bureau ne peuvent être mises en cache, 47&nbsp;% ont un cache supérieur à zéro, 27&nbsp;% sont mises en cache de manière heuristique et 6&nbsp;% ont un TTL de 0. Les statistiques pour les mobiles sont très similaires (19&nbsp;%, 47&nbsp;%, 27&nbsp;% et 7&nbsp;%)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1868559586&format=interactive"
  )
}}

Le tableau ci-dessous détaille les TTL du cache pour les requêtes en provenance d'ordinateurs de bureau. La plupart des types de contenu sont mis en cache, mais les ressources CSS semblent toujours être mises en cache à des valeurs TTL élevées.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="5" >Percentiles TTL du cache des ordinateurs de bureau (Heures)</th>
      </tr>
      <tr>
        <td></td>
        <th scope="col">10</th>
        <th scope="col">25</th>
        <th scope="col">50</th>
        <th scope="col">75</th>
        <th scope="col">90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row">Audio</th>
        <td class="numeric">12</td>
        <td class="numeric">24</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">CSS</th>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">Police d'écriture</th>
        <td class="numeric">< 1</td>
        <td class="numeric">3</td>
        <td class="numeric">336</td>
        <td class="numeric">8,760</td>
        <td class="numeric">87,600</td>
      </tr>
      <tr>
        <th scope="row">HTML</th>
        <td class="numeric">< 1</td>
        <td class="numeric">168</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,766</td>
      </tr>
      <tr>
        <th scope="row">Image</th>
        <td class="numeric">< 1</td>
        <td class="numeric">1</td>
        <td class="numeric">28</td>
        <td class="numeric">48</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">Autre</th>
        <td class="numeric">< 1</td>
        <td class="numeric">2</td>
        <td class="numeric">336</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <th scope="row">Script</th>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">1</td>
        <td class="numeric">6</td>
        <td class="numeric">720</td>
      </tr>
      <tr>
        <th scope="row">Texte</th>
        <td class="numeric">21</td>
        <td class="numeric">336</td>
        <td class="numeric">7,902</td>
        <td class="numeric">8,357</td>
        <td class="numeric">8,740</td>
      </tr>
      <tr>
        <th scope="row">Vidéo</th>
        <td class="numeric">< 1</td>
        <td class="numeric">4</td>
        <td class="numeric">24</td>
        <td class="numeric">24</td>
        <td class="numeric">336</td>
      </tr>
      <tr>
        <th scope="row">XML</th>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
        <td class="numeric">< 1</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Percentiles du TTL par type de ressources, pour ordinateurs de bureau.") }}</figcaption>
</figure>

Bien que la plupart des TTL médians sont élevées, les percentiles inférieurs mettent en évidence certaines occasions manquées de mise en cache. Par exemple, le TTL médian pour les images est de 28 heures, mais le 25e percentile n'est que d'une à deux heures et le 10e percentile indique que 10&nbsp;% du volume d'images en cache l'est pendant moins d'une heure.

En explorant plus en détail les possibilités de mise en cache par type de contenu dans la figure 16.5 ci-dessous, nous pouvons voir qu'environ la moitié de toutes les réponses HTML sont considérées comme non cachables. De plus, 16&nbsp;% des images et des scripts ne peuvent pas être mis en cache.

{{ figure_markup(
  image="fig5.png",
  caption="Distribution de la cachabilité pour les types de contenu destinés aux ordinateurs de bureau.",
  description="Un diagramme à barres montrant la répartition des éléments non cachables, mis en cache pendant plus de 0 seconde et mis en cache pendant seulement 0 seconde par type pour les ordinateurs de bureau. Une petite, mais significative proportion n'est pas cachable et cela va jusqu'à 50&nbsp;% pour le HTML, la plupart ont une mise en cache supérieure à 0 et une plus petite quantité a un TTL de 0",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1493610744&format=interactive"
  )
}}

Les mêmes données pour le mobile sont présentées ci-dessous. Comme on peut le voir, la mise en cache des types de contenu est similaire entre les ordinateurs de bureau et les mobiles.

{{ figure_markup(
  image="fig6.png",
  caption="Distribution de la cachabilité pour les types de contenu mobile.",
  description="Un diagramme à barres montrant la répartition des éléments non cachables, mis en cache pendant plus de 0 seconde et mis en cache pendant seulement 0 seconde par type pour les ordinateurs de bureau. Une petite, mais significative proportion n'est pas cachable et cela va jusqu'à 50&nbsp;% pour le HTML, la plupart ont une mise en cache supérieure à 0 et une plus petite quantité a un TTL de 0",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1713903788&format=interactive"
  )
}}

## `Cache-Control` vs `Expires`

Dans HTTP/1.0, l'en-tête `Expires` était utilisé pour indiquer la date/heure après laquelle la réponse était considérée comme périmée. Sa valeur est un horodatage, par exemple&nbsp;:

`Expires: Thu, 01 Dec 1994 16:00:00 GMT`

HTTP/1.1 a introduit l'en-tête `Cache-Control`, et la plupart des clients modernes supportent les deux en-têtes. Cet en-tête est beaucoup plus extensible, via des directives de mise en cache. Par exemple&nbsp;:

* `no-store` peut être utilisé pour indiquer qu'une ressource ne doit pas être mise en cache.
* `max-age` peut être utilisé pour indiquer une durée de vie.
* `must-revalidate` indique au client que la ressource mise en cache doit être revalidée avec une requête conditionnelle avant son utilisation.
* `private` indique qu'une réponse ne doit être mise en cache que par un navigateur, et non par un intermédiaire qui servirait plusieurs clients.

53&nbsp;% des réponses HTTP incluent un en-tête `Cache-Control` avec la directive `max-age`, et 54&nbsp;% incluent l'en-tête `Expires`. Cependant, seulement 41&nbsp;% de ces réponses utilisent les deux en-têtes, ce qui signifie que 13&nbsp;% des réponses sont basées uniquement sur l'ancien en-tête `Expires`.

{{ figure_markup(
  image="fig7.png",
  caption="Utilisation comparée des en-têtes <code>Cache-Control</code> et <code>Expires</code>.",
  description="Un diagramme à barres montrant que 53&nbsp;% des réponses ont un `Cache-Control: max-age`, 54&nbsp;%-55&nbsp;% utilisent `Expire`, 41&nbsp;%-42&nbsp;% utilisent les deux, et 34&nbsp;% n'utilisent aucun des deux. Les chiffres sont donnés à la fois pour les ordinateurs de bureau et les mobiles, mais les chiffres sont presque identiques, les mobiles ayant un point de pourcentage d'utilisation des expirations plus élevé.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1909701542&format=interactive"
  )
}}

## Directives `Cache-Control`

La <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-5.2.1">specification</a>  HTTP/1.1 inclut de multiples directives qui peuvent être utilisées dans l'en-tête de réponse `Cache-Control` et sont détaillées ci-dessous. Notez que plusieurs directives peuvent être utilisées dans une seule réponse.

<figure>
  <table>
    <tr>
      <th>Directive</th>
      <th>Description</th>
    </tr>
    <tr>
      <td>max-age</td>
      <td>Indique le nombre de secondes pendant lesquelles une ressource peut être mise en cache.</td>
    </tr>
    <tr>
      <td>public</td>
      <td>N'importe quel cache peut stocker la réponse.</td>
    </tr>
    <tr>
      <td>no-cache</td>
      <td>Une entrée en cache doit être revalidée avant son utilisation.</td>
    </tr>
    <tr>
      <td>must-revalidate</td>
      <td>Une entrée en cache périmée doit être revalidée avant son utilisation.</td>
    </tr>
    <tr>
      <td>no-store</td>
      <td>Indique qu'une réponse ne doit pas être mise en cache.</td>
    </tr>
    <tr>
      <td>private</td>
      <td>La réponse est destinée à un utilisateur spécifique et ne doit pas être stockée par des caches partagés.</td>
    </tr>
    <tr>
      <td>no-transform</td>
      <td>Aucune transformation ou conversion ne doit être effectuée sur cette ressource.</td>
    </tr>
    <tr>
      <td>proxy-revalidate</td>
      <td>Identique à must-revalidate mais pour les caches partagés.</td>
    </tr>
    <tr>
      <td>s-maxage</td>
      <td>Identique à l'âge maximum mais pour les caches partagés.</td>
    </tr>
    <tr>
      <td>immutable</td>
      <td>Indique que l'entrée en cache ne changera jamais, et qu'une revalidation n'est pas nécessaire.</td>
    </tr>
    <tr>
      <td>stale-while-revalidate</td>
      <td>Indique que le client est prêt à accepter une réponse périmée tout en vérifiant de manière asynchrone en arrière-plan l'existence d'une ressource plus fraiche.</td>
    </tr>
    <tr>
      <td>stale-if-error</td>
      <td>Indique que le client est prêt à accepter une réponse périmée même si la vérification qu'une ressource plus fraiche échoue.</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="<code>Cache-Control</code> directives.") }}</figcaption>
</figure>

Par exemple, `cache-control:public, max-age=43200` indique qu'une entrée mise en cache doit être stockée pendant 43.200 secondes et qu'elle peut être stockée par tous les caches.

{{ figure_markup(
  image="fig9.png",
  caption="Utilisation de la directive <code>Cache-Control</code> sur mobile.",
  description="Un diagramme à barres de 15 directives `Cache-Control` et leur utilisation allant de 74,8&nbsp;% pour max-age, 37,8&nbsp;% pour public, 27,8&nbsp;% pour no-cache, 18&nbsp;% pour no-store, 14,3&nbsp;% pour private, 3,4&nbsp;% pour l'immutable, 3.3. 3&nbsp;% pour no-transform, 2,4&nbsp;% pour le stale-while-revalidate, 2,2&nbsp;% pour pre-check, 2,2&nbsp;% pour post-check, 1,9&nbsp;% pour s-maxage, 1,6&nbsp;% pour proxy-revalidate, 0,3&nbsp;% pour le set-cookie et 0,2&nbsp;% pour le stale-if-error. Les statistiques sont presque identiques pour les ordinateurs de bureaux et les téléphones portables. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1054108345&format=interactive",
  width=600,
  height=662,
  data_width=600,
  data_height=662
  )
}}

La figure 16.9 ci-dessus illustre les 15 directives `Cache-Control` les plus utilisées sur les sites Web mobiles. Les résultats pour les sites destinés aux ordinateurs de bureau et les sites mobiles sont très similaires. Il y a quelques observations intéressantes sur la popularité de ces directives de cache&nbsp;:

* `max-age` est utilisé par presque 75&nbsp;% des en-têtes `Cache-Control`, et `no-store` est utilisé par 18&nbsp;%.
* `public` (publique) est rarement nécessaire car les entrées en cache sont supposées `public` à moins que `private` (privé) ne soit spécifié. Environ 38&nbsp;% des réponses incluent `public`.
* La directive `immutable` est relativement nouvelle, <a hreflang="en" href="https://code.facebook.com/posts/557147474482256/this-browser-tweak-saved-60-of-requests-to-facebook">introduite en 2017</a> et est [supportée par Firefox et Safari](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cache-Control#Browser_compatibility). Son utilisation a augmenté à 3,4&nbsp;% et elle est largement utilisée dans <a hreflang="en" href="https://discuss.httparchive.org/t/cache-control-immutable-a-year-later/1195">les réponses des tierces parties de Facebook et Google</a>.

Un autre ensemble intéressant de directives à faire apparaître dans cette liste sont `pre-check` et `post-check`, qui sont utilisées dans 2,2&nbsp;% des en-têtes `Cache-Control` (environ 7,8 millions de réponses). Cette paire d'en-têtes a été <a hreflang="en" href="https://blogs.msdn.microsoft.com/ieinternals/2009/07/20/internet-explorers-cache-control-extensions/">introduite dans Internet Explorer 5 pour fournir une validation en arrière-plan</a> et a rarement été implémentée correctement par les sites web. 99,2&nbsp;% des réponses utilisant ces en-têtes avaient utilisé la combinaison `pre-check=0` et `post-check=0`. Quand ces deux directives sont mises à 0, alors les deux directives sont ignorées. Il semble donc que ces directives n'aient jamais été utilisées correctement&nbsp;!

Il y a plus de 1&nbsp;500 directives erronées utilisées dans 0,28&nbsp;% des réponses. Ces directives sont ignorées par les clients, comprennent des erreurs d'orthographe telles que `nocache`, `s-max-age`, `smax-age` et `maxage`. Il y a aussi de nombreuses directives inexistantes comme `max-stale`, `proxy-public`, `subsrogate-control`, etc.

## `Cache-Control`&nbsp;: `no-store`, `no-cache` et `max-age=0` {cache-control-no-store-no-cache-et-max-age0}

Lorsqu'une réponse ne doit pas être mise en cache, la directive `Cache-Control` `no-store` doit être utilisée. Si cette directive n'est pas utilisée, alors la réponse peut être mise en cache.

Il y a quelques erreurs courantes, commises lorsqu'on essaie de configurer une réponse pour qu'elle ne puisse pas être mise en cache&nbsp;:

* configurer `Cache-Control: no-cache` peut donner l'impression que la ressource ne doit pas être mise en cache. En réalité, `no-cache` précise que l'entrée mise en cache doit être revalidée avant d'être utilisée et n'indique pas que la ressource ne peut pas être mise en cache.
* `Cache-Control: max-age=0` fixe le TTL à 0 seconde, mais ce n'est pas la même chose que de ne pas pouvoir mettre en cache. Quand `max-age` est fixé à 0, la ressource est stockée dans le cache du navigateur et immédiatement invalidée. Le navigateur doit donc effectuer une requête conditionnelle pour valider la fraîcheur de la ressource.

Fonctionnellement, `no-cache` et `max-age=0` sont similaires, puisqu'ils nécessitent tous deux la revalidation d'une ressource mise en cache. La directive `no-cache` peut aussi être utilisée avec une directive `max-age` supérieure à 0.

Plus de 3 millions de réponses comprennent la combinaison de `no-store`, `no-cache`, et `max-age=0`. Parmi ces directives, `no-store` est prioritaire et les autres directives sont simplement redondantes.

18&nbsp;% des réponses comprennent `no-store` et 16,6&nbsp;% des réponses comprennent à la fois `no-store` et `no-cache`. Puisque `no-store` a la priorité, la ressource n'est finalement pas cachable.

La directive `max-age=0` est présente sur 1,1&nbsp;% des réponses (plus de quatre millions de réponses) où `no-store` n'est pas présent. Ces ressources seront mises en cache dans le navigateur mais devront être revalidées car elles sont immédiatement expirées.

## Comment les TTL de cache se comparent-ils à l'âge des ressources&nbsp;? {comment-les-ttl-de-cache-se-comparent-ils-à-lâge-des-ressources}

Jusqu'à présent, nous avons parlé de la façon dont les serveurs Web indiquent à un client ce qui peut être mis en cache, et pendant combien de temps. Lors de la conception des règles de mise en cache, il est également important de comprendre l'âge du contenu que vous servez.

Lorsque vous choisissez un cache TTL, demandez-vous&nbsp;: "à quelle fréquence allez-vous mettre à jour ces ressources&nbsp;?" et "quelle est la sensibilité de leur contenu&nbsp;?". Par exemple, si une <i lang="en">Hero Image</i> va être modifiée peu fréquemment, alors cachez-la avec un TTL très long. Si vous vous attendez à ce qu'une ressource JavaScript soit modifiée fréquemment, alors versionnez-la puis mettez-la en cache avec un long TTL ou cachez-la avec un TTL plus court.

Le graphique ci-dessous illustre l'âge relatif des ressources par type de contenu, et vous pouvez lire une <a hreflang="en" href="https://discuss.httparchive.org/t/analyzing-resource-age-by-content-type/1659">analyse plus détaillée ici</a>. Le HTML tend à être le type de contenu ayant l'âge le plus court, et un très grand pourcentage des ressources traditionnellement mises en cache ([scripts](./javascript), [CSS](./css), et [polices d'écriture](./fonts)) ont plus d'un an&nbsp;!

{{ figure_markup(
  image="ch16_fig8_resource_age.jpg",
  caption="Répartition de l'âge des ressources par type de contenu.",
  description="Un diagramme à barres indiquant l'âge du contenu, divisé en semaines 0-52, > un an et > deux ans, avec des chiffres nuls et négatifs. Les statistiques sont divisées entre ressources principales et ressources de tierces parties. La valeur 0 est utilisée plus particulièrement pour le HTML, le texte et le XML issue du domaine principal. C'est également le cas pour plus de 50&nbsp;% des requêtes de tiers dans tous les types de ressources. Il existe un mélange utilisant des portions d'années, puis une utilisation considérable pendant un an et deux ans.",
  width=600,
  height=325
  )
}}

En comparant la capacité de mise en cache d'une ressource à son âge, nous pouvons déterminer si le TTL est approprié ou trop faible. Par exemple, la ressource servie par la réponse ci-dessous a été modifiée pour la dernière fois le 25 août 2019, ce qui signifie qu'elle avait 49 jours au moment où elle a été servie. L'en-tête `Cache-Control` indique que nous pouvons la mettre en cache pendant 43&nbsp;200 secondes, soit 12 heures. La ressource est largement assez vieille pour mériter qu'on se demande si un TTL plus long serait approprié.

```
< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-Modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

Dans l'ensemble, 59&nbsp;% des ressources servies sur le Web ont un TTL de cache trop court par rapport à l'âge de leur contenu. De plus, le delta médian entre le TTL et l'âge est de 25 jours.

Si l'on compare les ressources du domaine principal et celles des tierces parties, on constate que 70&nbsp;% des ressources du domaine principal peuvent bénéficier d'une durée de vie plus longue. Cela met clairement en évidence la nécessité d'accorder une attention particulière à ce qui peut être mis en cache, puis de s'assurer que la mise en cache est configurée correctement.

<figure>
  <table>
    <tr>
      <th>Client</th>
      <th>1ere partie</th>
      <th>3e partie</th>
      <th>Global</th>
    </tr>
    <tr>
      <td>Bureau</td>
      <td class="numeric">70.7&nbsp;%</td>
      <td class="numeric">47.9&nbsp;%</td>
      <td class="numeric">59.2&nbsp;%</td>
    </tr>
    <tr>
      <td>Mobile</td>
      <td class="numeric">71.4&nbsp;%</td>
      <td class="numeric">46.8&nbsp;%</td>
      <td class="numeric">59.6&nbsp;%</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Pourcentage des requêtes avec des TTL courts.") }}</figcaption>
</figure>

## Validation de la fraîcheur des informations

Les en-têtes HTTP utilisés pour valider les réponses stockées dans un cache sont `Last-Modified` et `ETag`. L'en-tête `Last-Modified` fait exactement ce que son nom implique et fournit l'heure à laquelle l'objet a été modifié pour la dernière fois. L'en-tête `ETag` fournit un identifiant unique pour le contenu.

Par exemple, la réponse ci-dessous a été modifiée pour la dernière fois le 25 août 2019 et elle a une valeur `ETag` de `"1566748830.0-3052-3932359948"`.

```
< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-Modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

Un client peut envoyer une requête conditionnelle pour valider une entrée en cache en utilisant la valeur `Last-Modified` dans un en-tête de requête nommé `If-Modified-Since`. De même, il pourrait aussi valider la ressource avec un en-tête de requête `If-None-Match`, qui valide par rapport à la valeur `ETag` que le client a pour la ressource dans son cache.

Dans l'exemple ci-dessous, le cache semble toujours valide, et un `HTTP 304` a été renvoyé sans contenu. Cela permet d'économiser le téléchargement de la ressource elle-même. Si l'entrée de cache n'était plus fraîche, alors le serveur aurait répondu avec un `200` et la ressource mise à jour qui aurait dû être téléchargée à nouveau.

```
> GET /static/js/main.js HTTP/1.1
> Host: www.httparchive.org
> User-Agent: curl/7.54.0
> Accept: */*
> If-Modified-Since: Sun, 25 Aug 2019 16:00:30 GMT

< HTTP/1.1 304
< Date: Thu, 17 Oct 2019 02:31:08 GMT
< Server: gunicorn/19.7.1
< Cache-Control: public, max-age=43200
< Expires: Thu, 17 Oct 2019 14:31:08 GMT
< ETag: "1566748830.0-3052-3932359948"
< Accept-Ranges: bytes
```

Dans l'ensemble, 65&nbsp;% des réponses sont servies avec un en-tête `Last-Modified`, 42&nbsp;% sont servies avec un `ETag`, et 38&nbsp;% utilisent les deux. Cependant, 30&nbsp;% des réponses n'incluent ni un en-tête `Last-Modified` ni un en-tête `ETag`.

{{ figure_markup(
  image="fig12.png",
  caption="Adoption de la validation de la fraîcheur via les en-têtes <code>Last-Modified</code> et <code>ETag</code> pour sites sur ordinateurs de bureau.",
  description="Le diagramme à barres montre que 64,4&nbsp;% des requêtes sur ordinateurs de bureau ont un Last Modified, 42,8&nbsp;% ont un ETag, 37,9&nbsp;% ont les deux et 30,7&nbsp;% n'ont ni l'un ni l'autre. Les statistiques pour les mobiles sont presque identiques&nbsp;: 65,3&nbsp;% pour la dernière modification, 42,8&nbsp;% pour l'ETag, 38,0&nbsp;% pour les deux et 29,9&nbsp;% pour aucune des deux.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=20297100&format=interactive"
  )
}}

## Validité des dates

Le format des en-têtes HTTP utilisés pour transmettre les horodatages, et le format de ceux-ci, sont importants. L'en-tête `Date` indique quand la ressource a été servie à un client. L'en-tête `Last-Modified` indique quand une ressource a été modifiée pour la dernière fois sur le serveur. Et l'en-tête `Expires` est utilisé pour indiquer combien de temps une ressource doit être mise en cache (à moins qu'un en-tête `Cache-Control` soit présent).

Tous ces en-têtes HTTP utiliser des dates sous forme de chaine de carractères pour représenter des horodatages.

Par exemple&nbsp;:

```
> GET /static/js/main.js HTTP/1.1
> Host: httparchive.org
> User-Agent: curl/7.54.0
> Accept: */*

< HTTP/1.1 200
< Date: Sun, 13 Oct 2019 19:36:57 GMT
< Content-Type: application/javascript; charset=utf-8
< Content-Length: 3052
< Vary: Accept-Encoding
< Server: gunicorn/19.7.1
< Last-modified: Sun, 25 Aug 2019 16:00:30 GMT
< Cache-Control: public, max-age=43200
< Expires: Mon, 14 Oct 2019 07:36:57 GMT
< ETag: "1566748830.0-3052-3932359948"
```

La plupart des clients ignorent les dates invalides, ce qui les rend incapables de comprendre la réponse qui leur est servie. Cela peut avoir des conséquences sur la possibilité de mise en cache, puisqu'un en-tête `Last-Modified` erroné sera mis en cache sans l'horodatage `Last-Modified`, ce qui rendra impossible l'exécution d'une requête conditionnelle.

L'en-tête de réponse HTTP `Date` est généralement généré par le serveur web ou le CDN qui sert la réponse à un client. Comme l'en-tête est généralement généré automatiquement par le serveur, il a tendance à être moins sujet aux erreurs, ce qui se reflète dans le très faible pourcentage d'en-têtes `Date` invalides. Les en-têtes `Last-Modified` sont très similaires, avec seulement 0,67&nbsp;% d'en-têtes invalides. Ce qui est très surprenant, c'est que 3,64&nbsp;% des en-têtes `Expires` utilisent un format de date invalide&nbsp;!

{{ figure_markup(
  image="fig13.png",
  caption="Formats de date invalides dans les en-têtes de réponse.",
  description="Le diagramme à barres montre que 0,10&nbsp;% des réponses sur ordinateurs de bureau ont une date non valide, 0,67&nbsp;% ont une date Last-Modified non valide et 3,64&nbsp;% ont une date d'Expires non valide. Les statistiques pour les mobiles sont très similaires avec 0,06&nbsp;% des réponses ayant une date non valide, 0,68&nbsp;% ayant une date Last-Modified non valide et 3,50&nbsp;% ayant une date d'Expires non valide.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1500819114&format=interactive"
  )
}}

Voici des exemples d'utilisations incorrectes de l'en-tête `Expires`&nbsp;:

* Formats de date valides, mais utilisant un fuseau horaire autre que GMT
* Valeurs numériques telles que 0 ou -1
* Valeurs qui seraient valides dans un en-tête `Cache-Control`

La plus grande source d'en-têtes `Expires` invalides provient de ressources servies par une tierce partie , dans lesquels un horodatage utilise le fuseau horaire EST, par exemple `Expires: Tue, 27 Apr 1971 19:44:06 EST`.

## En-tête `Vary`

L'une des étapes les plus importantes de la mise en cache est de déterminer si la ressource demandée est mise en cache ou non. Bien que cela puisse paraître simple, il arrive souvent que l'URL seule ne suffise pas à le déterminer. Par exemple, les requêtes ayant la même URL peuvent varier en fonction de la [compression](./compression) utilisée (Gzip, Brotli, etc.) ou être modifiées et adaptées aux visiteurs mobiles.

Pour résoudre ce problème, les clients donnent à chaque ressource mise en cache un identifiant unique (une clé de cache). Par défaut, cette clé de cache est simplement l'URL de la ressource, mais les développeurs et développeuses peuvent ajouter d'autres éléments (comme la méthode de compression) en utilisant l'en-tête `Vary`.

Un en-tête`Vary` demande au client d'ajouter la valeur d'une ou plusieurs valeurs d'en-tête de requête à la clé de cache. L'exemple le plus courant est `Vary&nbsp;: Accept-Encoding`, qui se traduira par différentes entrées en cache pour les valeurs d'en-tête de requête `Accept-Encoding` (c'est-à-dire `gzip`, `br`, `deflate`).

Une autre valeur commune est `Vary: Accept-Encoding, User-Agent`, qui demande au client de varier l'entrée en cache à la fois par les valeurs de `Accept-Encoding` et par la chaîne `User-Agent`. Lorsqu'il s'agit de proxies et de CDN partagés, l'utilisation de valeurs autres que `Accept-Encoding` peut être problématique car elle dilue les clés de cache et peut réduire le volume de trafic servi à partir du cache.

En général, vous ne devez modifier le cache que si vous servez un contenu alternatif aux clients en fonction de cet en-tête.

L'en-tête `Vary` est utilisé sur 39&nbsp;% des réponses HTTP, et 45&nbsp;% des réponses qui incluent un en-tête `Cache-Control`.

Le graphique ci-dessous détaille la popularité des 10 premières valeurs d'en-tête `Vary`. L'`Accept-Encoding` représente 90&nbsp;% de l'utilisation de `Vary`, avec `User-Agent` (11&nbsp;%), `Origin` (9&nbsp;%), et `Accept` (3&nbsp;%) constituant la majeure partie du reste.

{{ figure_markup(
  image="fig14.png",
  caption="Utilisation de l'en-tête Vary.",
  description="Le diagramme à barres montre que 90&nbsp;% des utilisations se basent sur accept-encoding, et pour le reste des valeurs beaucoup plus petites avec 10 à 11&nbsp;% pour l'user-agent, environ 7 à 8&nbsp;% pour origin et moins pour accept, presque pas d'utilisation pour les en-têtes cookie, x-forward-proto, accept-language, host, x-origin, access-control-request-method, et access-control-request-heads",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=384675253&format=interactive",
  width=600,
  height=655,
  data_width=600,
  data_height=655
  )
}}

## L'utilisation de cookies pour la mise en cache des réponses

Lorsqu'une réponse est mise en cache, tous ses en-têtes sont également stockés dans le cache. C'est pourquoi vous pouvez voir les en-têtes de réponse lorsque vous inspectez une réponse mise en cache via DevTools.

{{ figure_markup(
  image="ch16_fig12_header_example_with_cookie.jpg",
  caption="Outils de développement Chrome pour une ressource en cache.",
  description="Une capture d'écran de Chrome Developer Tools montrant les en-têtes de réponse HTTP pour une réponse en cache.",
  width=600,
  height=359
  )
}}

Mais que se passe-t-il si vous avez un `Set-Cookie` dans une réponse&nbsp;? Selon la <a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-8">RFC 7234 Section 8</a>, la présence d'un en-tête de réponse `Set-Cookie` n'empêche pas la mise en cache. Cela signifie qu'une entrée mise en cache peut contenir un `Set-Cookie` si elle a été mise en cache avec. La RFC recommande ensuite que vous configuriez des en-têtes `Cache-Control` appropriés pour contrôler la mise en cache des réponses.

L'un des risques de la mise en cache avec `Set-Cookie` est que les valeurs des cookies puissent être stockées et servies à des requêtes ultérieures. Suivant l'objectif du cookie, cela pourrait avoir des résultats inquiétants. Par exemple, si un cookie de connexion ou un cookie de session est présent dans un cache partagé, alors ce cookie pourrait être réutilisé par un autre client. Une façon d'éviter cela est d'utiliser la directive `Cache-Control` `private`, qui permet uniquement la mise en cache de la réponse par le navigateur du client.

3&nbsp;% des réponses pouvant être mises en cache contiennent un en-tête `Set-Cookie`. Parmi ces réponses, seulement 18&nbsp;% utilisent la directive `private`. Les 82&nbsp;% restants comprennent 5,3 millions de réponses HTTP qui incluent un `Set-Cookie` qui peut être mis en cache par des serveurs de cache publics et privés.

{{ figure_markup(
  image="ch16_fig16_cacheable_responses_set_cookie.jpg",
  caption="Réponses pouvant être mises en cache avec <code>Set-Cookie</code>.",
  description="Le graphique à barres montre que 97&nbsp;% des réponses n'utilisent pas Set-Cookie alors que 3&nbsp;% le font. Ces 3&nbsp;% sont zoomés pour obtenir un autre diagramme à barres montrant la répartition entre 15,3&nbsp;% de réponses <code>private</code>, 84,7&nbsp;% de réponses <code>public</code> pour les ordinateurs de bureau et réciproquement pour les téléphones portables, 18,4&nbsp;% de réponses <code>public</code> et 81,6&nbsp;% de réponses <code>private</code>.",
  width=600,
  height=567
  )
}}

## AppCache et service workers

L'Application Cache ou AppCache est une fonctionnalité de HTML5 qui permet aux développeurs et développeuses de spécifier les ressources que le navigateur doit mettre en cache et mettre à disposition des utilisateurs hors ligne. Cette fonctionnalité a été <a hreflang="en" href="https://web.archive.org/web/20191115024726/https://html.spec.whatwg.org/multipage/offline.html">dépréciée et supprimée des standards du web</a>, et sa prise en charge par les navigateurs a diminué. En fait, lorsque son utilisation est détectée, [Firefox v44+ recommande aux développeurs et développeuses d'utiliser plutôt des service workers](https://developer.mozilla.org/docs/Web/API/Service_Worker_API/Using_Service_Workers). <a hreflang="en" href="https://www.chromestatus.com/feature/5714236168732672">Chrome 70 limite le cache d'application au seul contexte sécurisé</a>. Le secteur s'est davantage orienté vers la mise en œuvre de ce type de fonctionnalité avec des service workers - et <a hreflang="en" href="https://caniuse.com/#feat=serviceworkers">la prise en charge des navigateurs</a> a connu une croissance rapide dans ce domaine.

En fait, l'un des <a hreflang="en" href="https://httparchive.org/reports/progressive-web-apps#swControlledPages">rapports de tendance des archives HTTP montre l'adoption des travailleurs des services</a> présenté ci-dessous&nbsp;:

{{ figure_markup(
  image="ch16_fig14_service_worker_adoption.jpg",
  caption='Série chronologique de pages contrôlées par des service workers. (Source&nbsp;: <a hreflang="en" href="https://httparchive.org/reports/progressive-web-apps#swControlledPages">HTTP Archive</a>)',
  description="Un graphique de séries chronologiques montre l'utilisation des sites contrôlés par les service worker d'octobre 2016 à juillet 2019. L'utilisation a augmenté régulièrement au fil des ans, tant pour les téléphones portables que pour les ordinateurs de bureau, mais reste inférieure à 0,6&nbsp;% pour les deux.",
  width=600,
  height=311
  )
}}

L'adoption est toujours inférieure à 1&nbsp;% des sites web, mais elle est en constante augmentation depuis janvier 2017. Le chapitre [Progressive Web App](./pwa) en parle davantage, notamment du fait qu'ils sont beaucoup plus utilisés que ne le suggère ce graphique en raison de leur utilisation sur des sites populaires, qui ne sont comptés qu'une fois dans le graphique ci-dessus.

Dans le tableau ci-dessous, vous pouvez voir un résumé de l'utilisation d'AppCache par rapport aux service workers. 32&nbsp;292 sites web ont mis en place un service worker, tandis que 1&nbsp;867 sites utilisent toujours la fonctionnalité AppCache, qui est obsolète.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th>N'utilisent pas de Server Worker</th>
        <th>Utilisent un Service Worker</th>
        <th>Total</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>N'utilise pas AppCache</td>
        <td class="numeric">5,045,337</td>
        <td class="numeric">32,241</td>
        <td class="numeric">5,077,578</td>
      </tr>
      <tr>
        <td>Utilise AppCache</td>
        <td class="numeric">1,816</td>
        <td class="numeric">51</td>
        <td class="numeric">1,867</td>
      </tr>
      <tr>
        <td>Total</td>
        <td class="numeric">5,047,153</td>
        <td class="numeric">32,292</td>
        <td class="numeric">5,079,445</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption=" Nombre de sites web utilisant AppCache par rapport aux Service Workers.") }}</figcaption>
</figure>

Si on fait une comparaison entre HTTP et HTTPS, cela devient encore plus intéressant. 581 des sites compatibles avec l'AppCache sont servis en HTTP, ce qui signifie que Chrome a probablement désactivé cette fonctionnalité. Le HTTPS est obligatoire pour l'utilisation des services workers, mais 907 des sites qui les utilisent sont servis en HTTP.

<figure>
  <table>
    <thead>
      <tr>
        <td scope="col"></td>
        <td></td>
        <th scope="col">N'utilise pas Service Worker</th>
        <th scope="col">Utilise Service Worker</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="rowgroup" rowspan="2" >HTTP</th>
        <td>N'utilise pas AppCache</td>
        <td class="numeric">1,968,736</td>
        <td class="numeric">907</td>
      </tr>
      <tr>
        <td>Utilise AppCache</td>
        <td class="numeric">580</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <th scope="rowgroup" rowspan="2" >HTTPS</th>
        <td>N'utilise pas AppCache</td>
        <td class="numeric">3,076,601</td>
        <td class="numeric">31,334</td>
      </tr>
      <tr>
        <td>Utilise AppCache</td>
        <td class="numeric">1,236</td>
        <td class="numeric">50</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Nombre de sites web utilisant AppCache par rapport à l'utilisation des service worker par HTTP/HTTPS.") }}</figcaption>
</figure>

## Identifier les possibilités de mise en cache

L'outil <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> de Google permet aux utilisateurs d'effectuer une série d'audits sur les pages web, et <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/cache-policy">l'audit de la politique de cache</a> évalue si un site peut bénéficier d'une mise en cache supplémentaire. Pour ce faire, il compare l'âge du contenu (via l'en-tête `Last-Modified`) au TTL de la ressource en cache et estime la probabilité que la ressource soit servie à partir du cache. En fonction du score, vous pouvez voir dans les résultats une recommandation de mise en cache, avec une liste de ressources spécifiques qui pourraient être mises en cache.

{{ figure_markup(
  image="ch16_fig15_lighthouse_example.jpg",
  caption="Rapport Lighthouse soulignant les améliorations possibles de la politique des caches.",
  description="Une capture d'écran d'une partie d'un rapport de l'outil Google Lighthouse, avec la section “Servir des ressources statiques avec une politique de cache efficace” ouverte où il énumère un certain nombre de ressources, dont les noms ont été masqués, et le TTL du cache par rapport à la taille.",
  width=600,
  height=459
  )
}}

Lighthouse calcule un score pour chaque audit, allant de 0 à 100&nbsp;%, et ces scores sont ensuite pris en compte dans les scores globaux. Le <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/cache-policy">score de mise en cache</a> est basé sur les économies potentielles d'octets. En examinant les résultats de Lighthouse, on peut se faire une idée du nombre de sites qui réussissent bien avec leur politique de cache.

{{ figure_markup(
  image="fig21.png",
  caption="Distribution des scores Lighthouse pour l'audit “Définit un long cache TTL” pour les pages web mobiles.",
  description="Un diagramme à barres superposées&nbsp;: 38,2&nbsp;% des sites web obtiennent un score de < 10&nbsp;%, 29,0&nbsp;% des sites web obtiennent un score entre 10 et 39&nbsp;%, 18,7&nbsp;% des sites web obtiennent un score de 40 à 79&nbsp;%, 10,7&nbsp;% des sites web obtiennent un score de 80 à 99&nbsp;%, et 3,4&nbsp;% des sites web obtiennent un score de 100&nbsp;%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=827424070&format=interactive"
  )
}}

Seuls 3,4&nbsp;% des sites ont obtenu un score de 100&nbsp;%, ce qui signifie que la plupart des sites peuvent bénéficier de certaines optimisations du cache. La grande majorité des sites ont un score inférieur à 40&nbsp;%, 38&nbsp;% ayant un score inférieur à 10&nbsp;%. En partant de là, on peut affirmer qu'il existe un nombre important d'opportunités de mise en cache sur le web.

Lighthouse indique également combien d'octets pourraient être économisés sur les vues répétées en permettant une politique de cache plus longue. Parmi les sites qui pourraient bénéficier d'une mise en cache supplémentaire, 82&nbsp;% d'entre eux peuvent réduire le poids de leurs pages jusqu'à un Mo entier&nbsp;!

{{ figure_markup(
  image="fig22.png",
  caption="Répartition des économies potentielles d'octets résultant de l'audit de la mise en cache de Lighthouse.",
  description="Un diagramme à barres superposées montrant que 56,8&nbsp;% des sites web ont un potentiel d'économie d'octets de moins d'un Mo, 22,1&nbsp;% pourraient avoir une économie d'un à deux Mo, 8,3&nbsp;% pourraient économiser deux à trois Mo. 4,3&nbsp;% pourraient permettre d'économiser trois à quatre Mo et 6,0&nbsp;% pourraient permettre d'économiser plus de quatre Mo.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vT3GWCs19Wq0mu0zgIlKRc8zcXgmVEk2xFHuzZACiWVtqOv8FO5gfHwBxa0mhU6O9TBY8ODdN4Zjd_O/pubchart?oid=1698914500&format=interactive"
  )
}}

## Conclusion

La mise en cache est une fonction incroyablement puissante qui permet aux navigateurs, aux serveurs de proxy et autres intermédiaires (tels que les CDN) de stocker le contenu du web et de le servir aux utilisateurs finaux. Les avantages en termes de performances sont considérables, puisqu'elle réduit les temps de trajet (aller-retour) et minimise les requêtes coûteuses sur le réseau.

La mise en cache est également un sujet très complexe. Il existe de nombreux en-têtes de réponse HTTP qui peuvent transmettre la fraîcheur ainsi que valider les entrées mises en cache, et les directives `Cache-Control` offrent une très grande souplesse et un très grand contrôle. Cependant, les développeurs et développeuses doivent être prudent·e·s quant aux possibilités supplémentaires d'erreurs que ces directives offrent. Il est recommandé de vérifier régulièrement votre site pour s'assurer que les ressources pouvant être mises en cache le sont correctement, et des outils comme <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> et <a hreflang="en" href="https://redbot.org/">REDbot</a> font un excellent travail pour aider à simplifier l'analyse.
