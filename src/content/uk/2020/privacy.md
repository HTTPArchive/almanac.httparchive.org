---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Конфіденційність
description: Розділ «Конфіденційність» у 2020 Web Almanac розкриває використання файлів «cookies» для онлайн трекінгу, технології для посилення конфіденційності та політику конфіденційності
authors: [ydimova]
reviewers: [ldevernay]
analysts: [ydimova, max-ostapenko]
editors: [tunetheweb]
translators: [tymosh]
ydimova_bio: Yana Dimova — аспірантка Левенського католицького університету у Бельгії. Вона вивчає конфіденційність та інтернет-безпеку.
discuss: 2046
results: https://docs.google.com/spreadsheets/d/16bE70rv4qbmKIqbZS1zUiTRpk5eOlgxBXEabL1qiduI/
featured_quote: Тема конфіденційності останнім часом стала популярнішою та важливішою для користувачів. Потребу в настановах втілили різноманітні регламенти, такі як, наприклад, GDPR у Європі, LGPD у Бразилії та CCPA у Каліфорнії. Ці правила покликані посилити відповідальність тих, хто обробляє дані, та їх прозорість перед користувачами. У цьому розділі ми поговоримо про поширеність онлайн трекінгу за допомогою різних технік та про рівень прийняття веб-сайтами банерів щодо використання файлів «cookies» та політики конфіденційності.
featured_stat_1: 93%
featured_stat_label_1: Веб-сайти, що завантажують принаймні один трекер
featured_stat_2: Дев'ять з<wbr>десяти
featured_stat_label_2: Домени, які встановлюють найбільше файлів «cookies», належать Google
featured_stat_3: 44.8%
featured_stat_label_3: Веб-сайти, що мають політику конфіденційності
---

## Вступ

У цьому розділі Web Almanac розглядається поточний стан конфіденційності в інтернеті. Ця тема останнім часом стала популярнішою та важливішою для користувачів. Потребу в настановах втілили різноманітні регламенти, такі як, наприклад, <a hreflang="en" href="https://gdpr-info.eu/">GDPR</a> у Європі, <a hreflang="en" href="https://lgpd-brazil.info/">LGPD</a> у Бразилії та <a hreflang="en" href="https://leginfo.legislature.ca.gov/faces/codes_displayText.xhtml?division=3.&part=4.&lawCode=CIV&title=1.81.5">CCPA</a> у Каліфорнії. Ці правила покликані посилити відповідальність тих, хто обробляє дані, та їх прозорість перед користувачами. У цьому розділі ми поговоримо про поширеність онлайн трекінгу за допомогою різних технік та про рівень прийняття веб-сайтами банерів щодо використання файлів «cookies» та політики конфіденційності.

## Відстеження в мережі

