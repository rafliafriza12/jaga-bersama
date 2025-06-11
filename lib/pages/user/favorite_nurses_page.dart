// lib/pages/user/favorite_nurses_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavoriteNursesPage extends StatefulWidget {
  const FavoriteNursesPage({Key? key}) : super(key: key);

  @override
  State<FavoriteNursesPage> createState() => _FavoriteNursesPageState();
}

class _FavoriteNursesPageState extends State<FavoriteNursesPage> {
  // Sample favorite nurses data
  final List<Map<String, dynamic>> _favoriteNurses = [
    {
      'id': '1',
      'name': 'Rafli Afriza Nugraha',
      'rating': 5.0,
      'reviews': 28,
      'specialty': 'Perawat Anak',
      'experience': '4 Tahun',
      'description': 'Fokus pada perkembangan anak usia dini dengan pendekatan bermain sambil belajar.',
      'location': 'Banda Aceh',
      'price': 350000,
      'isAvailable': true,
      'lastBooked': '2 minggu lalu',
      'totalBookings': 5,
    },
    {
      'id': '2',
      'name': 'Siti Nurhaliza',
      'rating': 4.8,
      'reviews': 45,
      'specialty': 'Perawat Anak',
      'experience': '6 Tahun',
      'description': 'Spesialis perawatan bayi baru lahir dengan sertifikasi internasional.',
      'location': 'Jakarta',
      'price': 450000,
      'isAvailable': false,
      'lastBooked': '1 bulan lalu',
      'totalBookings': 12,
    },
    {
      'id': '3',
      'name': 'Ahmad Ridwan',
      'rating': 4.9,
      'reviews': 32,
      'specialty': 'Perawat Lansia',
      'experience': '8 Tahun',
      'description': 'Berpengalaman dalam perawatan lansia dengan kondisi khusus.',
      'location': 'Bandung',
      'price': 400000,
      'isAvailable': true,
      'lastBooked': '3 minggu lalu',
      'totalBookings': 8,
    },
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
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perawat Favorit',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Perawat yang telah Anda tandai sebagai favorit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                
                // Stats Row
                Row(
                  children: [
                    _buildStatCard(
                      'Total Favorit',
                      '${_favoriteNurses.length}',
                      Icons.favorite,
                      Colors.red,
                    ),
                    SizedBox(width: 16),
                    _buildStatCard(
                      'Tersedia',
                      '${_favoriteNurses.where((n) => n['isAvailable']).length}',
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Nurses List
          Expanded(
            child: _favoriteNurses.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: _favoriteNurses.length,
                    itemBuilder: (context, index) {
                      final nurse = _favoriteNurses[index];
                      return _buildFavoriteNurseCard(nurse);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/nurses');
        },
        backgroundColor: Color(0xFFE91E63),
        icon: Icon(Icons.search),
        label: Text('Cari Perawat'),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Belum Ada Perawat Favorit',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tandai perawat sebagai favorit untuk\nmudah mengaksesnya nanti',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/nurses');
            },
            icon: Icon(Icons.search),
            label: Text('Cari Perawat'),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteNurseCard(Map<String, dynamic> nurse) {
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
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFE91E63),
                    child: Text(
                      nurse['name'].split(' ').map((e) => e[0]).take(2).join(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: nurse['isAvailable'] ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            nurse['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _removeFromFavorites(nurse);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${nurse['rating']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(${nurse['reviews']} ulasan)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFE91E63).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  nurse['specialty'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFE91E63),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Icon(Icons.work_outline, size: 14, color: Colors.grey[500]),
              SizedBox(width: 4),
              Text(
                nurse['experience'],
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              SizedBox(width: 12),
              Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[500]),
              SizedBox(width: 4),
              Text(
                nurse['location'],
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 12),
          
          Text(
            nurse['description'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16),
          
          // Statistics Row
          Row(
            children: [
              _buildNurseStatItem('Terakhir dipesan', nurse['lastBooked']),
              SizedBox(width: 20),
              _buildNurseStatItem('Total booking', '${nurse['totalBookings']}x'),
            ],
          ),
          SizedBox(height: 16),
          
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tarif Harian',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    'Rp ${nurse['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/nurse-profile',
                        arguments: nurse,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      'Lihat Profil',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: nurse['isAvailable'] ? () {
                      Navigator.pushNamed(
                        context,
                        '/booking-detail',
                        arguments: nurse,
                      );
                    } : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      nurse['isAvailable'] ? 'Pesan' : 'Tidak Tersedia',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNurseStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _removeFromFavorites(Map<String, dynamic> nurse) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus dari Favorit'),
        content: Text('Apakah Anda yakin ingin menghapus ${nurse['name']} dari daftar favorit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _favoriteNurses.removeWhere((n) => n['id'] == nurse['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${nurse['name']} dihapus dari favorit'),
                  backgroundColor: Color(0xFFE91E63),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        _favoriteNurses.add(nurse);
                      });
                    },
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }
}