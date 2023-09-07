import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestClass2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Appbar Title 2'.tr)),
        body: Column(
          children: [
            Text('A 2'.tr),
            Text("B C D 2".tr),
            Text('''E 
            C D 2'''
                .tr),
          ],
        ));
  }
}
