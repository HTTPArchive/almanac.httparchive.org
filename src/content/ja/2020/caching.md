---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: キャッシング
description: 2020年版Web Almanacのキャッシングの章では、キャッシュコントロール、期限切れ、TTL、有効性、可変、set-cookies、AppCache、サービスワーカー、機会について説明しています。
authors: [roryhewitt, raghuramakrishnan71]
reviewers: [jzyang]
analysts: [raghuramakrishnan71]
editors: [tunetheweb]
translators: [ksakae1216]
roryhewitt_bio: <a hreflang="en" href="https://www.akamai.com/">Akamai</a>のエンタープライズアーキテクトで、パフォーマンスに情熱を注いでいます。イギリスからの帰国子女で、サンフランシスコに20年以上住んでいます。余暇には、長距離アドベンチャーバイク、スノーボーダー、ボクサー/カラテカとして活躍しています。彼はトラブルメーカーとして知られていることが好きです。そして何より、父親であり、夫であり、猫のルナの飼い主でもあるのです。
raghuramakrishnan71_bio: <a hreflang="en" href="https://www.tcs.com/">Tata Consultancy Services</a>のエンタープライズアーキテクトで、公共部門の大規模なデジタルトランスフォーメーションプログラムに従事しています。テクノロジーに興味があり、特にパフォーマンスエンジニアリングに関心があります。旅行好きで、天文学、歴史、生物学、医学の進歩に興味を持っています。バガヴァッド・ギーターの第2章47節 "karmaṇy-evādhikāras te mā phaleṣhu kadāchana "を強く信奉している。
discuss: 2056
results: https://docs.google.com/spreadsheets/d/1fYmpSN3diOiFrscS75NsjfsrKXzxxhUMNcYSqXnQJQU/
featured_quote: キャッシングは、コストのかかるネットワークリクエストを回避することで、パフォーマンスに大きなメリットをもたらします。これは、エンドユーザーにとっても（ウェブページを早く手に入れることができる）、ウェブページを提供する企業にとっても（サーバーの負荷を軽減する）メリットがあります。キャッシングはまさにWin-Winの関係なのです。
featured_stat_1: 25.6%
featured_stat_label_1: キャッシング情報のないHTTPレスポンス
featured_stat_2: 21.4%
featured_stat_label_2: 再検証ができない回答
featured_stat_3: 21.3%
featured_stat_label_3: キャッシングの改善により、再訪問時に2MB以上の節約が可能なサイト
---

## 序章

キャッシングとは、一度ダウンロードしたコンテンツを再利用するための技術です。これは、何か（ウェブページを構築するサーバー、CDNなどのプロキシ、またはブラウザ自体）が「コンテンツ」（ウェブページ、CSS、JS、画像、フォントなど）を保存し適切なタグを付けることで再利用できるようにするものです。

非常にハイレベルな例を挙げてみましょう。

  *Janeは，ウェブサイト www.example.com のホームページを訪れました．Janeはカリフォルニア州ロサンゼルスに住んでおり、example.comのサーバーはマサチューセッツ州ボストンにあります。Janeが www.example.com にアクセスする際には、国を越えて移動しなければならないネットワークリクエストが発生します。*

  *example.comのサーバー（通称：Originサーバー）では、ホームページが取得されます。サーバーはJaneがLAに住んでいることを知り、Janeの近くで開催されるイベントのリストなどの動的コンテンツをページに追加します。その後、ページはアメリカのジェーンに送信され、ジェーンのブラウザに表示されます。*

  *キャッシングがない場合、LAのCarlosがJaneの後に www.example.com を訪れた場合、彼のリクエストは国を越えてexample.comのサーバーに移動しなければなりません。サーバーは、LAのイベントリストを含む同じページを構築しなければなりません。そして、そのページをCarlosに送り返さなければなりません。*

  *さらに悪いことに、Janeがexample.comのホームページを再訪すると、それ以降のリクエストは最初のリクエストと同じようになります。リクエストは国を越えて移動し、example.comのサーバーはホームページを再構築して彼女に送り返さなければなりません。*

  *つまり、キャッシングがなければ、example.comのサーバーは各リクエストを最初から構築することになります。これはサーバーにとって、より多くの仕事をすることになるので悪いことです。さらに、JaneまたはCarlosとexample.comサーバーとの間の通信で、データは国を越えて移動する必要があります。このようなことが重なると、体感速度は低下し、二人にとって良くないことになります。*

  *しかしサーバーキャッシングでは、Janeが最初のリクエストをしたときに、サーバーはホームページのLA版を構築します。これは、すべてのLAの訪問者が再利用できるようにデータをキャッシュします。ですから、Carlosのリクエストがexample.comのサーバーに届いたとき、サーバーはホームページのLA版がキャッシュにあるかどうかをチェックします。Janeの以前のリクエストの結果、そのページはキャッシュに入っているので、サーバーはキャッシュされたページを返すことで時間を節約します。*

  *さらに重要なことは、ブラウザキャッシュではJaneのブラウザは最初のリクエストでサーバからページを受け取ると、そのページをキャッシュします。今後のexample.comのホームページへのリクエストはすべて、ネットワークリクエストなしに、ブラウザのキャッシュから提供されることになります。example.comのサーバも、Janeのリクエストを処理する必要がないというメリットがあります。*

  *Janeは幸せです。Carlosも幸せです。example.comの皆さんも幸せです。みんな幸せです。*

ブラウザのキャッシングは、コストのかかるネットワークリクエストを回避することで、パフォーマンス上の大きなメリットをもたらすことは明らかでしょう（ただし、<a hreflang="en" href="https://simonhearne.com/2020/network-faster-than-cache/">常にエッジケースが存在します</a>）。また、ウェブサイトのオリジン・インフラストラクチャへのトラフィックを減らすことで、アプリケーションの拡張にも役立ちます。サーバーキャッシングは、基礎となるアプリケーションの負荷を大幅に軽減します。

キャッシングは、エンドユーザーにとっても（Webページを早く手に入れられる）、Webページを提供する企業にとっても（サーバーの負荷を軽減できる）メリットがあります。キャッシングはまさにWin-Winの関係なのです。

ウェブ・アーキテクチャでは、一般的に複数の階層のキャッシングが行われます。キャッシングが行われる場所としては、主に4つの場所、すなわち*caching entities*があります。

1. エンドユーザーのブラウザです。
1. エンドユーザーのブラウザ上で動作するサービスワーカーのキャッシュです。
1. コンテンツデリバリーネットワーク（CDN）などのプロキシで、エンドユーザーのブラウザとオリジンサーバーの間に設置される。
1. オリジン・サーバーそのものです。

本章では、オリジンサーバーやCDNでのキャッシングではなく、主にブラウザ内（1-2）でのキャッシングについて説明します。とはいえ、本章で取り上げるキャッシングに関する具体的なトピックの多くは、ブラウザとサーバー（CDNを使用している場合はそのサーバー）との関係に依存しています。

キャッシングやウェブの仕組みを理解するには、リクエストする側（ブラウザなど）とレスポンスする側（サーバなど）の間のトランザクションで成り立っていることを覚えておくとよいでしょう。各トランザクションは2つの部分で構成されています。

1. リクエストする側のエンティティからの要求。"*私はオブジェクトXが欲しい*"となります。
2. 応答する側のエンティティからのレスポンスです。"*これがオブジェクトXです*"となります。

キャッシングというと、リクエストした側のオブジェクト（HTMLページや画像など）がキャッシュされることを指します。

下図は、オブジェクト（Webページなど）に対する典型的なリクエスト／レスポンスの流れを示しています。ブラウザとサーバの間にはCDNがあります。ブラウザ→CDN→サーバの流れの各ポイントで、各キャッシングエンティティは、まず自分のキャッシュにオブジェクトがあるかどうかを確認します。見つかった場合は、キャッシュされたオブジェクトをリクエスト元に返し、その後、リクエストを次のキャッシュエンティティに転送します。

{{ figure_markup(
  image="request-response-flow-with-caching.png",
  caption="オブジェクトのリクエスト/レスポンスフロー。",
  description="オブジェクトの典型的なリクエスト/レスポンスフローにおけるキャッシュの使用法を示すシーケンス図。"
  )
}}

<p class="note">注：本章では、特に明記しない限り、デスクトップの統計も同様であると理解した上で、すべての統計をモバイル用にしています。モバイルとデスクトップの統計が大きく異なる場合は、その旨を明記しています。

本章で使用するレスポンスの多くは、一般的に入手可能なサーバーパッケージを使用するウェブサーバーからのものです。ベストプラクティスを示すことはできても、使用しているソフトウェアパッケージのキャッシュオプションの数が限られている場合には、ベストプラクティスを実現できない可能性があります。</p>

## キャッシングの基本原則

ウェブコンテンツのキャッシュには、3つの指針があります。

* 可能な限りのキャッシュ
* できる限り長くキャッシュする
* エンドユーザーにできるだけ近い場所でキャッシュする

### 可能な限りのキャッシュ

何をキャッシュするかを検討する際には、レスポンスの内容が*static*なのか*dynamic*なのかを理解することが重要です。

#### 静的コンテンツ

静的コンテンツの例として、画像があります。たとえばcat.jpgというファイルに収められた猫の写真は、誰がリクエストしてもどこにいても通常は同じものです（もちろん別のフォーマットやサイズで配信されることもありますが、通常は別のファイル名で配信されます）。

