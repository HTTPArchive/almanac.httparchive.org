---
part_number: IV
chapter_number: 15
title: Compression
description: Compression chapter of the 2019 Web Almanac covering HTTP compression, algorithms, content types, 1st party and 3rd party compression and opportunities.
authors: [paulcalvano]
reviewers: [obto, yoavweiss]
translators: [allemas]
translators: []
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
        <th scope="colgroup" colspan="2" >Percent of Requests</th>
        <th scope="colgroup" colspan="2" >Requests</th>
      </tr>
      <tr>
        <th scope="col">Content Encoding</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
        <th scope="col">Desktop</th>
        <th scope="col">Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>No Text Compression</em></td>
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
        <td><em>Other / Invalid</em></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">67,527</p></td>
        <td><p style="text-align: right">68,352</p></td>
      </tr>
      <tr>
        <td>identity</td>
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
  <figcaption>Figure 1. Adoption d'algorithmes de compression.</figcaption>
</figure>

Parmi les ressources qui sont servies compressées, la majorité utilise soit gzip (80%), soit brotli (20%). Les autres algorithmes de compression sont peu utilisés.

<figure>
  <a href="/static/images/2019/compression/fig2.png">
    <img src="/static/images/2019/compression/fig2.png" alt="Figure 2. Adoption d'algorithmes de compression sur les pages desktop." aria-labelledby="fig2-caption" aria-describedby="fig2-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2052550005&amp;format=interactive">
  </a>
  <div id="fig2-description" class="visually-hidden">Pie chart of the data table in Figure 1.</div>
  <figcaption id="fig2-caption">Figure 2. Adoption of compression algorithms on desktop pages.</figcaption>
</figure>

De plus, il y a 67K requetes qui renvoient un `Content-Encoding` invalide, tel que "none", "UTF-8", "base64", "text", etc. Ces ressources sont probablement servies sans compression.

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
    <img src="/static/images/2019/compression/fig3.png" alt="Figure 3. Top 25 compressed content types." aria-labelledby="fig3-caption" aria-describedby="fig3-description" width="780" height="482" data-width="780" data-height="482" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1790056981&amp;format=interactive">
  </a>
  <div id="fig3-description" class="visually-hidden">Treemap chart showing image/jpeg (167,912,373 requests - 3.23% compressed), application/javascript (121,058,259 requests - 81.29% compressed), image/png (113,530,400 requests - 3.81% compressed), text/css (86,634,570 requests - 81.81% compressed), text/html (81,975,252 requests - 43.44% compressed), image/gif (70,838,761 requests - 3.87% compressed), text/javascript (60,645,767 requests - 89.52% compressed), application/x-javascript (38,816,387 requests - 91.02% compressed), font/woff2 (22,622,918 requests - 3.87% compressed), application/json (16,501,326 requests - 59.02% compressed), image/webp (12,911,688 requests - 1.66% compressed), image/svg+xml (9,862,643 requests - 64.42% compressed), text/plain (6,622,361 requests - 24.72% compressed), application/octet-stream (3,884,287 requests - 6.01% compressed), image/x-icon (3,737,030 requests - 37.60% compressed), application/font-woff2 (3,061,857 requests - 5.90% compressed), application/font-woff (2,117,999 requests - 23.61% compressed), image/vnd.microsoft.icon (1,774,995 requests - 15.55% compressed), video/mp4 (1,472,880 requests - 0.03% compressed), font/woff (1,255,093 requests - 24.33% compressed), font/ttf (1,062,747 requests - 84.27% compressed), application/x-font-woff (1,048,398 requests - 30.77% compressed), image/jpg (951,610 requests - 6.66% compressed), application/ocsp-response (883,603 requests - 0.00% compressed).</div>
  <figcaption id="fig3-caption">Figure 3. Top 25 compressed content types.</figcaption>
</figure>

Filtering out the eight most popular content types allows us to see the compression stats for the rest of these content types more clearly.

