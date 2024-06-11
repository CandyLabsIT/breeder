import 'package:breeder/shared/controllers/new_breeding_text_editing_controller.dart';
import 'package:flutter/cupertino.dart';

class NewBreedingModel {
  late TextEditingController _newBreedingTextEditingController;

  TextEditingController get newBreedingTextEditingController => _newBreedingTextEditingController;

  NewBreedingModel() {
    NewBreedingTextEditingController()
      ..initNewBreedingTextEditingControllers()
      ..newBreedingTextEditingController;
  }

  void clearData() {
    newBreedingTextEditingController.clear();
  }
}
