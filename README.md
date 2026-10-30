# Course Explorer v2 - Integrasi REST API & Supabase

**Identitas Mahasiswa:**
* **Nama:** I Ketut Bagus Brihaspati
* **NIM:** 2415051090
* **Program Studi:** Pendidikan Teknik Informatika (PTI)
* **Mata Kuliah:** Pemrograman Mobile (Pertemuan 7)

---

## 📖 Deskripsi Aplikasi
Aplikasi *Course Explorer v2* (Course Data Manager) merupakan aplikasi katalog mata kuliah multiplatform berbasis Flutter yang mendukung pengelolaan data secara penuh (CRUD: Create, Read, Update, Delete). Aplikasi ini menerapkan pemisahan arsitektur clean code (*Repository Pattern*) dan manajemen state menggunakan *Provider*, serta mendukung dua sumber data backend yang dapat dialihkan (*switchable*): publik REST API dan database PostgreSQL Supabase.

---

## 🏗️ Arsitektur & Teknologi
Aplikasi ini dibangun menggunakan prinsip *Separation of Concerns*:
* **Presentation Layer (UI/Screens):** Mengonsumsi state dari provider tanpa melakukan pemanggilan query HTTP/database secara langsung. Mendukung tata letak responsif (*NavigationRail* / *NavigationBar*).
* **State Management:** Provider (`CourseProvider`) yang mengelola siklus data, caching lokal, status loading/error, dan sinkronisasi daftar favorit.
* **Repository Pattern:** `CourseRepository` yang bergantung pada abstraksi kontrak `CourseDataSource`.
* **Data Sources:** 
  * `CourseApiService`: Integrasi RESTful API eksternal.
  * `CourseSupabaseService`: Integrasi langsung ke database PostgreSQL Supabase dengan Row Level Security (RLS).

---

## 🗄️ Backend Database (Supabase)
* **Platform:** Supabase (PostgreSQL Database & Realtime Client).
* **Tabel:** `public.courses` (kolom: `id`, `code`, `title`, `credits`, `description`, `status`, `created_at`).
* **Keamanan:** Row Level Security (RLS) diaktifkan dengan kebijakan izin akses lab permisif untuk client anon/authenticated.

---

## 🚀 Cara Menjalankan Aplikasi
1. Pastikan Flutter SDK telah terpasang di sistem.
2. Clone repository ini:
   ```bash
   git clone [https://github.com/bagusbrihaspati/praktikum_5_course_explorer.git](https://github.com/bagusbrihaspati/praktikum_5_course_explorer.git)
   cd praktikum_5_course_explorer