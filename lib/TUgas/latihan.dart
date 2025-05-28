import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class Tugas7 extends StatefulWidget {
  const Tugas7({super.key});
  static const String id = "/meet_7";

  @override
  State<Tugas7> createState() => _Tugas7State();
}

class _Tugas7State extends State<Tugas7> {
  int _selectedMenu = 0;
  bool _isChecked = false;
  String? _selectedCategory;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<String> _categories = [
    'Elektronik',
    'Pakaian',
    'Makanan',
    'Lainnya',
  ];

  String _getMonthName(int month) {
    const months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month];
  }

  TextStyle getTitleStyle(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white : Colors.black,
    );
  }

  TextStyle getBodyStyle(BuildContext context, {Color? color}) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return GoogleFonts.poppins(
      fontSize: 16,
      color: color ?? (isDark ? Colors.white : Colors.black87),
    );
  }

  Widget _buildCard({required Widget child}) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildMenuContent() {
    switch (_selectedMenu) {
      case 0:
        return _buildCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Syarat & Ketentuan', style: getTitleStyle(context)),
              const SizedBox(height: 20),
              CheckboxListTile(
                value: _isChecked,
                onChanged: (val) => setState(() => _isChecked = val ?? false),
                title: Text(
                  'Saya menyetujui semua persyaratan yang berlaku',
                  style: getBodyStyle(context),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 12),
              Text(
                _isChecked
                    ? '✅ Anda bisa melanjutkan.'
                    : '⚠️ Silakan setujui syarat terlebih dahulu.',
                style: getBodyStyle(
                  context,
                  color: _isChecked ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        );
      case 1:
        return Consumer<ThemeProvider>(
          builder:
              (context, themeProvider, _) => _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mode Tampilan', style: getTitleStyle(context)),
                    const SizedBox(height: 20),
                    SwitchListTile(
                      value: themeProvider.isDarkMode,
                      onChanged: (_) => themeProvider.toggleTheme(),
                      title: Text(
                        'Aktifkan Mode Gelap',
                        style: getBodyStyle(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      themeProvider.isDarkMode
                          ? '🌙 Mode Gelap Aktif'
                          : '☀️ Mode Terang Aktif',
                      style: getBodyStyle(context),
                    ),
                  ],
                ),
              ),
        );
      case 2:
        return _buildCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kategori Produk', style: getTitleStyle(context)),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items:
                    _categories
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: getBodyStyle(context)),
                          ),
                        )
                        .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val),
                decoration: InputDecoration(
                  hintText: 'Pilih kategori',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _selectedCategory == null
                    ? 'Kategori belum dipilih.'
                    : 'Kategori: $_selectedCategory',
                style: getBodyStyle(context),
              ),
            ],
          ),
        );
      case 3:
        return _buildCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tanggal Lahir', style: getTitleStyle(context)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => _selectedDate = picked);
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Pilih Tanggal'),
              ),
              const SizedBox(height: 16),
              Text(
                _selectedDate == null
                    ? 'Belum ada tanggal dipilih.'
                    : '📅 ${_selectedDate!.day} ${_getMonthName(_selectedDate!.month)} ${_selectedDate!.year}',
                style: getBodyStyle(context),
              ),
            ],
          ),
        );
      case 4:
        return _buildCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pengingat', style: getTitleStyle(context)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) setState(() => _selectedTime = picked);
                },
                icon: const Icon(Icons.access_time),
                label: const Text('Pilih Waktu'),
              ),
              const SizedBox(height: 16),
              Text(
                _selectedTime == null
                    ? 'Belum ada waktu dipilih.'
                    : '⏰ ${_selectedTime!.format(context)}',
                style: getBodyStyle(context),
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tugas 7',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : const Color(0xff6A0DAD),
      ),
      drawer: Drawer(
        backgroundColor: isDark ? Colors.black : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : const Color(0xff6A0DAD),
              ),
              child: Center(
                child: Text(
                  'Menu Input',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            ...[
              {'icon': Icons.check_box, 'label': 'Syarat & Ketentuan'},
              {'icon': Icons.dark_mode, 'label': 'Mode Gelap'},
              {'icon': Icons.category, 'label': 'Kategori Produk'},
              {'icon': Icons.date_range, 'label': 'Tanggal Lahir'},
              {'icon': Icons.access_time, 'label': 'Pengingat'},
            ].asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return ListTile(
                leading: Icon(
                  item['icon'] as IconData,
                  color: isDark ? Colors.white : Colors.black,
                ),
                title: Text(
                  item['label'] as String,
                  style: GoogleFonts.poppins(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                hoverColor: isDark ? Colors.grey[800] : Colors.grey[200],
                onTap: () {
                  setState(() => _selectedMenu = index);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
      backgroundColor: isDark ? Colors.grey[900] : const Color(0xFFF4F4F4),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          key: ValueKey(_selectedMenu),
          padding: const EdgeInsets.all(16.0),
          child: _buildMenuContent(),
        ),
      ),
    );
  }
}
