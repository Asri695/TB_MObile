// ignore_for_file: unnecessary_new, file_names

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myshoe/Api/configAPI.dart';
import 'package:myshoe/Components/default_button_custome_color.dart';
import 'package:myshoe/Screens/Admin/Crud/EditSepatuScreen.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

import '../../../../Screens/Admin/HomeAdminScreens.dart';

class FormEditSepatu extends StatefulWidget {
  @override
  _FormEditSepatu createState() => _FormEditSepatu();
}

class _FormEditSepatu extends State<FormEditSepatu> {
  TextEditingController txtNamaSepatu =
          TextEditingController(text: '${EditSepatuScreens.dataSepatu['nama']}'),
      txtTipeSepatu =
          TextEditingController(text: '${EditSepatuScreens.dataSepatu['tipe']}'),
      txtHargaSepatu =
          TextEditingController(text: '${EditSepatuScreens.dataSepatu['harga']}'),
      txtMerekSepatu =
          TextEditingController(text: '${EditSepatuScreens.dataSepatu['merk']}');

  FocusNode focusNode = new FocusNode();
  File? image;
  Response? response;
  var dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loginProses();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildNamaSepatu(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildTipeSepatu(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildHargaSepatu(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildMerekSepatu(),
          SizedBox(height: getProportionateScreenHeight(30)),
          image == null
              ? Image.network(
                  '$baseUrl/${EditSepatuScreens.dataSepatu['gambar']}',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  image!,
                  // width: 250,
                  // height: 250,
                  fit: BoxFit.cover,
                ),
          DefaultButtonCustomeColor(
            color: kColorBlue,
            text: "Pilih Gambar Sepatu",
            press: () {
              pilihGambar();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "SUBMIT",
            press: () {
              if (txtNamaSepatu.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Nama Sepatu tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtTipeSepatu.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Tipe Sepatu tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtHargaSepatu.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Harga Sepatu tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtMerekSepatu.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Merek Sepatu tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else {
                editDataSepatu(txtNamaSepatu.text, txtTipeSepatu.text,
                    txtHargaSepatu.text, txtMerekSepatu.text, image?.path);
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextFormField buildNamaSepatu() {
    return TextFormField(
      controller: txtNamaSepatu,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Nama Sepatu',
          hintText: 'Masukan Nama Sepatu',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  TextFormField buildTipeSepatu() {
    return TextFormField(
      controller: txtTipeSepatu,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Tipe Sepatu',
          hintText: 'Masukan Tipe Sepatu',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  TextFormField buildHargaSepatu() {
    return TextFormField(
      controller: txtHargaSepatu,
      keyboardType: TextInputType.number,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Harga Sepatu',
          hintText: 'Masukan Harga Sepatu',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  TextFormField buildMerekSepatu() {
    return TextFormField(
      controller: txtMerekSepatu,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Merek Sepatu',
          hintText: 'Masukan Merek Sepatu',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  Future<void> pilihGambar() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      setState(() => image = imageTemp);
    } catch (e) {
      print("Gagal mengambil foto: $e");
    }
  }

  void editDataSepatu(nama, tipe, harga, merk, gambar) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        'nama': nama,
        'tipe': tipe,
        'harga': harga,
        'merk': merk,
        'gambar': image == null ? '' : await MultipartFile.fromFile(gambar)
      });

      response = await dio.put(
          '$editSepatu/${EditSepatuScreens.dataSepatu['_id']}',
          data: formData);
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            title: 'Peringatan',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
              Navigator.pushNamed(context, HomeAdminScreens.routeName);
            }).show();
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
          desc: 'Terjadi Kesalahan Pada Server Kami!!!!!!',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
