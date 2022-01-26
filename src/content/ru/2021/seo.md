---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO
description: Глава «SEO» издания Web Almanac за 2021 год охватывает сканируемость, индексируемость, удобство страниц, on-page SEO, ссылки, AMP, мультиязычное SEO и многое другое. 
authors: [patrickstox, Tomek3c, wrttnwrd]
reviewers: [fili, SeoRobt, fellowhuman1101]
analysts: [jroakes, rvth]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/11hw7zg4dpIY8XbQR5bNp5LvwbaQF0TjV0X5cK0ng8Bg/
patrickstox_bio: Патрик — советник по продукту, технический SEO-специалист и амбассадор бренда в <a hreflang="ru" href="https://ahrefs.com/ru/">Ahrefs</a>. Он является организатором <a hreflang="ru" href="https://www.meetup.com/ru-RU/RaleighSEO/">Raleigh SEO Meetup</a> (самый успешный SEO Meetup в США), <a hreflang="ru" href="https://www.meetup.com/ru-RU/beerandseo/">Beer and SEO Meetup</a> и <a hreflang="en" href="https://raleighseomeetup.org/conference/">Raleigh SEO Conference</a>. Он также руководит группой Technical SEO в Slack и является модератором <a hreflang="en" href="https://www.reddit.com/r/TechSEO">/r/TechSEO на Reddit</a>. Патрик любит делиться случайными знаниями о SEO в ветках Twitter, которые он называет «Необычные знания SEO». Он известный спикер конференций, блоггер индустрии (в настоящее время в основном в блоге Ahrefs), судья по присуждению наград в области поиска, а также помог определить роль стратега поискового маркетинга в Министерстве труда США.
Tomek3c_bio: Томек — руководитель отдела исследований и разработок в <a hreflang="en" href="https://www.onely.com/">Onely</a>. Он также работает над <a hreflang="en" href="https://www.ziptie.dev/">ZipTie</a>, продуктом, призванным помочь владельцам сайтов получать больше контента, проиндексированного Google. В свободное время он любит ходить в походы и играть в покер.
wrttnwrd_bio: Ян — консультант по маркетингу, SEO, спикер и основатель агентства по восстановлению. Он основал Portent, агентство цифрового маркетинга, в 1995 году и продал его Clearlink в 2017 году. Теперь он сам по себе, <a hreflang="en" href="https://www.ianlurie.com/digital-marketing-consulting/">консультирует бренды</a>, которые ему нравятся, и <a hreflang="en" href="https://www.ianlurie.com/speaking/">выступает на конференциях</a>, которые поставляют диетическую колу. Он также пытался стать профессиональным игроком в Dungeons & Dragons, но ничего не вышло. Вы можете найти его крутящим педали своего велосипеда по нелепым холмам Сиэтла.
featured_quote: SEO сейчас популярнее, чем когда-либо, и оно значительно выросло за последние пару лет, так как компании искали новые способы привлечь клиентов. Популярность SEO сильно превзошла другие цифровые каналы.
featured_stat_1: 16.5%
featured_stat_label_1: Веб-сайты без файла robots.txt
featured_stat_2: 41.5%
featured_stat_label_2: Мобильные страницы без тега canonical
featured_stat_3: 67%
featured_stat_label_3: Мобильные сайты, не соответствующие Core Web Vitals
---

## Введение {introduction}

SEO (Search Engine Optimization, поисковая оптимизация) — это практика оптимизации веб-сайта или веб-страницы для увеличения количества и качества их трафика на основе органических результатов поисковой системы.

SEO сейчас популярнее, чем когда-либо, и оно значительно выросло за последние пару лет, так как компании искали новые способы привлечь клиентов. Популярность SEO сильно превзошла другие цифровые каналы.

{{ figure_markup(
   image="seo-term-trends.png",
   caption="Google Trends: сравнение SEO с платой за клик, маркетингом в социальных сетях и email-маркетингом.",
   description="На скриншоте показан интерес в Google Trends с течением времени. Сравниваются четыре канала цифрового маркетинга: поисковая оптимизация, оплата за клик, маркетинг в социальных сетях и email-маркетинг. SEO всегда было самым популярным каналом, и в последние годы интерес к нему значительно вырос. SEO остается развивающейся сферой с растущим сообществом по всему миру.",
   width=1155,
   height=605
   )
}}

Цель главы «SEO» издания Web Almanac — проанализировать различные элементы, связанные с оптимизацией веб-сайта. В этой главе мы проверим, удобны ли веб-сайты для пользователей и поисковых систем.

Для нашего анализа использовались многие источники данных, включая <a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/">Lighthouse</a>, <a hreflang="en" href="https://developers.google.com/web/tools/chrome-user-experience-report">отчет о пользовательском опыте Chrome (CrUX)</a>, а также необработанные и обработанные HTML-элементы из <a hreflang="en" href="https://httparchive.org/">HTTP Archive</a> на мобильных устройствах и компьютерах. В случае с HTTP Archive и Lighthouse данные ограничиваются анализом только домашних страниц веб-сайтов, а не сканированием всего сайта. Помните об этом, делая выводы на основе наших результатов. Вы можете узнать больше об анализе на нашей странице [Methodology](./methodology).

Читайте дальше, чтобы узнать больше о текущем состоянии Интернета и его удобстве для поисковых систем.

## Сканируемость и Индексируемость {crawlability-and-indexability}

Чтобы возвращать релевантные результаты по запросам пользователей, поисковые системы должны создать индекс в Интернете. Этот процесс включает в себя:

1. **Сканирование** — поисковые системы используют поисковых роботов, или пауков, для посещения страниц в Интернете. Они находят новые страницы через такие источники, как карты сайта или ссылки между страницами.
2. **Обработка** — на этом этапе поисковые системы могут отрисовывать контент на страницах. Они будут извлекать необходимую информацию, такую как контент и ссылки, которые они будут использовать для создания и обновления своего индекса, ранжирования страниц и поиска нового контента. 
3. **Индексация** — cтраницы, отвечающие определенным требованиям к индексации в отношении качества и уникальности контента попадают в индекс. Эти проиндексированные страницы могут быть возвращены по запросам пользователей.

