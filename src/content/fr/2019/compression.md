---
part_number: IV
chapter_number: 15
title: Compression
description: Chapitre sur la compression du Web Almanac 2019 couvrant la compression HTTP, les algorithmes, les types de contenu, la compression 1ere partie et tierce partie et les possibilités.
authors: [paulcalvano]
reviewers: [obto, yoavweiss]
translators: [allemas]
discuss: 1770
results: https://docs.google.com/spreadsheets/d/1IK9kaScQr_sJUwZnWMiJcmHEYJV292C9DwCfXH6a50o/
queries: 15_Compression
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-05-19T00:00:00.000Z
---

## Introduction

La compression HTTP est une technique qui permet de coder des informations en utilisant moins de bits que la représentation originale. Lorsqu'il est utilisé pour la diffusion de contenu web, il permet aux serveurs web de réduire la quantité de données transmises aux clients.
Cela augmente l'efficacité de la bande passante disponible du client, réduit [le poids des pages](./page-weight), et améliore [les performances web](./performance).

Les algorithmes de compression sont souvent classés comme perdants ou sans perte :

*  Lorsqu'un algorithme de compression est utilisé et subit des pertes, le processus est irréversible et le fichier original ne peut pas être restauré par décompression. Cette méthode est couramment utilisée pour comprimer les ressources médiatiques, telles que les images et les contenus vidéo, lorsque la perte de certaines données n'affecte pas matériellement la ressource.
*  La compression sans perte est un processus entièrement réversible, et est couramment utilisée pour comprimer les ressources textuelles, comme [HTML](./markup), [JavaScript](./javascript), [CSS](./css), etc.

Dans ce chapitre, nous allons examiner comment le contenu textuel est compressé sur le web. L'analyse des contenus non textuels fait partie de la [Media](./media).


## Comment fonctionne la compression HTTP

Lorsqu'un client effectue une requête HTTP, celle-ci comprend souvent un header [`Accept-Encoding`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Encoding) pour communiqer les algorithmes de compression qu'il est capable de décoder. Le serveur peut alors choisir l'un des codages annoncés qu'il prend en charge et servir une réponse compressée. La réponse compressée comprendra un header [`Content-Encoding`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding)  afin que le client sache quelle compression a été utilisée. En outre, un header [`Content-Type`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type) est souvent utilisé pour indiquer le [type MIME](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types) de la ressource desservie.

Dans l'exemple ci-dessous, le client indique qu'il supporte de la compression gzip, brotli et deflate et le serveur a décidé de renvoyer une réponse compressée gzip contenant un document `text/html`.

```
    > GET / HTTP/1.1
    > Host: httparchive.org
    > Accept-Encoding: gzip, deflate, br

    < HTTP/1.1 200
    < Content-type: text/html; charset=utf-8
    < Content-encoding: gzip
```

The HTTP Archive contient des mesures pour 5,3 millions de sites web, et chaque site a chargé au moins une ressource texte compressée sur sa page d'accueil. En outre, les ressources ont été compressées dans le domaine principal sur 81 % des sites web.

## Algorithmes de compression

L'IANA tient à jour une [liste des encodages de contenu HTTP valide](https://www.iana.org/assignments/http-parameters/http-parameters.xml#content-coding) qui peuvent être utilisés avec les header "Accept-Encoding" et "Content-Encoding". Il s'agit notamment de gzip, deflate, br (brotli), ainsi que de quelques autres. De brèves descriptions de ces algorithmes sont données ci-dessous :


