import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Settings()
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  late int workTime;
  late int shortBreak;
  late int longBreak;
  late SharedPreferences prefs;

  TextStyle textStyle = TextStyle(fontSize: 24);
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;

  double buttonSize = 10.0;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort= TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", buttonSize, -1, WORKTIME, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          SettingsButton(Color(0xff009688), "+", buttonSize, 1, WORKTIME, updateSetting),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", buttonSize, -1, SHORTBREAK, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
          ),
          SettingsButton(Color(0xff009688), "+", buttonSize, 1, SHORTBREAK, updateSetting),
          Text("Long", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", buttonSize, -1, LONGBREAK, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
          ),
          SettingsButton(Color(0xff009688), "+", buttonSize, 1, LONGBREAK, updateSetting),
        ],
        padding: const EdgeInsets.all(20.0),
      )
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int workTime = (prefs.getInt(WORKTIME) ?? 30);
    int shortBreak = (prefs.getInt(SHORTBREAK) ?? 5);
    int longBreak = (prefs.getInt(LONGBREAK) ?? 30);

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = prefs.getInt(WORKTIME);
          if (workTime != null) {
            workTime += value;
            if (workTime >= 1 && workTime <= 180) {
              prefs.setInt(WORKTIME, workTime);
              setState(() {
                txtWork.text = workTime.toString();
              });
            }
          }
        }
        break;
      case SHORTBREAK:
        {
          int? short = prefs.getInt(SHORTBREAK);
          if (short != null) {
            short += value;
            if (short >= 1 && short <= 120) {
              prefs.setInt(SHORTBREAK, short);
              setState(() {
                txtShort.text = short.toString();
              });
            }
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = prefs.getInt(LONGBREAK);
          if (long != null) {
            long += value;
            if (long >= 1 && long <= 180) {
              prefs.setInt(LONGBREAK, long);
              setState(() {
                txtLong.text = long.toString();
              });
            }
          }
        }
        break;
    }
  }
}