Давайте рассмотрим некоторые проблемы, оказывающие влияние на сканируемость и индексируемость.

### `robots.txt`

`robots.txt` — файл, расположенный в корневой директории каждого поддомена на веб-сайте, который говорит роботам, например поисковым, куда они могут и не могут заходить. 

81.9% веб-сайтов используют файл robots.txt (для мобильных сайтов). По сравнению с предыдущими годами (72.2% в 2019 году и 80.5% в 2020 году) это небольшое улучшение.

Наличие `robots.txt` не обязательно. Если возвращается 404 ответ сервера, Google воспримет это как разрешение сканировать все страницы веб-сайта. Другие поисковые системы могут реагировать иначе.

{{ figure_markup(
   image="robots-txt-status-codes.png",
   caption="Распределение ответов сервера на запрос robots.txt.",
   description="Гистограмма показывает процент страниц с правильным файлом `robots.txt`. Код ответа сервера 200 получен от 81.9% мобильных веб-сайтов, 404 — от 16.5%. Другие коды ответа сервера практически не использовались, и показатели на компьютерах почти такие же, как и на мобильных устройствах.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2062029998&format=interactive",
   sheets_gid="91318795",
   sql_file="robots-txt-status-codes.sql"
   )
}}

Использование `robots.txt` позволяет владельцам веб-сайтов контролировать поисковых роботов. Однако данные анализа показали, что у 16.5% веб-сайтов нет файла `robots.txt`.

У веб-сайтов может быть неправильно настроен `robots.txt`. Например, некоторые популярные веб-сайты (вероятно по ошибке) блокировали поисковых роботов. Google может хранить эти веб-сайты в индексе некоторое время, но в конце концов их видимость в результатах поиска будет снижена.

Другая категория ошибок, связанных с `robots.txt` — ошибки доступа или сети. Ситуация, когда `robots.txt` существует, но к нему нельзя получить доступ. Если Google запрашивает файл `robots.txt` и получает ошибку, он может временно приостановить сканирование. Логика в том, что поисковая система не уверена, может ли выбранная страница быть просканирована, поэтому ждет доступа к `robots.txt`.

По нашим данным ~0.3% веб-сайтов вернули ошибку 403 Доступ запрещен или 5xx. Разные роботы могут реагировать по-разному, поэтому мы не знаем, как именно Googlebot обработал ошибку.

По последней информации, полученной <a hreflang="en" href="https://www.youtube.com/watch?v=JvYh1oe5Zx0&amp;t=315s">от Google за 2019 год</a>, до 5% веб-сайтов временно возвращали 5xx ответ сервера при запросе `robots.txt`, в то время как 26% были недоступны.

{{ figure_markup(
   image="robots-usage-presentation.png",
   caption="Распределение ответов сервера на запрос robots.txt от Googlebot.",
   description="На скриншоте показан процент кодов ответа сервера на запрос `robots.txt` от Googlebot. По данным за 2019 год 69% сайтов были в порядке и использовали ответ сервера 200 или 404 для открытого доступа. Целых 5% веб-сайтов были временно в порядке, возвращая 5хх при запросе `robots.txt`. 26% веб-сайтов оказались недоступны.",
   width=609,
   height=313
   )
}}

Две вещи могут вызвать расхождение между данными HTTP Archive и Google:

1. Google представляет данные двухлетней давности, в то время как HTTP Archive основан на последней информации, или 

2. HTTP Archive основан на данных веб-сайтов, которые достаточно популярны для попадания в CrUX, в то время как Google пытается посетить все известные веб-сайты. 

### Размер `robots.txt` {robotstxt-size}

{{ figure_markup(
   image="robots-txt-size-distribution.png",
   caption="Распределение размеров файла `robots.txt`.", 
   description="Гистограмма показывает распределение размеров `robots.txt`. Почти все файлы `robots.txt` имеют небольшой размер и весят от 0 до 100 Кб. Мы обнаружили, что 96.72% файлов `robots.txt` на мобильных страницах имеют размер 0-100 Кб (аналогичные результаты и для компьютеров). Практически ни на одной из веб-страниц (на компьютерах или телефонах) не было файлов robots.txt размером более 100 Кб, а на 1.58% веб-сайтов он отсутствовал.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1491943936&format=interactive",
   sheets_gid="1066408164",
   sql_file="robots-text-size.sql"
   )
}}

Большинство файлов `robots.txt` малы, их размер составляет от 0 до 100 Кб. Однако мы нашли более 3000 доменов с размером файла `robots.txt` больше 500 Кб, что превышает максимальный предел Google. Правила после этого ограничения будут проигнорированы.

{{ figure_markup(
   image="robots-txt-user-agent.png",
   caption="Использование пользовательских агентов в `robots.txt`.",
   description="Гистограмма показывает 10 наиболее часто используемых пользовательских агентов в `robots.txt`. Результаты были схожи для компьютеров и мобильных устройств, 75.2% доменов не указывают конкретный пользовательский агент. Мы обнаружили `adsbot-google` в 6.3% случаев, `mj12bot` — 5.6%, `ahrefsbot` — 5.0%, `mediapartners-google` — 4.9%, `googlebot` — 3.4%, `nutch` — 3.3%, `yandex` — 3.1%, `pinterest` — 2.9%, `ahrefssiteaudit` — 2.7%.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1206728832&format=interactive",
   sheets_gid="964313002",
   sql_file="robots-txt-user-agent-usage.sql"
   )
}}

Вы можете объявить правило для всех роботов или указать правило для конкретных роботов. Роботы обычно пробуют следовать по наиболее конкретному правилу для их пользовательского агента. `User-agent: Googlebot` будет относиться только к Googlebot, а `User-agent: *` будет относиться ко всем роботам, для которых нет более конкретного правила.

Мы увидели двух популярных SEO-роботов `mj12bot` (Majestic) и `ahrefsbot` (Ahrefs) в топ 5 наиболее часто используемых пользовательских агентов.

### Распределение поисковых систем в `robots.txt` {robotstxt-search-engine-breakdown}

