# テーブル設計

## usersテーブル
| Column         | Type    | Options                       |
| -------------- | ------- | ----------------------------- |
| nickname       | string  | null:  false                  |
| email          | string  | null:  false ,   unique: true |
| encrypted_password       | string  | null:  false                  |
| lastname       | string  | null:  false                  |
| firstname      | string  | null:  false                  |
| lastname_kana  | string  | null:  false                  |
| firstname_kana | string  | null:  false                  |
| bitrth_date    | date | null:  false                  |



### Association
- has_many :products
- has_many :buys



## productsテーブル
| Column         | Type       | Options                       |
| -------------- | ------- | ----------------------------- |
| name   | string       | null:  false                  |
| text   | text       | null:  false                  |
| price          | integer    | null:  false                  |
| user    | references | null:false, foreign_key: true |
| category_id       | integer    | null:  false                  |
| condition_id      | integer     | null:  false                  |
| fee_id   | integer     | null:  false                  |
| area_id | integer     | null:  false                  |
| ship_id       | integer     | null:  false                  |


### Association
- belongs_to :user
- has_one :buy



## buysテーブル 
| Column         | Type       | Options               |
| -------------- | ------- | ----------------------------- |
|user          |references | null:false, foreign_key: true |
|product    |  references | null:false, foreign_key: true |


## Association
- belongs_to :user
- has_one :address
- belongs_to :product




### addresses
| Column         | Type       | Options               |
| -------------- | ------- | ----------------------------- |
|   postal_code | string   |  null:  false    |
| area_id | integer     | null:  false                  |
|   municipality    |   string  |   null:  false    |
|   block_number    |   string |   null:  false    |
|   building_name   |   string   |     |
|   phone_number    | string   | null:  false    |
|   buy |references | null:false, foreign_key: true |


## Association
belongs_to :buy