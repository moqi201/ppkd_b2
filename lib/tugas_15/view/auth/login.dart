import 'package:elegant_notification/elegant_notification.dart'; // Import ini
import 'package:elegant_notification/resources/arrays.dart'; // Import ini
import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_15/api/get_user.dart';
import 'package:ppkd_b2/tugas_15/view/home_screen.dart';

class loginScreenApi extends StatefulWidget {
  const loginScreenApi({super.key});
  static const String id = "/login_screen_api";

  @override
  State<loginScreenApi> createState() => _LoginScreenApi();
}

class _LoginScreenApi extends State<loginScreenApi> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserService _userService = UserService();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final bool loginSuccess = await _userService.loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (loginSuccess) {
        if (mounted) {
          // --- Ganti SnackBar dengan ElegantNotification untuk Sukses ---
          ElegantNotification.success(
            title: const Text("Sukses"),
            description: const Text("Login Berhasil!"),
            animation: AnimationType.fromTop, // Opsi animasi
            toastDuration: const Duration(seconds: 3), // Durasi notifikasi
            // Anda bisa menyesuaikan warna, icon, dll.
          ).show(context);
          // --- Akhir ElegantNotification ---

          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen1.id,
            (Route<dynamic> route) => false,
          );
        }
        print('Navigasi ke Home Screen setelah login sukses.');
      } else {
        setState(() {
          _errorMessage = 'Login gagal. Coba lagi.';
        });
        if (mounted) {
          // --- Ganti SnackBar dengan ElegantNotification untuk Gagal (opsi default atau error) ---
          ElegantNotification.error(
            title: const Text("Gagal Login"),
            description: Text(_errorMessage!),
            animation: AnimationType.fromTop,
            toastDuration: const Duration(seconds: 4),
          ).show(context);
          // --- Akhir ElegantNotification ---
        }
        print(
          'Login gagal: Token tidak ditemukan dalam respons atau masalah lain.',
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            e.toString().contains('Failed to login user: 422')
                ? 'Email atau password salah.'
                : 'Terjadi kesalahan: ${e.toString().replaceFirst('Exception: ', '')}';
      });
      if (mounted) {
        // --- Ganti SnackBar dengan ElegantNotification untuk Error Umum ---
        ElegantNotification.error(
          title: const Text("Kesalahan"),
          description: Text(_errorMessage!),
          animation: AnimationType.fromTop,
          toastDuration: const Duration(seconds: 5),
        ).show(context);
        // --- Akhir ElegantNotification ---
      }
      print('Login gagal total (catch block): $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.lock_person_rounded,
                size: 100,
                color: Colors.blueGrey[700],
              ),
              const SizedBox(height: 24),
              Text(
                'Selamat Datang Kembali!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Silakan masuk untuk melanjutkan',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan email Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.blueGrey[400],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.blueGrey[400],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.blueGrey[400],
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 32.0),
              _isLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blueGrey[600]!,
                      ),
                    ),
                  )
                  : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueGrey[700],
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('MASUK'),
                  ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register_screen_api');
                  print('Pergi ke halaman Register');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blueGrey[600],
                  textStyle: const TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
                child: const Text('Belum punya akun? Daftar di sini.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
