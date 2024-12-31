---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Compression
description: Chapitre sur la compression par Web Almanac 2019, les algorithmes, les types de contenu, la compression 1ere partie et tierce partie et les possibilités.
hero_alt: Hero image of Web Almanac characters using a ray gun to shrink an HTML page to make it much smaller.
authors: [paulcalvano]
reviewers: [foxdavidj, yoavweiss]
analysts: [paulcalvano]
editors: [tunetheweb]
translators: [allemas]
discuss: 1770
results: https://docs.google.com/spreadsheets/d/1IK9kaScQr_sJUwZnWMiJcmHEYJV292C9DwCfXH6a50o/
paulcalvano_bio: Paul Calvano est architecte performance web chez <a hreflang="en" href="https://www.akamai.com/">Akamai</a>, où il aide les entreprises à améliorer les performances de leurs sites web. Il est également co-responsable du projet HTTP Archive. Vous pouvez le retrouver en train de tweeter à l’adresse <a href="https://x.com/paulcalvano">@paulcalvano</a>, en bloguant sur <a hreflang="en" href="https://paulcalvano.com">http://paulcalvano.com</a> et partager ses recherches HTTP Archive à <a hreflang="en" href="https://discuss.httparchive.org">https://discuss.httparchive.org</a>.
featured_quote: La compression HTTP est une technique qui permet de coder des informations en utilisant moins de bits que la représentation originale. Lorsqu’elle est utilisée pour la diffusion de contenu web, elle permet aux serveurs web de réduire la quantité de données transmises aux clients. La compression HTTP augmente l’efficacité de la bande passante disponible au client, réduit le poids des pages, et améliore les performances web.
featured_stat_1: 38 %
featured_stat_label_1: Réponses HTTP avec compression de texte
featured_stat_2: 80 %
featured_stat_label_2: Utilisent la compression Gzip
featured_stat_3: 56 %
featured_stat_label_3: Réponses HTML n'utilisant pas de compression
---

## Introduction

La compression HTTP est une technique qui permet de coder des informations en utilisant moins de bits que la représentation originale. Lorsqu’elle est utilisée pour la diffusion de contenu web, elle permet aux serveurs web de réduire la quantité de données transmises aux clients. La compression HTTP augmente l’efficacité de la bande passante disponible au client, réduit [le poids des pages](./page-weight), et améliore [les performances web](./performance).

Les algorithmes de compression sont souvent classés comme avec ou sans perte&nbsp;:

* Lorsqu’un algorithme de compression avec perte est utilisé, le processus est irréversible et le fichier original ne peut pas être restauré par décompression. Cette méthode est couramment utilisée pour comprimer les ressources medias, comme les images et les contenus vidéo, lorsque la perte de certaines données n’affecte pas sensiblement la ressource.
* La compression sans perte est un processus entièrement réversible, et est couramment utilisée pour compresser les ressources textuelles, comme [HTML](./markup), [JavaScript](./javascript), [CSS](./css), etc.

Dans ce chapitre, nous allons analyser comment le contenu textuel est compressé sur le web. L’analyse des contenus non textuels est traité dans le chapitre [Media](./media).

## Comment fonctionne la compression HTTP

