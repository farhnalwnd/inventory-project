# Issue: Fix "Proceed to Bill" Button Unresponsiveness

## Target
**Search Product / Cart Panel** (Khususnya fungsionalitas tombol **PROCEED TO BILL**).

## Tasks

### 1. Database & Data Integrity Check
- Perhatikan struktur tabel `cart`, `billmain`, dan `addproduct` pada database PostgreSQL.
- Sebelum melakukan perbaikan kode, pastikan logika query (Insert, Update, Delete) aman dan tidak menyebabkan kehilangan data stok maupun riwayat belanja.

### 2. Identifikasi & Perbaikan Error Tombol
- Saat ini tombol **PROCEED TO BILL** tidak merespons saat ditekan.
- Telusuri fungsi *action listener* milik tombol tersebut (kemungkinan `jButton23ActionPerformed` atau sejenisnya di `Mainpage.java`).
- Temukan akar masalah mengapa tombol tidak merespons (misalnya: error karena *row* tabel tidak terpilih, masalah konversi tipe data, atau *Exception* SQL yang tersembunyi).
- Lakukan perbaikan (*bug fix*) pada baris kode yang bermasalah agar tombol dapat berjalan kembali dengan normal.

## Expected Result
- Tombol **PROCEED TO BILL** kembali berfungsi normal saat ditekan.
- Seluruh rangkaian aksi (pembuatan invoice, pencatatan ke `billmain`, pengurangan stok di `addproduct`, dan pembersihan keranjang di `cart`) berhasil dieksekusi tanpa error.
- Aplikasi berhasil memunculkan pesan sukses dan melanjutkan alur ke halaman pencetakan nota.
