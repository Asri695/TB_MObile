// ignore_for_file: unused_field

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myshoe/Api/configAPI.dart';
import 'package:myshoe/Components/custom_surfix_icon.dart';
import 'package:myshoe/Components/default_button_custome_color.dart';
import 'package:myshoe/Screens/Login/LoginScreens.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

class SignUpform extends StatefulWidget {
  @override
  _SignUpformState createState() => _SignUpformState();
}

class _SignUpformState extends State<SignUpform> {
  final _formKey = GlobalKey<FormState>();
  String? namaLengkap;
  String? username;
  String? email;
  String? password;

  TextEditingController txtNamaLengkap = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  FocusNode focusNode = FocusNode();

  Response? response;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNamaLengkap(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUserName(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmail(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassword(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Register",
            press: () {
              if (_formKey.currentState!.validate()) {
                prosesRegistrasi(
                  txtUserName.text,
                  txtPassword.text,
                  txtNamaLengkap.text,
                  txtEmail.text,
                );
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: Text(
              "Sudah Punya Akun? Masuk Disini",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildNamaLengkap() {
    return TextFormField(
      controller: txtNamaLengkap,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Nama Lengkap',
        hintText: 'Masukkan Nama Lengkap',
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Mohon masukkan Nama Lengkap';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          namaLengkap = value;
        });
      },
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUserName,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Masukkan Username',
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/account.svg",
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Mohon masukkan Username';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          username = value;
        });
      },
    );
  }

  TextFormField buildEmail() {
    return TextFormField(
      controller: txtEmail,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan Email',
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Mohon masukkan Email';
        }
        if (!emailValidatorRegExp.hasMatch(value)) {
          return 'Masukkan Email yang valid';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan Password',
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Mohon masukkan Password';
        }
        if (value.length < 6) {
          return 'Password harus terdiri dari minimal 6 karakter';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  void prosesRegistrasi(
    String userName,
    String password,
    String nama,
    String email,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      response = await dio.post(
        urlRegister,
        data: {
          'username': userName,
          'password': password,
          'nama': nama,
          'email': email,
        },
      );

      bool status = response!.data['sukses'];
      String msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Berhasil Registrasi',
          btnOkOnPress: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Gagal Registrasi => $msg',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Peringatan',
        desc: 'Terjadi Kesalahan Pada Server',
        btnOkOnPress: () {},
      ).show();
    } finally {
      Navigator.pop(context);
    }
  }
}
