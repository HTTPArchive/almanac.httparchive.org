---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: セキュリティ
description: 2025年版Web Almanacのセキュリティチャプターは、トランスポート層セキュリティ、コンテンツインクルージョン（CSP、SRI、パーミッションポリシー）、ウェブ防御メカニズム（XSS・XS-Leaks対策）、セキュリティ機構の採用促進要因、セキュリティの誤設定を取り上げます。
hero_alt: Web Almanacのキャラクターがウェブページに南京錠をかけ、別のキャラクターたちがボルトカッターを持った覆面の泥棒を取り押さえているヒーロー画像。
authors: [vikvanderlinden, GJFR]
reviewers: [anirudhduggal, martinakraus, GJFR, clarkio, JannisBush, securient]
analysts: [vsdaan]
editors: [tunetheweb]
translators: [ksakae1216]
GJFR_bio: Gertjan Frankenは、KU Leuvenの<a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNet研究グループ</a>のポスドク研究員です。ウェブセキュリティとプライバシーの様々な側面を研究しており、特にブラウザセキュリティポリシーの自動分析に注力しています。この研究の一環として、バグのライフサイクルを特定するオープンソースツール<a hreflang="en" href="https://github.com/DistriNet/BugHog">BugHog</a>を管理しています。
vikvanderlinden_bio: Vik VanderlindenはKU Leuvenの<a hreflang="en" href="https://distrinet.cs.kuleuven.be/">DistriNet研究グループ</a>のコンピュータサイエンス博士課程の学生です。ウェブとネットワークセキュリティの研究に取り組んでおり、特にウェブアプリケーションとプロトコルにおけるタイミングリークに注力しています。
results: https://docs.google.com/spreadsheets/d/1TLYRfNRbFu4fWwWvG4zhcRXkQ8-aZTxszgsEWjYATpA/edit
featured_quote: このセキュリティチャプターは、ウェブセキュリティポリシーの採用において前向きな傾向を示しています。こうした前向きな傾向にもかかわらず、開発者はこれらのセキュリティ機構を活用する際に引き続き注意を払う必要があります。利用可能なセキュリティ機構の複雑さが増す中で、ウェブ上の誤設定の数が増加しました。ポリシー立案者は、開発者の混乱を避けるためにこれらの新しい機構の複雑さを低減することに注力する必要があります。
featured_stat_1: 98.8%
featured_stat_label_1: HTTPSを使用するリクエストの割合
featured_stat_2: 84%
featured_stat_label_2: ワイルドカード文字に設定されたTiming-Allow-Originヘッダーの割合
featured_stat_3: +50%
featured_stat_label_3: パーミッションポリシーの採用増加率
doi: 10.5281/zenodo.18246555
---

## はじめに

多くの人々の生活のますます多くの部分がオンラインに移行するにつれて、個人データも同様にオンライン化されており、ウェブセキュリティはかつてないほど重要になっています。日常的に使用する多くのシステムは、データを盗もうとしたり混乱を引き起こそうとする攻撃者にとって依然として魅力的なターゲットとなっています。今年もまた、現代の脅威の規模と複雑さが示されました。DDoS攻撃の規模と頻度は増加し続けており、記録された最大の攻撃は<a hreflang="en" href="https://blog.cloudflare.com/radar-2025-year-in-review/#hyper-volumetric-ddos-attack-sizes-grew-significantly-throughout-the-year">11月に31.4 Tbpsに達しました</a>。サプライチェーンの脆弱性は前例のない規模に拡大し、<a hreflang="en" href="https://www.hackerone.com/blog/shai-hulud-2-npm-worm-supply-chain-attack">Shai-Hulud 2.0攻撃</a>は1,000以上のnpmパッケージを侵害し、27,000以上のGitHubリポジトリに感染したと報告されています。また、<a hreflang="en" href="https://www.microsoft.com/en-us/security/blog/2025/12/15/defending-against-the-cve-2025-55182-react2shell-vulnerability-in-react-server-components/">React2Shell</a>として知られるReactの重大な脆弱性により、開発者はアプリケーションの迅速な更新に追われました。

本チャプターでは、ウェブを保護することを目的とした仕組みと、様々な理由によりそれらが機能しない場合について分析します。Transport Layer Security（TLS）やサードパーティコンテンツインクルージョンに対する保護などのウェブセキュリティの核心要素を探ります。これらのセキュリティ対策の採用がどのように進化しているか、攻撃防止にどのように役立っているか、そして誤設定がどのように適切な機能を妨げるかについて解説します。さらに、セキュリティに関連するいくつかのwell-known URIも分析します。

採用状況の測定だけでなく、場所、技術スタック、ウェブサイトの業種など、セキュリティ機構の採用を促進する要因も探ります。Web Almanacの過去のエディションのデータと比較することで、ウェブセキュリティの状態における長期的なトレンドと変化を把握することができます。

## トランスポートセキュリティ

