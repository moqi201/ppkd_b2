// lib/tugas_15/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_15/api/get_user.dart';
import 'package:ppkd_b2/tugas_15/model/user.dart';
import 'package:ppkd_b2/tugas_15/view/auth/login.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});
  static const String id = "/home_screen";

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final UserService _userService = UserService();
  User_Model? _userProfile;
  bool _isLoadingProfile = true;
  String? _profileError;
  bool _isSavingProfile = false;

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserProfile() async {
    setState(() {
      _isLoadingProfile = true;
      _profileError = null;
    });
    try {
      final User_Model user = await _userService.getProfile();
      setState(() {
        _userProfile = user;
        _nameController.text = user.name ?? '';
      });
      if (mounted) {
        ElegantNotification.info(
          title: const Text("Info Profil"),
          description: const Text("Profil berhasil dimuat."),
          animation: AnimationType.fromRight, // DIUBAH DARI fromTop
          toastDuration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 400),
        ).show(context);
      }
    } catch (e) {
      setState(() {
        _profileError =
            'Gagal memuat profil: ${e.toString().replaceFirst('Exception: ', '')}';
      });
      print('DEBUG (HomeScreen): Error saat memuat profil: $e');

      if (e.toString().contains('Unauthorized') ||
          e.toString().contains('token not found') ||
          e.toString().contains('Please log in again')) {
        print(
          'DEBUG (HomeScreen): Token tidak valid/tidak ditemukan. Mengarahkan ke Login Screen.',
        );
        await _userService.logout();
        if (mounted) {
          ElegantNotification.error(
            title: const Text("Sesi Berakhir"),
            description: const Text("Silakan login kembali."),
            animation: AnimationType.fromRight, // DIUBAH DARI fromBottom
            toastDuration: const Duration(seconds: 4),
            animationDuration: const Duration(milliseconds: 600),
          ).show(context);

          Navigator.of(context).pushNamedAndRemoveUntil(
            loginScreenApi.id,
            (Route<dynamic> route) => false,
          );
        }
      } else {
        if (mounted) {
          ElegantNotification.error(
            title: const Text("Error Profil"),
            description: Text(_profileError!),
            animation: AnimationType.fromRight, // DIUBAH DARI fromBottom
            toastDuration: const Duration(seconds: 4),
            animationDuration: const Duration(milliseconds: 600),
          ).show(context);
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingProfile = false;
        });
      }
    }
  }

  Future<void> _handleLogout() async {
    try {
      await _userService.logout();
      if (mounted) {
        ElegantNotification.success(
          title: const Text("Sukses"),
          description: const Text("Anda telah berhasil logout!"),
          animation: AnimationType.fromRight, // DIUBAH DARI fromBottom
          toastDuration: const Duration(seconds: 3),
          animationDuration: const Duration(milliseconds: 600),
        ).show(context);

        Navigator.of(context).pushNamedAndRemoveUntil(
          loginScreenApi.id,
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ElegantNotification.error(
          title: const Text("Gagal Logout"),
          description: Text(
            'Gagal logout: ${e.toString().replaceFirst('Exception: ', '')}',
          ),
          animation: AnimationType.fromRight, // DIUBAH DARI fromBottom
          toastDuration: const Duration(seconds: 4),
          animationDuration: const Duration(milliseconds: 600),
        ).show(context);
      }
      print('Error logout: $e');
    }
  }

  Future<void> _handleEditProfile() async {
    if (_userProfile == null) return;

    setState(() {
      _isSavingProfile = true;
    });

    try {
      final User_Model updatedUser = await _userService.editProfile(
        name: _nameController.text,
      );
      setState(() {
        _userProfile = updatedUser;
        if (mounted) {
          ElegantNotification.success(
            title: const Text("Profil Diperbarui"),
            description: const Text("Nama profil berhasil diperbarui!"),
            animation: AnimationType.fromRight, // DIUBAH DARI fromBottom
            toastDuration: const Duration(seconds: 3),
            animationDuration: const Duration(milliseconds: 600),
          ).show(context);
        }
      });
    } catch (e) {
      setState(() {
        _profileError =
            'Gagal memperbarui profil: ${e.toString().replaceFirst('Exception: ', '')}';
      });
      if (mounted) {
        ElegantNotification.error(
          title: const Text("Gagal Perbarui"),
          description: Text(_profileError!),
          animation: AnimationType.fromRight, // DIUBAH DARI fromBottom
          toastDuration: const Duration(seconds: 4),
          animationDuration: const Duration(milliseconds: 600),
        ).show(context);
      }
      print('Error saat update profil: $e');
    } finally {
      setState(() {
        _isSavingProfile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Profil Anda',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchUserProfile,
            tooltip: 'Refresh Profil',
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed:
                _userProfile != null
                    ? () {
                      _nameController.text = _userProfile!.name ?? '';
                      _showEditDialog(context);
                    }
                    : null,
            tooltip: 'Edit Profil',
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: _handleLogout,
            tooltip: 'Keluar',
          ),
        ],
      ),
      body:
          _isLoadingProfile
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Memuat profil Anda...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
              : _profileError != null
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 60,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _profileError!,
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _fetchUserProfile,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueGrey,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : _userProfile == null
              ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_off, color: Colors.grey, size: 60),
                      SizedBox(height: 20),
                      Text(
                        'Tidak ada data profil yang tersedia. Coba refresh atau masuk kembali.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.blueGrey[100],
                        child: Text(
                          _userProfile!.name[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w300,
                            color: Colors.blueGrey[700],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _userProfile!.name ?? 'Nama Pengguna',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _userProfile!.email ?? 'email@example.com',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informasi Akun',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[700],
                              ),
                            ),
                            const Divider(
                              height: 30,
                              thickness: 1.5,
                              color: Colors.blueGrey,
                            ),
                            _buildProfileInfoRow(
                              'ID Pengguna',
                              _userProfile!.id?.toString() ?? 'N/A',
                              Icons.fingerprint,
                            ),
                            _buildProfileInfoRow(
                              'Dibuat Pada',
                              _userProfile!.createdAt
                                      ?.toLocal()
                                      .toString()
                                      .split('.')[0] ??
                                  'N/A',
                              Icons.event,
                            ),
                            _buildProfileInfoRow(
                              'Diperbarui Pada',
                              _userProfile!.updatedAt
                                      ?.toLocal()
                                      .toString()
                                      .split('.')[0] ??
                                  'N/A',
                              Icons.history,
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

  Widget _buildProfileInfoRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueGrey, size: 28),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[900],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext dialogContext) {
    showDialog(
      context: dialogContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Edit Nama Anda',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueGrey[200]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.person, color: Colors.blueGrey),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed:
                  _isSavingProfile
                      ? null
                      : () {
                        Navigator.of(context).pop();
                        _handleEditProfile();
                      },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueGrey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child:
                  _isSavingProfile
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                      : const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
