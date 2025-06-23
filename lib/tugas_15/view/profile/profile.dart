// import 'package:flutter/material.dart';
// import 'package:ppkd_b2/tugas_15/api/get_user.dart';
// import 'package:ppkd_b2/tugas_15/model/user_model.dart';
// import 'package:ppkd_b2/tugas_15/view/auth/login.dart';
//  // Untuk logout

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   // Ubah tipe _userProfile menjadi 'User?' (yaitu, kelas teratas dari model Anda)
//   User? _userProfile;
//   bool _isLoading = true;
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   bool _isEditing = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchProfile();
//   }

//   Future<void> _fetchProfile() async {
//     setState(() {
//       _isLoading = true;
//     });
//     // ApiService.getProfile sekarang harus mengembalikan objek 'User' yang lengkap
//     User? userResponse = await UserService.getProfile();
//     setState(() {
//       _userProfile = userResponse;
//       _isLoading = false;
//       // Perhatikan cara mengakses name dan email di sini:
//       if (_userProfile?.data?.user != null) {
//         _nameController.text = _userProfile!.data!.user!.name ?? '';
//         _emailController.text = _userProfile!.data!.user!.email ?? '';
//       }
//     });

//     if (userResponse == null && mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Sesi berakhir. Silakan login kembali.')),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     }
//   }

//   Future<void> _updateProfile() async {
//     // Saat update, kita hanya mengirim name dan email
//     bool success = await ApiService.updateProfile(
//       _nameController.text,
//       _emailController.text,
//     );

//     if (success) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Profil berhasil diperbarui!')),
//         );
//       }
//       setState(() {
//         _isEditing = false;
//         _fetchProfile(); // Muat ulang profil setelah update
//       });
//     } else {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Gagal memperbarui profil.')),
//         );
//       }
//     }
//   }

//   Future<void> _logout() async {
//     await ApiService.logout();
//     if (mounted) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Anda telah logout.')));
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profil'),
//         actions: [
//           IconButton(
//             icon: Icon(_isEditing ? Icons.save : Icons.edit),
//             onPressed: () {
//               if (_isEditing) {
//                 _updateProfile();
//               } else {
//                 setState(() {
//                   _isEditing = true;
//                 });
//               }
//             },
//           ),
//           IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
//         ],
//       ),
//       body:
//           _isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : _userProfile == null || _userProfile!.data?.user == null
//               ? const Center(
//                 child: Text('Gagal memuat profil atau tidak ada profil.'),
//               )
//               : Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Akses 'id' melalui _userProfile.data.user.id
//                     Text(
//                       'ID: ${_userProfile!.data!.user!.id ?? 'N/A'}',
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(labelText: 'Name'),
//                       enabled: _isEditing,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(labelText: 'Email'),
//                       enabled: _isEditing,
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                   ],
//                 ),
//               ),
//     );
//   }
// }
