// lib/pages/user/search_filter_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchFilterPage extends StatefulWidget {
  const SearchFilterPage({Key? key}) : super(key: key);

  @override
  State<SearchFilterPage> createState() => _SearchFilterPageState();
}

class _SearchFilterPageState extends State<SearchFilterPage> {
  final TextEditingController _searchController = TextEditingController();
  
  // Filter variables
  List<String> _selectedSpecialties = [];
  List<String> _selectedLocations = [];
  RangeValues _priceRange = RangeValues(200000, 800000);
  RangeValues _experienceRange = RangeValues(1, 10);
  double _minRating = 4.0;
  List<String> _selectedAvailability = [];
  List<String> _selectedGender = [];
  List<String> _selectedCertifications = [];
  bool _emergencyOnly = false;
  bool _hasTransportation = false;
  bool _canWorkWeekends = false;

  // Filter options
  final List<String> _specialties = [
    'Perawat Anak',
    'Perawat Lansia',
    'Perawat Umum',
    'Perawat ICU',
    'Perawat Rehabilitasi',
    'Perawat Paliatif',
    'Perawat Jiwa',
    'Perawat Maternitas',
  ];

  final List<String> _locations = [
    'Jakarta',
    'Bandung',
    'Surabaya',
    'Medan',
    'Banda Aceh',
    'Yogyakarta',
    'Semarang',
    'Makassar',
    'Denpasar',
    'Palembang',
  ];

  final List<String> _availabilityOptions = [
    'Pagi (06:00-12:00)',
    'Siang (12:00-18:00)',
    'Malam (18:00-24:00)',
    'Dini Hari (00:00-06:00)',
    '24 Jam',
  ];

  final List<String> _genderOptions = [
    'Pria',
    'Wanita',
  ];

