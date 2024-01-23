import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonstersModel {
  List<TextEditingController> monstersNumber;

  MonstersModel({required this.monstersNumber});

  int calculateMonstersSum() {
    List<int> monstersCount = monstersNumber.map((TextEditingController controller) => int.tryParse(controller.text) ?? 0).toList();
    monstersCount[1] *= 2;
    monstersCount[2] *= 4;
    monstersCount[3] *= 8;
    monstersCount[4] *= 16;
    int monstersSum = monstersCount.fold(0, (int previousValue, int element) => previousValue + element);
    return monstersSum;
  }
}
