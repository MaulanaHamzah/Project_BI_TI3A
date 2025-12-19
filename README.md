# 📊 Business Intelligence - ETL & Data Warehouse Project

<div align="center">

![Business Intelligence](https://img.shields.io/badge/Business-Intelligence-blue?style=for-the-badge)
![ETL](https://img.shields.io/badge/ETL-Pentaho-orange?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-Database-blue?style=for-the-badge&logo=mysql)
![Data Warehouse](https://img.shields.io/badge/Data-Warehouse-green?style=for-the-badge)

**Superstore Sales Data Warehouse & Analytics**

[📚 Documentation](#documentation) • [🚀 Quick Start](#quick-start) • [📊 Dashboard](#dashboard) • [👥 Team](#team)

</div>

---

## 📋 Table of Contents

- [About Project](#-about-project)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Database Schema](#-database-schema)
- [Installation](#-installation)
- [Usage](#-usage)
- [Query Examples](#-query-examples)
- [KPI Dashboard](#-kpi-dashboard)
- [Team Members](#-team-members)
- [License](#-license)

---

## 🎯 About Project

Project ini merupakan implementasi **ETL (Extract, Transform, Load)** dan **Data Warehouse** menggunakan dataset **Superstore Sales** untuk analisis Business Intelligence. Project ini mencakup:

- ✅ Perancangan Data Warehouse dengan **Star Schema**
- ✅ Pipeline ETL menggunakan **Pentaho Data Integration**
- ✅ Database MySQL untuk Data Storage
- ✅ Query Testing & KPI Analysis
- ✅ Dashboard Visualization dengan Google Looker Studio

**Dataset Source:** [Kaggle - Superstore Sales](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting)

---

## 🛠 Tech Stack

| Technology | Purpose |
|------------|---------|
| ![Pentaho](https://img.shields.io/badge/Pentaho-Data%20Integration-FF6C37?style=flat-square) | ETL Pipeline Development |
| ![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat-square&logo=mysql&logoColor=white) | Data Warehouse Database |
| ![Laragon](https://img.shields.io/badge/Laragon-Development-0E83CD?style=flat-square) | Local Development Environment |
| ![Google Looker](https://img.shields.io/badge/Google-Looker%20Studio-4285F4?style=flat-square&logo=google&logoColor=white) | Dashboard & Visualization |
| ![phpMyAdmin](https://img.shields.io/badge/phpMyAdmin-Database%20Management-6C78AF?style=flat-square) | Database Administration |

---

## 📁 Project Structure

```
ETL_PROJECT/
│
├── 📄 dim_customer.ktr          # ETL untuk dimensi customer
├── 📄 dim_product.ktr           # ETL untuk dimensi product
├── 📄 dim_order.ktr             # ETL untuk dimensi order
├── 📄 dim_date.ktr              # ETL untuk dimensi date
├── 📄 fact_sales.ktr            # ETL untuk tabel fakta sales
├── 📄 job_master.kjb            # Job orchestrator untuk semua ETL
│
├── 📂 dataset/
│   └── 📊 train.csv             # Dataset Superstore Sales
│
├── 📂 sql/
│   ├── 🗃️ create_tables.sql    # Script DDL untuk create tables
│   ├── 🔍 query_testing.sql    # Query analisis dan testing
│   └── 🗑️ truncate_tables.sql  # Script untuk reset data
│
├── 📂 docs/
│   ├── 📄 Laporan_UAS_BI.pdf   # Laporan lengkap project
│   └── 📊 Star_Schema.png      # Diagram star schema
│
└── 📖 README.md                 # Project documentation
```

---

## 🗂 Database Schema

### ⭐ Star Schema Design

```
                    ┌─────────────────┐
                    │   dim_customer  │
                    │─────────────────│
                    │ customer_id (PK)│
                    │ customer_name   │
                    │ segment         │
                    │ country         │
                    │ city            │
                    │ state           │
                    │ postal_code     │
                    │ region          │
                    └────────┬────────┘
                             │
         ┌───────────────────┼───────────────────┐
         │                   │                   │
┌────────┴────────┐  ┌──────┴──────┐  ┌────────┴────────┐
│  dim_product    │  │ fact_sales  │  │   dim_order     │
│─────────────────│  │─────────────│  │─────────────────│
│ product_id (PK) │  │ fact_id (PK)│  │ order_id (PK)   │
│ category        │◄─┤ order_id FK │─►│ ship_date       │
│ sub_category    │  │ customer_id │  │ ship_mode       │
│ product_name    │  │ product_id  │  └─────────────────┘
└─────────────────┘  │ date_id FK  │
                     │ sales       │
                     └──────┬──────┘
                            │
                   ┌────────┴────────┐
                   │    dim_date     │
                   │─────────────────│
                   │ date_id (PK)    │
                   │ full_date       │
                   │ day             │
                   │ month           │
                   │ month_name      │
                   │ year            │
                   │ quarter         │
                   └─────────────────┘
```

### 📊 Tables Overview

| Table | Type | Records | Description |
|-------|------|---------|-------------|
| `fact_sales` | Fact | 9,800 | Transaksi penjualan |
| `dim_customer` | Dimension | 793 | Data pelanggan |
| `dim_product` | Dimension | 1,850+ | Data produk |
| `dim_order` | Dimension | 5,000+ | Data pesanan |
| `dim_date` | Dimension | 1,230 | Data tanggal |

---

## 🚀 Installation

### Prerequisites

- [Laragon](https://laragon.org/) (includes MySQL & PHP)
- [Pentaho Data Integration](https://sourceforge.net/projects/pentaho/)
- Web Browser (for phpMyAdmin & Looker Studio)

### Setup Steps

1. **Clone Repository**
   ```bash
   git clone https://github.com/[your-repo]/bi-etl-project.git
   cd bi-etl-project
   ```

2. **Start Laragon**
   - Open Laragon
   - Click "Start All"
   - Ensure MySQL is running (green indicator)

3. **Create Database**
   ```sql
   CREATE DATABASE superstore_dw;
   USE superstore_dw;
   
   -- Run create_tables.sql
   SOURCE sql/create_tables.sql;
   ```

4. **Configure Pentaho Connection**
   - Open Pentaho Spoon
   - Create new database connection:
     - Host: `localhost`
     - Port: `3306`
     - Database: `superstore_dw`
     - User: `root`
     - Password: (your password)

5. **Run ETL Job**
   ```
   Open job_master.kjb in Pentaho
   Click Run (F9)
   Wait until all transformations complete
   ```

---

## 💻 Usage

### Running ETL Pipeline

**Method 1: Using Job Master (Recommended)**
```
1. Open Pentaho Spoon
2. File → Open → job_master.kjb
3. Click Run button (F9)
4. Monitor log for success/errors
```

**Method 2: Manual Execution**
```
1. Run each .ktr file in order:
   - dim_customer.ktr
   - dim_product.ktr
   - dim_order.ktr
   - dim_date.ktr
   - fact_sales.ktr (last!)
```

### Reset Data (Fresh Load)

Before re-running ETL, truncate all tables:

```sql
-- In phpMyAdmin SQL tab
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE fact_sales;
TRUNCATE TABLE dim_customer;
TRUNCATE TABLE dim_product;
TRUNCATE TABLE dim_order;
TRUNCATE TABLE dim_date;
SET FOREIGN_KEY_CHECKS = 1;
```

Or use: `SOURCE sql/truncate_tables.sql;`

---

## 🔍 Query Examples

### Total Sales & Transactions
```sql
SELECT 
    SUM(sales) AS total_sales,
    COUNT(*) AS total_transactions
FROM fact_sales;
```

### Top 5 Products
```sql
SELECT 
    p.product_name,
    p.category,
    SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_sales DESC
LIMIT 5;
```

### Sales by Region
```sql
SELECT 
    c.region,
    SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_sales DESC;
```

**More queries:** See `sql/query_testing.sql`

---

## 📊 KPI Dashboard

### Key Performance Indicators

| KPI | Description |
|-----|-------------|
| 💰 **Total Sales** | Sum of all sales transactions |
| 📦 **Total Transactions** | Count of orders |
| 🏆 **Top 5 Products** | Best selling products by revenue |
| 🗂 **Category Performance** | Sales breakdown by product category |
| 🌎 **Regional Sales** | Sales distribution by region |
| 👥 **Customer Segments** | Sales by customer segment |
| 📈 **Monthly Trends** | Sales trends over time |
| 📅 **Quarterly Analysis** | Quarterly sales performance |

### Dashboard Preview

**Access Dashboard:** [Google Looker Studio Link]

*(Add screenshot of your dashboard here)*

---

## 👥 Team Members

<table>
  <tr>
    <td align="center">
      <img src="https://via.placeholder.com/100" width="100px;" alt="Member 1"/><br />
      <sub><b>Achmad Maulana Hamzah</b></sub><br />
      <sub>NIM: 2341720172</sub><br />
      <a href="https://github.com/[username]">GitHub</a>
    </td>
    <td align="center">
      <img src="https://via.placeholder.com/100" width="100px;" alt="Member 2"/><br />
      <sub><b>Gwido Putra Wijaya</b></sub><br />
      <sub>NIM: 2341720103</sub><br />
      <a href="https://github.com/[username]">GitHub</a>
    </td>
    <td align="center">
      <img src="https://via.placeholder.com/100" width="100px;" alt="Member 3"/><br />
      <sub><b>Stevan Zaky Setyanto</b></sub><br />
      <sub>NIM: 2341720101</sub><br />
      <a href="https://github.com/[username]">GitHub</a>
    </td>
    <td align="center">
      <img src="https://via.placeholder.com/100" width="100px;" alt="Member 4"/><br />
      <sub><b>Vemas Bagus Fermanda</b></sub><br />
      <sub>NIM: 2341720137</sub><br />
      <a href="https://github.com/[username]">GitHub</a>
    </td>
  </tr>
</table>

### Pembagian Tugas

| Nama                      | Role           | Tanggung Jawab             |
|-----------                |--------------- |----------------            |
| **Achmad Maulana Hamzah** | Project Lead   | Koordinasi & ETL Design    |
| **Gwido Putra Wijaya**    | Data Engineer  | Pentaho ETL Implementation |
| **Stevan Zaky Setyanto**  | Database Admin | Database Design & Query    |
| **Vemas Bagus Fermanda**  | Data Analyst   | Dashboard & KPI Analysis   |

---

## 📚 Documentation

- 📖 [Laporan Lengkap](docs/Laporan_UAS_BI.pdf)
- 📊 [Star Schema Diagram](docs/Star_Schema.png)
- 🔍 [Query Documentation](sql/query_testing.sql)
- 🎓 [Pentaho Tutorial](https://help.pentaho.com/)

---

## 🎓 Academic Information

**Mata Kuliah:** Business Intelligence  
**Dosen Pengampu:** Endah Septa Sintiya, S.Pd., M.Kom.  
**Program Studi:** D-IV Teknik Informatika  
**Jurusan:** Teknologi Informasi  
**Institusi:** Politeknik Negeri Malang  
**Tahun Akademik:** 2024/2025

---

## 📝 License

This project is created for academic purposes as part of Business Intelligence course final project at Politeknik Negeri Malang.

© 2025 - All Rights Reserved

---

## 🙏 Acknowledgments

- **Dataset:** [Kaggle Superstore Sales](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting)
- **Tools:** Pentaho Data Integration, MySQL, Google Looker Studio
- **Guidance:** Endah Septa Sintiya, S.Pd., M.Kom.

---

<div align="center">

**⭐ Star this repository if you find it helpful!**

Made with ❤️ by [Team Name]

[⬆ Back to Top](#-business-intelligence---etl--data-warehouse-project)

</div>