  final List<String> _certificationOptions = [
    'STR (Surat Tanda Registrasi)',
    'BLS (Basic Life Support)',
    'ACLS (Advanced Cardiac Life Support)',
    'BTCLS (Basic Trauma Cardiac Life Support)',
    'Sertifikat Perawatan Anak',
    'Sertifikat Perawatan Lansia',
    'Sertifikat Perawatan Luka',
    'Sertifikat Rehabilitasi',
  ];

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
        title: Text(
          'Filter Pencarian',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: Text(
              'Reset',
              style: TextStyle(
                color: Color(0xFFE91E63),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(24),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari nama perawat, spesialisasi, lokasi...',
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

          // Filter Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Filters
                  _buildQuickFilters(),
                  SizedBox(height: 24),

                  // Specialty Filter
                  _buildFilterSection(
                    'Spesialisasi',
                    _buildChipFilter(_specialties, _selectedSpecialties),
                  ),

                  // Location Filter
                  _buildFilterSection(
                    'Lokasi',
                    _buildChipFilter(_locations, _selectedLocations),
                  ),

                  // Price Range
                  _buildFilterSection(
                    'Rentang Harga (per hari)',
                    _buildPriceRangeFilter(),
                  ),

                  // Experience Range
                  _buildFilterSection(
                    'Pengalaman (tahun)',
                    _buildExperienceRangeFilter(),
                  ),

                  // Rating Filter
                  _buildFilterSection(
                    'Rating Minimum',
                    _buildRatingFilter(),
                  ),

                  // Availability Filter
                  _buildFilterSection(
                    'Ketersediaan Waktu',
                    _buildChipFilter(_availabilityOptions, _selectedAvailability),
                  ),

                  // Gender Filter
                  _buildFilterSection(
                    'Jenis Kelamin',
                    _buildChipFilter(_genderOptions, _selectedGender),
                  ),

                  // Certification Filter
                  _buildFilterSection(
                    'Sertifikasi',
                    _buildChipFilter(_certificationOptions, _selectedCertifications),
                  ),

                  // Additional Options
                  _buildFilterSection(
                    'Opsi Tambahan',
                    _buildAdditionalOptions(),
                  ),

                  SizedBox(height: 100), // Space for floating button
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: FloatingActionButton.extended(
          onPressed: _applyFilters,
          backgroundColor: Color(0xFFE91E63),
          icon: Icon(Icons.search),
          label: Text('Terapkan Filter'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildQuickFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter Cepat',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildQuickFilterChip('Rating Tinggi (4.5+)', () {
              setState(() {
                _minRating = 4.5;
              });
            }),
            _buildQuickFilterChip('Harga Terjangkau', () {
              setState(() {
                _priceRange = RangeValues(200000, 400000);
              });
            }),
            _buildQuickFilterChip('Tersedia Hari Ini', () {
              setState(() {
                _selectedAvailability = ['24 Jam'];
              });
            }),
            _buildQuickFilterChip('Perawat Anak', () {
              setState(() {
                _selectedSpecialties = ['Perawat Anak'];
              });
            }),
            _buildQuickFilterChip('Perawat Lansia', () {
              setState(() {
                _selectedSpecialties = ['Perawat Lansia'];
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickFilterChip(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFE91E63).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFFE91E63).withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFE91E63),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
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
        content,
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildChipFilter(List<String> options, List<String> selectedOptions) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        bool isSelected = selectedOptions.contains(option);
        return FilterChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                selectedOptions.add(option);
              } else {
                selectedOptions.remove(option);
              }
            });
          },
          selectedColor: Color(0xFFE91E63).withOpacity(0.2),
          checkmarkColor: Color(0xFFE91E63),
          labelStyle: TextStyle(
            color: isSelected ? Color(0xFFE91E63) : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceRangeFilter() {
    return Column(
      children: [
        RangeSlider(
          values: _priceRange,
          min: 100000,
          max: 1000000,
          divisions: 18,
          activeColor: Color(0xFFE91E63),
          labels: RangeLabels(
            'Rp ${(_priceRange.start / 1000).toInt()}k',
            'Rp ${(_priceRange.end / 1000).toInt()}k',
          ),
          onChanged: (values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rp ${(_priceRange.start).toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE91E63),
              ),
            ),
            Text(
              'Rp ${(_priceRange.end).toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE91E63),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceRangeFilter() {
    return Column(
      children: [
        RangeSlider(
          values: _experienceRange,
          min: 1,
          max: 20,
          divisions: 19,
          activeColor: Color(0xFFE91E63),
          labels: RangeLabels(
            '${_experienceRange.start.toInt()} tahun',
            '${_experienceRange.end.toInt()} tahun',
          ),
          onChanged: (values) {
            setState(() {
              _experienceRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_experienceRange.start.toInt()} tahun',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE91E63),
              ),
            ),
            Text(
              '${_experienceRange.end.toInt()} tahun',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE91E63),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      children: [
        Slider(
          value: _minRating,
          min: 1.0,
          max: 5.0,
          divisions: 8,
          activeColor: Color(0xFFE91E63),
          label: '${_minRating.toStringAsFixed(1)}⭐',
          onChanged: (value) {
            setState(() {
              _minRating = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('1.0⭐', style: TextStyle(color: Colors.grey[600])),
            Text(
              'Min: ${_minRating.toStringAsFixed(1)}⭐',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE91E63),
              ),
            ),
            Text('5.0⭐', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalOptions() {
    return Column(
      children: [
        CheckboxListTile(
          title: Text('Layanan Darurat'),
          subtitle: Text('Perawat yang tersedia untuk layanan darurat'),
          value: _emergencyOnly,
          onChanged: (value) {
            setState(() {
              _emergencyOnly = value!;
            });
          },
          activeColor: Color(0xFFE91E63),
        ),
        CheckboxListTile(
          title: Text('Memiliki Transportasi'),
          subtitle: Text('Perawat yang memiliki kendaraan sendiri'),
          value: _hasTransportation,
          onChanged: (value) {
            setState(() {
              _hasTransportation = value!;
            });
          },
          activeColor: Color(0xFFE91E63),
        ),
        CheckboxListTile(
          title: Text('Bisa Bekerja Weekend'),
          subtitle: Text('Tersedia untuk layanan Sabtu-Minggu'),
          value: _canWorkWeekends,
          onChanged: (value) {
            setState(() {
              _canWorkWeekends = value!;
            });
          },
          activeColor: Color(0xFFE91E63),
        ),
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedSpecialties.clear();
      _selectedLocations.clear();
      _priceRange = RangeValues(200000, 800000);
      _experienceRange = RangeValues(1, 10);
      _minRating = 4.0;
      _selectedAvailability.clear();
      _selectedGender.clear();
      _selectedCertifications.clear();
      _emergencyOnly = false;
      _hasTransportation = false;
      _canWorkWeekends = false;
    });
  }

  void _applyFilters() {
    // Create filter object to pass back
    Map<String, dynamic> filters = {
      'searchQuery': _searchController.text,
      'specialties': _selectedSpecialties,
      'locations': _selectedLocations,
      'priceRange': _priceRange,
      'experienceRange': _experienceRange,
      'minRating': _minRating,
      'availability': _selectedAvailability,
      'gender': _selectedGender,
      'certifications': _selectedCertifications,
      'emergencyOnly': _emergencyOnly,
      'hasTransportation': _hasTransportation,
      'canWorkWeekends': _canWorkWeekends,
    };

    // Return to previous page with filters
    Navigator.pop(context, filters);
    
    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filter diterapkan! Menampilkan hasil pencarian...'),
        backgroundColor: Color(0xFFE91E63),
        duration: Duration(seconds: 2),
      ),
    );
  }
}