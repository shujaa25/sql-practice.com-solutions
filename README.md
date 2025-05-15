# SQL Practice Solutions

This repository contains my complete solutions to all SQL questions available on [sql-practice.com](https://www.sql-practice.com/). The practice exercises use two different sample databases: `hospital.db` and `northwind.db`.

All solutions are written in **MySQL**, and each solution file includes:
- The **original question** (commented in SQL format)
- The **corresponding SQL query** to solve it

---

## 📁 Repository Structure

solutions/
├── hospital/
│ ├── easy.sql
│ ├── medium.sql
│ └── hard.sql
└── northwind/
├── easy.sql
├── medium.sql
└── hard.sql


Each `.sql` file corresponds to a difficulty level and includes all relevant questions and solutions.

---

## 🏥 `hospital.db` Schema

This database includes patient admission records across various provinces. The schema contains the following tables:

### `patients`
| Column         | Type     |
|----------------|----------|
| patient_id     | INT (PK) |
| first_name     | TEXT     |
| last_name      | TEXT     |
| gender         | CHAR(1)  |
| birth_date     | DATE     |
| city           | TEXT     |
| province_id    | CHAR(2)  |
| allergies      | TEXT     |
| height         | INT      |
| weight         | INT      |

### `admissions`
| Column           | Type     |
|------------------|----------|
| patient_id       | INT      |
| admission_date   | DATE     |
| discharge_date   | DATE     |
| diagnosis        | TEXT     |
| attending_doctor_id | INT  |

### `doctors`
| Column     | Type     |
|------------|----------|
| doctor_id  | INT (PK) |
| first_name | TEXT     |
| last_name  | TEXT     |
| specialty  | TEXT     |

### `province_names`
| Column        | Type     |
|---------------|----------|
| province_id   | CHAR(2)  |
| province_name | TEXT     |

---

## 🛒 `northwind.db` Schema

A classic sales and inventory database that simulates a small business. It includes the following tables:

### Tables

- **categories** (`category_id`, `category_name`, `description`)
- **customers** (`customer_id`, `company_name`, `contact_name`, ..., `fax`)
- **employees** (`employee_id`, `first_name`, `last_name`, ..., `reports_to`)
- **employee_territories** (`employee_id`, `territory_id`)
- **order_details** (`order_id`, `product_id`, `quantity`, `discount`)
- **orders** (`order_id`, `customer_id`, `employee_id`, ..., `ship_country`)
- **products** (`product_id`, `product_name`, `supplier_id`, ..., `discontinued`)
- **regions** (`region_id`, `region_description`)
- **shippers** (`shipper_id`, `company_name`, `phone`)
- **suppliers** (`supplier_id`, `company_name`, ..., `home_page`)
- **territories** (`territory_id`, `territory_description`, `region_id`)

_Note: Some table names may contain underscores instead of hyphens for consistency with SQL standards._

---

## 🛠️ Notes

- All SQL queries are written in **MySQL** syntax.
- Questions are kept in-line as comments inside each `.sql` file for easy reference.
- The focus was on correctness and clarity. Performance optimization is minimal and follows standard SQL practices.

---

## 📜 License

This project is licensed under the MIT License.

---

## 🙌 Acknowledgements

Thanks to [sql-practice.com](https://www.sql-practice.com/) for providing the question sets and databases used in this repository.

