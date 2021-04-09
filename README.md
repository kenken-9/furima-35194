# テーブル設計

## usersテーブル
| Column         | Type    | Options                       |
| -------------- | ------- | ----------------------------- |
| nickname       | string  | null:  false                  |
| email          | string  | null:  false ,   unique: true |
| password       | string  | null:  false                  |
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
| product_name   | string       | null:  false                  |
| product_text   | text       | null:  false                  |
| price          | integer    | null:  false                  |
| user    | references | null:false, foreign_key: true |
| category       | integer    | null:  false                  |
| condition      | string     | null:  false                  |
| shipping_fee   | string     | null:  false                  |
| consignor_area | string     | null:  false                  |
| ship_day       | string     | null:  false                  |


### Association
- belongs_to :user



## buysテーブル 
| Column         | Type       | Options               |
| -------------- | ------- | ----------------------------- |
|user          |references | null:false, foreign_key: true |
|buy_product|  text   | null:  false     |


## Association
- belongs_to :user
- has_one :address



### addresses
| Column         | Type       | Options               |
| -------------- | ------- | ----------------------------- |
|   postal_code | integer   |  null:  false    |
|   prefectures |   string  |   null:  false    |
|   municipality    |   string  |   null:  false    |
|   block_number    |   integer |   null:  false    |
|   building_name   |   string   |  null:  false    |
|   phone_number    | integer   | null:  false    |
|   buy |references | null:false, foreign_key: true |


## Association
belongs_to :buy