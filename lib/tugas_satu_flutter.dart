import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),


      body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "profil saya ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
                 SizedBox(height: 20),
         Row(
          children: [
            Icon(Icons.location_on, color: Colors.red,),
            Text(
              "Jl, MH THamrin ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color:Colors.black,
              ),
            )
          ],
         ),


         Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "saya adalah seorang gembala yang selalu riamg serta gembira kerena bapak saya garena",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
         ),




        ],
      ),
    );
  }
}
