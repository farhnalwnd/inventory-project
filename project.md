# Project Documentation - Inventory Management System

---

## 1. Flow Project (Alur Program)

### Gambaran Umum
Program ini adalah aplikasi desktop berbasis Java Swing untuk mengelola inventaris barang. Menggunakan database PostgreSQL untuk penyimpanan data.

### Alur Lengkap:

```
START
  │
  ▼
┌──────────────────────────────────────────────┐
│              LOGIN PAGE                       │
│  - Input Username & Password                  │
│  - Tombol LOGIN → validasi ke database        │
│  - Tombol REGISTER USER → buka halaman daftar │
└──────────────────────┬───────────────────────┘
         │                           │
     Sukses? ←─────────── Tidak (tampil error)
         │ Ya
         ▼
┌──────────────────────────────────────────────┐
│              MAIN PAGE (DASHBOARD)            │
│  Sidebar navigasi dengan 9 menu:             │
│                                              │
│  1. HOME        → Halaman awal (branding)    │
│  2. ADD PRODUCT → Tambah barang baru         │
│  3. SEARCH      → Cari + beli barang         │
│  4. INVENTORY   → Lihat semua stok barang    │
│  5. RETURN      → Return barang dari bill    │
│  6. UPDATE STOCK→ Tambah stok barang masuk   │
│  7. TRACK SALES → Lihat penjualan per tanggal│
│  8. UPDATE LOGIN→ Ganti username/password    │
│  9. LOGOUT      → Kembali ke Login Page      │
└──────────────────────────────────────────────┘
```

### Detail Setiap Fitur:

#### a. HOME
- Menampilkan logo dan branding "INVENTORY CENTRAL"
- Titik awal setelah login

#### b. ADD PRODUCT
- Form input: Item ID, Item Name, Quantity, Price, MFD (tanggal), EXP (tanggal), Batch No
- Tombol: ADD PRODUCT (simpan ke DB), CLEAR (reset form), BACK (ke Home)

#### c. SEARCH PRODUCT
- Cari barang berdasarkan Item ID
- Tabel hasil pencarian menampilkan detail barang
- Klik baris tabel → otomatis isi field: Item ID, Item Name, Quantity, Price
- Input jumlah pembelian → ADD TO CART (masukkan ke keranjang)
- VIEW CART → buka halaman keranjang

#### d. INVENTORY
- Tabel menampilkan SEMUA barang dari database
- Tombol: DISPLAY INVENTORY (muat data), CLEAR (kosongkan tabel), BACK

#### e. RETURN PRODUCT
- Cari bill berdasarkan bill number
- Tabel menampilkan item-item dalam bill tersebut
- Pilih item, masukkan jumlah return → proses return
- Sistem mengembalikan stok ke gudang dan mencatat jumlah returned

#### f. UPDATE STOCK
- Cari produk berdasarkan Item ID
- Tampilkan info: Item ID, Item Name, Price (read-only)
- Input jumlah stok tambahan → UPDATE STOCK
- Sistem menambah quantity di database

#### g. TRACK SALES
- Pilih tanggal pakai DateChooser
- Tampilkan semua transaksi penjualan di tanggal tersebut
- Informasi: Bill No, Item ID, Item Name, Quantity, Price, Date

#### h. UPDATE LOGIN DETAILS
- Form: Username, Password, New Username, New Password
- Validasi field tidak boleh kosong
- Update data di tabel `login`

#### i. LOGOUT
- Tutup Mainpage, buka Loginpage lagi

### Cart & Checkout Flow:
```
SEARCH PRODUK → ADD TO CART → VIEW CART
                                  │
                                  ▼
                          PROCEED TO BILL
                                  │
                                  ├── Generate Bill No (random)
                                  ├── Insert ke tabel billmain
                                  ├── Kurangi stok di addproduct
                                  ├── Hapus semua data di cart
                                  └── Buka halaman INVOICE
                                        │
                                        ▼
                                GENERATE INVOICE
                                  (cetak / print)
```

---

## 2. Analisis OOP (4 Pilar)

### A. Encapsulation (Pembungkusan Data)

Encapsulation adalah konsep menyembunyikan data internal suatu objek dan hanya memberikan akses melalui method tertentu.

**Lokasi dalam kode:**

| File | Baris | Contoh |
|---|---|---|
| `DatabaseConnection.java` | 9-11 | `private static final String URL`, `USER`, `PASSWORD` — kredensial database disembunyikan, tidak bisa diakses langsung dari luar class |
| `Loginpage.java` | 311-326 | Semua komponen GUI (jButton1, jTextField2, dll) dideklarasikan sebagai `private` |
| `Registeruser.java` | 368-389 | Sama, semua komponen `private` |
| `Mainpage.java` | 3712-3892 | Semua komponen GUI dideklarasikan `private` |
| `Loginpage.java` | 233 | Method `private boolean validate_data()` — logic validasi login tidak bisa dipanggil dari luar class |

