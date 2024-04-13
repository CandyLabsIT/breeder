import 'package:breeder/shared/controllers/singel_iv_text_editing_controllers.dart';
import 'package:flutter/cupertino.dart';

class SingleIVFormModel {
  late List<TextEditingController> singleIVTextEditingControllersList;

  SingleIVFormModel() {
    SingleIVTextEditingControllers singleIVTextEditingControllers = SingleIVTextEditingControllers();

    singleIVTextEditingControllersList = singleIVTextEditingControllers.singleIVTextEditingControllersList;
  }

  int calculateAmountLeft(int maxSlots) {
    int amountLeft = maxSlots - calculateSum();

    return amountLeft;
  }

  int calculateSum() {
    List<int> amountList = singleIVTextEditingControllersList
        .map((TextEditingController textEditingController) => int.tryParse(textEditingController.text) ?? 0)
        .toList();

    int formsSum = amountList.fold(0, (int previousValue, int element) => previousValue + element);

    return formsSum;
  }

  Map<String, int> getIVMap(){
    List<int> amountList = getAmountList();
    List<String> ivKeys = <String>['atk', 'hp', 'def', 'speed', 'sp.atk', 'sp.def'];

    Map<String, int> ivMap = <String, int>{};

    for (int i = 0; i < 6; i++){
      String key = ivKeys[i];
      int value = amountList[i];

      ivMap[key] = value;
    }
    return ivMap;

  }

  List<int> getAmountList() {
    List<int> amountList = singleIVTextEditingControllersList
        .map((TextEditingController textEditingController) => int.tryParse(textEditingController.text) ?? 0)
        .toList();
    return amountList;
  }
}
