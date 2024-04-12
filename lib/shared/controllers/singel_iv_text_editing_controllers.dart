import 'package:flutter/material.dart';

class SingleIVTextEditingControllers {
  late List<TextEditingController> singleIVTextEditingControllersList;

  SingleIVTextEditingControllers() {
    initSingleIVTextEditingControllers();
  }

  void initSingleIVTextEditingControllers() {
    singleIVTextEditingControllersList = List<TextEditingController>.generate(6, (_) => TextEditingController());
  }

  void dispose() {
    for (TextEditingController textEditingController in singleIVTextEditingControllersList) {
      textEditingController.dispose();
    }
  }
}
