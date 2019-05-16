# language:ja

# order: 01
機能: サイトページ
  利用者として
  サイトページを閲覧したい
  なぜならサービスの内容を知りたいからだ

  シナリオ: トップページ
    もし "/"にアクセスした
    ならば "Mr.M COFFEEについて"が表示される

  シナリオアウトライン: トップページのナビゲーションバー
    前提 "/"にアクセスしている
    もし ナビゲーションの"<menu>"をクリックしたならば
    ならば "<content>"が表示される
    例:
      |menu | content   |
      |Top  | Mr.M COFFEE |
      |About| Mr.M COFFEEについて |
      |Menu | Menu |
      |Coupon  | Coupon |
      |Shop    | Shop   |
      |Access  | Access |

  シナリオアウトライン: トップページのフッターメニュー
    前提 "/"にアクセスしている
    もし フッターの"<menu>"をクリックしたならば
    ならば "<content>"が表示される
    例:
      |menu | content   |
      |Top  | Mr.M COFFEE |
      |News | News |
      |About| Mr.M COFFEEについて |
      |Menu | Menu |
      |Coupon  | Coupon |
      |Contact | お問い合わせフォーム |

  シナリオ: コンタクトページ
    もし "/contact"にアクセスした
    ならば "お問い合わせフォーム"が表示される

  シナリオアウトライン: コンタクトページのナビゲーションバー
    前提 "/contact"にアクセスしている
    もし ナビゲーションの"<menu>"をクリックしたならば
    ならば "<content>"が表示される
    例:
      |menu | content   |
      |Top  | Mr.M COFFEE |
      |About| Mr.M COFFEEについて |
      |Menu | Menu |
      |Coupon  | Coupon |
      |Shop    | Shop   |
      |Access  | Access |

  シナリオアウトライン: コンタクトページのトップページのフッターメニュー
    前提 "/contact"にアクセスしている
    もし フッターの"<menu>"をクリックしたならば
    ならば "<content>"が表示される
    例:
      |menu | content   |
      |Top  | Mr.M COFFEE |
      |News | News |
      |About| Mr.M COFFEEについて |
      |Menu | Menu |
      |Coupon  | Coupon |
      |Contact | お問い合わせフォーム |

