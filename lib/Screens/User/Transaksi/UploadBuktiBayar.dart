import 'package:flutter/material.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

import '../../../Components/User/Transaksi/UploadBuktiPembayaran/UploadPembayaranComponent.dart';

class UploadBuktiPembayaranScreens extends StatelessWidget {
  static var routeName = '/upload_bukti_pembayaran';
  static var dataTransaksi;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataTransaksi = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Upload Bukti Bayar",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: UploadPembayaranComponent(),
    );
  }
}
