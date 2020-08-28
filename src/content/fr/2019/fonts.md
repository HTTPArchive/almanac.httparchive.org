---
part_number: I
chapter_number: 6
title: Polices d'écriture
description: Chapitre Polices d'écriture du web Almanac 2019 couvrant l'endroit d'où les polices sont chargées, les formats de police, la performance de leur chargement, les polices variables et les polices de couleur. 
authors: [zachleat]
reviewers: [hyperpress, AymenLoukil]
translators: [arigaud-ca]
discuss: 1761
results: https://docs.google.com/spreadsheets/d/108g6LXdC3YVsxmX1CCwrmpZ3-DmbB8G_wwgQHX5pn6Q/
queries: 06_Fonts
published: 2019-11-11T00:00:00.000Z
last_updated: 2020-03-02T00:00:00.000Z
---

## Introduction

Les polices Web permettent une typographie belle et fonctionnelle sur le web. L'utilisation des polices Web permet non seulement de renforcer le design, mais aussi de démocratiser un sous-ensemble du design, car elle permet un accès plus facile à ceux qui n'ont pas forcément de solides compétences en matière de design. Cependant, malgré tout le bien qu'elles peuvent faire, les polices web peuvent également nuire considérablement aux performances de votre site si elles ne sont pas chargées correctement.

Sont-elles un atout pour le web ? Offrent-elles plus d'avantages que d'inconvénients ? Les sentiers des standards du web sont-ils suffisamment pavés pour encourager les meilleures pratiques de chargement des polices web par défaut ? Et si ce n'est pas le cas, que faut-il changer ? Voyons si nous pouvons répondre à ces questions en examinant comment les polices de caractères sont utilisées sur le web aujourd'hui.

## Où avez-vous obtenu ces polices de caractères pour le web ?

La première et la plus importante question : la performance. Un chapitre entier est consacré à la [performance](./performance), mais nous allons ici approfondir un peu les questions de performance spécifiques aux polices.

