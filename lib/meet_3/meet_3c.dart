import 'package:flutter/material.dart';

class MeetTigaC extends StatelessWidget {
  const MeetTigaC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Meet 3C"),
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
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: 5,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/jokowi.jpg"),

                  // child: Image.asset("assets/images/jokowi.jpg"),
                ),
                title: Text("Nama User"),
                trailing: Icon(Icons.more_vert),
              ),
              Image.asset(
                "assets/images/gambar.png",
                // height: 100,
                width: double.infinity,
              ),
              ListTile(leading: Icon(Icons.favorite)),
            ],
          );
          // buildListUser();

          // Text(
          //   "data ke-$index",
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // );
        },
      ),
    );
  }
}
