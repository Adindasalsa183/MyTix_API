# MyTix API

Backend REST API untuk aplikasi pemesanan tiket bioskop **MyTix** (Flutter).

**Aplikasi Asli:** TIX ID
**Nama Plesetan:** MyTix

**Kelas:** S1 Sistem Informasi 2024F, Kelompok 2

## Anggota Kelompok

| No | Nama | NIM |
|----|------|-----|
| 1 | Fariha Zain | 24051214192 |
| 2 | Adinda Salsabila Putri | 24051214183 |
| 3 | Rifa Tabina Trinita | 24051214199 |
| 4 | M. Affan Malakaini | 24051214177 |

## Teknologi

- **Bahasa:** PHP (endpoint berupa file `.php` langsung, memakai `mysqli`)
- **Database:** MySQL, nama database `mytix_db`
- **Web server lokal:** Laragon atau XAMPP (Apache + MySQL)
- **Aplikasi klien:** [MyTix_App](https://github.com/Adindasalsa183/MyTix_App) (Flutter)

## Daftar Endpoint

Semua endpoint berada di `http://localhost/mytix_api/`.

| File | Fungsi |
|------|--------|
| `register.php` | Registrasi pengguna (nama lengkap dan nomor HP) |
| `get_profile.php` | Mengambil profil pengguna |
| `get_user_tickets.php` | Mengambil riwayat tiket pengguna |
| `save_transaction.php` | Menyimpan transaksi tiket film |
| `save_food_order.php` | Menyimpan pesanan makanan (TIX Food) |
| `save_event_order.php` | Menyimpan pesanan tiket event (TIX Event) |
| `save_movie_rental.php` | Menyimpan sewa film |

## Cara Menjalankan Proyek

### Prasyarat

- [Laragon](https://laragon.org/) atau [XAMPP](https://www.apachefriends.org/)
- Git

### 1. Jalankan Web Server Lokal

Buka **Laragon** atau **XAMPP**, lalu jalankan layanan **Apache** dan **MySQL**.

### 2. Import Database

1. Buka phpMyAdmin di `http://localhost/phpmyadmin`.
2. Buat database baru bernama `mytix_db`.
3. Pilih tab **Import**, pilih file `mytix_db.sql` dari repositori ini, lalu klik **Go / Import**.
4. Pastikan tabel berikut berhasil dibuat: `users`, `transactions`, `tix_food_orders`, `tix_event_orders`, `movie_rentals`.

### 3. Pasang API

1. Clone repositori ini:
```bash
   git clone https://github.com/Adindasalsa183/MyTix_API.git
```
2. Salin folder hasil clone ke direktori web server dengan nama **`mytix_api`**:
   - XAMPP: `C:\xampp\htdocs\mytix_api`
   - Laragon: `C:\laragon\www\mytix_api`
3. Koneksi database di setiap file PHP memakai pengaturan default:
```php
   new mysqli("localhost", "root", "", "mytix_db");
```
   Kalau MySQL kamu memakai password, ubah baris tersebut di tiap file `.php`.

### 4. Tes API

Buka di browser, hasilnya harus berupa JSON:

```
http://localhost/mytix_api/get_profile.php
```

### 5. Jalankan Aplikasi Flutter

Setelah API aktif, ikuti panduan di repositori
[MyTix_App](https://github.com/Adindasalsa183/MyTix_App) untuk menjalankan aplikasinya.

| Platform Flutter | Alamat API yang dipakai |
|------------------|-------------------------|
| Web / Windows / iOS | `http://localhost/mytix_api` |
| Android Emulator | `http://10.0.2.2/mytix_api` |

> Untuk HP fisik, ganti alamat dengan IP laptop kamu (contoh `http://192.168.1.10/mytix_api`)
> dan pastikan HP dan laptop terhubung ke Wi-Fi yang sama.

## Troubleshooting

- **Koneksi database gagal:** pastikan MySQL sudah berjalan dan nama database persis `mytix_db`.
- **404 Not Found:** pastikan nama folder persis `mytix_api` dan berada di `htdocs` / `www`.
- **Aplikasi Android tidak bisa konek:** gunakan `10.0.2.2` (emulator), bukan `localhost`.