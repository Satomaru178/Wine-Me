# DBテーブル設計

![](url)

<!--
  ユーザ登録時に入力する基本情報。
-->

## usersテーブル
| Column               | Type   | Option                                            |
|----------------------|--------|---------------------------------------------------|
|nickname              |string  |null: false, unique: true                          |
|email                 |string  |null: false, unique: true, default: "", index: true|
|encrypted_password    |string  |null: false,               default: ""             |

### Association
- has_many :brands, dependent: :destroy
- has_many :comments
- has_many :likes, dependent: :destroy
- has_many :liked_products, through: likes, source: :brand

<!--
  銘柄を投稿する時に登録する情報。

  originカラム
  産地を選択する

  explainカラム
  銘柄の説明（1000文字以内）

  typeカラム
  銘柄の種類
  ・スティルワイン
    ・赤
    ・白
    ・ロゼ
  ・スパークリングワイン
  ・フォーティファイドワイン
  ・フレーバードワイン

  varietyカラム
  銘柄の品種を選択する
  ユーザーが入力・登録することもできる

  sceneカラム
  銘柄におすすめのシーンを選択

  yearカラム
  収穫年を入力
  不明の場合は未入力も可能

  tasteカラム
  銘柄の味を選択

  likes_countカラム
  いいねの数を管理

  valueカラム
  おおよその価値、市販の金額、購入時の金額等を入力
-->

## brandsテーブル
| Column          | Type     | Option                                                                            |
|-----------------|----------|-----------------------------------------------------------------------------------|
|name             |string    |null: false, index: true, length: { maximum: 40 }                                  |
|origin           |string    |                                                                                   |
|explain          |text      |                          length: { maximum: 1_000 }                               |
|year             |string    |                                                                                   |
|value            |string    |                                                                                   |
|scene            |integer   |                                                                                   |
|taste            |integer   |                                                                                   |
|likes_count      |integer   |                                                                                   |
|type             |references|             foreign_key: true                                                     |
|variety          |references|             foreign_key: true                                                     |
|user             |references|null: false, foreign_key: true                                                     |
|created_at       |datetime  |null: false                                                                        |
|updated_at       |datetime  |null: false                                                                        |

### Association
- accepts_nested_attributes_for :images, allow_destroy: true
- has_many :images,   dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :likes,    dependent: :destroy
- belongs_to :user

<!--
  商品の画像。１枚必須。
-->

## imagesテーブル
| Column   | Type     | Option                       |
|----------|----------|------------------------------|
|brand     |references|null: false, foreign_key: true|
|src       |string    |                              |
|created_at|datetime  |null: false                   |
|updated_at|datetime  |null: false                   |

### Association
- belongs_to :brand, optional: true
- mount_uploader :src, ImageUploader

<!--
  種類はancestryを使って
  大分類、詳細といった階層構造にする。
-->

## typesテーブル
| Column   | Type   | Option                                         |
|----------|--------|------------------------------------------------|
|name      |string  |null: false, index: true, length: { maxmum: 40 }|
|ancestry  |string  |             index: true                        |
|created_at|datetime|null: false                                     |
|updated_at|datetime|null: false                                     |

### Association
- has_many :brands
- has_ancestry

<!--
  品種名は任意でユーザに入力させる。
  存在しない品種でも入力・登録はできる。
-->

## varietyテーブル
| Column   | Type   | Option                                                        |
|----------|--------|---------------------------------------------------------------|
|name      |string  |null: false, index: true, unique: true, length: { maximum: 40 }|
|created_at|datetime|null: false                                                    |
|updated_at|datetime|null: false                                                    |

### Association
- has_many :brands

<!--
  銘柄詳細ページでユーザがコメントを残すことができる。
  全てのユーザーが自由にコメントできる。
-->

## commentsテーブル
| Column     | Type     | Option                       |
|------------|----------|------------------------------|
|user        |references|null: false, foreign_key: true|
|brand       |references|null: false, foreign_key: true|
|comment     |text      |null: false                   |
|created_at  |datetime  |null: false                   |
|updated_at  |datetime  |null: false                   |


### Association
- belongs_to :user
- belongs_to :brand

<!--
  商品詳細ページでユーザがいいね！することができる。
  likeカラム
  いいね！フラグ
  false : いいね！していない状態
  true  : いいね！している状態
-->

## likesテーブル
| Column   | Type     | Option          |
|----------|----------|-----------------|
|user      |references|foreign_key: true|
|brand     |references|foreign_key: true|
|created_at|datetime  |null: false      |
|updated_at|datetime  |null: false      |

### Association
- belongs_to :user
- belongs_to :brand, counter_cache: :likes_count