[HTTPS](https://developer.mozilla.org/docs/Glossary/https)は<a hreflang="en" href="https://www.cloudflare.com/en-gb/learning/ssl/transport-layer-security-tls/">Transport Layer Security（TLS）</a>を使用してクライアントとサーバー間の接続を保護します。年々、HTTPSを使用するウェブサイトが増加し、ユーザーのセキュリティが向上しています。今年、HTTPS経由で送信されるすべてのリクエストの割合は前年比で再び上昇し、モバイル接続で98.8%を超えました。

{{ figure_markup(
  content="98.8%",
  caption="HTTPSを使用するリクエストの割合（モバイル）。",
  classes="big-number",
  sheets_gid="530740578",
  sql_file="https_request_over_time.sql",
) }}

平文のHTTPではなくHTTPSを使用して送信されるリクエストの割合は100%に近づき続けており、[2024年版Web Almanac](../2024/security#fig-1)と比較してモバイルでさらに0.74%上昇しました。

{{ figure_markup(
  image="https-usage.png",
  caption="HTTPSを使用するホームページの割合。",
  description="デスクトップとモバイルデバイスでのセキュア接続の採用率を示す棒グラフ。セキュリティはほぼ普遍的で、デスクトップサイトの97.5%、モバイルサイトの97.3%がHTTPSを使用してユーザーデータを保護しています。これは、非暗号化HTTP接続が全トラフィックのわずか3%未満に留まる、非常に安全なウェブ環境を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2075189160&format=interactive",
  sheets_gid="479242437",
  sql_file="home_page_https_usage.sql"
  )
}}

HTTPS経由で提供されるホームページの数にも前向きな進化が見られます。この数字はモバイルで95.6%から97.3%に上昇しました。多くのウェブサイトが多数の（多くの場合セキュアな）サイトへのサードパーティリクエストを送信するため、この数値はHTTPS経由で送信されるリクエストの割合よりも低くなる傾向がありますが、幸いにも毎年上昇し続けています。

これらの指標で前向きなトレンドが続き、HTTPSを使用するサイトの割合が100%に近づいていることは喜ばしいことです。これらの高い数値の一部は、ブラウザベンダー（<a hreflang="en" href="https://blog.chromium.org/2021/07/increasing-https-adoption.html#:~:text=Beginning%20in%20M94%2C%20Chrome%20will%20offer%20HTTPS%2DFirst%20Mode">Chrome</a>、<a hreflang="en" href="https://support.mozilla.org/en-US/kb/https-first">Firefox</a>、<a hreflang="en" href="https://webkit.org/blog/16301/webkit-features-in-safari-18-2/#security-and-privacy">Safari</a>）が平文のHTTPにフォールバックする前にまずHTTPSで通信しようとし、ユーザーにセキュリティ警告を表示することが多いことで、サイトオーナーにTLSの採用を促していることで説明できます。

### プロトコルバージョン

ここ数年、<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8446">TLS1.3</a>は最高のセキュリティを実現するための推奨プロトコルバージョンとなっています。最新バージョンはTLS1.2で<a hreflang="en" href="https://www.cloudflare.com/en-in/learning/ssl/why-use-tls-1.3/#:~:text=A%20number%20of%20outdated%20cryptography%20features%20resulted%20in%20vulnerabilities%20or%20enabled%20specific%20kinds%20of%20cyber%20attacks">欠陥が発見されたアルゴリズムを廃止</a>し、前方秘匿性などのより強固なセキュリティ保証を提供します。QUICも内部的にTLSを使用しており、<a hreflang="en" href="https://community.cloudflare.com/t/how-is-quic-a-direct-comparison-to-tls-1-3-and-tls-1-2/543349/6#:~:text=TLS%201.2%2C%20TLS%201.3%2C%20and%20QUIC%20share%20similar%20security%20characteristics%20but%20they%20are%20different">TLS1.3と同様のセキュリティ保証を提供</a>しています。

{{ figure_markup(
  image="tls-versions.png",
  caption="使用中のTLSバージョンの分布。",
  description="デスクトップとモバイルデバイスでウェブトラフィックを保護するために使用されている異なる暗号化プロトコルのシェアを示す棒グラフ。TLS 1.3が明確な標準で、全ウェブページの約76%を占めており、次いでTLS 1.2が約13〜15%のシェアを占めています。特に、最新のQUICプロトコル（HTTP/3に関連することが多い）はデスクトップ（9.5%）と比べてモバイル（10.8%）でわずかに高い存在感を示す、成長中のセキュアトラフィックセグメントを表しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1659150103&format=interactive",
  sheets_gid="902024133",
  sql_file="tls_versions_pages.sql"
  )
}}

[2024年版Web Almanac](../2024/security#プロトコルのバージョン)と同様に、QUICとTLS1.3の両方で使用が増加していることが分かります。TLS1.2を使用していた一部のサイトがTLS1.3に移行し、TLS1.2またはTLS1.3を使用していた一部のサイトがQUICに移行したと考えられます。TLS1.2は今年さらに4.5%減少しました。今年はQUICの採用がやや鈍化し、QUICを使用するサイトの割合は0.8%しか上昇しませんでした。将来的にはTLS1.2が（長い時間をかけて）徐々に廃止され、QUICが引き続き普及していくと予想されます。

### 暗号スイート

暗号化されたチャネルでの通信を開始するには、双方が同じ暗号アルゴリズム（または<a hreflang="en" href="https://learn.microsoft.com/en-au/windows/win32/secauthn/cipher-suites-in-schannel">暗号スイート</a>）を使用してお互いを理解する必要があります。そのため、通信前に使用する暗号スイートに合意します。ほとんどのリクエストは[Galois Counter Mode（GCM）](https://www.wikipedia.org/wiki/Galois/Counter_Mode)暗号を使用した接続で行われていることが分かります。これは<a hreflang="en" href="https://blog.qualys.com/product-tech/2019/04/22/zombie-poodle-and-goldendoodle-vulnerabilities">パディング攻撃</a>への耐性と、<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8446#:~:text=Those%20that%0A%20%20%20%20%20%20remain%20are%20all%20Authenticated%20Encryption%20with%20Associated%20Data%0A%20%20%20%20%20%20(AEAD)%20algorithms">TLS1.3で必須とされている</a><a hreflang="en" href="https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=2628d946bda9f3d3b087e5c4846e76ae0fb07b6b">関連データ付き認証暗号化（AEAD）</a>の提供により好まれています。また、より安全な256ビット版ではなく、128ビット鍵の使用が前年比4%増加していることも分かります。<a hreflang="en" href="https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-131Ar3.ipd.pdf">NISTは128ビット暗号スイートをセキュアとみなしています</a>が、256ビット版はさらに強力なセキュリティ保証を提供します。今年のAlmanacのデータセットには前年よりも多くのリクエストが含まれているため、この変化はデータセットの拡大に起因する可能性があります。使用中の暗号スイートはあまり多様ではなく、実際にデータセットで使用が確認された暗号スイートはわずか5種類です。これはTLS1.3が<a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8446#page-133">GCMまたは最新のブロック暗号のみを許可</a>しているためと考えられます。

{{ figure_markup(
  image="cipher-suites.png",
  caption="使用中の暗号スイートの分布。",
  description="AES_128_GCM暗号化標準が圧倒的に優勢で、デスクトップとモバイルの両プラットフォームでのHTTPSリクエスト全体の82.8%を保護していることを示す棒グラフ。`AES_256_GCM`が2番目に一般的なスイートで、トラフィックの約16.1%を占めており、`CHACHA20_POLY1305`などの最新の代替手段や`AES_256_CBC`などのレガシーモードはウェブ接続のごく一部（1%未満）を占めるに過ぎません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=220138440&format=interactive",
  sheets_gid="209958900",
  sql_file="tls_cipher_suite.sql"
  )
}}

TLS1.3は[前方秘匿性](https://www.wikipedia.org/wiki/Forward_secrecy)をサポートするアルゴリズムのみを許可しています。TLS1.3の高い採用率から、多くのリクエストが前方秘匿性の要件を満たすことが期待されます。

{{ figure_markup(
  image="forward-secrecy.png",
  caption="前方秘匿性をサポートするリクエストの割合。",
  description="デスクトップのHTTPSリクエストの約75.8%、モバイルの75.1%が前方秘匿性を利用していることを示す棒グラフ。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1624420318&format=interactive",
  sheets_gid="596349024",
  sql_file="tls_forward_secrecy.sql"
  )
}}

予想に反して、前方秘匿性のある接続で送信されるリクエストの数が比較的少ないことが分かります。[2024年版Web Almanac](../2024/security#fig-5)以降、前方秘匿性リクエストは20%減少しています。現在、このメトリクスにはTLS1.2とTLS1.3の前方秘匿性暗号のみが含まれており、QUICのTLSは含まれていないようで、これが確認された低下の説明となる可能性があります。

### 認証局

TLSを使用するためには、サイトは<a hreflang="en" href="https://www.ssl.com/faqs/what-is-a-certificate-authority/">認証局（CA）</a>から証明書を取得する必要があります。ブラウザが多数のCAを信頼しているため、サイトの証明書はブラウザによって有効な証明書として識別されます。その後、証明書はブラウザとサイトのサーバー間の安全な通信に使用されます。

<figure>
  <table>
    <thead>
      <tr>
        <th>発行者</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>R11</td>
        <td class="numeric">20.80%</td>
        <td class="numeric">21.86%</td>
      </tr>
      <tr>
        <td>R10</td>
        <td class="numeric">20.75%</td>
        <td class="numeric">21.73%</td>
      </tr>
      <tr>
        <td>WE1</td>
        <td class="numeric">16.35%</td>
        <td class="numeric">17.24%</td>
      </tr>
      <tr>
        <td>E6</td>
        <td class="numeric">4.50%</td>
        <td class="numeric">4.65%</td>
      </tr>
      <tr>
        <td>E5</td>
        <td class="numeric">4.31%</td>
        <td class="numeric">4.42%</td>
      </tr>
      <tr>
        <td>Sectigo RSA Domain Validation Secure Server CA</td>
        <td class="numeric">3.60%</td>
        <td class="numeric">3.52%</td>
      </tr>
      <tr>
        <td>Go Daddy Secure Certificate Authority - G2</td>
        <td class="numeric">1.77%</td>
        <td class="numeric">1.60%</td>
      </tr>
      <tr>
        <td>WR1</td>
        <td class="numeric">1.16%</td>
        <td class="numeric">1.40%</td>
      </tr>
      <tr>
        <td>Amazon RSA 2048 M02</td>
        <td class="numeric">1.37%</td>
        <td class="numeric">1.33%</td>
      </tr>
      <tr>
        <td>Amazon RSA 2048 M03</td>
        <td class="numeric">1.30%</td>
        <td class="numeric">1.25%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="発行者ごとの証明書発行割合（上位10件）", sheets_gid="215876282", sql_file="tls_ca_issuers_pages.sql") }}</figcaption>
</figure>

前年と比較すると、当時人気だった<a hreflang="en" href="https://letsencrypt.org/">Let's Encrypt</a>のR3中間証明書が発行者として消えていることが分かります。これは<a hreflang="en" href="https://crt.sh/?id=3334561879">（2025年9月に）期限切れになった</a>ため予想されていたことで、前年からすでに他の中間証明書への移行が始まっていました。<a hreflang="en" href="https://letsencrypt.org/2024/03/19/new-intermediate-certificates.html">R10とR11の中間証明書</a>がR3を引き継ぐ新しい証明書です。現在、<a hreflang="en" href="https://letsencrypt.org/2024/03/19/new-intermediate-certificates.html#rotating-issuance">中間鍵のピン留めを防ぐことを明示的な目標</a>として、2つの中間RSA証明書（R10とR11）と2つの中間ECDSA証明書（E5とE6）があります。上位5発行者の中でLet's Encrypt以外の唯一の証明書はWE1で、<a hreflang="en" href="https://pki.goog/">Google Trust Services（GTS）</a>のものです。リストにはGTSのWR1も含まれています。これらの証明書はGTSの新世代中間証明書の一部であり、前年に見られたGTS CA 1P5発行者などが期限切れになっています。

{{ figure_markup(
  content="52.6%",
  caption="Let's Encryptが発行したモバイルページの割合。",
  classes="big-number",
  sheets_gid="215876282",
  sql_file="tls_ca_issuers_pages.sql",
) }}

Let's Encryptの証明書を使用するサイトの総シェアは、前回の56%からわずかに低下して52.6%になりました。データから分かるように、GTSのWE1証明書が発行する証明書のシェアが増加していることが一因として挙げられます。ただし、GTSが発行した証明書（WE1他）の総シェアは計算されていません。

### HTTP Strict Transport Security

[HTTP Strict Transport Security](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security)は、サーバーがブラウザに対して、まずHTTPを試みてHTTPSへのリダイレクトに従うのではなく、このドメインのページにはHTTPSのみでアクセスするよう指示できるレスポンスヘッダーです。

{{ figure_markup(
  content="36%",
  caption="モバイルでHSTSヘッダーを使用するページの割合。",
  classes="big-number",
  sheets_gid="1439302553",
  sql_file="hsts_attributes.sql",
) }}

HSTSヘッダーを使用するページ数は引き続き増加しており、[前回のエディション](../2024/security#fig-8)と比較して6ポイント上昇し、モバイルで訪問された全ページの36%に達しています。

サーバーはヘッダーにいくつかのディレクティブを含めて、ブラウザに追加の設定を伝えることができます。例えば、`max-age` ディレクティブはブラウザにHTTPSのみを使用し続ける期間を伝えます。他のディレクティブ `includeSubDomains` と `preload` はオプションです。

{{ figure_markup(
  image="hsts-directives.png",
  caption="指定されたHSTSディレクティブの使用状況。",
  description="デスクトップとモバイルプラットフォームでのセキュリティヘッダーの設定を示す棒グラフ。これらのウェブサイトの96%近くがブラウザがセキュア接続を強制する期間を指定するための有効な`max-age`ディレクティブを使用しており、4%のみがポリシーを無効にするためにmax-ageをゼロに設定しています。高度なセキュリティ機能の採用率は大幅に低く、サブドメインを保護しているサイトは約40%、最初の訪問からセキュア接続を確保するためにpreloadディレクティブを使用しているサイトは約22%に留まっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1721543402&format=interactive",
  sheets_gid="1439302553",
  sql_file="hsts_attributes.sql"
  )
}}

有効な `max-age` を持つレスポンスのシェアは96%にわずかに増加しました。`includeSubdomains` と `preload` ディレクティブはそれぞれ約4%増加しており、一部のサイトが両方のディレクティブを同時に設定し始めたことを示している可能性があります。[非公式](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security#preloading_strict_transport_security)の `preload` ディレクティブには `includeSubdirectories` の設定と `max-age` が少なくとも1年の値を持つことが必要です。`preload` ディレクティブを使用することで、サイトはブラウザが初回接続時でもドメインとそのサブドメインに常にHTTPSでアクセスすることを保証できます（preloadなしのHSTSを使用する場合は必ずしもそうとは限りません）。

{{ figure_markup(
  image="hsts-max-age.png",
  caption="パーセンタイル別のHSTSの`max-age`値の分布。",
  description="デスクトップとモバイルプラットフォームでのHTTP Strict Transport Security（HSTS）の期間設定の分布を示す棒グラフ。中央値（50パーセンタイル）は両デバイスタイプで365日で、ほとんどの管理者がちょうど1年間のセキュア接続を強制していることを示しています。90パーセンタイルではこの値が730日に倍増し、下位では10パーセンタイルで最低基準として91日が示されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1532336378&format=interactive",
  sheets_gid="1684013271",
  sql_file="hsts_max_age_percentiles.sql"
  )
}}

有効な `max-age` 値の分布は、低いパーセンタイルを除いてほぼ同じままです。10パーセンタイルでは30日から91日へと大きな増加が見られ、非常に低い `max-age` 値を設定するサイトが減少していることを示しています。中央値は1年つまり365日のままです。

## クッキー

クッキーはウェブの重要な部分です。クッキーはウェブサイトが複数のステートレスなリクエストにわたって情報を保存できるようにします。サイトのクッキーを保護するために、[Cookies](./cookies)チャプターで詳しく報告されている多くのブラウザ組み込み機能があります。このチャプターでは特に[クッキー属性](./cookies#クッキー属性)、[クッキープレフィックス](./cookies#クッキープレフィックス)、[永続性（有効期限）](./cookies#永続性有効期限)のセクションを参照します。

## コンテンツインクルージョン

コンテンツインクルージョンはウェブのコアコンポーネントです。[コンテンツデリバリーネットワーク（CDN）](./cdn)からのページ、CSS、JavaScriptや共有ソースからの画像をインクルードできることは、ウェブが構築された基盤の一つです。しかし、これにはサードパーティのコンテンツをインクルードするサイトがそれらのサードパーティリソースに多大な信頼を置くなど、特定のリスクが伴います。もちろん、そのリソースが悪意を持っていないか、悪意のある攻撃者によって侵害されていないという保証はなく、これはサプライチェーン攻撃など多くの深刻な攻撃につながる可能性があります。このリスクを軽減するために、コンテンツインクルージョンを制御するセキュリティポリシーを使用することが重要です。

### コンテンツセキュリティポリシー

[コンテンツセキュリティポリシー（CSP）](https://developer.mozilla.org/docs/Web/HTTP/CSP)は、ウェブサイトがそのページにロードされるコンテンツをきめ細かく制御できるようにします。`Content-Security-Policy` レスポンスヘッダーを設定するか、`<meta>` HTMLタグで定義することで、ウェブサイトは使用中のポリシーをブラウザに伝え、ブラウザはそれを強制します。ポリシーには多くの利用可能なディレクティブがあり、ウェブサイトがどのソースからコンテンツをロードできるかを定義できます。

CSPは特定のリソースのロードをブロックするために使用でき、潜在的なクロスサイトスクリプティング（XSS）攻撃の影響を軽減するのに役立ちます。さらに CSP は、`update-insecure-requests` ディレクティブによる暗号化通信チャネルの使用の強制や、`frame-ancestors` ディレクティブを使用した現在のページがサブリソースとしてロードできるページの制御など、他の目的にも使用できます。これにより、ウェブサイトはクリックジャッキング攻撃から防御できます。

{{ figure_markup(
  content="+18%",
  caption="2024年からの`Content-Security-Policy`ヘッダーの採用率の相対的な増加。",
  classes="big-number",
  sheets_gid="136009485",
  sql_file="security_headers_prevalence.sql",
) }}

CSPの採用は[昨年の18.5%](../2024/security#コンテンツセキュリティポリシー)から今年の21.9%へと引き続き増加しており、20%近い増加です。Web Almanacの前回版で予測されたように、採用率は20%を超え、引き続き着実に上昇していることを示しています。

#### ディレクティブ

{{ figure_markup(
  image="csp-directives.png",
  caption="CSPで最もよく使用されるディレクティブ。",
  description="デスクトップとモバイルウェブページでのさまざまなコンテンツセキュリティポリシー（CSP）ディレクティブの採用頻度を示す棒グラフ。最も普及しているディレクティブは`upgrade-insecure-requests`と`frame-ancestors`で、セキュア接続の管理とクリックジャッキングの防止のために、CSPヘッダーの約50〜55%に存在します。デスクトップサイトは一般的に従来のディレクティブ使用でリードしていますが、モバイルサイトは`trusted-types`や`report-uri`などの最新セキュリティ機能で大幅に高い採用率を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=579658502&format=interactive",
  sheets_gid="1683734522",
  sql_file="csp_directives_usage.sql"
  )
}}

今年も多くのウェブサイトがCSPを `upgrade-insecure-requests` と `frame-ancestors` ディレクティブのために使用しています。これらのディレクティブを使用するモバイルサイトの相対的なシェアはわずかに減少しましたが、これはスキャンされたCSPヘッダーの数が多いことに起因していると考えられます。絶対数はデスクトップとモバイルでそれぞれ40万と80万のCSPヘッダーが増加しています。

`upgrade-insecure-requests` に置き換えられた `block-all-mixed-content` ディレクティブは、ここ数年と同様に引き続きわずかに減少しています。このディレクティブは[非推奨](https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Content-Security-Policy/block-all-mixed-content)なので、これは良いニュースです。

<figure>
  <table>
    <thead>
      <tr>
        <th>ポリシー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>upgrade-insecure-requests</code></td>
        <td class="numeric">21.45%</td>
        <td class="numeric">22.79%</td>
      </tr>
      <tr>
        <td><code>block-all-mixed-content; frame-ancestors 'none'; upgrade-insecure-requests;</code></td>
        <td class="numeric">19.92%</td>
        <td class="numeric">18.06%</td>
      </tr>
      <tr>
        <td><code>require-trusted-types-for 'script';report-uri /checkin/_/AndroidCheckinHttp/cspreport</code></td>
        <td class="numeric">2.67%</td>
        <td class="numeric">12.10%</td>
      </tr>
      <tr>
        <td><code>frame-ancestors 'self'</code></td>
        <td class="numeric">7.55%</td>
        <td class="numeric">6.38%</td>
      </tr>
      <tr>
        <td><code>upgrade-insecure-requests;</code></td>
        <td class="numeric">4.92%</td>
        <td class="numeric">4.30%</td>
      </tr>
      <tr>
        <td><code>frame-ancestors 'self';</code></td>
        <td class="numeric">2.53%</td>
        <td class="numeric">2.29%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="最も普及しているCSPヘッダー", sheets_gid="1551197242", sql_file="csp_most_common_header.sql") }}</figcaption>
</figure>

昨年上位3位にあったのと同じヘッダー値が今年の上位4位にも登場しています。ただし、今年の3番目に一般的なCSPヘッダーは新しいものです。この変化は、今年は昨年のようにデスクトップ使用率ではなくモバイル使用率で最も一般的なヘッダーをソートしているためです。Android関連の特定の `report-uri` エンドポイントを持つtrusted typesポリシーが3位に現れています。

<a hreflang="en" href="https://w3c.github.io/trusted-types/dist/spec/">Trusted types</a>は、インジェクションシンク（`element.innerHTML`など）に渡されるパラメータを制限し、プレーン文字列の代わりに適切に型付けされた値のみが渡されるようにするために使用できます。インジェクションシンクに渡される値を制限することで、多くの潜在的なDOM XSS脆弱性を防ぐことができます。観察されたtrusted typesヘッダーはモバイルページの12%以上に表示されています。この特定のCSPポリシー値の高い使用率については直接的な説明はありません。

5位と6位では、`upgrade-insecure-requests` と `frame-ancestors 'self'` ディレクティブが再び登場しますが、今回は末尾にセミコロンがついています。セミコロンはディレクティブを区切るために使用されますが、定義されているディレクティブが1つだけの場合は<a hreflang="en" href="https://w3c.github.io/webappsec-csp/#grammardef-serialized-policy">廃棄することができ</a>、どちらのヘッダー値も同じ効果を持つ有効なCSPポリシーです。

#### `script-src` のキーワード

CSPに含まれる最も重要なディレクティブの一つは `script-src` です。このディレクティブを使用することで、ウェブサイトはどのスクリプトがページで実行できるかを制御できます。これは攻撃者が任意のスクリプトを実行するのを妨げることができるため、攻撃者を抑制することができます。`script-src` には複数の潜在的なキーワードがあります。

{{ figure_markup(
  image="csp-script-src-keywords-per-request.png",
  caption="リクエストごとのCSP`script-src`キーワードの普及率。",
  description="`script-src`属性の使用状況を示す棒グラフ。デスクトップとモバイルの両方でウェブサイトの圧倒的な92%が`unsafe-inline`属性を使用しており、`unsafe-eval`はポリシーの77%に存在し、nonceは約20%のサイトで使用され、`strict-dynamic`は約10%のみです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=629434819&format=interactive",
  sheets_gid="218451283",
  sql_file="csp_script_source_list_keywords_per_request.sql"
  )
}}

`unsafe-inline` と `unsafe-eval` キーワードが非常に頻繁に使用されていることが分かります。これらのキーワードはそれぞれインラインスクリプトの実行を許可するか、JavaScriptの `eval` 関数の使用を許可するため、CSPの `script-src` のセキュリティへの影響を大幅に低下させます。

[昨年](../2024/security#script-srcのキーワード)と比較して、`script-src` キーワードの使用にほとんど変化がないことが分かります。重要な注意点として、`unsafe-inline` の存在は必ずしもインラインスクリプトが実行できることを意味するわけではありません。場合によっては、<a hreflang="en" href="https://w3c.github.io/webappsec-csp/">CSP仕様</a>に従って `unsafe-inline` は無視されます。例えば、nonceと `strict-dynamic` キーワードがCSPポリシーに追加されている場合がこれに該当します。

{{ figure_markup(
  image="csp-script-src-keywords-per-header.png",
  caption="ヘッダーごとのCSP`script-src`キーワードの普及率。",
  description="ヘッダーごとの`script-src`属性の使用状況を示す棒グラフ。デスクトップとモバイルの両方でヘッダーの圧倒的な92%が`unsafe-inline`属性を使用しており、`unsafe-eval`はポリシーの77%に存在し、nonceは約20%のサイトで使用され、`strict-dynamic`は約10%のみです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1711591110&format=interactive",
  sheets_gid="466842166",
  sql_file="csp_script_source_list_keywords_per_header.sql"
  )
}}

ページごとではなくヘッダーごとのキーワード使用状況も確認します。CSPでは、1つのレスポンスに複数のCSPヘッダーが存在し、異なるディレクティブを定義する場合があります。ディレクティブが複数回定義されている場合、<a hreflang="en" href="https://content-security-policy.com/examples/multiple-csp-headers/">ポリシーはブラウザが使用する最も制限的なポリシーを作成するために結合されます</a>。

リクエストごとの値と非常に似た分布が見られ、ほとんどのページがCSPヘッダーを1つだけ使用しているか、設定しているCSPヘッダーの1つだけに `script-src` を使用していることを示しており、ほとんどのページで `script-src` ディレクティブが競合していないことを意味します。

#### 許可されたホスト

CSPは完全に理解して正しく使用するには複雑なセキュリティポリシーです。使用中のCSPヘッダーの長さを確認すると、ポリシーのサイズに大きなバリエーションがあることが分かります。

{{ figure_markup(
  image="csp-header-length.png",
  caption="CSPヘッダーの長さ。",
  description="デスクトップとモバイルプラットフォームの様々なパーセンタイルでのコンテンツセキュリティポリシーヘッダーのバイトサイズの分布を示す棒グラフ。データは、10パーセンタイルから75パーセンタイルの間でヘッダーの長さが23〜86バイトの範囲で比較的一貫して小さく、デスクトップとモバイルの値がほぼ同じであることを示しています。90パーセンタイルでは、デスクトップのヘッダー長が583バイトに跳ね上がり、モバイルの長さは354バイトに達する大きな急増が発生します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=43389239&format=interactive",
  sheets_gid="1010084388",
  sql_file="csp_number_of_allowed_hosts.sql"
  )
}}

観察されたすべてのヘッダーのうち、75%が86バイト以下の長さです。これは昨年の75バイト以下よりわずかに長くなっています。90パーセンタイルでより長いポリシーが増加していることが分かります。デスクトップのポリシーは長くなり、モバイルのポリシーはわずかに短くなり、ポリシーの長さの差が広がっています。

<figure>
  <table>
    <thead>
      <tr>
        <th>ホスト</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>https://www.googletagmanager.com</code></td>
        <td class="numeric">0.74%</td>
        <td class="numeric">0.62%</td>
      </tr>
      <tr>
        <td><code>https://fonts.gstatic.com</code></td>
        <td class="numeric">0.61%</td>
        <td class="numeric">0.49%</td>
      </tr>
      <tr>
        <td><code>https://fonts.googleapis.com</code></td>
        <td class="numeric">0.60%</td>
        <td class="numeric">0.48%</td>
      </tr>
      <tr>
        <td><code>https://www.google.com</code></td>
        <td class="numeric">0.54%</td>
        <td class="numeric">0.46%</td>
      </tr>
      <tr>
        <td><code>https://www.google-analytics.com</code></td>
        <td class="numeric">0.47%</td>
        <td class="numeric">0.38%</td>
      </tr>
      <tr>
        <td><code>https://www.youtube.com</code></td>
        <td class="numeric">0.41%</td>
        <td class="numeric">0.34%</td>
      </tr>
      <tr>
        <td><code>https://*.google-analytics.com</code></td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td><code>https://*.google.com</code></td>
        <td class="numeric">0.31%</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td><code>https://connect.facebook.net</code></td>
        <td class="numeric">0.33%</td>
        <td class="numeric">0.29%</td>
      </tr>
      <tr>
        <td><code>https://www.gstatic.com</code></td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.27%</td>
      </tr>
    <tbody>
  </table>
  <figcaption>{{ figure_link(caption="CSPポリシーで最も頻繁に許可されるHTTP(S)ホスト", sheets_gid="670924704", sql_file="csp_allowed_host_frequency.sql") }}</figcaption>
</figure>


CSPヘッダーに含まれる最も一般的にロードされるHTTPSオリジンは、広告、フォント、その他のCDNリソースに使用されるものです。

<figure>
  <table>
    <thead>
      <tr>
        <th>ホスト</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>wss://*.hotjar.com</code></td>
        <td class="numeric">0.18%</td>
        <td class="numeric">0.15%</td>
      </tr>
      <tr>
        <td><code>wss://*.intercom.io</code></td>
        <td class="numeric">0.07%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td><code>wss://booth.karakuri.ai</code></td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td><code>wss://www.livejournal.com</code></td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.05%</td>
      </tr>
      <tr>
        <td><code>wss://*.quora.com</code></td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.05%</td>
      </tr>
      <tr>
        <td><code>wss://tsock.us1.twilio.com/v3/wsconnect</code></td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td><code>wss://api.smooch.io</code></td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td><code>wss://*.zopim.com</code></td>
        <td class="numeric">0.05%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td><code>wss://*.pusher.com</code></td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td><code>wss://cable.gumroad.com</code></td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.03%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CSPポリシーで最も頻繁に許可されるWSSホスト", sheets_gid="2069006969", sql_file="csp_allowed_host_frequency_wss.sql") }}</figcaption>
</figure>

セキュアウェブソケット（`wss://`）オリジンでは、Hotjarが1位を占め、出現数が2倍になっています。他のオリジンは出現数が少ないままです。

Hotjarはウェブサイト分析に使用されており、ウェブサイトの分析情報への継続的な関心を示しており、Intercomはカスタマーサービスに使用されています。また、AIファースト企業として、上位3位に入るkarakuriという日本のAI企業も統計に登場しています。

### サブリソース整合性

改ざんされたリソースのロードから保護するために、開発者は[サブリソース整合性（SRI）](https://developer.mozilla.org/docs/Web/Security/Subresource_Integrity)を利用できます。CSPが開発者にリソースがロードされるソースを制限させる一方で、SRIはそれらのリソースが開発者が期待するコンテンツを含むことを確認します。例えば、CDNが侵害され、攻撃者が有効なスクリプトを悪意のあるものに変更することに成功した場合はその逆になります。

`<script>` タグと `<link>` タグで `integrity` 属性を使用することで、開発者はブラウザにリソースの期待するハッシュを伝えることができます。指定されたリソースをロードする際、ブラウザはリソースの内容のハッシュが提供されたハッシュに対応するかどうかを確認し、対応しない場合はリソースのロード/実行を拒否し、ウェブサイトを潜在的に侵害されたコンテンツから保護します。

{{ figure_markup(
  content="23.6%",
  caption="SRIを使用するページ（モバイル）。",
  classes="big-number",
  sheets_gid="1788665240",
  sql_file="sri_usage.sql",
) }}

SRIはデスクトップとモバイルのページでそれぞれ25.9%と23.6%で使用されています。これは[昨年](../2024/security#サブリソース完全性)から両数字とも約2.5%上昇しており、増加する数の開発者がSRIを使用してページを保護していることを示しています。

{{ figure_markup(
  image="sri-coverage.png",
  caption="ページごとのSRIカバレッジ。",
  description="デスクトップとモバイルデバイスのウェブページの様々なパーセンタイルにわたるサブリソース整合性（SRI）の採用を示す棒グラフ。採用率は全体的に非常に低く、中央値（50パーセンタイル）のサイトはこのセキュリティ機能を使用してスクリプトの2.82%のみを保護しています。90パーセンタイルでも、ページのスクリプトの12.50%のみがSRIでカバーされています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1391748685&format=interactive",
  sheets_gid="165579346",
  sql_file="sri_coverage_per_page.sql"
  )
}}

[昨年](../2024/security#fig-25)と比較して、ページごとのサブリソースカバレッジの中央値が0.41%低下しています。この低下は、今年のWeb Almanacクローラーがクロールするページ数が多いことによる可能性が高いです。

<figure>
  <table>
    <thead>
      <tr>
        <th>ホスト</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>www.gstatic.com</code></td>
        <td class="numeric">34.70%</td>
        <td class="numeric">34.55%</td>
      </tr>
      <tr>
        <td><code>static.cloudflareinsights.com</code></td>
        <td class="numeric">8.89%</td>
        <td class="numeric">8.37%</td>
      </tr>
      <tr>
        <td><code>cdnjs.cloudflare.com</code></td>
        <td class="numeric">7.43%</td>
        <td class="numeric">7.20%</td>
      </tr>
      <tr>
        <td><code>cdn.userway.org</code></td>
        <td class="numeric">6.10%</td>
        <td class="numeric">6.60%</td>
      </tr>
      <tr>
        <td><code>code.jquery.com</code></td>
        <td class="numeric">4.96%</td>
        <td class="numeric">4.77%</td>
      </tr>
      <tr>
        <td><code>cdn.shoplineapp.com</code></td>
        <td class="numeric">4.62%</td>
        <td class="numeric">5.22%</td>
      </tr>
      <tr>
        <td><code>cdn.jsdelivr.net</code></td>
        <td class="numeric">4.50%</td>
        <td class="numeric">4.06%</td>
      </tr>
      <tr>
        <td><code>d3e54v103j8qbb.cloudfront.net</code></td>
        <td class="numeric">2.03%</td>
        <td class="numeric">2.30%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="SRI保護スクリプトが含まれる最も一般的なホスト", sheets_gid="347167013", sql_file="sri_popular_hosts.sql") }}</figcaption>
</figure>

SRI保護スクリプトがロードされる最も一般的なホストのリストは、一部のエントリーが相対的な位置を変えながらも、全体的に安定しています。例えば `cloudflareinsights` レコードは相対的な出現率が増加しましたが、2.40%のみです。

昨年と同様に、これらのエントリーのほとんどはCDNであり、SRIでロードおよび保護されるリソースのほとんどがCDNからロードされていることを示しています。これらのスクリプトは開発者の直接制御下にないことが多いため、これは理にかなっています。CDNは多くの場合、多くの開発者が含めることができる大量のスクリプトをホストします。これは自分のサーバーへの負荷が下がるため開発者にとって有益ですが、クライアントにとってもそれを含むすべてのウェブサイトで同じスクリプトを一度ずつロードするのではなく、CDNからスクリプトをキャッシュできるという点で有益です。

自分で制御していないサーバーにホストされているスクリプトを含めるリスクは、開発者として完全に制御している場合よりも高くなります。この外部スクリプトの開発者が悪意のあるコンテンツを含めることを決めるか、サーバーが侵害されてスクリプトが悪意のあるものに置き換えられた場合、SRIなしでは開発者のユーザーがこの悪意のあるコンテンツをロードして実行することになります。ユーザーをこれらの予期しない変更から保護し、どのスクリプトが実行を許可されているかを確実に知るための良い方法がSRIの使用です。

### パーミッションポリシー

[パーミッションポリシー](https://developer.mozilla.org/docs/Web/HTTP/Permissions_Policy)（以前はFeature Policy）は、カメラ、マイク、センサー（加速度計など）、位置情報データなど、ブラウザでの特定機能の使用を許可または拒否できるようにするポリシーです。`Permissions-Policy` レスポンスヘッダーを通じて、開発者はメインページとその埋め込みコンテンツによる特定の機能使用を許可または拒否できます。1つの埋め込みリソースに対する特定のポリシーは、`<iframe>` 要素の `allow` 属性を通じて設定できます。

{{ figure_markup(
  content="+50%",
  caption="2024年からの`Permissions-Policy`ヘッダーの採用率の相対的な増加（モバイル）。",
  classes="big-number",
  sheets_gid="136009485",
  sql_file="security_headers_prevalence.sql",
) }}

[昨年と比較して](../2024/security#パーミッションポリシー)、`Permissions-Policy` の使用は相対的に60%近く増加しました。これは大きな相対的な増加ですが、`Permissions-Policy` を使用するウェブサイトの絶対的な割合は、モバイルで3.7%と依然として比較的少ない状況です。採用率の上昇はポリシーにとって良い兆しです。

<figure>
  <table>
    <thead>
      <tr>
        <th>ヘッダー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>interest-cohort=()</code></td>
        <td class="numeric">11.02%</td>
        <td class="numeric">11.56%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), autoplay=(), camera=(), encrypted-media=(), fullscreen=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), midi=(), payment=(), picture-in-picture=(), publickey-credentials-get=(), screen-wake-lock=(), sync-xhr=(), usb=()</code></td>
        <td class="numeric">5.01%</td>
        <td class="numeric">10.00%</td>
      </tr>
      <tr>
        <td><code>geolocation=(),midi=(),sync-xhr=(),microphone=(),camera=(),magnetometer=(),gyroscope=(),fullscreen=(self),payment=()</code></td>
        <td class="numeric">4.63%</td>
        <td class="numeric">4.44%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), autoplay=(), camera=(), cross-origin-isolated=(), display-capture=(self), encrypted-media=(), fullscreen=*, geolocation=(self), gyroscope=(), keyboard-map=(), magnetometer=(), microphone=(), midi=(), payment=*, picture-in-picture=*, publickey-credentials-get=(), screen-wake-lock=(), sync-xhr=*, usb=(), xr-spatial-tracking=(), gamepad=(), serial=()</code></td>
        <td class="numeric">3.65%</td>
        <td class="numeric">3.45%</td>
      </tr>
      <tr>
        <td><code>geolocation=(self)</code></td>
        <td class="numeric">2.06%</td>
        <td class="numeric">2.64%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()</code></td>
        <td class="numeric">2.77%</td>
        <td class="numeric">2.38%</td>
      </tr>
      <tr>
        <td><code>accelerometer=(self), autoplay=(self), camera=(self), encrypted-media=(self), fullscreen=(self), geolocation=(self), gyroscope=(self), magnetometer=(self), microphone=(self), midi=(self), payment=(self), usb=(self)</code></td>
        <td class="numeric">2.39%</td>
        <td class="numeric">2.25%</td>
      </tr>
      <tr>
        <td><code>browsing-topics=()</code></td>
        <td class="numeric">1.82%</td>
        <td class="numeric">2.14%</td>
      </tr>
      <tr>
        <td><code>geolocation=(), microphone=(), camera=()</code></td>
        <td class="numeric">2.11%</td>
        <td class="numeric">2.09%</td>
      </tr>
      <tr>
        <td><code>geolocation=self</code></td>
        <td class="numeric">1.87%</td>
        <td class="numeric">1.81%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="最も普及している`Permission-Policy`ヘッダー", sheets_gid="180881517", sql_file="pp_header_prevalence.sql") }}</figcaption>
</figure>

上位10位の `Permissions-Policy` 値を確認すると、Googleの<a hreflang="en" href="https://privacysandbox.com/intl/en_us/proposals/floc/">Federated Learning of Cohorts（FLoC）</a>をオプトアウトするためにヘッダーを使用する開発者が少なくなっており、`Permissions-Policy` ヘッダーの11.5%のみが `interest-cohort=()` 値を含んでいます。また、モバイルでの `Permissions-Policy` ヘッダーの10%がこの値を含む、一度に多くの機能をオプトアウトする値が人気の値になっていることも分かります。これは[異なるPermission PolicyでのTopics APIに置き換えられたため](https://privacysandbox.google.com/private-advertising/topics/web/controls#opt_out_as_a_developer)と考えられます。また、[GoogleがこれらのPrivacy Sandbox APIを廃止している](https://privacysandbox.google.com/blog/update-on-plans-for-privacy-sandbox-technologies)ため、将来的にさらに減少する可能性が高いです。

上位10位で観察された他のすべての値は、ウェブページと埋め込みコンテンツの権限を制限することを目的としています。パーミッションポリシーはデフォルトでオープンであり、機能の使用を制限するためにはヘッダーで明示的に言及する必要があります。昨年と同様に、デスクトップの `Permissions-Policy` ヘッダーの0.27%が `*` ワイルドカード値を設定しており、`allow` 属性により厳格なポリシーを定義していないページと埋め込みコンテンツにすべての権限を明示的に付与しています。モバイルでは、ワイルドカード値はまったく見つかりませんでした。

前述のように、Permissions PolicはHTML `<iframe>` の `allow` 属性でも定義できます。例えば、埋め込みコンテンツにカメラとマイクへのアクセスを許可するiframeは次のようになります：

```html
<iframe src="https://example.com/" allow="camera 'self'; microphone 'self'">
```

モバイルの合計3,330万のiframeのうち、29.2%が `allow` 属性を含んでいることが観察されました。`allow` 属性の使用の相対的な減少は、今年のクロールで前年よりも多くのページが含まれていたため、1,000万以上多くのiframe要素が見つかったことに起因していると考えられます。

<figure>
  <table>
    <thead>
      <tr>
        <th>ディレクティブ</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>encrypted-media</code></td>
        <td class="numeric">60.90%</td>
        <td class="numeric">70.66%</td>
      </tr>
      <tr>
        <td><code>autoplay</code></td>
        <td class="numeric">34.99%</td>
        <td class="numeric">41.83%</td>
      </tr>
      <tr>
        <td><code>picture-in-picture</code></td>
        <td class="numeric">26.10%</td>
        <td class="numeric">36.63%</td>
      </tr>
      <tr>
        <td><code>gyroscope</code></td>
        <td class="numeric">23.76%</td>
        <td class="numeric">34.20%</td>
      </tr>
      <tr>
        <td><code>accelerometer</code></td>
        <td class="numeric">23.76%</td>
        <td class="numeric">34.20%</td>
      </tr>
      <tr>
        <td><code>clipboard-write</code></td>
        <td class="numeric">20.39%</td>
        <td class="numeric">26.24%</td>
      </tr>
      <tr>
        <td><code>join-ad-interest-group</code></td>
        <td class="numeric">24.23%</td>
        <td class="numeric">17.35%</td>
      </tr>
      <tr>
        <td><code>web-share</code></td>
        <td class="numeric">12.07%</td>
        <td class="numeric">15.67%</td>
      </tr>
      <tr>
        <td><code>attribution-reporting</code></td>
        <td class="numeric">3.93%</td>
        <td class="numeric">2.35%</td>
      </tr>
      <tr>
        <td><code>run-ad-auction</code></td>
        <td class="numeric">3.84%</td>
        <td class="numeric">2.26%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="最も普及している`allow`属性ディレクティブ", sheets_gid="1876706326", sql_file="iframe_allow_directives.sql") }}</figcaption>
