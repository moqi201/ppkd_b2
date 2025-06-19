import 'package:flutter/material.dart';
import 'package:ppkd_b2/Meet_6/latihan.dart';
import 'package:ppkd_b2/helper/preference.dart';
import 'package:ppkd_b2/meet_12/meet_12a.dart';
import 'package:ppkd_b2/meet_12/meet_12c.dart';
import 'package:ppkd_b2/meet_4/tugas_empat.dart';
import 'package:ppkd_b2/meet_5/meet_5a.dart';

class Meet6 extends StatefulWidget {
  const Meet6({super.key});
  static const String id = "/meet_6";

  @override
  State<Meet6> createState() => _Meet6State();
}

class _Meet6State extends State<Meet6> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Login to access your account',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff888888),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(
                      0.10,
                    ), // Use opacity for a subtle blur effect,
                    hintText: 'Enter your email address',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // BOrder Ketika di klik
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                      // borderSide: BorderSide(color: Colors.black, width: 5),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff888888),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.10),
                    hintText: 'Enter your phone number',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // BOrder Ketika di klik
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                      // borderSide: BorderSide(color: Colors.black, width: 5),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff888888),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(
                      0.10,
                    ), // Use opacity for a subtle blur effect
                    // Blur effectF
                    // Use a Stack to wrap the TextField with BackdropFilter
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // BOrder Ketika di klik
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                      // borderSide: BorderSide(color: Colors.black, width: 5),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_rounded,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      //navigator push Replacement di gunakan untuk berpindah halaman
                      // tetapi tidak bisa kembali ke halaman sebelumnya
                      // ini Navigator pushReplacement
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MeetLima()),
                      ); // navigator push di gunakan untuk berpindah halaman
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // navigator push di gunakan untuk berpindah halaman / mendorong halaman baru  ke atas stack (halaman sebelumnya tetap ada di belakang)
                      // ini Navigator push
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => TugasEmpat()),
                      // ); // ini Navigator push

                      PreferenceHandler.saveLogin(true);
                      Navigator.pushNamed(context, MeetDuaBelasC.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff283FB1),
                      padding: EdgeInsets.symmetric(vertical: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    // Divider with elevation using Material and SizedBox
                    Material(
                      elevation: 1,
                      color: Colors.transparent,
                      child: SizedBox(
                        height: 1,
                        child: Divider(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or Sign In With',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // navigator push di gunakan untuk berpindah halaman
                      Navigator.pushNamed(context, "/meet_2");
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor:
                          Colors
                              .white, // gunakan backgroundColor untuk fill putih
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/btn_google.png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        WidgetSpan(
                          child: TextButton(
                            onPressed: () {
                              // navigator push di gunakan untuk berpindah halaman
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Meet11A(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xff283FB1),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
