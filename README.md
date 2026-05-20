# BharataWayang

[![Flutter Version](https://img.shields.io/badge/Flutter-%3E%3D3.19.0-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-%3E%3D3.3.0-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Windows-lightgrey)](#)
[![License](https://img.shields.io/badge/License-MIT-green)](#)

**BharataWayang** adalah aplikasi edukasi dan eksplorasi budaya digital interaktif yang dirancang untuk memperkenalkan warisan budaya Wayang serta kisah epik Mahabharata kepada generasi muda. Dengan pendekatan visual premium bernuansa tradisional-modern serta adanya fitur gamifikasi, aplikasi ini menghadirkan pengalaman belajar budaya nusantara yang interaktif, edukatif, dan menyenangkan bagi pengguna.

---

## Fitur Utama

Aplikasi **BharataWayang** menawarkan berbagai fitur interaktif untuk mendalami seni pewayangan secara komprehensif:

### 1. Simulasi Dalang Digital
*   **Pengalaman Interaktif**: Fitur simulasi yang menempatkan pengguna sebagai dalang pertunjukan.

### 2. Mustika Wayang (Koleksi & Ensiklopedia Tokoh)
*   **Sistem Koleksi Terkunci (Locked/Unlocked)**: Desain kartu premium bertema emas dengan status dinamis. Tokoh yang belum terbuka akan tampil sebagai siluet misterius, memicu rasa penasaran pengguna untuk membukanya melalui progres membaca cerita.
*   **Halaman Profil Tokoh**: Menyajikan visualisasi tokoh wayang dengan detail biografi, senjata pusaka, silsilah keluarga, kesaktian, serta nilai-nilai moral dari tokoh ksatria (seperti Arjuna, Werkudara, Sri Kresna, dll.).

### 3. Serat Mahabharata (Membaca Parwa)
*   **Navigasi 5 Parwa Utama**: Cerita berseri dari Adi Parwa, Sabha Parwa, Wana Parwa, Wirata Parwa, hingga perang kolosal Bharatayuda.
*   **Sistem Progres Membaca**: Melacak babak cerita yang sudah selesai dibaca dan secara otomatis membuka babak baru di setiap parwa berikutnya.

### 4. Kuis Interaktif (Leveling Dalang)
*   **5 Tingkat Kesulitan**: Tantangan pengetahuan pewayangan berjenjang dari level **Dalang Pemula**, **Dalang Dasar**, **Dalang Handal**, **Dalang Mahir**, hingga tingkat tertinggi **Dalang Maestro**.
*   **Skor Tertinggi & Live Reload**: Mencatat skor terbaik di database lokal dan memperbarui tampilan kartu kuis secara real-time dengan status "SELESAI" dan opsi "COBA LAGI" setelah kuis diselesaikan.

### 5. Kawruh Pewayangan (Edukasi 5 Materi Dasar)
*   **Pengertian Wayang**: Memahami definisi dan hakikat Wayang Kulit sebagai media pertunjukan bayangan yang sarat akan tuntunan dan tontonan hidup.
*   **Sejarah Wayang**: Menelusuri jejak asal-usul sejarah, perkembangan, serta proses akulturasi seni pewayangan di Indonesia dari masa ke masa.
*   **Jenis-Jenis Wayang**: Membahas ragam klasifikasi seni wayang di nusantara seperti Wayang Purwa, Wayang Gedog, Wayang Klitik, Wayang Golek, Wayang Beber, Wayang Wahyu, dan lainnya.
*   **Unsur Pertunjukan**: Mengupas tuntas elemen penting pementasan wayang kulit, termasuk Blencong, Kelir, Cempala, Kotak Wayang, dan musik Gamelan pengiring.
*   **Mengapa Mahabharata**: Menganalisis alasan mengapa kisah epik kepahlawanan Mahabharata diangkat menjadi inti lakon lakon pewayangan di Indonesia.

### 6. Pengelolaan Profil Pengguna
*   **Sistem Otentikasi**: Log masuk dan registrasi keanggotaan menggunakan alamat email secara aman dengan enkripsi password SHA-256.
*   **Ubah Profil Tradisional**: Mengedit identitas nama lengkap, bio ksatria pribadi, serta mengganti foto profil dengan mengambil berkas gambar langsung melalui sistem File Manager perangkat.

---

## 🚀 Arsitektur & Teknologi Stack

*   **Framework**: [Flutter](https://flutter.dev) (Dart)
*   **State Management**: [Provider](https://pub.dev/packages/provider) (Arsitektur bersih dan responsif)
*   **Database Lokal**: [SQLite](https://pub.dev/packages/sqflite) (Merekam progres membaca serat, status koleksi mustika, progres akun pengguna, dan nilai tertinggi kuis)
*   **Kriptografi**: [Crypto](https://pub.dev/packages/crypto) (Hashing password menggunakan SHA-256)

---

## 👥 Developer
*   **Muhana Perdana Putra - Politeknik Negeri Media Kreatif - Teknologi Rekayasa Multimedia**
