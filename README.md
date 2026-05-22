# Inventory Management System

Aplikasi desktop untuk mengelola inventaris barang, dibangun menggunakan Java Swing dan database PostgreSQL.

---

## Fitur Utama

- Login & Register user
- Tambah, cari, dan tampilkan barang (inventaris)
- Keranjang belanja dan checkout
- Update stok barang
- Return produk berdasarkan nomor bill
- Lacak penjualan per tanggal
- Cetak invoice
- Update kredensial login

---

## Teknologi

| Komponen      | Detail                         |
| ------------- | ------------------------------ |
| Bahasa        | Java                           |
| GUI Framework | Java Swing (NetBeans)          |
| Database      | PostgreSQL                     |
| Driver        | `org.postgresql.Driver` (JDBC) |

---

## Persyaratan

- Java JDK 8+
- PostgreSQL
- NetBeans IDE (opsional, untuk buka project)

---

## Setup & Instalasi

**1. Clone repository**

```bash
git clone https://github.com/harishy0406/Inventory-Management-System
```

**2. Buat database PostgreSQL**

```sql
CREATE DATABASE inventory_db;
```

**3. Import schema database**

```bash
psql -U postgres -d inventory_db -f inventory_db_postgres.sql
```

**4. Sesuaikan koneksi database**

Edit file `src/ism/DatabaseConnection.java`:

```java
private static final String URL = "jdbc:postgresql://localhost:5432/inventory_db";
private static final String USER = "postgres";
private static final String PASSWORD = "your_password";
```

**5. Jalankan project**

Buka di NetBeans → klik kanan project → Run

---

## Login Default

| Username | Password |
| -------- | -------- |
| admin    | admin    |

---

## Struktur Project

```
src/ism/
├── ISM.java              # Entry point (main class)
├── Loginpage.java        # Halaman login
├── Registeruser.java     # Halaman registrasi
├── Mainpage.java         # Dashboard utama (semua fitur)
└── DatabaseConnection.java # Koneksi ke PostgreSQL
```

---

## Database

4 tabel utama:

| Tabel        | Fungsi                      |
| ------------ | --------------------------- |
| `login`      | Data akun user              |
| `addproduct` | Data & stok barang          |
| `cart`       | Keranjang belanja sementara |
| `billmain`   | Riwayat transaksi penjualan |

---

## Lisensi

Project ini dibuat untuk keperluan akademik (tugas OOP).
