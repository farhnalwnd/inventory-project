# Proses Bisnis Fitur Search Product & Billing

File ini menjelaskan alur kerja dan proses bisnis dari fitur **Search Product** hingga proses pembayaran (**Billing**) pada aplikasi Inventory Management System.

## 1. Alur Pencarian dan Tambah ke Keranjang (Search Product)
Fitur ini digunakan oleh kasir atau admin untuk mencari barang dan menambahkannya ke keranjang belanja sementara sebelum pelanggan melakukan pembayaran.

*   **Pencarian**: Pengguna mencari barang menggunakan **Item ID**. Hasilnya akan muncul di tabel pencarian.
*   **Auto-fill**: Saat baris barang diklik, detail barang (Nama, Harga) akan otomatis terisi ke form input. Field ini sengaja dikunci (*read-only*) agar harga dan nama tidak dimanipulasi.
*   **Input Quantity**: Pengguna memasukkan jumlah barang yang ingin dibeli. Sistem akan memvalidasi apakah jumlah tersebut tersedia di gudang (tabel `addproduct`).
*   **Add to Cart**: Jika validasi berhasil, sistem akan menghitung *Total Price* dan menyimpan data barang tersebut ke dalam tabel sementara yaitu `cart`.

## 2. Alur Pembayaran (View Cart & Proceed to Bill)
Setelah barang terkumpul di keranjang, pengguna menekan tombol **VIEW CART** untuk berpindah ke halaman keranjang/kasir.

### Apa fungsi dari "PROCEED TO BILL"?
Tombol **PROCEED TO BILL** adalah eksekusi inti dari transaksi penjualan. Tombol ini memiliki peran penting untuk menyelesaikan pembelian atas barang yang ada di keranjang. 

Berikut adalah proses bisnis yang terjadi di belakang layar ketika tombol ini ditekan:

1.  **Pembuatan Nomor Tagihan (Invoice Generation)**:
    Sistem secara otomatis membuat *Bill Number* secara acak (random) dan mengambil tanggal hari ini (*Current Date*) sebagai penanda waktu transaksi.
2.  **Pencatatan Transaksi Penjualan**:
    Data barang yang dipilih dari keranjang, beserta Nomor Tagihan dan Tanggal, dipindahkan dan disimpan secara permanen ke dalam tabel `billmain`. Tabel ini berfungsi sebagai riwayat utama penjualan (Buku Besar Penjualan).
3.  **Pengurangan Stok Gudang (Inventory Deduction)**:
    Sistem akan mengecek kembali jumlah stok barang saat ini di gudang (tabel `addproduct`), kemudian menguranginya secara otomatis sesuai dengan jumlah (*quantity*) yang baru saja dibeli. Hal ini memastikan stok gudang selalu sinkron secara *real-time*.
4.  **Pembersihan Keranjang**:
    Barang yang sudah berhasil dibayar dan diproses akan dihapus dari tabel sementara (`cart`), sehingga keranjang kembali kosong untuk item tersebut.
5.  **Cetak Struk/Nota**:
    Setelah seluruh proses database berhasil, sistem akan mengarahkan layar ke tab/halaman **Invoice Print** di mana struk pembayaran siap untuk dicetak dan diberikan kepada pelanggan.

---
**Hal Penting yang Harus Diketahui Developer:**
*   Proses *Proceed to Bill* saat ini memproses satu baris item yang *di-select* pada tabel keranjang (`jTable5`). Pastikan untuk menangani logika jika keranjang memiliki banyak item secara bersamaan (misalnya menggunakan iterasi (loop) pada seluruh baris tabel jika ingin melakukan *checkout* sekaligus).
*   Integritas data sangat penting di sini: pastikan query `UPDATE` stok dan `DELETE` cart berada dalam mekanisme yang aman agar tidak terjadi selisih stok jika salah satu query gagal.
