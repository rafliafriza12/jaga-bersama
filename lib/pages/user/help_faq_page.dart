// lib/pages/help_faq_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpFaqPage extends StatefulWidget {
  const HelpFaqPage({Key? key}) : super(key: key);

  @override
  State<HelpFaqPage> createState() => _HelpFaqPageState();
}

class _HelpFaqPageState extends State<HelpFaqPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _faqItems = [
    {
      'category': 'Umum',
      'question': 'Apa itu JagaBersama?',
      'answer': 'JagaBersama adalah platform yang menghubungkan keluarga dengan perawat anak dan lansia profesional yang telah terverifikasi. Kami menyediakan layanan perawatan berkualitas tinggi di rumah.',
    },
    {
      'category': 'Umum',
      'question': 'Bagaimana cara mendaftar di JagaBersama?',
      'answer': 'Anda dapat mendaftar melalui aplikasi dengan mengisi formulir registrasi, memverifikasi email dan nomor telepon, lalu melengkapi profil Anda.',
    },
    {
      'category': 'Pemesanan',
      'question': 'Bagaimana cara memesan perawat?',
      'answer': 'Pilih perawat yang sesuai dari daftar, lihat profil dan jadwal ketersediaan, lalu klik "Pesan Sekarang". Isi formulir pemesanan dan konfirmasi booking Anda.',
    },
    {
      'category': 'Pemesanan',
      'question': 'Berapa lama sebelumnya saya harus memesan?',
      'answer': 'Kami merekomendasikan pemesanan minimal 24 jam sebelumnya untuk layanan reguler. Untuk layanan darurat, kami tersedia 24/7 dengan biaya tambahan.',
    },
    {
      'category': 'Pemesanan',
      'question': 'Bisakah saya membatalkan pemesanan?',
      'answer': 'Ya, Anda dapat membatalkan pemesanan hingga 12 jam sebelum jadwal yang ditentukan tanpa dikenakan biaya. Pembatalan kurang dari 12 jam akan dikenakan biaya administrasi.',
    },
    {
      'category': 'Pembayaran',
      'question': 'Metode pembayaran apa saja yang tersedia?',
      'answer': 'Kami menerima pembayaran melalui transfer bank, e-wallet (GoPay, OVO, DANA), kartu kredit, dan pembayaran tunai kepada perawat.',
    },
    {
      'category': 'Pembayaran',
      'question': 'Kapan saya harus melakukan pembayaran?',
      'answer': 'Pembayaran dapat dilakukan setelah konfirmasi booking. Untuk pembayaran non-tunai, pembayaran harus diselesaikan sebelum layanan dimulai.',
    },
    {
      'category': 'Keamanan',
      'question': 'Bagaimana JagaBersama memverifikasi perawat?',
      'answer': 'Semua perawat telah melalui proses verifikasi ketat meliputi pemeriksaan sertifikat, pengalaman kerja, latar belakang, dan tes kompetensi.',
    },
    {
      'category': 'Keamanan',
      'question': 'Apakah data pribadi saya aman?',
      'answer': 'Ya, kami menggunakan enkripsi tingkat bank untuk melindungi data pribadi Anda dan tidak akan membagikan informasi kepada pihak ketiga tanpa persetujuan.',
    },
    {
      'category': 'Layanan',
      'question': 'Jenis layanan apa saja yang tersedia?',
      'answer': 'Kami menyediakan perawatan anak (0-17 tahun), perawatan lansia, perawatan medis dasar, terapi rehabilitasi, dan layanan konsultasi kesehatan.',
    },
    {
      'category': 'Layanan',
      'question': 'Apakah perawat membawa peralatan medis?',
      'answer': 'Perawat membawa peralatan medis dasar. Untuk peralatan khusus, Anda dapat menginformasikan kebutuhan saat pemesanan dengan biaya tambahan.',
    },
  ];

  final List<Map<String, String>> _contactOptions = [
    {
      'title': 'Hubungi Customer Service',
      'subtitle': 'Chat dengan tim support kami',
      'icon': 'chat',
      'action': 'chat',
    },
    {
      'title': 'Telepon',
      'subtitle': '+62 21 1234 5678',
      'icon': 'phone',
      'action': 'phone',
    },
    {
      'title': 'Email',
      'subtitle': 'support@jagabersama.com',
      'icon': 'email',
      'action': 'email',
    },
    {
      'title': 'WhatsApp',
      'subtitle': '+62 812 3456 7890',
      'icon': 'whatsapp',
      'action': 'whatsapp',
    },
  ];

  List<String> get _categories {
    return _faqItems.map((item) => item['category'] as String).toSet().toList();
  }

  List<Map<String, dynamic>> get _filteredFaqItems {
    if (_searchQuery.isEmpty) {
      return _faqItems;
    }
    return _faqItems.where((item) {
      return item['question'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             item['answer'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
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
                Text(
                  'Bantuan & FAQ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Pusat bantuan dan pertanyaan umum',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
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
                Tab(text: 'FAQ'),
                Tab(text: 'Hubungi Kami'),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFaqTab(),
                _buildContactTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqTab() {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: EdgeInsets.all(24),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Cari pertanyaan...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
        
        // FAQ List
        Expanded(
          child: _filteredFaqItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Tidak ada hasil ditemukan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Coba kata kunci lain',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final categoryItems = _filteredFaqItems
                        .where((item) => item['category'] == category)
                        .toList();
                    
                    if (categoryItems.isEmpty) {
                      return SizedBox.shrink();
                    }
                    
                    return _buildFaqCategory(category, categoryItems);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFaqCategory(String category, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        ...items.map((item) => _buildFaqItem(item)).toList(),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildFaqItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
      child: ExpansionTile(
        title: Text(
          item['question'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              item['answer'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
        ],
        iconColor: Color(0xFFE91E63),
        collapsedIconColor: Colors.grey[500],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Butuh bantuan lebih lanjut?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tim customer service kami siap membantu Anda 24/7',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 24),
          
          // Contact Options
          ...(_contactOptions.map((option) => _buildContactOption(option)).toList()),
          
          SizedBox(height: 32),
          
          // Office Hours
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFE91E63).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE91E63).withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Color(0xFFE91E63),
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Jam Operasional',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildOfficeHour('Senin - Jumat', '08:00 - 22:00 WIB'),
                _buildOfficeHour('Sabtu - Minggu', '08:00 - 20:00 WIB'),
                _buildOfficeHour('Layanan Darurat', '24/7'),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Quick Actions
          Text(
            'Aksi Cepat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildQuickAction(
                  'Panduan Penggunaan',
                  Icons.help_outline,
                  () {
                    _showUserGuide();
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildQuickAction(
                  'Laporkan Masalah',
                  Icons.report_problem,
                  () {
                    _showReportIssue();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(Map<String, String> option) {
    IconData icon;
    Color color;
    
    switch (option['icon']) {
      case 'chat':
        icon = Icons.chat;
        color = Colors.blue;
        break;
      case 'phone':
        icon = Icons.phone;
        color = Colors.green;
        break;
      case 'email':
        icon = Icons.email;
        color = Colors.orange;
        break;
      case 'whatsapp':
        icon = Icons.message;
        color = Colors.green[600]!;
        break;
      default:
        icon = Icons.help;
        color = Colors.grey;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _handleContactAction(option['action']!);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(16),
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
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option['title']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        option['subtitle']!,
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
      ),
    );
  }

  Widget _buildOfficeHour(String day, String time) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE91E63),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: Color(0xFFE91E63),
                size: 32,
              ),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleContactAction(String action) {
    switch (action) {
      case 'chat':
        _startChat();
        break;
      case 'phone':
        _makePhoneCall();
        break;
      case 'email':
        _sendEmail();
        break;
      case 'whatsapp':
        _openWhatsApp();
        break;
    }
  }

  void _startChat() {
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
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  Text(
                    'Live Chat',
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
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Fitur Live Chat',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Akan segera tersedia',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Membuka aplikasi telepon...'),
        backgroundColor: Color(0xFFE91E63),
      ),
    );
  }

  void _sendEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Membuka aplikasi email...'),
        backgroundColor: Color(0xFFE91E63),
      ),
    );
  }

  void _openWhatsApp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Membuka WhatsApp...'),
        backgroundColor: Color(0xFFE91E63),
      ),
    );
  }

  void _showUserGuide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Panduan Penggunaan'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Panduan singkat menggunakan JagaBersama:'),
              SizedBox(height: 16),
              _buildGuideStep('1', 'Daftar atau masuk ke akun Anda'),
              _buildGuideStep('2', 'Cari perawat sesuai kebutuhan'),
              _buildGuideStep('3', 'Lihat profil dan jadwal perawat'),
              _buildGuideStep('4', 'Buat pemesanan dengan detail lengkap'),
              _buildGuideStep('5', 'Konfirmasi dan lakukan pembayaran'),
              _buildGuideStep('6', 'Perawat akan datang sesuai jadwal'),
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

  Widget _buildGuideStep(String step, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFFE91E63),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReportIssue() {
    final TextEditingController issueController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Laporkan Masalah'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Ceritakan masalah yang Anda alami:'),
            SizedBox(height: 16),
            TextField(
              controller: issueController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Deskripsikan masalah Anda...',
                border: OutlineInputBorder(),
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
                  content: Text('Laporan terkirim. Tim kami akan segera menghubungi Anda.'),
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
}