import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Appbar Title'.tr)),
        body: Column(
          children: [
            Text('A'.tr),
            Text("B C D".tr),
            Text('''E C D on line'''.tr),
            Text('''E 
            C D broken 1'''
                .tr),
            Text("""E 
            C D broken 2"""
                .tr),
          ],
        ));
  }
}
