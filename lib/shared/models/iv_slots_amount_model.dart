import 'package:breeder/config/controllers/maxi_iv_text_formatter_cotrollers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IVSlotsAmountModel {
  late List<TextEditingController> ivSlotsDataList;

  IVSlotsAmountModel() {
    IVTextEditingControllersList ivControllersList = IVTextEditingControllersList()
    ..initControllers();
    ivSlotsDataList = ivControllersList.textEditingControllerList;
  }

  List<int> getAmountList() {
    List<int> slotsAmountList = ivSlotsDataList.map((TextEditingController controller) => int.tryParse(controller.text) ?? 0).toList();
    return slotsAmountList;
  }

  int calculateSlotsSum() {
    List<int> slotsAmountList = getAmountList();
    slotsAmountList[1] *= 2;
    slotsAmountList[2] *= 4;
    slotsAmountList[3] *= 8;
    slotsAmountList[4] *= 16;
    int slotsSum = slotsAmountList.fold(0, (int previousValue, int element) => previousValue + element);
    return slotsSum;
  }

  int getSlotsLeft(int inputWeight) {
    int slotsLeft = ((32 - calculateSlotsSum()) / inputWeight).truncate();
    return slotsLeft;
  }

  void updateTextFormValue(int index, String value) {
    ivSlotsDataList[index].text = value;
  }
}