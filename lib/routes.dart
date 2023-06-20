import 'package:flutter/material.dart';
import 'package:myshoe/Screens/Admin/Crud/EditSepatuScreen.dart';
import 'package:myshoe/Screens/Admin/Crud/InpuSepatuScreen.dart';
import 'package:myshoe/Screens/Admin/HomeAdminScreens.dart';
import 'package:myshoe/Screens/Register/RegistrasiScreens.dart';
import 'package:myshoe/Screens/Login/LoginScreens.dart';
import 'package:myshoe/Screens/User/Sepatu/DataSepatuScreens.dart';
import 'package:myshoe/Screens/User/HomeUserScreens.dart';

import 'Screens/User/Transaksi/DataTransaksiUser.dart';
import 'Screens/User/Transaksi/TransaksiScreens.dart';
import 'Screens/User/Transaksi/UploadBuktiBayar.dart';

final Map<String, WidgetBuilder> routes = {
  // Login registrasi
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),

  //routes user biasa
  HomeUserScreen.routeName: (context) => HomeUserScreen(),
  DataSepatuScreens.routeName: (context) => DataSepatuScreens(),
  TransaksiScreens.routeName: (context) => TransaksiScreens(),
  DataTransaksiScreens.routeName: (context) => DataTransaksiScreens(),
  UploadBuktiPembayaranScreens.routeName: (context) => UploadBuktiPembayaranScreens(),

  //routes admin
  HomeAdminScreens.routeName: (context) => HomeAdminScreens(),
  InputSepatuScreens.routeName: (context) => InputSepatuScreens(),
  EditSepatuScreens.routeName: (context) => EditSepatuScreens(),
};