<figure>
  <a href="/static/images/2019/compression/fig4.png">
    <img src="/static/images/2019/compression/fig4.png" alt="Figure 4. Compressed content types, excluding top 8." aria-labelledby="fig4-caption" aria-describedby="fig4-description" width="780" height="482" data-width="780" data-height="482" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=495358423&amp;format=interactive">
  </a>
  <div id="fig4-description" class="visually-hidden">Treemap chart showing font/woff2 (22,622,918 requests - 3.87% compressed), application/json (16,501,326 requests - 59.02% compressed), image/webp (12,911,688 requests - 1.66% compressed), image/svg+xml (9,862,643 requests - 64.42% compressed), text/plain (6,622,361 requests - 24.72% compressed), application/octet-stream (3,884,287 requests - 6.01% compressed), image/x-icon (3,737,030 requests - 37.60% compressed), application/font-woff2 (3,061,857 requests - 5.90% compressed), application/font-woff (2,117,999 requests - 23.61% compressed), image/vnd.microsoft.icon (1,774,995 requests - 15.55% compressed), video/mp4 (1,472,880 requests - 0.03% compressed), font/woff (1,255,093 requests - 24.33% compressed), font/ttf (1,062,747 requests - 84.27% compressed), application/x-font-woff (1,048,398 requests - 30.77% compressed), image/jpg (951,610 requests - 6.66% compressed), application/ocsp-response (883,603 requests - 0.00% compressed)</div>
  <figcaption id="fig4-caption">Figure 4. Compressed content types, excluding top 8.</figcaption>
</figure>

The `application/json` and `image/svg+xml` content types are compressed less than 65% of the time.

Most of the custom web fonts are served without compression, since they are already in a compressed format. However, `font/ttf` is compressible, but only 84% of TTF font requests are being served with compression so there is still room for improvement here.

The graphs below illustrate the breakdown of compression techniques used for each content type. Looking at the top three content types, we can see that across both desktop and mobile there are major gaps in compressing some of the most frequently requested content types. 56% of `text/html` as well as 18% of `application/javascript` and `text/css` resources are not being compressed. This presents a significant performance opportunity.

<figure>
  <a href="/static/images/2019/compression/fig5.png">
    <img src="/static/images/2019/compression/fig5.png" alt="Figure 5. Compression by content type for desktop." aria-labelledby="fig5-caption" aria-describedby="fig5-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=148811764&amp;format=interactive">
  </a>
  <div id="fig5-description" class="visually-hidden">Stacked bar chart showing application/javascript is 36.18 Million/8.97 Million/10.47 Million by compression type (Gzip/Brotli/None), text/css is 24.29 M/8.31 M/7.20 M, text/html is 11.37 M/4.89 M/20.57 M, text/javascript is 23.21 M/1.72 M/3.03 M, application/x-javascript is 11.86 M/4.97 M/1.66 M, application/json is 4.06 M/0.50 M/3.23 M, image/svg+xml is 2.54 M/0.46 M/1.74 M, text/plain is 0.71 M/0.06 M/2.42 M, and image/x-icon is 0.58 M/0.10 M/1.11 M. Deflate is almost never used by any time and does not register on the chart..</div>
  <figcaption id="fig5-caption">Figure 5. Compression by content type for desktop.</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/compression/fig6.png">
    <img src="/static/images/2019/compression/fig6.png" alt="Figure 6. Compression by content type for mobile." aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2009060762&amp;format=interactive">
  </a>
  <div id="fig6-description" class="visually-hidden">Stacked bar chart showing application/javascript is 43.07 Million/10.17 Million/12.19 Million by compression type (Gzip/Brotli/None), text/css is 28.3 M/9.91 M/8.56 M, text/html is 13.86 M/5.48 M/25.79 M, text/javascript is 27.41 M/1.94 M/3.33 M, application/x-javascript is 12.77 M/5.70 M/1.82 M, application/json is 4.67 M/0.50 M/3.53 M, image/svg+xml is 2.91 M/ 0.44 M/1.77 M, text/plain is 0.80 M/0.06 M/1.77 M, and image/x-icon is 0.62 M/0.11 M/1.22M. Deflate is almost never used by any time and does not register on the chart.</div>
  <figcaption id="fig6-caption">Figure 6. Compression by content type for mobile.</figcaption>
