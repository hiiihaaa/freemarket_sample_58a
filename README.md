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
|nickname|varchar(45)|null: false|
|email|varchar(45)|null: false|
|password|varchar(45)|null: false|
|family_name|varchar(45)|null: false|
|first_name|varchar(45)|null: false|
|family_furigana|varchar(45)|null: false|
|first_furigana|varchar(45)|null: false|
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
|prefecture|varchar(45)|null: false|
|city|varchar(45)|null: false|
|block|varchar(45)|null: false|
|building|varchar(45)|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## delivery_addressテーブル

|Column|Type|Options|
|------|----|-------|
|family_name|varchar(45)|null: false|
|first_name|varchar(45)|null: false|
|family_furigana|varchar(45)|null: false|
|first_furigana|varchar(45)|null: false|
|postal_code|integer|null: false|
|prefecture|varchar(45)|null: false|
|city|varchar(45)|null: false|
|block|varchar(45)|null: false|
|building|varchar(45)|null: false|
|phone_number|integer|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## credit_cardsテーブル

|Column|Type|Options|
|------|----|-------|
|token_id|integer|null: false|
|credit_cardscol|varchar(45)|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## banks_accountsテーブル

|Column|Type|Options|
|------|----|-------|
|bank_name|varchar(45)|null: false|
|account_type|varchar(45)|null: false|
|branch_code|integer|null: false|
|account_number|integer|null: false|
|family_name|varchar(45)|null: false|
|first_name|varchar(45)|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## phone_number_authorizationsテーブル

|Column|Type|Options|
|------|----|-------|
|telephone|varchar(45)|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|name|varchar(45)|null: false|
|size|varchar(45)|null: false|
|status|integer|null: false|
|shipping_fee|integer|null: false|
|shipping_method|varchar(45)|null: false|
|shipping_form|varchar(45)|null: false|
|shipping_data|varchar(45)|null: false|
|price|integer|null: false|
|brand|varchar(45)|null: false|
|current_status|varchar(45)|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- has_many :categories
- has_many :likes
- has_many :comments
- belongs_to :user
- belongs_to :purchase


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|text|varchar(45)|null: false|
|user_id|integer|null: false|
|products_id|integer|null: false|

### Association
- belongs_to :product


## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|products_id|integer|null: false|

### Association
- belongs_to :user
- belongs_to :product


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|varchar(45)|null: false|
|big_id|integer|null: false|
|middle_id|integer|null: false|
|products_id|integer|null: false|

### Association
- belongs_to :product


## purchasesテーブル

|Column|Type|Options|
|------|----|-------|
|evaluation|integer|null: false|
|user_id|integer|null: false|
|products_id|integer|null: false|

### Association
- has_many :message_after_buyings
- belongs_to :user
- belongs_to :product


## message_after_buyingsテーブル

|Column|Type|Options|
|------|----|-------|
|type|varchar(45)|null: false|
|text|varchar(45)|null: false|
|user_id|integer|null: false|
|purchase_id|integer|null: false|

### Association
- belongs_to :user