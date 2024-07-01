import 'package:flutter/cupertino.dart';

class NewBreedingTextEditingController {
  late TextEditingController newBreedingTextEditingController;

  NewBreedingTextEditingController() {
    initNewBreedingTextEditingControllers();
  }

  void initNewBreedingTextEditingControllers() {
    newBreedingTextEditingController = TextEditingController();
  }

// TODO(balladyna): Dispose is currently nowhere used. Consider where should be call

  void dispose() {
    newBreedingTextEditingController.dispose();
  }
}