L'utilisation de polices web hébergées permet une mise en œuvre et une maintenance faciles, mais l'auto-hébergement offre les meilleures performances. Étant donné que les polices web par défaut rendent le texte invisible pendant le chargement de la police web (également connu sous le nom de [Flash of Invisible Text](https://css-tricks.com/fout-foit-foft/), ou FOIT), les performances des polices web peuvent être plus critiques que les éléments non bloquants comme les images.

### Les polices sont-elles hébergées sur le même serveur ou par un serveur différent ?

La distinction entre l'auto-hébergement et l'hébergement tiers est de plus en plus pertinente dans un monde [HTTP/2](./http2), où l'écart de performance entre un même hôte et une connexion d'hôte différent peut être plus important. Les requêtes de même hôte présentent l'énorme avantage d'un meilleur potentiel de priorisation par rapport aux autres requêtes de même hôte dans la cascade.

Les recommandations pour réduire les coûts de performance du chargement des polices web à partir d'un autre hôte comprennent l'utilisation des fonctions "preconnect", "dns-prefetch" et "preload" [resource hints](./resource-hints), mais les polices web hautement prioritaires devraient être des requêtes de même hôte pour minimiser l'impact des polices web sur les performances. Ceci est particulièrement important pour les polices utilisées par des contenus très visuellement importants ou des corps de texte occupant la majorité d'une page.

<figure>
  <a href="/static/images/2019/fonts/fig1.png">
    <img src="/static/images/2019/fonts/fig1.png" alt="Figure 1. Popular web font hosting strategies." aria-labelledby="fig1-description" aria-describedby="fig1-caption" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1546332659&amp;format=interactive">
  </a>
  <div id="fig1-description" class="visually-hidden">Bar chart showing the popularity of third-party and self-hosting strategies for web fonts. 75% of mobile web pages use third-party hosts and 25% self-host. Desktop websites have similar usage.</div>
  <figcaption id="fig1-caption">Figure 1. Popular web font hosting strategies.</figcaption>
</figure>

Le fait que les trois quarts soient hébergés n'est peut-être pas surprenant compte tenu de la domination de Google Fonts dont nous parlerons [ci-dessous] (#what-are-the-most-popular-third-party-hosts).

Google fournit des polices en utilisant des fichiers CSS tiers hébergés sur https://fonts.googleapis.com. Les développeurs ajoutent des requêtes à ces feuilles de style en utilisant les balises `<link>` dans leur balisage. Bien que ces feuilles de style soient bloquantes, elles sont très petites. Cependant, les fichiers de police sont hébergés sur un autre domaine, `https://fonts.gstatic.com`. Le modèle consistant à exiger deux sauts séparés vers deux domaines différents fait de `preconnect` une excellente option ici pour la deuxième requête qui ne sera pas découverte avant le téléchargement du CSS.

Notez que si `preload` serait un ajout intéressant pour charger les fichiers de police plus haut dans la cascade de requêtes (rappelez-vous que `preconnect` établit la connexion, il ne demande pas le contenu du fichier), `preload` n'est pas encore disponible avec Google Fonts. Google Fonts génère des URL uniques pour leurs fichiers de police [qui sont susceptibles de changer] (https://github.com/google/fonts/issues/1067).

### What are the most popular third-party hosts?

<figure>
  <table>
    <thead>
      <tr>
        <th>Host</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>fonts.gstatic.com</td>
        <td class="numeric">75.4%</td>
        <td class="numeric">74.9%</td>
      </tr>
      <tr>
        <td>use.typekit.net</td>
        <td class="numeric">7.2%</td>
        <td class="numeric">6.6%</td>
      </tr>
      <tr>
        <td>maxcdn.bootstrapcdn.com</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">2.0%</td>
      </tr>
      <tr>
        <td>use.fontawesome.com</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>static.parastorage.com</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">1.2%</td>
      </tr>
      <tr>
        <td>fonts.shopifycdn.com</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>cdn.shopify.com</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>cdnjs.cloudflare.com</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>use.typekit.com</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>netdna.bootstrapcdn.com</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>fast.fonts.net</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>static.dealer.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>themes.googleusercontent.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>static-v.tawk.to</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>stc.utdstc.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>cdn.jsdelivr.net</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>kit-free.fontawesome.com</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>open.scdn.co</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>assets.squarespace.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td>fonts.jimstatic.com</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 2. Top 20 font hosts by percent of requests.</figcaption>
</figure>

La domination de Google Fonts ici était à la fois surprenante et non surprenante. Elle n'était pas surprenante dans la mesure où je m'attendais à ce que le service soit le plus populaire et surprenant par la simple domination de sa popularité. 75 % des demandes de polices sont étonnantes. TypeKit était en deuxième position, à un chiffre près, la bibliothèque Bootstrap occupant une troisième place encore plus éloignée.

<figure>
  <div class="big-number">29%</div>
  <figcaption>Figure 3. Percent of pages that include a Google Fonts stylesheet link in the document <code>&lt;head&gt;</code>.</figcaption>
</figure>

Si l'utilisation élevée des Google Fonts ici est très impressionnante, il est également à noter que seulement 29% des pages comprenaient un élément Google Fonts `<link>`. Cela pourrait signifier plusieurs choses :

- Lorsque des pages utilisent des Google Fonts, elles utilisent _beaucoup_ de Google Fonts. Elles sont fournies sans coût monétaire, après tout. Peut-être qu'elles sont utilisées dans un éditeur WYSIWYG populaire ? Cela semble être une explication très probable.
- Ou une histoire plus improbable est que cela pourrait signifier que beaucoup de gens utilisent les Google Fonts avec `@import` au lieu de `<link>`.
- Ou si nous voulons aller plus loin dans des scénarios très improbables, cela pourrait signifier que beaucoup de gens utilisent des polices Google avec un [HTTP `Link:` header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Link) à la place.

<figure>
  <div class="big-number">0.4%</div>
  <figcaption>Figure 4. Percent of pages that include a Google Fonts stylesheet link as the first child in the document <code>&lt;head&gt;</code>.</figcaption>
</figure>

La documentation de Google Fonts encourage le `<link>` pour le CSS Google Fonts à être placé comme premier enfant dans le `<head>` d'une page. C'est une grande demande ! Dans la pratique, ce n'est pas courant car seulement un demi pour cent de toutes les pages (environ 20 000 pages) ont suivi ce conseil.

De plus, si une page utilise les éléments "preconnect" ou "dns-prefetch" comme `<link>`, ceux-ci passeront de toute façon avant les polices CSS de Google. Lisez la suite pour en savoir plus sur ces conseils de ressources.

### Speeding up third-party hosting

As mentioned above, a super easy way to speed up web font requests to a third-party host is to use the `preconnect` [resource hint](./resource-hints).

<figure>
  <div class="big-number">1.7%</div>
  <figcaption>Figure 5. Percent of mobile pages preconnecting to a web font host.</figcaption>
</figure>

Wow! Less than 2% of pages are using [`preconnect`](https://web.dev/uses-rel-preconnect)! Given that Google Fonts is at 75%, this should be higher! Developers: if you use Google Fonts, use `preconnect`! Google Fonts: proselytize `preconnect` more!

In fact, if you're using Google Fonts go ahead and add this to your `<head>` if it's not there already:

```<link rel="preconnect" href="https://fonts.gstatic.com/">```

### Most popular typefaces

<figure markdown>
  <table>
      <thead>
        <tr>
          <th>Rank</th>
          <th>Font family</th>
          <th>Desktop</th>
          <th>Mobile</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="numeric">1</td>
          <td>Open Sans</td>
          <td class="numeric">24%</td>
          <td class="numeric">22%</td>
        </tr>
        <tr>
          <td class="numeric">2</td>
          <td>Roboto</td>
          <td class="numeric">15%</td>
          <td class="numeric">19%</td>
        </tr>
        <tr>
          <td class="numeric">3</td>
          <td>Montserrat</td>
          <td class="numeric">5%</td>
          <td class="numeric">4%</td>
        </tr>
        <tr>
          <td class="numeric">4</td>
          <td>Source Sans Pro</td>
          <td class="numeric">4%</td>
          <td class="numeric">3%</td>
        </tr>
        <tr>
          <td class="numeric">5</td>
          <td>Noto Sans JP</td>
          <td class="numeric">3%</td>
          <td class="numeric">3%</td>
        </tr>
        <tr>
          <td class="numeric">6</td>
          <td>Lato</td>
          <td class="numeric">3%</td>
          <td class="numeric">3%</td>
        </tr>
        <tr>
          <td class="numeric">7</td>
          <td>Nanum Gothic</td>
          <td class="numeric">4%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">8</td>
          <td>Noto Sans KR</td>
          <td class="numeric">3%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">9</td>
          <td>Roboto Condensed</td>
          <td class="numeric">2%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">10</td>
          <td>Raleway</td>
          <td class="numeric">2%</td>
          <td class="numeric">2%</td>
        </tr>
        <tr>
          <td class="numeric">11</td>
          <td>FontAwesome</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">12</td>
          <td>Roboto Slab</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">13</td>
          <td>Noto Sans TC</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">14</td>
          <td>Poppins</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">15</td>
          <td>Ubuntu</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">16</td>
          <td>Oswald</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">17</td>
          <td>Merriweather</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">18</td>
          <td>PT Sans</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">19</td>
          <td>Playfair Display</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
        <tr>
          <td class="numeric">20</td>
          <td>Noto Sans</td>
          <td class="numeric">1%</td>
          <td class="numeric">1%</td>
        </tr>
      </tbody>
    </table>
  <figcaption>Figure 6. Top 20 font families as a percent of all font declarations.</figcaption>
</figure>

It is unsurprising that the top entries here seem to match up very similarly to [Google Fonts' list of fonts sorted by popularity](https://fonts.google.com/?sort=popularity).

## What font formats are being used?

[WOFF2 is pretty well supported](https://caniuse.com/#feat=woff2) in web browsers today. Google Fonts serves WOFF2, a format that offers improved compression over its predecessor WOFF, which was itself already an improvement over other existing font formats.

<figure>
  <a href="/static/images/2019/fonts/fig7.png">
    <img src="/static/images/2019/fonts/fig7.png" alt="Figure 7. Popularity of web font MIME types." aria-labelledby="fig7-caption" aria-describedby="fig7-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=998584594&amp;format=interactive">
  </a>
  <div id="fig7-description" class="visually-hidden">Bar chart showing the popularity of web font MIME types. WOFF2 is used on 74% of fonts, followed by 13% WOFF, 6% octet-stream, 3% TTF, 2% plain, 1% HTML, 1% SFNT, and fewer than 1% for all other types. Desktop and mobile have similar distributions.</div>
  <figcaption id="fig7-caption">Figure 7. Popularity of web font MIME types.</figcaption>
</figure>

From my perspective, an argument could be made to go WOFF2-only for web fonts after seeing the results here. I wonder where the double-digit WOFF usage is coming from? Perhaps developers still serving web fonts to Internet Explorer?

Third place `octet-stream` (and `plain` a little further down) would seem to suggest that a lot of web servers are configured improperly, sending an incorrect MIME type with web font file requests.

Let's dig a bit deeper and look at the `format()` values used in the `src:` property of `@font-face` declarations:

<figure>
  <a href="/static/images/2019/fonts/fig8.png">
    <img src="/static/images/2019/fonts/fig8.png" alt="Figure 8. Popularity of font formats in <code>@font-face</code> declarations." aria-labelledby="fig8-caption" aria-describedby="fig8-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=700778025&amp;format=interactive">
  </a>
  <div id="fig8-description" class="visually-hidden">Bar chart showing the popularity of formats used in font-face declarations. 69% of desktop pages' @font-face declarations specify the WOFF2 format, 11% WOFF, 10% TrueType, 8% SVG, 2% EOT, and fewer than 1% OpenType, TTF, and OTF. The distribution for mobile pages is similar.</div>
  <figcaption id="fig8-caption">Figure 8. Popularity of font formats in <code>@font-face</code> declarations.</figcaption>
</figure>

I was hoping to see [SVG fonts](https://caniuse.com/#feat=svg-fonts) on the decline. They're buggy and implementations have been removed from every browser except Safari. Time to drop these, y'all.

The SVG data point here also makes me wonder what MIME type y'all are serving these SVG fonts with. I don't see `image/svg+xml` anywhere in Figure 7. Anyway, don't worry about fixing that, just get rid of them!

### WOFF2-only

<figure>
  <table>
    <thead>
      <tr>
        <th>Rank</th>
        <th>Format combinations</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>woff2</td>
        <td class="numeric">84.0%</td>
        <td class="numeric">81.9%</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>svg, truetype, woff</td>
        <td class="numeric">4.3%</td>
        <td class="numeric">4.0%</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>svg, truetype, woff, woff2</td>
        <td class="numeric">3.5%</td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td>eot, svg, truetype, woff</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">2.9%</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td>woff, woff2</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td class="numeric">6</td>
        <td>eot, svg, truetype, woff, woff2</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td class="numeric">7</td>
        <td>truetype, woff</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">1.1%</td>
      </tr>
      <tr>
        <td class="numeric">8</td>
        <td>woff</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.8%</td>
      </tr>
      <tr>
        <td class="numeric">9</td>
        <td>truetype</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.7%</td>
      </tr>
      <tr>
        <td class="numeric">10</td>
        <td>truetype, woff, woff2</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td class="numeric">11</td>
        <td>opentype, woff, woff2</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">12</td>
        <td>svg</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">13</td>
        <td>eot, truetype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td class="numeric">14</td>
        <td>opentype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">15</td>
        <td>opentype</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">16</td>
        <td>eot</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.1%</td>
      </tr>
      <tr>
        <td class="numeric">17</td>
        <td>opentype, svg, truetype, woff</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">18</td>
        <td>opentype, truetype, woff, woff2</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">19</td>
        <td>eot, truetype, woff, woff2</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
      <tr>
        <td class="numeric">20</td>
        <td>svg, woff</td>
        <td class="numeric">0.0%</td>
        <td class="numeric">0.0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>Figure 9. Top 20 font format combinations.</figcaption>
</figure>

This dataset seems to suggest that the majority of people are already using WOFF2-only in their `@font-face` blocks. But this is misleading of course, per our earlier discussion on the dominance of Google Fonts in the data set. Google Fonts does some sniffing methods to serve a streamlined CSS file and only includes the most modern `format()`. Unsurprisingly, WOFF2 dominates the results here for that reason, as browser support for WOFF2 has been pretty broad for some time now.

Importantly, this particular data doesn't really support or detract from the case to go WOFF2-only yet, but it remains a tempting idea.

## Fighting against invisible text

The number one tool we have to fight the default web font loading behavior of "invisible while loading" (also known as FOIT), is `font-display`. Adding `font-display: swap` to your `@font-face` block is an easy way to tell the browser to show fallback text while the web font is loading.

[Browser support](https://caniuse.com/#feat=mdn-css_at-rules_font-face_font-display) is great too. Internet Explorer and pre-Chromium Edge don't have support but they also render fallback text by default when a web font loads (no FOITs allowed here). For our Chrome tests, how commonly is `font-display` used?

<figure>
  <div class="big-number">26%</div>
  <figcaption>Figure 10. Percent of mobile pages that utilize the <code>font-display</code> style.</figcaption>
</figure>

I assume this will be creeping up over time, especially now that [Google Fonts is adding `font-display` to all new code snippets](https://www.zachleat.com/web/google-fonts-display/) copied from their site.

If you're using Google Fonts, update your snippets! If you're not using Google Fonts, use `font-display`! Read more about `font-display` on [MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display).

Let's have a look at what `font-display` values are popular:

<figure>
  <a href="/static/images/2019/fonts/fig11.png">
    <img src="/static/images/2019/fonts/fig11.png" alt="Figure 11. Usage of 'font-display' values." aria-labelledby="fig11-caption" aria-describedby="fig11-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1988783738&amp;format=interactive">
  </a>
  <div id="fig11-description" class="visually-hidden">Bar chart showing the usage of the font-display style. 2.6% of mobile pages set this style to "swap", 1.5% to "auto", 0.7% to "block", 0.4% to "fallback", 0.2% to optional, and 0.1% to "swap" enclosed in quotes, which is invalid. The desktop distribution is similar except "swap" usage is lower by 0.4 percentage points and "auto" usage is higher by 0.1 percentage points.</div>
  <figcaption id="fig11-caption">Figure 11. Usage of <code>font-display</code> values.</figcaption>
</figure>

As an easy way to show fallback text while a web font is loading, `font-display: swap` reigns supreme and is the most common value. `swap` is also the default value used by new Google Fonts code snippets too. I would have expected `optional` (only render if cached) to have a bit more usage here as a few prominent developer evangelists lobbied for it a bit, but no dice.

## How many web fonts are too many?

This is a question that requires some measure of nuance. How are the fonts being used? For how much content on the page? Where does this content live in the layout? How are the fonts being rendered? In lieu of nuance however let's dive right into some broad and heavy handed analysis specifically centered on request counts.

<figure>
  <a href="/static/images/2019/fonts/fig12.png">
    <img src="/static/images/2019/fonts/fig12.png" alt="Figure 12. Distribution of font requests per page." aria-labelledby="fig12-caption" aria-describedby="fig12-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=451821825&amp;format=interactive">
  </a>
  <div id="fig12-description" class="visually-hidden">Bar chart showing the distribution of font requests per page. The 10, 25, 50, 75, and 90th percentiles for desktop are: 0, 1, 3, 6, and 9 font requests. The distribution for mobile is identical until the 75th and 90th percentiles, where mobile pages request 1 fewer font.</div>
  <figcaption id="fig12-caption">Figure 12. Distribution of font requests per page.</figcaption>
</figure>

The median web page makes three web font requests. At the 90th percentile, requested six and nine web fonts on mobile and desktop, respectively.

<figure>
  <a href="/static/images/2019/fonts/fig13.png">
    <img src="/static/images/2019/fonts/fig13.png" alt="Figure 13. Histogram of web fonts requested per page." aria-labelledby="fig13-description" aria-describedby="fig13-caption" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=1755200484&amp;format=interactive">
  </a>
  <div id="fig13-description" class="visually-hidden">Histogram showing the distribution of the number of font requests per page. The most popular number of font requests is 0 at 22% of desktop pages. The distribution drops to 9% of pages having 1 font, then crests at 10% for 2-4 fonts before falling as the number of fonts increases. The desktop and mobile distributions are similar, although the mobile distribution skews slightly toward having fewer fonts per page.</div>
  <figcaption id="fig13-caption">Figure 13. Histogram of web fonts requested per page.</figcaption>
</figure>

It does seem quite interesting that web font requests seem to be pretty steady across desktop and mobile. I'm glad to see the [recommendation to hide `@font-face` blocks inside of a `@media` queries](https://css-tricks.com/snippets/css/using-font-face/#article-header-id-6) didn't catch on (don't get any ideas).

That said there are marginally more requests for fonts made on mobile devices. My hunch here is that fewer typefaces are available on mobile devices, which in turn means fewer `local()` hits in Google Fonts CSS, falling back to network requests for these.

### You don't want to win this award

<figure>
  <div class="big-number">718</div>
  <figcaption>Figure 14. The most web font requests on a single page.</figcaption>
</figure>

The award for the page that requests the most web fonts goes to a site that made **718** web font requests!

After diving into the code, all of those 718 requests are going to Google Fonts! It looks like a malfunctioning "Above the Page fold" optimization plugin for WordPress has gone rogue on this site and is requesting (DDoS-ing?) all the Google Fonts—oops!

Ironic that a performance optimization plugin can make your performance much worse!

## More accurate matching with `unicode-range`

<figure>
  <div class="big-number">56%</div>
  <figcaption>Figure 15. Percent of mobile pages that declare a web font with the <code>unicode-range</code> property.</figcaption>
</figure>

[`unicode-range`](https://developer.mozilla.org/en-US/docs/Web/CSS/%40font-face/unicode-range) is a great CSS property to let the browser know specifically which code points the page would like to use in the font file. If the `@font-face` declaration has a `unicode-range`, content on the page must match one of the code points in the range before the font is requested. It is a very good thing.

This is another metric that I expect was skewed by Google Fonts usage, as Google Fonts uses `unicode-range` in most (if not all) of its CSS. I'd expect this to be less common in user land, but perhaps filtering out Google Fonts requests in the next edition of the Almanac may be possible.

## Don't request web fonts if a system font exists

<figure>
  <div class="big-number">59%</div>
  <figcaption>Figure 16. Percent of mobile pages that declare a web font with the <code>local()</code> property.</figcaption>
</figure>

`local()` is a nice way to reference a system font in your `@font-face` `src`. If the `local()` font exists, it doesn't need to make a request for a web font at all. This is used both extensively and controversially by Google Fonts, so it is likely another example of skewed data if we're trying to glean patterns from user land.

It should also be noted here that it has been said by smarter people than I (Bram Stein of TypeKit) that [using `local()` can be unpredictable as installed versions of fonts can be outdated and unreliable](https://bramstein.com/writing/web-font-anti-patterns-local-fonts.html).

## Condensed fonts and `font-stretch`

<figure>
  <div class="big-number">7%</div>
  <figcaption>Figure 17. Percent of desktop and mobile pages that include a style with the <code>font-stretch</code> property.</figcaption>
</figure>

Historically, `font-stretch` has suffered from poor browser support and was not a well-known `@font-face` property. Read more about [`font-stretch` on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/font-stretch). But [browser support](https://caniuse.com/#feat=css-font-stretch) has broadened.

It has been suggested that using condensed fonts on smaller viewports allows more text to be viewable, but this approach isn't commonly used. That being said, that this property is used half a percentage point more on desktop than mobile is unexpected, and 7% seems much higher than I would have predicted.

## Variable fonts are the future

[Variable fonts](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Fonts/Variable_Fonts_Guide) allow several font weights and styles to be included in the one font file.

<figure>
  <div class="big-number">1.8%</div>
  <figcaption>Figure 18. Percent of pages that include a variable font.</figcaption>
</figure>

Even at 1.8% this was higher than expected, although I am excited to see this take off. [Google Fonts v2](https://developers.google.com/fonts/docs/css2) does include some support for variable fonts.

<figure>
  <a href="/static/images/2019/fonts/fig19.png">
    <img src="/static/images/2019/fonts/fig19.png" alt="Figure 19. Usage of 'font-variation-settings' axes." aria-labelledby="fig19-caption" aria-describedby="fig19-description" width="600" height="371" data-width="600" data-height="371" data-seamless data-frameborder="0" data-scrolling="no" data-iframe="https://docs.google.com/spreadsheets/d/e/2PACX-1vQDogXDb3BwZZHrBT39qccP_LJoCScD3QEi_FmjT_8VDPD_1Srpz-g7ZuuTUEb8pYXBpDmQzZ1hQh7q/pubchart?oid=699343351&amp;format=interactive">
  </a>
  <div id="fig19-description" class="visually-hidden">Bar chart showing the usage of the font-variation-settings property. 42% of properties on desktop pages are set to the "opsz" value, 32% to "wght", 16% to "wdth", 2% or fewer to "roun", "crsb", "slnt", "inln", and more. The most notable differences between desktop and mobile pages are 26% usage of "opsz", 38% of "wght", and 23% of "wdth".</div>
  <figcaption id="fig19-caption">Figure 19. Usage of <code>font-variation-settings</code> axes.</figcaption>
</figure>

Through the lens of this large data set, these are very low sample sizes-take these results with a grain of salt. However, `opsz` as the most common axis on desktop pages is notable, with `wght` and `wdth` trailing. In my experience, the introductory demos for variable fonts are usually weight-based.

## Color fonts might also be the future?

<figure>
  <div class="big-number">117</div>
  <figcaption>Figure 20. The number of desktop web pages that include a color font.</figcaption>
</figure>

Usage here of these is basically nonexistent but you can check out the excellent resource [Color Fonts! WTF?](https://www.colorfonts.wtf/) for more information. Similar (but not at all) to the SVG format for fonts (which is bad and going away), this allows you to embed SVG inside of OpenType files, which is awesome and cool.

## Conclusion

The biggest takeaway here is that Google Fonts dominates the web font discussion. Approaches they've taken weigh heavily on the data we've recorded here. The positives here are easy access to web fonts, good font formats (WOFF2), and for-free `unicode-range` configurations. The downsides here are performance drawbacks associated with third-party hosting, different-host requests, and no access to `preload`.

I fully expect that in the future we'll see the "Rise of the Variable Font". This _should_ be paired with a decline in web font requests, as Variable Fonts combine multiple individual font files into a single composite font file. But history has shown us that what usually happens here is that we optimize a thing and then add more things to fill the vacancy.

It will be very interesting to see if color fonts increase in popularity. I expect these to be far more niche than variable fonts but may see a lifeline in the icon font space.

Keep those fonts frosty, y'all.
