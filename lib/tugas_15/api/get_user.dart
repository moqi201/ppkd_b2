// lib/tugas_15/service/user_service.dart

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ppkd_b2/tugas_15/endpoint.dart';
import 'package:ppkd_b2/tugas_15/model/user.dart';
// KOREKSI: Hapus import yang tidak diperlukan atau salah
// import 'package:ppkd_b2/tugas_15/model/Login_model.dart';
// import 'package:ppkd_b2/tugas_15/model/register_eror.dart';
// import 'package:ppkd_b2/tugas_15/model/register_respon.dart';
// import 'package:ppkd_b2/tugas_15/model/user.dart'; // Ganti dengan User_Model // PASTI PAKAI INI
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<Map<String, dynamic>> registerUser({
    required String email,
    required String name,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Endpoint.register),
      headers: {"Accept": "application/json"},
      body: {"name": name, "email": email, "password": password},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Pastikan Anda memiliki model RegisterResponse dan RegisterErrorResponse yang benar
      // dan fungsi fromJson-nya. Jika tidak, Anda mungkin perlu mengadaptasi ini.
      // Untuk tujuan perbaikan getProfile dan logout, saya asumsikan ini benar.
      // return registerResponseFromJson(response.body).toJson();
      // Lebih aman jika hanya mengembalikan Map<String, dynamic> dari JSON langsung
      return json.decode(response.body);
    } else if (response.statusCode == 422) {
      // return registerErrorResponseFromJson(response.body).toJson();
      return json.decode(response.body);
    } else {
      print("Failed to register user: ${response.statusCode}");
      throw Exception("Failed to register user: ${response.statusCode}");
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${Endpoint.baseUrl}/api/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'email': email, 'password': password}),
      );

      print('Login API Status Code: ${response.statusCode}');
      print('Login API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);

        if (decodedResponse.containsKey('data') &&
            decodedResponse['data'].containsKey('token')) {
          final String token = decodedResponse['data']['token'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          print('Token BERHASIL disimpan ke SharedPreferences: $token');
          return true;
        } else {
          print(
            'Peringatan: Respons login tidak mengandung token atau token kosong.',
          );
          print('Respons yang diterima: $decodedResponse');
          return false;
        }
      } else {
        print('Login gagal dengan status code: ${response.statusCode}');
        print('Pesan error dari server: ${response.body}');
        throw Exception(
          'Failed to login user: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      print('Error saat login: $e');
      rethrow;
    }
  }



  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      print(
        "User successfully logged out (token removed from SharedPreferences).",
      );
    } catch (e) {
      print("Error during logout (SharedPreferences): $e");
      throw Exception("Failed to logout: $e");
    }
  }

  Future<User_Model> getProfile() async {
    final url = Uri.parse('${Endpoint.baseUrl}/api/profile');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Authentication token not found. Please log in.');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Get Profile Status Code: ${response.statusCode}');
      print('Get Profile Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);

        if (decodedResponse.containsKey('data')) {
          return User_Model.fromJson(decodedResponse['data']);
        } else {
          return User_Model.fromJson(decodedResponse);
        }
      } else if (response.statusCode == 401) {
        await logout();
        throw Exception(
          'Unauthorized: Token invalid or expired. Please log in again.',
        );
      } else {
        throw Exception(
          'Failed to load profile: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      print('Error getting profile: $e');
      rethrow;
    }
  }
   Future<User_Model> editProfile({
    required String name,

    // Tambahkan parameter lain jika API Anda mengizinkan atau mengharuskan pembaruan
    // Misalnya: String? newPassword, String? passwordConfirmation, dll.
  }) async {
    final url = Uri.parse(
      '${Endpoint.baseUrl}/api/profile',
    ); // Asumsi endpoint PUT juga /api/profile
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Authentication token not found. Please log in.');
    }

    try {
      final response = await http.put(
        // Menggunakan http.put()
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'name': name,
          // Tambahkan data lain yang ingin Anda perbarui
          // 'password': newPassword,
          // 'password_confirmation': passwordConfirmation,
        }),
      );

      print('Edit Profile Status Code: ${response.statusCode}'); // Debugging
      print('Edit Profile Response Body: ${response.body}'); // Debugging

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);

        // API seringkali membungkus data profil di bawah kunci 'data'
        if (decodedResponse.containsKey('data')) {
          return User_Model.fromJson(decodedResponse['data']);
        } else {
          // Jika tidak ada kunci 'data', asumsikan respons langsung adalah data user
          return User_Model.fromJson(decodedResponse);
        }
      } else if (response.statusCode == 401) {
        await logout(); // Jika token tidak valid, paksa logout
        throw Exception(
          'Unauthorized: Token invalid or expired. Please log in again.',
        );
      } else if (response.statusCode == 422) {
        // Jika ada validasi error dari server (misalnya email sudah terpakai)
        throw Exception('Validation error: ${response.body}');
      } else {
        throw Exception(
          'Failed to update profile: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      print('Error updating profile: $e'); // Debugging
      rethrow; // Melemparkan kembali error untuk ditangani di UI
    }
  }
} 
