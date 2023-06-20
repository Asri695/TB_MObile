import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myshoe/Api/configAPI.dart';
import 'package:myshoe/Screens/User/HomeUserScreens.dart';
import 'package:myshoe/Screens/User/Transaksi/UploadBuktiBayar.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

class DataTransaksiUserComponents extends StatefulWidget {
  @override
  State<DataTransaksiUserComponents> createState() =>
      _DataTransaksiUserComponents();
}  

class _DataTransaksiUserComponents extends State<DataTransaksiUserComponents> {
  Response? response;
  var dio = Dio();
  var dataTransaksi;

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
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: dataTransaksi == null ? 0 : dataTransaksi.length,
                itemBuilder: (BuildContext context, int index) {
                  // return cardTransaksi(dataSepatu[index]);
                  return cardTransaksi(dataTransaksi[index]);
                },
              ),
            ),
          ],
        )),
      ),
    ));
  }

  Widget cardTransaksi(data) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, UploadBuktiPembayaranScreens.routeName,
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
          .get('$getTransaksiUser/${HomeUserScreen.dataUserLogin['_id']}');
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
