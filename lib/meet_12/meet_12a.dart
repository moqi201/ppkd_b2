import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppkd_b2/constant/App_color.dart';
import 'package:ppkd_b2/constant/app_format.dart';
import 'package:ppkd_b2/constant/app_style.dart';
import 'package:ppkd_b2/meet_12/checkbox_custom.dart';

class Meet12AInputWidget extends StatefulWidget {
  const Meet12AInputWidget({super.key});
  static const String id = "/meet_12a";

  @override
  State<Meet12AInputWidget> createState() => _Meet12AInputWidgetState();
}

class _Meet12AInputWidgetState extends State<Meet12AInputWidget> {
  //Checkbox
  final bool _isChecked = false;
  final bool _isChecked1 = false;
  final bool _isChecked2 = false;
  //Switch
  bool isSwitchOn = false;
  //Dropdown
  String? isSelected;
  final List<String> _colors = [
    "Merah",
    "Hijau",
    "Biru",
    "Kuning",
    "Ungu",
    "Hitam",
    "Putih",
  ];
  //DatePicker
  DateTime? selectedDate;
  TimeOfDay? selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isSwitchOn ? AppColor.gray88 : Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.army1,
        title: Text(
          "Meet 12A Input Widget",
          style: AppStyle.fontBold(fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCheckBox(_isChecked),
            buildSwitch(),
            buildDropdownButton(),
            buildDataTime(context),
            IconButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(hour: 1, minute: 10),
                );
                if (picked != null) {
                  setState(() {
                    selectedDay = picked;
                  });
                }
              },
              icon: Icon(Icons.watch_later),
            ),
            // buildCheckBox(_isChecked1),
            // buildCheckBox(_isChecked2),
          ],
        ),
      ),
    );
  }

  Widget buildDataTime(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              icon: Icon(Icons.date_range),
            ),
            Text(
              selectedDate == null
                  ? "Pilih Tanggal"
                  : "${selectedDate!.day.toString()}/${selectedDate!.timeZoneName.toString()}",
            ),
          ],
        ),
        Text(DateTime.now().toString()),
        Text(DateFormat.MMMMd().format(selectedDate ?? DateTime.now())),
        Text(AppFormat.createDateFullDay(selectedDate ?? DateTime.now())),

        //  Text(
        // DateTime.now(
        // selectedDate.toString()),)
      ],
    );
  }

  Column buildDropdownButton() {
    return Column(
      children: [
        DropdownButton<String>(
          value: isSelected,
          hint: Text("Pilih Warna"),
          items:
              _colors.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (String? value) {
            setState(() {
              isSelected = value;
              // if (value == "Merah") {
              //   Navigator.pushNamed(context, MeetTigaA.id);
              // }
            });
          },
        ),
        Text(isSelected ?? "Belum pilih warna", style: AppStyle.fontBold()),
        if (isSelected == "Merah") CircularProgressIndicator(),
        Container(
          height: 150,
          width: 150,
          color:
              isSelected == "Merah"
                  ? Colors.red
                  : isSelected == "Hijau"
                  ? AppColor.army1
                  : AppColor.blueButton,
        ),
      ],
    );
  }

  Row buildSwitch() {
    return Row(
      children: [
        Switch(
          value: isSwitchOn,
          onChanged: (value) {
            setState(() {
              isSwitchOn = value;
            });
          },
        ),
        Text(
          isSwitchOn ? "Mode Gelap" : "Mode Terang",
          style: AppStyle.fontBold(fontSize: isSwitchOn ? 25 : 18),
        ),
      ],
    );
  }

  Row buildCheckBox(bool? valueCheck) {
    print(valueCheck);
    return Row(
      children: [
        CheckBoxCustom(valueCheck: valueCheck),
        Checkbox(
          // fillColor: WidgetStateProperty.all(AppColor.army1),
          activeColor: AppColor.army2,
          checkColor: Colors.white,
          shape: CircleBorder(), // mengatur bentuk checkbox
          side: BorderSide(color: AppColor.army2, width: 0),
          value: valueCheck,
          onChanged: (value) {
            setState(() {
              print("Checkbox value changed: $value");
              valueCheck = value ?? false;
            });
          },
        ),
        Text(
          _isChecked ? "Sudah bagus" : "Belum bagus",
          style: AppStyle.fontBold(fontSize: 18),
        ),
      ],
    );
  }
}
