// ignore_for_file: unused_import, file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:myshoe/Components/Admin/Crud/EditSepatu/EditSepatuForm.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

class EditSepatuComponent extends StatefulWidget {
  @override
  _EditSepatuComponent createState() => _EditSepatuComponent();
}

class _EditSepatuComponent extends State<EditSepatuComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Edit Data Sepatu !",
                          style: mTitleStyle,
                        )
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                FormEditSepatu()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
