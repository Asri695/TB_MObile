import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myshoe/Screens/User/Sepatu/DataSepatuScreens.dart';
import 'package:myshoe/Screens/User/Transaksi/DataTransaksiUser.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

import '../../Api/configAPI.dart';
import '../../Screens/User/HomeUserScreens.dart';

class HomeUserComponent extends StatefulWidget {
  @override
  _HomeUserComponent createState() => _HomeUserComponent();
}

class _HomeUserComponent extends State<HomeUserComponent> {
  var dataTransaksi;
  Response? response;
  var dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataTransaksi();
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
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Layanan",
                style: mTitleStyle,
              ),
            ),
            menuLayanan(),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Data Transaksi Anda",
                style: mTitleStyle,
              ),
            ),
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: dataTransaksi == null ? 0 : dataTransaksi.length,
                itemBuilder: (BuildContext context, int index) {
                  // return cardTransaksi(dataGitar[index]);
                  return cardTransaksi(dataTransaksi[index]);
                },
              ),
            ),
          ],
        )),
      ),
    ));
  }

  Widget menuLayanan() {
    return Container(
      height: 70,
      child: Column(children: [
        Row(children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DataSepatuScreens.routeName);
            },
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              padding: EdgeInsets.only(left: 16),
              height: 64,
              decoration: BoxDecoration(
                  color: mFillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mBorderColor, width: 1)),
              child: Row(
                children: [
                  Image.network(
                      "https://cdn-icons-png.flaticon.com/32/2099/2099125.png"),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sepatu",
                          style: mServiceTitleStyle,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "List Data Sepatu",
                          style: mServiceSubtitleStyle,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DataTransaksiScreens.routeName);
            },
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              padding: EdgeInsets.only(left: 16),
              height: 64,
              decoration: BoxDecoration(
                  color: mFillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mBorderColor, width: 1)),
              child: Row(
                children: [
                  Image.network(
                      "https://cdn-icons-png.flaticon.com/32/2856/2856892.png"),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Transaksi",
                          style: mServiceTitleStyle,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Data Transaksi",
                          style: mServiceSubtitleStyle,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        ])
      ]),
    );
  }

  Widget cardTransaksi(data) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, UploadBuktiPembayaranScreens.routeName,
        //     arguments: data);
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
                child:
                    Image.network('$baseUrl/${data['dataBarang']['gambar']}'),
              ),
              title: Text(
                "${data['dataBarang']['nama']}",
                style:
                    TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Harga",
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp. ${data['harga']}",
                  ),
                  Text(
                    "Jumlah Beli",
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${data['jumlah']}",
                  ),
                  Text(
                    "Total",
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp. ${data['total']}",
                  ),
                  data['buktiPembayaran'] == null
                      ? Text(
                          "Pending",
                          style: TextStyle(
                              color: kColorYellow, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "Berhasil",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
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

  void getDataTransaksi() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio
          .get('$getTransaksiUserLimit/${HomeUserScreen.dataUserLogin['_id']}');
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          dataTransaksi = response!.data['data'];
          print(dataTransaksi);
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
