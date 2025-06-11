// lib/pages/nurses_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NursesPage extends StatefulWidget {
  const NursesPage({Key? key}) : super(key: key);

  @override
  State<NursesPage> createState() => _NursesPageState();
}

class _NursesPageState extends State<NursesPage> {
  int _selectedIndex = 1;
  String _selectedCategory = 'Semua';
  String _selectedSpecialization = 'Pilih spesialisasi';
  String _selectedExperience = 'Pilih pengalaman';
  String _selectedRating = 'Pilih rating';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = ['Semua', 'Perawat Anak', 'Perawat Lansia'];
  final List<String> _specializations = [
    'Pilih spesialisasi',
    'Perawatan Bayi',
    'Perkembangan Anak',
    'Kebutuhan Khusus',
    'Perawatan Lansia',
    'Rehabilitasi'
  ];
  final List<String> _experiences = [
    'Pilih pengalaman',
    '1-2 Tahun',
    '3-5 Tahun',
    '5+ Tahun'
  ];
  final List<String> _ratings = [
    'Pilih rating',
    '4.0+',
    '4.5+',
    '5.0'
  ];

  // Sample data perawat
  final List<Map<String, dynamic>> _nurses = [
    {
      'name': 'Rafli Afriza Nugraha',
      'rating': 5.0,
      'reviews': 28,
      'specialty': 'Perawat Anak',
      'experience': '4 Tahun',
      'description': 'Fokus pada perkembangan anak usia dini dengan pendekatan bermain sambil belajar.',
      'location': 'Banda Aceh',
      'price': 350000,
      'category': 'Perawat Anak',
    },
    {
      'name': 'Siti Nurhaliza',
      'rating': 4.8,
      'reviews': 45,
      'specialty': 'Perawat Anak',
      'experience': '6 Tahun',
      'description': 'Spesialis perawatan bayi baru lahir dengan sertifikasi internasional.',
      'location': 'Jakarta',
      'price': 450000,
      'category': 'Perawat Anak',
    },
    {
      'name': 'Ahmad Ridwan',
      'rating': 4.9,
      'reviews': 32,
      'specialty': 'Perawat Lansia',
      'experience': '8 Tahun',
      'description': 'Berpengalaman dalam perawatan lansia dengan kondisi khusus.',
      'location': 'Bandung',
      'price': 400000,
      'category': 'Perawat Lansia',
    },
    {
      'name': 'Dewi Kartika',
      'rating': 4.7,
      'reviews': 22,
      'specialty': 'Perawat Anak',
      'experience': '3 Tahun',
      'description': 'Ahli dalam stimulasi perkembangan motorik dan kognitif anak.',
      'location': 'Surabaya',
      'price': 375000,
      'category': 'Perawat Anak',
    },
    {
      'name': 'Budi Santoso',
      'rating': 4.6,
      'reviews': 18,
      'specialty': 'Perawat Lansia',
      'experience': '5 Tahun',
      'description': 'Fokus pada perawatan lansia dengan penyakit kronis.',
      'location': 'Medan',
      'price': 380000,
      'category': 'Perawat Lansia',
    },
  ];

  List<Map<String, dynamic>> get _filteredNurses {
    return _nurses.where((nurse) {
      bool matchesCategory = _selectedCategory == 'Semua' || nurse['category'] == _selectedCategory;
      bool matchesSearch = nurse['name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                          nurse['specialty'].toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
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
          // Header Section
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Temukan Perawat Terbaik',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Pilih perawat anak dan lansia profesional yang sesuai dengan kebutuhan Anda.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24),
                
                // Category Tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((category) {
                      bool isSelected = _selectedCategory == category;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 12),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xFFE91E63) : Colors.grey[100],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[600],
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                
                // Search Bar
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Cari perawat . . .',
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
              ],
            ),
          ),
          
          // Filters Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            height: 60,
            child: Row(
              children: [
                Expanded(child: _buildFilterDropdown('Spesialisasi', _selectedSpecialization, _specializations, (value) {
                  setState(() {
                    _selectedSpecialization = value!;
                  });
                })),
                SizedBox(width: 12),
                Expanded(child: _buildFilterDropdown('Pengalaman', _selectedExperience, _experiences, (value) {
                  setState(() {
                    _selectedExperience = value!;
                  });
                })),
                SizedBox(width: 12),
                Expanded(child: _buildFilterDropdown('Rating', _selectedRating, _ratings, (value) {
                  setState(() {
                    _selectedRating = value!;
                  });
                })),
              ],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Nurses List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              itemCount: _filteredNurses.length,
              itemBuilder: (context, index) {
                final nurse = _filteredNurses[index];
                return _buildNurseCard(nurse);
              },
            ),
          ),
          
          // Load More Button
          Padding(
            padding: EdgeInsets.all(24),
            child: OutlinedButton(
              onPressed: () {
                // TODO: Load more nurses
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Muat Lebih Banyak',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              // Already on nurses page
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/education');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFFE91E63),
        unselectedItemColor: Colors.grey[500],
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Perawat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Edukasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            label,
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
          style: TextStyle(color: Colors.black87, fontSize: 14),
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNurseCard(Map<String, dynamic> nurse) {
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
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nurse['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
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
                          '( ${nurse['reviews']} ulasan )',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context, 
                    '/nurse-profile',
                    arguments: nurse,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFFE91E63),
                  side: BorderSide(color: Color(0xFFE91E63)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Lihat Profil',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFE91E63).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
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
              Icon(Icons.work_outline, size: 16, color: Colors.grey[500]),
              SizedBox(width: 4),
              Text(
                nurse['experience'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 12),
              Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[500]),
              SizedBox(width: 4),
              Text(
                nurse['location'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
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
          ),
          SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context, 
                    '/nurse-profile',
                    arguments: nurse,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE91E63),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Pesan Sekarang',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}