<div align="center">

# 🔔 Tugas 6.2 — Local Notification

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)

> Implementasi **Local Notification** pada Flutter — Mata Kuliah Aplikasi Perangkat Bergerak

---

| 📋 | Detail |
|---|---|
| **Nama** | Michael Angello Qadosy Riyadi |
| **NIM** | 1202230014 |
| **Jurusan** | Teknologi Informasi |
| **Universitas** | Telkom University |
| **Mata Kuliah** | Aplikasi Perangkat Bergerak |

---

</div>

## Deskripsi Tugas

Membuat aplikasi Flutter yang mengimplementasikan **local notification**. Aplikasi memiliki **FloatingActionButton** yang apabila ditekan akan membuat notifikasi berisi waktu button ditekan:

> **"Anda menekan tombol pada waktu HH:MM:SS"**

---

## Syarat-Syarat Wajib

Berikut adalah syarat dan langkah-langkah yang **wajib dipenuhi** untuk menerapkan local notification di Flutter:

### 1. Tambah Library

Tambahkan package `flutter_local_notifications` di `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_local_notifications: ^18.0.1
```

Lalu jalankan:

```bash
flutter pub get
```

### 2. Konfigurasi Android

#### a. Permission di `AndroidManifest.xml`

Tambahkan permission berikut di `android/app/src/main/AndroidManifest.xml` **sebelum** tag `<application>`:

```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
```

| Permission | Fungsi |
|---|---|
| `POST_NOTIFICATIONS` | Wajib untuk Android 13+ (API 33) agar bisa menampilkan notifikasi |
| `RECEIVE_BOOT_COMPLETED` | Agar notifikasi terjadwal tetap aktif setelah device restart |

#### b. Ikon Notifikasi

Notifikasi Android membutuhkan ikon. Secara default menggunakan `@mipmap/ic_launcher` (ikon bawaan app).

---

## Cara Kerja (Alur Logika)

Berikut adalah alur kerja notifikasi lokal secara **urut dan runtut**:

### Step 1 — Inisialisasi Plugin

```
main() dipanggil
    │
    ▼
WidgetsFlutterBinding.ensureInitialized()
    │  → Wajib dipanggil sebelum plugin apapun
    ▼
Buat AndroidInitializationSettings
    │  → Set ikon notifikasi: @mipmap/ic_launcher
    ▼
Buat DarwinInitializationSettings (iOS)
    │  → Minta izin: alert, badge, sound
    ▼
Gabungkan ke InitializationSettings
    │
    ▼
flutterLocalNotificationsPlugin.initialize()
    │  → Plugin siap digunakan
    ▼
runApp(MyApp())
```

### Step 2 — Membuat Notification Channel (Android)

```
AndroidNotificationDetails dibuat dengan:
    │
    ├── channelId: 'local_notification_channel'
    │     → ID unik untuk channel (wajib)
    │
    ├── channelName: 'Local Notification'
    │     → Nama yang tampil di Settings > Notifications
    │
    ├── importance: Importance.max
    │     → Prioritas tertinggi (muncul di status bar)
    │
    └── priority: Priority.high
          → Tampil sebagai heads-up notification (popup atas)
```

### Step 3 — Menampilkan Notifikasi

```
User menekan FloatingActionButton (+)
    │
    ▼
Ambil waktu sekarang: DateTime.now()
    │
    ▼
Format waktu → "HH:MM:SS"
    │
    ▼
flutterLocalNotificationsPlugin.show(
    id: 0,
    title: 'Notifikasi Lokal',
    body: 'Anda menekan tombol pada waktu HH:MM:SS',
    notificationDetails
)
    │
    ▼
Notifikasi muncul di status bar / heads-up
```

---

## Penjelasan Kode `main.dart`

| Bagian | Fungsi |
|---|---|
| `FlutterLocalNotificationsPlugin` | Instance global plugin notifikasi |
| `WidgetsFlutterBinding.ensureInitialized()` | Wajib dipanggil sebelum inisialisasi plugin |
| `AndroidInitializationSettings` | Konfigurasi ikon notifikasi Android |
| `DarwinInitializationSettings` | Konfigurasi permission notifikasi iOS |
| `InitializationSettings` | Gabungan konfigurasi semua platform |
| `AndroidNotificationDetails` | Detail notifikasi: channel, importance, priority |
| `flutterLocalNotificationsPlugin.show()` | Fungsi untuk menampilkan notifikasi |
| `DateTime.now()` | Mengambil waktu saat tombol ditekan |
| `FloatingActionButton` | Tombol untuk trigger notifikasi |

---

## 📸 Screenshot

### Tampilan Aplikasi
<img width="482" height="832" alt="Cuplikan layar 2026-04-06 091441" src="https://github.com/user-attachments/assets/d2ffc54b-dcf0-4d06-ad6d-cffadda3360a" />

---

<div align="center">

![Made with Flutter](https://img.shields.io/badge/Made%20with-Flutter-02569B?style=flat-square&logo=flutter)
![Telkom University](https://img.shields.io/badge/Telkom-University-e4002b?style=flat-square)

</div>
