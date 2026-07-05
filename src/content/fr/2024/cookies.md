---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Cookies
description: Chapitre sur les cookies de l'édition 2024 du Web Almanac, couvrant la prévalence et la structure des cookies sur le web.
hero_alt: Image d'illustration des personnages du Web Almanac transportant un gros cookie, tandis que des miettes sont jetées par un autre personnage. Un autre personnage du Web Almanac suit la piste des cookies avec un chapeau de détective et une loupe.
authors: [yohhaan,samdutton,ydimova]
reviewers: [samdutton,rowan-m]
analysts: [yohhaan]
editors: [tunetheweb]
translators: [mika943]
results: https://docs.google.com/spreadsheets/d/1wDGnUkO0rgcU5_V6hmUrhm1pq60VU2XbeMHgYJEEaSM/
yohhaan_bio: Yohan Beugin est doctorant au département des sciences informatiques de l'université du Wisconsin-Madison, où il est membre du Security and Privacy Research Group sous la direction du professeur Patrick McDaniel. Il s'intéresse à la construction de systèmes plus sécurisés, respectueux de la vie privée et fiables. Ses recherches actuelles se concentrent sur le ciblage et la confidentialité dans la publicité en ligne.
samdutton_bio: Sam Dutton est Developer Advocate au sein de l'équipe Privacy Sandbox chez Google, dont la mission est d'aider les sites à abandonner les cookies tiers. Sam a grandi en Australie-Méridionale, a étudié à l'université de Sydney et vit à Londres depuis 1986. Il a travaillé auparavant comme ingénieur logiciel chez BBC R&D et ITN, comme typographe pour Decca Records et comme chercheur pour Picador Books.
ydimova_bio: Yana Dimova est doctorante à DistriNet, KU Leuven, et se concentre sur la perspective des utilisateurs en matière de vie privée et sur la façon dont ils peuvent se protéger sur le web. Ses intérêts de recherche portent sur le suivi en ligne, les fuites de données personnelles ainsi que le droit de la vie privée et de la protection des données.
featured_quote: Nos résultats indiquent que le suivi de première partie (first-party) et de tierce partie (third-party) est courant. Nous démontrons que le suivi en ligne au moyen de cookies reste prédominant auf le web.
featured_stat_1: 61%
featured_stat_label_1: Cookies qui sont des cookies tiers
featured_stat_2: 11%
featured_stat_label_2: Cookies de première partie sur ordinateur ayant `SameSite=None`
featured_stat_3: 6%
featured_stat_label_3: Cookies tiers qui sont partitionnés (CHIPS)
doi: 10.5281/zenodo.14065903
---

## Introduction

Le chapitre suivant du Web Almanac 2024 est consacré aux cookies. Les cookies ont de multiples fonctionnalités et sont, dans une certaine mesure, essentiels au fonctionnement du web — par exemple pour l'authentification, la prévention de la fraude et la sécurité. Cependant, certains cookies peuvent suivre les utilisateurs d'un site à l'autre et sont utilisés pour établir des profils de comportement.

Dans ce chapitre, nous mesurons la prévalence et la structure des cookies web rencontrés lors de la navigation sur le premier million de sites web les plus visités au cours de la collecte de données de HTTP Archive en juin 2024.

De plus, nous analysons et mesurons l'adoption de mécanismes alternatifs aux cookies tiers introduits par Google sur Chrome dans le cadre de l'initiative <a hreflang="en" href="https://privacysandbox.com/">Privacy Sandbox</a> visant à réduire le suivi intersite.