Lorsqu’un client effectue une requête HTTP, celle-ci comprend souvent un en-tête [`Accept-Encoding`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Accept-Encoding) pour communiquer les algorithmes qu’il est capable de décoder. Le serveur peut alors choisir parmi eux un encodage qu’il prend en charge et servir la réponse compressée. La réponse compressée comprendra un en-tête [`Content-Encoding`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Encoding) afin que le client sache quelle compression a été utilisée. En outre, l’en-tête [`Content-Type`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Type) est souvent utilisé pour indiquer le [type MIME](https://developer.mozilla.org/docs/Web/HTTP/Basics_of_HTTP/MIME_types) de la ressource servie.

Dans l’exemple ci-dessous, le client indique supporter la compression Gzip, Brotli et deflate. Le serveur a décidé de renvoyer une réponse compressée avec Gzip contenant un document `text/html`.

```
    > GET / HTTP/1.1
    > Host: httparchive.org
    > Accept-Encoding: gzip, deflate, br

    < HTTP/1.1 200
    < Content-type: text/html; charset=utf-8
    < Content-encoding: gzip
```

HTTP Archive contient des mesures pour 5,3 millions de sites web, et chaque site a chargé au moins une ressource texte compressée sur sa page d’accueil. En outre, les ressources ont été compressées dans le domaine principal sur 81&nbsp;% des sites web.

## Algorithmes de compression

L’IANA tient à jour une <a hreflang="en" href="https://www.iana.org/assignments/http-parameters/http-parameters.xml#content-coding">liste des encodages de contenu HTTP valide</a> qui peuvent être utilisés avec les en-têtes «&nbsp;Accept-Encoding&nbsp;» et «&nbsp;Content-Encoding&nbsp;». On y retrouve notamment `gzip`, `deflate`, `br` (Brotli), ainsi que de quelques autres. De brèves descriptions de ces algorithmes sont données ci-dessous&nbsp;:

* <a hreflang="en" href="https://tools.ietf.org/html/rfc1952">Gzip</a> utilise les techniques de compression [LZ77](https://fr.wikipedia.org/wiki/LZ77_et_LZ78#LZ77) et [le codage de Huffman](https://fr.wikipedia.org/wiki/Codage_de_Huffman) qui sont plus ancienes que le web lui-même. Elles ont été développés à l’origine pour le programme `gzip` d’UNIX en 1992. Une implémentation pour la diffusion sur le web existe depuis HTTP/1.1, et la plupart des navigateurs et clients web la prennent en charge.
* <a hreflang="en" href="https://tools.ietf.org/html/rfc1951">Deflate</a> utilise le même algorithme que Gzip, mais avec un conteneur différent. Son utilisation n’a pas été largement adoptée sur le web pour des [raisons de compatibilité](https://en.wikipedia.org/wiki/HTTP_compression#Problems_preventing_the_use_of_HTTP_compression) avec d’autres serveurs et navigateurs.
* <a hreflang="en" href="https://tools.ietf.org/html/rfc7932">Brotli</a> est un algorithme de compression plus récent qui a été <a hreflang="en" href="https://github.com/google/brotli">inventé par Google</a>. Il utilise la combinaison d’une variante moderne de l’algorithme LZ77, le codage de Huffman et la modélisation du contexte du second ordre. La compression via Brotli est plus coûteuse en termes de calcul par rapport à Gzip, mais l’algorithme est capable de réduire les fichiers de <a hreflang="en" href="https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf">15-25&nbsp;%</a> de plus que la compression Gzip. Brotli a été utilisé pour la première fois pour la compression de contenu web en 2015 et est <a hreflang="en" href="https://caniuse.com/#feat=brotli">supporté par tous les navigateurs web modernes</a>.

Environ 38&nbsp;% des réponses HTTP sont fournies avec de la compression de texte. Cette statistique peut sembler surprenante, mais n’oubliez pas qu’elle est basée sur toutes les requêtes HTTP de l’ensemble de données. Certains contenus, tels que les images, ne bénéficieront pas de ces algorithmes de compression. Le tableau ci-dessous résume le pourcentage de requêtes servies pour chaque type de compression.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >Pourcentage de requêtes</th>
        <th scope="colgroup" colspan="2" >Requêtes</th>
      </tr>
      <tr>
        <th scope="col">Type de compression</th>
        <th scope="col">Ordinateur de bureau</th>
        <th scope="col">Mobile</th>
        <th scope="col">Ordinateur de bureau</th>
        <th scope="col">Ordinateur de bureau</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Pas de compression de texte</em></td>
        <td class="numeric">62,87&nbsp;%</td>
        <td class="numeric">61,47&nbsp;%</td>
        <td class="numeric">260,245,106</td>
        <td class="numeric">285,158,644</td>
      </tr>
      <tr>
        <td><code>gzip</code></td>
        <td class="numeric">29,66&nbsp;%</td>
        <td class="numeric">30,95&nbsp;%</td>
        <td class="numeric">122,789,094</td>
        <td class="numeric">143,549,122</td>
      </tr>
      <tr>
        <td><code>br</code></td>
        <td class="numeric">7.43&nbsp;%</td>
        <td class="numeric">7.55&nbsp;%</td>
        <td class="numeric">30,750,681</td>
        <td class="numeric">35,012,368</td>
      </tr>
      <tr>
        <td><code>deflate</code></td>
        <td class="numeric">0,02&nbsp;%</td>
        <td class="numeric">0,02&nbsp;%</td>
        <td class="numeric">68,802</td>
        <td class="numeric">70,679</td>
      </tr>
      <tr>
        <td><em>Autre / Invalide</em></td>
        <td class="numeric">0,02&nbsp;%</td>
        <td class="numeric">0,01&nbsp;%</td>
        <td class="numeric">67,527</td>
        <td class="numeric">68,352</td>
      </tr>
      <tr>
        <td><code>identity</code></td>
        <td class="numeric">0,000709&nbsp;%</td>
        <td class="numeric">0,000563&nbsp;%</td>
        <td class="numeric">2,935</td>
        <td class="numeric">2,611</td>
      </tr>
      <tr>
        <td><code>x-gzip</code></td>
        <td class="numeric">0,000193&nbsp;%</td>
        <td class="numeric">0,000179&nbsp;%</td>
        <td class="numeric">800</td>
        <td class="numeric">829</td>
      </tr>
      <tr>
        <td><code>compress</code></td>
        <td class="numeric">0,000008&nbsp;%</td>
        <td class="numeric">0,000007&nbsp;%</td>
        <td class="numeric">33</td>
        <td class="numeric">32</td>
      </tr>
      <tr>
        <td><code>x-compress</td>
        <td class="numeric">0,000002&nbsp;%</td>
        <td class="numeric">0,000006&nbsp;%</td>
        <td class="numeric">8</td>
        <td class="numeric">29</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Illustration 1. Adoption des algorithmes de compression.</figcaption>
</figure>

Parmi les ressources qui sont servies compressées, la majorité utilise soit Gzip (80&nbsp;%), soit Brotli (20&nbsp;%). Les autres algorithmes de compression sont peu utilisés.

{{ figure_markup(
  image="fig2.png",
  caption="Adoption des algorithmes de compression sur les pages d’ordinateur de bureau.",
  description="Diagramme circulaire du tableau de données de la figure 15.1.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2052550005&format=interactive"
  )
}}

De plus, il y a 67k requêtes qui renvoient un `Content-Encoding` invalide, tel que «&nbsp;none&nbsp;», «&nbsp;UTF-8&nbsp;», «&nbsp;base64&nbsp;», «&nbsp;text&nbsp;», etc. Ces ressources sont probablement servies sans compression.

Nous ne pouvons pas déterminer les niveaux de compression à partir des diagnostics recueillis par HTTP Archive, mais les bonnes pratiques pour compresser du contenu sont&nbsp;:

* Au minimum, activez le niveau 6 de compression Gzip pour les ressources textuelles. Cela permet un bon compromis entre le coût de calcul et le taux de compression, c'est la <a hreflang="en" href="https://paulcalvano.com/index.php/2018/07/25/brotli-compression-how-much-will-it-reduce-your-content/">valeur par défaut pour de nombreux serveurs web</a>. Toutefois [Nginx utilise  par défaut le niveau 1, c’est souvent trop bas](http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_comp_level).
* Si vous pouvez supporter Brotli et la précompression des ressources, alors compressez au niveau 11. Cette méthode est plus coûteuse en termes de calcul que Gzip - la précompression est donc absolument nécessaire pour éviter les délais.
* Si vous pouvez supporter le Brotli et que vous ne pouvez pas le précompresser, alors compressez au niveau 5. Ce niveau se traduira par un cout de compression plus petit que Gzip, avec un coût de calcul similaire.

## Quels types de contenus compressons-nous&nbsp;?

La plupart des ressources textuelles (telles que HTML, CSS et JavaScript) peuvent bénéficier de la compression Gzip ou Brotli. Cependant, il n’est souvent pas nécessaire d’utiliser ces techniques sur des ressources binaires, telles que les images, les vidéos et certaines polices Web, leurs formats de fichiers sont déjà compressés.

Dans le graphique ci-dessous, les 25 premiers types de contenus sont affichés sous forme de boîtes dont les dimensions représentent le nombre de requêtes correspondantes. La couleur de chaque boîte représente le nombre de ces ressources qui ont été servies compressées. La plupart des contenus médias sont nuancés en orange, ce qui est normal puisque Gzip et Brotli ne leur apporteraient que peu ou pas d’avantages. La plupart des contenus textuels sont nuancés en bleu pour indiquer qu’ils sont compressés. Cependant, la teinte bleu clair de certains types de contenu indique qu’ils ne sont pas compressés de manière aussi cohérente que les autres.

{{ figure_markup(
  image="fig3.png",
  caption="Les 25 principaux types de contenus compressés.",
  description="Diagramme arborescent montrant les formats image/jpeg (167 912 373 requêtes - 3,23&nbsp;% de compression), application/javascript (121 058 259 requêtes - 81,29&nbsp;% de compression), image/png (113 530 400 requêtes - 3,81&nbsp;% de compression), text/css (86 634 570 requêtes - 81,81&nbsp;% de compression), text/html (81 975 252 requêtes - 43,44&nbsp;% de compression), image/gif (70 838 761 requêtes - 3. 87&nbsp;% de compression), text/javascript (60 645 767 demandes - 89,52&nbsp;% de compression), application/x-javascript (38 816 387 demandes - 91,02&nbsp;% de compression), font/woff2 (22 622 918 demandes - 3. 87&nbsp;% de compression), application/json (16 501 326 demandes - 59,02&nbsp;% de compression), image/webp (12 911 688 demandes - 1,66&nbsp;% de compression), image/svg+xml (9 862 643 demandes - 64. 42&nbsp;% de compression), text/plain (6.622.361 demandes - 24,72&nbsp;% de compression), application/octet-stream (3.884.287 demandes - 6,01&nbsp;% de compression), image/x-icon (3 737 030 demandes - 37. 60&nbsp;% de compression), application/font-woff2 (3.061.857 demandes - 5,90&nbsp;% de compression), application/font-woff (2 117 999 demandes - 23,61&nbsp;% de compression), image/vnd.microsoft.icon (1.774.995 demandes - 15. 55&nbsp;% de compression), video/mp4 (1 472 880 requêtes - 0,03&nbsp;% de compression), font/woff (1 255 093 requêtes - 24,33&nbsp;% de compression), font/ttf (1 062 747 requêtes - 84. 27&nbsp;% de compression), application/x-font-woff (1 048 398 demandes - 30,77&nbsp;% de compression), image/jpg (951 610 demandes - 6,66&nbsp;% de compression), application/ocsp-response (883 603 demandes - 0,00&nbsp;% de compression).",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1790056981&format=interactive",
  width=780,
  height=482,
  data_width=780,
  data_height=482
  )
}}

La sélection des huit types de contenus les plus populaires nous permet de voir plus clairement les tendances de compression de ces types de contenus.

{{ figure_markup(
  image="fig4.png",
  caption="Types de contenus compressés, à l’exception des 8 premiers.",
  description="Diagramme arborescent montrant les polices/woff2 (22 622 918 demandes - 3,87&nbsp;% de compression), application/json (16 501 326 demandes - 59,02&nbsp;% de compression), image/webp (12 911 688 demandes - 1,66&nbsp;% de compression), image/svg+xml (9 862 643 demandes - 64. 42&nbsp;% de compression), text/plain (6 622 361 demandes - 24,72&nbsp;% de compression), application/octet-stream (3 884 287 demandes - 6,01&nbsp;% de compression), image/x-icon (3 737 030 demandes - 37,60&nbsp;% de compression), application/font-woff2 (3 061 857 demandes - 5. 90&nbsp;% de compression), application/font-woff (2 117 999 requêtes - 23,61&nbsp;% de compression), image/vnd.microsoft.icon (1 774 995 requêtes - 15,55&nbsp;% de compression), video/mp4 (1 472 880 requêtes - 0,03&nbsp;% de compression), font/woff (1 255 093 requêtes - 24. 33&nbsp;% de compression), font/ttf (1 062 747 demandes - 84,27&nbsp;% de compression), application/x-font-woff (1 048 398 demandes - 30,77&nbsp;% de compression), image/jpg (951 610 demandes - 6,66&nbsp;% de compression), application/ocsp-response (883 603 demandes - 0,00&nbsp;% de compression)",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=495358423&format=interactive",
  width=780,
  height=482,
  data_width=780,
  data_height=482
  )
}}

Les types de contenus `application/json` et `image/svg+xml` sont compressés moins de 65&nbsp;% du temps.

La majeure partie des polices web customisées sont servies sans compression, car elles sont déjà dans un format compressé. Cependant, `font/ttf` est compressible, mais seulement 84&nbsp;% des requêtes de polices TTF sont servies avec compression, il y a donc encore des possibilités d’amélioration dans ce domaine.

Les graphiques ci-dessous illustrent la répartition des techniques de compression utilisées pour chaque type de contenu. En examinant les trois premiers types de contenus, on constate que, tant sur les ordinateurs de bureau que sur les téléphones portables, il existe des écarts importants dans la compression de certains des types de contenus les plus fréquemment demandés. 56&nbsp;% des ressources `texte/html` ainsi que 18&nbsp;% des ressources `application/javascript` et `text/css` ne sont pas compressées. Cela représente une opportunité de performance significative.

{{ figure_markup(
  image="fig5.png",
  caption="Compression par type de contenu pour les ordinateurs de bureau.",
  description="Le graphique à barres empilées montrant l’application/javascript est de 36,18 M/8,97 M/10,47 M par type de compression (Gzip/Brotli/None), text/css est de 24,29 M/8,31 M/7,20 M, text/html est de 11,37 M/4,89 M/20,57 M, text/javascript est de 23,21 M/1,72 M/3,03 M, application/x-javascript est de 11. 86 M/4,97 M/1,66 M, application/json est 4,06 M/0,50 M/3,23 M, image/svg+xml est 2,54 M/0,46 M/1,74 M, text/plain est 0,71 M/0,06 M/2,42 M, et image/x-icon est 0,58 M/0,10 M/1,11 M. Deflate n’est presque jamais utilisé à aucun moment et ne s’inscrit pas sur la carte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=148811764&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

{{ figure_markup(
  image="fig6.png",
  caption="Compression par type de contenu pour le mobile.",
  description="Le graphique à barres empilées montrant l’application/javascript est de 43,07 M/10,17 M/12,19 M par type de compression (Gzip/Brotli/None), text/css est de 28,3 M/9,91 M/8,56 M, text/html est de 13,86 M/5,48 M/25,79 M, text/javascript est de 27. 41 M/1,94 M/3,33 M, application/x-javascript est 12,77 M/5,70 M/1,82 M, application/json est 4,67 M/0,50 M/3,53 M, image/svg+xml est 2,91 M/ 0,44 M/1,77 M, text/plain est 0,80 M/0,06 M/1,77 M, et image/x-icon est 0,62 M/0,11 M/1,22M. La fonction Deflate n’est presque jamais utilisée et ne s’inscrit pas sur la carte.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2009060762&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

Les types de contenus ayant les taux de compression les plus faibles sont `application/json`, `texte/xml` et `text/plain`. Ces ressources sont couramment utilisées pour les requêtes XHR afin de fournir des données que les applications web peuvent utiliser pour créer des expériences riches. Leur compression améliorera certainement l’expérience de l’utilisateur. Les graphiques vectoriels tels que `image/svg+xml` et `image/x-icon` ne sont pas souvent considérés comme du texte, mais ils le sont et les sites qui les utilisent bénéficieraient de la compression.

{{ figure_markup(
  image="fig7.png",
  caption="Compression par type de contenu en pourcentage pour les ordinateurs de bureau.",
  description="Le graphique à barres empilées montrant l’application/javascript est de 65,1&nbsp;%/16,1&nbsp;%/18,8&nbsp;% par type de compression (Gzip/Brotli/None), text/css est de 61,0&nbsp;%/20,9&nbsp;%/18,1&nbsp;%, text/html est de 30,9&nbsp;%/13,3&nbsp;%/55,8&nbsp;%, text/javascript est de 83,0&nbsp;%/6. 1&nbsp;%/10,8&nbsp;%, application/x-javascript est de 64,1&nbsp;%/26,9&nbsp;%/9,0&nbsp;%, application/json est de 52,1&nbsp;%/6,4&nbsp;%/41,4&nbsp;%, image/svg+xml est de 53,5&nbsp;%/9,8&nbsp;%/36,7&nbsp;%, text/plain est de 22,2&nbsp;%/2,0&nbsp;%/75,8&nbsp;%, et image/x-icon est de 32,6&nbsp;%/5,3&nbsp;%/62,1&nbsp;%. Deflate n’est presque jamais utilisé et ne s’inscrit pas sur le graphique.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1923565332&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

{{ figure_markup(
  image="fig8.png",
  caption="Compression par type de contenu en pourcentage pour les mobiles.",
  description="Le graphique à barres empilées montrant l’application/javascript est de 65,8&nbsp;%/15,5&nbsp;%/18,6&nbsp;% par type de compression (Gzip/Brotli/None), text/css est de 60,5&nbsp;%/21,2&nbsp;%/18,3&nbsp;%, text/html est de 30,7&nbsp;%/12,1&nbsp;%/57,1&nbsp;%, text/javascript est de 83,9&nbsp;%/5. 9&nbsp;%/10,2&nbsp;%, application/x-javascript est 62,9&nbsp;%/28,1&nbsp;%/9,0&nbsp;%, application/json est 53,6&nbsp;%/8,6&nbsp;%/34,6&nbsp;%, image/svg+xml est 23,4&nbsp;%/1,8&nbsp;%/74,8&nbsp;%, text/plain est 23,4&nbsp;%/1,8&nbsp;%/74,8&nbsp;%, et image/x-icon est 31,8&nbsp;%/5,5&nbsp;%/62,7&nbsp;%. Deflate n’est presque jamais utilisé et ne s’inscrit pas sur le graphique.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=673629979&format=interactive",
  width=760,
  height=470,
  data_width=760,
  data_height=470
  )
}}

Dans tous les types de contenus, Gzip est l’algorithme de compression le plus populaire. La compression Brotli, plus récente, est utilisée moins fréquemment, et les types de contenus où elle apparaît le plus sont `application/javascript`, `text/css` et `application/x-javascript`. Cela est probablement dû aux CDN qui appliquent automatiquement la compression Brotli pour le trafic qui y transite.

## Compression de première partie et tierce partie

Dans le chapitre les [tierces parties](./third-parties), nous avons appris le rôle des tiers et leur impact sur les performances. Lorsque nous comparons les techniques de compression entre les premières et les tierces parties, nous pouvons constater que le contenu des tierces parties a tendance à être plus compressé que le contenu des premières parties.

En outre, le pourcentage de compression Brotli est plus élevé pour les contenus tiers. Cela est probablement dû au nombre de ressources servies par les grands tiers qui soutiennent généralement le Brotli, comme Google et Facebook.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Ordinateur de bureau</th>
        <th scope="colgroup" colspan="2">Mobile</th>
      </tr>
      <tr>
        <th scope="col">Type de compression</th>
        <th scope="col">Première partie</th>
        <th scope="col">Tierce partie</th>
        <th scope="col">Première partie</th>
        <th scope="col">Tierce partie</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Pas de compression de texte</em></td>
        <td class="numeric">66.23&nbsp;%</td>
        <td class="numeric">59.28&nbsp;%</td>
        <td class="numeric">64.54&nbsp;%</td>
        <td class="numeric">58.26&nbsp;%</td>
      </tr>
      <tr>
        <td><code>gzip</code></td>
        <td class="numeric">29.33&nbsp;%</td>
        <td class="numeric">30.20&nbsp;%</td>
        <td class="numeric">30.87&nbsp;%</td>
        <td class="numeric">31.22&nbsp;%</td>
      </tr>
      <tr>
        <td><code>br</code></td>
        <td class="numeric">4.41&nbsp;%</td>
        <td class="numeric">10.49&nbsp;%</td>
        <td class="numeric">4.56&nbsp;%</td>
        <td class="numeric">10.49&nbsp;%</td>
      </tr>
      <tr>
        <td><code>deflate</code></td>
        <td class="numeric">0.02&nbsp;%</td>
        <td class="numeric">0.01&nbsp;%</td>
        <td class="numeric">0.02&nbsp;%</td>
        <td class="numeric">0.01&nbsp;%</td>
      </tr>
      <tr>
        <td><em>Autre / Invalide</em></td>
        <td class="numeric">0.01&nbsp;%</td>
        <td class="numeric">0.02&nbsp;%</td>
        <td class="numeric">0.01&nbsp;%</td>
        <td class="numeric">0.02&nbsp;%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Illustration 9. Compression de première partie ou de tierce partie par type d’appareil.</figcaption>
</figure>

## Identifier les possibilités de compression

L’outil Google <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a> permet aux utilisateurs d’effectuer une série d’audits sur les pages web. L’<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/text-compression">audit de la compression de texte</a> évalue si un site peut bénéficier d’une compression de texte supplémentaire. Pour ce faire, il tente de comprimer les ressources et évalue si la taille d’un objet peut être réduite d’au moins 10&nbsp;% et de 1 400 octets. En fonction du score, vous pouvez voir une recommandation de compression dans les résultats, avec une liste de ressources spécifiques qui pourraient être compressées.

{{ figure_markup(
  image="ch15_fig8_lighthouse.jpg",
  caption="Suggestions de compressions par Lighthouse.",
  description="Une capture d’écran d’un rapport Lighthouse montrant une liste de ressources (avec les noms flouté) et montrant la taille et l’économie potentielle. Pour le premier élément, il y a une économie potentiellement importante de 91 KB à 73 KB, tandis que pour d’autres fichiers plus petits de 6 KB ou moins, il y a une économie plus faible de 4 KB à 1 KB.",
  width=600,
  height=303
  )
}}

Comme [HTTP Archive effectue des audits Lighthouse](./methodology#lighthouse) pour chaque page mobile, nous pouvons agréger les scores de tous les sites pour savoir dans quelle mesure il est possible de compresser davantage le contenu. Dans l’ensemble, 62&nbsp;% des sites web ont réussi cet audit et près de 23&nbsp;% des sites web ont obtenu une note inférieure à 40. Cela signifie que plus de 1,2 million de sites web pourraient bénéficier d’une compression du texte supplémentaire.

{{ figure_markup(
  image="fig11.png",
  caption="Les résultats de l’audit «&nbsp;Activer la compression de texte&nbsp;» de Lighthouse.",
  description="Diagramme à barres empilées montrant que 7,6&nbsp;% des sites coûtent moins de 10&nbsp;%, 13,2&nbsp;% des sites ont un score compris entre 10 et 39&nbsp;%, 13,7&nbsp;% des sites ont un score compris entre 40 et 79&nbsp;%, 2,9&nbsp;% des sites ont un score compris entre 80 et 99&nbsp;%, et 62,5&nbsp;% des sites ont un laissez-passer avec plus de 100&nbsp;% des textes compressés.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2048155673&format=interactive",
  width=760,
  height=331,
  data_width=760,
  data_height=331
  )
}}

Lighthouse indique également combien d’octets pourraient être économisés en permettant la compression du texte. Parmi les sites qui pourraient bénéficier de la compression de texte, 82&nbsp;% d’entre eux peuvent réduire le poids de leur page de 1 Mo&nbsp;!

{{ figure_markup(
  image="fig12.png",
  caption="Audit Lighthouse «&nbsp;activer la compression de texte&nbsp;»: économies d’octets potentielles.",
  description="Diagramme à barres empilées montrant que 82,11&nbsp;% des sites pourraient économiser moins de 1 Mo, 15,88&nbsp;% des sites pourraient économiser 1 - 2 Mo et 2&nbsp;% des sites pourraient économiser > 3 Mo.<",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=738657382&format=interactive",
  width=760,
  height=331,
  data_width=760,
  data_height=331
  )
}}

## Conclusion

La compression HTTP est une fonctionnalité très utilisée et très précieuse pour réduire la taille des contenus web. La compression Gzip et Brotli sont les deux algorithmes les plus utilisés, et la quantité de contenu compressé varie selon le type de contenu. Des outils comme Lighthouse peuvent aider à découvrir des solutions pour comprimer le contenu.

Bien que de nombreux sites fassent bon usage de la compression HTTP, il y a encore des possibilités d’amélioration, en particulier pour le format `text/html` sur lequel le web est construit&nbsp;! De même, les formats de texte moins bien compris comme `font/ttf`, `application/json`, `text/xml`, `text/plain`, `image/svg+xml`, et `image/x-icon` peuvent nécessiter une configuration supplémentaire qui manque à de nombreux sites web.

Au minimum, les sites web devraient utiliser la compression Gzip pour toutes les ressources textuelles, car elle est largement prise en charge, facile à mettre en œuvre et a un faible coût de traitement. Des économies supplémentaires peuvent être réalisées grâce à la compression Brotli, bien que les niveaux de compression doivent être choisis avec soin en fonction de la possibilité de précompression d’une ressource.