</figure>

興味深いことに、昨年の上位3つの `allow` 属性値（`join-ad-interest-group`、`attribution-reporting`、`run-ad-auction`）は昨年と比べて極めて低い採用率になっています。これらの値をiframe要素に追加したと仮定されていた大手プレイヤーが、その変更を元に戻した可能性があります。昨年の上位10位に入るその他の値は、`allow` 属性値への組み込みが全体的に大幅に増加しており、絶対的な変化は最大+50%に達しています。

### iframeサンドボックス

`<iframe>` 要素に[`sandbox`](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/iframe#sandbox)属性を使用することで、開発者は `<iframe>` に埋め込まれたリソースが侵害されたり悪意を持ったりした場合のいくつかの攻撃からユーザーを保護できます。`sandbox` 属性の値では、開発者が `<iframe>` にロードして表示されるコンテンツに対してどのような制限を設けるべきかを指定できます。例えば、以下の `<iframe>` は埋め込みウェブページがスクリプトを実行できるようにします：

```html
<iframe src="https://example.com/" sandbox="allow-scripts"></iframe>
```

sandbox属性の使用は2024年版から20.0%から22.7%に上昇しており、埋め込みコンテンツによる潜在的な悪用からユーザーを保護したいと考える開発者が増加していることを示しています。

{{ figure_markup(
  image="iframe-sandbox-directives.png",
  caption="iframeでのsandboxディレクティブの普及率。",
  description="デスクトップとモバイルプラットフォームのサンドボックスiframe内での特定の権限の採用を示す棒グラフ。`allow-scripts`と`allow-same-origin`ディレクティブはほぼ普遍的で、JavaScriptの実行や独自のストレージへのアクセスなどのコア機能を埋め込みコンテンツが維持できるようにするためにサンドボックスページの約97〜98%に存在します。`allow-popups`と`allow-popups-to-escape-sandbox`などの適度に一般的な機能はサイトの約70〜75%で利用されており、`allow-top-navigation-by-user-activation`などの特殊なナビゲーションコントロールは30%未満で最も採用率が低くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1050517232&format=interactive",
  sheets_gid="679180424",
  sql_file="iframe_sandbox_directives.sql"
  )
}}

[昨年](../2024/security#iframeサンドボックス)と同様に、`sandbox` 属性を持つすべてのiframeのうち、98.5%（モバイル）が `allow-scripts` ディレクティブを含めることで埋め込みウェブページがスクリプトを実行できるようにするために使用していることが分かります。2位は、モバイルiframeの97.8%で使用されており、開発者がロードされたリソースを埋め込み元のオリジンの一部にするための `allow-same-origin` です。

## 新興のセキュリティヘッダー

TLS、HSTS、CSPポリシー、SRI、iframeの `sandbox` 属性などの既存のセキュリティ機能のほとんどで上昇が見られます。これらの既存機能に加えて、時代が進むにつれて新しい攻撃が作成され、より多くの防御が実装されています。このセクションでは、実際の環境で見られる頻度が増えている比較的新しいドキュメントポリシーについて説明します。

### ドキュメントポリシー

<a hreflang="en" href="https://wicg.github.io/document-policy/">ドキュメントポリシー</a>は、2022年に最終更新されたコミュニティグループレポートの草案です。もともとは、パーミッションポリシーモデルに合わなかったり、複雑さを過度に増加させたりするパーミッションポリシーへの提案された追加に対する応答として作成されました。

ドキュメントポリシーはパーミッションポリシー、CSP、サンドボックスなどの関連メカニズムと比べていくつかの利点があります。パーミッションポリシーよりもきめ細かく、異なる継承モデルを持っており：子リソースは互換性がある場合は親が選んだ特定のポリシーを上書きできます。CSPよりも一般的で、リソースがロードされた後の権限に関するディレクティブを持っており、リソースをロードできるオリジンを決定するだけではありません。サンドボックスより拡張が容易なのは、サンドボックスで言及されていない機能はデフォルトでブロックされており、新しいものを追加することが非常に困難だからです。

<figure>
  <table>
    <thead>
      <tr>
        <th>ヘッダー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>include-js-call-stacks-in-crash-reports</code></td>
        <td class="numeric">68.48%</td>
        <td class="numeric">71.99%</td>
      </tr>
      <tr>
        <td><code>js-profiling</code></td>
        <td class="numeric">12.66%</td>
        <td class="numeric">15.24%</td>
      </tr>
      <tr>
        <td><code>js-profiling; include-js-call-stacks-in-crash-reports</code></td>
        <td class="numeric">17.41%</td>
        <td class="numeric">11.94%</td>
      </tr>
      <tr>
        <td><code>force-load-at-top</code></td>
        <td class="numeric">1.25%</td>
        <td class="numeric">0.65%</td>
      </tr>
      <tr>
        <td><code>no-font-display-late-swap</code></td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.05%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="最も一般的なdocument policyヘッダー値", sheets_gid="1931592953", sql_file="documentpolicy_most_common_header.sql") }}</figcaption>
