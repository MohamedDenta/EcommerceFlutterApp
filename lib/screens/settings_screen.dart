import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/utils/theme.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // String getColor() {
  //   switch (myThemeData.textTheme.title) {
  //     case :

  //       break;
  //     default:
  //   }
  // }
  var currentColor = myThemeData.primaryColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Settings, 'Settings'),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('App Color'),
            onTap: () {
              AlertDialog(
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: currentColor,
                    onColorChanged: (color){
                      setState(() {
                        currentColor=color;
                      });
                      
                    },
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: true,
                    displayThumbColor: true,
                    showLabel: true,
                    paletteType: PaletteType.hsv,
                    pickerAreaBorderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(2.0),
                      topRight: const Radius.circular(2.0),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
