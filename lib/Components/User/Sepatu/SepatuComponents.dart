import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myshoe/Screens/User/Transaksi/TransaksiScreens.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

import '../../../Api/configAPI.dart';

class SepatuComponents extends StatefulWidget {
  @override
  State<SepatuComponents> createState() => _SepatuComponentsState();
}

class _SepatuComponentsState extends State<SepatuComponents> {
  Response? response;
  var dio = Dio();
  var dataSepatu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataSepatu();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: dataSepatu == null ? 0 : dataSepatu.length,
                itemBuilder: (BuildContext context, int index) {
                  // return cardSepatu(dataSepatu[index]);
                  return cardSepatu(dataSepatu[index]);
                },
              ),
            ),
          ],
        )),
      ),
    ));
  }

  Widget cardSepatu(data) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, TransaksiScreens.routeName,
            arguments: data);
      },
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: Container(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: Image.network('$baseUrl/${data['gambar']}'),
              ),
              title: Text(
                "${data['nama']}",
                style:
                    TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data['merk']}",
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${data['tipe']}",
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp. ${data['harga']}",
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: mTitleColor,
                size: 30.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getDataSepatu() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.get(getAllSepatu);
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          dataSepatu = response!.data['data'];
          print(dataSepatu);
        });
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Peringatan',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
            }).show();
      }
    } catch (e) {
      print(e);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Terjadi kesalahan pada server kami',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
