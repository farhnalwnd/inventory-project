# Issue: Implementasi & Perbaikan Fitur "Track Sales"

## 🎯 Target Utama

1. **Fitur Track Sales**: Mengimplementasikan pencarian data riwayat penjualan (Track Sales) berdasarkan tanggal.
2. **Perbaikan UI & Database**: Menambahkan komponen input tanggal yang hilang pada antarmuka, menyambungkan fungsi tombol _Search_, dan menampilkan data penjualan secara akurat dari database.

---

## 📋 Task Description

Saat ini, tampilan fitur "Track Sales" (berada di dalam `jPanel9` atau `tab8` pada `Mainpage.java`) memiliki beberapa kekurangan mendasar: terdapat label _"Search Date"_ dan tombol _"SEARCH"_ (`jButton16`), namun **tidak ada komponen input (seperti kalender/JDateChooser atau text field) untuk memasukkan tanggal**. Selain itu, tombol _Search_ belum memiliki aksi (event listener) sama sekali.

Tugas kamu sebagai developer adalah menyelesaikan modul Track Sales ini secara penuh.

### 1. Perbaikan Antarmuka Pengguna (UI)

- Buka desain UI `Mainpage.java` menggunakan GUI Builder (seperti di NetBeans).
- Cari panel untuk fitur **Track Sales** (`jPanel9`).
- Tambahkan komponen kalender **`JDateChooser`** (atau `JTextField` jika tidak ada library kalender) tepat di sebelah label "Search Date" (`jLabel43`) dan sebelum tombol "SEARCH" (`jButton16`).
- Beri nama variabel yang jelas pada komponen input tersebut, misalnya `dateChooserSales`.

### 2. Implementasi Logika Pencarian (Event Listener)

- Tambahkan event `ActionListener` pada tombol "SEARCH" (`jButton16`). Kamu bisa melakukannya lewat GUI Builder (klik kanan -> _Events_ -> _Action_ -> _actionPerformed_).
- Di dalam metode `jButton16ActionPerformed`, ambil nilai tanggal dari komponen input:
  - Jika menggunakan `JDateChooser`: Ambil tanggal, lalu format menjadi _string_ berformat `yyyy-MM-dd` menggunakan `SimpleDateFormat`.
  - Jika menggunakan `JTextField`: Ambil teks langsung.

### 3. Query Database & Tampilkan ke Tabel

- Gunakan `PreparedStatement` untuk mengeksekusi query pencarian.
- Query SQL: `SELECT bill_no, item_id, item_name, quantity, price, date FROM billmain WHERE date = ?`
- Bersihkan tabel `jTable4` sebelum memuat data baru (`model.setRowCount(0)`).
- Masukkan hasil eksekusi (`ResultSet`) ke dalam `jTable4` baris demi baris menggunakan `model.addRow(...)`.

---

## 🐛 Informasi Kemungkinan Kesalahan dan Bug (Harus Diwaspadai)

Saat mengerjakan tugas ini, perhatikan beberapa potensi _error_ dan pastikan kamu menanganinya dengan baik:

1. **`NullPointerException` (Saat Membaca Tanggal)**
   - **Penyebab**: Jika pengguna langsung menekan tombol SEARCH tanpa memilih/memasukkan tanggal sama sekali, pengambilan nilai kalender akan mengembalikan `null`. Memanggil format _date_ pada nilai `null` akan memicu _crash_.
   - **Solusi**: Tambahkan validasi di awal `actionPerformed`. Contoh: `if (dateChooserSales.getDate() == null) { JOptionPane... return; }`.

2. **SQL Injection Vulnerability**
   - **Penyebab**: Menempelkan string tanggal langsung ke dalam query, contoh: `"SELECT ... WHERE date = '" + inputTanggal + "'"`.
   - **Solusi**: Wajib menggunakan `PreparedStatement` dengan sintaks parameter `?`, kemudian memanggil `pstmt.setDate(1, java.sql.Date.valueOf(inputTanggal))` atau `pstmt.setString(1, inputTanggal)`.

3. **Format Tanggal Tidak Cocok (Data Tidak Ditemukan)**
   - **Penyebab**: Tipe data kolom `date` di tabel PostgreSQL (`billmain`) adalah `date` (format YYYY-MM-DD). Jika kamu mengirim format seperti `DD/MM/YYYY`, query tidak akan menemukan data atau malah _error_.
   - **Solusi**: Pastikan Java memformat tanggal ke struktur `yyyy-MM-dd` sebelum parameter di-_set_ ke dalam _Prepared Statement_. Gunakan `SimpleDateFormat("yyyy-MM-dd")`.

4. **Koneksi / Resource Leak**
   - **Penyebab**: Objek `Connection`, `PreparedStatement`, atau `ResultSet` tidak ditutup. Hal ini dapat menghabiskan memori dan memutus akses ke database jika dilakukan berulang kali.
   - **Solusi**: Gunakan pola _Try-With-Resources_ atau pastikan `c.close()`, `pstmt.close()`, dan `rs.close()` dipanggil pada blok `finally`.
