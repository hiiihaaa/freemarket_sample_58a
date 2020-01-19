# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_furigana|string|null: false|
|first_furigana|string|null: false|
|birth_year|integer|null: false|
|customer_id|integer|null: false, foreign_key: true|

### Association
- has_many :products
- has_one :credit_card
- has_many :likes
- has_many :comments
- has_many :message_after_buyings
- has_one :phone_number_authorizations
- has_one :delivery_address
- has_many :user_identifications


## User_idenficationsテーブル

|Column|Type|Options|
|------|----|-------|
|post_number|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user, dependent: :destroy


## delivery_addressテーブル

|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_furigana|string|null: false|
|first_furigana|string|null: false|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string|null: false|
|phone_number|integer|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user, dependent: :destroy


## credit_cardsテーブル

|Column|Type|Options|
|------|----|-------|
|token_id|integer|null: false|
|credit_cardscol|string|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user, dependent: :destroy


## banks_accountsテーブル

|Column|Type|Options|
|------|----|-------|
|bank_name|string|null: false|
|account_type|string|null: false|
|branch_code|integer|null: false|
|account_number|integer|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user, dependent: :destroy


## phone_number_authorizationsテーブル

|Column|Type|Options|
|------|----|-------|
|telephone|string|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user, dependent: :destroy


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|size|string|null: false|
|status|integer|null: false|
|shipping_fee|integer|null: false|
|shipping_method|string|null: false|
|shipping_form|string|null: false|
|shipping_data|string|null: false|
|price|integer|null: false|
|brand|string|null: false|
|current_status|string|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :category, dependent: :destroy
- has_many :likes
- has_many :comments
- belongs_to :user, dependent: :destroy
- belongs_to :purchase


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|user_id|integer|null: false|
|products_id|integer|null: false|

### Association
- belongs_to :product, dependent: :destroy


## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|products_id|integer|null: false|

### Association
- belongs_to :user, dependent: :destroy
- belongs_to :product, dependent: :destroy


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|

### Association
- has_many :products, dependent: :destroy
- has_ancestry


## purchasesテーブル

|Column|Type|Options|
|------|----|-------|
|evaluation|integer|null: false|
|user_id|integer|null: false|
|products_id|integer|null: false|

### Association
- has_many :message_after_buyings
- belongs_to :user, dependent: :destroy
- belongs_to :product, dependent: :destroy


## message_after_buyingsテーブル

|Column|Type|Options|
|------|----|-------|
|type|string|null: false|
|text|string|null: false|
|user_id|integer|null: false|
|purchase_id|integer|null: false|

### Association
- belongs_to :user, dependent: :destroy