<figure>
  <table>
    <thead>
      <tr>
        <th>Робот</th>
        <th>Компьютеры</th>
        <th>Телефоны</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Googlebot</td>
        <td class="numeric">3.3%</td>
        <td class="numeric">3.4%</td>
      </tr>
      <tr>
        <td>Bingbot</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">3.4%</td>
      </tr>
      <tr>
        <td>Baiduspider</td>
        <td class="numeric">1.9%</td>
        <td class="numeric">1.9%</td>
      </tr>
      <tr>
        <td>Yandexbot</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">0.5%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Распределение поисковых систем в `robots.txt`.", sheets_gid="964313002", sql_file="robots-txt-user-agent-usage.sql") }}</figcaption>
</figure>

При рассмотрении правил, применяемых к конкретным поисковым системам, чаще всего указывался робот Googlebot, который появлялся на 3,3% просканированных веб-сайтов.

Правила роботов, относящиеся к другим поисковым системам, таким как Bing, Baidu и Яндекс, менее популярны (2.5%, 1.9% и 0.5% соответственно). Мы не анализировали, какие правила применялись к этим роботам.

### Канонические теги {canonical-tags}

Интернет — это огромный набор документов, некоторые из которых повторяются. Чтобы избежать дублирования контента, веб-разработчики могут использовать канонические теги, чтобы сообщать поисковым системам, какую версию следует индексировать. Канонические теги также помогают объединять сигналы, такие как ссылки на ранжируемую страницу.

{{ figure_markup(
   image="canonical-tag-usage.png",
   caption="Использование канонических тегов.",
   description="Гистограмма показывает использование канонических тегов. Мы обнаружили, что большинство веб-страниц используют канонические теги (58.5% страниц для мобильных устройств и 56.6% страниц для компьютеров). Процент канонизированных страниц выше на мобильных устройствах (8.3%) в сравнении с компьютерами (4.3%).",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=118545040&format=interactive",
   sheets_gid="1066408164",
   sql_file="pages-canonical-stats.sql"
   )
}}

Данные показывают рост использования канонических тегов за последние годы. Например, издание 2019 года показывает, что 48.3% страниц мобильных страниц использовали канонический тег. В издании 2020 года процент вырос до 53.6%, а в 2021 — до 58.5%.

Канонические теги используются на большем количестве страниц для мобильных устройств, чем для компьютеров. Кроме того, 8.3% мобильных и 4.3% компьютерных страниц канонизированы в другую страницу, чтобы дать Google и другим поисковым системам, что страница, указанная в каноническом теге, является той, которую следует проиндексировать.

Большее число канонизированных страниц на мобильных устройствах, по-видимому, связано с веб-сайтами, использующими <a hreflang="ru" href="https://developers.google.com/search/mobile-sites/mobile-seo/separate-urls">отдельные URL-адреса для мобильных устройств</a>. В этих случаях Google рекомендует размещать тег `rel="canonical"`, указывающий на соответствующие URL-адреса для компьютеров.

Наш набор данных и анализ ограничены главными страницами веб-сайтов; скорее всего, результат будет отличаться при рассмотрении всех URL-адресов на тестируемых веб-сайтах.

#### Два способа использования канонических тегов {two-methods-of-implementing-canonical-tags}

Существует два способа использования канонических тегов:

1. В секции `<head>` HTML-документа
2. В HTTP-заголовке (через заголовок `Link`)

{{ figure_markup(
   image="canonical-raw-rendered-usage.png",
   caption=" Использование канонического тега в необработанном и отрисованном вариантах.",
   description="Гистограмма показывает наличие необработанных и отрисованных канонических тегов (необработанные, отрисованные, тег указан только после отрисовки, тег изменен после отрисовки, тег изменен HTTP-заголовком). По нашим данным канонический тег указан в необработанных документах у 55.9% компьютерных и 57.7% мобильных страниц. Отрисованные канонические теги были обнаружены у 56.5% компьютерных и 58.4% мобильных страниц. Другие теги использовались менее чем на 1.5% компьютерных или мобильных страниц.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1288519273&format=interactive",
   sheets_gid="1066408164",
   sql_file="pages-canonical-stats.sql"
   )
}}

Внедрение канонических тегов в секции `<head>` HTML-документа популярнее, чем использование HTTP-заголовка `Link`. Реализация тега в секции `<head>` считается проще, поэтому используется значительно чаще. 

Мы также увидели небольшое изменение (< 1%) в каноническом теге между доставленным необработанным и отрисованным HTML после применения JavaScript. 

#### Конфликтующие канонические теги {conflicting-canonical-tags}

