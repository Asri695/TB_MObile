import 'package:flutter/material.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

import '../../../Components/User/Transaksi/DataTransaksi/DataTransaksiUserComponents.dart';

class DataTransaksiScreens extends StatelessWidget {
  static var routeName = '/data_transaksiusers_screens';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Data Transaksi",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: DataTransaksiUserComponents(),
    );
  }
}