{{ figure_markup(
  image="luna-cat.jpg",
  caption="はい、猫の写真があります。",
  description="ルナという猫の写真です。"
  )
}}

静的コンテンツは、一般的にキャッシュ可能で、多くの場合、長期間にわたって利用されます。コンテンツ（1つ）とリクエスト（多数）の間には、1対多の関係があります。

#### ダイナミックコンテンツ

ダイナミックコンテンツの例としては、ある地域に特化したイベントのリストがあります。このリストは、リクエストした人の場所に応じて異なります。

動的に生成されたコンテンツは、より微妙で、慎重な検討が必要です。動的コンテンツの中にはキャッシュできるものもありますが、多くの場合、短い期間しかキャッシュできません。近日開催のイベントのリストの例では、おそらく日ごとに変化します。また、ユーザーのブラウザにキャッシュされるものは、サーバーやCDNにキャッシュされるもののサブセットである可能性もあります。とはいえ、一部のダイナミックコンテンツをキャッシュすることは可能です。「ダイナミック」を「キャッシュできない」の別の言葉だと考えるのは正しくありません。

### できる限り長くキャッシュする

リソースをキャッシュする時間の長さは、コンテンツの*揮発性*、つまり変更の可能性や頻度に大きく依存します。たとえば、画像やバージョン管理されたJavaScriptファイルは、非常に長い時間キャッシュされる可能性があります。APIレスポンスやバージョン管理されていないJavaScriptファイルは、ユーザーに最新のレスポンスを確実に提供するために、より短いキャッシュ期間が必要になるかもしれません。一部のコンテンツは1分以下しかキャッシュされないかもしれません。もちろん、まったくキャッシュされるべきではないコンテンツもあります。これについては、後述の[キャッシュの機会を特定する](#identifying-caching-opportunities)で詳しく説明しています。

もうひとつの留意点は、ブラウザにコンテンツのキャッシュをどれだけ長く指示しても、ブラウザはその時点以前にそのコンテンツをキャッシュから削除することがあるということです。たとえば、より頻繁にアクセスされる他のコンテンツのためのスペースを確保するためにそうすることがあります。しかし、ブラウザは指示された時間以上にキャッシュコンテンツを使用することはありません。

### できるだけエンドユーザーの近くにキャッシュする

エンドユーザーの近くにコンテンツをキャッシュすることで、遅延をなくしてダウンロード時間を短縮できます。たとえば、あるリソースがユーザーのブラウザにキャッシュされていればリクエストがネットワークに出ることはなく、ユーザーが必要とするときにはいつでもローカルで利用できます。ブラウザのキャッシュにエントリがない訪問者にとっては、CDNはキャッシュされたリソースが次に返される場所となります。ほとんどの場合、オリジンサーバーと比較して、ローカルキャッシュやCDNからリソースを取得する方が速くなります。

## いくつかの専門用語

*Caching entity*: キャッシングを行うハードウェアまたはソフトウェアのこと。本章では、とくに指定のない限り、「ブラウザ」を「キャッシング・エンティティ」の同義語として使用します。

*Time-To-Live (TTL)*: キャッシュオブジェクトのTTLは、そのオブジェクトがキャッシュに保存される期間を定義するもので、通常は秒単位で測定されます。キャッシュされたオブジェクトがTTLに達すると、そのオブジェクトはキャッシュによって「古い」とマークされます。キャッシュにどのように追加されたか（下記のキャッシュヘッダーの詳細を参照）に応じて、そのオブジェクトは直ちにキャッシュから削除されるか、あるいはキャッシュに残っていても「stale」オブジェクトとしてマークされ再利用の前に再検証が必要になることがあります。

*Eviction*: オブジェクトがTTLに達したとき、あるいはキャッシュが満杯になったとき、実際にキャッシュから削除される自動化されたプロセスのこと。

*Revalidation*: 古くなったと判定されたキャッシュオブジェクトは、ユーザーに表示する前、サーバーで「再検証」する必要があります。ブラウザはまず、ブラウザのキャッシュにあるオブジェクトが最新で有効であることをサーバに確認しなければなりません。

## ブラウザキャッシングの概要

ブラウザがコンテンツ（Webページなど）を要求すると、コンテンツそのもの（HTMLマークアップ）だけでなく、コンテンツを説明する多くの*HTTPレスポンスヘッダー*（キャッシュ可能性に関する情報を含む）を含むレスポンスを受け取ります。

キャッシング関連のヘッダーがあるかないかで、ブラウザに3つの重要な情報が伝わります。

1. **キャッシュ性**: このコンテンツはキャッシュ可能ですか？
2. **新鮮さ**: キャッシュ可能な場合、どのくらいの期間キャッシュできるのか？
3. **バリデーション**: もしキャッシュ可能であれば、その後どのようにしてキャッシュされたバージョンが新鮮であることを確認するのでしょうか？

鮮度を指定するために一般的に使用される2つのHTTPレスポンスヘッダーは、`Cache-Control`と`Expires`です。

* `Expires`は、明示的な有効期限の日時を指定します（つまり、コンテンツの有効期限がいつ切れるかを指定します）。
* `Cache-Control`では、キャッシュ期間（リクエストされた時からどのくらいの期間、ブラウザにコンテンツをキャッシュできるか）を指定します。

しばしば、これらのヘッダーの両方を指定することがありますが、その場合は`Cache-Control`が優先されます。

これらのキャッシングヘッダーの完全な仕様は、<a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-8">RFC 7234</a>にあり、<a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.2">4.2 (Freshness)</a>と<a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-4.3">4.3 (Validation)</a>のセクションで説明されていますが、以下ではより詳細に説明します。

## `Cache-Control`対`Expires`

初期のHTTP/1.0時代のウェブでは、`Expires`ヘッダーが唯一のキャッシュ関連のレスポンスヘッダーでした。上述したように、このヘッダーは、レスポンスが古くなったとみなされる正確な日時を示すために使用されます。その値は、次のような日時です。

```
Expires: Thu, 01 Dec 1994 16:00:00 GMT
```

`Expires`ヘッダーは、鈍器のようなものと考えてよいでしょう。相対的なキャッシュTTLが必要な場合は、現在の日付/時刻に基づいて適切な値を生成するために、サーバー上で処理を行う必要があります。

HTTP/1.1では、一般的に使用されているすべてのブラウザで長い間サポートされている`Cache-Control`ヘッダーが導入されました。`Cache-Control`ヘッダーは、*キャッシングディレクティブ*を介して、`Expires`よりもはるかに高い拡張性と柔軟性を備えており、複数のディレクティブを一緒に指定できます。さまざまなディレクティブの詳細は以下の通りです。

```
> GET /static/js/main.js HTTP/2
> Host: www.example.org
> Accept: */*
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:04:17 GMT
< Expires: Thu, 23 Jul 2020 03:14:17 GMT
< Cache-Control: public, max-age=600
```

上の簡単な例では、JavaScriptファイルのリクエストとレスポンスを示していますが、わかりやすくするためにいくつかのヘッダーを削除しています。`Date`ヘッダーは、現在の日付（具体的には、コンテンツが提供された日付）を示しています。`Expires`ヘッダーは、10分間キャッシュできることを示しています（`Expires`と`Date`ヘッダーの違い）。`Cache-Control`ヘッダーは、`max-age`ディレクティブを指定しており、これはリソースが600秒（5分）の間キャッシュできることを示している。`Cache-Control`は`Expires`よりも優先されるので、ブラウザはレスポンスを5分間キャッシュし、それ以降は陳腐化したものとしてマークされます。

RFC 7234では、レスポンスにキャッシュ用のヘッダーが存在しない場合、ブラウザはレスポンスを*ヒューリスティック*にキャッシュできます。これは、`Last-Modified`ヘッダー（渡された場合）からの時間の10％をキャッシュ期間として提案しています。このような場合ほとんどのブラウザはこの提案のバリエーションを実装していますが、中にはレスポンスを無期限にキャッシュするものや、まったくキャッシュしないものもあります。このようにブラウザによってばらつきがあるため、コンテンツのキャッシュ可能性を確実にコントロールするために、特定のキャッシュルールを明示的に設定することが重要です。

{{ figure_markup(
  image="cache-control-and-max-age-and-expires.png",
  caption="`Cache-Control`および`Expires`ヘッダーの使用法。",
  description="`Cache-Control` と `Expires` の使用状況を示す棒グラフです。デスクトップでは、73.6％のレスポンスが`Cache-Control`ヘッダーで提供されています。55.5％が`Expires`ヘッダーで配信され、54.8％が`Cache-Control`ヘッダーと`Expires`ヘッダーの両方を使用し、25.6％がどちらのヘッダーも含まれていませんでした。モバイルでは73.5％のレスポンスに`Cache-Control`ヘッダーが付与され、56.2％に`Expires`ヘッダーが付与され、55.4％に`Cache-Control`と`Expires`の両方が付与され、25.6％に`Cache-Control`と`Expires`の両方が付与されていないことがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=188448640&format=interactive",
  sheets_gid="865734542",
  sql_file="cache_control_and_max_age_and_expires.sql"
  )
}}

モバイルのレスポンスのうち73.5％は`Cache-Control`ヘッダーが付いており、56.2％は`Expires`ヘッダーが付いていますが、レスポンスに両方のヘッダーが含まれているため、これらのほぼすべて（55.4％）は使用されません。25.6％のレスポンスはどちらのヘッダーも含まれていないため、ヒューリスティックキャッシングの対象となります。

この統計は、昨年のデータと比較すると興味深いものです。

{{ figure_markup(
  image="cache-control-and-max-age-and-expires-2019.png",
  caption="2019年の`Cache-Control`と`Expires`ヘッダーの使用法。",
  description="`Cache-Control`と`Expires`の使用状況を示す棒グラフです。デスクトップでは、72.3％のレスポンスが`Cache-Control`ヘッダーで提供されています。56.3％が`Expires`ヘッダーを付けており、55.2％が`Cache-Control`と`Expires`の両方を使用しており、26.7％がどちらのヘッダーも付けていない。モバイルでは71.7％のレスポンスに`Cache-Control`ヘッダーが付与され、56.4％に`Expires`ヘッダーが付与され、55.5％に`Cache-Control`と`Expires`の両方が付与され、27.4％に`Cache-Control`と`Expires`の両方が付与されていないことがわかりました。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=651240480&format=interactive",
  sheets_gid="664360335",
  sql_file="cache_control_and_max_age_and_expires_2019.sql"
  )
}}

また、デスクトップでは、`Cache-Control`ヘッダーの使用がわずかに増加（1.8％）していますが、古い`Expires`ヘッダーの使用はわずかに減少（0.2％）しています。デスクトップでは、`Cache-Control`がわずかに増加し（1.3％）、`Expires`の増加は少ない（0.8％）ことがわかります。つまり、デスクトップのサイトでは、`Expires`ではなく`Cache-Control`ヘッダーを追加するケースが増えているようです。

また、`Cache-Control`ヘッダーで許可されているさまざまなディレクティブを掘り下げていくと、その柔軟性とパワーが、多くのケースでより適していることがわかるでしょう。

## `Cache-Control`ディレクティブ

`Cache-Control`ヘッダーを使用する際には、特定のキャッシュ機能を示す1つ以上の*ディレクティブ*ー定義済みの値を指定します。複数のディレクティブはカンマで区切られ、どのような順番でも指定できますが、中にはお互いに`ぶつかり合う`ものもあります（例：`public`と`private`）。いくつかのディレクティブは`max-age`のように値を取るものもあります。

以下は、もっとも一般的な`Cache-Control`ディレクティブの一覧です。

<figure>
  <table>
    <tr>
     <th>ディレクティブ</th>
     <th>説明</th>
    </tr>
    <tr>
     <td><code class="no-wrap">max-age</code></td>
     <td>現在の時刻を基準にして、リソースをキャッシュできる秒数を示します。 たとえば<code>max-age=86400</code>。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">public</code></td>
     <td>ブラウザや、サーバとブラウザの間にあるCDNなどのプロキシを含む、あらゆるキャッシュがレスポンスを保存する可能性があります。これはデフォルトで想定されています。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">no-cache</code></td>
     <td>キャッシュされたエントリは、たとえstaleとマークされていなくても、使用前に条件付きリクエストで再検証されなければなりません。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">must-revalidate</code></td>
     <td>古くなったキャッシュエントリは、使用前に条件付きリクエストで再検証する必要があります。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">no-store</code></td>
     <td>応答をキャッシュしてはいけないことを示す。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">private</code></td>
     <td>レスポンスは特定のユーザーを対象としており、プロキシやCDNなどの共有キャッシュには保存されないようになっています。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">proxy-revalidate</code></td>
     <td><code>must-revalidate</code>と同じですが、共有キャッシュに適用されます。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">s-maxage</code></td>
     <td><code>max-age</code>と同じですが、共有キャッシュ（例：CDN）にのみ適用されます。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">immutable</code></td>
     <td>TTLの間、キャッシュされたエントリが変更されることはなく、再検証は必要ないことを示す。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">stale-while-revalidate</code></td>
     <td>クライアントが、古い応答を受け入れる一方で、新しい応答をバックグラウンドで非同期的にチェックすることを示します。</td>
    </tr>
    <tr>
     <td><code class="no-wrap">stale-if-error</code></td>
     <td>新鮮な応答のチェックに失敗した場合に、クライアントが古い応答を受け入れることを示す。</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="<code>Cache-Control</code>ディレクティブ。", sheets_gid="1950040019", sql_file="cache_control_directives.sql") }}</figcaption>
