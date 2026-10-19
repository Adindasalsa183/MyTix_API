<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MyTixApiController
{
    /**
     * Endpoint Registrasi Pengguna MyTix (Simpan ke MySQL / phpMyAdmin)
     * Method: POST /api/register
     */
    public function register(Request $request)
    {
        $nama = $request->input('nama_lengkap');
        $phone = $request->input('nomor_hp');

        if (empty($nama) || empty($phone)) {
            return response()->json([
                'status' => 'error',
                'message' => 'Nama lengkap dan nomor handphone wajib diisi!'
            ], 400);
        }

        // Format nomor HP agar diawali +62 jika belum ada
        if (strpos($phone, '0') === 0) {
            $phone = '+62' . substr($phone, 1);
        } elseif (strpos($phone, '+62') !== 0) {
            $phone = '+62' . $phone;
        }

        try {
            // Simpan data pendaftaran ke tabel users di phpMyAdmin
            $userId = DB::table('users')->insertGetId([
                'nama_lengkap' => $nama,
                'nomor_hp'     => $phone,
                'created_at'   => now(),
                'updated_at'   => now(),
            ]);

            return response()->json([
                'status'  => 'success',
                'message' => 'Pendaftaran akun MyTix berhasil disimpan ke phpMyAdmin!',
                'data'    => [
                    'user_id'      => $userId,
                    'nama_lengkap' => $nama,
                    'nomor_hp'     => $phone,
                    'created_at'   => now()->toDateTimeString(),
                ]
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Gagal menyimpan ke database: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Endpoint Daftar Film (Sedang Tayang & Filter Bioskop)
     * Method: GET /api/movies?cinema=XXI
     */
    public function getMovies(Request $request)
    {
        $cinema = $request->query('cinema', 'Semua');

        $allMovies = [
            [
                'id'          => 1,
                'title'       => 'KUASA GELAP',
                'poster'      => 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=500',
                'rating'      => 'D17+',
                'genre'       => 'Horror',
                'duration'    => '96 Menit',
                'cinemas'     => ['XXI', 'CGV', 'Cinépolis'],
                'is_upcoming' => false,
            ],
            [
                'id'          => 2,
                'title'       => 'STREET FIGHTER',
                'poster'      => 'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?q=80&w=500',
                'rating'      => 'R13+',
                'genre'       => 'Action / Sci-Fi',
                'duration'    => '115 Menit',
                'cinemas'     => ['XXI', 'CGV'],
                'is_upcoming' => false,
            ],
            [
                'id'          => 3,
                'title'       => 'THE BUSTER',
                'poster'      => 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=500',
                'rating'      => 'SU',
                'genre'       => 'Animation / Comedy',
                'duration'    => '90 Menit',
                'cinemas'     => ['CGV', 'Cinépolis'],
                'is_upcoming' => false,
            ],
        ];

        if ($cinema !== 'Semua' && $cinema !== 'Semua Film') {
            $filteredMovies = array_values(array_filter($allMovies, function ($movie) use ($cinema) {
                return in_array($cinema, $movie['cinemas']);
            }));
        } else {
            $filteredMovies = $allMovies;
        }

        return response()->json([
            'status' => 'success',
            'city'   => 'SURABAYA',
            'data'   => $filteredMovies
        ], 200);
    }

    /**
     * Endpoint Banner Promo MyTix
     * Method: GET /api/promos
     */
    public function getPromos()
    {
        return response()->json([
            'status' => 'success',
            'data'   => [
                [
                    'id'          => 1,
                    'title'       => 'Beli tiket bioskop sekaligus event lebih hemat di MyTix',
                    'subtitle'    => 'Cashback s.d 10rb + Extra Cashback 20rb OVO Points',
                    'promo_code'  => 'MYTIXOVO',
                ],
            ]
        ], 200);
    }
}