// lib/pages/booking_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({Key? key}) : super(key: key);

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  
  String _selectedDate = 'Pilih tanggal';
  String _selectedTime = 'Pilih waktu';
  String _selectedDuration = 'Harian';
  String _selectedServiceType = 'Perawatan di Rumah';
  
  final List<String> _durations = ['Harian', 'Mingguan', 'Bulanan'];
  final List<String> _serviceTypes = [
    'Perawatan di Rumah',
    'Perawatan di Klinik',
    'Konsultasi Online',
  ];
  
  final List<String> _timeSlots = [
    '08:00 - 12:00',
    '12:00 - 16:00',
    '16:00 - 20:00',
    '08:00 - 20:00 (Full Day)',
  ];

  bool _isEmergency = false;
  bool _needMedicalEquipment = false;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get nurse data from arguments
    final Map<String, dynamic>? nurse = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    if (nurse == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Data perawat tidak ditemukan')),
      );
    }

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
                  'Booking Perawat',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Lengkapi informasi pemesanan Anda',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Selected Nurse Info
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFE91E63).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE91E63).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFFE91E63),
                  child: Text(
                    nurse['name'].split(' ').map((e) => e[0]).take(2).join(),
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
                        nurse['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        nurse['specialty'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFE91E63),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 14),
                          SizedBox(width: 4),
                          Text(
                            '${nurse['rating']} (${nurse['reviews']} ulasan)',
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
                Text(
                  'Rp ${nurse['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}/hari',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE91E63),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Type
                    _buildSectionTitle('Jenis Layanan'),
                    _buildDropdownField(
                      label: 'Pilih jenis layanan',
                      value: _selectedServiceType,
                      items: _serviceTypes,
                      onChanged: (value) {
                        setState(() {
                          _selectedServiceType = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Date & Time
                    _buildSectionTitle('Jadwal'),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateField(),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildTimeField(),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildDropdownField(
                      label: 'Durasi layanan',
                      value: _selectedDuration,
                      items: _durations,
                      onChanged: (value) {
                        setState(() {
                          _selectedDuration = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Address
                    _buildSectionTitle('Alamat Layanan'),
                    _buildTextField(
                      controller: _addressController,
                      label: 'Alamat lengkap',
                      hint: 'Masukkan alamat lengkap untuk layanan',
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Alamat harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Additional Options
                    _buildSectionTitle('Opsi Tambahan'),
                    _buildCheckboxTile(
                      title: 'Layanan Darurat',
                      subtitle: 'Prioritas tinggi (+50% biaya)',
                      value: _isEmergency,
                      onChanged: (value) {
                        setState(() {
                          _isEmergency = value!;
                        });
                      },
                    ),
                    _buildCheckboxTile(
                      title: 'Peralatan Medis',
                      subtitle: 'Membutuhkan alat medis khusus',
                      value: _needMedicalEquipment,
                      onChanged: (value) {
                        setState(() {
                          _needMedicalEquipment = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Notes
                    _buildSectionTitle('Catatan Khusus'),
                    _buildTextField(
                      controller: _notesController,
                      label: 'Catatan untuk perawat',
                      hint: 'Informasi tambahan yang perlu diketahui perawat (opsional)',
                      maxLines: 4,
                    ),
                    SizedBox(height: 20),

                    // Terms Agreement
                    _buildCheckboxTile(
                      title: 'Setuju dengan syarat dan ketentuan',
                      subtitle: 'Saya telah membaca dan menyetujui syarat layanan',
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

          // Bottom Section with Price & Booking Button
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
                // Price Summary
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildPriceRow('Tarif ${_selectedDuration}', 'Rp ${nurse['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
                      if (_isEmergency) 
                        _buildPriceRow('Biaya Darurat (50%)', 'Rp ${(nurse['price'] * 0.5).toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
                      if (_needMedicalEquipment)
                        _buildPriceRow('Peralatan Medis', 'Rp 100.000'),
                      Divider(),
                      _buildPriceRow('Total', 'Rp ${_calculateTotal(nurse['price']).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}', isTotal: true),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                
                // Booking Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _agreeToTerms ? () {
                      if (_formKey.currentState!.validate()) {
                        _processBooking(nurse);
                      }
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE91E63),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Konfirmasi Booking',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(label),
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 90)),
        );
        if (picked != null) {
          setState(() {
            _selectedDate = "${picked.day}/${picked.month}/${picked.year}";
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[500], size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                _selectedDate,
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedDate == 'Pilih tanggal' ? Colors.grey[500] : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField() {
    return GestureDetector(
      onTap: () {
        _showTimeSlotDialog();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: Colors.grey[500], size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                _selectedTime,
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedTime == 'Pilih waktu' ? Colors.grey[500] : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
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
          borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: validator,
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
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? Color(0xFFE91E63) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showTimeSlotDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Waktu Layanan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _timeSlots.map((slot) {
            return ListTile(
              title: Text(slot),
              onTap: () {
                setState(() {
                  _selectedTime = slot;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  int _calculateTotal(int basePrice) {
    int total = basePrice;
    if (_isEmergency) {
      total += (basePrice * 0.5).toInt();
    }
    if (_needMedicalEquipment) {
      total += 100000;
    }
    return total;
  }

  void _processBooking(Map<String, dynamic> nurse) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apakah Anda yakin ingin melanjutkan booking dengan detail:'),
            SizedBox(height: 16),
            Text('• Perawat: ${nurse['name']}'),
            Text('• Tanggal: $_selectedDate'),
            Text('• Waktu: $_selectedTime'),
            Text('• Durasi: $_selectedDuration'),
            Text('• Total: Rp ${_calculateTotal(nurse['price']).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
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
              Navigator.pop(context);
              Navigator.pushNamed(context, '/my-bookings');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking berhasil! Kami akan menghubungi Anda segera.'),
                  backgroundColor: Color(0xFFE91E63),
                ),
              );
            },
            child: Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }
}