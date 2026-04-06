import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ===========================================================
// Inisialisasi plugin notifikasi sebagai global variable
// ===========================================================
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  // Pastikan binding sudah diinisialisasi sebelum plugin
  WidgetsFlutterBinding.ensureInitialized();

  // -----------------------------------------------------------
  // Konfigurasi inisialisasi per platform
  // -----------------------------------------------------------
  // Android: gunakan ic_launcher sebagai ikon notifikasi
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS: minta izin alert, badge, dan sound
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  // Gabungkan konfigurasi semua platform
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  // Inisialisasi plugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotificationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _lastNotificationTime = '-';

  // =============================================================
  // Fungsi untuk menampilkan notifikasi lokal
  // =============================================================
  Future<void> _showNotification() async {
    // Ambil waktu saat tombol ditekan
    final now = DateTime.now();
    final timeString =
        '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';

    // ---------------------------------------------------------
    // Konfigurasi detail notifikasi untuk Android
    // ---------------------------------------------------------
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'local_notification_channel', // Channel ID (wajib unik)
      'Local Notification',         // Channel Name (tampil di Settings)
      channelDescription: 'Channel untuk notifikasi lokal tugas APB',
      importance: Importance.max,   // Prioritas tertinggi
      priority: Priority.high,     // Tampil sebagai heads-up notification
      icon: '@mipmap/ic_launcher',
    );

    // ---------------------------------------------------------
    // Konfigurasi detail notifikasi untuk iOS
    // ---------------------------------------------------------
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Gabungkan konfigurasi notifikasi
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // ---------------------------------------------------------
    // Tampilkan notifikasi
    // ---------------------------------------------------------
    await flutterLocalNotificationsPlugin.show(
      0,                            // Notification ID
      'Notifikasi Lokal',           // Title
      'Anda menekan tombol pada waktu $timeString', // Body
      notificationDetails,
    );

    // Update state untuk menampilkan waktu terakhir di UI
    setState(() {
      _lastNotificationTime = timeString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notification'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.notifications_active,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Tekan tombol + untuk mengirim notifikasi',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              'Notifikasi terakhir dikirim:',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              _lastNotificationTime,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNotification,
        tooltip: 'Kirim Notifikasi',
        child: const Icon(Icons.add),
      ),
    );
  }
}
