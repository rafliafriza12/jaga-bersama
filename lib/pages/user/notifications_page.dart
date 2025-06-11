// lib/pages/notifications_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Notification settings
  bool _bookingNotifications = true;
  bool _reminderNotifications = true;
  bool _promotionNotifications = false;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _pushNotifications = true;

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Booking Dikonfirmasi',
      'message': 'Booking Anda dengan T.M Fadlul Ihsan telah dikonfirmasi untuk tanggal 26 April 2025.',
      'type': 'booking',
      'time': '2 jam lalu',
      'isRead': false,
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'id': '2',
      'title': 'Reminder Jadwal',
      'message': 'Jangan lupa, layanan perawatan Anda dimulai besok pukul 09:00.',
      'type': 'reminder',
      'time': '5 jam lalu',
      'isRead': true,
      'icon': Icons.schedule,
      'color': Colors.blue,
    },
    {
      'id': '3',
      'title': 'Perawat Dalam Perjalanan',
      'message': 'T.M Fadlul Ihsan sedang dalam perjalanan menuju lokasi Anda. Estimasi tiba 15 menit.',
      'type': 'booking',
      'time': '1 hari lalu',
      'isRead': true,
      'icon': Icons.directions_car,
      'color': Colors.orange,
    },
    {
      'id': '4',
      'title': 'Promo Spesial!',
      'message': 'Dapatkan diskon 20% untuk booking perawat anak di bulan ini. Berlaku hingga 30 April.',
      'type': 'promotion',
      'time': '2 hari lalu',
      'isRead': false,
      'icon': Icons.local_offer,
      'color': Colors.red,
    },
    {
      'id': '5',
      'title': 'Layanan Selesai',
      'message': 'Terima kasih telah menggunakan layanan kami. Berikan rating untuk perawat Anda.',
      'type': 'booking',
      'time': '3 hari lalu',
      'isRead': true,
      'icon': Icons.star,
      'color': Colors.amber,
    },
    {
      'id': '6',
      'title': 'Artikel Baru',
      'message': 'Artikel terbaru: "Tips Merawat Anak Usia 0-3 Tahun" sudah tersedia di halaman edukasi.',
      'type': 'education',
      'time': '1 minggu lalu',
      'isRead': true,
      'icon': Icons.article,
      'color': Colors.purple,
    },
  ];

  List<Map<String, dynamic>> get _unreadNotifications {
    return _notifications.where((notif) => !notif['isRead']).toList();
  }

  List<Map<String, dynamic>> get _allNotifications {
    return _notifications;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(
              Icons.local_hospital,
              color: Color(0xFFE91E63),
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              'JagaBersama',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black87),
            onPressed: () {
              _showNotificationSettings();
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '10.45 AM',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifikasi',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${_unreadNotifications.length} notifikasi belum dibaca',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    if (_unreadNotifications.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          _markAllAsRead();
                        },
                        child: Text(
                          'Tandai Semua',
                          style: TextStyle(
                            color: Color(0xFFE91E63),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Tab Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              indicator: BoxDecoration(
                color: Color(0xFFE91E63),
                borderRadius: BorderRadius.circular(12),
              ),
              tabs: [
                Tab(text: 'Belum Dibaca (${_unreadNotifications.length})'),
                Tab(text: 'Semua (${_allNotifications.length})'),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotificationsList(_unreadNotifications),
                _buildNotificationsList(_allNotifications),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'Tidak ada notifikasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Notifikasi akan muncul di sini',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(24),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Dismissible(
      key: Key(notification['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 24,
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          _notifications.removeWhere((notif) => notif['id'] == notification['id']);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notifikasi dihapus'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // TODO: Implement undo functionality
              },
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          _markAsRead(notification);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification['isRead'] ? Colors.white : Color(0xFFE91E63).withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: notification['isRead'] ? Colors.grey[200]! : Color(0xFFE91E63).withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: notification['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  notification['icon'],
                  color: notification['color'],
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (!notification['isRead'])
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Color(0xFFE91E63),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      notification['message'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getTypeColor(notification['type']).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getTypeLabel(notification['type']),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getTypeColor(notification['type']),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          notification['time'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'booking':
        return Colors.blue;
      case 'reminder':
        return Colors.orange;
      case 'promotion':
        return Colors.red;
      case 'education':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'booking':
        return 'BOOKING';
      case 'reminder':
        return 'REMINDER';
      case 'promotion':
        return 'PROMO';
      case 'education':
        return 'EDUKASI';
      default:
        return 'INFO';
    }
  }

  void _markAsRead(Map<String, dynamic> notification) {
    setState(() {
      notification['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Semua notifikasi ditandai sebagai dibaca'),
        backgroundColor: Color(0xFFE91E63),
      ),
    );
  }

  void _showNotificationSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  Text(
                    'Pengaturan Notifikasi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Settings content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSettingsSection(
                      'Jenis Notifikasi',
                      [
                        _buildSettingsTile(
                          'Notifikasi Booking',
                          'Update status pemesanan dan konfirmasi',
                          _bookingNotifications,
                          (value) => setState(() => _bookingNotifications = value),
                        ),
                        _buildSettingsTile(
                          'Pengingat',
                          'Reminder jadwal dan tugas penting',
                          _reminderNotifications,
                          (value) => setState(() => _reminderNotifications = value),
                        ),
                        _buildSettingsTile(
                          'Promosi & Penawaran',
                          'Informasi diskon dan promo khusus',
                          _promotionNotifications,
                          (value) => setState(() => _promotionNotifications = value),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    _buildSettingsSection(
                      'Metode Pengiriman',
                      [
                        _buildSettingsTile(
                          'Push Notification',
                          'Notifikasi langsung di aplikasi',
                          _pushNotifications,
                          (value) => setState(() => _pushNotifications = value),
                        ),
                        _buildSettingsTile(
                          'Email',
                          'Kirim notifikasi ke email',
                          _emailNotifications,
                          (value) => setState(() => _emailNotifications = value),
                        ),
                        _buildSettingsTile(
                          'SMS',
                          'Kirim notifikasi via SMS',
                          _smsNotifications,
                          (value) => setState(() => _smsNotifications = value),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 32),
                    
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Batal'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Pengaturan disimpan'),
                                  backgroundColor: Color(0xFFE91E63),
                                ),
                              );
                            },
                            child: Text('Simpan'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Color(0xFFE91E63),
        dense: false,
      ),
    );
  }
}