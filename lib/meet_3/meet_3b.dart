import 'package:flutter/material.dart';

//Materi tentang ListView Aja
class MeetTigaB extends StatelessWidget {
  const MeetTigaB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Meet 3"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Action for search button
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        // scrollDirection: Axis.horizontal,
        children: [
          buildListUser(),
          buildListUser(),
          buildListUser(),
          buildListUser(),
          buildListUser(),
          buildListUser(),
          buildListUser(),
          buildListUser(),
          buildListUser(),
          buildListUser(),
          buildListUser(),
          buildListUser(),
          // buildStack(),
          // buildStack(),
          // buildStack(),
          // buildStack(),
          // buildStack(),
          // buildStack(),
          // buildStack(),
          // buildStack(),
        ],
      ),
    );
  }
}

ListTile buildListUser() {
  return ListTile(
    leading: Image.asset("assets/images/jokowi.jpg"),
    title: Text("Jokowi"),
    subtitle: Text("Presiden Indonesia"),
    trailing: Icon(Icons.arrow_forward_ios),
    tileColor: Colors.blue[100],
    onTap: () {},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
