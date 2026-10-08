<div align="center">

# DEAFSAPP

**Aplikasi pendamping belajar Bahasa Isyarat Indonesia (BISINDO) berbasis Flutter yang aksesibel**

![Status](https://img.shields.io/badge/status-prototipe%20V1-orange)
![Flutter](https://img.shields.io/badge/Flutter-Mobile-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-Language-0175C2?logo=dart&logoColor=white)
![State](https://img.shields.io/badge/State%20management-GetX-8A2BE2)
![Platforms](https://img.shields.io/badge/Target-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey)

[English](README.md) | Bahasa Indonesia

</div>

---

## Daftar Isi

1. [Gambaran Umum](#gambaran-umum)
2. [Latar Belakang dan Dampak](#latar-belakang-dan-dampak)
3. [Cakupan Repositori Ini](#cakupan-repositori-ini)
4. [Fitur](#fitur)
5. [Arsitektur](#arsitektur)
6. [Teknologi](#teknologi)
7. [Struktur Proyek](#struktur-proyek)
8. [Memulai](#memulai)
9. [Rencana Pengembangan](#rencana-pengembangan)
10. [Keterbatasan Saat Ini](#keterbatasan-saat-ini)
11. [Ucapan Terima Kasih](#ucapan-terima-kasih)
12. [Penulis](#penulis)

---

## Gambaran Umum

DEAFSAPP adalah aplikasi mobile yang dirancang untuk mengurangi hambatan komunikasi antara komunitas Tuli dan komunitas dengar di Indonesia. Aplikasi ini menargetkan **BISINDO** (Bahasa Isyarat Indonesia), bahasa isyarat yang paling banyak digunakan komunitas Tuli di Indonesia, dengan tiga gagasan utama:

- **Belajar**: materi interaktif dan kuis untuk siswa dan guru.
- **Pengenalan**: menerjemahkan gerakan isyarat menjadi teks dan suara.
- **Visualisasi**: menampilkan isyarat melalui Augmented Reality (AR) dan media bergaya hologram.

Repositori ini (**DEAFSAPP-V1**) berisi versi pertama aplikasi: kerangka aplikasi Flutter, navigasi, onboarding, modul speech-to-text, dan modul kuis.

---

## Latar Belakang dan Dampak

DEAFSAPP berawal dari proyek skripsi Sistem Informasi di **Universitas Muhammadiyah Sumatera Utara (UMSU)** dan dikembangkan bersama **SLB Melati Aisyah** (sekolah luar biasa di Medan) sebagai program pengabdian masyarakat.

Hasil yang dilaporkan untuk sistem pada tahap skripsi:

| Metrik | Hasil |
|---|---|
| Urutan isyarat dinamis BISINDO yang dikenali | **26** |
| Akurasi pengenalan gestur | **76,1%** |
| Skor usability positif | **76,5%** |
| Peserta uji lapangan | **17 siswa dan 8 guru** |
| Penghargaan | Finalis Nasional Lomba Inovasi Digital Mahasiswa (LIDM) 2023 |
| Penghargaan | Program riset skripsi berbiaya penuh di Universitas Pendidikan Indonesia (UPI), Bandung |
| Kekayaan intelektual | Hak Cipta terdaftar, No. EC00202341333, DJKI, 2023 |

> Hasil di atas menggambarkan sistem tahap skripsi secara keseluruhan. Model machine learning dan pipeline AR lengkapnya **tidak termasuk dalam snapshot repositori ini**. Lihat [Cakupan Repositori Ini](#cakupan-repositori-ini).

---

## Cakupan Repositori Ini

Agar ekspektasi jelas, berikut isi repositori ini.

| Area | Status di repositori ini |
|---|---|
| Kerangka aplikasi, routing, dependency injection (GetX) | Sudah ada |
| Onboarding dan form sign-in beranimasi (Rive) | Sudah ada (hanya UI, tanpa autentikasi backend) |
| Navigasi bawah beranimasi (Rive) | Sudah ada |
| Layar Speech-to-Text (transkrip langsung dari mikrofon) | Sudah ada |
| Modul kuis (timer, skor, umpan balik jawaban) | Sudah ada (memakai API trivia publik sebagai konten sementara) |
| Layar deteksi bahasa isyarat | Placeholder |
| Layar Augmented Reality | Placeholder |
| Layar Hologram | Placeholder |
| Layar Search dan Profile | Belum diimplementasikan |
| Model pengenalan gestur (landmark MediaPipe dan classifier) | Tidak disertakan |

---

## Fitur

**Tersedia sekarang**

- Alur onboarding dengan form sign-in beranimasi, loading, sukses, dan konfeti.
- Layar Home dengan kartu menu (Kuis, Deteksi Bahasa Isyarat, Hologram, Augmented Reality).
- Navigasi bawah melayang beranimasi dengan lima tab.
- Speech-to-Text: tekan mikrofon dan ucapan langsung ditranskripsi di layar, berguna sebagai alat bantu komunikasi dari orang dengar ke orang Tuli.
- Kuis: timer 60 detik per soal, pilihan jawaban diacak, umpan balik hijau dan merah, serta penghitung poin.

**Dalam pengembangan**

- Pengenalan gestur BISINDO real-time dari kamera.
- Visualisasi isyarat dengan AR tanpa marker.
- Keluaran text-to-speech untuk isyarat yang dikenali.
- Konten kuis khusus BISINDO untuk kebutuhan kelas.

---

## Arsitektur

### 1. Alur aplikasi (sesuai implementasi di repositori ini)

```mermaid
flowchart TD
    A(["Buka aplikasi"]) --> B["Layar Onboarding<br/>Animasi Rive dan form sign-in"]
    B -->|"Form valid"| C["Entry Point<br/>Navigasi bawah beranimasi"]

    C --> D["Home"]
    C --> E["Search"]
    C --> F["Speech to Text"]
    C --> G["Notifikasi"]
    C --> H["Profile"]

    D --> D1["Kuis"]
    D --> D2["Deteksi Bahasa Isyarat"]
    D --> D3["Hologram"]
    D --> D4["Augmented Reality"]

    D1 --> Q["API trivia<br/>sumber soal"]
    F --> S["Mikrofon ke transkrip langsung"]

    classDef done fill:#d4f5dd,stroke:#2e8b57,color:#111;
    classDef stub fill:#eeeeee,stroke:#999,stroke-dasharray: 4 3,color:#111;
    class A,B,C,D,F,D1,Q,S done;
    class E,G,H,D2,D3,D4 stub;
```

Node hijau sudah diimplementasikan. Node abu-abu putus-putus masih placeholder.

### 2. Urutan proses Speech-to-Text

```mermaid
sequenceDiagram
    actor User as Pengguna
    participant View as ChatScreenView
    participant Ctrl as ChatScreenController (GetX)
    participant STT as SpeechTextRecognizer
    participant OS as Mesin suara perangkat

    User->>View: Tekan tombol mikrofon
    View->>Ctrl: recognizedTexts()
    Ctrl->>STT: startListning(callback)
    STT->>OS: listen (mode dictation, maks. 90 detik)
    OS-->>Ctrl: SpeechRecognitionResult (parsial dan final)
    Ctrl->>Ctrl: recognizedText.value = recognizedWords
    Ctrl-->>View: Obx memperbarui UI dengan transkrip langsung
```

### 3. Pipeline sistem target (acuan desain)

Diagram berikut menggambarkan rancangan akhir DEAFSAPP: terjemahan dua arah antara bahasa isyarat dan suara. Tahap pengenalan dan AR adalah **komponen yang direncanakan atau berasal dari tahap skripsi, dan tidak termasuk dalam snapshot ini**.

```mermaid
flowchart LR
    subgraph SIGN["Isyarat ke Teks dan Suara"]
        direction LR
        S1["Umpan kamera"] --> S2["Ekstraksi landmark tangan dan pose<br/>MediaPipe"]
        S2 --> S3["Urutan landmark<br/>penyiapan fitur"]
        S3 --> S4["Classifier gestur<br/>26 isyarat dinamis BISINDO"]
        S4 --> S5["Kata atau frasa terdeteksi"]
        S5 --> S6["Keluaran teks"]
        S5 --> S7["Keluaran text-to-speech"]
    end

    subgraph SPEECH["Suara ke Isyarat"]
        direction LR
        T1["Mikrofon"] --> T2["Speech-to-text"]
        T2 --> T3["Normalisasi teks<br/>dan pemetaan isyarat"]
        T3 --> T4["Visualisasi isyarat<br/>AR tanpa marker atau media hologram"]
    end

    classDef built fill:#d4f5dd,stroke:#2e8b57,color:#111;
    classDef planned fill:#fff3cd,stroke:#c9a227,stroke-dasharray: 4 3,color:#111;
    class T1,T2 built;
    class S1,S2,S3,S4,S5,S6,S7,T3,T4 planned;
```

Hijau: sudah ada di repositori ini (mikrofon dan speech-to-text). Kuning putus-putus: direncanakan atau tahap skripsi.

---

## Teknologi

| Lapisan | Teknologi | Fungsi |
|---|---|---|
| Framework | Flutter, Dart | UI lintas platform |
| State, routing, DI | [GetX](https://pub.dev/packages/get) | Controller, binding, named routes |
| Animasi | [Rive](https://pub.dev/packages/rive) | Onboarding, ikon navigasi, loading dan konfeti |
| Grafis | [flutter_svg](https://pub.dev/packages/flutter_svg) | Ikon dan bentuk vektor |
| Input suara | [speech_to_text](https://pub.dev/packages/speech_to_text) | Transkripsi langsung |
| Konten | Open Trivia DB (HTTP) | Soal kuis sementara |

Dideklarasikan di `pubspec.yaml` untuk fitur mendatang dan belum dipakai di snapshot ini: `flutter_tts`, `video_player`, `permission_handler`, `avatar_glow`, `highlight_text`.

---

## Struktur Proyek

Aplikasi memakai struktur modular GetX: setiap fitur punya `bindings`, `controllers`, dan `views` sendiri.

```text
lib/
├── main.dart                      # Entry aplikasi, registrasi controller, rute
├── entry_point.dart               # Host navigasi bawah (5 tab)
└── app/
    ├── routes/                    # Nama rute dan daftar halaman
    ├── data/
    │   ├── components/            # Widget yang dipakai ulang (animated bar)
    │   ├── models/                # Model Course dan Rive asset
    │   ├── utils/                 # Helper Rive
    │   └── constants.dart
    └── modules/
        ├── OnboardingScreen/      # Onboarding beranimasi dan form sign-in
        ├── home/                  # Kartu menu, kuis, layar AR / hologram / deteksi
        ├── ChatScreen/            # Fitur Speech-to-Text
        ├── Search/                # Placeholder
        ├── BellScreen/            # Placeholder
        └── Profile/               # Placeholder
assets/                            # File Rive, ikon, avatar, font, gambar kuis
android/ ios/ web/ linux/ macos/ windows/   # Runner tiap platform
```

---

## Memulai

### Prasyarat

- [Flutter SDK](https://docs.flutter.dev/get-started/install) stabil terbaru. Lockfile dependensi mengacu pada Flutter 3.22 atau lebih baru.
- Android Studio atau VS Code dengan ekstensi Flutter.
- Perangkat atau emulator Android atau iOS. Perangkat asli disarankan untuk pengenalan suara.

### Instalasi

```bash
git clone https://github.com/dkiplikurniawan/DEAFSAPP-V1.git
cd DEAFSAPP-V1
flutter pub get
flutter run
```

### Izin mikrofon

Layar Speech-to-Text membutuhkan akses mikrofon.

- **Android:** tambahkan `<uses-permission android:name="android.permission.RECORD_AUDIO"/>` ke `android/app/src/main/AndroidManifest.xml`.
- **iOS:** tambahkan `NSMicrophoneUsageDescription` dan `NSSpeechRecognitionUsageDescription` ke `ios/Runner/Info.plist`.

### Cara menggunakan

1. Buka aplikasi dan selesaikan form onboarding.
2. Di **Home**, pilih kartu menu seperti **Mari Latihan Quis** untuk memulai kuis.
3. Buka tab **Speech to Text**, tekan mikrofon, lalu berbicara. Transkrip muncul langsung.

---

## Rencana Pengembangan

- [x] Kerangka aplikasi dengan routing GetX dan struktur modular
- [x] Onboarding dan navigasi bawah beranimasi
- [x] Modul Speech-to-Text
- [x] Modul kuis dengan timer dan skor
- [ ] Pengenalan gestur BISINDO real-time (kamera, landmark, classifier)
- [ ] Visualisasi isyarat dengan AR tanpa marker
- [ ] Text-to-speech untuk isyarat yang dikenali
- [ ] Konten kuis dan materi khusus BISINDO
- [ ] Layar Search, Profile, dan Notifikasi
- [ ] Autentikasi sungguhan dan pelacakan progres pengguna
- [ ] Pengujian otomatis dan CI

---

## Keterbatasan Saat Ini

- Form sign-in hanya alur UI. Belum ada autentikasi backend.
- Soal kuis berasal dari API trivia umum berbahasa Inggris, bukan materi BISINDO.
- Layar deteksi isyarat, hologram, dan AR masih placeholder.
- Layar Search dan Profile masih berupa stub dan perlu diimplementasikan sebelum dipakai.
- Izin mikrofon harus ditambahkan ke manifest platform (lihat di atas).

---

## Ucapan Terima Kasih

- **SLB Melati Aisyah**, Medan: mitra sekolah dan komunitas uji lapangan.
- **Universitas Muhammadiyah Sumatera Utara (UMSU)**: tempat skripsi ini dikerjakan.
- **Universitas Pendidikan Indonesia (UPI)** dan **Kementerian Pendidikan, Kebudayaan, Riset, dan Teknologi**: program finalis nasional LIDM 2023.
- Sebagian UI onboarding dan kuis mengikuti template tutorial Flutter yang tersedia publik (onboarding animasi Rive dan kuis trivia).

---

## Penulis

**Dul Kipli Kurniawan**
Lulusan Sistem Informasi, UI/UX dan Flutter developer, AI application developer.
Medan, Sumatera Utara, Indonesia.

GitHub: [@dkiplikurniawan](https://github.com/dkiplikurniawan)

<!-- Tambahkan link video demo dan screenshot di sini -->
