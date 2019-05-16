# language:ja

機能: 問い合わせ
  利用者として
  サイト運営に問い合わせをしたい
  なぜなら利用者の声を聞きたいからだ

  シナリオアウトライン: お問い合わせフォーム送信
    前提 問い合わせテーブルが存在する
    前提 "/contact"にアクセスしている
    もし お問い合わせ内容"<name>","<email>","<questionnaire>","<category>","<message>"を入力して
    かつ 送信ボタンを押した
    ならば "お問い合わせを送信しました"が表示される
    例:
      |name     | email | questionnaire | category   | message |
      |お名前    | mail@test.com | 口コミ | ご予約について | メッセージ   |