</figure>

The content types with the lowest compression rates include `application/json`, `text/xml`, and `text/plain`. These resources are commonly used for XHR requests to provide data that web applications can use to create rich experiences. Compressing them will likely improve user experience.  Vector graphics such as `image/svg+xml`, and `image/x-icon` are not often thought of as text based, but they are and sites that use them would benefit from compression.

<figure>
    <a href="/static/images/2019/compression/fig7.png">
    <img src="/static/images/2019/compression/fig7.png" alt="Figure 7. Compression by content type as a percent for desktop." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=1923565332&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">Stacked bar chart showing application/javascript is 65.1%/16.1%/18.8% by compression type (Gzip/Brotli/None), text/css is 61.0%/20.9%/18.1%, text/html is 30.9%/13.3%/55.8%, text/javascript is 83.0%/6.1%/10.8%, application/x-javascript is 64.1%/26.9%/9.0%, application/json is 52.1%/6.4%/41.4%, image/svg+xml is 53.5%/9.8%/36.7%, text/plain is 22.2%/2.0%/75.8%, and image/x-icon is 32.6%/5.3%/62.1%. Deflate is almost never used by any time and does not register on the chart.</div>
  <figcaption id="fig7-caption">Figure 7. Compression by content type as a percent for desktop.</figcaption>
</figure>

<figure>
  <a href="/static/images/2019/compression/fig8.png">
    <img src="/static/images/2019/compression/fig8.png" alt="Figure 8. Compression by content type as a percent for mobile." aria-labelledby="fig6-caption" aria-describedby="fig6-description" width="760" height="470" data-width="760" data-height="470" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=673629979&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">Stacked bar chart showing application/javascript is 65.8%/15.5%/18.6% by compression type (Gzip/Brotli/None), text/css is 60.5%/21.2%/18.3%, text/html is 30.7%/12.1%/57.1%, text/javascript is 83.9%/5.9%/10.2%, application/x-javascript is 62.9%/28.1%/9.0%, application/json is 53.6%/8.6%/34.6%, image/svg+xml is 23.4%/1.8%/74.8%, text/plain is 23.4%/1.8%/74.8%, and image/x-icon is 31.8%/5.5%/62.7%. Deflate is almost never used by any time and does not register on the chart.</div>
  <figcaption id="fig8-caption">Figure 8. Compression by content type as a percent for mobile.</figcaption>
</figure>

Across all content types, gzip is the most popular compression algorithm. The newer brotli compression is used less frequently, and the content types where it appears most are `application/javascript`, `text/css` and `application/x-javascript`. This is likely due to CDNs that automatically apply brotli compression for traffic that passes through them.

## First-party vs third-party compression

In the [Third Parties](./third-parties) chapter, we learned about third parties and their impact on performance. When we compare compression techniques between first and third parties, we can see that third-party content tends to be compressed more than first-party content.

Additionally, the percentage of brotli compression is higher for third-party content. This is likely due to the number of resources served from the larger third parties that typically support brotli, such as Google and Facebook.

<figure>
  <table>
    <thead>
      <tr>
        <td></td>
        <th scope="colgroup" colspan="2">Desktop</th>
        <th scope="colgroup" colspan="2">Mobile</th>
      </tr>
      <tr>
        <th scope="col">Content Encoding</th>
        <th scope="col">First-Party</th>
        <th scope="col">Third-Party</th>
        <th scope="col">First-Party</th>
        <th scope="col">Third-Party</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><em>No Text Compression</em></td>
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
        <td><em>Other / Invalid</em></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
        <td><p style="text-align: right">0.01%</p></td>
        <td><p style="text-align: right">0.02%</p></td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 9. First-party versus third-party compression by device type.</figcaption>
</figure>

## Identifying compression opportunities

