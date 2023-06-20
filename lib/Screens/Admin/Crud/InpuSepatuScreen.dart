import 'package:flutter/material.dart';
import 'package:myshoe/Components/Admin/Crud/InputSepatu/InputSepatuComponent.dart';
import 'package:myshoe/utils/constants.dart';

class InputSepatuScreens extends StatelessWidget {
  static var routeName = '/input_sepatu_screens';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Input Data Sepatu",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: InputSepatuComponent(),
    );
  }
}