</figure>

使用中のドキュメントポリシーヘッダーのうち、3分の2以上がクラッシュレポートにコールスタックを含めるために使用されていることが分かります。`js-profiling` ディレクティブと組み合わせると、これら2つの機能が現在のユースケースの大多数を占めています。現在、合計で19の異なるディレクティブを含むポリシー値が見つかります。一般的には定義されているディレクティブがより多い場合もありますが、現時点ではその合計数は把握できていません。

現在、デスクトップとモバイルでそれぞれ約24,000と29,500ページしか見つかっておらず、訪問した総ページ数の0.10%です。ドキュメントポリシーヘッダーの採用率は今後も上昇すると予想されますが、将来的な採用は急速には進まないかもしれません。

## 攻撃防御

ブラウザが実装しているウェブサイトへの多くの防御がある一方で、すべての可能性とベストプラクティスの概要を把握することは困難です。さらに、保護がオプトインであり、デフォルトで有効になっていない場合は、さらなる課題となります。開発者は最新の攻撃と、それらの攻撃からユーザーを保護するために存在する防御について常に最新情報を把握しておく必要があります。このセクションでは、ウェブ全体でどの攻撃防御手段が使用されているかを評価します。

### セキュリティヘッダーの採用

多くの保護メカニズムがHTTPレスポンスヘッダーを通じて設定できます。これらのヘッダーの値に基づいてブラウザはこれらの保護を強制します。すべてのセキュリティメカニズムがすべてのウェブサイトに関連するわけではありませんが、セキュリティヘッダーがまったくない場合はセキュリティに対する緊急性の欠如を示す可能性があります。

{{ figure_markup(
  image="security-headers-mobile.png",
  caption="経時的なモバイルページでのサイトリクエストのセキュリティヘッダー採用率。",
  description="2023年から2025年にかけてのモバイルウェブサイトでのさまざまなセキュリティヘッダーの使用の成長を示す棒グラフ。データは最も一般的なヘッダーの採用に一貫した上昇傾向を示しており、`X-Content-Type-Options`が2025年までに採用率約50%でグループをリードしています。`X-Frame-Options`や`Strict-Transport-Security`などの他の主要なヘッダーがそれに続き、サイトの約35%への着実な増加を示しています。一方、`Cross-Origin-Opener-Policy`や`Permissions-Policy`などのより現代的またはニッチなヘッダーは採用の初期段階にあり、10%の閾値を大きく下回っています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=710761597&format=interactive",
  sheets_gid="136009485",
  sql_file="security_headers_prevalence.sql"
  )
}}

[昨年と同様に](../2024/security#セキュリティヘッダーの採用)、採用が減少しているヘッダーはわずかです。`Feature-Policy` ヘッダーは `Permissions-Policy` に取って代わられたため廃止されており、採用が減少していることは驚くことではありません。他の2つ（`Clear-Site-Data` と `Document-Policy-Report-Only`）の採用率は非常に低く（それぞれ0.01%と0.00001%）、採用率の相対的な変化は大きく見えることがありますが、絶対的な差は実際には小さいです。これは全体的なセキュリティヘッダーの採用が時間とともに増加し続けていることを意味し、ウェブセキュリティ全体にとって前向きな兆候です。

2024年版からの最も強い上昇は `Strict-Transport-Security`（+4.02%）、`Content-Security-Policy`（+3.39%）、`X-Content-Type-Options`（+2.30%）です。

#### `Origin-Agent-Cluster`

[`Origin-Agent-Cluster`](https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Origin-Agent-Cluster)は、正しく設定されている場合、ドキュメントに使用されるリソース（オペレーティングシステムプロセスなど）を同じオリジンのドキュメントと共有するリクエストをブラウザに伝えます。ブラウザはリクエストに応じることも応じないこともあり、クライアントはJavaScriptを使用してリクエストが実際に応じられたかどうかを確認できます。

使用率は依然として低く、モバイルサイトの0.47%、デスクトップサイトの0.38%がこれを使用していますが、彼らが何のために使用しているかを詳しく見てみましょう：

<figure>
  <table>
    <thead>
      <tr>
        <th>ヘッダー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>?1</code></td>
        <td class="numeric">74.11%</td>
        <td class="numeric">90.32%</td>
      </tr>
      <tr>
        <td><code>?0</code></td>
        <td class="numeric">25.79%</td>
        <td class="numeric">9.60%</td>
      </tr>
      <tr>
        <td><code>1</code></td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td><code>0</code></td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.01%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="最も一般的な`Origin-Agent-Cluster`ヘッダー値", sheets_gid="1123976436", sql_file="oac_header_prevalence.sql") }}</figcaption>
</figure>

ブール値は<a hreflang="en" href="https://httpwg.org/specs/rfc8941.html#boolean">HTML Living Standardで</a>疑問符で始まる文字列として定義されています。これは `1` や `0` のような値がこのヘッダーに対して無効であることを意味します。幸いにも、これらの値の使用は限定的です。`?1` 値は `Origin-Agent-Cluster` の唯一の有効値であり、開発者がこの機能にオプトインしたいことを伝えるために使用され、他のすべての値は無視されます。モバイルでは、ヘッダーの90%以上が有効な `?1` 値を持っています。残念ながら、ヘッダー値の0.07%は `1` であり、開発者が専用リソースの使用をリクエストしたいにもかかわらず無視される値です。

#### `document.domain`の使用

[`document.domain`](https://developer.mozilla.org/docs/Web/API/Document/domain)を使用することで、開発者は現在のドキュメントのドメイン部分を読み取ることができ、新しいドメインを設定することもできます（現在のドメインのスーパードメインのみ許可）。その後、ブラウザは同一オリジンポリシーのチェックに新しいドメインをオリジンとして使用します。ただし、このプロパティの使用は現在非推奨となっており、ブラウザはまもなくこのプロパティのサポートを停止する可能性があります。

<figure>
  <table>
    <thead>
      <tr>
        <th>Blink機能</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>DocumentSetDomain</code></td>
        <td class="numeric">0.49%</td>
        <td class="numeric">0.36%</td>
      </tr>
      <tr>
        <td><code>DocumentDomainSetWithNonDefaultPort</code></td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.14%</td>
      </tr>
      <tr>
        <td><code>DocumentDomainEnabledCrossOriginAccess</code></td>
        <td class="numeric">0.0008%</td>
        <td class="numeric">0.0004%</td>
      </tr>
      <tr>
        <td><code>DocumentDomainBlockedCrossOriginAccess</code></td>
        <td class="numeric">0.0002%</td>
        <td class="numeric">0.0001%</td>
      </tr>
      <tr>
        <td><code>DocumentOpenAliasedOriginDocumentDomain</code></td>
        <td class="numeric">0.00008%</td>
        <td class="numeric">0.00001%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="特定のBlink機能に基づく`document.domain`の使用", sheets_gid="1240446071", sql_file="documentdomain_usage.sql") }}</figcaption>
</figure>

デスクトップとモバイルのウェブサイトのうち0.5%未満が `document.domain` セッターを使用してページのオリジンを変更しており、非デフォルトポートで行うサイトはさらに少ないことが分かります。これは前向きなトレンドですが、依然としてコードを更新すべき数万のウェブサイトが存在します。

### CSPとX-Frame-Optionsによるクリックジャッキング防御

前述のように、コンテンツセキュリティポリシー（CSP）は `frame-ancestors` ディレクティブを使用して<a hreflang="en" href="https://owasp.org/www-community/attacks/Clickjacking">クリックジャッキング</a>攻撃に対して有効です。一部の上位CSPヘッダー値には `'none'` または `'self'` 値を持つ `frame-ancestors` ディレクティブが含まれており、ページの埋め込みを全体的にブロックするか、同一オリジンのページへの埋め込みを制限します。

