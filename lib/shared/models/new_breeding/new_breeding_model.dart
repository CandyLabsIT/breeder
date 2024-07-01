import 'package:breeder/shared/controllers/new_breeding_text_editing_controller.dart';
import 'package:flutter/cupertino.dart';

class NewBreedingModel {
  late TextEditingController newBreedingTextEditingController;

  NewBreedingModel() {
    NewBreedingTextEditingController newBreedingTextController = NewBreedingTextEditingController()..initNewBreedingTextEditingControllers();

    newBreedingTextEditingController = newBreedingTextController.newBreedingTextEditingController;
  }

  void clearData() {
    newBreedingTextEditingController.clear();
  }
}