</figure>

`max-age`ディレクティブは、`Expires`ヘッダーと同じように、TTLを直接定義するので、もっともよく見られるものです。

以下は、複数のディレクティブを持つ有効なCache-Controlヘッダーの例です。

```
Cache-Control: public, max-age=86400, must-revalidate
```

これはオブジェクトが86,400秒（1日）キャッシュできることを示しており、サーバとブラウザの間のすべてのキャッシュや、ブラウザ自体にも保存できることを意味しています。TTLに達しstaleとマークされたオブジェクトは、キャッシュに残りますが、再利用する前に条件付きで再検証する必要があります。

{{ figure_markup(
  image="cache-control-directives.png",
  caption="`Cache-Control`ディレクティブの配布。",
  description="11個の `Cache-Control` ディレクティブの分布を示す棒グラフです。デスクトップでの使用率は、`max-age`が60.2％、`public`が29.7％、`no-cache`が14.3％、`must-revalidate`が12.1％、`no-store`が9.2％、`private`が9.1％、`immutable`が3.5％、`no-transform`が2.3％、`stale-while-revalidate`が2.1％となっています。 `immutable`は3.5％、`no-transform`は2.3％、`stale-while-revalidate`は2.1％、`s-maxage`は1.5％、`proxy-revalidate`は1.0％、`stale-if-error`は0.2％となってます。モバイルでは、`max-age`が59.7％、`public`が29.7％、`no-cache`が15.1％、`must-revalidate`が12.5％、`no-store`が9.6％、`private`が9.7％、`immutable`が3.5％となってます。 `immutable`は3.5％、`no-transform`は2.2％、`stale-while-revalidate`は2.2％、`s-maxage`は1.2％、`proxy-revalidate`は1.1％、`stale-if-error`は0.2％です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=388795105&format=interactive",
  sheets_gid="1950040019",
  sql_file="cache_control_directives.sql"
  )
}}

上の図は、モバイルとデスクトップのウェブサイトで使用されている11個の`Cache-Control`ディレクティブを示しています。これらのキャッシュディレクティブの人気度について、いくつかの興味深い見解があります。
* モバイルの`Cache-Control`ヘッダーのうち、`max-age`は約59.66％、`no-store`は約9.64％使用されています（`no-store`ディレクティブの意味と使用方法については後述します）。
* `public`を明示的に指定する必要はありません。なぜなら、`private`が指定されていない限り、キャッシュエントリは`public`とみなされるからです。それにもかかわらず、ほぼ3分の1のレスポンスには`public`が含まれていて、すべてのレスポンスで数個のヘッダーバイトがムダになっています :)
* `immutable`ディレクティブは、2017年に導入された比較的新しいもので、FirefoxとSafariでしかサポートされていません。使用率はまだ3.47％程度ですが、Facebook、Google、Wix、Shopifyなどのレスポンスで広く見られます。特定のタイプのリクエストのキャッシュ性を大幅に向上させる可能性があります。

ロングテールに向かうと、ごく一部の無効なディレクティブが見つかります。これらはブラウザでは無視され、ヘッダーバイトをムダにするだけです。これらは大まかに2つのカテゴリーに分けられます。

* `nocache`や`s-max-age`などのスペルミスや、`=`の代わりに`:`を使用したり、`-`の代わりに`_`を使用したりするなど、無効なディレクティブの構文があります。
* `max-stale`, `proxy-public`, `surrogate-control`のような存在しないディレクティブ。

ムダなディレクティブのリストの中でもっとも興味深いのは、`no-cache="set-cookie"`の使用です。`Cache-Control`ヘッダーの全値のわずか0.2％であっても、他の無効なディレクティブの合計よりも多くを占めています。初期の`Cache-Control`ヘッダーに関する議論の中で、この構文は、`Set-Cookie`レスポンスヘッダー（ユーザー固有のものである可能性）が、CDNなどの中間プロキシによってオブジェクト自体と一緒にキャッシュされないようするための可能な方法として提起されました。しかし、この構文は最終的なRFCには含まれていませんでした。ほぼ同等の機能は`private`ディレクティブで実装できますし、`no-cache`ディレクティブでは値を指定することはできません。

## `Cache-Control`: `no-store`, `no-cache`と`max-age=0`

レスポンスを絶対にキャッシュしてはいけない場合には、`Cache-Control: no-store`ディレクティブを使用します。このディレクティブが指定されていない場合には、レスポンスは *キャッシュ可能であるとみなされ、キャッシュできます* 。`no-store`が指定されている場合は、他のディレクティブよりも優先されることに注意してください。これは、キャッシュされるべきではないリソースがキャッシュされた場合に深刻なプライバシーやセキュリティの問題が、発生する可能性があるためです。

レスポンスをキャッシュできないように設定しようとしたときに発生する、いくつかの一般的なエラーを見ることができます。