{# TODO remove findings from intro #}
Nous constatons que 61 % des cookies sont définis dans un contexte tiers. En général, les cookies tiers peuvent être utilisés pour le suivi en ligne et la publicité ciblée. C'est pourquoi Google a proposé de supprimer progressivement tous les cookies tiers et d'introduire des options plus respectueuses de la vie privée pour remplacer leurs fonctionnalités grâce à la Privacy Sandbox.

{# TODO remove findings from intro #}
D'un autre côté, tous les cookies tiers ne sont pas utilisés pour le suivi en ligne. Les navigateurs comme Chrome intègrent plusieurs moyens de limiter l'utilisation des cookies tiers. Par exemple, les cookies partitionnés (CHIPS) ne peuvent pas être consultés sur des sites de premier niveau différents de celui sur lequel ils ont été initialement déposés, ce qui rend impossible le suivi des utilisateurs d'un site à l'autre. Néanmoins, nous constatons que les cookies partitionnés les plus courants sont déposés par des domaines liés à la publicité. Un autre exemple est l'attribut de cookie `SameSite`, qui garantit que les cookies (de première partie) ne sont pas inclus par défaut dans les requêtes intersites. Les traqueurs peuvent désactiver ce comportement en attribuant explicitement la valeur `None` à l'attribut `SameSite`. Par conséquent, nous constatons en pratique que pour 11 % des cookies de première partie observés, `SameSite` est configuré sur `None`. De plus, nous observons que les cookies tiers les plus largement déployés sont utilisés pour la publicité et l'analyse de données, Google étant présent sur le plus grand pourcentage de sites web.

{# TODO remove findings from intro #}
Les cookies de première partie peuvent également être utilisés pour suivre les utilisateurs récurrents. De notre analyse, nous concluons que les cookies de première partie les plus répandus sont utilisés pour l'analyse d'audience. En théorie, en raison de la politique de même origine (same-origin policy), ces cookies ne peuvent pas être utilisés pour le suivi intersite. Cependant, en utilisant des méthodes de suivi avancées telles que la synchronisation de cookies (cookie syncing) et le suivi CNAME (CNAME tracking), les traqueurs peuvent contourner cette limitation. Nous vous renvoyons au chapitre [Vie privée](./privacy) pour plus de détails sur les méthodes de suivi en ligne.

{# TODO remove findings from intro #}
Nos résultats indiquent que le suivi de première partie et de tierce partie est courant. Nous démontrons que le suivi en ligne au moyen de cookies reste prédominant sur le web.

## Définitions

Commençons par nous accorder sur la définition de certains termes utilisés dans ce chapitre.

### Cookie HTTP

Lorsqu'un utilisateur visite un site web, il interagit avec un serveur web qui peut demander au navigateur de l'utilisateur de définir et d'enregistrer un [cookie HTTP](https://developer.mozilla.org/docs/Web/HTTP/Cookies). Ce cookie correspond à des données sauvegardées sous forme de chaîne de caractères sur l'appareil de l'utilisateur, et est renvoyé lors des requêtes HTTP ultérieures adressées à ce serveur web. Les cookies sont utilisés pour conserver des informations d'état sur les utilisateurs à travers plusieurs requêtes HTTP, permettant ainsi l'authentification, la gestion des sessions et le suivi. Les cookies sont également associés à des risques pour la vie privée et la sécurité.

### Cookies de première partie (first-party) et de tierce partie (third-party)

Les cookies sont définis par un serveur web et il en existe deux types : les cookies **de première partie** et les cookies **de tierce partie**. Les cookies de première partie sont déposés par le même domaine que le site que l'utilisateur visite, tandis que les cookies tiers sont déposés par un domaine différent.

Les cookies tiers peuvent provenir d'un tiers véritable, ou d'un site ou service différent appartenant à la même entité juridique ("première partie") que le site de premier niveau. Les **cookies tiers** sont en réalité des **cookies intersites**.

Pour illustrer cela, imaginez que le propriétaire du domaine `example.com` possède également `example.net` et que les cookies suivants soient définis pour un utilisateur visitant `https://www.example.com` :

<figure>
  <table>
    <thead>
      <tr>
        <th>Nom du cookie</th>
        <th>Déposé par</th>
        <th>Type de cookie</th>
        <th>Raison</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`cookie_a`</td>
        <td>`www.example.com`</td>
        <td>Première partie</td>
        <td>Même domaine que le site web visité</td>
      </tr>
      <tr>
        <td>`cookie_b`</td>
        <td>`cart.example.com`</td>
        <td>Première partie</td>
        <td>Même domaine que le site web visité : les sous-domaines n'importent pas</td>
      </tr>
      <tr>
        <td>`cookie_c`</td>
        <td>`www.example.edu`</td>
        <td>Tierce partie</td>
        <td>Domaine différent du site web visité</td>
      </tr>
      <tr>
        <td>`cookie_d`</td>
        <td>`tracking.example.org`</td>
        <td>Tierce partie</td>
        <td>Domaine différent du site web visité</td>
      </tr>
      <tr>
        <td>`cookie_e`</td>
        <td>`login.example.net`</td>
        <td>Tierce partie</td>
        <td>Domaine différent du site web visité même s'il appartient au même propriétaire dans cet exemple (cookie intersite provenant de la même "première partie" que le site de premier niveau)</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Contexte des cookies.") }}</figcaption>
</figure>

### Risques pour la vie privée et la sécurité

**Suivi web (Web tracking).** Les cookies sont utilisés par des tiers pour suivre les utilisateurs de site en site et enregistrer leur comportement de navigation ainsi que leurs intérêts. Dans le cadre de la publicité ciblée, ces données sont exploitées pour afficher des publicités correspondant aux intérêts de l'utilisateur. Ce suivi se déroule généralement de la manière suivante : un code tiers intégré sur un site peut déposer un cookie qui identifie un utilisateur. Ensuite, ce même tiers peut enregistrer l'activité de l'utilisateur en récupérant ce cookie lorsque l'utilisateur visite d'autres sites web où ce code est également intégré (voir aussi le chapitre [Vie privée](./privacy)). Nous précisons que les cookies de première partie peuvent également être utilisés pour le suivi en ligne, des méthodes comme la synchronisation de cookies permettant de contourner les limitations des cookies tiers et de suivre les utilisateurs <a hreflang="en" href="https://dl.acm.org/doi/abs/10.1145/3442381.3449837">à travers différents sites web</a>.

**Vol de cookies et détournement de session (Session hijacking).** Les cookies sont utilisés pour stocker des informations de session telles que des identifiants (jeton de session) à des fins d'authentification à travers plusieurs requêtes HTTP. Toutefois, si ces cookies venaient à être récupérés par un acteur malveillant, ce dernier pourrait les utiliser pour s'authentifier auprès des serveurs web correspondants. Si les cookies ne sont pas correctement configurés par les serveurs web, ils peuvent être sujets à des vulnérabilités intersites telles que le [détournement de session](https://developer.mozilla.org/docs/Glossary/Session_Hijacking), la contrefaçon de requête intersite ([CSRF](https://developer.mozilla.org/docs/Web/Security/Practical_implementation_guides/CSRF_prevention)), l'inclusion de scripts intersites ([XSS](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting)), et d'autres (voir aussi le chapitre [Sécurité](./security)).

### Limites méthodologiques

Vous pouvez en savoir plus sur la méthodologie appliquée par HTTP Archive pour le Web Almanac en 2024 sur la page [Méthodologie](./methodology). Cette méthodologie comporte des limites qui peuvent influencer les résultats de ce chapitre :

- Les données sont collectées en visitant automatiquement des sites web de manière non interactive ; l'interaction d'un utilisateur réel pourrait modifier la façon dont les sites web définissent et utilisent les cookies en pratique. Par exemple, les outils de HTTP Archive n'interagissent pas mit les bannières de cookies (le cas échéant), ainsi les cookies qui seraient déposés après interaction avec ces bannières ne sont pas observés dans notre étude.
- Les sites web sont visités depuis des serveurs situés aux États-Unis qui n'ont aucun cookie enregistré au début de chaque visite indépendante ; cela est très différent d'un utilisateur réel qui accumule et enregistre des cookies au fil de sa navigation sur le web. L'emplacement géographique depuis lequel les visites sont effectuées peut impacter le comportement des cookies en raison de réglementations et législations telles que le <a hreflang="en" href="https://gdpr-info.eu/">RGPD</a>.
- Pour chaque site web, la page d'accueil ainsi qu'une autre page du même site sont visitées.
- La plupart des résultats présentés dans ce chapitre sont basés sur le premier million de sites web les plus visités selon le [Chrome User Experience Report (CrUX)](https://developer.chrome.com/docs/crux) qui ont pu être consultés avec succès lors de la collecte de données de HTTP Archive en juin 2024.
- Les cookies collectés pour l'analyse de ce chapitre ont été obtenus à la fin de la visite de chaque page web en extrayant tous les cookies stockés par le navigateur dans son gestionnaire de cookies. Par conséquent, les données collectées ne contiennent que les cookies jugés valides par le navigateur et correctement enregistrés. Ainsi, si des sites web tentent de définir des cookies invalides (taille trop grande, non-concordance des attributs, etc.), ces derniers seront absents de notre analyse.

### Remarques

Les graphiques présentés dans ce chapitre indiquent dans leur sous-titre (a) le type d'appareil client (**ordinateur** ou **mobile**) utilisé pour accéder aux sites web pour les données affichées et (b) le classement des sites web visités (selon leur [rang CrUX](https://developer.chrome.com/blog/crux-rank-magnitude)). Si l'information n'est pas spécifiée, elle figure sur l'un des axes du graphique.

## Prévalence et structure des cookies

Dans cette section, nous présentons la prévalence des cookies, leur type et leurs attributs sur le web.

### Prévalence des cookies de première et tierce partie

Les cookies de première partie sont définis par le même domaine que le site web que l'utilisateur visite, tandis que les cookies tiers sont définis par un domaine différent [voir Définitions](#définitions). Dans cette analyse, nous examinons le pourcentage de cookies déposés sur les sites web qui sont de première et de tierce partie selon les types de clients (ordinateur ou mobile) et les rangs CrUX.

{{ figure_markup(
  image="first-and-third-party-prevalence.png",
  caption="Prévalence des cookies de première partie et tiers.",
  description="Diagramme en barres montrant la prévalence des cookies de première partie et tiers sur les clients ordinateurs et mobiles. Pour les deux types de clients, nous observons la même répartition : 39 % des cookies sont de première partie et 61 % des cookies définis sont des cookies tiers.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=627993125&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

Sur le premier million de sites web les plus visités, environ 39 % des cookies sont de première partie et 61 % sont des cookies tiers. Ainsi, une majorité des cookies définis sur le web sont des cookies tiers. Nous observons également que cette répartition est très similaire, que ces sites soient consultés via un ordinateur ou un appareil mobile. Cela indique que dans l'ensemble, il y a peu ou pas de changement de comportement basé sur le type de client utilisé. Cependant, certains sites web peuvent toujours se comporter différemment et/ou utiliser d'autres méthodes de suivi comme l'empreinte numérique (fingerprinting) selon le type de client (voir le chapitre [Vie privée](./privacy) pour en savoir plus).

{{ figure_markup(
  image="first-and-third-party-prevalence-by-rank-desktop.png",
  caption="Prévalence des cookies de première partie et tiers par rang sur les clients ordinateurs.",
  description="Diagramme en barres montrant la prévalence des cookies de première partie et tiers sur les clients ordinateurs selon la popularité du site web (nous avons utilisé le rapport Chrome User Experience pour déterminer la popularité des sites). Nous constatons que les sites web les plus populaires déposent nettement plus de cookies tiers. Pour les mille sites web les plus populaires sur ordinateur, 77 % des cookies définis sont des cookies tiers, tandis que pour le premier million de sites, 61 % des cookies sont tiers. Une explication de cette différence est que les sites plus populaires ont tendance à inclure plus de contenus tiers qui déposent des cookies.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1327011561&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

{{ figure_markup(
  image="first-and-third-party-prevalence.png-by-rank-mobile.png",
  caption="Prévalence des cookies de première partie et tiers par rang sur les clients mobiles.",
  description="Diagramme en barres montrant la prévalence des cookies de première partie et tiers sur les clients mobiles selon la popularité du site web (nous avons utilisé le rapport Chrome User Experience pour déterminer la popularité des sites). Nous constatons que les sites web les plus populaires déposent nettement plus de cookies tiers. Pour les mille sites les plus populaires sur ordinateur, 77 % des cookies définis sont des cookies tiers, tandis que pour le premier million de sites, 61 % des cookies sont tiers. Une explication de cette différence est que les sites plus populaires ont tendance à inclure plus de contenus tiers qui déposent des cookies. Nous observons les mêmes résultats pour les clients mobiles et ordinateurs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1792338085&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_type_attributes_per_rank.sql"
  )
}}

En analysant la prévalence du type de cookies selon le classement des sites web, nous constatons que les sites les plus populaires affichent une proportion plus élevée de cookies tiers que ceux moins visités. Par exemple, par rapport aux résultats rapportés pour le premier million de sites, 23 % et 77 % des cookies sont respectivement de première partie et tiers sur les mille sites les plus populaires. Cela est probablement dû au fait que les sites les plus visités par les utilisateurs intègrent davantage de codes tiers (qui à leur tour définissent plus de cookies tiers) que les sites moins fréquentés.
De plus, la prévalence de chaque type de cookie à travers les différents rangs est très similaire entre les clients ordinateurs et mobiles ; nous constatons que les remarques précédentes faites sur le premier million de sites s'appliquent également à travers les rangs CrUX.

### Attributs des cookies

Ensuite, nous analysons la répartition des différents [attributs des cookies](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie). De plus, nous zoomons sur l'utilisation de l'attribut de cookie `SameSite`. Les deux graphiques suivants montrent la proportion de cookies de première et tierce partie définis sur le premier million de sites web pour chaque client qui possèdent l'un des attributs suivants : `Partitioned`, `Session`, `HttpOnly`, `Secure`, `SameSite`. Avant d'entrer dans les détails de chaque attribut, constatons à nouveau la similitude de la répartition des différents attributs entre les clients ordinateurs et mobiles.

{{ figure_markup(
  image="cookies-attributes-overview-desktop.png",
  caption="Vue d'ensemble des attributs de cookies pour les clients ordinateurs.",
  description="Ce graphique donne un aperçu de la façon dont les attributs de cookies sont utilisés pour les clients ordinateurs pour les cookies de première partie et tiers. 100 % des cookies tiers incluent les attributs `SameSite` et `Secure`. Seulement 1 % des cookies de première partie et 6 % des cookies tiers utilisent `Partitioned`. 16 % des cookies de première partie définissent leur attribut `Session`, alors que ce n'est le cas que pour 4 % des cookies tiers. Enfin, 12 % des cookies de première partie et 19 % des cookies tiers utilisent l'attribut `HttpOnly`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=69067153&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookies-attributes-overview-mobile.png",
  caption="Vue d'ensemble des attributs de cookies pour les clients mobiles.",
  description="Ce graphique donne un aperçu de la façon dont les attributs de cookies sont utilisés pour les clients mobiles pour les cookies de première partie et tiers. Nous observons exactement les mêmes résultats que pour les clients ordinateurs. 100 % des cookies tiers incluent les attributs `SameSite` et `Secure`. Seulement 1 % des cookies de première partie et 6 % des cookies tiers utilisent `Partitioned`. 16 % des cookies de première partie définissent leur attribut `Session`, alors que ce n'est le cas que pour 4 % des cookies tiers. Enfin, 12 % des cookies de première partie et 19 % des cookies tiers utilisent l'attribut `HttpOnly`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=2109248653&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

#### `Partitioned`

Les cookies partitionnés sont stockés par les [navigateurs compatibles](https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies#browser_compatibility) en utilisant un stockage partitionné. Les cookies possédant l'attribut `Partitioned` ne peuvent être consultés que par le même tiers et depuis le même site de premier niveau où ils ont été initialement créés. En d'autres termes, les cookies partitionnés ne peuvent pas être utilisés pour le suivi tiers d'un site à l'autre et permettent une utilisation légitime des cookies tiers sur un site de premier niveau. Pour plus de détails, voir : [CHIPS (Cookies Having Independent Partitioned State)](https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies).

Nous observons qu'environ 6 % des cookies tiers définis sur ordinateur ou mobile lors de la visite du premier million de sites web sont partitionnés. Le graphique suivant présente les cookies partitionnés les plus courants (nom et domaine) qui sont définis dans un contexte tiers sur le premier million de sites. Pour chaque client (ordinateur et mobile), seuls les dix premiers cookies partitionnés en pourcentage de sites web sur lesquels ils sont visibles sont rapportés.
Les deux cookies partitionnés les plus largement utilisés sont définis par `youtube.com` sur 9,9 % des sites web sur ordinateur et 8,89 % sur mobile. Le cookie `YSC` est utilisé à des fins de sécurité, c'est-à-dire pour prévenir la fraude et les abus, et expire à la fin de la session de l'utilisateur, tandis que l'objectif principal de `VISITOR_INFO1_LIVE` est l'analyse de données (voir la <a hreflang="en" href="https://policies.google.com/technologies/cookies/embedded?hl=en-US">documentation de Google</a>).
La plupart des cookies listés dans le graphique sont définis par des domaines publicitaires comme `adnxs.com`, `criteo.com` et `doubleclick.net`.

{{ figure_markup(
  image="top-third-party-CHIPS.png",
  caption="Top des cookies partitionnés (CHIPS) dans un contexte tiers.",
  description="Un graphique montrant les principaux domaines tiers déposant des cookies partitionnés. Les deux premiers cookies partitionnés définis appartiennent à Google. `YSC` et `VISITOR_INFO1_LIVE` sont déposés par `youtube.com` sur 9,9 % des sites web sur ordinateur et 8,9 % des sites sur mobile. La plupart des principaux domaines utilisant CHIPS appartiennent à la catégorie de la publicité ou de l'analyse.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1075137054&format=interactive",
  sheets_gid="1597405066",
  sql_file ="CHIPS_top_20_third_party_cookies.sql"
  )
}}

Fait peut-être un peu surprenant, 1 % de tous les cookies de première partie définis sur le premier million de sites web (clients ordinateur et mobile) sont partitionnés. Cependant, le partitionnement des cookies dans un contexte de première partie semble quelque peu redondant puisque les cookies de première partie ne sont déjà accessibles, par définition, que par cette même première partie sur ce site de premier niveau. Le graphique suivant présente les dix premiers cookies partitionnés définis dans un contexte de première partie pour chaque client. `receive-cookie-deprecation` est défini par les domaines qui [participent à la phase de test](https://developers.google.com/privacy-sandbox/private-advertising/setup/web/chrome-facilitated-testing) de la Privacy Sandbox de Chrome. `cf_clearance` et `csrf_token` sont des cookies définis par Cloudflare pour indiquer respectivement que l'utilisateur a réussi un défi anti-robot ou pour identifier le trafic web de confiance.

{{ figure_markup(
  image="top-first-party-CHIPS.png",
  caption="Top des cookies partitionnés (CHIPS) dans un contexte de première partie.",
  description="Un graphique montrant les principaux cookies partitionnés de première partie. Le cookie principal `receive-cookie-deprecation` fait partie de la phase de test de la Privacy Sandbox. Le deuxième cookie partitionné de première partie le plus largement défini est déposé par Cloudflare sur 4,21 % des sites sur ordinateur et 4,13 % des pages sur mobile, et indique que l'utilisateur a complété avec succès la détection de robots.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1330654598&format=interactive",
  sheets_gid="1597405066",
  sql_file="CHIPS_top_20_first_party_cookies.sql"
  )
}}

#### Session

Les cookies de session sont des cookies qui ne sont valides que pour la durée d'une seule session utilisateur. En d'autres termes, les cookies de session sont temporaires et expirent dès que l'utilisateur quitte le site web correspondant sur lequel ils ont été définis, ou ferme son navigateur web, selon l'événement qui survient en premier. Notez cependant que certains navigateurs web permettent aux utilisateurs de restaurer une session précédente au démarrage ; dans ce cas, les cookies de session définis lors de cette session précédente sont également restaurés.

Les résultats de notre analyse sur le premier million de sites web en juin 2024 montrent que 16 % des cookies de première partie et seulement 4 % des cookies tiers sont des cookies de session (sur les clients ordinateurs et mobiles).

#### `HttpOnly`

L'attribut [`HttpOnly`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#httponly) empêche l'accès aux cookies par du code JavaScript, ce qui offre une certaine protection contre les attaques de [script intersite (XSS)](https://developer.mozilla.org/docs/Glossary/Cross-site_scripting). Notez que la configuration de l'attribut `HttpOnly` n'empêche pas l'envoi des cookies lors de requêtes `XMLHttpRequest` ou `fetch` initiées depuis JavaScript.

Seulement 12 % des cookies de première partie ont l'attribut `HttpOnly` configuré, alors que pour les cookies tiers, cette proportion s'élève à 19 % sur ordinateur und 18 % sur mobile.

#### `Secure`

Les cookies dotés de l'attribut [`Secure`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#secure) ne sont envoyés qu'aux requêtes effectuées via HTTPS. Cela permet de prévenir les attaques de l'homme du milieu ([man-in-the-middle](https://developer.mozilla.org/docs/Glossary/MitM)).

Pour les cookies de première partie, 23 % sur ordinateur et 22 % sur mobile possèdent l'attribut `Secure`, tandis que la totalité des cookies tiers observés possèdent l'attribut `Secure`. En effet, ces cookies tiers ont également l'attribut `SameSite=None` qui nécessite l'activation de `Secure` (voir la section suivante).

#### `SameSite`

L'attribut de cookie [`SameSite`](https://developer.mozilla.org/docs/Web/HTTP/Cookies#controlling_third-party_cookies_with_samesite) permet aux sites de spécifier quand les cookies doivent être inclus dans les requêtes intersites :
- `SameSite=Strict` : un cookie n'est envoyé qu'en réponse à une requête provenant du même site que l'origine du cookie.
- `SameSite=Lax` : identique à `SameSite=Strict`, sauf que le navigateur envoie également le cookie lors d'une navigation vers le site d'origine du cookie. C'est la valeur par défaut de `SameSite`.
- `SameSite=None` : les cookies sont envoyés lors des requêtes sur le même site ou intersites.
Cela signifie que pour rendre possible le suivi tiers à l'aide de cookies, les cookies de suivi doivent impérativement avoir leur attribut `SameSite` configuré sur `None`.

Pour en savoir plus sur l'attribut `SameSite`, consultez les références suivantes :
- [Explication des cookies `SameSite`](https://web.dev/articles/samesite-cookies-explained)
- ["Same-site" et "same-origin"](https://web.dev/articles/same-site-same-origin)
- [Quelles sont les parties d'une URL ?](https://web.dev/articles/url-parts)

{{ figure_markup(
  image="same-site-desktop.png",
  caption="Attribut `SameSite` pour les cookies sur client ordinateur.",
  description="Affiche la prévalence de l'attribut `SameSite` und sa valeur pour les cookies de première partie et tiers sur les clients ordinateurs. 2,16 % des cookies de première partie configurent l'attribut `SameSite` sur `Strict`, 20,17 % utilisent `SameSite=Lax` (qui est la valeur par défaut), 10,78 % configurent la valeur sur `None` und 66,89 % ne spécifient pas la valeur de `SameSite`. Près de 100 % des cookies tiers configurent l'attribut `SameSite` sur `None`, afin que ces cookies soient envoyés dans un contexte intersite.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=797398172&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}
{{ figure_markup(
  image="same-site-mobile.png",
  caption="Attribut `SameSite` pour les cookies sur client mobile.",
  description="Affiche la prévalence de l'attribut `SameSite` und sa valeur pour les cookies de première partie et tiers sur les clients mobiles. Nous observons des résultats très similaires à ceux des ordinateurs. 2,21 % des cookies de première partie configurent l'attribut `SameSite` sur `Strict`, 20 % utilisent `SameSite=Lax` (valeur par défaut), 10,63 % configurent la valeur sur None und 67,16 % ne spécifient pas la valeur de `SameSite`. Près de 100 % des cookies tiers configurent l'attribut `SameSite` sur `None`, afin que ces cookies soient envoyés dans un contexte intersite.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=2030447900&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

Nous observons que pour chaque client, environ 33 % des cookies de première partie et près de 100 % des cookies tiers vus sur le premier million de sites web ont un attribut `SameSite` explicitement défini lors de leur création (rappel : `SameSite` prend la valeur par défaut `Lax` s'il n'est pas spécifié). Les deux diagrammes en barres ci-dessus représentent la répartition de cet attribut `SameSite` pour les cookies de première partie et tiers selon les clients. Nous constatons que les différences de résultats entre les clients sont là encore négligeables. Près de 100 % des cookies tiers possèdent `SameSite=None`, et sont donc envoyés lors des requêtes intersites.
Pour les cookies de première partie, environ 87 % d'entre eux bénéficient du comportement `SameSite=Lax` (20 % définissent explicitement l'attribut, et les 67 % restants sont concernés par le comportement par défaut lorsque `SameSite` n'est pas configuré). 11 % des cookies ont leur attribut `SameSite` explicitement configuré sur la valeur `None`. Il est difficile de déterminer l'objectif exact pour lequel les cookies sont définis, mais il est probable qu'une fraction de ces cookies soit utilisée pour suivre les utilisateurs dans un contexte de première partie. Seulement 2 % des cookies ont `SameSite` configuré sur `Strict`.

### Préfixes de cookies

Deux [préfixes de cookies](https://developer.mozilla.org/docs/Web/HTTP/Cookies#cookie_prefixes) `__Host-` et `__Secure-` peuvent être utilisés dans le nom du cookie pour indiquer qu'ils ne peuvent être définis ou modifiés que par une origine HTTPS sécurisée. Cela permet de se défendre contre les attaques de [fixation de session](https://developer.mozilla.org/docs/Web/Security/Types_of_attacks#session_fixation). Les cookies comportant ces deux préfixes doivent être définis par une origine HTTPS sécurisée et avoir l'attribut `Secure` configuré. De plus, les cookies `__Host-` ne doivent pas contenir d'attribut `Domain` et doivent avoir leur `Path` configuré sur `/`, ainsi les cookies `__Host-` ne sont renvoyés qu'à l'hôte exact sur lequel ils ont été définis, et donc à aucun domaine parent.

{{ figure_markup(
  image="cookie-prefixes-desktop.png",
  caption="Préfixes de cookies observés sur les pages pour ordinateurs.",
  description="Montre les préfixes de cookies observés utilisés sur les pages pour ordinateurs. Nous constatons que 0,032 % des cookies de première partie et seulement 0,001 % des cookies tiers incluent `__Host-`. De même, 0,03 % des cookies de première partie et 0,001 % des cookies tiers incluent `__Secure-`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1005258943&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

{{ figure_markup(
  image="cookie-prefixes-mobile.png",
  caption="Préfixes de cookies observés sur les pages pour mobiles.",
  description="Montre les préfixes de cookies observés utilisés sur les pages pour mobiles. Nous observons des résultats très similaires aux préfixes de cookies utilisés sur les pages pour ordinateurs. Nous constatons que 0,031 % des cookies de première partie et seulement 0,001 % des cookies tiers incluent `__Host-`. De même, 0,03 % des cookies de première partie et 0,001 % des cookies tiers incluent `__Secure-`.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=747475408&format=interactive",
  sheets_gid="1700493344",
  sql_file="prevalence_attributes_per_type.sql"
  )
}}

Nous mesurons que 0,032 % et 0,030 % des cookies de première partie observés sur ordinateur possèdent respectivement le préfixe `__Host-` et `__Secure-`. Ces chiffres sont de 0,001 % pour les cookies tiers. Ces résultats démontrent la très faible adoption de ces préfixes et de la mesure de défense en profondeur associée depuis leur première [introduction](https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis#section-4.1.3.1) fin 2015.

## Principaux cookies et domaines de première et tierce partie les définissant

Dans la section suivante, nous présentons pour chaque client (ordinateur et mobile) les dix premiers cookies de première partie, cookies tiers, ainsi que les domaines qui les définissent. Nous commentons certains d'entre eux en utilisant les résultats de <a hreflang="en" href="https://cookiepedia.co.uk/">Cookiepedia</a> et invitons les lecteurs curieux à se référer à cette ressource pour en savoir plus.

{{ figure_markup(
  image="top-first-party-cookies-set.png",
  caption="Top des cookies de première partie définis.",
  description="Le graphique montre les cookies de première partie les plus largement définis. Google Analytics définit les cookies `_ga` et `_gid`, qui sont utilisés pour les statistiques des sites web et les rapports d'analyse, sur plus de 61 % des sites web pour les clients mobiles et ordinateurs.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1305664900&format=interactive",
  sheets_gid="1236728722",
  sql_file="top_20_first_party_cookies.sql"
  )
}}

Les deux premiers cookies de première partie `_ga` and `_gid` sont définis par <a hreflang="en" href="https://business.safety.google/adscookies/">Google Analytics</a> pour stocker les identifiants clients et les statistiques pour les rapports d'analyse de site, une majorité de sites web utilisant Google Analytics (respectivement plus de 60 % et 35 %). Le troisième, `_fbp`, est défini par Facebook et utilisé pour la publicité ciblée sur 25 % des sites web.

{{ figure_markup(
  image="top-third-party-cookies-set.png",
  caption="Top des cookies tiers et des domaines qui les définissent.",
  description="Le graphique montre les cookies tiers les plus largement définis. DoubleClick définit des cookies publicitaires tiers sur 28,9 % des sites web sur ordinateur et 26,7 % sur mobile. Microsoft définit également des cookies publicitaires sur 12,4 % des pages sur ordinateur et 11,3 % sur mobile. La plupart des principaux domaines déposant des cookies tiers sont liés au suivi et à la publicité.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=219338324&format=interactive",
  sheets_gid="1236728722",
  sql_file="top_20_third_party_cookies.sql"
  )
}}

Les cookies `IDE` et `test_cookie` sont définis par `doubleclick.net` (propriété de Google) et sont les cookies tiers les plus fréquemment observés sur le premier million de sites web ; ils sont utilisés pour la publicité ciblée. DoubleClick vérifie si le navigateur web d'un utilisateur prend en charge les cookies tiers en tentant de définir `test_cookie`. `MUID` de Microsoft vient ensuite et est également utilisé dans la publicité ciblée pour stocker l'identifiant unique de l'utilisateur à des fins de suivi intersite.

{{ figure_markup(
  image="top-cookie-domains.png",
  caption="Top des domaines enregistrables déposant des cookies.",
  description="Le graphique montre les domaines les plus courants qui déposent des cookies sur le web. La plateforme publicitaire DoubleClick, propriété de Google, définit des cookies sur plus de 44 % du premier million de sites web tandis que les autres se situent autour de 8 % à 12 %.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=418361658&format=interactive",
  sheets_gid="1236728722",
  sql_file="top_20_domains_setting_cookies.sql"
  )
}}

Parmi les dix domaines les plus courants qui déposent des cookies sur le web, nous ne trouvons que des domaines impliqués dans les services de recherche, de ciblage et de publicité. Ce résultat souligne la couverture que certains tiers possèdent sur le web, par exemple : la plateforme publicitaire DoubleClick, propriété de Google, définit des cookies sur plus de 44 % du premier million de sites web alors que les autres se situent entre 8 % et 12 %.

## Nombre de cookies définis par les sites web

<figure>
  <table>
    <thead>
      <tr>
        <th>Nombre de cookies (premier million sur ordinateur)</th>
        <th>Première partie</th>
        <th>Tierce partie</th>
        <th>Tous</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>médiane</td>
        <td class="numeric">7</td>
        <td class="numeric">5</td>
        <td class="numeric">10</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">13</td>
        <td class="numeric">17</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">22</td>
        <td class="numeric">66</td>
        <td class="numeric">51</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">46</td>
        <td class="numeric">331</td>
        <td class="numeric">323</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">160</td>
        <td class="numeric">632</td>
        <td class="numeric">662</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiques sur le nombre de cookies définis sur les pages pour ordinateurs.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Nombre de cookies (premier million sur mobile)</th>
        <th>Première partie</th>
        <th>Tierce partie</th>
        <th>Tous</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">3</td>
        <td class="numeric">2</td>
        <td class="numeric">4</td>
      </tr>
      <tr>
        <td>médiane</td>
        <td class="numeric">7</td>
        <td class="numeric">4</td>
        <td class="numeric">9</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">12</td>
        <td class="numeric">18</td>
        <td class="numeric">24</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">21</td>
        <td class="numeric">64</td>
        <td class="numeric">52</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">45</td>
        <td class="numeric">327</td>
        <td class="numeric">316</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">168</td>
        <td class="numeric">604</td>
        <td class="numeric">645</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiques sur le nombre de cookies définis sur les pages pour mobiles.") }}</figcaption>
</figure>

Les sites web définissent une médiane de neuf ou dix cookies de tout type au total, sept cookies de première partie, et quatre ou fife cookies tiers pour les clients mobiles et ordinateurs, respectivement. Les tableaux ci-dessus rapportent plusieurs autres statistiques sur le nombre de cookies observés par site web et les graphiques ci-dessous affichent leurs fonctions de répartition cumulative (CDF). Par exemple : sur ordinateur, un maximum de 160 cookies de première partie et 632 cookies tiers sont définis par site web.

{{ figure_markup(
  image="number-cookies-cdf-desktop.png",
  caption="Nombre de cookies par site web (CDF) pour les pages pour ordinateurs.",
  description="Le graphique montre la fonction de répartition cumulative pour le nombre de cookies définis sur les pages pour ordinateurs. Nous constatons que davantage de sites web ont un nombre de cookies de première partie plus proche du maximum de cookies de première partie observés, par rapport aux cookies tiers.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1693604543&format=interactive",
  sheets_gid="1448286433",
  sql_file="nb_cookies_cdf.sql"
  )
}}

{{ figure_markup(
  image="number-cookies-cdf-mobile.png",
  caption="Nombre de cookies par site web (CDF) pour les pages pour mobiles.",
  description="Le graphique montre la fonction de répartition cumulative pour le nombre de cookies définis sur les pages pour mobiles. Nous constatons que davantage de sites web ont un nombre de cookies de première partie plus proche du maximum de cookies de première partie observés, par rapport aux cookies tiers. De plus, nous observons des résultats très similaires pour les sites web ordinateurs et mobiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=832068018&format=interactive",
  sheets_gid="1448286433",
  sql_file="nb_cookies_cdf.sql"
  )
}}

Nous constatons que davantage de sites web ont un nombre de cookies de première partie proche du maximum observé, comparativement aux cookies tiers.

## Taille des cookies

<figure>
  <table>
    <thead>
      <tr>
        <th>Taille des cookies (premier million sur ordinateur) en octets</th>
        <th>Première partie</th>
        <th>Tierce partie</th>
        <th>Tous</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">26</td>
        <td class="numeric">22</td>
        <td class="numeric">23</td>
      </tr>
      <tr>
        <td>médiane</td>
        <td class="numeric">39</td>
        <td class="numeric">36</td>
        <td class="numeric">37</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">59</td>
        <td class="numeric">58</td>
        <td class="numeric">58</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">148</td>
        <td class="numeric">114</td>
        <td class="numeric">128</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">380</td>
        <td class="numeric">274</td>
        <td class="numeric">348</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">4087</td>
        <td class="numeric">4094</td>
        <td class="numeric">4094</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiques sur la taille des cookies définis sur les pages pour ordinateurs.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Taille des cookies (premier million sur mobile) en octets</th>
        <th>Première partie</th>
        <th>Tierce partie</th>
        <th>Tous</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
        <td class="numeric">1</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">26</td>
        <td class="numeric">22</td>
        <td class="numeric">23</td>
      </tr>
      <tr>
        <td>médiane</td>
        <td class="numeric">39</td>
        <td class="numeric">37</td>
        <td class="numeric">38</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">59</td>
        <td class="numeric">59</td>
        <td class="numeric">59</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">149</td>
        <td class="numeric">114</td>
        <td class="numeric">130</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">382</td>
        <td class="numeric">278</td>
        <td class="numeric">352</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">4086</td>
        <td class="numeric">4093</td>
        <td class="numeric">4093</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiques sur la taille des cookies définis sur les pages pour mobiles.") }}</figcaption>
</figure>

Cette section se concentre sur la taille réelle de ces cookies. Nous constatons que la taille médiane de l'ensemble des cookies observés sur ordinateur lors de la collecte de données de HTTP Archive en juin 2024 est de 37 octets. Cette valeur médiane est cohérente entre les cookies de première partie et tiers ainsi qu'entre les clients. La taille maximale que nous obtenons est d'environ 4 Ko, ce qui est conforme aux limites définies dans la [RFC 6265](https://datatracker.ietf.org/doc/html/rfc6265#section-6.1). Notez qu'en raison du fonctionnement des outils de HTTP Archive, si des sites web tentent de définir des cookies d'une taille supérieure à la limite de 4 Ko, cette information sera manquante dans les données analysées dans ce chapitre.

Les plus petits cookies observés mesurent un seul octet, ils sont probablement définis par erreur en raison d'en-têtes `Set-Cookie` vides. De plus, nous rapportons également la fonction de répartition cumulative (CDF) de la taille de tous les cookies observés sur le premier million de sites web pour chaque client.

La plupart des cookies utilisés pour le suivi ont une taille supérieure à [35 octets](https://link.springer.com/chapter/10.1007/978-3-319-15509-8_21). La raison en est que la taille est liée à la capacité de suivi des cookies : les traqueurs attribuent des identifiants de manière aléatoire aux utilisateurs afin de pouvoir les réidentifier. Ainsi, plus la taille (nombre d'octets) de l'identifiant est grande, plus ils peuvent attribuer d'identifiants uniques à différents utilisateurs.

{{ figure_markup(
  image="size-cookies-cdf-desktop-mobile.png",
  caption="Taille des cookies par site web (CDF) pour les pages pour ordinateurs et mobiles.",
  description="Le graphique montre la fonction de répartition cumulative pour le nombre de cookies définis sur les pages pour ordinateurs et mobiles. Nous observons une répartition très similaire des tailles de cookies pour les clients ordinateurs et mobiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=2005425406&format=interactive",
  sheets_gid="1882828646",
  sql_file = 'size_cookies_cdf.sql'
  )
}}

## Persistance (expiration)
<figure>
  <table>
    <thead>
      <tr>
        <th>Durée de vie des cookies (premier million sur ordinateur) en jours</th>
        <th>Première partie</th>
        <th>Tierce partie</th>
        <th>Tous</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">1</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>médiane</td>
        <td class="numeric">183</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">396</td>
        <td class="numeric">365</td>
        <td class="numeric">396</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiques sur la durée de vie des cookies définis sur les pages pour ordinateurs.") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Durée de vie des cookies (premier million sur mobile) en jours</th>
        <th>Première partie</th>
        <th>Tierce partie</th>
        <th>Tous</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>min</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
        <td class="numeric">0</td>
      </tr>
      <tr>
        <td>p25</td>
        <td class="numeric">1</td>
        <td class="numeric">30</td>
        <td class="numeric">30</td>
      </tr>
      <tr>
        <td>médiane</td>
        <td class="numeric">183</td>
        <td class="numeric">365</td>
        <td class="numeric">365</td>
      </tr>
      <tr>
        <td>p75</td>
        <td class="numeric">396</td>
        <td class="numeric">365</td>
        <td class="numeric">390</td>
      </tr>
      <tr>
        <td>p90</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>p95</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
      <tr>
        <td>max</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
        <td class="numeric">400</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Statistiques sur la durée de vie des cookies définis sur les pages pour mobiles.") }}</figcaption>
</figure>

Après avoir étudié la taille des cookies, penchons-nous sur leur durée de vie. Les cookies se voient attribuer une date d'expiration lors de leur création. Rappelons que les cookies de session expirent immédiatement après la fin de la session ([voir la section précédente](#session)). L'âge médian des cookies de première partie est d'environ 183 jours, soit à peu près 6 mois, tandis que l'âge médian des cookies tiers est d'une année complète. Après moins d'un jour et trente jours, 25 % des cookies de première partie et tiers expirent respectivement. L'âge maximum parmi les cookies que nous pouvons observer mit l'instrumentation et la collecte des outils de HTTP Archive est de 400 jours, ce qui correspond aux [limites strictes](https://developer.chrome.com/blog/cookie-max-age-expires) que Chrome impose aux attributs `Expires` und `Max-Age` des cookies. Ci-dessous figurent les fonctions de répartition cumulative (CDF) de l'âge des cookies définis sur le premier million de sites web, que ce soit sur un client ordinateur ou mobile.

{{ figure_markup(
  image="age-cookies-cdf-desktop-mobile.png",
  caption="Durée de vie des cookies par site web (CDF) pour les pages pour ordinateurs et mobiles.",
  description="Le graphique montre la fonction de répartition cumulative pour l'âge des cookies définis sur les pages pour ordinateurs et mobiles. Environ 45 % des cookies expirent après 90 jours. Nous constatons les mêmes résultats pour les clients mobiles et ordinateurs. De plus, 75 % des cookies ont une durée de vie maximale de 1 an, tandis que l'autre moitié reste stockée dans le navigateur pendant plus d'un an. Nous observons une répartition très similaire des tailles de cookies pour les clients ordinateurs et mobiles.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=147680119&format=interactive",
  sheets_gid="135614941",
  sql_file="age_expires_cookies_cdf.sql"
  )
}}

Du graphique, nous déduisons qu'environ 45 % des cookies expirent après 90 jours. Nous trouvons les mêmes résultats pour les clients mobiles et ordinateurs. De plus, 75 % des cookies ont une durée de vie de maximum 1 an, tandis que l'autre moitié reste stockée dans le navigateur pendant plus d'un an. En théorie, plus la durée de vie des cookies est longue, plus ils peuvent réidentifier un utilisateur récurrent sur le long terme. Pour cette raison, les cookies de suivi sont généralement stockés dans le navigateur pendant une période prolongée.

## Initiative Privacy Sandbox

En <a hreflang="en" href="https://blog.google/products/chrome/building-a-more-private-web/">2019</a>, Google a annoncé le lancement de l'initiative <a hreflang="en" href="https://developers.google.com/privacy-sandbox">Privacy Sandbox</a> visant à réduire le suivi intersite (sur le web) et entre applications (sur Android) tout en préservant l'utilité pour la publicité et d'autres cas d'utilisation qui reposaient historiquement sur les cookies tiers et d'autres mécanismes de suivi.

### Qu'est-ce que l'initiative Privacy Sandbox ?

La Privacy Sandbox est composée de plus de <a hreflang="en" href="https://privacysandbox.com">20 propositions différentes</a> qui visent à diminuer l'utilisation d'identifiants uniques, à limiter le suivi dissimulé (covert tracking), à lutter contre le spam et la fraude, à afficher des publicités pertinentes pour les utilisateurs et à mesurer les conversions publicitaires.

Une partie du plan initial de Google mit la Privacy Sandbox consistait à supprimer les cookies tiers, mais dans des <a hreflang="en" href="https://privacysandbox.com/news/privacy-sandbox-update">mises à jour récentes</a>, Google a annoncé que ce n'était plus son intention et qu'il préférerait introduire une "nouvelle expérience dans Chrome qui permet aux utilisateurs de faire un choix éclairé qui s'applique à l'ensemble de leur navigation web". Dans le même temps, Google continuera à "mettre à disposition les API de la Privacy Sandbox et à investir dans celles-ci pour améliorer encore la confidentialité et l'utilité".

Nous nous sommes associés au chapitre [Vie privée](./privacy) du Web Almanac 2024 pour mesurer l'adoption des API de la Privacy Sandbox sur les sites web visités lors de la collecte de données de HTTP Archive et nous renvoyons les lecteurs intéressés à leur chapitre pour l'analyse des résultats. Ci-dessous, nous présentons un aperçu des mécanismes proposés qui font partie de la Privacy Sandbox et visent à remplacer une fonctionnalité fournie jusqu'à présent par les cookies.

### API Topics

L'api [Topics](https://developers.google.com/privacy-sandbox/private-advertising/topics/web) permet la publicité basée sur les centres d'intérêt, sans utiliser de cookies tiers. L'API permet aux appelants (tels que les plateformes technologiques publicitaires) d'accéder aux sujets d'intérêt qu'ils ont observés pour un utilisateur, mais sans révéler d'informations supplémentaires sur l'activité de l'utilisateur.

Voir le chapitre [Vie privée](./privacy) pour obtenir des résultats sur l'adoption de l'API Topics.

### Protected Audience

L'api [Protected Audience](https://developers.google.com/privacy-sandbox/private-advertising/protected-audience) permet des enchères publicitaires sur l'appareil pour diffuser du remarketing et des audiences personnalisées, sans suivi tiers intersite. Les annonceurs peuvent ajouter des utilisateurs à des groupes d'intérêt sauvegardés par le navigateur pendant que les utilisateurs naviguent sur le web. Cela permet aux annonceurs de réaliser de la publicité reciblée en enchérissant sur les groupes d'intérêt disponibles dont l'utilisateur fait partie lorsqu'il visite un site web où une enchère publicitaire est réalisée.

Voir le chapitre [Vie privée](./privacy) pour obtenir des résultats sur l'adoption de l'API Protected Audience.

### API Attribution Reporting

L'api [Attribution Reporting](https://developers.google.com/privacy-sandbox/private-advertising/attribution-reporting) permet aux sites web et aux tiers de mesurer la conversion publicitaire, c'est-à-dire lorsqu'une vue ou un clic sur une publicité conduit plus tard, par exemple, à un achat. L'API Attribution Reporting vise à permettre la mesure de la conversion publicitaire, mais sans l'utilisation d'identifiants intersites et de cookies.

Voir le chapitre [Vie privée](./privacy) pour obtenir des résultats sur l'adoption de l'API Attribution Reporting.

### CHIPS

Les [cookies CHIPS (Cookies Having Independent Partitioned State)](https://developers.google.com/privacy-sandbox/cookies/chips) permettent aux développeurs web de spécifier qu'ils souhaitent que les cookies qu'ils définissent soient sauvegardés dans un stockage partitionné, c'est-à-dire dans un gestionnaire de cookies distinct par site de premier niveau. Les cookies CHIPS correspondent aux cookies partitionnés abordés précédemment dans ce chapitre, dans la section [partitionné](#partitioned).

### Related Website Sets (Ensembles de sites web connexes)

Les [Related Website Sets](https://developers.google.com/privacy-sandbox/cookies/related-website-sets) permettent aux sites web d'un même propriétaire de partager des cookies entre eux. La création et la soumission d'un ensemble de sites web connexes se font actuellement en ouvrant une pull request sur un <a hreflang="en" href="https://github.com/GoogleChrome/related-website-sets">dépôt GitHub</a> que les employés de Google vérifient et fusionnent si elle est jugée valide. Les sites web qui appartiennent au même ensemble de sites web connexes doivent également l'indiquer en plaçant un fichier correspondant à l'url <a hreflang="en" href="https://www.iana.org/assignments/well-known-uris/well-known-uris.xhtml">.well-known</a> `/.well-known/related-website-set.json`.

{{ figure_markup(
  caption="Nombre d'ensembles de sites web principaux connexes validés par Google au moment de la rédaction.",
  content= "64",
  classes="big-number",
  sheets_gid="199073475"
)
}}

Chrome est livré mit un fichier préchargé contenant les ensembles de sites web connexes validés par l'équipe Chrome ; au moment de la rédaction (version `2024.8.10.0`), il existe 64 ensembles de sites web connexes distincts. Chaque ensemble contient un domaine principal et une liste d'autres domaines liés au domaine principal sous l'un des attributs suivants : `associatedSites`, `servicesSites`, et/ou `ccTLDs`. Ces 64 domaines principaux sont chacun associés à des domaines secondaires dans le cadre de leur ensemble : 60 ensembles contiennent `associatedSites`, 11 `servicesSites`, et 7 `ccTLDs`. Nous indiquons sur le graphique suivant le nombre de domaines secondaires pour chaque ensemble. Nous observons que si une majorité des domaines principaux sont associés à 5 domaines secondaires ou moins, `https://journaldesfemmes.com`, `https://ya.ru`, et `https://mercadolibre.com` sont liés respectivement à 8, 17, et 39 domaines secondaires au sein desquels les requêtes tierces sont traitées comme si elles provenaient toutes de la première partie.

{{ figure_markup(
  image="secondary-domains.png",
  caption="Domaines secondaires par domaine principal.",
  description="Le graphique montre les domaines secondaires associés aux domaines principaux pour les Related Website Sets, qui font partie de la Privacy Sandbox de Google. Nous observons que si une majorité des domaines principaux sont associés à 5 domaines secondaires ou moins, `https://journaldesfemmes.com`, `https://ya.ru`, et `https://mercadolibre.com` sont liés respectivement à 8, 17, et 39 domaines secondaires au sein desquels les requêtes tierces sont traitées comme si elles provenaient toutes de la première partie.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=914391662&format=interactive",
  sheets_gid="199073475"
  )
}}

### Fichier d'attestation

Afin d'utiliser certaines API de la Privacy Sandbox, les appelants de l'API doivent passer par un processus d'[inscription](https://developers.google.com/privacy-sandbox/private-advertising/enrollment) pour déclarer qu'ils n'abuseront pas de ces API à des fins de réidentification intersite, mais uniquement pour les cas d'utilisation prévus. Les implications juridiques de cet engagement s'il n'est pas respecté sont assez floues, mais cela permet à ces appelants d'obtenir un fichier d'attestation qui doit être placé à l'URI `.well-known` `/.well-know/privacy-sandbox-attestations.json` sur le domaine qu'ils ont enregistré pour appeler ces API.

Chrome est livré mit un fichier préchargé contenant une list de domaines disposant d'un fichier d'attestation enregistré. Actuellement, cette liste contient 257 domaines distincts (version `2024.10.7.0`) qui se sont inscrits pour appeler les API suivantes : Attribution Reporting, Protected App Signals (Android uniquement), Private Aggregation (Chrome uniquement), Protected Audience, Shared Storage (Chrome uniquement), et Topics.

Nous avons utilisé un <a hreflang="en" href="https://github.com/privacysandstorm/well-known-crawler">crawler personnalisé</a> distinct des outils de HTTP Archive pour obtenir et analyser ces fichiers d'attestation. Nous avons récupéré mit succès les fichiers d'attestation pour 232 domaines distincts mit ce crawler (certains fichiers d'attestation peuvent être disponibles mais non obtenus par ce crawler en raison de problèmes de réseau par exemple). Ensuite, nous indiquons la proportion de domaines inscrits pour chaque API sur Chrome et Android. Nous observons que la majorité de ces origines sont inscrites pour appeler l'une des cinq API Chrome nécessitant une attestation, tandis que la proportion est bien moindre pour les API Android.

{{ figure_markup(
  image="attestation-files.png",
  caption="Inscription à partir des fichiers d'attestation des API de la Privacy Sandbox.",
  description="257 domaines se sont déjà inscrits pour la Privacy Sandbox de Google et font partie du fichier d'attestation. Le graphique montre la proportion de domaines inscrits pour chaque API sur Chrome et Android. Nous observons que la majorité de ces origines sont inscrites pour appeler l'une des d'API Chrome nécessitant une attestation, tandis que la proportion est bien moindre pour les API Android." ,
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLO9Te80QewkuPKnz6eJ7OFcU5q3fZMsdqv7cEncBKrL5zcsIN9sMMg5HQT7ndKze8JJNe-V1IkB-9/pubchart?oid=1570607827&format=interactive",
  sheets_gid="2119972682"
  )
}}

## Conclusion

Dans ce chapitre, nous analysons l'utilisation des cookies sur le web. Notre étude nous permet de répondre à plusieurs questions :

**Quel type de cookies est défini par les sites web ?**

Nous constatons que la majorité des cookies sur le web (61 %) sont des cookies tiers. De plus, les sites web les plus populaires déposent nettement plus de cookies tiers, probablement parce qu'ils intègrent généralement plus de contenus tiers. De plus, nous observons qu'environ 6 % des cookies tiers sont partitionnés (CHIPS). Les cookies partitionnés ne peuvent pas être utilisés pour le suivi tiers étant donné que le gestionnaire de cookies est distinct pour chaque site web (domaine) que l'utilisateur visite. Cependant, nous constatons que les cookies partitionnés sont majoritairement définis par des domaines publicitaires et sont utilisés pour l'analyse de données.

**Quels attributs de cookies sont configurés ?**

Sur l'ensemble des cookies définis, 16 % des cookies de première partie et seulement 4 % des cookies tiers sont des cookies de session. Le reste des cookies est plus persistant puisqu'ils ne sont pas supprimés lorsque l'utilisateur ferme le navigateur. En général, la durée de vie moyenne des cookies (la médiane) est de 6 mois pour les cookies de première partie et d'un an pour les cookies tiers.

De plus, pour 100 % des cookies tiers, l'attribut `SameSite` est explicitement configuré sur `None`, ce qui permet à ces cookies d'être inclus dans les requêtes intersites et donc d'être utilisés pour suivre les utilisateurs.

**Qui définit les cookies et à quoi servent-ils ?**

Les principaux cookies de première partie sont principalement utilisés pour l'analyse d'audience. Google Analytics, dont la fonction principale est de rendre compte de l'utilisation des sites web par les utilisateurs, c'est-à-dire l'analyse de première partie, est présent sur au moins 60 % des sites web. Meta suit ses traces en définissant des cookies de première partie sur 25 % des sites web.

Les cookies tiers sont également majoritairement définis par Google : `doubleclick.net` définit un cookie sur 44 % des sites web. Les autres traqueurs majeurs ont une portée considérablement plus faible, de l'ordre de 8 à 12 % des sites. En général, les cookies tiers les plus populaires appartiennent principalement à la catégorie de la publicité ciblée.

Nous concluons ce chapitre par un aperçu de la Privacy Sandbox, qui vise à remplacer complètement les cookies tiers, et renvoyons au chapitre [Vie privée](./privacy) pour plus de résultats.
