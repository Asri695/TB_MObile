import 'package:flutter/material.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

import '../../../Components/Admin/Crud/EditSepatu/EditSepatuComponent.dart';

class EditSepatuScreens extends StatelessWidget {
  static var routeName = '/edit_sepatu_screens';
  static var dataSepatu;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataSepatu = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          "Edit Data Sepatu",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: EditSepatuComponent(),
    );
  }
}
