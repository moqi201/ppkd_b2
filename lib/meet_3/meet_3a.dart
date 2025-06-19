import 'package:flutter/material.dart';

class MeetTigaA extends StatelessWidget {
  const MeetTigaA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text("Meet 3")),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(horizontal: 100),
        physics:
            // ClampingScrollPhysics(), // Scroll untuk menahan
            BouncingScrollPhysics(), // Scroll untuk pantul
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [buildStack(), buildStack()]),
            ),

            //Materi tentang widget stack
            Text("Stack Widget"),
            SizedBox(height: 20),
            buildStack(),
            buildStack(),
            // buildStack(),
            // buildStack(),
            // buildStack(),
            // buildStack(),
            // buildStack(),
            // buildStack(),
            // buildStack(),
          ],
        ),
      ),
    );
  }
}

Center buildStack() {
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        ),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
          ),
        ),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
        ),
        Column(children: [Text("data1"), Text("data2"), Text("data3")]),
      ],
    ),
  );
}
