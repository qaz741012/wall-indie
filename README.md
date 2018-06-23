# The wall indie 音樂展演資訊平台

> 5秒內快速找到喜愛的展演資訊

## The wall indie 提供了以下功能

### 首頁

- 使用Facebook、Spotify帳號與一般註冊的方式加入平台會員。
- 使用Facebook、Spotify與一般會員帳號登入平台。
- 會員可點擊大頭貼(預設為可愛動物 or Spotify大頭貼)進入會員專頁。
- 瀏覽平台所推薦的展演資訊。
- 瀏覽全台灣各地近期的展演活動。
- 透過點擊 "看更多" 瀏覽全台灣各地所有的展演活動
- 透過搜尋 展演名稱、表演者名稱、地點、時間、票價 找到想看的展演活動。
- 可追蹤展演活動。
- 透過Google map找到 台北、台中、台南、高雄 的展演場地。
- 點擊 展演圖片 進入展演資訊專頁。

### 展演資訊專頁

- 瀏覽詳細的展演資訊。
- 追蹤展演活動。
- 點擊 表演者名稱 進入表演者專頁。

### 表演者專頁

- 聆聽表演者在Youtube的影片。
- 聆聽表演者在Spotify的音樂。
- 瀏覽表演者近期的展演資訊。
- 追蹤表演者。

### 會員專頁

- 瀏覽已追蹤的展演活動。
- 瀏覽已追蹤的Artist (若透過Spotify登入，平台會自動幫您追蹤Spotify所追蹤的Artist)。
- 透過Edit Profile更新 大頭貼、名稱 與 Email帳號。
- 可在最後一週黃金決策期，收到追蹤活動的Email通知。
- 可收到追縱Artist近期的表演通知Email。

### 管理者後台

- 管理者可瀏覽所有展演資訊、展演場地、表演者、會員。
- 管理者可新增展演資訊、展演場地、表演者。
- 管理者可編輯展演資訊、展演場地、表演者。
- 管理者可刪除展演資訊。

## 目錄

* [A. Started](#A)
* [B. Setting](#B)
    - [B.1 devise.rb](#B.1)
    - [B.2 facebook.yml](#B.2)
    - [B.3 spotify.yml](#B.3)

* [C. Get Event & Artist data](#C)
    - [C.1 執行crawl.rake取得展演資料](#C.1)
    - [C.2. 執行dev.rake產生測試資料](#C.2)
* [D. Website](#4)

<h2 id="A">A. Started</h2>
首先將Rails專案透過git clone下載到本地端(local)

```
  $ git clone
```

並執行`bundle install`安裝它。

```
  $ bundle install
```

接下來執行 migration來建立資料表

```
  $ rails db:migrate
```

<h2 id="B">B. Setting</h2>
<h3 id="B.1">B.1 devise.rb</h3>

為了讓使用者能用 Facebook 與 Spotify 登入，當開發環境為本地端時，請在rails專案資料夾 `config/` 新增 `facebook.yml` 及 `spotify.yml` 兩個檔案，
並開啟 `config/initializers/devise.rb` 檔案，啟用下方程式碼，才能在本地端透過 `facebook.yml` 載入串接Facebook API所需要的app_id及secret。

```
  fb_config = Rails.application.config_for(:facebook)
  config.omniauth :facebook,
  fb_config["app_id"],
  fb_config["secret"]
```

一樣在`config/initializers/devise.rb`檔案，啟用下方程式碼，才能在本地端透過`spotify.yml`載入串接Spotify API所需要的client_id、client_secret。

```
  spotify_config = Rails.application.config_for(:spotify)
  config.omniauth :spotify,
  spotify_config["client_id"],
  spotify_config["client_secret"],
  scope: 'user-read-private playlist-read-private user-read-email user-follow-modify user-library-modify'
```

<h3 id="B.2">B.2 facebook.yml</h3>

申請Facebook API金鑰來設定 `facebook.yml` 檔案的內容，請至[facebook for developers](https://developers.facebook.com/apps) 申請並取得app_id、seceret及API token，取得後請在 `facebook.yml` 檔案內輸入以下內容：

```
development:
  app_id: 輸入取得的app_id
  secret: 輸入取得的secret
  api_token: 輸入取得的API token
```

<h3 id="B.3">B.3 spotify.yml</h3>

申請Spotify API金鑰來設定 `spotify.yml` 檔案的內容，請至[Spotify Developer](https://developer.spotify.com/my-applications/) 申請並取得client_id及client_secret，取得後請在 `spotify.yml` 檔案內輸入以下內容：

```
development:
  client_id: 輸入取得的client_id
  client_secret: 輸入取得的client_secret
```



<h2 id="C">C. Get Event 與 Artist 資料</h2>
<h3 id="C.1">C.1 執行crawl.rake取得展演資料</h3>

自動取得 the_wall、revolver、witchhouse、indievox、songkick 的展演與表演者資訊

```
  $ rails crawl:all
```

<h3 id="C.2">C.2. 執行dev.rake產生測試資料</h3>
產生測試資料(使用者、追蹤表演者、追蹤展演資訊)

```
  $ rails dev:fake_all
```



<h2 id="D">D. Website</h2>

[The wall indie 音樂展演資訊平台](https://wall-indie-mth.herokuapp.com/artists/171)
