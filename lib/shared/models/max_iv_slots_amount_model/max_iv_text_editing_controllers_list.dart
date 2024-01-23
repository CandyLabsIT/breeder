import 'package:flutter/material.dart';

class MaxIVTextEditingControllersList {
  late List<TextEditingController> maxIVTextEditingControllersList;

  MaxIVTextEditingControllersList() {
    initMaxIVTextEditingControllers();
  }

  void initMaxIVTextEditingControllers() {
    maxIVTextEditingControllersList = List<TextEditingController>.generate(5, (_) => TextEditingController());
  }

  void dispose() {
    for (TextEditingController textEditingController in maxIVTextEditingControllersList) {
      textEditingController.dispose();
    }
  }
}