クリックジャッキング攻撃に対する別の防御方法は、[`X-Frame-Options`（XFO）](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-Frame-Options)ヘッダーを通じてです。XFOヘッダーを設定することで、開発者はドキュメントが他のドキュメントに埋め込めないこと（'DENY'）、または同一オリジンのドキュメントのみに埋め込めること（`SAMEORIGIN`）を伝えることができます。

<figure>
  <table>
    <thead>
      <tr>
        <th>ヘッダー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>SAMEORIGIN</code></td>
        <td class="numeric">72.48%</td>
        <td class="numeric">72.13%</td>
      </tr>
      <tr>
        <td><code>DENY</code></td>
        <td class="numeric">24.40%</td>
        <td class="numeric">24.64%</td>
      </tr>
      <tr>
        <td><code>ALLOWALL</code></td>
        <td class="numeric">0.68%</td>
        <td class="numeric">0.72%</td>
      </tr>
      <tr>
        <td><code>SAMEORIGIN, SAMEORIGIN</code></td>
        <td class="numeric">0.27%</td>
        <td class="numeric">0.28%</td>
      </tr>
      <tr>
        <td><code>allow-from https://s.salla.sa</code></td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.28%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="最も普及している`X-Frame-Options`ヘッダー値", sheets_gid="1545864706", sql_file="xfo_header_prevalence.sql") }}</figcaption>
</figure>

今年のデータと[2024年](../2024/security#セキュリティヘッダーの採用)のデータではほとんど変化がないことが分かります。`X-Frame-Options` ヘッダーは主に同一オリジンのウェブサイトがページを埋め込めるようにするために使用されています（72.1%）。次に、任意のページが自身のコンテンツを埋め込むことを拒否するために使用されています（24.6%）。

観察される他の値の例はテーブルの3行目から5行目に示されています。`ALLOW-FROM` 値はかつて有効でしたが、現在は非推奨でブラウザに無視されます。XFOで `ALLOW-FROM` を使用する代わりに、開発者はCSPの `frame-ancestors` ディレクティブの使用に切り替えるべきです。これらの仕様外の値はあまり見られませんが、ヘッダーを設定することで保護が有効になると期待する開発者によって設定されている場合があります。

### クロスオリジンポリシーを使用した攻撃防御

<a hreflang="en" href="https://spectreattack.com/">SpectreとMeltdown</a>のようなマイクロアーキテクチャサイドチャネル攻撃と<a hreflang="en" href="https://xsleaks.dev/">Cross-Site Leaks（XS-Leaks）</a>の登場により、クロスオリジンリソースの使用と埋め込みに関するセキュリティの視点が変わりました。これらの脅威に対応して、他のウェブサイトでのリソースのレンダリングを制御し、これらの新しい脅威から保護するための新しいメカニズムが作成されました。

クロスオリジンポリシーとして知られる複数の新しいセキュリティヘッダーがこれらの課題への対応として作成されました：Cross-Origin-Resource-Policy（CORP）、Cross-Origin-Embedder-Policy（COEP）、Cross-Origin-Opener-Policy（COOP）。これらのヘッダーは、開発者がリソースが異なるオリジン間でどのように埋め込まれるかを制御できるようにすることで、サイドチャネル攻撃から保護するメカニズムを提供します。これらのヘッダーのすべての採用が年々増加し続けており、CORPとCOOPの両方が今年2%以上の採用率に達していることが観察されます。

{{ figure_markup(
  image="cross-origin-headers-trend.png",
  caption="クロスオリジンヘッダーの経時的な使用状況。",
  description="2023年から2025年の間の3つの特定のセキュリティヘッダーの使用状況を示す棒グラフ。`Cross-Origin-Resource-Policy`は3つの中で最も広く採用されており、2023年の約1.75%から2025年には2.25%以上に成長しています。`Cross-Origin-Opener-Policy`は最も大きな相対的な成長を経験し、3年間で採用率が1.00%未満から約2.00%へと倍増以上しました。`Cross-Origin-Embedder-Policy`は最も一般的でないものの、2025年までに約0.75%の採用率に達する着実な上昇傾向を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=157500281&format=interactive",
  sheets_gid="136009485",
  sql_file="security_headers_prevalence.sql"
  )
}}

#### クロスオリジンエンベッダーポリシー

[Cross-Origin-Embedder-Policy（COEP）](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy)は、開発者がどのクロスオリジンリソースが現在のドキュメントに埋め込めるかを設定できるようにします。デフォルト（ヘッダーが存在しない場合）では、すべてのクロスオリジンリソースがページに埋め込めます。これはヘッダーが `unsafe-none` 値で設定されている場合と同じ動作です。

<figure>
  <table>
    <thead>
      <tr>
        <th>COEP値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>unsafe-none</code></td>
        <td class="numeric">83.26%</td>
        <td class="numeric">86.52%</td>
      </tr>
      <tr>
        <td><code>require-corp</code></td>
        <td class="numeric">6.68%</td>
        <td class="numeric">4.92%</td>
      </tr>
      <tr>
        <td><code>credentialless</code></td>
        <td class="numeric">2.59%</td>
        <td class="numeric">1.89%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="許可された値の有効なバリエーションを含むCOEPヘッダーの普及率", sheets_gid="1595978010", sql_file="coep_header_prevalence.sql") }}</figcaption>
</figure>

[昨年と比較して](../2024/security#クロスオリジンエンベッダーポリシー)、ほとんどの開発者は依然として `unsafe-none` 値を使用してすべてのコンテンツが現在のドキュメントに埋め込まれることを明示的に許可するためにCOEPヘッダーを設定しています。この値の使用率はモバイルで依然として86%以上ありますが、昨年から約2%低下しており、開発者がヘッダーの使用を変更し始めていることを示している可能性があります。

他の値 `require-corp` と `credentialless` は昨年からそれぞれ0.2%と0.3%のわずかな採用増加を見せました。`require-corp` を使用する場合、ブラウザは同一オリジンコンテンツまたはCORPによって埋め込みが許可されたクロスオリジンコンテンツのみがページに埋め込まれることを強制します。

`credentialless` の場合、ブラウザはコンテンツのCORSポリシーに関係なく `no-cors` モードでクロスオリジンリクエストを許可しますが、クッキーはリクエストに添付されません。

#### クロスオリジンリソースポリシー

COEPと関連して、[Cross-Origin-Resource-Policy（CORP）](https://developer.mozilla.org/docs/Web/HTTP/Cross-Origin_Resource_Policy)は、現在のドキュメントにどのコンテンツが埋め込まれるかを強制するのではなく、現在のコンテンツがどのドキュメントからアクセスできるかを管理します。

可能な値は `cross-origin`、`same-origin`、`same-site` の3つだけです。`cross-origin` 値はすべてのドキュメントがリソースにアクセスできるようにし、`same-origin` と `same-site` 値はそれぞれ同一オリジンまたはサイトのドキュメントのみにリソースへのアクセスを制限します。開発者は[オリジン（スキーム、ホスト、ポート）とサイト（登録可能なドメイン）の違い](https://web.dev/articles/url-parts)を認識すべきです。ヘッダーが存在する場合、`no-cors` モードのリクエストはブラウザによってブロックされます。

<figure>
  <table>
    <thead>
      <tr>
        <th>CORP値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>cross-origin</code></td>
        <td class="numeric">81.36%</td>
        <td class="numeric">80.52%</td>
      </tr>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">14.40%</td>
        <td class="numeric">15.63%</td>
      </tr>
      <tr>
        <td><code>same-site</code></td>
        <td class="numeric">3.80%</td>
        <td class="numeric">3.48%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="CORP ヘッダー値の普及率", sheets_gid="758863059", sql_file="corp_header_prevalence.sql") }}</figcaption>
</figure>

ほとんどの場合、ヘッダーはあらゆるクロスオリジンリソースへのアクセスを許可するために使用されています。今年この数字に大きな変化が見られ、[昨年](../2024/security#クロスオリジンリソースポリシー)から10%以上低下してモバイルで80.5%になっています。一方、`same-origin` 値の使用は約10%上昇しており、開発者がクロスオリジンアクセスからリソースを保護する方向に移行していることを示しています。`same-site` の使用シェアはほぼ同じで、半パーセント未満のわずかな減少を示しています。

#### クロスオリジンオープナーポリシー

最後のクロスオリジンポリシーヘッダー、[Cross-Origin-Opener-Policy（COOP）](https://developer.mozilla.org/docs/Web/HTTP/Headers/Cross-Origin-Opener-Policy)は、開発者が `window.open` などのブラウザAPIを通じてページを開いたときに他のページがそのページを参照できる方法を制御できるようにします。

デフォルト値の `unsafe-none` はCOOP保護を無効にできるようにし、これはヘッダーが存在しない場合にも起こります。開発者が `window.open` を使用して `unsafe-none` を使用するページを開いた場合、返された値を使用して開かれたページの特定のプロパティにアクセスでき、これがCross-Site Leaksにつながる可能性があります。

`same-origin` がオープナーと開かれたリソースの両方に存在する場合、`windows.open` によって返された参照はオープナーが使用できます。`same-origin-allow-popups` は、ドキュメントが依然として動作する参照へのアクセスを維持しながら、`unsafe-none` を持つ別のドキュメントを開けるようにします。

最後に、`noopener-allow-popups` は、開かれたドキュメントも同じCOOP値が設定されている場合を除いて、参照に決してアクセスできないようにします。

<figure>
  <table>
    <thead>
      <tr>
        <th>COOP値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">58.22%</td>
        <td class="numeric">61.64%</td>
      </tr>
      <tr>
        <td><code>unsafe-none</code></td>
        <td class="numeric">28.47%</td>
        <td class="numeric">26.82%</td>
      </tr>
      <tr>
        <td><code>same-origin-allow-popups</code></td>
        <td class="numeric">11.36%</td>
        <td class="numeric">9.95%</td>
      </tr>
      <tr>
        <td><code>noopener-allow-popups</code></td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="許可された値の有効なバリエーションを含むCOOPヘッダーの普及率", sheets_gid="1357383563", sql_file="coop_header_prevalence.sql") }}</figcaption>
</figure>

COOPの最も厳格な `same-origin` 値の使用はモバイルで47.5%から61.6%に引き続き上昇しています。`noopener-allow-popups` は非常に新しい値で、[昨年](../2024/security#クロスオリジンオープナーポリシー)にはまだ存在しませんでした。今年はこの値を使用する少数の採用者が確認されます。`unsafe-none` の使用は10%以上低下しました。これらの変化はCOOPの使用において前向きな進化を示しています。

#### クロスオリジンアイソレーション

`SharedArrayBuffer` や `Performance.now` などの特定の機密APIにアクセスするためには、サイトが[クロスオリジンアイソレーション状態](https://developer.mozilla.org/docs/Web/API/Window/crossOriginIsolated)である必要があります。クロスオリジンアイソレーション状態であるためには、開発者がCOEPを `same-origin` に設定し、CORPを `require-corp` または `credentialless` のいずれかに設定する必要があります。その後、ブラウザはこれらのAPIへのアクセスを再び許可します。これはXS Leaksに対する保護を強化します。最近では、開発者は<a hreflang="en" href="https://wicg.github.io/document-isolation-policy/">ドキュメントアイソレーションポリシー</a>を使用してクロスオリジンアイソレーションにオプトインすることもできます。

### `Clear-Site-Data`を使用した攻撃防御

[`Clear-Site-Data`](https://developer.mozilla.org/docs/Web/HTTP/Headers/Clear-Site-Data) HTTPレスポンスヘッダーを使用することで、開発者はクライアントにブラウジングデータをクリアするよう指示できます。ヘッダーの値はクリアするデータの種類を指定します。これはユーザーがウェブサイトからログアウトするときに役立ち、開発者は認証クッキーが確実にクリアされることを確認できます。

`Clear-Site-Data` の採用率を正確に推定することは難しいです。その使用はユーザーをログアウトさせる際に最も価値があることが多いためです。使用しているクローラーはウェブサイトにログインしないため、ログアウト後にヘッダーを使用するサイト数を確認するためにログアウトすることもできません。現時点では、`Clear-Site-Data` ヘッダーを使用している2,024のモバイルホストが確認されており、これはクロールされたホストの総数の0.01%にすぎません。

<figure>
  <table>
    <thead>
      <tr>
        <th>クリアサイトデータ値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>cache</code></td>
        <td class="numeric">30.82%</td>
        <td class="numeric">29.25%</td>
      </tr>
      <tr>
        <td><code>*</code></td>
        <td class="numeric">17.74%</td>
        <td class="numeric">20.61%</td>
      </tr>
      <tr>
        <td><code>cookies</code></td>
        <td class="numeric">7.02%</td>
        <td class="numeric">8.16%</td>
      </tr>
      <tr>
        <td><code>"cache"</code></td>
        <td class="numeric">8.94%</td>
        <td class="numeric">7.19%</td>
      </tr>
      <tr>
        <td><code>"storages"</code></td>
        <td class="numeric">5.66%</td>
        <td class="numeric">6.08%</td>
      </tr>
      <tr>
        <td><code>cache, cookies, storage</code></td>
        <td class="numeric">2.12%</td>
        <td class="numeric">3.23%</td>
      </tr>
      <tr>
        <td><code>"cache", "cookies", "storage", "executionContexts"</code></td>
        <td class="numeric">2.32%</td>
        <td class="numeric">2.51%</td>
      </tr>
      <tr>
        <td><code>"cookies"</code></td>
        <td class="numeric">2.78%</td>
        <td class="numeric">2.46%</td>
      </tr>
      <tr>
        <td><code>"storage"</code></td>
        <td class="numeric">2.27%</td>
        <td class="numeric">2.03%</td>
      </tr>
      <tr>
        <td><code>"cache", "storage", "executionContexts"</code></td>
        <td class="numeric">1.36%</td>
        <td class="numeric">1.54%</td>
      </tr>
    <tbody>
  </table>
  <figcaption>{{ figure_link(caption="`Clear-Site-Data`ヘッダーの普及率", sheets_gid="301356995", sql_file="clear-site-data_value_prevalence.sql") }}</figcaption>
</figure>

データは、ほとんどの開発者がキャッシュをクリアするために `Clear-Site-Data` ヘッダーを使用しようとしていることを示しています。最も普及している値は `cache` で、次にワイルドカード文字 `*` と `cookies` が続きます。上位3つの値はすべて仕様によると無効です。このヘッダーの値は「引用符付き文字列」でなければならず、つまり `"cache"`、`"*"`、`"cookies"` が同等の有効な値です。上位3つの値を合わせると、モバイルの現在のヘッダー値の58.01%をすでに占めているため、これは懸念されます。

これらの数字は年々かなり変動しますが、ヘッダーの採用率が低いため、非常に少数のホストが相対的な割合を大幅に変更できることで説明できると考えられます。

### `<meta>`を使用した攻撃防御

レスポンスヘッダーで設定することに加えて、ウェブのセキュリティメカニズムの一部は `<meta>` タグを使用してHTMLドキュメント内で直接設定できます。その例として `Content-Security-Policy` と `Referrer-Policy` があります。これらのメカニズムへのmetaタグの使用は[昨年](../2024/security#metaを使用した攻撃の防止)からほぼ安定しており、CSPとReferrer-Policyでそれぞれ約0.60%と約2.50%です。昨年と同様に、CSPのわずかな減少とReferrer-Policyのわずかな増加が観察されます。

<figure>
  <table>
    <thead>
      <tr>
        <td>Metaタグ</td>
        <td>デスクトップ</td>
        <td>モバイル</td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>includes Referrer-policy</code></td>
        <td class="numeric">2.75%</td>
        <td class="numeric">2.52%</td>
      </tr>
      <tr>
        <td><code>includes CSP</code></td>
        <td class="numeric">0.64%</td>
        <td class="numeric">0.59%</td>
      </tr>
      <tr>
        <td><code>includes not-allowed policy</code></td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.11%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="metaタグを使用して異なるポリシーを有効にしているホストの割合", sheets_gid="1717430289", sql_file="meta_policies_allowed_vs_disallowed.sql") }}</figcaption>
</figure>

他のセキュリティメカニズムは `<meta>` タグを使用して設定できませんが、毎年開発者がこれを試みているのが確認されます。今年はモバイルでmetaタグを使用して設定できないポリシーが0.07%から0.11%に増加しています。これらの値はブラウザに無視されるため、正しいヘッダーが設定されていない場合、ユーザーが脆弱な状態になる可能性があります。継続的な例として、今年は `X-Frame-Options` ポリシーを含む5,564のmetaタグが見つかりました。これは昨年より約600ページ多く、懸念されるトレンドです。

### ウェブ暗号化API

<a hreflang="en" href="https://www.w3.org/TR/WebCryptoAPI/">ウェブ暗号化API</a>は、基本的な暗号化操作を実行するインターフェースを提供するJavaScript APIです。そのような操作の例は、乱数の生成、ハッシュ化、コンテンツの署名、署名の検証、そしてもちろん暗号化と復号化です。

<figure>
  <table>
    <thead>
      <tr>
        <th>機能</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>CryptoGetRandomValues</code></td>
        <td class="numeric">34.45%</td>
        <td class="numeric">40.95%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoDigest</code></td>
        <td class="numeric">2.65%</td>
        <td class="numeric">2.98%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha256</code></td>
        <td class="numeric">2.36%</td>
        <td class="numeric">2.48%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoImportKey</code></td>
        <td class="numeric">1.29%</td>
        <td class="numeric">1.68%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmEcdh</code></td>
        <td class="numeric">0.97%</td>
        <td class="numeric">1.39%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha512</code></td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.32%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmSha1</code></td>
        <td class="numeric">0.21%</td>
        <td class="numeric">0.26%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmAesCbc</code></td>
        <td class="numeric">0.21%</td>
        <td class="numeric">0.17%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoSign</code></td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.14%</td>
      </tr>
      <tr>
        <td><code>SubtleCryptoEncrypt</code></td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td><code>CryptoAlgorithmHmac</code></td>
        <td class="numeric">0.10%</td>
        <td class="numeric">0.11%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="ウェブ暗号化APIの機能の使用状況", sheets_gid="433834892", sql_file="web_cryptography_api.sql") }}</figcaption>