**Gunanya:**
- Mencegah data sensitif (password DB, komponen internal) diakses sembarangan
- Memudahkan perubahan internal tanpa mempengaruhi code lain
- Menjaga integritas data

---

### B. Inheritance (Pewarisan)

Inheritance adalah konsep di mana sebuah class mewarisi sifat dari class lain (parent class).

**Lokasi dalam kode:**

| File | Baris | Kode |
|---|---|---|
| `Loginpage.java` | 19 | `public class Loginpage extends javax.swing.JFrame` |
| `Registeruser.java` | 20 | `public class Registeruser extends javax.swing.JFrame` |
| `Mainpage.java` | 29 | `public class Mainpage extends javax.swing.JFrame` |

Ketiga class utama mewarisi dari `JFrame` (class bawaan Java Swing).

**Gunanya:**
- Tidak perlu membuat window dari nol — tinggal pakai method bawaan JFrame seperti `setVisible()`, `setTitle()`, `pack()`, `setLocationRelativeTo()`
- Kode lebih ringkas dan reusable
- Contoh penggunaan: `LoginpageFrame.setVisible(true)` (diwarisi dari JFrame)

---

### C. Polymorphism (Banyak Bentuk)

Polymorphism berarti satu method/interface bisa memiliki banyak implementasi berbeda.

**Lokasi dalam kode:**

| Lokasi | Baris | Penjelasan |
|---|---|---|
| **ActionListener** — banyak tombol | `Loginpage.java:135-138` | Tombol LOGIN. Method `actionPerformed()` di-override untuk login logic. Di tempat lain (jButton2, dll) override untuk navigasi berbeda |
| **MouseAdapter** — sidebar navigasi | `Mainpage.java:255-259` (home), `283-286` (add), `310-313` (search), dll | Satu class MouseAdapter, banyak implementasi `mouseClicked()` berbeda untuk setiap menu |
| **Runnable** — threading | `Loginpage.java:304-308` | Override `run()` untuk menjalankan GUI di Event Dispatch Thread |
| **isCellEditable** | `Mainpage.java:1866-1868` | Override method untuk mengatur tabel yang tidak bisa diedit |

**Gunanya:**
- Satu interface (`ActionListener`) bisa dipakai untuk menangani klik tombol yang berbeda-beda
- Kode lebih fleksibel — setiap tombol punya perilaku sendiri tanpa perlu if-else panjang
- Memungkinkan penggunaan method overriding untuk menyesuaikan perilaku

---

### D. Abstraction (Abstraksi)

Abstraction adalah konsep menyembunyikan kompleksitas dan hanya menampilkan fungsi penting.

**Lokasi dalam kode:**

| Lokasi | Baris | Penjelasan |
|---|---|---|
| **DatabaseConnection** | `DatabaseConnection.java:13-15` | Method `getConnection()` — pengguna cukup panggil `DatabaseConnection.getConnection()`, tanpa perlu tahu detail DriverManager, URL, username, password. Kompleksitas koneksi DB disembunyikan. |
| **Penggunaan JFrame** | Semua class GUI | `JFrame` adalah class abstrak yang menyediakan framework window. Kita tinggal pakai tanpa perlu tahu bagaimana window dibuat di level OS. |
| **Interface ActionListener** | Banyak tempat | Kita hanya perlu implement `actionPerformed()`, tanpa perlu tahu bagaimana Swing menangani event klik di belakang layar. |
| **try-with-resources** | `Mainpage.java:2871`, `3038`, `3560` | Resource management (Connection, PreparedStatement, ResultSet) ditutup otomatis — programmer tidak perlu mikir cleanup manual. |

**Gunanya:**
- Memudahkan penggunaan fitur kompleks (koneksi DB, GUI, event handling)
- Kode lebih bersih dan fokus pada business logic
- Memisahkan "apa yang dilakukan" dari "bagaimana cara melakukannya"

---

## 3. Penjelasan Database

### Jenis Database: PostgreSQL

### Nama Database: `inventory_db`

### Struktur 4 Tabel:

#### Tabel 1: `login`
Menyimpan data user untuk autentikasi.

| Kolom | Tipe | Keterangan |
|---|---|---|
| username | VARCHAR(100) | Primary Key |
| email | VARCHAR(150) | Alamat email user |
| password | VARCHAR(100) | Password login |

**Fungsi:** Digunakan saat login dan register user. Ada data default: `admin / admin@example.com / admin`.

---

#### Tabel 2: `addproduct`
Menyimpan data barang/inventaris.

