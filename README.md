# アルディアスの魔法書 〜対話型日記アプリ〜
魔法の本に閉じ込められた魔法使い=アルディアスが日記に返事を書いてくる日記アプリです。
![スクリーンショット 2024-10-01 23 57 06](https://github.com/user-attachments/assets/2e9866c0-f2f2-4a34-8f45-dfd0d08151a0)

# サービスURL
https://www.crimoire-of-aldias.com

# サービスへの想い
私は昔からファンタジーの世界観がとても好きでした。
ハリーポッターや魔法使いの弟子（ディズニー）などの雰囲気が好きで、何度も映画を見たり、ユニバのハリーポッターコーナーやハリーポッタースタジオに足を運びました。
また、私は昔から日記を続けるのが苦手な人間でした。
そんな私でも苦にならず日記を続けられた時期がありました。
それは、学校の先生が日記に対して面白く返事をくれた、小学校の時の連絡帳に書く日記です。
ファンタジーな世界観で、日記を続けられるサービスを作成したいと思い、このアプリを作成しました。

#　想定されるユーザー層
・ハリーポッターのような魔法の世界観やファンタジーの世界観に少しでも浸かりたいと思っている人
・誰かに自分の日記を見られることで日記が続けられる人（特に生身の人だと気が張って思うように日記が進まない人）

# アプリケーションのイメージ

# 画面一覧
トップ | 会員登録
-|-
![スクリーンショット 2024-10-02 3 23 33](https://github.com/user-attachments/assets/44bf3f16-bcd6-45ff-8167-76a0d7b979cf)| ![スクリーンショット 2024-10-02 3 18 49](https://github.com/user-attachments/assets/df222f55-bcf0-43d5-adbe-a56a66c7b783)
古い本や英字新聞などを参考に、ファンタジーぽさを意識したデザインを心がけました。 | メールでの会員登録機能を搭載しています。<br>メール以外にもラインでの登録・ログインも用意しています。

ログイン | 日記投稿画面
-|-
![スクリーンショット 2024-10-02 3 39 17](https://github.com/user-attachments/assets/caed918d-7c93-4e5b-b0bc-2c074c4edd04)| ![スクリーンショット 2024-10-02 3 33 18](https://github.com/user-attachments/assets/0a619566-699e-4db3-9972-59fe48b48a9c)
メール、パスワードでのログイン機能を搭載しています。 | ノートの線を再現し、日記投稿フォームを作成しました。<br>内容と写真を投稿できます。

返信待ち画面 | アルディアス返信画面
-|-
![スクリーンショット 2024-10-03 2 43 35](https://github.com/user-attachments/assets/08c3c241-be8e-4b34-ba26-26d1b209f2d4) | https://github.com/user-attachments/assets/2ef30f77-e362-4c1a-9f5a-bcc6b6aa4d04
OpenAIからの返信に数秒時間がかかるためウェイティングページを設けました。 | 一文字ずつ言葉を紡いでいるように、アニメーションにこだわり、特別なアルディアスの返答画面を搭載しました。<br> OpenAIの使用は使用量が使用した分だけ上がるため、1日に一度のみの制限を設けています。

日記編集画面 | 日記詳細画面
-|-
![スクリーンショット 2024-10-03 3 02 11](https://github.com/user-attachments/assets/b2acdb32-0304-4d14-a973-20b48a353d43) | ![スクリーンショット 2024-10-03 2 57 22](https://github.com/user-attachments/assets/42636268-1f29-441f-9eef-67e8ed096b50)
日記詳細画面から非同期処理にて画像と日記内容を編集できるようにしました。 | 日記詳細をわかりやすく確認できるように、上から画像、日記内容、OpenAIからの返信に分けて表示しました。

日記一覧 |  マイページ 
-|-
![スクリーンショット 2024-10-04 3 37 56](https://github.com/user-attachments/assets/1d990bf7-7e8a-440f-a30d-35f5d3d79820)　| ![スクリーンショット 2024-10-03 3 31 47](https://github.com/user-attachments/assets/41ae4f99-51f8-455d-9ea4-aadb6bc9daff) 
日記一覧機能を実装しました。なるべく本型の日記のようなデザインとするためカレンダーでの日指定だけでなく、次週/先週で日にち変更もできるようにしました。| ユーザー情報の確認、パスワード変更、ユーザー削除機能を設けました。<br> 日記に特定の文字を打つと絵が絵がどんどんと浮かび上がるような遊び心を加えました。

ラインログイン| ライン投稿
-|-
![スクリーンショット 2024-10-03 21 56 26](https://github.com/user-attachments/assets/b76f63dd-8124-43c1-8850-448d4795ec04) | ![スクリーンショット 2024-10-03 16 34 55](https://github.com/user-attachments/assets/c3bb80cf-9095-4813-a222-15a62d0e57ac)
メールでのログインのほかに、ラインでのログイン機能を追加しました。 | ライン投稿をラインから行えるように機能を搭載しました。



## 使用技術
カテゴリー |  使用技術
-|-
フロントエンド |  - JavaScript (jsbundling-rails)<br>- Turbo<br>- Stimulus<br>- CSS (cssbundling-rails)<br>- SassC 
バッグエンド | - Ruby on Rails<br>- Puma<br>- Sidekiq<br>- Sorcery<br>- CanCanCan<br>- CarrierWave<br>- Ruby-OpenAI<br>- Rails Admin<br>- Omniauth 
インフラ | - Docker<br>- Docker Compose- アプリケーションのコンテナ化<br>
データベース | - PostgreSQL 
API | - LINE Bot API<br> -OpenAI API
開発環境 | - RSpec<br>- FactoryBot<br>- Faker<br>- Rubocop<br>- Letter Opener Web

# 画面遷移図
Figma：https://www.figma.com/board/j9KFApJ3dpK6KDG4g97GZu/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?t=9zf8xuNLM7aa6Yxm-1

# ER図
![スクリーンショット 2024-10-04 3 01 45](https://github.com/user-attachments/assets/2609da60-a9fb-44a1-8950-e08a3cfe07dc)
https://lucid.app/lucidchart/83db1dd4-d92e-45da-9c4b-adc072bc3b39/edit?invitationId=inv_a26fc328-db4e-4185-bb5b-3479bf0385ad&page=0_0

# 機能一覧
-ユーザー管理機能（Sorcery,LINEAPI)<br>
-日記投稿機能<br>
-画像投稿機能<br>
-ChatGPTによる日記への返信機能<br>
-キーワード取得度によりマイページの画像解放機能<br>
-ChatGPT返信待ちウェイティング機能<br>
-ChatGPT返信アニメーション（一文字ずつ表示）機能<br>





