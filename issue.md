# Issue: Penambahan Fitur "Clear Data" pada Seluruh Modul

## 🎯 Target Utama
- **Fitur Add Product**
- **Fitur Search Product**
- **Fitur Lainnya**: Update Stock, Return Product, Track Sales, dan Update Login Credentials.

---

## 📋 Task Description

Saat ini, beberapa fitur dalam aplikasi inventaris (`Mainpage.java`) memiliki *form* pengisian data yang panjang. Pengguna memerlukan tombol **"CLEAR"** untuk menghapus isi teks atau tabel dengan cepat tanpa harus menghapusnya satu per satu. 

Tugas kamu sebagai developer adalah memeriksa setiap modul fitur, menambahkan tombol "CLEAR" jika belum ada, dan memberikan logika untuk membersihkan sisa inputan data.

### 1. Fitur Add Product (`jPanel3`)
- **Tugas**: Periksa keberadaan tombol "CLEAR". Jika sudah ada (seperti `jButton20`), berikan implementasi fungsi pada event `actionPerformed`. Jika belum, tambahkan tombol tersebut.
- **Aksi Pembersihan**: Kosongkan nilai dari:
  - `TextBox1` (Item Id)
  - `TextBox2` (Item Name)
  - `TextBox3` (Quantity)
  - `TextBox4` (Price)
  - Pindahkan fokus kursor kembali ke `TextBox1` (`TextBox1.requestFocus()`).

### 2. Fitur Search Product (`jPanel4`)
- **Tugas**: Periksa keberadaan tombol "CLEAR" (seperti `jButton26`).
- **Aksi Pembersihan**: Kosongkan *field* pencarian (`TextBox7`) dan **bersihkan seluruh isi tabel** (`jTable1`).
- *Hint*: Gunakan `((DefaultTableModel) jTable1.getModel()).setRowCount(0);` untuk mengosongkan tabel.

### 3. Fitur Update Stock (`jPanel7`)
- **Tugas**: Tambahkan tombol "CLEAR" baru di sebelah tombol "UPDATE STOCK" (`jButton14`).
- **Aksi Pembersihan**: Kosongkan `jTextField15`, `jTextField16`, `jTextField17`, `jTextField13`, `jTextField14`, dan kolom pencarian ID `jTextField18`.

### 4. Fitur Return Product (`jPanel5`)
- **Tugas**: Tambahkan tombol "CLEAR" pada antarmuka retur barang.
- **Aksi Pembersihan**: Kosongkan semua *text field* (`jTextField9` s/d `jTextField12`, dan `jTextField19`). Bersihkan juga tabel riwayat pembelian (`jTable3`).

### 5. Fitur Track Sales (`jPanel9`)
- **Tugas**: Tambahkan tombol "CLEAR" di sebelah tombol "SEARCH".
- **Aksi Pembersihan**: Reset input tanggal (`dateChooserSales`) dan bersihkan tabel hasil pencarian penjualan (`jTable4`).

### 6. Fitur Update Login Credentials (`jPanel8`)
- **Tugas**: Tambahkan tombol "CLEAR" di sebelah tombol "UPDATE" jika belum ada.
- **Aksi Pembersihan**: Kosongkan kolom input kredensial lama dan baru (`jTextField20`, `jTextField21`, `jPasswordField1`, `jPasswordField2`).

---

## 🐛 Informasi Kemungkinan Kesalahan dan Bug (Harus Diwaspadai)

Saat mengerjakan tugas penambahan fungsi "Clear" ini, ada beberapa kesalahan (*bug*) teknis yang sangat rentan terjadi. Pastikan untuk memperhatikannya:

1. **`NullPointerException` saat Membersihkan Tabel**
   - **Penyebab**: Memanggil metode pada model tabel yang salah atau gagal di-*cast* dengan tepat.
   - **Solusi**: Wajib mengambil model tabel terlebih dahulu dengan cara aman:
     ```java
     DefaultTableModel model = (DefaultTableModel) jTableX.getModel();
     model.setRowCount(0); // Membersihkan tabel dengan aman
     ```

2. **Kesalahan Penanganan Komponen Non-Text (`JDateChooser`)**
   - **Penyebab**: Menggunakan `.setText("")` pada objek seperti *date picker* atau tabel yang dapat memicu *crash* saat dikompilasi.
   - **Solusi**: Untuk mengosongkan *JDateChooser*, Anda harus menggunakan perintah `setDate(null)`.

3. **Field Berstatus *Read-Only* Gagal Direset (Logika Validasi)**
   - **Penyebab**: Terkadang mengosongkan *field* yang sudah di set `setEditable(false)` akan memicu kesalahan pada beberapa *listener* turunan.
   - **Solusi**: Perintah `setText("")` tetap berfungsi pada *read-only field*. Pastikan saja setelah memanggilnya, Anda tidak mencoba menulis ke *field* itu lagi, melainkan berikan fokus ke kolom yang *editable* dengan metode `.requestFocus()`.

4. **Tumpang Tindih Action Listener (Duplikasi Event)**
   - **Penyebab**: Terlalu sering menekan "Double Click" saat mendesain UI di *NetBeans/GUI Builder* yang secara tidak sengaja membuat dua buah deklarasi fungsi `actionPerformed` untuk satu tombol.
   - **Solusi**: Lakukan pengecekan pada kode *Source*. Pastikan satu tombol hanya terhubung pada satu aksi penanganan (*event handler*) yang berisi kumpulan perintah *clear data*.
