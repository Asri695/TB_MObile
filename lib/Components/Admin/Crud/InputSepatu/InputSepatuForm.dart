// ignore_for_file: unused_import, file_names, unnecessary_import, use_key_in_widget_constructors, unnecessary_new, avoid_print, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:myshoe/Api/configAPI.dart';
import 'package:myshoe/Components/custom_surfix_icon.dart';
import 'package:myshoe/Components/default_button_custome_color.dart';
import 'package:myshoe/Screens/Admin/HomeAdminScreens.dart';
import 'package:myshoe/Screens/Register/RegistrasiScreens.dart';
import 'package:myshoe/Screens/User/HomeUserScreens.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';
import 'dart:convert';

class FormInputSepatu extends StatefulWidget {
  @override
  _FormInputSepatu createState() => _FormInputSepatu();
}

class _FormInputSepatu extends State<FormInputSepatu> {
  TextEditingController txtNamaSepatu = TextEditingController(),
      txtTipeSepatu = TextEditingController(),
      txtHargaSepatu = TextEditingController(),
      txtMerekSepatu = TextEditingController();

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
              ? Container()
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
                inputDataSepatu(txtNamaSepatu.text, txtTipeSepatu.text,
                    txtHargaSepatu.text, txtMerekSepatu.text, image?.path);
              }
            },
          ),
          const SizedBox(
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
          suffixIcon: const Icon(Icons.add_chart_sharp)),
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
          suffixIcon: const Icon(Icons.add_chart_sharp)),
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
          suffixIcon: const Icon(Icons.add_chart_sharp)),
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
          suffixIcon: const Icon(Icons.add_chart_sharp)),
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

  void inputDataSepatu(nama, tipe, harga, merk, gambar) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        'nama': nama,
        'tipe': tipe,
        'harga': harga,
        'merk': merk,
        'gambar': await MultipartFile.fromFile(gambar)
      });

      response = await dio.post(inputSepatu, data: formData);
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