* `Cache-Control: no-cache`を指定すると、リソースをキャッシュしないように指示しているように聞こえるかもしれません。しかし、上述のとおり、`no-cache`ディレクティブはリソースのキャッシュを許可します。これは単に、使用前にリソースを再検証するようにブラウザに通知するだけで、リソースのキャッシュをまったく行わないこととは異なります。
* `Cache-Control: max-age=0`を設定するとTTLが0秒になりますが、これはキャッシュされないこととは違います。`max-age=0`が指定されると、リソースはキャッシュされますが、staleとマークされるため、ブラウザは即座にその新鮮さを再検証しなければなりません。

機能的には、`no-cache`と`max-age=0`は似ていて、どちらもキャッシュされたリソースの再検証を要求します。`no-cache`ディレクティブは、0よりも大きな値の`max-age`ディレクティブと一緒に使うこともできます。この場合、オブジェクトは指定されたTTLの間キャッシュされますが、毎回使用する前に再検証されます。

上記の3つのディレクティブを見ると、`no-store`、`no-cache`、`max-age=0`の3つのディレクティブを組み合わせたものが2.7％、`no-store`と`no-cache`の両方を組み合わせたものが6.7％、`no-store`のみを組み合わせたものは0.15％以下とごくわずかしかありません。

上述したように、`no-store`が`no-cache`と`max-age=0`のどちらかまたは両方と一緒に指定された場合、no-storeディレクティブが優先され、他のディレクティブは無視されます。したがってコンテンツをどこにもキャッシュしたくない場合は、単純に`Cache-Control: no-store`を指定するだけで十分であり、よりシンプルで最小限のヘッダーバイトしか使用しません。

`max-age=0`ディレクティブは、`no-store`が指定されていないレスポンスの2％未満にしか存在しません。このような場合、リソースはブラウザにキャッシュされますが、すぐにstaleと判定されるため、再検証が必要になります。

## 条件付きリクエストとリバリデーション

ブラウザが以前にオブジェクトをリクエストしすでにキャッシュに入っているが、そのキャッシュエントリがすでにTTLを超えている（したがってstaleとマークされている）場合や、オブジェクトが使用前に再検証されなければならないものとして定義されている場合などがよくあります。

このような場合、ブラウザはサーバに対して条件付きのリクエストを行うことができます。つまり、「*私のキャッシュにはobject Xがあるのですが、これを使ってもいいでしょうか。それとも、もっと新しいバージョンを使った方がいいでしょうか？*」。 サーバーは以下の2つの方法で応答します。

* 「*はい、キャッシュに保存されているバージョンのオブジェクトXは問題なく使用できます。*」となります。この場合、サーバーからのレスポンスは、`304 Not Modified`というステータスコードとレスポンスヘッダーで構成され、レスポンスボディはありません。
* "*いいえ、ここに最新のバージョンのオブジェクトXがありますので、これを使ってください。*" となります。この場合、サーバーからのレスポンスは、`200 OK`のステータスコード、レスポンスヘッダー、そして新しいレスポンスボディ（実際の新しいバージョンのオブジェクトX）で構成されます。

いずれの場合も、サーバはオプションでキャッシング応答ヘッダーを更新し、オブジェクトのTTLを延長できます。そうすれば、ブラウザは条件付きのリクエストを重ねることなく、さらに長期間オブジェクトを使用できます。

`304 Not Modified`のレスポンスはヘッダーのみで構成されているため、上記は*revalidation*と呼ばれ、正しく実装されていれば、知覚的なパフォーマンスを大幅に向上させることができます。それは、`200 OK`の応答よりもはるかに小さいため、帯域幅が削減され、迅速な応答が可能になります。

では、サーバーはどのようにして条件付きのリクエストと通常のリクエストを識別するのでしょうか？

実際には、オブジェクトへの最初のリクエストに起因するものです。ブラウザがキャッシュにないオブジェクトをリクエストするときは、次のようなGETリクエストを行うだけです。

```
> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*
```

ブラウザが条件付きリクエストを利用できるようにしたい場合（この判断は完全にサーバ側に委ねられています！）、サーバは、オブジェクトが後続の条件付きリクエストの対象であることを識別する2つのレスポンスヘッダーの一方または両方を含めることができます。2つのレスポンスヘッダーとは。

* `Last-Modified`: これは、オブジェクトが最後に変更された日時を示します。この値は日付のタイムスタンプです。
* `ETag`（エンティティタグ）です。これは、コンテンツのユニークな識別子を引用符付きの文字列で提供します。通常はファイルの内容をハッシュ化したものですが、タイムスタンプや単純な文字列にすることもできます。

両方のヘッダーが存在する場合は、`ETag`が優先されます。

### `Last-Modified`

ファイルのリクエストを受け取ったサーバーは、次のように、ファイルがもっとも最近変更された日時をレスポンスヘッダーとして含めることができます。

<pre><code>< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:04:17 GMT
< <span class="keyword">Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT</span>
< Cache-Control: max-age=600

...lots of html here...</code></pre>

ブラウザはこのオブジェクトを（`Cache-Control`ヘッダーで定義されているように）600秒間キャッシュし、それ以降はオブジェクトが古くなったものとしてマークします。ブラウザがこのファイルを再度使用する必要がある場合は、最初に行ったのと同様にサーバからファイルを要求しますが、今回は`If-Modified-Since`という追加のリクエストヘッダーを含め最初のレスポンスで`Last-Modified`レスポンスヘッダーに渡された値を設定します。

<pre><code>> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*
> <span class="keyword">If-Modified-Since: Mon, 20 Jul 2020 11:43:22 GMT</span></code></pre>

このリクエストを受け取ったサーバーは、`If-Modified-Since`ヘッダーの値と、もっとも最近にファイルを変更した日付を比較することで、オブジェクトが変更されたかどうかを確認できます。

2つの値が同じであれば、サーバはブラウザがファイルの最新バージョンを持っていることを知り、サーバはヘッダー（同じ`Last-Modified`ヘッダー値を含む）のみでレスポンスボディを持たない`304 Not Modified`レスポンスを返すことができます。

```
< HTTP/2 304
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT
< Cache-Control: max-age=600
```

しかし、ブラウザが最後にリクエストしてからサーバ上のファイルが変更された場合、サーバはヘッダー（更新された`Last-Modified`ヘッダーを含む）とボディ内のファイルの新バージョンからなる`200 OK`レスポンスを返します。

```
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< Last-Modified: Thu, 23 Jul 2020 03:12:42 GMT
< Cache-Control: max-age=600

...lots of html here...
```

ご覧の通り、`Last-Modified`レスポンスヘッダーと`If-Modified-Since`リクエストヘッダーはペアで動作しています。

### エンティティタグ（`ETag`）

この機能は、前述の日付ベースの`Last-Modified`/`If-Modified-Since`条件付きリクエスト処理とほぼ同じです。

しかし、この場合、サーバーは日付のタイムスタンプではなく、`ETag`レスポンスヘッダーを送信します。`ETag`は単なる文字列で、ファイルの内容をハッシュ化したものや、サーバが算出したバージョン番号などが多いです。この文字列のフォーマットはサーバが自由に決めることができます。唯一の重要な事実は、サーバはファイルを変更するたびに`ETag`の値を変更するということです。

この例では、サーバーがファイルの最初のリクエストを受信したときに、次のように`ETag`応答ヘッダーでファイルのバージョンを返すことができます。

```
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:04:17 GMT
< ETag: "v123.4.01"
< Cache-Control: max-age=600

...lots of html here...
```

上記の`If-Modified-Since`の例と同様に、ブラウザは`Cache-Control`ヘッダーで定義されているように、このオブジェクトを600秒間キャッシュします。このオブジェクトを再度サーバーにリクエストする必要がある場合は、`If-None-Match`と呼ばれる追加のリクエストヘッダーを含めます。このリクエストヘッダーには、最初のレスポンスの`ETag`レスポンスヘッダーで渡された値が含まれています。

```
> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*
> If-None-Match: "v123.4.01"
```

このリクエストを受け取ったサーバーは、`If-None-Match`ヘッダー値と、そのファイルの現在のバージョンを比較することで、オブジェクトが変更されたかどうかを確認できます。

2つの値が同じであれば、ブラウザはファイルの最新バージョンを持っていることになり、サーバーはヘッダーだけで`304 Not Modified`レスポンスを返すことができます。

```
< HTTP/2 304
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< ETag: "v123.4.01"
< Cache-Control: max-age=600
```

しかし値が異なる場合はサーバー上のファイルのバージョンが、ブラウザが持っているバージョンよりも新しいということになるので、サーバーはヘッダー（更新された`ETag`ヘッダーを含む）とファイルの新しいバージョンからなる`200 OK`レスポンスを返します。

```
< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< ETag: "v123.5.06"
< Cache-Control: public, max-age=600

...lots of html here...
```

ここでも、この条件付きリクエスト処理には、`ETag`レスポンスヘッダーと`If-None-Match`リクエストヘッダーという2つのヘッダーが使われています。

`Cache-Control`ヘッダーが`Expires`ヘッダーよりも強力で柔軟性があるのと同じように、`ETag`ヘッダーは多くの点で`Last-Modified`ヘッダーよりも改良されています。これには2つの理由があります。

1. サーバーは、`ETag`ヘッダーに独自のフォーマットを定義できます。上の例では、バージョンの文字列を示していますが、ハッシュやランダムな文字列にすることもできます。これを許可すると、オブジェクトのバージョンは日付に明示的にリンクされません。そのため、サーバーはファイルの新しいバージョンを作成しても、以前のバージョンと同じETagを与えることができます。

