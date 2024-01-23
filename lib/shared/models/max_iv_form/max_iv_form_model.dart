import 'package:breeder/shared/controllers/max_iv_text_editing_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaxIVFormModel {
  late List<TextEditingController> maxIVTextEditingControllersList;

  MaxIVFormModel() {
    MaxIVTextEditingControllers maxIVTextEditingControllers = MaxIVTextEditingControllers()..initMaxIVTextEditingControllers();

    maxIVTextEditingControllersList = maxIVTextEditingControllers.maxIVTextEditingControllersList;
  }

  int calculateAmountLeft(int inputWeight) {
    int amountLeft = ((32 - calculateWeightedSum()) / inputWeight).truncate();

    return amountLeft;
  }

  int calculateWeightedSum() {
    List<int> amountList = getAmountList();

    amountList[1] *= 2;
    amountList[2] *= 4;
    amountList[3] *= 8;
    amountList[4] *= 16;

    int formsSum = amountList.fold(0, (int previousValue, int element) => previousValue + element);

    return formsSum;
  }

  List<int> getAmountList() {
    List<int> amountList =
        maxIVTextEditingControllersList.map((TextEditingController textEditingController) => int.tryParse(textEditingController.text) ?? 0).toList();

    return amountList;
  }
}
