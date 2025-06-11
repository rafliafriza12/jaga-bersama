// lib/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Settings variables
  bool _darkMode = false;
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _locationServices = true;
  bool _autoBackup = true;
  bool _biometricAuth = false;
  
  String _selectedLanguage = 'Bahasa Indonesia';
  String _selectedCurrency = 'IDR (Rupiah)';
  
  final List<String> _languages = [
    'Bahasa Indonesia',
    'English',
    'Bahasa Melayu',
  ];
  
  final List<String> _currencies = [
    'IDR (Rupiah)',
    'USD (Dollar)',
    'MYR (Ringgit)',
  ];

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pengaturan',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Kelola preferensi aplikasi Anda',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Settings Sections
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Account Settings
                  _buildSettingsSection(
                    'Akun',
                    [
                      _buildSettingsTile(
                        icon: Icons.person,
                        title: 'Informasi Pribadi',
                        subtitle: 'Kelola profil dan data pribadi',
                        onTap: () {
                          Navigator.pushNamed(context, '/edit-profile');
                        },
                      ),
                      _buildSettingsTile(
                        icon: Icons.security,
                        title: 'Keamanan',
                        subtitle: 'Password dan autentikasi',
                        onTap: () {
                          _showSecuritySettings();
                        },
                      ),
                      _buildSettingsTile(
                        icon: Icons.payment,
                        title: 'Metode Pembayaran',
                        subtitle: 'Kelola kartu dan e-wallet',
                        onTap: () {
                          _showPaymentMethods();
                        },
                      ),
                    ],
                  ),

                  // App Preferences
                  _buildSettingsSection(
                    'Preferensi Aplikasi',
                    [
                      _buildSwitchTile(
                        icon: Icons.dark_mode,
                        title: 'Mode Gelap',
                        subtitle: 'Aktifkan tema gelap',
                        value: _darkMode,
                        onChanged: (value) {
                          setState(() {
                            _darkMode = value;
                          });
                        },
                      ),
                      _buildDropdownTile(
                        icon: Icons.language,
                        title: 'Bahasa',
                        subtitle: _selectedLanguage,
                        items: _languages,
                        onChanged: (value) {
                          setState(() {
                            _selectedLanguage = value!;
                          });
                        },
                      ),
                      _buildDropdownTile(
                        icon: Icons.attach_money,
                        title: 'Mata Uang',
                        subtitle: _selectedCurrency,
                        items: _currencies,
                        onChanged: (value) {
                          setState(() {
                            _selectedCurrency = value!;
                          });
                        },
                      ),
                    ],
                  ),

                  // Notifications
                  _buildSettingsSection(
                    'Notifikasi',
                    [
                      _buildSwitchTile(
                        icon: Icons.notifications,
                        title: 'Push Notification',
                        subtitle: 'Terima notifikasi di aplikasi',
                        value: _pushNotifications,
                        onChanged: (value) {
                          setState(() {
                            _pushNotifications = value;
                          });
                        },
                      ),
                      _buildSwitchTile(
                        icon: Icons.email,
                        title: 'Notifikasi Email',
                        subtitle: 'Terima notifikasi via email',
                        value: _emailNotifications,
                        onChanged: (value) {
                          setState(() {
                            _emailNotifications = value;
                          });
                        },
                      ),
                      _buildSettingsTile(
                        icon: Icons.tune,
                        title: 'Kelola Notifikasi',
                        subtitle: 'Atur jenis notifikasi',
                        onTap: () {
                          Navigator.pushNamed(context, '/notifications');
                        },
                      ),
                    ],
                  ),

                  // Privacy & Security
                  _buildSettingsSection(
                    'Privasi & Keamanan',
                    [
                      _buildSwitchTile(
                        icon: Icons.location_on,
                        title: 'Layanan Lokasi',
                        subtitle: 'Izinkan akses lokasi',
                        value: _locationServices,
                        onChanged: (value) {
                          setState(() {
                            _locationServices = value;
                          });
                        },
                      ),
                      _buildSwitchTile(
                        icon: Icons.fingerprint,
                        title: 'Autentikasi Biometrik',
                        subtitle: 'Login dengan sidik jari/wajah',
                        value: _biometricAuth,
                        onChanged: (value) {
                          setState(() {
                            _biometricAuth = value;
                          });
                        },
                      ),
                      _buildSwitchTile(
                        icon: Icons.backup,
                        title: 'Backup Otomatis',
                        subtitle: 'Backup data secara otomatis',
                        value: _autoBackup,
                        onChanged: (value) {
                          setState(() {
                            _autoBackup = value;
                          });
                        },
                      ),
                    ],
                  ),

                  // Support
                  _buildSettingsSection(
                    'Dukungan',
                    [
                      _buildSettingsTile(
                        icon: Icons.help_outline,
                        title: 'Bantuan & FAQ',
                        subtitle: 'Pusat bantuan dan pertanyaan',
                        onTap: () {
                          Navigator.pushNamed(context, '/help');
                        },
                      ),
                      _buildSettingsTile(
                        icon: Icons.feedback,
                        title: 'Berikan Feedback',
                        subtitle: 'Bantu kami memperbaiki aplikasi',
                        onTap: () {
                          _showFeedbackDialog();
                        },
                      ),
                      _buildSettingsTile(
                        icon: Icons.star_rate,
                        title: 'Beri Rating di App Store',
                        subtitle: 'Dukung kami dengan rating',
                        onTap: () {
                          _rateApp();
                        },
                      ),
                    ],
                  ),

                  // About
                  _buildSettingsSection(
                    'Tentang',
                    [
                      _buildSettingsTile(
                        icon: Icons.info_outline,
                        title: 'Tentang JagaBersama',
                        subtitle: 'Versi 1.0.0',
                        onTap: () {
                          _showAboutDialog();
                        },
                      ),
                      _buildSettingsTile(
                        icon: Icons.privacy_tip,
                        title: 'Kebijakan Privasi',
                        subtitle: 'Lihat kebijakan privasi',
                        onTap: () {
                          _showPrivacyPolicy();
                        },
                      ),
                      _buildSettingsTile(
                        icon: Icons.description,
                        title: 'Syarat & Ketentuan',
                        subtitle: 'Lihat syarat penggunaan',
                        onTap: () {
                          _showTermsOfService();
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 32),

                  // Logout Button
                  Container(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showLogoutDialog();
                      },
                      icon: Icon(Icons.logout, color: Colors.red),
                      label: Text(
                        'Keluar dari Akun',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 32),
                ],
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
        Padding(
          padding: EdgeInsets.fromLTRB(0, 24, 0, 16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFE91E63).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Color(0xFFE91E63),
                  size: 20,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFE91E63).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color(0xFFE91E63),
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFFE91E63),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _showDropdownDialog(title, subtitle, items, onChanged);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFE91E63).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Color(0xFFE91E63),
                  size: 20,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdownDialog(String title, String currentValue, List<String> items, Function(String?) onChanged) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih $title'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((item) {
            return RadioListTile<String>(
              title: Text(item),
              value: item,
              groupValue: currentValue,
              onChanged: (value) {
                onChanged(value);
                Navigator.pop(context);
              },
              activeColor: Color(0xFFE91E63),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showSecuritySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pengaturan keamanan akan segera tersedia'),
        backgroundColor: Color(0xFFE91E63),
      ),
    );
  }

  void _showPaymentMethods() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pengaturan pembayaran akan segera tersedia'),
        backgroundColor: Color(0xFFE91E63),
      ),
    );
  }

  void _showFeedbackDialog() {
    final TextEditingController feedbackController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Berikan Feedback'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Bantu kami meningkatkan layanan dengan memberikan feedback:'),
            SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tulis feedback Anda...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terima kasih atas feedback Anda!'),
                  backgroundColor: Color(0xFFE91E63),
                ),
              );
            },
            child: Text('Kirim'),
          ),
        ],
      ),
    );
  }

  void _rateApp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Beri Rating'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Apakah Anda menikmati menggunakan JagaBersama?'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 32,
                );
              }),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Nanti Saja'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terima kasih! Mengarahkan ke App Store...'),
                  backgroundColor: Color(0xFFE91E63),
                ),
              );
            },
            child: Text('Beri Rating'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tentang JagaBersama'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.local_hospital,
                color: Color(0xFFE91E63),
                size: 64,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                'JagaBersama',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE91E63),
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Versi 1.0.0',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'JagaBersama adalah platform terpercaya yang menghubungkan keluarga dengan perawat anak dan lansia profesional. Kami berkomitmen untuk memberikan layanan perawatan berkualitas tinggi dan aman.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Dikembangkan dengan ❤️ untuk keluarga Indonesia',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Kebijakan Privasi'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kebijakan Privasi JagaBersama',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Pengumpulan Data\n'
                'Kami mengumpulkan data yang Anda berikan secara langsung dan data yang dikumpulkan secara otomatis saat menggunakan layanan kami.\n\n'
                '2. Penggunaan Data\n'
                'Data yang dikumpulkan digunakan untuk menyediakan, memelihara, dan meningkatkan layanan kami.\n\n'
                '3. Perlindungan Data\n'
                'Kami menggunakan langkah-langkah keamanan yang sesuai untuk melindungi data pribadi Anda.\n\n'
                '4. Berbagi Data\n'
                'Kami tidak menjual atau menyewakan data pribadi Anda kepada pihak ketiga.\n\n'
                'Untuk informasi lengkap, silakan kunjungi website kami.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Syarat & Ketentuan'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Syarat & Ketentuan Penggunaan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Penerimaan Syarat\n'
                'Dengan menggunakan aplikasi JagaBersama, Anda menyetujui syarat dan ketentuan ini.\n\n'
                '2. Penggunaan Layanan\n'
                'Anda bertanggung jawab untuk menggunakan layanan sesuai dengan hukum yang berlaku.\n\n'
                '3. Akun Pengguna\n'
                'Anda bertanggung jawab untuk menjaga keamanan akun dan password Anda.\n\n'
                '4. Pembayaran\n'
                'Semua pembayaran harus dilakukan sesuai dengan metode yang tersedia.\n\n'
                '5. Pembatalan\n'
                'Pembatalan layanan tunduk pada kebijakan pembatalan yang berlaku.\n\n'
                'Untuk syarat lengkap, silakan kunjungi website kami.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Keluar'),
        content: Text('Apakah Anda yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Keluar'),
          ),
        ],
      ),
    );
  }
}