2. `ETag`は'strong'または'weak'のいずれかとして定義でき、これによりブラウザは異なる方法で検証できます。この機能を完全に理解し、議論することはこの章の範囲を超えていますが、 <a hreflang="en" href="https://tools.ietf.org/html/rfc7232">RFC 7232</a>に記載されています。

しかし、`ETag`はサーバの最終更新時刻をベースにしていることが多いので、多くの実装で事実上同じになってしまう可能性があります。さらに悪いことに、サーバの実装（とくにApache）にはさまざまなバグがあり、<a hreflang="en" href="https://www.tunetheweb.com/performance/http-performance-headers/etag/#downsides">`ETag`を使うことがあまり効果的ではないこともあります</a>。

{{ figure_markup(
  image="last-modified-and-etag.png",
  caption="`Last-Modified`と`ETag`ヘッダーによる新鮮さの検証の採用。",
  description="棒グラフで見ると、デスクトップでは`Last-Modified`が73.5％、`ETag`が47.9％、両方が42.8％、どちらでもないが21.4％となっています。モバイルの場合もほぼ同じで、`Last-Modified`が72.0％、`ETag`が46.2％、両方が41.0％、どちらでもないが22.9％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1171778982&format=interactive",
  sheets_gid="1084825476",
  sql_file="last_modified_and_etag.sql"
  )
}}

{{ figure_markup(
  image="last-modified-and-etag-2019.png",
  caption="2019年には、`Last-Modified`と`ETag`ヘッダーによる新鮮さの検証を採用。",
  description="棒グラフで見ると、デスクトップでは`Last-Modified`が72.7％、`ETag`が48.0％、両方が43.1％、どちらでもないが22.4％となっています。モバイルの場合もほぼ同じで、`Last-Modified`が72.0％、`ETag`が47.1％、両方が42.1％、どちらでもないが23.1％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1775409512&format=interactive",
  sheets_gid="1084825476",
  sql_file="last_modified_and_etag_2019.sql"
  )
}}

モバイルのレスポンスの72.0％が`Last-Modified`ヘッダー付きで提供されていることがわかります。2019年との比較では、モバイルでの使用率は横ばいですが、デスクトップではわずかに増加しています（1％未満）。

`ETag`ヘッダーを見ると、携帯電話の回答の46.2％がこれを使用しています。これらの回答のうち、34.38％が*string*、9.81％が*weak*、残りの1.98％が無効となっています。`Last-Modified`とは対照的に、`ETag`ヘッダーの使用率は、2019年と比較してわずかに減少しています（1％未満の減少）。

41.0％のモバイルレスポンスは、両方のヘッダーを含んでおり、上述の通りこの場合は`ETag`ヘッダーが優先されます。22.9％のモバイルレスポンスは、`Last-Modified`と`ETag`のどちらのヘッダーも含まれていません。

条件付きリクエストを使用して再検証を正しく実装すれば帯域幅（304応答は一般的に200応答よりもはるかに小さい）、サーバーの負荷（変更日やハッシュを比較するために必要な処理はわずか）、および知覚的なパフォーマンスの向上（サーバーは304でより迅速に応答する）を大幅に削減できます。しかし上記の統計からもわかるように、全リクエストの5分の1以上は、どのような形式の条件付きリクエストも使用していません。

クロールでは空のキャッシュを使用しており、304レスポンスはほとんどが[Methodology](./methodology)ではテストしていない後続の訪問に役立つものなので、これは予想外のことではありません。それでも、304がどのように使用されているかを確認するためにこれらを分析しました。

{{ figure_markup(
  image="valid-if-none-match-returns-304.png",
  caption="`304 Not Modified`ステータスの分布",
  description="`304 Not Modified`の分布を示す棒グラフ。デスクトップのレスポンスのうち20.5％は、`ETag`ヘッダーがなく、対応するリクエストの`If-Modified-Since`ヘッダーで渡された`Last-Modified`の値と同じものを含んでいました。そのうち86％は`304 Not Modified`というステータスでした。レスポンスの86.1％は、対応するリクエストの`If-None-Match`ヘッダーで渡される同じ`ETag`値を含んでいた。このうち88.9％は`304 Not Modified`となっています。17.2％のモバイルレスポンスは、`ETag`ヘッダーを持たず、対応するリクエストの`If-Modified-Since`ヘッダーに渡された同じ`Last-Modified`値を含んでいました。そのうち78.3％は`304 Not Modified`というステータスを持っていた。89.9％のレスポンスには、対応するリクエストの`If-None-Match`ヘッダーに渡された同じ`ETag`の値が含まれていた。そのうち90.2％は`304 Not Modified`となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1530788258&format=interactive",
  sheets_gid="1705717345",
  sql_file="valid_if_none_match_returns_304.sql"
  )
}}

モバイルのレスポンスのうち17.2％（デスクトップ20.5％）は、`ETag`ヘッダーを持たず、対応するリクエストの`If-Modified-Since`ヘッダーで渡されたのと同じ`Last-Modified`値を含んでいることがわかりました。そのうち78.3％（デスクトップでは86％）が`304 Not Modified`というステータスでした。

モバイルのレスポンスの89.9％（デスクトップ86.1％）が、対応するリクエストの`If-None-Match`ヘッダーで渡された同じ`ETag`の値を含んでいました。また、`If-Modified-Since`ヘッダーが存在する場合は、`ETag`が優先されます。これらのうち、90.2％（デスクトップでは88.9％）が`304 Not Modified`というステータスでした。

## 日付文字列の妥当性

このドキュメントでは、タイムスタンプを伝えるためのキャッシュ関連のHTTPヘッダーについて説明してきました。

* `Date`レスポンスヘッダーは、リソースがクライアントに提供された日時を示します。
* `Last-Modified`レスポンスヘッダーは、リソースがサーバー上で最後に変更された日時を示します。
* `Expires`ヘッダーは、リソースがどのくらいの期間キャッシュ可能かを示すために使用されます。

これら3つのHTTPヘッダーは、いずれもタイムスタンプを表すために日付形式の文字列を使用しています。日付形式の文字列は、<a hreflang="en" href="https://tools.ietf.org/html/rfc2616#section-3.3.1">RFC 2616</a>で定義されており、GMTタイムスタンプの文字列を指定する必要があります。
たとえば、以下のようになります。

```
> GET /index.html HTTP/2
> Host: www.example.org
> Accept: */*

< HTTP/2 200
< Date: Thu, 23 Jul 2020 03:14:17 GMT
< Cache-Control: max-age=600
< Last-Modified: Mon, 20 Jul 2020 11:43:22 GMT
```

無効な日付文字列はほとんどのブラウザで無視されるため、その文字列が提供されたレスポンスのキャッシュ可能性に影響を与えます。たとえば無効な`Last-Modified`ヘッダーは、その無効なタイムスタンプなしにキャッシュされているため、ブラウザはその後、そのオブジェクトに対して条件付きのリクエストを実行できません。

{{ figure_markup(
  image="invalid-last-modified-and-expires-and-date.png",
  caption="レスポンスヘッダーの日付フォーマットが無効です。",
  description="無効な日付の分布を示す棒グラフ。デスクトップでは0.1％、`Last-Modified`で0.5％、`Expires`で2.5％の割合で無効な`Date`が検出されています。モバイルでもほぼ同様で、`Date`に0.1％、`Last-Modified`に0.7％、`Expires`に2.9％の割合で不正な日付が含まれています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=827586570&format=interactive",
  sheets_gid="1338572274",
  sql_file="invalid_last_modified_and_expires_and_date.sql"
  )
}}

HTTPレスポンスヘッダーの`Date`は、ほとんどの場合、ウェブサーバによって自動的に生成されるため、無効な値は非常にまれです。同様に、`Last-Modified`ヘッダーでも、無効な値の割合は非常に低く（モバイルで0.75％、デスクトップで0.5％）なっています。しかし、非常に意外だったのは、`Expires`ヘッダーの2.94％が無効な日付フォーマットを使用していたことです（デスクトップでは2.5％）。

`Expires`ヘッダーの無効な使い方の例としては、以下のようなものがあります。

* 有効な日付フォーマットですが、GMT以外のタイムゾーンを使用しています。
* 0や-1などの数値
* `Cache-Control`ヘッダーで有効な値

無効な`Expires`ヘッダーの大きな原因のひとつは、人気のあるサードパーティから提供されたアセットで、日付/時間がESTタイムゾーンを使用しています。`Tue, 27 Apr 1971 19:44:06 EST`。 ブラウザによっては、堅牢性の観点からこの日付形式を理解して受け入れるものもありますが、そうであると仮定してはいけません。

## `Vary`ヘッダー

これまでキャッシュエンティティは、レスポンスオブジェクトがキャッシュ可能か、またどのくらいの期間キャッシュできるかを判断する方法について説明してきました。しかしキャッシュエンティティーが行わなければならない、もっとも重要なステップの1つは、リクエストされたリソースがすでにキャッシュにあるかどうかを判断することです。これは簡単に見えるかもしれませんが、多くの場合URLだけでは判断できません。たとえば同じURLのリクエストでも、使用した圧縮方法（gzip、Brotliなど）が異なっていたり、異なるエンコーディング（XML、JSONなど）で返されたりすることがあります。