Google's [Lighthouse](https://developers.google.com/web/tools/lighthouse) tool enables users to run a series of audits against web pages. The [text compression audit](https://developers.google.com/web/tools/lighthouse/audits/text-compression) evaluates whether a site can benefit from additional text-based compression. It does this by attempting to compress resources and evaluate whether an object's size can be reduced by at least 10% and 1,400 bytes. Depending on the score, you may see a compression recommendation in the results, with a list of specific resources that could be compressed.

<figure>
  <a href="/static/images/2019/compression/ch15_fig8_lighthouse.jpg">
    <img src="/static/images/2019/compression/ch15_fig8_lighthouse.jpg" alt="Figure 10. Lighthouse compression suggestions" aria-labelledby="fig10-caption" aria-describedby="fig10-description" width="600" height="303">
  </a>
  <div id="fig10-description" class="visually-hidden">A screenshot of a Lighthouse report showing a list of resources (with the names redacted) and showing the size and the potential saving. For the first item there is a potentially significant saving from 91 KB to 73 KB, while for other smaller files of 6 KB or less there are smaller savings of 4 KB to 1 KB.</div>
  <figcaption id="fig10-caption">Figure 10. Lighthouse compression suggestions.</figcaption>
</figure>

Because the [HTTP Archive runs Lighthouse audits](./methodology#lighthouse) for each mobile page, we can aggregate the scores across all sites to learn how much opportunity there is to compress more content. Overall, 62% of websites are passing this audit and almost 23% of websites have scored below a 40. This means that over 1.2 million websites could benefit from enabling additional text based compression.

<figure>
  <a href="/static/images/2019/compression/fig11.png">
    <img src="/static/images/2019/compression/fig11.png" alt="Figure 11. Lighthouse 'enable text compression' audit scores." aria-labelledby="fig11-caption" aria-describedby="fig11-description" width="760" height="331" data-width="760" data-height="331" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=2048155673&amp;format=interactive">
  </a>
  <div id="fig11-description" class="visually-hidden">Stacked bar chart showing 7.6% are cosing less than 10%, 13.2% of sites are scoring between 10-39%, 13.7% of sites scoring between 40-79%, 2.9% os sites scoring between 80-99%, and 62.5% of sites have a pass with over 100% of text assets being compressed.</div>
  <figcaption id="fig11-caption">Figure 11. Lighthouse "enable text compression" audit scores.</figcaption>
</figure>

Lighthouse also indicates how many bytes could be saved by enabling text-based compression. Of the sites that could benefit from text compression, 82% of them can reduce their page weight by up to 1 MB!

<figure>
  <a href="/static/images/2019/compression/fig12.png">
    <img src="/static/images/2019/compression/fig12.png" alt="Figure 12. Lighthouse 'enable text compression' audit potential byte savings." aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="760" height="331" data-width="760" data-height="331" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQNIyMEGYE_1W0OdFYLIKsxg6M3o_ZsTTuaX73Zzv6Alw4x4D6oH0jdg9BSgw-jy4E-MmX_Qaf-B98W/pubchart?oid=738657382&amp;format=interactive">
  </a>
  <div id="fig12-description" class="visually-hidden">Stacked bar chart showing 82.11% of sites could save less than 1 Mb, 15.88% of sites could save 1 - 2 Mb and 2% of sites could save > 3 MB.</div>
  <figcaption id="fig12-caption">Figure 12. Lighthouse "enable text compression" audit potential byte savings.</figcaption>
</figure>

## Conclusion

HTTP compression is a widely used and highly valuable feature for reducing the size of web content. Both gzip and brotli compression are the dominant algorithms used, and the amount of compressed content varies by content type. Tools like Lighthouse can help uncover opportunities to compress content.

While many sites are making good use of HTTP compression, there is still room for improvement, particularly for the `text/html` format that the web is built upon! Similarly, lesser-understood text formats like `font/ttf`, `application/json`, `text/xml`, `text/plain`, `image/svg+xml`, and `image/x-icon` may take extra configuration that many websites miss.

At a minimum, websites should use gzip compression for all text-based resources, since it is widely supported, easily implemented, and has a low processing overhead. Additional savings can be found with brotli compression, although compression levels should be chosen carefully based on whether a resource can be precompressed.
