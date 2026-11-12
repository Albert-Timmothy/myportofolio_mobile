# MyPortfolio Mobile

Nama: Albert Timmothy Ariajaya  
NPM: 2506656381  
Kelas: PBP F

## Tentang proyek

Aplikasi ini adalah versi mobile dari portofolio saya untuk mata kuliah Pemrograman Berbasis Platform. 


## Menjalankan aplikasi

Gunakan Flutter stable dengan Dart yang memenuhi `sdk: ^3.13.7` pada `pubspec.yaml`. Pengembangan awal menggunakan Flutter 3.47.9 dan Dart 3.13.7. Pastikan folder `flutter/bin` sudah ada di PATH dan Chrome tersedia.

```sh
git clone https://github.com/Albert-Timmothy/myportofolio_mobile.git
cd myportofolio_mobile
flutter pub get
flutter doctor
flutter run -d chrome
```

Untuk Android, siapkan Android SDK dan emulator atau perangkat fisik terlebih dahulu. Lihat perangkat yang tersedia lewat `flutter devices`, lalu jalankan `flutter run -d <device-id>`. Pengujian proyek ini berfokus pada web dan widget test; kesiapan Android perlu diperiksa terpisah dengan `flutter doctor`.

## Struktur dan pemeriksaan

| Berkas | Isi |
| --- | --- |
| `lib/main.dart` | Entry point, `MyApp`, dan tema aplikasi. |
| `lib/menu.dart` | Halaman `MyHomePage`, `InfoCard`, model `ItemHomepage`, dan `ItemCard`. |
| `test/widget_test.dart` | Pemeriksaan identitas, pesan tiap tombol, warna berbeda, dan layout layar kecil. |
| `docs/ai-log.md` | Catatan prompt serta bagian yang dibantu AI. |

```sh
dart format lib test
flutter analyze
flutter test
```

Untuk mencoba secara manual, tekan masing-masing kartu dan periksa pesan yang muncul. Perkecil jendela Chrome untuk mengecek nama lengkap serta menu tetap terbaca. Halaman dapat digulir jika tinggi layar tidak cukup.

### Tugas 7

1. **Widget tree dan hubungan parent-child**

   Menurut saya, widget tree adalah susunan widget yang membentuk tampilan aplikasi secara bertingkat. Widget parent membungkus atau menyusun widget child lewat properti seperti `child`, `children`, `home`, dan `body`. Di aplikasi saya, alurnya dimulai dari `MyApp`, lalu `MaterialApp`, `MyHomePage`, dan `Scaffold`. Bagian body berisi `SingleChildScrollView`, kemudian `Column` yang menyusun baris identitas dan grid menu. Parent memberikan batas ukuran kepada child, lalu child menentukan ukuran yang sesuai dan parent menempatkannya. Jadi, posisi widget di dalam tree memengaruhi layout dan data dari ancestor yang bisa diakses.

2. **Widget yang saya gunakan**

   Berikut semua jenis widget yang secara eksplisit dipakai dalam kode aplikasi saya:

   | Widget | Fungsi dalam proyek |
   | --- | --- |
   | `MyApp` | Widget buatan saya untuk mengembalikan konfigurasi aplikasi. |
   | `MaterialApp` | Menyediakan konfigurasi aplikasi Material, tema, dan halaman awal. |
   | `MyHomePage` | Menyusun halaman utama portofolio tanpa state lokal yang berubah. |
   | `Scaffold` | Kerangka halaman dengan AppBar dan body. |
   | `AppBar` | Menampilkan judul MyPortfolio di atas halaman. |
   | `SingleChildScrollView` | Membuat halaman bisa digulir saat kontennya melebihi tinggi layar. |
   | `Column` | Menyusun elemen secara vertikal, termasuk isi kartu. |
   | `Row` | Menyusun tiga kartu identitas secara horizontal. |
   | `Expanded` | Membagi lebar baris untuk masing-masing kartu identitas. |
   | `InfoCard` | Widget reusable untuk pasangan label dan isi identitas. |
   | `Card` | Permukaan kartu identitas dengan elevasi. |
   | `Padding` | Memberi jarak di sekeliling konten. |
   | `Text` | Menampilkan judul, identitas, nama menu, dan pesan. |
   | `SizedBox` | Memberi jarak antara label dan isi atau ikon dan teks. |
   | `GridView.count` | Menyusun kartu aksi dalam tiga kolom. |
   | `ItemCard` | Widget reusable yang menampilkan dan menangani klik satu menu. |
   | `Material` | Memberi warna, bentuk, dan permukaan efek tinta pada kartu aksi. |
   | `InkWell` | Menangani tap dan menampilkan efek sentuhan. |
   | `Icon` | Menampilkan simbol folder, tambah, dan logout. |
   | `SnackBar` | Menampilkan pesan sementara setelah menu ditekan. |

   `StatelessWidget` adalah kelas dasar widget buatan saya. `Theme` dan `ScaffoldMessenger` diakses melalui `of(context)` untuk mengambil tema dan menampilkan SnackBar dari ancestor yang disediakan aplikasi. `ItemHomepage` sendiri adalah model data, bukan widget. `ThemeData`, `ColorScheme`, `TextStyle`, dan `EdgeInsets` juga merupakan objek konfigurasi, bukan widget tampilan.

