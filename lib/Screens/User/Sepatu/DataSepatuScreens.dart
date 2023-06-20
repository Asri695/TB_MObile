import 'package:flutter/material.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

import '../../../Components/User/Sepatu/SepatuComponents.dart';

class DataSepatuScreens extends StatelessWidget {
  static var routeName = '/list_sepatu_user_screens';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Daftar Sepatu",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SepatuComponents(),
    );
  }
}
