import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:myshoe/Components/Admin/HomeAdminComponents.dart';
import 'package:myshoe/Screens/Admin/Crud/InpuSepatuScreen.dart';
import 'package:myshoe/Screens/Login/LoginScreens.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

class HomeAdminScreens extends StatelessWidget {
  static var routeName = '/home_admin_screens';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "MyShoe",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.home,
          color: mTitleColor,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, InputSepatuScreens.routeName);
            },
            child: Row(children: const [
              Icon(Icons.add, color: mTitleColor),
              Text(
                "Input Data",
                style:
                    TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              )
            ]),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: HomeAmdinComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.RIGHSLIDE,
              title: 'Peringatan',
              desc: 'Yakin ingin keluar dari aplikasi ? ....',
              btnCancelOnPress: () {},
              btnCancelText: 'Tidak',
              btnOkText: 'Yakin',
              btnOkOnPress: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              }).show();
        },
        backgroundColor: kColorRedSlow,
        child: Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }
}