この問題を解決するために、キャッシング・エンティティがオブジェクトをキャッシュする際には、そのオブジェクトに一意の識別子（キャッシュ・キー）を与えます。オブジェクトがキャッシュにあるかどうかを判断する必要があるときは、キャッシュキーをルックアップとして使用してオブジェクトの存在を確認します。デフォルトでは、このキャッシュキーはオブジェクトの取得に使用された単純なURLですが、サーバは`Vary`レスポンスヘッダーを含めることによってキャッシュキーにレスポンスの他の属性（圧縮方法など）を含めるようにキャッシュエンティティに指示できます。`Vary`ヘッダーは、URL以外の要素に基づいて、オブジェクトのバリエーションを識別します。

`Vary`レスポンスヘッダーは、1つまたは複数のリクエストヘッダーの値をキャッシュキーに追加するようにブラウザに指示します。この`Vary: Accept-Encoding`のもっとも一般的な例、ブラウザは、異なる`Accept-Encoding`リクエストヘッダー値（例: `gzip`, `br`, `deflate`）に基づいて、同じオブジェクトを異なるフォーマットでブラウザがキャッシュすることになります。

キャッシング用のエンティティは、HTMLファイルのリクエストを送信し、gzip形式のレスポンスを受け入れることを示します。

```
> GET /index.html HTTP/2
> Host: www.example.org
> Accept-Encoding: gzip
```

サーバーはオブジェクトで応答し、送信するバージョンが`Accept-Encoding`リクエストヘッダーの値を含むべきであることを示します。

```
< HTTP/2 200 OK
< Content-Type: text/html
< Vary: Accept-Encoding
```

この単純化された例では、キャッシング エンティティは、URLと`Vary`ヘッダーの組み合わせを使用してオブジェクトをキャッシュします。

もうひとつの一般的な値は`Vary: Accept-Encoding, User-Agent`で、これはクライアントに対して、`Accept-Encoding`と`User-Agent`の両方の値をキャッシュキーに含めるように指示します。しかし共有プロキシやCDNについて議論する場合、`Accept-Encoding`以外の値を使用すると、キャッシュが希釈または断片化されキャッシュから提供されるトラフィックの量が、減少する可能性があるため問題となることがあります。たとえば、`User-Agent`には数千の異なる種類があるため、CDNがあるオブジェクトの多くの異なるバリエーションをキャッシュしようとすると、ほとんど同一の（あるいは実際に同一の）キャッシュされたオブジェクトでキャッシュがいっぱいになってしまう可能性があります。これは非常に非効率的であり、CDN内でのキャッシングが最適でなくなり、キャッシュヒット数の減少とレイテンシーの増大を招くことになります。

一般的に、キャッシュを変更するのは、そのヘッダーに基づいてクライアントに別のコンテンツを提供する場合だけにすべきです。

HTTPレスポンスの43.4％がVaryヘッダーを使用しており、そのうち84.2％が`Cache-Control`ヘッダーを含んでいます。

下のグラフは、Varyヘッダーの上位10個の値の人気度を示しています。`User-Agent`が10.7％、`Origin`（CORSの処理に使用）が8％、`Accept`が4.1％となっており、`Vary`の使用量の約92％を占めています。

{{ figure_markup(
  image="vary-headers.png",
  caption="`Vary`ヘッダーの使用方法。",
  description="`Vary`ヘッダーの分布を示す棒グラフ。デスクトップでは91.8％が`Accept-Encoding`を使用しており、その他は`User-Agent`が10.7％、`Origin`が約8.0％、`Accept`、`Access-Control-Request-Headers`、 `Access-Control-Request-Method`、`Cookie`、`X-Forwarded-Proto`、`Accept-Language`、`Range`が0.5％～4.1％となっており、かなり小さい値となっています。モバイル応答の91.3％が`Accept-Encoding`を使用しており、その他の値は非常に小さく、`User-Agent`が11.0％、`Origin`が約9.1％、`Accept`、`Access-Control-Request-Headers`、`Access-Control-Request-Method`、`Cookie`、`X-Forwarded-Proto`、`Accept-Language`、`Range`が0.6％～3.9％となっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=317375276&format=interactive",
  sheets_gid="1115686547",
  sql_file="vary_headers.sql"
  )
}}

## キャッシュ可能なレスポンスにCookieを設定する

レスポンスがキャッシュされると、そのレスポンス ヘッダーの全セットがキャッシュされたオブジェクトに含まれます。ChromeでキャッシュされたレスポンスをDevToolsで検査すると、レスポンス・ヘッダーが表示されるのはこのためです。

{{ figure_markup(
  image="chrome-dev-tools.png",
  caption="キャッシュされたリソースのためのChrome Dev Toolsです。",
  description="Chrome Dev Toolsによると、レスポンスがキャッシュされると、レスポンスヘッダーの全セットがキャッシュされたオブジェクトに含まれます。"
  )
}}

しかし、レスポンスに`Set-Cookie`がある場合はどうなるでしょうか？<a hreflang="en" href="https://tools.ietf.org/html/rfc7234#section-8">RFC 7234 Section 8</a>によると、`Set-Cookie`レスポンスヘッダーの存在はキャッシュを阻害しないそうです。つまり、キャッシュされたエントリーに`Set-Cookie`レスポンスヘッダーが含まれている可能性があるということです。このRFCでは、レスポンスのキャッシュ方法を制御するために、適切な `Cache-Control`ヘッダーを設定することを推奨しています。

私のリクエストに応じてサーバーから私に送信された`Set-Cookie`レスポンスヘッダーには、私のCookieが含まれていることが明らかなので、私のブラウザがそれらをキャッシュしても問題はありません。しかし、私とサーバーの間にCDNがある場合、サーバーはCDNに対して、レスポンスをCDN自体にキャッシュすべきでないことを示さなければなりません。そうすれば、私向けのレスポンスがキャッシュされないで、他のユーザーに（私の`Set-Cookie`ヘッダーを含めて）提供されることになります。

たとえば、ログインCookieやセッションCookieがCDNのキャッシュされたオブジェクトに存在する場合、そのCookieは他のクライアントによって再利用される可能性があります。これを避けるための主な方法は、サーバーが`Cache-Control: private`ディレクティブを送信することです。

{{ figure_markup(
  image="set-cookie-usage-on-cacheable-responses.png",
  caption="キャッシュ可能なレスポンスの`Set-Cookie`。",
  description="キャッシュ可能なレスポンスにおける`Set-Cookie`の使用状況を示す棒グラフ。キャッシュ可能なデスクトップ向けレスポンスの41.4％、モバイル向けレスポンスの40.4％が`Set-Cookie`ヘッダーを含んでいます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1106475158&format=interactive",
  sheets_gid="1263250537",
  sql_file="set_cookie.sql"
  )
}}

キャッシュ可能なモバイルレスポンスのうち、40.4％が`Set-Cookie`ヘッダーを含んでいます。これらのレスポンスのうち、`private`ディレクティブを使用しているのは4.9％。残りの95.1％（1億9,860万のHTTPレスポンス）は、少なくとも1つの`Set-Cookie`レスポンスヘッダーを含んでおり、CDNなどのパブリックキャッシュサーバでキャッシュできます。これは、キャッシュ機能とCookieがどのように共存しているのか、理解されていないことを示しているのかもしれません。

{{ figure_markup(
  image="set-cookie-usage-on-private-and-non-private-cacheable-responses.png",
  caption="`private`および非プライベートのキャッシュ可能なレスポンスにおける`Set-Cookie`。",
  description="キャッシュ可能な`private`と非プライベートのレスポンスにおける`Set-Cookie`の使用率を示す棒グラフです。`Set-Cookie`ヘッダーを含むデスクトップレスポンスのうち、4.6％が`private`ディレクティブを使用しています。95.4％のレスポンスが、プライベートとパブリックの両方のキャッシュサーバでキャッシュ可能です。`Set-Cookie`ヘッダーを含むモバイルのレスポンスのうち、4.9％が`private`ディレクティブを利用しています。95.1％のレスポンスが、プライベートとパブリックの両方のキャッシュサーバでキャッシュされます。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=97044455&format=interactive",
  sheets_gid="1263250537",
  sql_file="set_cookie.sql"
  )
}}

## サービス・ワーカー

サービスワーカーとはHTML5の機能の1つで、フロントエンドの開発者がWebページの通常のリクエスト／レスポンスの流れの外で実行されるべきスクリプトを指定し、メッセージを介してWebページと通信することを可能にします。サービスワーカーの一般的な用途としては、バックグラウンドでの同期やプッシュ通知、そして当然ながらキャッシュが挙げられます。

{{ figure_markup(
  image="service-workers-controlled-pages-2019-2020.png",
  caption="サービスワーカーの成長は、2019年からのページを制御しています。",
  description="サービスワーカーの管理ページの増加を示す棒グラフ。2019年の0.6％から2020年には1.0％まで採用率が伸びてます",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=893877591&format=interactive",
  sheets_gid="2082343974",
  sql_file="appcache_and_serviceworkers_2019.sql"
  )
}}

採用率はウェブサイトの1％にとどまっていますが、2019年7月以降、着実に増加しています。[Progressive Web App](./pwa)の章では、上のグラフで1回しかカウントされていない人気サイトでの利用により、このグラフが示す以上に多く利用されていることなど詳しく説明しています。