</figure>

`CryptoGetRandomValues` 関数はこのAPIで最も広く使用されている機能のままですが、[昨年と同様に](../2024/security#ウェブ暗号化api)使用が引き続き低下しています。モバイルでの使用は今年12%以上低下し、41%をわずかに下回っています。他の機能は引き続き上昇しており、2番目に人気の機能 `SubtleCryptoDigest` は1.2%増加して3%弱になっています。

### ボット保護サービス

ボットはウェブに長い間存在しており、悪意のあるボットはその大きな部分を占めています。これらの問題のために、異なるベンダーによってウェブサイトをボットから保護するための多くの製品が作成されました。これらの製品の使用は今年も含めて年々増加し続けており、モバイルでの採用率が26.5%から31.1%に急増し、4.5%以上の上昇となっています。

{{ figure_markup(
  image="bot-protection-absolute.png",
  caption="使用中のボット保護サービスの絶対的な分布。",
  description="デスクトップとモバイルプラットフォームでのさまざまなボット対策ツールのシェアを示す棒グラフ。データはreCAPTCHAとCloudflare Bot Managementが両クライアントタイプにわたってウェブサイトの約30%を集合的に保護する主要サービスであることを示しています。デスクトップサイトはこれらのサービスの全体的な採用率がモバイルの31%強よりわずかに高い34%以上を示しています。Cloudflare Turnstile、hCaptcha、DDoS-Guardなどの他のサービスは総市場のはるかに小さな分数を表し、調査されたウェブサイトの2%未満に現れています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1081236768&format=interactive",
  sheets_gid="1427912746",
  sql_file="bot_detection.sql"
  )
}}

{{ figure_markup(
  image="bot-protection-relative.png",
  caption="使用中のボット保護サービスの相対的な分布。",
  description="そのようなサービスを利用するウェブサイトのサブセット内でのさまざまなボット対策ツールのシェアを示す棒グラフ。データはreCAPTCHAとCloudflare Bot Managementが集合的にデスクトップとモバイルの両プラットフォームで相対的使用率の90%以上を占める高度に集中した市場を示しています。具体的には、reCAPTCHAがデスクトップで50.7%、モバイルで52.0%の最大のシェアを保持しており、Cloudflare Bot Managementがそれぞれ40.6%と38.6%で続いています。hCaptcha、DDoS-Guard、Cloudflare Turnstileなどのマイナーなプロバイダーは全体のごく一部を占めるに過ぎず、それぞれ相対的な使用率の2%未満を占めています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1085355715&format=interactive",
  sheets_gid="1427912746",
  sql_file="bot_detection.sql"
  )
}}

reCAPTCHAが依然として最大のボット保護サービスであり続けていますが、Cloudflare Bot Managementはより急速に成長しており、ボット保護サービスを使用するウェブサイトの中でより大きな相対的なシェアを占めています。これらのトレンドが来年も続く場合、Cloudflare Bot ManagementがreCAPTCHAとの差を縮めるのを見るかもしれません。

### HTMLサニタイゼーション

`SetHTMLUnsafe` と `ParseHTMLUnsafe` APIは、比較的最近のブラウザへの追加で、開発者は[JavaScriptから宣言的なシャドウDOMを使用](https://developer.chrome.com/blog/new-in-chrome-124#dsd)できます。

開発者が `innerHTML` を使用して宣言的シャドウDOMの定義（例：`<template shadowrootmode="open">...</template>`）を含むカスタムHTMLコンポーネントをページに配置しようとする場合、これは期待通りに機能しません。`SetHTMLUnsafe` または `ParseHTMLUnsafe` を使用することで、開発者は宣言的シャドウDOMがブラウザによって適切にインスタンス化されることを確認できます。

名前が示すように、開発者はこれらの「unsafe」APIに安全な値のみが渡されることを確認する責任があります。そうでない場合、開発者は危険なコンテンツがページに行き着くリスクを負い、XSS攻撃につながる可能性があります。

<figure>
  <table>
    <thead>
      <tr>
        <th>機能</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>ParseHTMLUnsafe</code></td>
        <td class="numeric">19869</td>
        <td class="numeric">17147</td>
      </tr>
      <tr>
        <td><code>SetHTMLUnsafe</code></td>
        <td class="numeric">443</td>
        <td class="numeric">449</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="HTMLサニタイゼーションAPIを使用するページの数", sheets_gid="1789171380", sql_file="html_sanitization_usage.sql") }}</figcaption>
</figure>

[昨年](../2024/security#htmlサニタイズ)以降、これらのAPIの使用が大幅に増加しています。モバイルでは、`SetHTMLUnsafe` を使用するページの数が2ページから449ページに増加し、`ParseHTMLUnsafe` を使用するページ数は今年6から17,147に増加しました。後者はクロールされたページの0.06%を占めるに過ぎませんが、興味深い変化であり、翌年も採用が増加し続けることが期待されます。ただし、これらのAPIが近い将来に広く普及することは予想されていません。

## セキュリティ機構の採用促進要因

ウェブ開発者がより多くのセキュリティプラクティスを採用することを選ぶ理由はさまざまあります。最も注目すべきものには以下があります：

- **地理的要因**: 地域によって、よりセキュリティ指向の教育や知識があるかもしれません。場合によっては、より厳格なセキュリティ衛生を義務付ける地域の法律がある場合もあります。
- **技術的要因**: 使用する技術スタックはセキュリティ機構の採用に影響を与えることがあります。使用する技術によっては、開発者が意識して有効にしなくてもいくつかのセキュリティ機能がデフォルトで有効になります。
- **人気**: 非常に人気のあるウェブサイトは、特定のサイバー攻撃の標的になりやすいため、セキュリティに大きな予算を持っている場合があります。さらに、これらのサイトはより多くのセキュリティ専門家や場合によってはバグバウンティハンターを引き付け、セキュリティ機能の実装と防御の強化を支援します。

### ウェブサイトの所在地

ウェブサイトがホストされている場所や開発者が拠点を置いている場所は、特定のセキュリティ機能の採用に大きな影響を与えることがあります。開発者向けのセキュリティ教育は大きな役割を果たしており、開発者は自分が知らない機能や理解していない機能を実装することができません。さらに、地域の法律が特定のセキュリティプラクティスの採用を要求する場合があります。

{{ figure_markup(
  image="https-by-country.png",
  caption="国ごとのHTTPS採用率：採用率の上位10カ国と下位10カ国。",
  description="さまざまな国でのHTTPSを使用するデスクトップウェブサイトの割合を示す棒グラフ。データはニュージーランドが99.70%でリストをリードし、スイスとナイジェリアが99.67%で僅差に続く、世界的に非常に高い採用率を示しています。日本と韓国などのこの特定のランキングの下位の国々でさえ、それぞれ94.17%と95.34%の採用率で高い暗号化標準を維持しています。全体として、図表はリストされたすべての国が94%の採用率の閾値を超えており、セキュアなウェブ通信へのほぼ普遍的な移行を示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1706573742&format=interactive",
  sheets_gid="1980003998",
  sql_file="feature_adoption_by_country.sql"
  )
}}

HTTPSの採用は年々増加しており、幸いにも今年もこのトレンドが続いています。上位の国々でさえ採用率が数十分の一パーセントずつ増加し続けているのが見られます。下位の国々ではHTTPS採用率がやや大きく上昇し、日本は今や95%未満の採用率を持つ唯一の国となり、98%未満のHTTPS採用率を持つのはわずか5カ国で、非常に良好な結果です。今後数年で、下位の国々が上位の国々の採用率に徐々に追いつくことが期待されますが、完全な100%の採用は近い将来には難しそうです。

{{ figure_markup(
  image="csp-xfo-by-country.png",
  caption="国ごとのCSPとXFOの採用率：CSP採用率の上位5カ国と下位5カ国。",
  description="さまざまな国でのデスクトップサイトでのコンテンツセキュリティポリシーとX-Frame-Optionsの実装率を示す棒グラフ。ニュージーランドが両方のセキュリティ対策で最高の採用率を持ち、XFOで42.25%、CSPで29.50%に達しています。対照的に、韓国はXFOを使用するサイトが14.69%、CSPを使用するサイトが8.89%と大幅に低い水準を示しています。リストされたすべての国で、データはX-Frame-OptionsがContent Security Policyよりも高い採用率を一貫して示しており、CSPはより複雑またはあまり頻繁に実装されないセキュリティ標準であることを示唆しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1911016277&format=interactive",
  sheets_gid="1980003998",
  sql_file="feature_adoption_by_country.sql"
  )
}}

より複雑なセキュリティメカニズムを見ると、より多様な状況が見られます。ほとんどのリーダー国でわずかな採用の増加がある一方で、一部の下位国でこれらのポリシーの採用が減少しました。リーダー国はまだウェブサイトの4分の1強にCSPを設定しています。CSPとXFOの差は大きいままですが、わずかに上昇しており、[昨年](../2024/security#ウェブサイトの場所)の15%ではなく最大14%にとどまっています。

### テクノロジースタック

ウェブサイトのセキュリティは、使用する技術によって異なる場合があります。フレームワークにはデフォルトでセキュリティ機能が含まれており、大手ベンダーはユーザーをセキュアに保つことが利益になるため、これらの基盤技術を使用することでウェブサイトのセキュリティが向上する可能性があります。

<figure>
  <table>
    <thead>
      <tr>
        <th>テクノロジー</th>
        <th>セキュリティ機能</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>LiveJournal</td>
        <td><code>Content-Security-Policy</code> (99.99%), <code>Permissions-Policy</code> (99.99%), <code>Referrer-Policy</code> (99.99%)</td>
      </tr>
      <tr>
        <td>Weblium</td>
        <td><code>X-Content-Type-Options</code> (97.31%), <code>X-XSS-Protection</code> (97.31%)</td>
      </tr>
      <tr>
        <td>GoDaddy Website Builder</td>
        <td><code>Strict-Transport-Security</code> (95.97%), <code>Content-Security-Policy</code> (95.97%)</td>
      </tr>
      <tr>
        <td>Sitevision CMS</td>
        <td><code>X-Frame-Options</code> (81.54%)</td>
      </tr>
      <tr>
        <td>Microsoft Sharepoint</td>
        <td><code>X-Content-Type-Options</code> (57.44%)</td>
      </tr>
      <tr>
        <td>Liferay</td>
        <td><code>X-Content-Type-Options</code> (52.65%)</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="選択されたCMSシステムで使用されているセキュリティ機能", sheets_gid="1417258040", sql_file="feature_adoption_by_technology.sql") }}</figcaption>
</figure>

多くのブログウェブサイトとウェブサイトビルダーが、HSTS、CSP、`X-Content-Type-Options` が最も人気のあるものの中に入る、いくつかの重要なセキュリティメカニズムをほぼすべてのシステムで設定していることが分かります。

### ウェブサイトの人気

大規模なユーザーベースを持つ人気サイトは、ユーザーとその信頼を失わないように、最善の方法でユーザーを保護する十分な理由を持っていることが多いです。しばしば機密性の高いデータを保護しながら、より標的を絞った攻撃の対象になる可能性が高い中で、ウェブサイトのセキュリティへの多大な投資が必要ですが、そのトレードオフとして、より一般的にセキュアなウェブサイトにつながります。

{{ figure_markup(
  image="security-headers-by-rank.png",
  caption="CrUXによるウェブサイトランク別のセキュリティヘッダー採用率。",
  description="さまざまなセキュリティヘッダーの実装がモバイルでのウェブサイトの人気ランキングとどのように相関しているかを示す棒グラフ。データは、上位1,000サイトなどのより人気のあるウェブサイトが、より広いウェブと比較して`X-Frame-Options`や`Strict-Transport-Security`などのヘッダーに対して大幅に高い採用率を持つ明確なトレンドを示しています。例えば、`X-Frame-Options`の採用率は上位1,000サイトで60%を超えますが、すべてのサイトを合わせると約30%に低下します。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2036748504&format=interactive",
  sheets_gid="775322478",
  sql_file="security_adoption_by_rank.sql"
  )
}}

