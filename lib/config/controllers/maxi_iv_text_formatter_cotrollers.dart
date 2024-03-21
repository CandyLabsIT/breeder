import 'package:flutter/material.dart';


class IVTextEditingControllersList {
  late List<TextEditingController> textEditingControllerList;

  IVTextEditingControllersList() {
    initControllers();
  }

  void initControllers() {
    textEditingControllerList = List<TextEditingController>.generate(5, (_) => TextEditingController());
  }

  void dispose() {
    for (TextEditingController controller in textEditingControllerList) {
      controller.dispose();
    }
  }
}