<figure>
  <table>
    <tr>
     <th>サービスワーカーを使わないサイト</th>
     <th>サービスワーカーを使っているサイト</th>
     <th>総サイト数</th>
    </tr>
    <tr>
     <td class="numeric">6,225,774</td>
     <td class="numeric">64,373</td>
     <td class="numeric">6,290,147</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="サービス・ワーカーを利用しているウェブサイトの数", sheets_gid="2106765718", sql_file="appcache_and_serviceworkers.sql") }}</figcaption>
</figure>

上の表では、全6,290,147サイトのうち、64,373サイトがサービスワーカーを導入していることがわかります。

<figure>
  <table>
    <tr>
     <th>HTTPサイト</th>
     <th>HTTPSサイト</th>
     <th>合計サイト</th>
    </tr>
    <tr>
     <td class="numeric">1,469</td>
     <td class="numeric">62,904</td>
     <td class="numeric">64,373</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="HTTP/HTTPSでサービスワーカーを利用しているウェブサイトの数。", sheets_gid="2106765718", sql_file="appcache_and_serviceworkers.sql") }}</figcaption>
</figure>

これをHTTPとHTTPSで分けてみると、さらに興味深いことがわかります。HTTPSはサービスワーカーを使用するための必須条件であるにもかかわらず、以下の表によると、サービスワーカーを使用しているサイトのうち1,469件がHTTPで提供されています。

## どのようなコンテンツをキャッシングするのか？

これまで見てきたように、キャッシュ可能なリソースは一定期間ブラウザに保存され、その後のリクエストで再利用できるようになります。

{{ figure_markup(
  image="cacheable-and-non-cacheable.png",
  caption="キャッシュ可能なレスポンスとキャッシュ不可能なレスポンスの分布。",
  description="キャッシュ可能な回答の割合を示す棒グラフ。デスクトップでは9.2％、モバイルでは9.6％の回答がキャッシュされています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=430652203&format=interactive",
  sheets_gid="391853872",
  sql_file="ttl.sql"
  )
}}

 すべてのHTTP(S)リクエストにおいて、90.4％のレスポンスがキャッシュ可能であると考えられています（つまり、キャッシュの保存が許可されています）。残りの9.6％のレスポンスは、ブラウザのキャッシュに保存できません。

{{ figure_markup(
  image="ttl-cachable-responses.png",
  caption="キャッシュ可能なレスポンスにおけるTTLの分布。",
  description="キャッシュ可能なレスポンスにおけるTTLの分布を示す棒グラフ。デスクトップのレスポンスの4.2％がTTLゼロ、59.4％がゼロより大きいTTL、28.2％がヒューリスティックTTLを使用しています。モバイルのレスポンスの4.2％がTTLゼロ、58.8％がTTLゼロより大きい、28.4％がヒューリスティックTTLを使用しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1365998611&format=interactive",
  sheets_gid="391853872",
  sql_file="ttl.sql"
  )
}}

もう少し掘り下げてみると4.1％のリクエストのTTLが0秒で、この場合オブジェクトはキャッシュに追加されますが、すぐに古いものとしてマークされ再検証が必要になります。28.4％は`Cache-Control`や`Expires`などのヘッダーがないためヒューリスティックにキャッシュされ、58.8％は0秒以上キャッシュされています。

以下の表は、モバイルリクエストのキャッシュTTL値をタイプ別にまとめたものです。

<figure>
  <table>
    <thead>
      <tr>
        <th colspan="6" scope="col">キャッシュのTTLパーセンタイル（単位：時間）</th>
      </tr>
      <tr>
        <th scope="col">タイプ</th>
        <th scope="col">10</th>
        <th scope="col">25</th>
        <th scope="col">50</th>
        <th scope="col">75</th>
        <th scope="col">90</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Audio</td>
        <td class="numeric">6</td>
        <td class="numeric">6</td>
        <td class="numeric">240</td>
        <td class="numeric">744</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <td>CSS</td>
        <td class="numeric">24</td>
        <td class="numeric">24</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <td>Font</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <td>HTML</td>
        <td class="numeric">0</td>
        <td class="numeric">3</td>
        <td class="numeric">336</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,600</td>
      </tr>
      <tr>
        <td>Image</td>
        <td class="numeric">6</td>
        <td class="numeric">168</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,766</td>
      </tr>
      <tr>
        <td>その他</td>
        <td class="numeric">0</td>
        <td class="numeric">3</td>
        <td class="numeric">31</td>
        <td class="numeric">336</td>
        <td class="numeric">23,557</td>
      </tr>
      <tr>
        <td>Script</td>
        <td class="numeric">0</td>
        <td class="numeric">4</td>
        <td class="numeric">720</td>
        <td class="numeric">8,760</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <td>Text</td>
        <td class="numeric">0</td>
        <td class="numeric">1</td>
        <td class="numeric">6</td>
        <td class="numeric">24</td>
        <td class="numeric">8,760</td>
      </tr>
      <tr>
        <td>Video</td>
        <td class="numeric">6</td>
        <td class="numeric">336</td>
        <td class="numeric">336</td>
        <td class="numeric">336</td>
        <td class="numeric">8,674</td>
      </tr>
      <tr>
        <td>XML</td>
        <td class="numeric">1</td>
        <td class="numeric">24</td>
        <td class="numeric">24</td>
        <td class="numeric">24</td>
        <td class="numeric">720</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="リソースタイプ別のモバイルキャッシュTTLパーセンタイル。", sheets_gid="676954337", sql_file="ttl_by_resource.sql") }}</figcaption>
</figure>

ほとんどのTTLの中央値は高いのですが、低いパーセンタイルでは、キャッシュの機会を逃しているものがいくつかあります。たとえば画像のTTLの中央値は720時間（1か月）ですが、25<sup>th</sup> パーセンタイルはわずか168時間（1週間）で、10<sup>th</sup> パーセンタイルはわずか数時間にまで落ち込んでいます。これをフォントと比較すると、フォントのTTLは8,760時間（1年）と非常に高く25<sup>th</sup>パーセンタイルまであり、10<sup>th</sup>パーセンタイルでも1か月のTTLを示しています。

コンテンツタイプ別のキャッシュ可能性を下の図で詳しく見てみると、フォント、ビデオやオーディオ、CSSファイルは100％近くブラウザキャッシュされている一方で（これらのファイルは一般的に静的であるため、これは理にかなっている）、全HTMLレスポンスの約3分の1はキャッシュ不可能であると考えられます。

{{ figure_markup(
  image="cacheable-by-resource-type.png",
  caption="コンテンツタイプ別のキャッシュ可能性の分布",
  description="キャッシュ可能なリソースの種類を棒グラフで表したもの。デスクトップでは、audioの99.3％、CSSの99.3％、fontの99.8％、HTMLの67.9％、imagesの91.2％、その他のタイプの66.3％、scriptsの95.2％、textの78.6％、videoの99.6％、xmlの81.4％がキャッシュ可能でした。モバイルでは、audioの99.0％、CSSの99.0％、fontの99.8％、HTMLの71.5％、imagesの89.9％、その他のタイプの67.9％、scriptsの95.1％、textの78.4％、videoの99.7％、xmlの80.6％がキャッシュ可能です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=1283939423&format=interactive",
  sheets_gid="220584548",
  sql_file="non_cacheable_by_resource_type.sql"
  )
}}

また、デスクトップでは、imagesの10.1％、scriptsの4.9％がキャッシュされません。これらのオブジェクトの中には静的なものもあり、より高い割合でキャッシュできる可能性があるため、ここには改善の余地があると思われます。覚えておいてください： *できる限り多くのものを、できる限り長くキャッシュしましょう！*。

## キャッシュのTTLはリソースの年齢と比べてどうなのか？

これまでに、サーバーがクライアントにキャッシュ可能なコンテンツをどのように伝え、どのくらいの期間キャッシュされているかについて説明してきました。キャッシュルールを設計する際には、提供しているコンテンツがどれくらい古いかを理解することも重要です。

クライアントへ返信するレスポンスヘッダーに指定するキャッシュTTLを選択する際には、自問してみてください。「どのくらいの頻度でこれらの資産を更新しているか」と「コンテンツの感度はどうか」。たとえば、ヒーロー画像が頻繁に変更されない場合は、非常に長いTTLでキャッシュできます。対照的にJavaScriptファイルが頻繁に変更されるのであれば、ユニークなクエリ文字列でバージョン管理し長いTTLをキャッシュするか、あるいはもっと短いTTLでキャッシュすべきでしょう。

以下のグラフは、コンテンツタイプ別のリソースの相対的な古さを示しています。

{{ figure_markup(
  image="resource-age-party-and-type-wise-groups-1st-party.png",
  caption="コンテンツタイプ別のリソースエイジ（ファーストパーティ）。",
  description="コンテンツの年齢を示すスタックバーチャートで、0～52週目、1年以上、2年以上に分けられ、nullやマイナスの数値も表示されます。統計は、ファーストパーティとサードパーティに分かれています。値0は、とくにファーストパーティのHTML、text、xml、およびすべてのアセットタイプのサードパーティリクエストの最大50％に使用されています。中間の年の使用も混在しており、1年目と2年目にはかなりの使用があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=2056330432&format=interactive",
  sheets_gid="1889235328",
  sql_file="resource_age_party_and_type_wise_groups.sql"
  )
}}

