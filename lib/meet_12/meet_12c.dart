import 'package:flutter/material.dart';
import 'package:ppkd_b2/Meet_14/meet_a/meet_14.dart';
import 'package:ppkd_b2/Meet_14/meet_b/validator_widget.dart';
import 'package:ppkd_b2/Meet_6/meet_6.dart';
import 'package:ppkd_b2/constant/App_Color.dart';
import 'package:ppkd_b2/constant/App_image.dart';
import 'package:ppkd_b2/constant/app_style.dart';
import 'package:ppkd_b2/helper/preference.dart';
import 'package:ppkd_b2/meet_22/view/user_list_screen.dart';


class MeetDuaBelasC extends StatefulWidget {
  const MeetDuaBelasC({super.key});
  static const  String id = "/meet_12c";

  @override
  State<MeetDuaBelasC> createState() => _MeetDuaBelasCState();
}

class _MeetDuaBelasCState extends State<MeetDuaBelasC> {
  int _selectedIndex = 0;
  static const List<Widget> _screen = [
    Center(child: Text("Halaman 1")),
    Meet14a(),
    Meet14b(),
    
    // Center(child: Text("Halaman 2")),
    // Meet12AInputWidget(),
    Center(child: Text("Halaman 3")),
  ];
  void _itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("Halaman saat ini : $_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Menu Drawer")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColor.army2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(AppImage.photoProfile),
                  ),
                  Text(
                    "Andrea Surya Habibie",
                    style: AppStyle.fontBold(fontSize: 16),
                  ),
                  Text(
                    "projecthabibie@gmail.com",
                    style: AppStyle.fontBold(fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: AppColor.army1),
              title: Text("Home", style: AppStyle.fontBold(fontSize: 14)),
              onTap: () {
                _itemTapped(0);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.home, color: AppColor.army1),
              title: Text(
                "List dan Map",
                style: AppStyle.fontBold(fontSize: 14),
              ),
              onTap: () {
                _itemTapped(1);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.key, color: AppColor.army1),
              title: Text(
                "Validator",
                style: AppStyle.fontBold(fontSize: 14),
              ),
              onTap: () {
                _itemTapped(2);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.key, color: AppColor.army1),
              title: Text(
                "Get user",
                style: AppStyle.fontBold(fontSize: 14),
              ),
              onTap: () {
                _itemTapped(3);
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserListScreen()),
                      ); // 
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: AppColor.orange),
              title: Text("Keluar", style: AppStyle.fontBold(fontSize: 14)),
              onTap: () {
                PreferenceHandler.deleteLogin();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Meet6()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: _screen[_selectedIndex],
    );
  }
}
