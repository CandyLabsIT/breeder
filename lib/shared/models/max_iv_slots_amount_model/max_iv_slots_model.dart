import 'package:breeder/shared/models/max_iv_slots_amount_model/max_iv_text_editing_controllers_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaxIVSlotsModel {
  late List<TextEditingController> maxIVTextEditingControllersList;

  MaxIVSlotsModel() {
    MaxIVTextEditingControllersList ivTextEditingControllers = MaxIVTextEditingControllersList()..initMaxIVTextEditingControllers();
    maxIVTextEditingControllersList = ivTextEditingControllers.maxIVTextEditingControllersList;
  }

  int calculateMaxIVAmountLeft(int inputWeight) {
    int maxIVSlotsAmountLeft = ((32 - calculateMaxIVSlotsSum()) / inputWeight).truncate();
    return maxIVSlotsAmountLeft;
  }

  int calculateMaxIVSlotsSum() {
    List<int> maxIVSSlotsAmountList = getMaxIVSlotsAmountList();
    maxIVSSlotsAmountList[1] *= 2;
    maxIVSSlotsAmountList[2] *= 4;
    maxIVSSlotsAmountList[3] *= 8;
    maxIVSSlotsAmountList[4] *= 16;
    int maxIVSlotsSum = maxIVSSlotsAmountList.fold(0, (int previousValue, int element) => previousValue + element);
    return maxIVSlotsSum;
  }

  List<int> getMaxIVSlotsAmountList() {
    List<int> maxIVSSlotsAmountList =
        maxIVTextEditingControllersList.map((TextEditingController textEditingController) => int.tryParse(textEditingController.text) ?? 0).toList();
    return maxIVSSlotsAmountList;
  }
}
