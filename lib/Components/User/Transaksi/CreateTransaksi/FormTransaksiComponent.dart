import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:myshoe/Api/configAPI.dart';
import 'package:myshoe/Components/default_button_custome_color.dart';
import 'package:myshoe/Screens/User/HomeUserScreens.dart';
import 'package:myshoe/Screens/User/Transaksi/TransaksiScreens.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

class TransaksiForm extends StatefulWidget {
  @override
  State<TransaksiForm> createState() => _TransaksiFormState();
}

class _TransaksiFormState extends State<TransaksiForm> {
  var totalBayar = 0.0;
  var jumlahBeli = 0.0;
  var hargaBarang = TransaksiScreens.dataSepatu['harga'];

  Response? response;
  var dio = Dio();
  @override
  Widget build(BuildContext context) {
    print(TransaksiScreens.dataSepatu);
    return Form(
        child: Column(
      children: [
        Image.network(
          "$baseUrl/${TransaksiScreens.dataSepatu['gambar']}",
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Barang",
                style: mTitleStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${TransaksiScreens.dataSepatu['nama']}",
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tipe",
                style: mTitleStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${TransaksiScreens.dataSepatu['tipe']}",
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Harga",
                style: mTitleStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${TransaksiScreens.dataSepatu['harga']}",
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Merek",
                style: mTitleStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${TransaksiScreens.dataSepatu['merk']}",
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jumlah Beli",
                style: mTitleStyle,
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 10, top: 3),
            child: SpinBox(
              min: 0,
              max: 100,
              value: 0,
              onChanged: (value) {
                setState(() {
                  jumlahBeli = value;
                  totalBayar = jumlahBeli * hargaBarang;
                });
              },
            )),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total",
                    style: mTitleStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$totalBayar",
                    style: mTitleStyle,
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        DefaultButtonCustomeColor(
          color: kPrimaryColor,
          text: "Beli",
          press: () {
            if (totalBayar <= 0 || jumlahBeli <= 0) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO,
                animType: AnimType.RIGHSLIDE,
                title: 'Peringatan',
                desc: 'Jumlah pembelian harus lebih dari 1',
                btnOkOnPress: () {},
              ).show();
            } else {
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.RIGHSLIDE,
                      title: 'Peringatan',
                      desc:
                          'Yakin ingin melakukan pembelian Sepatu ${TransaksiScreens.dataSepatu['nama']} ?....',
                      btnOkOnPress: () {
                        prosesTransaksi(
                            TransaksiScreens.dataSepatu['_id'],
                            HomeUserScreen.dataUserLogin['_id'],
                            jumlahBeli,
                            hargaBarang,
                            totalBayar);
                      },
                      btnCancelOnPress: () {})
                  .show();
            }
          },
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
      ],
    ));
  }

  void prosesTransaksi(idBarang, idUser, jumlah, harga, total) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.post(createTransaksi, data: {
        'idBarang': idBarang,
        'idUser': idUser,
        'jumlah': jumlah,
        'harga': harga,
        'total': total,
      });

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Berhasil Transaksi',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, HomeUserScreen.routeName,
                arguments: HomeUserScreen.dataUserLogin);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Gagal Transaksi => $msg',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Peringatan',
        desc: 'Terjadi Kesalahan Pada Server',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
    }
  }
}