`X-Frame-Options`、`Strict-Transport-Security`、`X-Content-Type-Options`、`Content-Security-Policy` などの最も人気のあるセキュリティヘッダーは、常にモバイルでより人気のあるウェブサイトでより高い採用率を示しています。最も広く採用されているヘッダーである `X-Frame-Options` は上位1,000サイトの67%で使用されていますが、ブラウザが訪問するすべてのサイトの30%でしか使用されていません。より人気のあるサイトとそうでないサイトの採用率の差は、[昨年](../2024/security#ウェブサイトの人気)から事実上同じままであることが分かります。

### ウェブサイトカテゴリー

業界によっては、ウェブサイトをよりセキュアに保つことに対してより多くの重要性が帰属される場合があります。ウェブサイトが設定するセキュリティヘッダーの平均数に基づいて、業界ごとのウェブサイトのセキュリティへの取り組みを推定しようとします。セキュリティヘッダーの数は必ずしもウェブサイトがより良くセキュアされているかどうかを示すわけではありませんが（セキュリティメカニズムは誤設定される可能性があります）、セキュリティ機能を実装するための取り組みの良い指標を提供します。

{{ figure_markup(
  image="avg-security-headers-per-site.png",
  caption="ウェブサイトカテゴリー別のセキュリティヘッダーの平均数：上位5カテゴリーと下位5カテゴリー。",
  description="モバイルとデスクトップの両プラットフォームでのさまざまなウェブサイト業界における実装されたセキュリティヘッダーの平均数を示す棒グラフ。「インターネット＆テレコム」と「コンピューター＆エレクトロニクス」セクターが大幅にリードしており、これらのカテゴリーのモバイルサイトはそれぞれ平均4.6と4.0ヘッダーです。対照的に、「法律＆政府」や「旅行＆交通」などの多くの他の業界はサイトあたり平均1.3ヘッダーと大幅に低い採用率を示しています。リストされたほぼすべてのカテゴリーで、モバイルサイトはデスクトップの対応より平均セキュリティヘッダー数が多い傾向があり、これらの特定の分野でモバイルユーザーのセキュリティへのより強い焦点を強調しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1092427119&format=interactive",
  sheets_gid="662895658",
  sql_file="feature_adoption_by_category.sql"
  )
}}

昨年からセキュリティヘッダーの平均数に大きな変化が見られます。 _インターネット＆テレコム_ と _コンピューター＆エレクトロニクス_ カテゴリーのサイトはより多くのセキュリティヘッダーを使用しています。特にモバイルクライアントではこれらのカテゴリーとの差が明確に見えます。これら2つのカテゴリーが良い意味での例外的なケースであるように見える一方で、他の業界のセキュリティヘッダーの平均数はほぼ同じままで、サイトあたり平均約0.1ヘッダーのわずかな変化があるだけです。

セキュリティヘッダーの観点でリードする2つの業界は、インターネットとコンピューターセキュリティの分野に関連した業界です。これらの業界ではセキュリティの関連性が高いため、これらのサイトの開発者は潜在的なリスクをより認識しており、特定のセキュリティメカニズムをより積極的に使用することが考えられます。

## ウェブ上の不正行為

暗号通貨はこれまで以上に人気があります。暗号通貨マイニングは何年もの間大きなビジネスであり、攻撃者が被害者のウェブサイトにマルウェアの一形態として暗号マイナーをインストールすることが知られています。過去数年で、ウェブ上での暗号マイナーの使用は着実に減少しています。

{{ figure_markup(
  image="cryptominers-trend.png",
  caption="経時的な使用中の暗号マイナー数：2022年5月から2025年9月まで。",
  description="2022年5月から2025年9月にかけてデスクトップとモバイルプラットフォームの両方で暗号マイニングスクリプトが検出されたページ数を示す折れ線グラフ。データは3年間で使用量の全体的な大幅な減少を示しており、モバイルページは一貫してデスクトップページよりも暗号マイナー活動のレベルが高くなっています。2022年初頭、モバイルインスタンスは約250ページでピークに達しましたが、2025年末までに両プラットフォームは大幅に低いレベルに収束し、モバイルは50ページ未満、デスクトップは25ページ未満に留まっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2128543496&format=interactive",
  sheets_gid="612990857",
  sql_file="cryptominer_usage.sql"
  )
}}

暗号マイナーを持つページの数はモバイルでわずか37ページに減少しており、[昨年](../2024/security#fig-47)から42%の減少です。これはまた、わずか3年前の2022年9月から83%の減少でもあります。

{{ figure_markup(
  image="cryptominers-market-share.png",
  caption="暗号マイナーの市場シェア。",
  description="デスクトップとモバイルプラットフォームで検出された特定の暗号マイニングスクリプトを示す棒グラフ。データはJSEcoinとCoinimp、特にモバイルデバイスでそれぞれ9ページで見つかり、最も普及しているサービスであることを示しています。デスクトップでは、Coinimpが5検出ページでリードし、JSEcoinの3が続きます。Minero.cc、CoinHive、Crypto-Lootなどの他のマイナーな寄与者が残りの検出を占めており、全体的な数はデスクトップよりモバイルの方が高くなっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1906348526&format=interactive",
  sheets_gid="1210984012",
  sql_file="cryptominer_share.sql"
  )
}}

ウェブ上の暗号マイナーの絶対数は非常に少ないものの、異なる暗号マイナーが代表するシェアを確認します。[昨年](../2024/security#fig-48)と比較して、Coinimpを持つページの数がJSEcoinを持つ9ページと一致するまで減少しています。興味深い点は、デスクトップとモバイルページの暗号マイナーの数の違いで、モバイルのページ数はデスクトップのほぼ2倍になっています。

## セキュリティの誤設定と見落とし

ウェブとブラウザで利用可能なセキュリティメカニズムは数多くありますが、これらのメカニズムを正しく期待通りに設定することが不可欠です。誤設定されたセキュリティメカニズムは、ユーザーが保護されていると思っている開発者に偽りのセキュリティ感を生み出します。このセクションでは、ウェブサイトのセキュリティを損なう可能性のあるいくつかの誤設定の発生を強調します。

### `<meta>`でサポートされていないポリシー

セキュリティポリシーを設定する際、開発者はポリシーをどのように定義すべきかを理解することが重要です。一部のポリシーはヘッダーとHTML `<meta>` タグの両方で定義できます。ただし、多くのポリシーは `<meta>` を通じて定義できません。開発者は時々、これらのポリシーを `<meta>` タグを通じて設定しようとする間違いを犯します。残念ながらブラウザはこれらのポリシーを無視し、非アクティブなセキュリティポリシーになります。

<figure>
  <table>
    <thead>
      <tr>
        <th>ポリシー</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>X-Frame-Options</code></td>
        <td class="numeric">4,584</td>
        <td class="numeric">5,564</td>
      </tr>
      <tr>
        <td><code>X-Content-Type-Options</code></td>
        <td class="numeric">2,440</td>
        <td class="numeric">2,854</td>
      </tr>
      <tr>
        <td><code>Permissions-Policy</code></td>
        <td class="numeric">1,983</td>
        <td class="numeric">2,236</td>
      </tr>
      <tr>
        <td><code>X-XSS-Protection</code></td>
        <td class="numeric">1,691</td>
        <td class="numeric">1,702</td>
      </tr>
      <tr>
        <td><code>Referrer-Policy</code></td>
        <td class="numeric">1,630</td>
        <td class="numeric">1,644</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`<meta>`を通じて誤って設定されたセキュリティポリシーの上位5件", sheets_gid="1717430289", sql_file="meta_policies_allowed_vs_disallowed.sql") }}</figcaption>
</figure>

モバイルサイトの約0.11%が、ブラウザが `<meta>` タグを通じて明示的にサポートしないセキュリティヘッダーを設定しようとしていることが分かります。最もよく試みられるポリシーは `X-Frame-Options`、`X-Content-Type-Options`、`Permissions-Policy` です。2024年と比較して、`<meta>` でこれらのポリシーを設定するモバイルサイトの数が絶対数で5,000ページ以上増加しており、これらの誤設定が開発者によってまだ積極的に設定されていることを示しています。

### `<meta>`でサポートされていないCSPディレクティブ

CSPは `<meta>` タグを通じて設定 *できます* が、この動作はモバイルページの0.59%で観察されており、特定のCSPディレクティブは `<meta>` タグの実装では明示的に禁止されており、ブラウザに無視されます。これらのディレクティブは `Content-Security-Policy` レスポンスヘッダーを使用することでのみ設定できます。

<figure>
  <table>
    <thead>
      <tr>
        <th>ディレクティブ</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>frame-ancestors </code></td>
        <td class="numeric">2.37%</td>
        <td class="numeric">2.11%</td>
      </tr>
      <tr>
        <td><code>sandbox </code></td>
        <td class="numeric">0.004%</td>
        <td class="numeric">0.003%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="`<meta>`で定義されたCSPポリシーのうち禁止されたディレクティブを含む割合", sheets_gid="1969221363", sql_file="meta_csp_disallowed_directives.sql") }}</figcaption>
</figure>

`<meta>` タグを通じてCSPポリシーを設定するモバイルページの2%以上が `frame-ancestors` ディレクティブを含んでおり、0.003%が `sandbox` ディレクティブを含んでいることが分かります。後者はクロールされたデータセット全体でわずか3ページに相当します。前回版と比較して、`frame-ancestors` の誤設定は600ページ多く現れており、0.8%以上上昇しています。これはこの種の誤設定に対するゆっくりだが否定的な進展を表しています。

### COOP/COEP/CORPの混同

クロスオリジンポリシーのCOEP、CORP、COOPは類似した命名を持ち、目的が関連しているため、開発者によって混同されることがあります。これらのヘッダーに誤った値を割り当てると、ブラウザはヘッダーがまったく提供されていないかのようにデフォルトのポリシーを適用し、開発者が望む追加の防御が無効になります。

<figure>
  <table>
    <thead>
      <tr>
        <th>無効なCOEP値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>same-origin</code></td>
        <td class="numeric">4.43%</td>
        <td class="numeric">4.02%</td>
      </tr>
      <tr>
        <td><code>cross-origin</code></td>
        <td class="numeric">0.55%</td>
        <td class="numeric">0.46%</td>
      </tr>
      <tr>
        <td><code>*</code></td>
        <td class="numeric">0.13%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><code>(unsafe-none|require-corp); report-to='default'</code></td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><code>: require-corp</code></td>
        <td class="numeric">0.09%</td>
        <td class="numeric">0.10%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="無効なCOEPヘッダー値の普及率", sheets_gid="1595978010", sql_file="coep_header_prevalence.sql") }}</figcaption>
</figure>

合計で、観察されたCOEPヘッダーの5.6%がモバイルで無効な値を含んでいます。これらのヘッダーの4%以上がCORPまたはCOOPヘッダーでのみ有効な値である `same-origin` を含んでいます。別の0.5%近くはCORPヘッダー用の値である `cross-origin` を含んでいます。残念ながら、これらの誤設定は[昨年](../2024/security#coepcorpcoopの混同)からも増加し、COEPヘッダーの `same-origin` 値で約1%上昇しました。

これらの誤設定に加えて、ブラウザが解析できないため、ヘッダーのデフォルト値に戻ることになる構文エラーを含むいくつかの値も観察しました。これらの構文エラーは少数のケースを表しています。

### Timing-Allow-Originワイルドカード

[`Timing-Allow-Origin`（TAO）](https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Timing-Allow-Origin)レスポンスヘッダーはサーバーが[Resource Timing API](https://developer.mozilla.org/docs/Web/API/Performance_API/Resource_timing)の機能を通じて取得した属性の値にアクセスできるオリジンのリストを指定できるようにします。このヘッダーにリストされたオリジンは、TCPコネクションの開始時間、リクエストの開始、レスポンスの開始など、サーバーへの接続に関する詳細なタイムスタンプにアクセスできます。このアクセスをオリジンに許可する際は、リストされたオリジンがタイミング攻撃や他のクロスサイト攻撃を実行する可能性が生まれるため、慎重に行う必要があります。

CORSが設定されている場合、上記のようなこれらの種類のタイミング値の多くはクロスオリジンリークを防ぐために0として返されます。`Timing-Allow-Origin` ヘッダーにオリジンをリストすることで、これらの値は元の値を保持し、ゼロアウトされなくなります。

{{ figure_markup(
  content="84%",
  caption="`Timing-Allow-Origin`ヘッダーがワイルドカード（`*`）値に設定されている割合。",
  classes="big-number",
  sheets_gid="788822751",
  sql_file="tao_header_prevalence.sql",
) }}

オリジンのリストを返すことに加えて、開発者は `Timing-Allowed-Origin` ヘッダーの値をワイルドカード文字 `*` に設定して、どのオリジンでもタイミング情報にアクセスできることを示すことができます。TAOヘッダーの84.6%がワイルドカード `*` 値を含んでおり、[昨年](../2024/security#timing-allow-originワイルドカード)から2%上昇していることが分かります。これは多くの開発者がきめ細かなタイミング情報を任意のオリジンに普遍的に公開することに問題がないことを示しています。

### サーバー情報ヘッダーの抑制の欠如

ウェブサイトがサーバーとその特定バージョンなど、インフラについての過剰な情報を公開した場合、自動脆弱性スキャナーの標的になるリスクが高くなる可能性があります。この情報を非表示にすることはセキュリティ・バイ・オブスキュリティの一形態であり、システムのコアな脆弱性には対処しないため一般的に眉をひそめられる戦略ですが、特定の攻撃のレーダー下に留まるのに役立つ可能性があるため分析を含めます。

このような情報を報告するために一般的に使用されるヘッダー、すなわち：`Server`、`X-Server`、`X-Backend-Server`、`X-Powered-By`、`X-Aspnet-Version` の使用を追跡します。

{{ figure_markup(
  image="server-headers.png",
  caption="サーバーに関する情報を伝えるために使用されるヘッダーの普及率。",
  description="2023年から2025年にかけてのモバイルウェブサイトでのさまざまな情報ヘッダーの採用を示す棒グラフ。`Server`ヘッダーは2025年に91.52%のサイトに現れるほぼ普遍的なままであり、`X-Powered-By`ヘッダーは23.99%で使用されています。`X-Aspnet-Version`、`X-Server`、`X-Backend-Server`などの他の特殊なヘッダーははるかに低い使用率を示しており、すべてのカテゴリーが3年間でわずかだが一貫した下降トレンドを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=347972704&format=interactive",
  sheets_gid="374546324",
  sql_file="server_information_header_prevalence.sql"
  )
}}

過去の年と同様に、`Server` ヘッダーは `X-Powered-By` を大差で最も広く使用されているヘッダーであり続けています。これらのヘッダーはウェブ上のホストの91.5%と23.9%に表示されます。各ヘッダーについて、表示されるホストの数がわずかに減少しているのが見られます。多くのウェブ技術がこれらのヘッダーの一部を自動的に設定し、開発者はセキュリティ上の利点が小さいため、これらのヘッダーを削除することにあまり興味がないかもしれないため、これらの値が時間とともに大きく変化することは期待されません。

<figure>
  <table>
    <thead>
      <tr>
        <th>ヘッダー値</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>PHP/7.4.33</code></td>
        <td class="numeric">9.54%</td>
        <td class="numeric">9.98%</td>
      </tr>
      <tr>
        <td><code>PHP/7.3.33</code></td>
        <td class="numeric">3.61%</td>
        <td class="numeric">4.29%</td>
      </tr>
      <tr>
        <td><code>PHP/5.3.3</code></td>
        <td class="numeric">2.10%</td>
        <td class="numeric">2.20%</td>
      </tr>
      <tr>
        <td><code>PHP/5.6.40</code></td>
        <td class="numeric">2.07%</td>
        <td class="numeric">2.12%</td>
      </tr>
      <tr>
        <td><code>PHP/8.0.30</code></td>
        <td class="numeric">1.55%</td>
        <td class="numeric">1.70%</td>
      </tr>
      <tr>
        <td><code>PHP/7.2.34</code></td>
        <td class="numeric">1.34%</td>
        <td class="numeric">1.41%</td>
      </tr>
      <tr>
        <td><code>PHP/8.2.28</code></td>
        <td class="numeric">1.15%</td>
        <td class="numeric">1.31%</td>
      </tr>
      <tr>
        <td><code>PHP/8.3.13</code></td>
        <td class="numeric">1.08%</td>
        <td class="numeric">1.11%</td>
      </tr>
      <tr>
        <td><code>PHP/8.1.32</code></td>
        <td class="numeric">1.05%</td>
        <td class="numeric">1.09%</td>
      </tr>
      <tr>
        <td><code>PHP/8.1.27</code></td>
        <td class="numeric">0.92%</td>
        <td class="numeric">1.06%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="特定のフレームワークバージョンを含む最も普及している`X-Powered-By`ヘッダー値", sheets_gid="1997993812", sql_file="server_header_value_prevalence.sql") }}</figcaption>