{{ figure_markup(
  image="resource-age-party-and-type-wise-groups-3rd-party.png",
  caption="コンテンツタイプ別のリソースエイジ（サードパーティ）。",
  description="コンテンツの年齢を示すスタックバーチャートで、0～52週目、1年以上、2年以上に分けられ、nullやマイナスの数値も表示されます。統計は、ファーストパーティとサードパーティに分かれています。値0は、とくにファーストパーティのHTML、text、xml、およびすべてのアセットタイプのサードパーティリクエストの最大50％に使用されています。中間の年の使用も混在しており、1年目と2年目にはかなりの使用があります。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=859132635&format=interactive",
  sheets_gid="1889235328",
  sql_file="resource_age_party_and_type_wise_groups.sql"
  )
}}

このデータの中で興味深い観察結果があります。

* ファーストパーティのHTMLは、リソース年数がもっとも短いコンテンツタイプで、41.1％のリクエストが1週間未満となっています。その他のほとんどのコンテンツタイプでは、サードパーティコンテンツの方がファーストパーティコンテンツよりもリソースエイジが小さい。
* ウェブ上のファーストパーティコンテンツのうち、8週間以上経過しているものには、images（78.9％）、scripts（68.7％）、CSS（74.9％）、Webフォント（80.4％）、autio（78.2％）、video（79.3％）など、伝統的にキャッシュ可能なオブジェクトがあります。
* ファーストパーティとサードパーティのリソースでは、1週間以上経過しているものがあり、大きな差があります。ファーストパーティ製CSSの93.4％が1週間以上経過しているのに対し、サードパーティ製CSSでは48.0％が1週間以上経過している。

リソースのキャッシュ可能性とその年齢を比較することで、TTLが適切か低すぎるかを判断できます。

たとえば、2020年10月18日に配信されたリソースの最終更新日は2020年8月30日であり、配信時には1か月以上経過していることになります。これは頻繁に変更されないオブジェクトであることを示しています。しかし、`Cache-Control`ヘッダーによると、ブラウザは86,400秒（1日）しかキャッシュできないことになっています。これは、ブラウザが条件付きでも再リクエストする必要がないように、TTLを長くすることが適切なケースです。とくに、ユーザーが数日間に何度も訪れるようなウェブサイトの場合はそうです。

```
> HTTP/1.1 200
> Date: Sun, 18 Oct 2020 19:36:57 GMT
> Content-Type: text/html; charset=utf-8
> Content-Length: 3052
> Vary: Accept-Encoding
> Last-Modified: Sun, 30 Aug 2020 16:00:30 GMT
> Cache-Control: public, max-age=86400
```

ウェブ上で提供されているモバイルリソースのうち60.2％が、コンテンツの年齢に比べて短すぎると思われるキャッシュTTLを持っていました。さらに、TTLと年齢の差の中央値は25日で、これもキャッシュ不足が顕著であることを示しています。

<figure>
  <table>
    <tr>
     <th>クライアント</th>
     <th>ファーストパーティ</th>
     <th>サードパーティ</th>
     <th>全体</th>
    </tr>
    <tr>
     <td>デスクトップ</td>
     <td class="numeric">61.6%</td>
     <td class="numeric">59.3%</td>
     <td class="numeric">60.7%</td>
    </tr>
    <tr>
     <td>モバイル</td>
     <td class="numeric">61.8%</td>
     <td class="numeric">57.9%</td>
     <td class="numeric">60.2%</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="TTLが短いリクエストの割合。", sheets_gid="1706274506", sql_file="content_age_older_than_ttl_by_party.sql") }}</figcaption>
</figure>

上の表でファーストパーティとサードパーティに分けてみると、ファーストパーティのリソースの約3分の2（61.8％）がTTLを長くすることでメリットを得られることがわかります。このことから、キャッシュ可能なものにとくに注意を払い、キャッシュを正しく設定していることを確認する必要があります。

## キャッシングの機会を特定する

Googleの<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse">Lighthouse</a>ツールでは、ウェブページに対する一連の監査を実行でき、<a hreflang="en" href="https://developers.google.com/web/tools/lighthouse/audits/cache-policy">cache policy audit</a>では、サイトに追加のキャッシュが必要かどうかを評価します。これは、コンテンツの年齢（`Last-Modified`ヘッダーによる）をキャッシュのTTLと比較し、リソースがキャッシュから提供される確率を推定することによって行われます。スコアに応じて、キャッシュを推奨する結果が表示され、キャッシュ可能な特定のリソースのリストが表示されます。

{{ figure_markup(
  image="lighthouse-caching-audit.png",
  caption="キャッシュ・ポリシーの改善の可能性を示すライトハウス・レポート。",
  description="キャッシュポリシーの改善の可能性を強調したLighthouseレポートの抜粋。ファーストパーティとサードパーティのURL、そのキャッシュTTL、およびサイズが示されている。"
  )
}}

Lighthouseでは、各監査に対して0％から100％の範囲でスコアを計算し、それらのスコアを総合的なスコアに反映させています。キャッシングのスコアは、潜在的なバイト削減量に基づいています。Lighthouseの結果を見ると、どれだけのサイトがキャッシュポリシーをうまく活用しているかがわかります。

{{ figure_markup(
  image="cache-ttl-lighthouse-score.png",
  caption="LighthouseキャッシングのTTLスコアの分布。",
  description="モバイルWebページの`uses-long-cache-ttl`に関するLighthouse監査スコアの分布を示す棒グラフ。0.10未満が37.5％、0.10～0.39が28.8％、0.40～0.79が17.7％、0.80～0.99が12.1％となっています。1が3.3％、スコア無しが0.6％でした。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=637059966&format=interactive",
  sheets_gid="1554485361",
  sql_file="cache_ttl_lighthouse_score.sql"
  )
}}

100％のスコアを獲得したサイトはわずか3.3%であり、大多数のサイトがキャッシュの最適化によって恩恵を受けることができると考えられます。約3分の2のサイトが40%を下回り、約3分の1のサイトが10%を下回りました。このことから、かなりの量のキャッシュが不足しており、ネットワーク上で過剰なリクエストやバイトが処理されていることがわかります。

また、Lighthouseはより長いキャッシュポリシーを有効にすることで、繰り返し表示する際に何バイト節約できるかを示しています。

{{ figure_markup(
  image="cache-wasted-bytes-lighthouse.png",
  caption="Lighthouseキャッシング監査による潜在的なバイト削減量の分布。",
  description="モバイルWebページのLighthouseキャッシング監査で得られたバイト削減可能量の分布を示す棒グラフ。回答のうち57.2％が1MB未満、21.58％が1～2MB、7.8％が2～3MB、4.3％が3～4MBのサイズを削減しています。9.2%は4MB以上の節約に成功しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQvridledKYJT8mHVVa5-x_TllkwbPsOaDg66iMWafxJq-KSLLfSHUaA6VoMyLnp9FFJ48vePGpiWQ5/pubchart?oid=534991851&format=interactive",
  sheets_gid="2140407198",
  sql_file="cache_wastedbytes_lighthouse.sql"
  )
}}

キャッシュを追加することで恩恵を受けることができるサイトのうち、5分の1以上のサイトが2MB以上もページの重量を減らすことができます。

## 結論

キャッシングは、ブラウザやプロキシ、CDNなどの仲介者がウェブコンテンツを保存し、エンドユーザーに提供できる非常に強力な機能です。往復の時間を短縮し、コストのかかるネットワークリクエストを最小限に抑えることができるため、パフォーマンス面でのメリットが大きいのです。

キャッシングは非常に複雑なテーマであり、開発サイクルの後半まで放置され、最後の最後で追加されることもよくあります（サイト開発者が設計中に最新バージョンのサイトを見たいという要求）。またキャッシュルールは一度定義されると、サイトの基本的なコンテンツが変更されても、変更されないことが多い。慎重に検討することなく、デフォルト値が選ばれることもよくあります。

オブジェクトを正しくキャッシュするために、キャッシュされたエントリを検証するだけでなく、新鮮さを伝えることができる多くのHTTPレスポンスヘッダーがあり、`Cache-Control`ディレクティブは非常に大きな柔軟性とコントロールを提供します。

一般的にキャッシュできないと考えられているオブジェクトタイプやコンテンツの多くは、実際にキャッシュできます（覚えておいてください：*できるだけ多くのキャッシュをしましょう！*）。また、多くのオブジェクトはキャッシュされる期間が短すぎるため、繰り返しリクエストや再検証が必要になります（覚えておいてください：*できるだけ多くのキャッシュをしましょう！*）。しかしウェブサイトの開発者は、コンテンツを過剰にキャッシュすることで、ミスの機会が増えることに注意しなければなりません。

サイトがCDNで提供されることを意図している場合、サーバーの負荷を軽減しエンドユーザーに迅速な応答を提供するために、CDNでのキャッシングの機会を増やすことを、Cookieなどの個人情報を誤ってキャッシングしてしまうことの関連するリスクとともに考慮する必要があります。

しかし強力で複雑であることは、必ずしも難しいことではありません。他のほとんどのものと同様にキャッシュはルールによって制御されており、キャッシュ可能性とプライバシーのベストミックスを提供するために、かなり簡単に定義できます。サイトを定期的に監査し、キャッシュ可能なリソースが適切にキャッシュされていることを確認することをオススメします。
