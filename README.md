# Mail or SMS System (Ruby on Rails)

このアプリケーションは、お問い合わせフォームを通じて顧客情報を受け取り、**SMS または メールで通知を自動送信** する Ruby on Rails アプリケーションです。

---

## 機能概要

**SMS または メールの自動通知**  
- 顧客が問い合わせを送信すると、**電話番号がある場合は SMS を送信**  
- **電話番号がない場合、メールを送信**

**問い合わせフォーム**  
- `http://localhost:3000/customers/new` にアクセスすると問い合わせフォームを表示

**送信完了ページ**  
- 送信後は `http://localhost:3000/thank_you` へリダイレクト

**送信履歴の確認**  
- `rails c` でデータベースの内容を確認

```bash
rails c
Customer.all
```

**メール送信ログを確認**  
- メールは `letter_opener` を使用して確認できます。

```bash
rails s
# 送信後に http://localhost:3000/letter_opener で確認
```

---

## 必要な環境

- **Ruby** 3.2.0
- **Rails** 7.2.2.1
- **Bundler**
- **データベース**: SQLite / PostgreSQL
- **Puma** (Rails の標準サーバー)
- **Letter Opener Web**（開発環境でのメール確認用）

---

## セットアップ手順

### 1.リポジトリをクローン

```bash
git clone https://github.com/kakinotane77/notification_system.git
cd notification_system
```

### 2.依存ライブラリをインストール

```bash
bundle install
```

### 3️.データベースをセットアップ

```bash
rails db:create db:migrate
```

### 4️.サーバーを起動

```bash
rails s
```
**ブラウザで `http://localhost:3000/` にアクセス**

---

## 🌍 開発環境

| 環境       | バージョン                     |
|-----------|--------------------------------|
| **OS**    | macOS Sequoia 15.2       |
| **エディタ** | VS Code             |
| **DB**    | MySQL            |

### 環境変数
`.env` に API キーやメール設定を追加できます。
**今回はテスト用のため、環境変数は設定していません。**

```ini
SMS_API_KEY=your_sms_api_key
EMAIL_HOST=smtp.example.com
```

---

## 実行方法

1. **ローカルサーバーを起動**

    ```bash
    rails s
    ```

2. **メール送信確認**

    ```bash
    rails console
    NotificationMailer.notify_email("test@example.com").deliver_now
    ```

3. **デバッグ**

    ```bash
    tail -f log/development.log
    ```

---

## テスト

**RSpec を使用したテスト**

```bash
bundle exec rspec
```

フォームの動作テスト：

```bash
rails c
Customer.create(name: "テスト", email: "test@example.com")
```

---

## ライセンス

このプロジェクトは **スキルカレッジ副業道場用課題** のもとで公開されています。

---

## 貢献方法

1. **Issue を作成** (バグ報告 / 機能提案)  
2. **Pull Request を送信** (新機能や修正)  
3. **README の改善** (ドキュメント更新)  