*   [Gzip](https://tools.ietf.org/html/rfc1952) utilise les techniques de compression [LZ77](https://en.wikipedia.org/wiki/LZ77_and_LZ78#LZ77) et  [Huffman coding](https://en.wikipedia.org/wiki/Huffman_coding) qui sont plus ancienes que le web lui-même.  Il a été développé à l'origine pour le programme gzip d'UNIX en 1992. Une implémentation pour la diffusion sur le web existe depuis HTTP/1.1, et la plupart des navigateurs et clients web la prennent en charge.
*   [Deflate](https://tools.ietf.org/html/rfc1951) utilise le même algorithme que gzip, mais avec un conteneur différent. Son utilisation n'a pas été largement adoptée pour le web pour des raisons de [questions de compatibilité](https://en.wikipedia.org/wiki/HTTP_compression#Problems_preventing_the_use_of_HTTP_compression) avec d'autres serveurs et navigateurs.
*   [Brotli](https://tools.ietf.org/html/rfc7932) est un algorithme de compression plus récent qui a été [inventé par Google](https://github.com/google/brotli). Il utilise la combinaison d'une variante moderne de l'algorithme LZ77, le codage de Huffman et la modélisation du contexte du second ordre.

La compression via brotli est plus coûteuse en termes de calcul par rapport à gzip, mais l'algorithme est capable de réduire les fichiers de [15-25%](https://cran.r-project.org/web/packages/brotli/vignettes/brotli-2015-09-22.pdf) plus que la compression gzip. Brotli a été utilisé pour la première fois pour la compression de contenu web en 2015 et est [supporté par tous les navigateurs web modernes](https://caniuse.com/#feat=brotli).

Environ 38 % des réponses HTTP sont fournies avec une compression de texte. Cette statistique peut sembler surprenante, mais n'oubliez pas qu'elle est basée sur toutes les requêtes HTTP de l'ensemble de données. Certains contenus, tels que les images, ne bénéficieront pas de ces algorithmes de compression. Le tableau ci-dessous résume le pourcentage de requêtes servies avec chaque codage de contenu.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2" >Pourcentage de requêtes</th>
        <th scope="colgroup" colspan="2" >Requêtes</th>
      </tr>
      <tr>
        <th scope="col">Encodage du contenu</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Pas de compression de texte</em></td>
        <td><p style="text-align: right">62.87%</p></td>
        <td><p style="text-align: right">61.47%</p></td>
        <td><p style="text-align: right">260,245,106</p></td>
        <td><p style="text-align: right">285,158,644</p></td>
      </tr>
      <tr>
        <td>gzip</td>
        <td><p style="text-align: right">29.66%</p></td>
        <td><p style="text-align: right">30.95%</p></td>
        <td><p style="text-align: right">122,789,094</p></td>
        <td><p style="text-align: right">143,549,122</p></td>
      </tr>
      <tr>
        <td>br</td>
        <td><p style="text-align: right">7.43%</p></td>
        <td><p style="text-align: right">7.55%</p></td>
        <td><p style="text-align: right">30,750,681</p></td>
        <td><p style="text-align: right">35,012,368</p></td>
      </tr>
      <tr>
        <td>deflate</td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">68,802</p></td>
        <td><p style="text-align: right">70,679</p></td>
      </tr>
      <tr>
        <td><em>Autre / Invalide</em></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">67,527</p></td>
        <td><p style="text-align: right">68,352</p></td>
      </tr>
      <tr>
        <td>identité</td>
        <td><p style="text-align: right">0.000709%</p></td>
        <td><p style="text-align: right">0.000563%</p></td>
        <td><p style="text-align: right">2,935</p></td>
        <td><p style="text-align: right">2,611</p></td>
      </tr>
      <tr>
        <td>x-gzip</td>
        <td><p style="text-align: right">0.000193%</p></td>
        <td><p style="text-align: right">0.000179%</p></td>
        <td><p style="text-align: right">800</p></td>
        <td><p style="text-align: right">829</p></td>
      </tr>
      <tr>
        <td>compress</td>
        <td><p style="text-align: right">0.000008%</p></td>
        <td><p style="text-align: right">0.000007%</p></td>
        <td><p style="text-align: right">33</p></td>
        <td><p style="text-align: right">32</p></td>
      </tr>
      <tr>
        <td>x-compress</td>
        <td><p style="text-align: right">0.000002%</p></td>
        <td><p style="text-align: right">0.000006%</p></td>
        <td><p style="text-align: right">8</p></td>
        <td><p style="text-align: right">29</p></td>
      </tr>
    </tbody>
  </table>
  <figcaption>Illustration 1. Adoption d'algorithmes de compression.</figcaption>
</figure>

Parmi les ressources qui sont servies compressées, la majorité utilise soit gzip (80%), soit brotli (20%). Les autres algorithmes de compression sont peu utilisés.

<figure>
  <a href="/static/images/2019/compression/fig2.png">
    <img src="/static/images/2019/compression/fig2.png" alt="Illustration 2. Adoption d'algorithmes de compression sur les pages desktop." aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2052550005&amp;format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">Diagramme circulaire du tableau de données de la figure 1.</div>
  <figcaption id="fig2-caption">Illustration 2. Adoption of compression algorithms on desktop pages.</figcaption>
</figure>

De plus, il y a 67K requêtes qui renvoient un `Content-Encoding` invalide, tel que "none", "UTF-8", "base64", "text", etc. Ces ressources sont probablement servies sans compression.

Nous ne pouvons pas déterminer les niveaux de compression à partir des diagnostics recueillis par the HTTP Archive, mais la meilleure pratique pour compresser le contenu l'est :

*   Au minimum, activez le niveau 6 de compression gzip pour les ressources textuelles. Cela permet un compromis équitable entre le coût de calcul et le taux de compression et est le [par défaut pour de nombreux serveurs web](https://paulcalvano.com/index.php/2018/07/25/brotli-compression-how-much-will-it-reduce-your-content/) mais [Nginx se situe toujours par défaut au niveau 1, souvent trop bas](http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_comp_level).
*   Si vous pouvez prendre en charge  brotli et la précompression des ressources, alors compressez au niveau 11.  Cette méthode est plus coûteuse en termes de calcul que gzip - la précompression est donc absolument nécessaire pour éviter les délais.
*   Si vous pouvez supporter le brotli et que vous ne pouvez pas le précompresser, alors compressez au niveau 5. Ce niveau se traduira par des charges utiles plus petites que celles de gzip, avec un surcoût de calcul similaire.

## Quels types de contenus compressons-nous ?

La plupart des ressources textuelles (telles que HTML, CSS et JavaScript) peuvent bénéficier de la compression gzip ou brotli.
Cependant, il n'est souvent pas nécessaire d'utiliser ces techniques de compression sur des ressources binaires, telles que les images, les vidéos et certaines polices Web, car leurs formats de fichiers sont déjà compressés.

Dans le graphique ci-dessous, les 25 premiers types de contenu sont affichés avec des tailles de boîte représentant le nombre relatif de demandes.
La couleur de chaque boîte représente le nombre de ces ressources qui ont été servies compressées. La plupart des contenus médiatiques sont ombragés en orange, ce qui est attendu puisque gzip et brotli n'auraient que peu ou pas d'avantages pour eux. La plupart des contenus textuels sont ombrés en bleu pour indiquer qu'ils sont en cours de compression. Cependant, l'ombrage bleu clair de certains types de contenu indique qu'ils ne sont pas compressés de manière aussi cohérente que les autres.


<figure>
  <a href="/static/images/2019/compression/fig3.png">
    <img src="/static/images/2019/compression/fig3.png" alt="Illustration 3. Les 25 principaux types de contenus compressés." aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="780" height="482" data-width="780" data-height="482" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1790056981&amp;format=interactive">
  </a>
  <div id="fig3-description" class="visually-hidden">Diagramme arborescent montrant les formats image/jpeg (167 912 373 requêtes - 3,23 % de compression), application/javascript (121 058 259 requêtes - 81,29 % de compression), image/png (113 530 400 requêtes - 3,81 % de compression), text/css (86 634 570 requêtes - 81,81 % de compression), text/html (81 975 252 requêtes - 43,44 % de compression), image/gif (70 838 761 requêtes - 3. 87% de compression), text/javascript (60 645 767 demandes - 89,52% de compression), application/x-javascript (38 816 387 demandes - 91,02% de compression), font/woff2 (22 622 918 demandes - 3. 87 % de compression), application/json (16 501 326 demandes - 59,02 % de compression), image/webp (12 911 688 demandes - 1,66 % de compression), image/svg+xml (9 862 643 demandes - 64. 42% de compression), texte/plain (6.622.361 demandes - 24,72% de compression), application/octet-stream (3.884.287 demandes - 6,01% de compression), image/x-icon (3.737.030 demandes - 37. 60% de compression), application/font-woff2 (3.061.857 demandes - 5,90% de compression), application/font-woff (2.117.999 demandes - 23,61% de compression), image/vnd.microsoft.icon (1.774.995 demandes - 15. 55% de compression), video/mp4 (1 472 880 requêtes - 0,03% de compression), font/woff (1 255 093 requêtes - 24,33% de compression), font/ttf (1 062 747 requêtes - 84. 27% de compression), application/x-font-woff (1 048 398 demandes - 30,77% de compression), image/jpg (951 610 demandes - 6,66% de compression), application/ocsp-response (883 603 demandes - 0,00% de compression).</div>
  <figcaption id="fig3-caption">Illustration 3. Les 25 principaux types de contenus compressés.</figcaption>
</figure>

Le filtrage des huit types de contenu les plus populaires nous permet de voir plus clairement les statistiques de compression pour le reste de ces types de contenu.

<figure>
  <a href="/static/images/2019/compression/fig4.png">
    <img src="/static/images/2019/compression/fig4.png" alt="Illustration 4. Types de contenus compressés, à l'exception des 8 premiers." aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="780" height="482" data-width="780" data-height="482" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=495358423&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">Diagramme arborescent montrant les polices/woff2 (22 622 918 demandes - 3,87% de compression), application/json (16 501 326 demandes - 59,02% de compression), image/webp (12 911 688 demandes - 1,66% de compression), image/svg+xml (9 862 643 demandes - 64. 42% de compression), texte/plain (6 622 361 demandes - 24,72% de compression), application/octet-stream (3 884 287 demandes - 6,01% de compression), image/x-icon (3 737 030 demandes - 37,60% de compression), application/font-woff2 (3 061 857 demandes - 5. 90% de compression), application/font-woff (2 117 999 requêtes - 23,61% de compression), image/vnd.microsoft.icon (1 774 995 requêtes - 15,55% de compression), video/mp4 (1 472 880 requêtes - 0,03% de compression), font/woff (1 255 093 requêtes - 24. 33% de compression), font/ttf (1 062 747 demandes - 84,27% de compression), application/x-font-woff (1 048 398 demandes - 30,77% de compression), image/jpg (951 610 demandes - 6,66% de compression), application/ocsp-response (883 603 demandes - 0,00% de compression)</div>
  <figcaption id="fig4-caption">Illustration 4. Types de contenus compressés, à l' exception des 8 premiers.</figcaption>
</figure>

Les types de contenu `application/json` et `image/svg+xml` sont compressés moins de 65% du temps.

La plupart des polices web personnalisées sont servies sans compression, car elles sont déjà dans un format compressé. Cependant, `font/ttf` est compressible, mais seulement 84% des demandes de polices TTF sont servies avec compression, donc il y a encore de la place pour l'amélioration ici.

Les graphiques ci-dessous illustrent la répartition des techniques de compression utilisées pour chaque type de contenu. En examinant les trois premiers types de contenu, on constate que, tant sur les ordinateurs de bureau que sur les téléphones portables, il existe des lacunes importantes dans la compression de certains des types de contenu les plus fréquemment demandés. 56% des ressources `texte/html` ainsi que 18% des ressources `application/javascript` et `texte/css` ne sont pas compressées. Cela représente une opportunité de performance significative.

<figure>
  <a href="/static/images/2019/compression/fig5.png">
    <img src="/static/images/2019/compression/fig5.png" alt="Illustration 5. Compression par type de contenu pour les ordinateurs de bureau." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=148811764&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">Le graphique à barres empilées montrant l'application/javascript est de 36,18 M/8,97 M/10,47 M par type de compression (Gzip/Brotli/None), text/css est de 24,29 M/8,31 M/7,20 M, text/html est de 11,37 M/4,89 M/20,57 M, text/javascript est de 23,21 M/1,72 M/3,03 M, application/x-javascript est de 11. 86 M/4,97 M/1,66 M, application/json est 4,06 M/0,50 M/3,23 M, image/svg+xml est 2,54 M/0,46 M/1,74 M, texte/plain est 0,71 M/0,06 M/2,42 M, et image/x-icon est 0,58 M/0,10 M/1,11 M. Deflate n'est presque jamais utilisé à aucun moment et ne s'inscrit pas sur la carte.</div>
  <figcaption id="fig5-caption">Illustration 5. Compression par type de contenu pour les ordinateurs de bureau.</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/compression/fig6.png">
    <img src="/static/images/2019/compression/fig6.png" alt="Illustration 6. Compression par type de contenu pour le mobile." aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2009060762&amp;format=interactive">
  </a>
  <div id="fig6-description" class="visually-hidden">Le graphique à barres empilées montrant l'application/javascript est de 43,07 M/10,17 M/12,19 M par type de compression (Gzip/Brotli/None), text/css est de 28,3 M/9,91 M/8,56 M, text/html est de 13,86 M/5,48 M/25,79 M, text/javascript est de 27. 41 M/1,94 M/3,33 M, application/x-javascript est 12,77 M/5,70 M/1,82 M, application/json est 4,67 M/0,50 M/3,53 M, image/svg+xml est 2,91 M/ 0,44 M/1,77 M, texte/plain est 0,80 M/0,06 M/1,77 M, et image/x-icon est 0,62 M/0,11 M/1,22M. La fonction Deflate n'est presque jamais utilisée et ne s'inscrit pas sur la carte.</div>
  <figcaption id="fig6-caption">Illustration 6. Compression par type de contenu pour le mobile.</figcaption>
</figure>

Les types de contenu ayant les taux de compression les plus faibles sont `application/json`, `texte/xml` et `texte/plain`. Ces ressources sont couramment utilisées pour les requêtes XHR afin de fournir des données que les applications web peuvent utiliser pour créer des expériences riches. Leur compression améliorera certainement l'expérience de l'utilisateur.  Les graphiques vectoriels tels que `image/svg+xml` et `image/x-icon` ne sont pas souvent considérés comme du texte, mais ils le sont et les sites qui les utilisent bénéficieraient de la compression.

<figure>
    <a href="/static/images/2019/compression/fig7.png">
    <img src="/static/images/2019/compression/fig7.png" alt="Illustration 7. Compression par type de contenu en pourcentage pour les ordinateurs de bureau." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1923565332&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">Le graphique à barres empilées montrant l'application/javascript est de 65,1 %/16,1 %/18,8 % par type de compression (Gzip/Brotli/None), text/css est de 61,0 %/20,9 %/18,1 %, text/html est de 30,9 %/13,3 %/55,8 %, text/javascript est de 83,0 %/6. 1%/10,8%, application/x-javascript est de 64,1%/26,9%/9,0%, application/json est de 52,1%/6,4%/41,4%, image/svg+xml est de 53,5%/9,8%/36,7%, texte/plain est de 22,2%/2,0%/75,8%, et image/x-icon est de 32,6%/5,3%/62,1%. Deflate n'est presque jamais utilisé et ne s'inscrit pas sur le graphique.</div>
  <figcaption id="fig7-caption">Illustration 7. Compression par type de contenu en pourcentage pour les ordinateurs de bureau.</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/compression/fig8.png">
    <img src="/static/images/2019/compression/fig8.png" alt="Illustration 8. Compression par type de contenu en pourcentage pour les mobiles." aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=673629979&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">Le graphique à barres empilées montrant l'application/javascript est de 65,8%/15,5%/18,6% par type de compression (Gzip/Brotli/None), text/css est de 60,5%/21,2%/18,3%, text/html est de 30,7%/12,1%/57,1%, text/javascript est de 83,9%/5. 9 %/10,2 %, application/x-javascript est 62,9 %/28,1 %/9,0 %, application/json est 53,6 %/8,6 %/34,6 %, image/svg+xml est 23,4 %/1,8 %/74,8 %, texte/plain est 23,4 %/1,8 %/74,8 %, et image/x-icon est 31,8 %/5,5 %/62,7 %. Deflate n'est presque jamais utilisé et ne s'inscrit pas sur le graphique.</div>
  <figcaption id="fig8-caption">Illustration 8. Compression par type de contenu en pourcentage pour les mobiles.</figcaption>
</figure>

Dans tous les types de contenu, gzip est l'algorithme de compression le plus populaire. La compression brotli, plus récente, est utilisée moins fréquemment, et les types de contenu où elle apparaît le plus sont `application/javascript`, `texte/css` et `application/x-javascript`. Cela est probablement dû aux CDN qui appliquent automatiquement la compression brotli pour le trafic qui passe par eux.

## Compression de première partie et tierce partie

Dans le chapitre les [tierces parties](./third-parties), nous avons appris à connaître les tiers et leur impact sur les performances. Lorsque nous comparons les techniques de compression entre les premières et les tierces parties, nous pouvons constater que le contenu des tierces parties a tendance à être plus compressé que le contenu des premières parties.

En outre, le pourcentage de compression du brotli est plus élevé pour les contenus tiers. Cela est probablement dû au nombre de ressources servies par les grands tiers qui soutiennent généralement le brotli, comme Google et Facebook.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Ordinateur de bureau</th>
        <th scope="colgroup" colspan="2">Mobile</th>
      </tr>
      <tr>
        <th scope="col">Encodage du contenu</th>
        <th scope="col">Première partie</th>
        <th scope="col">Tierce partie</th>
        <th scope="col">Première partie</th>
        <th scope="col">Tierce partie</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>Pas de compression de texte</em></td>
        <td><p style="text-align: right">66.23%</p></td>
        <td><p style="text-align: right">59.28%</p></td>
        <td><p style="text-align: right">64.54%</p></td>
        <td><p style="text-align: right">58.26%</p></td>
      </tr>
      <tr>
        <td>gzip</td>
        <td><p style="text-align: right">29.33%</p></td>
        <td><p style="text-align: right">30.20%</p></td>
        <td><p style="text-align: right">30.87%</p></td>
        <td><p style="text-align: right">31.22%</p></td>
      </tr>
      <tr>
        <td>br</td>
        <td><p style="text-align: right">4.41%</p></td>
        <td><p style="text-align: right">10.49%</p></td>
        <td><p style="text-align: right">4.56%</p></td>
        <td><p style="text-align: right">10.49%</p></td>
      </tr>
      <tr>
        <td>deflate</td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
      </tr>
      <tr>
        <td><em>Autre / Invalide</em></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
      </tr>
    </tbody>
  </table>
  <figcaption>Illustration 9. Compression de première partie ou de tierce partie par type de dispositif.</figcaption>
</figure>

## Identifier les possibilités de compression

L'outil Google [Lighthouse](https://developers.google.com/web/tools/lighthouse)  permet aux utilisateurs d'effectuer une série d'audits sur les pages web. L'[audit de la compression de texte](https://developers.google.com/web/tools/lighthouse/audits/text-compression) évalue si un site peut bénéficier d'une compression de texte supplémentaire. Pour ce faire, il tente de comprimer les ressources et évalue si la taille d'un objet peut être réduite d'au moins 10 % et de 1 400 octets. En fonction du score, vous pouvez voir une recommandation de compression dans les résultats, avec une liste de ressources spécifiques qui pourraient être compressées.

<figure>
  <a href="/static/images/2019/compression/ch15_fig8_lighthouse.jpg">
    <img src="/static/images/2019/compression/ch15_fig8_lighthouse.jpg" alt="Illustration 10. Lighthouse compression suggestions" aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="303">
  </a>
  <div id="fig10-description" class="visually-hidden">A screenshot of a Lighthouse report showing a list of resources (with the names redacted) and showing the size and the potential saving. For the first item there is a potentially significant saving from 91 KB to 73 KB, while for other smaller files of 6 KB or less there are smaller savings of 4 KB to 1 KB.</div>
  <figcaption id="fig10-caption">Illustration 10. Lighthouse compression suggestions.</figcaption>
</figure>

Comme [HTTP Archive effectue des audits Lighthouse](./methodology#lighthouse) pour chaque page mobile, nous pouvons agréger les scores de tous les sites pour savoir dans quelle mesure il est possible de comprimer davantage de contenu. Dans l'ensemble, 62 % des sites web ont réussi cet audit et près de 23 % des sites web ont obtenu une note inférieure à 40. Cela signifie que plus de 1,2 million de sites web pourraient bénéficier d'une compression du texte supplémentaire .

<figure>
  <a href="/static/images/2019/compression/fig11.png">
    <img src="/static/images/2019/compression/fig11.png" alt="Illustration 11. Lighthouse 'enable text compression' audit scores." aria-labelledby="fig11-caption" aria-describedby="fig11-description" width="760" height="331" data-width="760" data-height="331" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2048155673&amp;format=interactive">
  </a>
  <div id="fig11-description" class="visually-hidden">Stacked bar chart showing 7.6% are cosing less than 10%, 13.2% of sites are scoring between 10-39%, 13.7% of sites scoring between 40-79%, 2.9% os sites scoring between 80-99%, and 62.5% of sites have a pass with over 100% of text assets being compressed.</div>
  <figcaption id="fig11-caption">Illustration 11. Lighthouse "enable text compression" audit scores.</figcaption>
</figure>

Lighthouse indique également combien d'octets pourraient être sauvegardés en permettant la compression de texte. Parmi les sites qui pourraient bénéficier de la compression de texte, 82 % d'entre eux peuvent réduire le poids de leur page de 1 Mo !

<figure>
  <a href="/static/images/2019/compression/fig12.png">
    <img src="/static/images/2019/compression/fig12.png" alt="Illustration 12. Lighthouse 'enable text compression' audit potential byte savings." aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="760" height="331" data-width="760" data-height="331" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=738657382&amp;format=interactive">
  </a>
  <div id="fig12-description" class="visually-hidden">Stacked bar chart showing 82.11% of sites could save less than 1 Mb, 15.88% of sites could save 1 - 2 Mb and 2% of sites could save > 3 MB.</div>
  <figcaption id="fig12-caption">Illustration 12. Lighthouse "enable text compression" audit potential byte savings.</figcaption>
</figure>

## Conclusion

La compression HTTP est une fonctionnalité très utilisée et très précieuse pour réduire la taille des contenus web. La compression gzip et brotli sont les deux algorithmes dominants utilisés, et la quantité de contenu compressé varie selon le type de contenu. Des outils comme Lighthouse peuvent aider à découvrir des possibilités de compression de contenu.

Bien que de nombreux sites fassent bon usage de la compression HTTP, il y a encore des possibilités d'amélioration, en particulier pour le format `text/html` sur lequel le web est construit ! De même, les formats de texte moins bien compris comme `font/ttf`, `application/json`, `text/xml`, `text/plain`, `image/svg+xml`, et `image/x-icon` peuvent nécessiter une configuration supplémentaire que de nombreux sites web ne peuvent pas utiliser.

Au minimum, les sites web devraient utiliser la compression gzip pour toutes les ressources textuelles, car elle est largement soutenue, facile à mettre en œuvre et a une faible charge de traitement. Des économies supplémentaires peuvent être réalisées grâce à la compression brotli, bien que les niveaux de compression doivent être choisis avec soin en fonction de la possibilité de précompression d'une ressource.
