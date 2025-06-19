import 'package:flutter/material.dart';
import 'package:ppkd_b2/Meet_14/meet_b/thanks_screen.dart';
import 'package:ppkd_b2/utils/button.dart';


class Meet14b extends StatefulWidget {
  const Meet14b({super.key});

  @override
  State<Meet14b> createState() => _Meet14bState();
}

class _Meet14bState extends State<Meet14b> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email tidak boleh kosong";
                } else if (!value.contains("@")) {
                  return "Email tidak valid";
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            DefaultButton(
              text: "Daftar",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print("Berhasil");
                  dialogSuccess(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dialogSuccess(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Berhasil"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Email anda : ${_emailController.text}")],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Tutup"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            HalamanTerimakasih(email: _emailController.text),
                  ),
                );
              },
              child: Text("Lanjut"),
            ),
          ],
        );
      },
    );
  }
}
