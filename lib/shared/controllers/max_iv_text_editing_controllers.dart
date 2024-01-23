import 'package:flutter/material.dart';

class MaxIVTextEditingControllers {
  late List<TextEditingController> maxIVTextEditingControllersList;

  MaxIVTextEditingControllers() {
    initMaxIVTextEditingControllers();
  }

  void initMaxIVTextEditingControllers() {
    maxIVTextEditingControllersList = List<TextEditingController>.generate(5, (_) => TextEditingController());
  }


  // TODO(balladyna): Dispose is currently nowhere used. Consider where should be call

  void dispose() {
    for (TextEditingController textEditingController in maxIVTextEditingControllersList) {
      textEditingController.dispose();
    }
  }
}