Иногда страницы содержат более одного канонического тега. При возникновении таких противоречивых сигналов поисковым системам приходится в этом разбираться. Один из адвокатов поиска Google, [Мартин Сплитт](https://twitter.com/g33konaut), однажды сказал, что <a hreflang="en" href="https://www.youtube.com/watch?v=bAE3L1E1Fmk&amp;t=772s">это вызывает неопределенное поведение</a> со стороны Google.

На предыдущем рисунке показано, что 1.3% мобильных страниц имеют разные канонические теги в исходном HTML и в отрисованной версии.

[В прошлогодней главе отмечалось](../2020/seo#canonicalization): «Подобный конфликт можно обнаружить с разными методами реализации: 0.15% мобильных и 0.17% компьютерных страниц показывают конфликты между каноническими тегами, реализованными через HTTP-заголовки и секцию `head`.»

Данные 2021 года по этому конфликту вызывают еще большую тревогу. Страницы отправляют противоречивые сигналы в 0.4% случаев на компьютерах и в 0.3% случаев на мобильных устройствах.

Поскольку данные Web Almanac охватывают только домашние страницы, могут возникнуть дополнительные проблемы со страницами, расположенными глубже в архитектуре сайта, так как они с большей вероятностью нуждаются в канонических сигналах.

## Удобство страницы {page-experience}

В 2021 году стали уделять больше внимания пользовательскому опыту. Google выпустил <a hreflang="ru" href="https://developers.google.com/search/blog/2020/11/timing-for-page-experience">обновление, связанное с удобством страниц</a>, которое включает существующие сигналы, такие как HTTPS и удобство для мобильных устройств, а также новые показатели скорости под названием Core Web Vitals.

### HTTPS

{{ figure_markup(
   image="usage-of-https.png",
   caption="Процент страниц для компьютеров и мобильных устройств, обслуживаемых HTTPS.",
   description="Гистограмма показывает процентное соотношение сайтов на HTTPS. Мы обнаружили, что 81.2% мобильных и 84.3% компьютерных страниц обслуживаются HTTPS.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1826599611&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

Распространение HTTPS все еще растет. HTTPS используется по умолчанию на 81.2% мобильных и 84.3% компьютерных страниц. Это больше почти на 8% на мобильных и на 7% на компьютерных сайтах по сравнению с прошлым годом.

### Удобство для мобильных устройств {mobile-friendliness}

В этом году наблюдается небольшой всплеск удобства для мобильных устройств. Реализация адаптивного дизайна увеличились, в то время как динамический показ остался относительно неизменным.

Адаптивный дизайн отправляет один и тот же код и настраивает отображение веб-сайта в зависимости от размера экрана, в то время как динамический показ отправляет другой код в зависимости от устройства. Метатег `viewport` использовался для распознавания адаптивных веб-сайтов, а заголовок `Vary: User-Agent` — для распознавания веб-сайтов, использующих динамический показ.

{{ figure_markup(
  caption="Процент мобильных страниц, использующих метатег `viewport` — сигнал удобства для мобильных устройств.",
  content="91.1%",
  classes="big-number",
  sheets_gid="704656954",
  sql_file="meta-tag-usage-by-name.sql"
)
}}

91.1% мобильных страниц содержат метатег `viewport`, по сравнению с 89.2% в 2020 году. 86.4% компьютерных страниц также содержат метатег `viewport`, по сравнению с 83.8% в 2020 году.

{{ figure_markup(
   image="vary-usage-agent-header-usage.png",
   caption="Использование заголовка `Vary: User-Agent`.",
   description="Гистограмма показывает использование заголовка `vary`, необходимого для распознавания удобства для мобильных устройств. Мы обнаружили, что адаптивный дизайн на страницах используется чаще (87.4% для компьютеров и 86.6% для мобильных устройств), чем динамический показ (12.6% для компьютеров и 13.4% для мобильных устройств).",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1985736287&format=interactive",
   sheets_gid="478009067",
   sql_file="html-response-vary-header-used.sql"
   )
}}

Для заголовка `Vary: User-Agent` цифры почти не изменились: 12.6% страниц для компьютеров и 13.4% мобильных страниц.

{{ figure_markup(
  caption="Процент мобильных страниц, не использующих разборчивые размеры шрифта.",
  content="13.5%",
  classes="big-number",
  sheets_gid="1705330480",
  sql_file="lighthouse-seo-stats.sql"
)
}}

Одна из главных причин неудобства страниц для мобильных устройств — 13.5% страниц не используют разборчивые размеры шрифта. Это значит, что <a hreflang="en" href="https://web.dev/font-size/">60% или больше текста на странице имеют размер шрифта меньше 12px</a>, что может сложно читаться на мобильных устройствах. 

### Core Web Vitals

Core Web Vitals — это новые показатели скорости, которые являются частью сигналов удобства страниц для Google. Метрики измеряют производительность загрузки с помощью Largest Contentful Paint (LCP), визуальную стабильность с Cumulative Layout Shift (CLS) и интерактивность с First Input Delay (FID).

Данные поступают из отчета о пользовательском опыте Chrome (CrUX), в котором записываются реальные данные от зарегистрированных пользователей Chrome.

{{ figure_markup(
   image="core-web-vitals-trend.png",
   caption="Тенденция показателей Core Web Vitals.",
   description="Линейная диаграмма показывает процент веб-сайтов с хорошими показателями Core Web Vitals на мобильных устройствах. В 2021 году доля сайтов с хорошим показателем LCP выросла с 42% до 45%, с хорошим FID — с 81% до 90%, с хорошим CLS — с 55% до 62%, и в целом с хорошими данными CWV — с 23% до 29%. Наши результаты показывают, что процент мобильных веб-сайтов с хорошими показателями Core Web Vitals будет продолжать расти с каждым годом.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1693723951&format=interactive",
   sheets_gid="460991760",
   sql_file="core-web-vitals.sql"
   )
}}

29% мобильных веб-сайтов удовлетворяют пороговым значениям Core Web Vitals по сравнению с 20% в прошлом году. У большинства веб-сайтов удовлетворительный показатель FID, но владельцы веб-сайтов, похоже, пытаются улучшить CLS и LCP. Дополнительную информацию по этой теме смотрите в главе [Производительность](./performance).

## On-Page

Поисковые системы просматривают контент вашей страницы, чтобы определить, соответствует ли содержимое поисковому запросу. Другие элементы на странице могут также влиять на ранжирование или внешний вид в поисковых системах.

### Метаданные {metadata}

Метаданные включают в себя элементы `<title>` и теги `<meta name="description">`. Метаданные могут напрямую или косвенно влиять на эффективность SEO.

{{ figure_markup(
   image="title-meta-description-usage.png",
   caption="Разбивка использования `title` и `meta description`.",
   description="Гистограмма показывает процент страниц, имеющих метаданные. Мы обнаружили, что на 98.8% мобильных и компьютерных страниц есть элемент `title`, и на 71.1% — `meta description`.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=541272297&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

В 2021 году 98.8% компьютерных и мобильных страниц содержали элемент `<title>`. 71.1% домашних страниц для компьютеров и мобильных устройств содержали теги `<meta name="description">`.

#### Элемент `<title>` {title-element}

Элемент `<title>` — это фактор ранжирования на странице, который дает подсказку о релевантности страницы и может отображаться на странице результатов поисковой системы (SERP). В августе 2021 года <a hreflang="ru" href="https://developers.google.com/search/blog/2021/08/update-to-generating-page-titles">Google начал чаще переписывать заголовки в результатах поиска</a>.

{{ figure_markup(
   image="title-word-counts.png",
   caption="Количество слов, используемых в элементах `<title>`.",
   description="Гистограмма показывает количество слов в теге `<title>` на процентиль (10, 25, 50, 75 и 90). Средняя страница содержала заголовок, который имел 6 слов, и 50% всех заголовков содержали 3-9 слов. По нашим данным не было обнаружено разницы в количестве слов между компьютерными и мобильными страницами.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2017837375&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

{{ figure_markup(
   image="title-character-counts.png",
   caption="Количество символов, испольуемых в элементах `<title>`.",
   description="Гистограмма показывает количество символов в теге заголовка на процентиль (10, 25, 50, 75 и 90). Средняя страница содержала 39 символов в заголовке на компьютерах и 40 символов — на мобильных устройствах. По нашим данным количество символов между компьютерами и мобильными устройствами отличалось незначительно.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1099454676&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

В 2021 году:

- Средняя страница содержала 6 слов в `<title>`.
- Средняя страница содержала 39 и 40 символов в `<title>` на компьютерах и мобильных устройствах соответственно.
- На 10% страниц элемент `<title>` содержал 12 слов.
- На 10% компьютерных и мобильных страниц элемент `<title>` содержал 74 и 75 символов соответственно. 

Большинство из этих статистических данных относительно не изменились с прошлого года. Напоминаем, что это заголовки главных страниц, которые, как правило, короче, чем заголовки на более глубоких страницах.

#### Метатег description {meta-description-tag}

Тег `<meta name="description>` не влияет напрямую на ранжирование, но может появляться в поисковой выдаче как описание страницы.

{{ figure_markup(
   image="meta-word-counts.png",
   caption="Количество слов, используемых в метатегах `description`.",
   description="Гистограмма показывает количество слов в метатеге `description` на процентиль (10, 25, 50, 75 и 90). Средняя страница содержала мета описание из 20 слов для компьютеров и 19 слов для мобильных устройств. По нашим данным количество слов между компьютерами и мобильными устройствами отличалось незначительно.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2013621429&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

{{ figure_markup(
   image="meta-character-counts.png",
   caption="Количество символов, используемых в метатегах `description`.",
   description="Гистограмма показывает количество символов в метатеге `description` на процентиль (10, 25, 50, 75 и 90). Средняя страница содержала мета описание длиной 138 символов на компьютерных и 137 символов на мобильных страницах. По нашим данным количество символов между компьютерами и мобильными устройствами отличалось незначительно.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=971210715&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats.sql"
   )
}}

В 2021 году:

- Средняя компьютерная и мобильная страницы содержали тег `<meta name="description>` длиной 20 и 19 слов соответственно.
- Средняя компьютерная и мобильная страницы содержали тег `<meta name="description>` длиной 138 и 127 символов соответственно.
- На 10% компьютерных и мобильных страниц тег `<meta name="description>` был длиной 35 слов.
- На 10% компьютерных и мобильных страниц тег `<meta name="description>` был длиной 232 и 231 символов соответственно.

Эти показатели практически не изменились с прошлого года.

### Изображения {images}

{{ figure_markup(
   image="number-of-images-per-page.png",
   caption="Количество изображений на каждой странице.",
   description="Гистограмма показывает количество элементов `<img>` на странице на процентиль (10, 25, 50, 75 и 90). Средняя компьютерная и мобильная страницы содержали 21 и 19 элементов `<img>` соответственно.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1314615789&format=interactive",
   sheets_gid="1483073708",
   sql_file="image-alt-stats.sql"
   )
}}

Изображения могу напрямую или косвенно влиять на SEO, поскольку они влияют на рейтинг изображений в поиске и производительность страницы. 

- 10% страниц содержат 2 или меньше тегов `<img>`. Это верно и для компьютеров, и для мобильных устройств.
- Средняя компьютерная и мобильная страницы содержат 21 и 19 тегов `<img>` соответственно.
- На 10% компьютерных страниц содержится 83 или больше тегов `<img>`. На 10% мобильных страниц содержится 73 или больше тегов `<img>`.

Эти цифры незначительно изменились с 2020 года.

#### Атрибуты изображения `alt` {image-alt-attributes}

Атрибут `alt` для элемента `<img>` помогает пояснить содержимое изображения и влияет на [общедоступность](./accessibility).

Обратите внимание, что отсутствие атрибута `alt` не означает проблему. Страницы могут содержать очень маленькие или пустые изображения, которым не требуется атрибут `alt` для SEO или общедоступности.

{{ figure_markup(
   image="images-with-alt-attribute.png",
   caption="Процент изображений, которые содержат атрибуты `alt`.",
   description="Гистограмма показывает количество изображений с атрибутом `alt` на процентиль (10, 25, 50, 75 и 90). По нашим данным средняя страница содержит 54.6% и 56.5% изображений с атрибутом `alt` на мобильных и компьютерных страницах соответственно.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1862003290&format=interactive",
   sheets_gid="412947118",
   sql_file="image-alt-stats.sql"
   )
}}

{{ figure_markup(
   image="images-with-blank-alt-attribute.png",
   caption="Процент пустых атрибутов `alt`.",
   description="Гистограмма показывает процент пустых атрибутов `alt` на процентиль (25, 50, 75 и 90). Средняя веб-страница содержала 10.5% и 11.8% пустых атрибутов `alt` на компьютерных и мобильных страницах соответственно.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=198831003&format=interactive",
   sheets_gid="412947118",
   sql_file="image-alt-stats.sql"
   )
}}

{{ figure_markup(
   image="images-with-missing-alt-attribute.png",
   caption="Процент изображений без атрибутов `alt`.",
   description="Гистограмма показывает процент изображений без атрибутов `alt` на процентиль (10, 25, 50, 75 и 90). Средняя веб-страница содержала 1.4% изображений без атрибутов `alt` на компьютерах и 0 изображений — на мобильных устройствах.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=819909313&format=interactive",
   sheets_gid="412947118",
   sql_file="image-alt-stats.sql"
   )
}}

Мы обнаружили, что:

- На средней компьютерной странице 56.5% тегов `<img>` сожержали атрибут `alt`. Это небольшой рост по сравнению с 2020 годом.
- На средней мобильной странице 54.6% тегов `<img>` сожержали атрибут `alt`. Это небольшой рост по сравнению с 2020 годом.
- Однако в среднем страницы для компьютеров и мобильных устройств в 10.5% и 11.8% случаев имеют пустые атрибуты `alt` для тегов `<img>` соответственно. Это фактически то же самое, что и в 2020 году.
- На средних страницах для компьютеров и мобильных устройств нет или почти нет тегов `<img>` без атрибутов `alt`. Это улучшение по сравнению с 2020 годом, когда на 2-3% страниц теги `<img>` не содержали атрибуты `alt`.

#### Атрибуты изображений `loading` {image-loading-attributes}

Атрибут `loading` в элементах `<img>` влияет на приоритет рендеринга и отображения изображений на странице. Это может влиять на пользовательский опыт и производительность загрузки страницы, оба фактора влияют на SEO.

{{ figure_markup(
   image="image-loading-property-usage.png",
   caption="Использование атрибута изображения `loading`.",
   description='Гистограмма показывать процент страниц и использование атрибута изображения `loading` (missing — отсутствует, `lazy`, `eager`, invalid — недопустимое значение, `auto`, blank - пустое). По нашим данным на 83.3% компьютерных и 83.5% мобильных страниц отсутствовал атрибут `loading` для изображений. Мы обнаружили, что `loading="lazy"` используется на 15.6% страниц для компьютеров и мобильных устройств, в то время как только 0.8% страниц для компьютеров и мобильных устройств используют `loading="eager"`. Количество других случаев составлет менее 1% на компьютерных и мобильных страницах, сюда входят случаи с недопустимым или пустым значением атрибута или со значением `auto`.',
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1305654777&format=interactive",
   sheets_gid="55531578",
   sql_file="image-loading-property-usage.sql"
   )
}}

Мы обнаружили, что: 

- 85.5% страниц не используют атрибут `loading` для изображений.
- 15.6% страниц используют значение `loading="lazy"`, которое откладывает загрузку изображения до тех пор, пока оно не приблизится к области просмотра.
- 0.8% страниц используют значение `loading="eager"`, которое загружает изображение сразу же, как только браузер загружает код.
- 0.1% страниц используют недопустимое значение атрибута.
- 0.1% страниц используют значение `loading="auto"`, которое использует поведение браузера по умолчанию.


### Количество слов {word-count}

Количество слов на странице не является фактором ранжирования, но то, как страницы отображают слова, может сильно повлиять на ранжирование. Слова могут быть в необработанном коде страницы или отрисованном контенте.

#### Количество слов после отрисовки {rendered-word-count}

В первую очередь мы смотрим на отрисованный контент страницы. _Отрисованный_ контент — это содержимое страницы после выполнения браузером всего JavaScript и любого другого кода, который изменяет DOM или CSSOM. 

{{ figure_markup(
   image="visible-rendered-words-percentile.png",
   caption="Количество видимых слов после отрисовки на процентиль.",
   description="Гистограмма показывает количество видимых слов после отрисовки на процентиль (10, 25, 50, 75 и 90). Средняя _отрисованная_ компьютерная и мобильная страницы содержат 425 и 367 слов соответственно. Мобильные страницы содержат меньше _отрисованных_ слов в каждом процентиле.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=833732027&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

- Средняя _отрисованная_ компьютерная страница содержит 425 слов, по сравенению с 402 словами в 2020 году.
- Средняя _отрисованная_ мобильная страница содержит 367 слов, по сравению с 348 словами в 2020 году.
- Отрисованные мобильные страницы содержат на 13.6% слов меньше, чем отрисованные компьютерные страницы. Обратите внимание, что Google — это индекс в первую очередь для мобильных устройств. Контент, которого нет в мобильной версии, может не индексироваться.

#### Raw word count

Next, we look at the raw page content _Raw_ is the content of the page before the browser has executed JavaScript or any other code that modified the DOM or CSSOM. It's the "raw" content delivered and visible in the source code.

{{ figure_markup(
   image="visible-raw-words-percentile.png",
   caption="Visible words raw by percentile.",
   description="Bar chart showing the number of raw visible words by percentile (10, 25, 50, 75, 90). The median raw desktop page contained 369 words and the median mobile page contained 321. Mobile pages contained fewer raw words at every percentile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=58186900&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

- The median _raw_ desktop page contains 369 words, versus 360 words in 2020.
- The median _raw_ mobile page contains 321 words, versus 312 words in 2020.
- Raw mobile pages contain 13.1% fewer words than rendered desktop pages. Note that Google is a mobile-only index. Content not on the mobile HTML version may not get indexed.

Overall, 15% of written content on desktop devices is generated by JavaScript and 14.3% on mobile versions.

### Structured Data

Historically, search engines have worked with unstructured data: the piles of words, paragraphs and other content that comprise the text on a page.

Schema markup and other types of structured data provide search engines another way to parse and organize content. Structured data powers many of <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/search-gallery">Google's search features</a>.

Like words on the page, structured data can be modified with JavaScript.

{{ figure_markup(
   image="structured-data-usage.png",
   caption="Structure data usage.",
   description="Bar chart showing the number of pages with raw vs rendered structured data. 41.8% of desktop and 42.5% of mobile of pages had raw structured data. The number of pages that had rendered structure data was 43.2% for desktop and 44.2% for mobile. Few pages had only rendered structure data, 1.4% of desktop pages and 1.7% of mobile pages. Lastly, 4.5% of desktop pages and 4.7% of mobile pages had structured data rendering changes.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1924313131&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

42.5% of mobile pages and 41.8% of desktop pages have structured data in the HTML. JavaScript modifies the structured data on 4.7% of mobile pages and 4.5% of desktop pages.

On 1.7% of mobile pages and 1.4% of desktop pages structured data is added by JavaScript where it didn't exist in the initial HTML response.

#### Most popular structured data formats

{{ figure_markup(
   image="structured-data-formats.png",
   caption="Breakdown of structured data formats.",
   description="Bar chart showing the number of pages with structured data formats (JSON-LD, microdata, RDFa, microformats2). The JSON-LD structured data format was implemented on 62.4% of desktop and 60.5% of mobile sites. The microdata format was implemented on 34.6% of desktop and 36.9% of mobile sites. The RDFa format was implemented on 2.9% of desktop and 2.4% of mobile sites. The microformats2 format was used on only .2% of desktop and mobile sites in our dataset.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1433352391&format=interactive",
   sheets_gid="1113852331",
   sql_file="structured-data-formats.sql"
   )
}}

There are several ways to include structured data on a page: JSON-LD, microdata, RDFa, and microformats2. JSON-LD is the most popular implementation method. Over 60% of desktop and mobile pages that have structured data implement it with JSON-LD.

Among websites implementing structured data, over 36% of desktop and mobile pages use microdata and less than 3% of pages use RDFa or microformats2.

Structured data adoption is up a bit since last year. It's used on 33.2% of pages in 2021 vs 30.6% in 2020.

#### Most popular schema types

{{ figure_markup(
   image="most-popular-schema-types.png",
   caption="Most popular schema types.",
   description="Bar chart showing the most popular schema types found on homepages. Results were nearly identical for desktop and mobile homepages. The most popular schema types were WebSite, SearchAction, WebPage, UnknownType and Organization.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=242663990&format=interactive",
   sheets_gid="1580260783",
   sql_file="structured-data-schema-types.sql",
   width=600,
   height=532
   )
}}

The most popular schema types found on homepages are `WebSite`, `SearchAction`, `WebPage`. `SearchAction` is what powers the <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/sitelinks-searchbox">Sitelinks Search Box</a>, which Google can choose to show in the Search Results Page.

### `<h>` elements (headings)

Heading elements (`<h1>`, `<h2>`, etc.) are an important structural element. While they don't directly impact rankings, they do help Google to better understand the content on the page.

{{ figure_markup(
   image="heading-element-usage.png",
   caption="Heading element usage.",
   description="Bar chart showing the percent of pages with the presence of H elements by heading tag (level 1, 2, 3, 4). There was little to no difference between desktop and mobile results. `h1` headings were found on 65.4% of pages, `h2`s were found the most frequently on 71.9% of pages, `h3`3s were found on 61.8% of pages and `h4` headings were found on 37.6% of pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1197492338&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

For main headings, more pages (71.9%) have `h2`s than have `h1`s (65.4%). There's no obvious explanation for the discrepancy. 61.4% of desktop and mobile pages use `h3`s and less than 39% use `h4`s.

There was very little difference between desktop and mobile heading usage, nor was there a major change versus 2020.

{{ figure_markup(
   image="non-empty-heading-element-usage.png",
   caption="Non-empty heading element usage.",
   description="Bar chart showing the percent of pages with the presence of non-empty `<h>` elements by heading tag (level 1, 2, 3, 4). There was little to no difference between desktop and mobile results. `h1` headings were found on 58.1% of pages, `h2`s were found the most frequently on 70.5% of pages, `h3`s on 60.3% of pages and `h4` headings were found on 36.5% of pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2102902536&format=interactive",
   sheets_gid="1347655296",
   sql_file="seo-stats.sql"
   )
}}

However, a lower percentage of pages include _non-empty_`<h>` elements, particularly `h1`. Websites often wrap logo-images in `<h1>` elements on homepages, and this may explain the discrepancy.

## Links

Search engines use links to discover new pages and to pass [_PageRank_](https://en.wikipedia.org/wiki/PageRank) which helps determine the importance of pages.

{{ figure_markup(
  caption="Pages using non-descriptive link texts.",
  content="16.0%",
  classes="big-number",
  sheets_gid="1705330480",
  sql_file="lighthouse-seo-stats.sql"
)
}}

On top of PageRank, the text used as a link anchor helps search engines to understand what a linked page is about. Lighthouse has a test to check if the anchor text used is useful text or if it's generic anchor text like "learn more" or "click here" which aren't very descriptive. 16% of the tested links did not have descriptive anchor text, which is a missed opportunity from an SEO perspective and also bad for accessibility.

### Internal and external links

{{ figure_markup(
   image="outgoing-internal-link.png",
   caption="Internal links from homepages.",
   description="Bar chart showing the number of internal links on homepages by percentile (10, 25, 50, 75, 90). The median desktop homepage had 64 internal links compared to 55 internal links on mobile. There were more internal links on desktop homepages at every percentile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1929473622&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

Internal links are links to other pages on the same site. Pages had less links on the mobile versions compared to the desktop versions.

The data shows that the median number of internal links on desktop is 16% higher than mobile, 64 vs 55 respectively. It's likely this is because developers tend to minimize the navigation menus and footers on mobile to make them easier to use on smaller screens.

The most popular websites (the top 1,000 according to CrUX data) have more outgoing internal links than less popular websites. 144 on desktop vs. 110 on mobile, over two times higher than the median! This may be because of the use of mega-menus on larger sites that generally have more pages.

{{ figure_markup(
   image="outgoing-external-links.png",
   caption="External links from homepages.",
   description="Bar chart showing the number of external links on homepages by percentile (10, 25, 50, 75, 90). The median desktop homepage had 7 external links compared to 6 external links on mobile. There were more external links on desktop homepages at every percentile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=876769621&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

External links are links from one website to a different site. The data again shows fewer external links on the mobile versions of the pages.

The numbers are nearly identical to 2020. Despite Google rolling out mobile first indexing this year, websites have not brought their mobile versions to parity with their desktop versions.

### Text and image links

{{ figure_markup(
   image="text-links.png",
   caption="Text links from homepages.",
   description="Bar chart showing the number of text links per percentile (10, 25, 50, 75, and 90). The median page contained 69 text links on desktop and 63 text links on mobile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1700739999&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

{{ figure_markup(
   image="image-links.png",
   caption="Image links from homepages.",
   description="Bar chart showing the number of image links per percentile (10, 25, 50, 75, and 90). The median web page contained 7 image links on desktop and 6 image links on mobile.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1217720785&format=interactive",
   sheets_gid="455169599",
   sql_file="seo-stats-by-percentile.sql"
   )
}}

While a significant portion of links on the web are text based, a portion also link images to other pages. 9.2% of links on desktop pages and 8.7% of links on mobile pages are image links. With image links, the `alt` attributes set for the image act as anchor text to provide additional context on what the pages are about.

### Link attributes

In September of 2019, Google <a hreflang="en" href="https://googleblog.blogspot.com/2005/01/preventing-comment-spam.html">introduced attributes</a> that allow publishers to classify links as being _sponsored_ or _user-generated content_. These attributes are in addition to `rel=nofollow` which was previously <a hreflang="en" href="https://webmasters.googleblog.com/2019/09/evolving-nofollow-new-ways-to-identify.html">introduced in 2005</a>. The new attributes, `rel=ug`c and `rel=sponsored`, add additional information to the links.

{{ figure_markup(
   image="rel-attibute-usage.png",
   caption="Rel attribute usage.",
   description="Bar chart showing the usage (in percent) of rel attributes on desktop and mobile. Our data found that that 29.2% of homepages featured nofollow attributes on their desktop version and 30.7% on mobile. Rel=noopener was featured on 31.6% of desktop pages and 30.1% on mobile. Rel=noreferrer was featured on 15.8% of desktop pages and 14.8% of mobile. Rel=dofollow, Rel=ugc, Rel=sponsored, and Rel=follow were all featured on fewer than 1% of desktop and mobile pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1672151299&format=interactive",
   sheets_gid="1936997045",
   sql_file="anchor-rel-attribute-usage.sql"
   )
}}

The new attributes are still fairly rare, at least on homepages, with `rel="ugc"` appearing on 0.4% of mobile pages and `rel="sponsored"` appearing on 0.3% of mobile pages. It's likely these attributes are seeing more adoption on pages that aren't homepages.

`rel="follow"` and `rel=dofollow` appear on more pages than `rel="ugc"` and `rel="sponsored"`. While this is not a problem, Google ignores `rel="follow"` and `rel="dofollow"` because they aren't official attributes.

`rel="nofollow"` was found on 30.7% of mobile pages, similar to last year. With the attribute used so much, it's no surprise that Google has changed `nofollow` to a hint—which means they can choose whether or not they respect it.

## Accelerated Mobile Pages (AMP)

2021 saw major changes in the Accelerated Mobile Pages (AMP) ecosystem. AMP is <a hreflang="en" href="https://developers.google.com/search/blog/2021/04/more-details-page-experience#details">no longer required for the Top Pages carousel, no longer required for the Google News app, and Google will no longer show the AMP logo next to AMP results in the SERP</a>.

{{ figure_markup(
   image="amp-markup-types.png",
   caption="AMP attribute usage.",
   description="Bar chart showing the percent of pages with AMP markup types. The Amp attribute was present on 0.09% of desktop and 0.22% of mobile pages. The Amp & Emjoi attribute was present on 0.02% of desktop and 0.04% of mobile pages. The Amp or Emjoi attribute was used on 0.10% of desktop and 0.26% of mobile pages. Lastly, the Rel Amp Tag was used on 0.82% of desktop pages and 0.75% of mobile pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1787667985&format=interactive",
   sheets_gid="718210755",
   sql_file="markup-stats.sql"
   )
}}

However, AMP adoption continued to increase in 2021. 0.09% of desktop pages now include the AMP attribute vs 0.22% for mobile pages. This is up from 0.06% on desktop pages and 0.15% on mobile pages in 2020.

## Internationalization

<figure>
  <blockquote>If you have multiple versions of a page for different languages or regions, tell Google about these different variations. Doing so will help Google Search point users to the most appropriate version of your page by language or region.</blockquote>
  <figcaption>— <cite><a hreflang="en" href="hhttps://developers.google.com/search/docs/advanced/crawling/localized-versions">Google SEO documentation</a></cite></figcaption>
</figure>

To let search engines know about localized versions of your pages, use `hreflang` tags. `hreflang` attributes are also used by <a hreflang="en" href="https://yandex.com/support/webmaster/yandex-indexing/locale-pages.html">Yandex</a> and Bing ([to some extent](https://twitter.com/facan/status/1304120691172601856)).

{{ figure_markup(
   image="hreflang-usage.png",
   caption="Top hreflang tag attributes chart.",
   description="Horizontal bar chart showing hreflang usage. The most popular hreflang attribute was `en` (English version) and hreflang attributes (across all languages) were implemented on less than 5% of desktop and mobile pages.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=1149395895&format=interactive",
   sheets_gid="866829014",
   sql_file="hreflang-link-tag-usage.sql",
   width=600,
   height=546
   )
}}

9.0% of desktop pages and 8.4% of mobile pages use the hreflang attribute.

There are three ways of implementing `hreflang` information: in HTML `<head>` elements, `X-robots` headers, and with XML sitemaps. This data does not include data for XML sitemaps.

The most popular hreflang attribute is `"en"` (English version). 4.75% of mobile homepages use it and 5.32% of desktop homepages.

`x-default` (also called the fallback version) is used in 2.56% of cases on mobile. Other popular languages addressed by `hreflang` attributes are French and Spanish.

For Bing, [`hreflang` is a "far weaker signal" than the `content-language` header](https://twitter.com/facan/status/1304120691172601856).

As with many other SEO parameters, [`content-language`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Language) has multiple implementation methods including:

1. HTTP server response
2. HTML tag

{{ figure_markup(
   image="language-usage-html-http.png",
   caption="Language usage (HTML and HTTP header).",
   description="Horizontal bar chart showing percent of pages with language usage (HTML and HTTP header).",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ7oSHa6DHYTfZqsuGmIYdlfYVkwrUvOYD_r6soecExV_ZpbbZjmG6watu0hwrOKqK3-inNrt0TfXCO/pubchart?oid=2048466165&format=interactive",
   sheets_gid="933228304",
   sql_file="content-language-usage.sql",
   width=600,
   height=529
   )
}}

Using an HTTP server response is the most popular way of implementing `content-language`. 8.7% of websites use it on desktop while 9.3% on mobile.

Using the HTML tag is less popular, with content-language appearing on just 3.3% of mobile websites.

## Conclusion

Websites are slowly improving from an SEO perspective. Likely due to a combination of websites improving their SEO and the platforms hosting websites also improving. The web is a big and messy place so there's still a lot to do, but it's nice to see consistent progress.
