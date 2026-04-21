# 📝 Flutter Modern Note App

Aplikasi manajemen catatan (Note App) modern yang dibangun menggunakan framework Flutter. Proyek ini mengimplementasikan pemisahan *logic* berskala industri dengan **Clean Architecture**, **State Management BLoC**, dan integrasi **Supabase** sebagai *Backend-as-a-Service* (BaaS).

Proyek ini dikembangkan sebagai bagian dari pemenuhan tugas *Hands-on Practice* mata kuliah Workshop Pemrograman Perangkat Bergerak (Semester 4).

## ✨ Fitur Utama

- **Arsitektur Modular:** Pemisahan fitur menggunakan pendekatan *multi-package* (`note` dan `core_services`) untuk kemudahan skalabilitas.
- **Clean Architecture:** Struktur kode terbagi dengan rapi menjadi 3 lapisan utama:
  - `Domain Layer`: Berisi *Entities*, *Abstract Repositories*, dan *Use Cases* yang independen.
  - `Data Layer`: Berisi *Models*, *Remote Data Sources*, dan implementasi *Repository* untuk berkomunikasi dengan API.
  - `Presentation Layer`: Berisi UI (*Pages*) dan *State Management* (BLoC).
- **State Management:** Menggunakan `flutter_bloc` untuk memisahkan logika bisnis dari antarmuka pengguna.
- **Backend Integrasi:** Melakukan operasi CRUD (Create, Read, Update, Delete) secara langsung ke database *cloud* menggunakan **Supabase**.

## 🛠️ Teknologi yang Digunakan

- [Flutter](https://flutter.dev/) - UI Toolkit
- [Dart](https://dart.dev/) - Bahasa Pemrograman
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) & [equatable](https://pub.dev/packages/equatable) - State Management
- [supabase_flutter](https://pub.dev/packages/supabase_flutter) - Database & API
