# Course Explorer v2 - Pertemuan 6
Praktikum Pemrograman Mobile: State Management & Application Architecture

- **Nama Mahasiswa:** I Ketut Bagus Brihaspati
- **NIM:** 2415051090
- **Kelas:** PTI 5A
- **Program Studi:** Pendidikan Teknik Informatika, Undiksha

---

## 🏛️ Arsitektur Aplikasi & Tanggung Jawab Folder

Aplikasi Course Explorer v2 dibangun mengikuti prinsip *Separation of Concerns* (SoC) dengan arah ketergantungan satu arah:
`Screen/Widget` ➔ `Provider` ➔ `Repository` ➔ `Service/Data Source`

1. **`lib/models/` (`course.dart`)**
   - Mendefinisikan struktur data entitas (tipe data kuat/type-safe).
   - Memusatkan konversi dan serialisasi data (`fromJson` dan `toJson`).

2. **`lib/services/` (`course_service.dart`)**
   - Menangani detail teknis data source (membaca file JSON asset via `rootBundle.loadString` dan deserialisasi `jsonDecode`).
   - Bebas dari ketergantungan UI/Widget.

3. **`lib/repositories/` (`course_repository.dart`)**
   - Berperan sebagai lapisan abstraksi antara *business logic* dan *data source*.
   - Menyediakan API data yang bersih bagi Provider sehingga sumber data dapat diganti di kemudian hari tanpa merombak state atau UI.

4. **`lib/providers/` (`course_provider.dart`)**
   - Mengelola *application state* dan *async lifecycle* (`loading`, `success`, `error`).
   - Menyediakan *single source of truth* untuk data katalog dan daftar favorit lintas screen.
   - Menggunakan `notifyListeners()` untuk memberi tahu perubahan data kepada widget listener tanpa menyimpan `BuildContext`.

5. **`lib/screens/`**
   - Berisi tampilan halaman utama (`HomePage`, `CoursesPage`, `FavoritesPage`, `ProfileFeedbackPage`, `DebuggingLabPage`).
   - Bertanggung jawab murni pada presentasi visual dan merespons interaksi pengguna dengan mengonsumsi state dari Provider.

6. **`lib/widgets/`**
   - Berisi komponen antarmuka modular yang dapat digunakan kembali (*reusable components*), seperti `CourseCardWidget` dan `StudentHeaderCard`.

---

## 🌐 Dokumentasi Integrasi REST API (Pertemuan 7)

- **Endpoint URL:** `https://jsonplaceholder.typicode.com/posts`
- **HTTP Method:** `GET`
- **Status Code:** `200 OK`
- **Resource Representation:** `Course / Post Resource`
- **Field JSON Utama:**
  1. `id` (integer) - Identifier unik resource
  2. `code` (string) - Kode identifikasi mata kuliah
  3. `title` (string) - Judul / nama mata kuliah
  4. `credits` (integer) - Bobot satuan kredit semester (SKS)
  5. `status` (string) - Status ketercapaian (`active` / `done` / `planned`)