</figure>

`Server` と `X-Powered-By` 値の中で最も一般的な値を確認すると、PHPが特に `X-Powered-By` ヘッダーでサーバー上で動作している正確なバージョンを公開する傾向があることが分かります。デスクトップとモバイルの両方で、`X-Powered-By` ヘッダーの27%以上がバージョン情報を含んでいることが分かります。ヘッダーはデータで観察されるプラットフォームによって自動的に返される可能性があります。興味深いことに、古いPHPバージョン7.xと低いバージョンのわずかな減少と、新しいPHPバージョン8.xのわずかな増加が見られ、少なくとも一部の開発者がサーバーをアップデートしていることの兆しです。

### `Server-Timing`ヘッダーの抑制の欠如

`Server-Timing` HTTPヘッダーはサーバーパフォーマンスメトリクスを通信するために使用できる<a hreflang="en" href="https://w3c.github.io/server-timing/">W3C Editor's Draft</a>で定義されたレスポンスヘッダーです。開発者はゼロ以上のプロパティを含むメトリクスを送信できます。指定されたプロパティの一つは `dur` プロパティで、サーバー上の特定のアクションの持続時間を含むミリ秒精度のタイミングを通信するために使用できます。

{{ figure_markup(
  image="server-timing-header-usage.png",
  caption="`Server-Timing`ヘッダーの使用状況。",
  description="デスクトップとモバイルプラットフォームでのこのパフォーマンス監視ヘッダーの普及率を示す棒グラフ。データはデスクトップレスポンスの約27%とモバイルレスポンスの26%が`Server-Timing`ヘッダーを含んでいることを示しています。個別のレスポンスではなくユニークなホストで測定した場合、採用率はわずかに低く、デスクトップホストの21%とモバイルホストの22%がこの機能を利用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1645983336&format=interactive",
  sheets_gid="963438395",
  sql_file="server_timing_usage_values.sql"
  )
}}

`server-timing` ヘッダーを返すホストの割合は、クローラーが訪問したホストの5分の1以上で15%以上増加しました。これは[昨年](../2024/security#server-timingヘッダーの抑制の欠如)からの非常に急激な増加です。

{{ figure_markup(
  image="server-timing-header-dur-property.png",
  caption="`Server-Timing`ヘッダーの`dur`プロパティの相対的な使用状況。",
  description="デスクトップとモバイルプラットフォームでの`Server-Timing`ヘッダー内の特定の期間メトリクスの普及率を示す棒グラフ。データはこれらのヘッダーのかなりの部分（デスクトップで43%、モバイルで42%）が少なくとも1つの`dur`プロパティを含んでいることを示しています。さらに、かなりの割合のホスト（デスクトップで29%、モバイルで27%）が2つ以上の別個の期間メトリクスを公開しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2066582084&format=interactive",
  sql_file="server_timing_usage_values.sql"
  )
}}

ウェブ上の `server-timing` ヘッダーのうち、42%が少なくとも1つの `dur` プロパティを持っていることが分かります。これは[昨年](../2024/security#fig-53)と比較した場合の相対的な減少ですが、年間のヘッダー使用量の急激な増加を考えると、絶対数は増加しています。これはまた、より多くのヘッダーが `dur` プロパティを含まず、開発者が特定のメトリクスの説明を設定できる `desc` プロパティの使用などを通じて、ヘッダーを他の目的で使用していることを意味します。

`server-timing` ヘッダーに含まれる情報は機密性がある可能性があるため、値へのアクセスは同一オリジンと `Timing-Allow-Origin` ヘッダーにリストされたオリジンに制限されています。上述のように、多くのウェブサイトはワイルドカード文字で `Timing-Allow-Origin` を設定しており、潜在的に機密性の高い情報にすべてのオリジンがアクセスできるようにしています。クロスオリジンアクセスがなくても、ブラウザのコンテキスト外でサーバーが機密性の高いタイミング情報を公開している場合、タイミング攻撃をサーバーに直接実行することが可能です。

## Well-known URI

Well-known URIはサイト全体のメタデータとサービスのための特定の場所を指定するための標準化されたメカニズムを提供します。<a hreflang="en" href="https://www.rfc-editor.org/rfc/pdfrfc/rfc8615.txt.pdf">RFC 8615</a>で定義されているwell-known URIは、プレフィックス `/.well-known/` で始まるパスコンポーネントによって識別されます。これにより、クライアントはサイトのURLスキームに関する事前知識がなくても特定のリソースを発見できます。

### `security.txt`

よく知られている<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc8615.txt">`security.txt`</a>ファイルはウェブサイトが脆弱性報告情報を通信するために使用する標準化されたファイル形式です。ホワイトハットハッカーやペネトレーションテスターはこのファイルを使用して、責任ある開示のための連絡先詳細、PGPキー、ポリシー、その他の情報を見つけることができます。

{{ figure_markup(
  image="security-text-property-usage.png",
  caption="`security.txt`プロパティの使用状況。",
  description="デスクトップとモバイルプラットフォームでの`security.txt`ファイル内のさまざまなフィールドの実装を示す棒グラフ。データは必須の`contact`フィールドが最も広く採用されているプロパティで、ファイルの94%に現れていることを示しており、もう一つの必須フィールド`expires`は実装の約75%に存在します。`preferred_language`（72%）と`hiring`（37%）などの他の一般的なオプションフィールドに対して、`encryption`（9%）、`signed`（2%）、`csaf`（0%）などのより技術的または管理的なプロパティははるかに低い使用率です。全体的に、採用率はデスクトップとモバイルデバイスでほぼ同じです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=2020387408&format=interactive",
  sheets_gid="1421232798",
  sql_file="well-known_security.sql"
  )
}}

採用率はデスクトップで1.82%、モバイルサイトで1.72%に増加し、どちらも[2024年の1%](../2024/security#securitytxt)から上昇しており、標準化されたセキュリティ開示プラクティスへの認識が高まっていることを示しています。

`security.txt` を実装しているサイトの中では、連絡先情報がデスクトップで95%、モバイルで94%とほぼ普遍的に含まれており、2024年の92%と89%からそれぞれ上昇しています。興味深いことに、75%が有効期限を定義しており、2024年のデスクトップで51%、モバイルで48%から大幅に増加しています。優先言語は実装の70〜72%で指定されており、脆弱性報告手順を定義するポリシーはデスクトップで37%、モバイルファイルで34%にのみ現れており、2024年の39%から低下しています。ただし、ポリシーを定義する `security.txt` ファイルの絶対数は3分の2増加しました。

この分析は、`security.txt` ファイルの少なくとも25%が完全に有効ではないことを示しています。これは<a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc9116.txt">RFC 9116</a>で規定されているように、連絡先情報とともに有効期限を含めることが必要だからです。

### `change-password`

<a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/">`change-password` well-known URI</a>は2021年のW3C仕様草案で、それ以来更新されていません。このURIの目的は、ユーザーと外部リソースが特定のサイトのパスワードを変更できる正しい場所をすばやく見つけるためのものです。

{{ figure_markup(
  image="change-password-usage.png",
  caption="change-password .well-knownエンドポイントの使用状況。",
  description="デスクトップとモバイルプラットフォームで標準の`/.well-known/change-password`リダイレクトを実装しているウェブサイトの割合を示す棒グラフ。データはこの機能の非常に低い採用率を示しており、現在エンドポイントを利用しているデスクトップサイトはわずか0.30%、モバイルサイトは0.27%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1701010385&format=interactive",
  sheets_gid="2031721186",
  sql_file="well-known_change-password.sql"
  )
}}

デスクトップサイトは0.27%から0.30%にわずかに上昇し、モバイルエンドポイントでは0.27%のまま変化がないことが分かります。この緩やかな採用は、すべてのウェブサイトが認証メカニズムを必要とするわけではないことを考えると、予想外ではありません。

### ステータスコードの信頼性検出

ウェブサイトのHTTPレスポンスステータスコードの信頼性を確認するための<a hreflang="en" href="https://w3c.github.io/webappsec-change-password-url/response-code-reliability.html">仕様</a>草案も2021年から変更されていません。この特定のwell-knownエンドポイントの目的は、それが決して存在してはならず、したがってレスポンスステータスコードが決して<a hreflang="en" href="https://fetch.spec.whatwg.org/#ok-status">okステータス</a>であってはならないというものです。サイトがokステータスで応答するリダイレクトが発生した場合、これは不正な動作とみなされます。

{{ figure_markup(
  image="well-known-responses.png",
  caption="ステータスコードの信頼性を評価するための`.well-known`エンドポイントに返されるステータスの分布。",
  description="ウェブサーバー全体で一貫したメタデータ発見のために使用される標準化された`.well-known` URIプレフィックスへのリクエストの成功率を示す積み上げ棒グラフ。データはこれらのリクエストの圧倒的多数（デスクトップで83%、モバイルで82%）が「not ok」ステータスになり、意図されたリソースが正常に取得または見つけられなかったことを示しています。対照的に、成功した200 OKレスポンスはリクエスト総数の約10%のみを占め、201〜299の範囲のステータスコードは追加の8%を占めています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1650502790&format=interactive",
  sheets_gid="182236208",
  sql_file="well-known_resource-not-be-200.sql"
  )
}}

[2022年版](../2022/security#change-password)と[2024年版](../2024/security#change-password)のWeb Almanacと同様の結果が見られます。ただし、誤ったokステータスレスポンスの数はわずかに増加しており、2024年のデスクトップとモバイルページの両方で84%からそれぞれ83%と84%になっています。ウェブ開発者は、これらのステータスコードが意味を失わないようにするために、アプリケーションが受信リクエストに正しいステータスコードで応答し続けるようにする必要があります。

### `robots.txt`内の機密エンドポイント

最後に、よく知られている `robots.txt` ファイルで機密エンドポイントがクローラーによる訪問を禁止されているかどうかを確認します。このファイルの禁止されたエンドポイントを確認することで、攻撃者は標的にするページを見つける可能性があります。今年は、デスクトップサイトの81%とモバイルサイトの80%が `robots.txt` ファイルをホストしており、[昨年版のWeb Almanac](../2024/security#robotstxtの機密エンドポイント)と非常に似ています。

{{ figure_markup(
  image="robots-text-sensitive-endpoints.png",
  caption="指定されたエンドポイントを`robots.txt`に含むサイトの割合。",
  description="デスクトップとモバイルプラットフォームでウェブクローラーから潜在的に機密性の高いディレクトリがブロックされている出現率を示す棒グラフ。データは`admin`が最も頻繁に禁止されている機密用語で、デスクトップの`robots.txt`ファイルの4.29%に現れ、次いで`account`が2.96%です。`login`（1.73%）と`auth`（0.57%）などの他の用語も一般的に制限されており、`signin`と`sso`は出現率の0.05%未満です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQVbvwEPuhyK8NPPVMVbTlXLI6JfPUX-W4hcSoBU14ZB09qx4ZdSDIuMt2UGIMkWMQZHuQO28HO5Ps5/pubchart?oid=1097990890&format=interactive",
  sheets_gid="1854752678",
  sql_file="robot-txt_sensitive_disallow.sql"
  )
}}

これらのファイルの内容も非常に似ています。最大の増加はデスクトップサイトで `auth` エンドポイントの0.2%であり、最大の減少はデスクトップサイトで `login` エンドポイントの0.2%でした。

## 結論

このセキュリティチャプターはウェブセキュリティポリシーの採用において前向きなトレンドを示しています。HTTPSは全体的に100%近くの採用率に達しており、国別のメトリクスは全ての国がHTTPSの普遍的な使用という目標に向けて進んでいることを示しています。`Content-Security-Policy` は18%以上の使用増加、`Permissions-Policy` は昨年より50%多く使用されるなど、最新の攻撃からユーザーをより良く保護することを目的とした多くの最新セキュリティポリシーの採用が増加しているのが見られました。また、ドキュメントポリシーのような新しいポリシーが実際の環境に現れているのも見られ、開発者が新しいセキュリティ機能の採用に積極的に取り組んでいることを示しています。

これらの前向きなトレンドにもかかわらず、開発者はこれらのセキュリティメカニズムを活用する際に警戒を続けなければなりません。利用可能な多くのセキュリティメカニズムの複雑さの増大により、ウェブ上での誤設定の数が増加しているのが見られました。ページの0.1%がブラウザでサポートされていないにもかかわらず `<meta>` HTMLタグでセキュリティポリシーを設定していることが分かりました。もう一つの問題は関連する保護の間の混同です：COEPヘッダーの値の5%は、関連するCORPまたはCOOPヘッダーでのみ有効な無効値です。また、開発者の疲労のような形も観察されており、デプロイをより管理しやすくするか潜在的な問題を防ぐために、保護の最も緩やかな値が設定されています。例えば `Timing-Allow-Origin` ヘッダーのワイルドカード値はこれらのヘッダーの84%以上に現れています。幸い、開発者が問題を認識すれば、これらの問題を簡単に軽減できます。

将来の新しい攻撃は必然的に世界中のユーザーを安全に保つためのさらに多くの保護メカニズムの設計を推進するでしょう。政策立案者は開発者の混乱を避けるためにこれらの新しいメカニズムの複雑さを減らすことに焦点を当てる必要がありますが、新しいセキュリティ機能の採用に時間がかかる一方で、比較的新しいポリシーが採用され、時間とともに多くの採用を得ており、すべての人にとってより安全なウェブを生み出しています。
