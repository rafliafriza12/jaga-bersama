// lib/pages/user/chat_support_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatSupportPage extends StatefulWidget {
  const ChatSupportPage({Key? key}) : super(key: key);

  @override
  State<ChatSupportPage> createState() => _ChatSupportPageState();
}

class _ChatSupportPageState extends State<ChatSupportPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<Map<String, dynamic>> _messages = [
    {
      'id': '1',
      'message': 'Halo! Selamat datang di JagaBersama. Saya adalah asisten virtual Anda. Ada yang bisa saya bantu hari ini?',
      'isUser': false,
      'timestamp': DateTime.now().subtract(Duration(minutes: 5)),
      'senderName': 'Customer Service',
      'senderRole': 'admin',
    },
  ];

  final List<Map<String, String>> _quickReplies = [
    {'text': 'Cara booking perawat', 'action': 'booking_help'},
    {'text': 'Masalah pembayaran', 'action': 'payment_help'},
    {'text': 'Ubah jadwal booking', 'action': 'reschedule_help'},
    {'text': 'Keluhan perawat', 'action': 'complaint'},
    {'text': 'Cara membatalkan booking', 'action': 'cancel_help'},
    {'text': 'Hubungi operator', 'action': 'human_agent'},
  ];

  bool _isTyping = false;
  bool _isOnline = true;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFFE91E63),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.support_agent,
                    color: Color(0xFFE91E63),
                    size: 24,
                  ),
                ),
                if (_isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer Service',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _isOnline ? 'Online - Biasanya membalas dalam beberapa menit' : 'Offline',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Colors.white),
            onPressed: () {
              _showCallOptions();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              _showChatOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          
          // Quick Replies
          if (_quickReplies.isNotEmpty) _buildQuickReplies(),
          
          // Message Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    bool isUser = message['isUser'];
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE91E63),
              child: Icon(
                Icons.support_agent,
                color: Colors.white,
                size: 16,
              ),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isUser && message['senderName'] != null)
                  Padding(
                    padding: EdgeInsets.only(left: 12, bottom: 4),
                    child: Text(
                      message['senderName'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUser ? Color(0xFFE91E63) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message['message'],
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _formatTime(message['timestamp']),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE91E63),
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFE91E63),
            child: Icon(
              Icons.support_agent,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                SizedBox(width: 4),
                _buildTypingDot(1),
                SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildQuickReplies() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: _quickReplies.length,
        itemBuilder: (context, index) {
          final reply = _quickReplies[index];
          return Container(
            margin: EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(
                reply['text']!,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFE91E63),
                ),
              ),
              backgroundColor: Colors.white,
              side: BorderSide(color: Color(0xFFE91E63)),
              onPressed: () {
                _handleQuickReply(reply['action']!, reply['text']!);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file, color: Colors.grey[600]),
            onPressed: () {
              _showAttachmentOptions();
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ketik pesan...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            backgroundColor: Color(0xFFE91E63),
            child: Icon(Icons.send, color: Colors.white, size: 20),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'message': _messageController.text.trim(),
        'isUser': true,
        'timestamp': DateTime.now(),
      });
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate admin response
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'message': _generateAutoResponse(_messages[_messages.length - 1]['message']),
            'isUser': false,
            'timestamp': DateTime.now(),
            'senderName': 'Customer Service',
            'senderRole': 'admin',
          });
        });
        _scrollToBottom();
      }
    });
  }

  void _handleQuickReply(String action, String text) {
    setState(() {
      _messages.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'message': text,
        'isUser': true,
        'timestamp': DateTime.now(),
      });
      _isTyping = true;
    });

    _scrollToBottom();

    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'message': _getQuickReplyResponse(action),
            'isUser': false,
            'timestamp': DateTime.now(),
            'senderName': 'Customer Service',
            'senderRole': 'admin',
          });
        });
        _scrollToBottom();
      }
    });
  }

  String _generateAutoResponse(String userMessage) {
    String message = userMessage.toLowerCase();
    
    if (message.contains('booking') || message.contains('pesan')) {
      return 'Untuk melakukan booking, Anda bisa pergi ke halaman "Perawat", pilih perawat yang diinginkan, lalu klik "Pesan Sekarang". Apakah ada yang perlu saya bantu terkait proses booking?';
    } else if (message.contains('bayar') || message.contains('pembayaran')) {
      return 'Kami menerima berbagai metode pembayaran seperti transfer bank, e-wallet (GoPay, OVO, DANA), dan kartu kredit. Pembayaran dilakukan setelah konfirmasi booking. Ada masalah dengan pembayaran Anda?';
    } else if (message.contains('batal') || message.contains('cancel')) {
      return 'Anda dapat membatalkan booking hingga 12 jam sebelum jadwal layanan tanpa dikenakan biaya. Untuk pembatalan kurang dari 12 jam, akan ada biaya administrasi. Apakah Anda ingin membatalkan booking tertentu?';
    } else if (message.contains('harga') || message.contains('tarif')) {
      return 'Tarif perawat bervariasi tergantung spesialisasi dan pengalaman, mulai dari Rp 250.000 hingga Rp 500.000 per hari. Anda bisa melihat tarif detail di profil masing-masing perawat.';
    } else {
      return 'Terima kasih atas pertanyaan Anda. Tim customer service kami akan membantu mencarikan solusi terbaik. Apakah ada hal spesifik lainnya yang bisa saya bantu?';
    }
  }

  String _getQuickReplyResponse(String action) {
    switch (action) {
      case 'booking_help':
        return 'Untuk booking perawat:\n1. Buka halaman "Perawat"\n2. Gunakan filter untuk mencari sesuai kebutuhan\n3. Pilih perawat dan lihat profil\n4. Klik "Pesan Sekarang"\n5. Isi detail pemesanan\n6. Konfirmasi dan lakukan pembayaran\n\nApakah ada langkah yang perlu dijelaskan lebih detail?';
      case 'payment_help':
        return 'Terkait pembayaran, kami menerima:\n• Transfer Bank (BCA, Mandiri, BNI, BRI)\n• E-Wallet (GoPay, OVO, DANA)\n• Kartu Kredit (Visa, Mastercard)\n• Tunai kepada perawat\n\nJika ada masalah pembayaran, mohon berikan detail ordernya.';
      case 'reschedule_help':
        return 'Untuk mengubah jadwal booking:\n1. Buka "Pemesanan Saya"\n2. Pilih booking yang ingin diubah\n3. Klik "Ubah Jadwal"\n4. Pilih tanggal/waktu baru\n5. Konfirmasi perubahan\n\nPerubahan dapat dilakukan minimal 6 jam sebelum jadwal.';
      case 'complaint':
        return 'Kami sangat serius menangani keluhan. Mohon berikan detail:\n• Nama perawat\n• Tanggal layanan\n• Deskripsi masalah\n• Bukti jika ada\n\nTim kami akan menindaklanjuti dalam 24 jam.';
      case 'cancel_help':
        return 'Kebijakan pembatalan:\n• >12 jam sebelum jadwal: GRATIS\n• 6-12 jam sebelum: Biaya admin 25%\n• <6 jam: Biaya admin 50%\n• Pembatalan darurat: Hubungi CS\n\nUntuk membatalkan, buka "Pemesanan Saya" > pilih booking > "Batalkan".';
      case 'human_agent':
        return 'Saya akan menghubungkan Anda dengan operator manusia. Mohon tunggu sebentar...\n\n*Operator sedang bergabung ke chat*';
      default:
        return 'Terima kasih. Tim kami akan membantu Anda dengan pertanyaan ini.';
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  void _showCallOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.phone, color: Color(0xFFE91E63)),
              title: Text('Telepon Customer Service'),
              subtitle: Text('+62 21 1234 5678'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement phone call
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam, color: Color(0xFFE91E63)),
              title: Text('Video Call'),
              subtitle: Text('Hubungi via video call'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement video call
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.history, color: Color(0xFFE91E63)),
              title: Text('Riwayat Chat'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show chat history
              },
            ),
            ListTile(
              leading: Icon(Icons.download, color: Color(0xFFE91E63)),
              title: Text('Unduh Transkrip'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Download transcript
              },
            ),
            ListTile(
              leading: Icon(Icons.block, color: Colors.red),
              title: Text('Laporkan Masalah'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Report issue
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo, color: Color(0xFFE91E63)),
              title: Text('Kirim Foto'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Send photo
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_file, color: Color(0xFFE91E63)),
              title: Text('Kirim File'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Send file
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Color(0xFFE91E63)),
              title: Text('Kirim Lokasi'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Send location
              },
            ),
          ],
        ),
      ),
    );
  }
}