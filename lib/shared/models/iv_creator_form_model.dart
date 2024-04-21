class IVCreatorFormModel {
  late List<int> amountList;

  late int currentWidgetIndex;

  List<int> allWidgetList = <int>[
    1,
    2,
  ];

  IVCreatorFormModel(this.amountList) {
    currentWidgetIndex = 0;
  }

  List<int> getWidgetList() {
    List<int> widgetList = <int>[1];
    for (int i = 1; i < allWidgetList.length; i++) {
      if (amountList[i - 1] > 0) {
        widgetList.add(allWidgetList[i]);
      }
    }
    return widgetList;
  }

  int getNextWidget() {
    List<int> widgetList = getWidgetList();
    int length = widgetList.length;
    if (currentWidgetIndex < (length - 1)) {
      currentWidgetIndex += 1;
    }
    return widgetList[currentWidgetIndex];
  }

  int getPreviousWidget() {
    List<int> widgetList = getWidgetList();
    if (currentWidgetIndex > 0) {
      currentWidgetIndex -= 1;
    }
    return widgetList[currentWidgetIndex];
  }
}
