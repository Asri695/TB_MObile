import 'package:flutter/material.dart';
import 'package:myshoe/size_config.dart';
import 'package:myshoe/utils/constants.dart';

import 'FormTransaksiComponent.dart';

class TransaksiComponent extends StatefulWidget {
  @override
  _TransaksiComponent createState() => _TransaksiComponent();
}

class _TransaksiComponent extends State<TransaksiComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Transaksi !",
                          style: mTitleStyle,
                        )
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                TransaksiForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