Сторонні відстежувачі збирають дані користувачів, щоб будувати профілі їх поведінки з рекламною метою та отримувати за це плату. Це змушує інтернет-користувачів непокоїтися за свою конфіденційність, що виливається в появу різноманітних способів захисту від трекінгу. Проте, як ми побачимо у цьому підрозділі, онлайн трекінг й досі доволі поширений. І це негативно впливає не тільки на конфіденційність, але й на <a hreflang="en" href="https://gerrymcgovern.com/calculating-the-pollution-cost-of-website-analytics-part-1/">навколишнє середовище</a>, а уникнення цього може навіть [покращити продуктивність веб-сайтів](https://twitter.com/fr3ino/status/1000166112615714816).

Ми розглянули найпоширеніші типи [сторонніх](./third-party) трекерів, а саме відстеження з допомогою сторонніх файлів «cookies» та з використанням фінґерпринтингу. Онлайн трекінг не обмежується цими двома техніками, нові продовжують з’являтися, щоб обходити наявні контрзаходи.

### Стороні трекери

Ми використовуємо список відстежувачів від <a hreflang="en" href="https://whotracks.me/">WhoTracksMe</a> для визначення відсотку веб-сайтів, які роблять запити до потенційних трекерів. Як показує графік, ми визначили, що як мінімум один потенційний відстежувач присутній на близько 93% сайтів.

{{ figure_markup(
  image="privacy-websites-that-load-trackers.png",
  caption="Веб-сайти, що завантажують хоча б один потенційний трекер",
  description="Гістограма показує, що 92,94% настільних сторінок та 92,97% мобільних завантажують трекери.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1325818112&format=interactive",
  sheets_gid="1591448294"
  )
}}

Ми вивчили найпоширеніші трекери й побудували графік поширеності 10 найпопулярніших.

{{ figure_markup(
  image="privacy-biggest-third-party-potential-trackers.png",
  caption="Топ-10 потенційних трекерів",
  description="Гістограма показує 10 найпопулярніших потенційних трекерів, що використовуються мобільними та настільними клієнтами. Різниця між клієнтами невелика. На мобільних 65,5% займає google_analytics, 65,9% — googleapis.com, 63,3% — gstatic, 58,3% — google_fonts, 50,0% — doubleclick, 47,6% — google, 42,4% — google_tag_manager, 30,9% — facebook, 19,2% — google_adservices та 12,7% — cloudflare.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=850649042&format=interactive",
  sheets_gid="1677398038"
  )
}}

Найбільшим гравцем на ринку онлайн трекінгу є, безперечно, Google з вісьмома доменами серед топ-10 потенційних відстежувачів і присутністю щонайменше на 70% веб-сайтів. За ними слідує Facebook та Cloudflare, хоча останній найімовірніше відображує його популярність як хостингу.

Список трекерів від WhoTracksMe також визначає категорії, до яких належать відстежувачі. Якщо виключити CDN-и та хостинг-сайти зі статистики, припускаючи, що вони не відстежують, або принаймні це не є їх основною функцією, отримаємо дещо інший погляд на топ-10.

{{ figure_markup(
  image="privacy-biggest-third-party-trackers.png",
  caption="Топ-10 трекерів",
  description="Гістограма показує 10 найпопулярніших трекерів, що використовуються мобільними та настільними клієнтами. Різниця між клієнтами невелика.  На мобільних 65,5% займає google_analytics, 50,0% — doubleclick, 47,6% — google, 42,4% — google_tag_manager, 30,9% — facebook, 19,2% — google_adservices, 12,7% — youtube, 19,2% — google_syndication і по 6,5% — twitter та wordpress_stats.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1831606887&format=interactive",
  sheets_gid="1677398038"
  )
}}

Google все ще має 7 з топ-10 доменів. Наступний графік показує поширення різних категорій для 100 найбільших потенційних трекерів за категоріями.

{{ figure_markup(
  image="privacy-tracker-categories.png",
  caption="Категорії 100 найпопулярніших потенційних трекерів",
  description="Гістограма показує поширення 100 потенційних трекерів в інтернеті, серед яких 56 належать до реклами, 11 — до cdn, 9 — до аналітики_сайту, 6 — до соціальних медіа та різного, 3 — до базових та допомоги_клієнтам, 2 — до аудіо та відео і 1 — до коментарів та невизначено.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1117413918&format=interactive",
  sheets_gid="1431872451",
  )
}}

Майже 60% популярних трекерів стосуються реклами. Це може бути причиною високої дохідності ринку онлайн реклами, що сприймається у відношенні до кількості трекінгу.

### Файли «cookies»

Ми переглянули найпопулярніші файли «cookies», додані з допомогою заголовку HTTP відповіді, згідно з їхніми іменами та доменами.

<figure>
  <table>
    <thead>
      <tr>
        <th>Домен</th>
        <th>Ім’я файлу</th>
        <th>Веб-сайти</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">24%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>unknown</td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">9%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>unknown</td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td>unknown</td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Найпопулярніші файли «cookies» на настільних веб-сайтах", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Домен</th>
        <th>Ім’я файлу</th>
        <th>Веб-сайти</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>doubleclick.net</td>
        <td><code>test_cookie</code></td>
        <td class="numeric">32%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>IDE</code></td>
        <td class="numeric">21%</td>
      </tr>
      <tr>
        <td>facebook.com</td>
        <td><code>fr</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>VISITOR_INFO1_LIVE</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>YSC</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>google.com</td>
        <td><code>NID</code></td>
        <td class="numeric">10%</td>
      </tr>
      <tr>
        <td>youtube.com</td>
        <td><code>GPS</code></td>
        <td class="numeric">8%</td>
      </tr>
      <tr>
        <td>doubleclick.net</td>
        <td><code>DSID</code></td>
        <td class="numeric">7%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>yandexuid</code></td>
        <td class="numeric">6%</td>
      </tr>
      <tr>
        <td>yandex.ru</td>
        <td><code>i</code></td>
        <td class="numeric">6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Найпопулярніші файли «cookies» на мобільних веб-сайтах", sheets_gid="732942035", sql_file="top100_cookies_set_from_header.sql") }}</figcaption>
</figure>

Як можна побачити, домен для відстеження від Google «doubleclick.net» додає файли «cookies» майже на чверть мобільних веб-сайтів та на третину настільних. І знову ж 9 з 10 найпоширеніших файлів на настільних та 7 з 10 на мобільних клієнтах встановлюються доменом Google. Це найнижча межа кількості веб-сайтів, на яких додаються куки, оскільки ми тільки враховуємо файли, які встановлюються HTTP заголовком. Величезна кількість файлів «cookies» для відстеження додаються, використовуючи сторонні скрипти.

### Фінґерпринтинг

Іншою поширеною технікою для відстеження є фінґерпринтинг. Він являє собою збирання різної інформації про користувача з метою створення унікального «відбитку» для його ідентифікації. Трекери використовують різні види фінґерпринтингу. Браузерний  фінґерпринтинг використовує характеристики, специфічні для браузера користувача, спираючись на той факт, що шанс отримати тотожні налаштування браузера для іншого користувача доволі низький, якщо кількість змінних для відстеження достатньо велика. У нашому аналізі ми перевіряли наявність бібліотеки <a hreflang="en" href="https://fingerprintjs.com/">FingerprintJS</a>, яка надає браузерний фінґерпринтинг як сервіс.

{{ figure_markup(
  image="privacy-websites-with-fingerprintjs-library.png",
  caption="Веб-сайти, що використовують FingerprintJS",
  description="Гістограма показує. Що 0,17% настільних та 0,18% мобільних веб-сайтів використовують  FingerprintJS.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=1556252953&format=interactive",
  sheets_gid="222110824",
  sql_file="percent_of_websites_with_fingerprinting.sql "
  )
}}

Хоча цю бібліотеку і використовує невелика кількість веб-сайтів, стійкий характер фінґерпринтингу означає, що навіть незначне використання може мати надзвичайний вплив. До того ж FingerprintJS — не єдина спроба фінґерпринтингу. Інші бібліотеки, інструменти та нативний код також можуть виконувати цю функцію, тож це лише один приклад.

## Платформи керування згодою

Банери щодо згоди на використання файлів «cookies» стали звичною справою. Вони роблять використання куків прозорішим та часто дозволяють користувачам визначати власні вподобання. Хоча багато сайтів створюють власні банери щодо використання файлів «cookies», останнім часом стали з’являтися сторонні рішення, які називають платформами керування згодою. Ці платформи стають простим способом для веб-сайтів збирати згоди користувачів для використання різних типів кук. Ми бачимо, що 4,4% веб-сайтів використовують платформи керування згодою, щоб визначати вподобання користувачів щодо файлів «cookies» на настільних клієнтах та 4,0% — на мобільних.

{{ figure_markup(
  image="privacy-websites-with-consent-management-platform.png",
  caption="Веб-сайти, які використовують платформи керування згодою",
  description="Гістограма показує, що 4,4% настільних сайтів та 4,0% мобільних використовують платформи керування згодою.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=2025542332&format=interactive",
  sheets_gid="1910033502",
  sql_file="percent_of_websites_with_cmp.sql"
  )
}}

{{ figure_markup(
  image="privacy-consent-management-platform-popularity.png",
  caption="Популярність платформ керування згодою",
  description="Гістограма показує популярність платформ керування згодою від Osano на 1,6% веб-сайтів, Quantcast Choice на 1,0%, Cookiebot та OneTrust на 0,4%, Iubenda на 0,3%, Crownpeak, Didomi та TrustArc на 0,1% веб-сайтів, CIVIC, Cookie Script, CookieHub, Termly, Uniconsent, CookieYes, eucookie.eu, Seers та Metomic на приблизно 0,0% веб-сайтів.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341496718&format=interactive",
  sheets_gid="1104760876",
  sql_file="percent_of_websites_using_each_cmp.sql"
  )
}}

Порівнюючи популярність різних платформ керування згодою, ми бачимо, що Osano та Quantcast Choice лідирують серед інших.

### Transparency Consent Framework від IAB Europe

IAB Europe (Interactive Advertising Bureau, або Бюро Інтерактивної Реклами) — це європейська асоціація цифрового маркетингу та реклами. Вони запропонували <a hreflang="en" href="https://iabeurope.eu/transparency-consent-framework/">Transparency Consent Framework</a> (TCF) як рішення для отримання дозволу користувачів на збереження їхніх налаштувань щодо цифрової реклами, що відповідає стандартам GDPR. Слідування цьому фреймворку створює стандарт для індустрії у комунікації між видавцями та рекламодавцями щодо згоди споживача.

{{ figure_markup(
  image="privacy-adoption-of-the-tcf-banner.png",
  caption="Рівень прийняття банерів TCF",
  description="Гістограма показує, що 1,5% настільних та 1,4% мобільних веб-сайтів реалізували TCF банер від IAB Europe.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=341275612&format=interactive",
  sheets_gid="2077755325",
  sql_file="percent_of_websites_with_iab_tcf_banner.sql"
  )
}}

Хоча наші результати показують, що TCF банер ще не став «стандартом для індустрії», це вже є кроком у правильному напрямку. Враховуючи, що основною цільовою групою для IAB Europe є фактично європейські видавці, а наша вибірка є глобальною, отримати рівень прийняття у 1,5% настільних веб-сайтів та 1,4% у мобільних — це все дуже непогано.

## Політика конфіденційності

Політика конфіденційності широко використовується веб-сайтами для виконання юридичних зобов’язань та підвищення прозорості перед користувачами щодо збирання даних. Для нашої вибірки ми шукали ключові слова, які б вказували на наявність політики конфіденційності на кожному веб-сайті, який ми відвідали.

{{ figure_markup(
  image="privacy-websites-with-privacy-link.png",
  caption="Веб-сайти, які мають політику конфіденційності",
  description="Гістограма показує, що 44,8% настільних веб-сайтів та 42,3% мобільних мають посилання на політику конфіденційності.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQJMtHv0Y1JcQJkcVyrqBk9dsujZeDtOZEv7uvE0xM2VrQSuTUDFya41TeRlTZDDe2rWmHwDghW3Dev/pubchart?oid=329249623&format=interactive",
  sheets_gid="495362514",
  sql_file="percent_of_websites_with_privacy_links.sql "
  )
}}

Результати показують, що майже половина веб-сайтів у наборі даних має сторінку з політикою конфіденційності, що є однозначно позитивним моментом. Однак дослідження показують, що більшість користувачів інтернету не завдають собі клопоту читанням політики конфіденційності, а коли і роблять це, то не все розуміють через велику кількість тексту та його складність. І все ж наявність політики конфіденційності є кроком у правильному напрямку!

## Висновок

Цей розділ показав, що сторонні трекери залишаються помітними як на настільних, так і на мобільних клієнтах, а Google відстежує найбільший відсоток веб-сайтів. Платформи керування згодою використовуються мізерною кількістю веб-сайтів, хоча доволі багато сайтів створюють власні банери щодо згоди на використання файлів «cookies».

Наостанок, майже половина веб-сайтів має сторінку з політикою конфіденційності, що підвищує прозорість для користувачів щодо обробки їхніх даних. Без сумніву, це крок вперед, але роботи все ще багато. За межами цього аналізу ми розуміємо, що політику конфіденційності важко читати, а банери щодо згоди на використання файлів «cookies» маніпулюють користувачами, щоб отримати їхній дозвіл.

Для того, щоб інтернет справді поважав користувачів, конфіденційність має бути частиною концепції, а не останньою думкою. Регулювання — це добре в даному питанні, заспокоює, коли бачиш підвищення регулювання у сфері конфіденційності по всьому світу. <a hreflang="en" href="https://en.wikipedia.org/wiki/Privacy_by_design">Навмисна конфіденційність</a> має бути нормою, а не додаванням політик та інструментів в останній момент, щоб відповідати мінімальним юридичним вимогам й уникати штрафів.
