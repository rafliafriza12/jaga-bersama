// lib/pages/my_bookings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({Key? key}) : super(key: key);

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 'BK001',
      'nurseName': 'T.M Fadlul Ihsan',
      'nurseSpecialty': 'Perawat Anak',
      'date': '26 April 2025',
      'time': '09:00 - 18:00 WIB',
      'status': 'Aktif',
      'price': 350000,
      'duration': 'Harian',
      'address': 'Jl. Prada Utama No. 15, Banda Aceh',
      'phone': '+62 812-3456-7890',
    },
    {
      'id': 'BK002',
      'nurseName': 'Siti Nurhaliza',
      'nurseSpecialty': 'Perawat Anak',
      'date': '20 April 2025',
      'time': '09:00 - 18:00 WIB',
      'status': 'Selesai',
      'price': 450000,
      'duration': 'Harian',
      'address': 'Jl. Prada Utama No. 15, Banda Aceh',
      'phone': '+62 812-3456-7890',
      'rating': 5.0,
      'review': 'Sangat profesional dan ramah dengan anak saya.',
    },
    {
      'id': 'BK003',
      'nurseName': 'Ahmad Ridwan',
      'nurseSpecialty': 'Perawat Lansia',
      'date': '15 April 2025',
      'time': '09:00 - 18:00 WIB',
      'status': 'Selesai',
      'price': 400000,
      'duration': 'Harian',
      'address': 'Jl. Prada Utama No. 15, Banda Aceh',
      'phone': '+62 812-3456-7890',
      'rating': 4.8,
      'review': 'Perawatan untuk nenek sangat baik dan telaten.',
    },
    {
      'id': 'BK004',
      'nurseName': 'Dewi Kartika',
      'nurseSpecialty': 'Perawat Anak',
      'date': '10 April 2025',
      'time': '09:00 - 18:00 WIB',
      'status': 'Dibatalkan',
      'price': 375000,
      'duration': 'Harian',
      'address': 'Jl. Prada Utama No. 15, Banda Aceh',
      'phone': '+62 812-3456-7890',
      'cancelReason': 'Perubahan jadwal mendadak',
    },
  ];

  List<Map<String, dynamic>> get _activeBookings {
    return _bookings.where((booking) => booking['status'] == 'Aktif').toList();
  }

  List<Map<String, dynamic>> get _completedBookings {
    return _bookings.where((booking) => booking['status'] == 'Selesai').toList();
  }

  List<Map<String, dynamic>> get _cancelledBookings {
    return _bookings.where((booking) => booking['status'] == 'Dibatalkan').toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                  'Pemesanan Saya',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Kelola informasi pribadi Anda',
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
                Tab(text: 'Aktif (${_activeBookings.length})'),
                Tab(text: 'Selesai (${_completedBookings.length})'),
                Tab(text: 'Dibatalkan (${_cancelledBookings.length})'),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBookingsList(_activeBookings, 'Aktif'),
                _buildBookingsList(_completedBookings, 'Selesai'),
                _buildBookingsList(_cancelledBookings, 'Dibatalkan'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(List<Map<String, dynamic>> bookings, String status) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status == 'Aktif' ? Icons.schedule : 
              status == 'Selesai' ? Icons.check_circle : Icons.cancel,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'Tidak ada pemesanan $status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              status == 'Aktif' 
                  ? 'Pemesanan aktif akan muncul di sini'
                  : status == 'Selesai'
                      ? 'Riwayat pemesanan selesai akan muncul di sini'
                      : 'Pemesanan yang dibatalkan akan muncul di sini',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            if (status == 'Aktif') ...[
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/nurses');
                },
                child: Text('Cari Perawat'),
              ),
            ],
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(24),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildBookingCard(booking);
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    Color statusColor;
    IconData statusIcon;
    
    switch (booking['status']) {
      case 'Aktif':
        statusColor = Colors.green;
        statusIcon = Icons.schedule;
        break;
      case 'Selesai':
        statusColor = Colors.blue;
        statusIcon = Icons.check_circle;
        break;
      case 'Dibatalkan':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID: ${booking['id']}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: 14,
                      color: statusColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      booking['status'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Nurse Info
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFE91E63),
                child: Text(
                  booking['nurseName'].split(' ').map((e) => e[0]).take(2).join(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['nurseName'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      booking['nurseSpecialty'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFE91E63),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Booking Details
          _buildDetailRow(Icons.calendar_today, 'Tanggal', booking['date']),
          _buildDetailRow(Icons.access_time, 'Waktu', booking['time']),
          _buildDetailRow(Icons.monetization_on, 'Tarif ${booking['duration']}', 
              'Rp ${booking['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
          
          if (booking['status'] == 'Dibatalkan' && booking['cancelReason'] != null) ...[
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.red, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Alasan dibatalkan: ${booking['cancelReason']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          if (booking['status'] == 'Selesai' && booking['rating'] != null) ...[
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Rating Anda: ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 14,
                            color: index < booking['rating'].floor() 
                                ? Colors.amber 
                                : Colors.grey[300],
                          );
                        }),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${booking['rating']}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  if (booking['review'] != null) ...[
                    SizedBox(height: 4),
                    Text(
                      '"${booking['review']}"',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          
          SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              if (booking['status'] == 'Aktif') ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showContactNurse(booking);
                    },
                    icon: Icon(Icons.phone, size: 16),
                    label: Text('Hubungi'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showCancelBooking(booking);
                    },
                    icon: Icon(Icons.cancel_outlined, size: 16),
                    label: Text('Batalkan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ] else if (booking['status'] == 'Selesai') ...[
                if (booking['rating'] == null) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showRatingDialog(booking);
                      },
                      icon: Icon(Icons.star, size: 16),
                      label: Text('Beri Rating'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                ],
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _rebookNurse(booking);
                    },
                    icon: Icon(Icons.refresh, size: 16),
                    label: Text('Pesan Lagi'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ] else if (booking['status'] == 'Dibatalkan') ...[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _rebookNurse(booking);
                    },
                    icon: Icon(Icons.refresh, size: 16),
                    label: Text('Pesan Lagi'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
              SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  _showBookingDetail(booking);
                },
                child: Text('Detail'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey[500],
          ),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showContactNurse(Map<String, dynamic> booking) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Hubungi Perawat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement phone call
                      },
                      icon: Icon(Icons.phone),
                      label: Text('Telepon'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement WhatsApp
                      },
                      icon: Icon(Icons.message),
                      label: Text('WhatsApp'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancelBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Batalkan Pemesanan'),
        content: Text('Apakah Anda yakin ingin membatalkan pemesanan ini? Tindakan ini tidak dapat dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tidak'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                booking['status'] = 'Dibatalkan';
                booking['cancelReason'] = 'Dibatalkan oleh pengguna';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pemesanan berhasil dibatalkan'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Ya, Batalkan'),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(Map<String, dynamic> booking) {
    double rating = 5.0;
    TextEditingController reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Beri Rating & Ulasan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bagaimana pengalaman Anda dengan ${booking['nurseName']}?'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setDialogState(() {
                        rating = index + 1.0;
                      });
                    },
                    child: Icon(
                      Icons.star,
                      size: 32,
                      color: index < rating ? Colors.amber : Colors.grey[300],
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              TextField(
                controller: reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tulis ulasan Anda (opsional)',
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
                setState(() {
                  booking['rating'] = rating;
                  if (reviewController.text.isNotEmpty) {
                    booking['review'] = reviewController.text;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Terima kasih atas rating dan ulasan Anda!'),
                    backgroundColor: Color(0xFFE91E63),
                  ),
                );
              },
              child: Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }

  void _rebookNurse(Map<String, dynamic> booking) {
    Navigator.pushNamed(
      context,
      '/nurse-profile',
      arguments: {
        'name': booking['nurseName'],
        'specialty': booking['nurseSpecialty'],
        'rating': 5.0,
        'reviews': 28,
        'experience': '4 Tahun',
        'description': 'Perawat berpengalaman dengan pelayanan terbaik.',
        'location': 'Banda Aceh',
        'price': booking['price'],
      },
    );
  }

  void _showBookingDetail(Map<String, dynamic> booking) {
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
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Detail Pemesanan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailSection('Informasi Pemesanan', [
                        _buildDetailItem('ID Pemesanan', booking['id']),
                        _buildDetailItem('Status', booking['status']),
                        _buildDetailItem('Tanggal', booking['date']),
                        _buildDetailItem('Waktu', booking['time']),
                      ]),
                      
                      _buildDetailSection('Informasi Perawat', [
                        _buildDetailItem('Nama', booking['nurseName']),
                        _buildDetailItem('Spesialisasi', booking['nurseSpecialty']),
                        _buildDetailItem('Nomor Telepon', booking['phone']),
                      ]),
                      
                      _buildDetailSection('Informasi Layanan', [
                        _buildDetailItem('Alamat', booking['address']),
                        _buildDetailItem('Durasi', booking['duration']),
                        _buildDetailItem('Tarif', 'Rp ${booking['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
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
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Text(
            ': ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}