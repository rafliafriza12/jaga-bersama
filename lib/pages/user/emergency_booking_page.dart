// lib/pages/user/emergency_booking_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmergencyBookingPage extends StatefulWidget {
  const EmergencyBookingPage({Key? key}) : super(key: key);

  @override
  State<EmergencyBookingPage> createState() => _EmergencyBookingPageState();
}

class _EmergencyBookingPageState extends State<EmergencyBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _emergencyDescriptionController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _contactNumberController = TextEditingController();

  String _selectedEmergencyType = '';
  String _selectedUrgencyLevel = '';
  bool _needAmbulance = false;
  bool _hasInsurance = false;
  bool _agreeToTerms = false;

  final List<Map<String, dynamic>> _emergencyTypes = [
    {
      'title': 'Kecelakaan',
      'description': 'Kecelakaan rumah tangga, terjatuh, luka',
      'icon': Icons.local_hospital,
      'color': Colors.red,
    },
    {
      'title': 'Sesak Napas',
      'description': 'Kesulitan bernapas, asma akut',
      'icon': Icons.air,
      'color': Colors.blue,
    },
    {
      'title': 'Demam Tinggi',
      'description': 'Demam >39°C, kejang demam',
      'icon': Icons.thermostat,
      'color': Colors.orange,
    },
    {
      'title': 'Nyeri Dada',
      'description': 'Nyeri dada, serangan jantung',
      'icon': Icons.favorite,
      'color': Colors.red[800]!,
    },
    {
      'title': 'Pingsan',
      'description': 'Kehilangan kesadaran, lemas',
      'icon': Icons.person_off,
      'color': Colors.purple,
    },
    {
      'title': 'Stroke',
      'description': 'Gejala stroke, lumpuh mendadak',
      'icon': Icons.psychology,
      'color': Colors.indigo,
    },
    {
      'title': 'Lainnya',
      'description': 'Kondisi darurat lainnya',
      'icon': Icons.medical_services,
      'color': Colors.grey[700]!,
    },
  ];

  final List<Map<String, dynamic>> _urgencyLevels = [
    {
      'level': 'Kritis',
      'description': 'Mengancam nyawa, butuh pertolongan segera',
      'color': Colors.red,
      'eta': '5-10 menit',
    },
    {
      'level': 'Darurat',
      'description': 'Perlu pertolongan cepat',
      'color': Colors.orange,
      'eta': '10-20 menit',
    },
    {
      'level': 'Mendesak',
      'description': 'Perlu pertolongan dalam waktu dekat',
      'color': Colors.yellow[700]!,
      'eta': '20-30 menit',
    },
  ];

  @override
  void dispose() {
    _addressController.dispose();
    _emergencyDescriptionController.dispose();
    _contactPersonController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(
              Icons.emergency,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              'Panggilan Darurat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  '24/7',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Emergency Banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red, Colors.red[700]!],
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.warning_amber,
                  color: Colors.white,
                  size: 48,
                ),
                SizedBox(height: 8),
                Text(
                  'Layanan Darurat 24/7',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tim medis profesional siap membantu',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Emergency Type Selection
                    _buildSectionTitle('Jenis Kondisi Darurat'),
                    _buildEmergencyTypeSelection(),
                    SizedBox(height: 24),

                    // Urgency Level
                    _buildSectionTitle('Tingkat Urgensi'),
                    _buildUrgencyLevelSelection(),
                    SizedBox(height: 24),

                    // Emergency Description
                    _buildSectionTitle('Deskripsi Kondisi'),
                    _buildTextField(
                      controller: _emergencyDescriptionController,
                      label: 'Jelaskan kondisi pasien',
                      hint: 'Deskripsikan gejala, kondisi saat ini, dan hal penting lainnya...',
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deskripsi kondisi harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),

                    // Contact Information
                    _buildSectionTitle('Informasi Kontak'),
                    _buildTextField(
                      controller: _contactPersonController,
                      label: 'Nama Penanggung Jawab',
                      hint: 'Nama lengkap yang bisa dihubungi',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama penanggung jawab harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _contactNumberController,
                      label: 'Nomor Telepon Aktif',
                      hint: 'Nomor yang bisa dihubungi segera',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor telepon harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),

                    // Location
                    _buildSectionTitle('Lokasi Darurat'),
                    _buildTextField(
                      controller: _addressController,
                      label: 'Alamat Lengkap',
                      hint: 'Masukkan alamat detail termasuk patokan',
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Alamat harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Get current location
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Mendapatkan lokasi saat ini...'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      icon: Icon(Icons.my_location),
                      label: Text('Gunakan Lokasi Saat Ini'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Additional Options
                    _buildSectionTitle('Opsi Tambahan'),
                    _buildCheckboxTile(
                      title: 'Perlu Ambulans',
                      subtitle: 'Membutuhkan transportasi darurat',
                      value: _needAmbulance,
                      onChanged: (value) {
                        setState(() {
                          _needAmbulance = value!;
                        });
                      },
                    ),
                    _buildCheckboxTile(
                      title: 'Memiliki Asuransi Kesehatan',
                      subtitle: 'Biaya dapat ditanggung asuransi',
                      value: _hasInsurance,
                      onChanged: (value) {
                        setState(() {
                          _hasInsurance = value!;
                        });
                      },
                    ),
                    SizedBox(height: 24),

                    // Terms Agreement
                    _buildCheckboxTile(
                      title: 'Setuju dengan ketentuan layanan darurat',
                      subtitle: 'Saya memahami biaya dan prosedur layanan darurat',
                      value: _agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeToTerms = value!;
                        });
                      },
                      isRequired: true,
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Section with Emergency Actions
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Emergency Info
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.red),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Biaya Layanan Darurat',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[800],
                              ),
                            ),
                            Text(
                              'Rp 750.000 - 1.500.000 (tergantung jarak & kondisi)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Emergency Call Button
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _callEmergencyHotline();
                        },
                        icon: Icon(Icons.phone, color: Colors.red),
                        label: Text('Call 112'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: BorderSide(color: Colors.red),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: _agreeToTerms && _selectedEmergencyType.isNotEmpty && _selectedUrgencyLevel.isNotEmpty
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  _requestEmergencyService();
                                }
                              }
                            : null,
                        icon: Icon(Icons.emergency),
                        label: Text('PANGGIL DARURAT'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildEmergencyTypeSelection() {
    return Column(
      children: _emergencyTypes.map((type) {
        bool isSelected = _selectedEmergencyType == type['title'];
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedEmergencyType = type['title'];
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? type['color'].withOpacity(0.1) : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? type['color'] : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    type['icon'],
                    color: isSelected ? type['color'] : Colors.grey[600],
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? type['color'] : Colors.black87,
                          ),
                        ),
                        Text(
                          type['description'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: type['color'],
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUrgencyLevelSelection() {
    return Column(
      children: _urgencyLevels.map((level) {
        bool isSelected = _selectedUrgencyLevel == level['level'];
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedUrgencyLevel = level['level'];
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? level['color'].withOpacity(0.1) : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? level['color'] : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: level['color'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              level['level'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? level['color'] : Colors.black87,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'ETA: ${level['eta']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          level['description'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: level['color'],
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool?) onChanged,
    bool isRequired = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: CheckboxListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.red,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  void _callEmergencyHotline() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.phone, color: Colors.red),
            SizedBox(width: 8),
            Text('Panggilan Darurat'),
          ],
        ),
        content: Text('Menghubungi layanan darurat 112?\n\nAnda akan dihubungkan dengan operator darurat nasional.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Make emergency call
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Menghubungi 112...'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Hubungi 112'),
          ),
        ],
      ),
    );
  }

  void _requestEmergencyService() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: Colors.red),
            SizedBox(width: 8),
            Text('Konfirmasi Darurat'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detail Panggilan Darurat:'),
            SizedBox(height: 12),
            Text('• Jenis: $_selectedEmergencyType'),
            Text('• Urgensi: $_selectedUrgencyLevel'),
            Text('• Kontak: ${_contactPersonController.text}'),
            Text('• Telepon: ${_contactNumberController.text}'),
            if (_needAmbulance) Text('• Membutuhkan ambulans'),
            SizedBox(height: 12),
            Text(
              'Tim medis akan segera dikirim ke lokasi Anda.',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
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
              Navigator.pushReplacementNamed(context, '/emergency-tracking');
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Panggilan darurat berhasil! Tim medis sedang menuju lokasi Anda.'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('KONFIRMASI DARURAT'),
          ),
        ],
      ),
    );
  }
}