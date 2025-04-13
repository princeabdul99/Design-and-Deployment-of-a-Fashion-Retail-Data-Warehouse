# Data Catalog for Gold Layer

## Overview
The gold Layer is the business data representation, structured to support multifaceted analytical and reporting use cases. It consists of **dimension tables** and **fact tables**
for specfic business metrics.

---

### 1. **gold.dim_customers**
- **Purpose:** Stores customer details enriched with demographic and geographic data.
- **Columns:**

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| customer_id      | INT           | primary key uniquely identifying each customer record in the dimension table.               |
| fullname         | NVARCHAR(50)  | The customer's fullame, as recorded in the system.                                         |
| country          | NVARCHAR(50)  | The country of residence for the customer (e.g., 'Portugal').                               |
| city             | NVARCHAR(50)  | The city of the customer (e.g., 'Coimbra', 'Brage').                                        |
| gender           | NVARCHAR(50)  | The gender of the customer (e.g., 'Male', 'Female', 'n/a').                                  |
| birth_date       | DATE          | The date of birth of the customer, formatted as YYYY-MM-DD (e.g., 1971-10-06).               |
| profession      | NVARCHAR(50)   | The occupation of the customer as recorded in the system.                                      |

---

### 2. **gold.dim_stores**
- **Purpose:** Provides detailed information about store locations for a multinational company. Each entry represents a specific store, with details about its geographical location, number of employees, and more.
- **Columns:**

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| store_id                 | INT             | primary key uniquely identifying each store record in the dimension table.          |
| store_name               | NVARCHAR(50)    | The store name following the format (Store [City]).                                 |
| country                  | NVARCHAR(50)    | The country where the store is located (e.g., 'Portugal').                          |
| city                     | NVARCHAR(50)    | The city where the store is located (e.g., 'Coimbra', 'Brage').                     |
| zipcode                  | NVARCHAR(50)    | The postal code of the store location.            (20000)                           |
| latitude                 | DATE            | The geographcal latitude of the store location.  (e.g., 31.2304)                    |
| longitude                | NVARCHAR(50)    | The geographical longitiude of the store location. (e.g., 121.4737).                |
| number_of_employees      | NVARCHAR(50)    | Total employees assigned to the store. (e.g., 10).                                  |

---


### 3. **gold.dim_product**
- **Purpose:** Provides detailed information about products sold by a company, with descriptions and other product attributes such as category, and sizes etc.
- **Columns:**

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| product_id             | INT             | primary key uniquely identifying each product record in the dimension table.          |
| category               | NVARCHAR(50)    | High-level classification of the product. (e.g., Feminine, Masculine, Children).      |
| subcategory            | NVARCHAR(50)    | More specific classification within the category (e.g., 'Coat and Blazzers').         |
| description            | NVARCHAR(50)    | The product descriptions (e.g., sports velvet sport with buttons).                    |
| color                  | NVARCHAR(50)    | The product color. (e,g. PINK)                                                        |
| sizes                  | NVARCHAR(50)    | The product sizes available. (e.g., S |M |L |XL, 38|39|40)                       |

---


### 4. **gold.dim_employees**
- **Purpose:** Provides information about employees working at different store locations, detailing their roles and unique identifiers.
- **Columns:**

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| employee_id      | INT             | primary key uniquely identifying each product record in the dimension table.  (e.g., 1).    |
| store_id         | INT             | Foreign key linking to the Store ID location in dim_stores. (e.g., 1).                      |
| fullname         | NVARCHAR(50)    | Employees first name and last name (e.g., 'Michelle Williams').                             |
| position         | NVARCHAR(50)    | Roles within the store hierarchy (e.g., Manager).                                           |

---