3. **Fungsi MaterialApp**

   `MaterialApp` menyatukan konfigurasi yang umum diperlukan aplikasi Material Design, seperti tema, halaman awal, dan navigasi. Pada proyek saya, `title` memberi judul aplikasi, `theme` mengatur warna indigo, dan `home` menunjuk ke `MyHomePage`. Widget ini biasanya ditempatkan dekat akar supaya konfigurasi tersebut dapat dipakai oleh seluruh halaman di bawahnya. Secara tepat, widget yang saya kirim ke `runApp` adalah `MyApp`, kemudian `MyApp` mengembalikan `MaterialApp`. Jadi bukan berarti setiap aplikasi Flutter wajib memiliki `MaterialApp`; ini pilihan yang cocok untuk tampilan Material yang saya gunakan. [Referensi MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html).

4. **StatelessWidget dan StatefulWidget**

   `StatelessWidget` tidak mempunyai objek `State` untuk menyimpan perubahan lokal. Tampilan dibentuk dari konfigurasi widget dan data yang tersedia saat `build` dipanggil. Widget ini tetap bisa dibangun ulang, misalnya ketika parent memberi konfigurasi baru atau tema berubah. Saya memilihnya untuk `MyHomePage`, `InfoCard`, dan `ItemCard` karena data halaman saat ini tetap.

   `StatefulWidget` memiliki objek `State` yang bertahan sepanjang lifecycle terkait. Ketika nilai di dalam state berubah, `setState` dapat meminta framework membangun ulang tampilan. Contohnya adalah penghitung, status checkbox, atau data form yang perlu diperbarui ketika pengguna berinteraksi. Menekan kartu pada aplikasi saya hanya meminta `ScaffoldMessenger` menampilkan SnackBar, sehingga kartu tidak perlu menyimpan state sendiri. Jadi, adanya tombol tidak otomatis membuat sebuah widget harus stateful.

5. **BuildContext**

   `BuildContext` adalah pegangan ke posisi suatu widget di dalam widget tree. Pada `build(BuildContext context)`, saya menggunakannya untuk mencari layanan atau konfigurasi dari ancestor. Contohnya, `Theme.of(context)` mengambil tema terdekat untuk AppBar, sedangkan `ScaffoldMessenger.of(context)` mencari pengelola SnackBar ketika menu ditekan. Posisi context penting: context milik parent tidak bisa dipakai untuk mencari ancestor yang sebenarnya baru dibuat sebagai child di bawahnya. Jika membutuhkan context di bawah widget tertentu, kita bisa memakai `Builder` atau memisahkan widget. Context juga tidak sebaiknya disimpan sembarangan; setelah operasi asynchronous, periksa `context.mounted` sebelum memakainya kembali. [Referensi BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html).

6. **Hot reload, hot restart, dan full restart**

   Hot reload memasukkan perubahan kode dan membangun ulang widget tree sambil mempertahankan state aplikasi. Ini cocok ketika saya mengubah teks, warna, atau layout dan ingin langsung melihat hasilnya. Hot reload tidak menjalankan ulang `main()` maupun `initState()`.

   Hot restart memulai ulang aplikasi Flutter dan menghapus state yang sedang tersimpan. Saya memakainya ketika perlu menjalankan ulang inisialisasi, mengubah nilai awal yang masih tertahan dalam state, atau melakukan perubahan struktur yang tidak dapat diterapkan hot reload. Contohnya, perubahan antara enum dan class atau perubahan deklarasi parameter generic dapat memerlukan restart.

   Full restart menghentikan dan menjalankan aplikasi kembali, termasuk membangun ulang bagian platform bila diperlukan. Perubahan kode native Kotlin, Java, Swift, atau Objective-C memerlukan full restart. Pada terminal `flutter run`, `r` digunakan untuk hot reload dan `R` untuk hot restart. Jika ada error kompilasi, kodenya tetap harus diperbaiki; restart bukan pengganti perbaikan error. [Referensi hot reload](https://docs.flutter.dev/tools/hot-reload).

## AI Disclosure

Saya menggunakan ChatGPT/Codex untuk membantu membaca tugas, mengecek proyek Tutorial 08, mengubah kode, membuat widget test. Strategi prompting saya bertahap: meminta pengecekan progres, mengikuti panduan instalasi, meminta untuk mengjarkan dan memandu mengerjakan tugas.