| Kolom | Tipe | Keterangan |
|---|---|---|
| item_id | VARCHAR(50) | Primary Key — ID unik barang |
| item_name | VARCHAR(150) | Nama barang |
| quantity | INTEGER | Jumlah stok barang |
| price | NUMERIC(15,2) | Harga per unit |
| mfd | DATE | Tanggal produksi (manufactured date) |
| expd | DATE | Tanggal kadaluarsa (expired date) |
| batch_no | VARCHAR(50) | Nomor batch produksi |

**Fungsi:** Digunakan oleh fitur Add Product (tambah), Inventory (tampil semua), Search Product (cari & beli), Update Stock (tambah stok), Return Product (kembalikan stok).

---

#### Tabel 3: `cart`
Keranjang belanja sementara.

| Kolom | Tipe | Keterangan |
|---|---|---|
| id | SERIAL | Primary Key (auto increment) |
| item_id | VARCHAR(50) | ID barang |
| item_name | VARCHAR(150) | Nama barang |
| quantity | INTEGER | Jumlah dibeli |
| price | NUMERIC(15,2) | Harga per unit |
| totprice | NUMERIC(15,2) | Total harga (quantity x price) |

**Fungsi:** Menyimpan barang yang akan dibeli sebelum di-checkout. Data di tabel ini akan dihapus setelah checkout berhasil (diproses ke billmain).

---

#### Tabel 4: `billmain`
Menyimpan riwayat transaksi penjualan.

| Kolom | Tipe | Keterangan |
|---|---|---|
| id | SERIAL | Primary Key (auto increment) |
| bill_no | VARCHAR(50) | Nomor bill (random 4 digit) |
| item_id | VARCHAR(50) | ID barang |
| item_name | VARCHAR(150) | Nama barang |
| quantity | INTEGER | Jumlah terjual |
| returned_quantity | INTEGER | Default 0 — jumlah yang sudah di-return |
| price | NUMERIC(15,2) | Harga per unit |
| totprice | NUMERIC(15,2) | Total harga |
| date | DATE | Tanggal transaksi |

**Fungsi:** Mencatat semua transaksi penjualan. Digunakan oleh fitur Track Sales (cari per tanggal), Return Product (cari bill untuk return), dan Generate Invoice (print bill).

### Relasi Antar Tabel:

```
login ──(digunakan untuk login)──> aplikasi

addproduct ──(stok diambil)──> cart ──(checkout)──> billmain
     ^                                                 │
     │                                                 │
     └──────── (return stok) ←─────────────────────────┘
```

Alur data:
1. Admin login pakai tabel `login`
2. Barang ditambahkan ke `addproduct`
3. Pembeli memilih barang → masuk ke `cart`
4. Checkout → data pindah ke `billmain`, stok di `addproduct` berkurang
5. Jika ada return → stok dikembalikan ke `addproduct`, `returned_quantity` di `billmain` bertambah

---

## 4. Kesimpulan

### Ringkasan Project
**Inventory Management System** adalah aplikasi desktop berbasis Java Swing dengan database PostgreSQL. Aplikasi ini membantu mengelola inventaris barang, mulai dari pencatatan barang, penjualan, hingga pelacakan return barang.

### OOP yang Diterapkan

| Pilar | Implementasi | Manfaat |
|---|---|---|
| **Encapsulation** | Semua field private, method validasi private | Data aman, kode terstruktur |
| **Inheritance** | Loginpage, Registeruser, Mainpage extends JFrame | Code reuse, memanfaatkan fitur Swing |
| **Polymorphism** | Override actionPerformed(), mouseClicked(), run() | Satu interface banyak perilaku |
| **Abstraction** | DatabaseConnection, interface Swing | Sederhanakan akses kompleks |

### Database
Menggunakan 4 tabel (login, addproduct, cart, billmain) yang saling terhubung untuk mendukung seluruh fitur aplikasi.

### Kelebihan Project
- GUI yang user-friendly dengan navigasi sidebar
- Fitur CRUD lengkap untuk inventaris
- Fitur keranjang belanja dan checkout
- Fitur return barang dengan tracking quantity
- Fitur cetak invoice

### Kekurangan / Catatan
- Beberapa query masih menggunakan Statement (rawan SQL Injection) — namun sudah diperbaiki di bagian Update Stock, Return Product, Track Sales, dan Search Bill yang menggunakan PreparedStatement
- Password disimpan dalam bentuk plain text (belom di-hash)
- Kode GUI banyak yang auto-generated oleh NetBeans (susah dibaca manual)
- Semua logic ada di dalam satu class Mainpage yang sangat besar (~3894 baris) — bisa dipecah menjadi class-class terpisah

---

*Dokumen ini dibuat untuk dokumentasi project OOP - Inventory Management System*