### 5. **gold.dim_discounts**
- **Purpose:** Provides information data about discount campaigns, including their validity periods, discount rates, and applicable product categories.
- **Columns:**

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| discount_key     | INT             | primary key uniquely identifying each discount record in the dimension table.  (e.g., 1).   |
| start_date       | Date            | Date when the discount becomes active, in YYYY-MM-DD. (e.g., 2024-06-01).                   |
| end_date         | Date            | Date when the discount expires, in YYYY-MM-DD (e.g., 2024-06-30).                           |
| discount         | Float           | Decimal value representing the discount rate (e.g., 0.20 means 20% discount) (e.g., 0.20).  |
| description      | NVARCHAR(50)    | Brief description of the discount campaign. (e.g., 'Summer Sale discount on all items').    |
| category         | NVARCHAR(50)    | Product categories to which the discount applies. (e.g., 'Feminine').                       |
| subcategory      | NVARCHAR(50)    | Product Sub Category to which the discount applies. (e.g., 'T-shirts and Tops').            |


---


### 6. **gold.fact_sales**
- **Purpose:** Provides detailed transaction information for a multinational retail company operating in multiple countries and currencies. Each entry represents a single line item from an invoice, including both sales and returns.
- **Columns:**

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| inovice_id       | INT             | A unique identifier for each transaction, distinguishing sales and returns. It follows the format: (INV for sales or RET for returns) + Country Code + Store ID + Sequential Counter. This ensures all items from the same transaction are grouped under the same invoice.  (e.g., INV-US-001-00001233).   |
| sku              | NVARCHAR(50)    | Stock Keeping Unit (SKU), a unique inventory code. (e.g., FESH81-M-PINK).                   |
| customer_id      | INT             | Unique identifier referencing the customer who made the purchase on dim_customers. (e.g., 380368).           |
| store_id         | INT             | Unique identifier referencing the store where the transaction took place on dim_stores. (e.g., 9).        |
| employee_id      | INT             | Unique identifier referencing the employee who processed the transaction on dim_employees. (e.g., 37).       |
| transaction_date | Date            | Date and time of the transaction in the format. YYYY-MM-DD HH:MM:SS (e.g., '2023-01-01 12:23:00'). |
| product_id       | INT             | Unique identifier referencing the product purchased on dim_products.  (e.g., 1816).         |
| size             | NVARCHAR(50)    | Product size variant (e.g., S, M, L, XL). n/a if not applicable.. (e.g., M).                   |
| color            | NVARCHAR(50)    | Color variation of the product. n/a if not applicable. (e.g., PINK).                           |
| line             | INT             | Sequential number representing the position of the product in the invoice. A single invoice can contain multiple line items. (e.g., 1).  |
| unit_price       | Float           | Price of a single unit of the product before any discounts are applied. (e.g., 198.00).    |
| quantity         | INT             | Number of units of the product purchased within this invoice line item. (e.g., 2).                       |
| discount         | Float           | Discount applied to the line item, represented as a decimal (e.g., 0.30 = 30% discount, 0.00 = no discount). found list of discount dim_discount  (e.g., 0.00).   |
| amount_total     | Float           | Total cost for the line item after applying any discounts. Calculated as: Unit Price × Quantity × (1 - Discount).  (e.g., 277.20).   |
| invoice_total    | Float           | Refers to the total value of the transaction (Invoice ID). It is the sum of all Line Total values for the same Invoice ID. This value is repeated across all line items within the same Invoice ID. (e.g., 347.50).                           |
| transaction_type | NVARCHAR(50)    | Specifies whether the transaction is a Sale or Return. (e.g., Sale).  |
| currency         | NVARCHAR(50)    | Three-letter ISO currency code representing the currency used for the transaction (e.g., USD, EUR, CNY, GBP). (e.g., USD).    |
| currency_symbol  | NVARCHAR(50)    | Symbol associated with the transaction currency (e.g., $, €, £, ¥). (e.g., $).                       |
| payment_method   | NVARCHAR(50)    | Method used to complete the transaction (e.g., Credit Card, Cash).  (e.g., Credit Card).   |





