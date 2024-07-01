import 'package:breeder/shared/models/new_breeding/new_breeding_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of NewBreedingModel', () {
    NewBreedingModel newBreedingModel = NewBreedingModel()..newBreedingTextEditingController.text = 'Test123';

    test('Should return ' ' if [input is text and digits]', () {
      newBreedingModel.clearData();
      String actualNewBreedingTextEditingController = newBreedingModel.newBreedingTextEditingController.text;

      String expectedNewBreedingTextEditingController = '';

      expect(actualNewBreedingTextEditingController, expectedNewBreedingTextEditingController);
    });

    test('Should return ' ' if [input is only digits]', () {
      newBreedingModel.newBreedingTextEditingController.text = '13 54';

      newBreedingModel.clearData();
      String actualNewBreedingTextEditingController = newBreedingModel.newBreedingTextEditingController.text;

      String expectedNewBreedingTextEditingController = '';

      expect(actualNewBreedingTextEditingController, expectedNewBreedingTextEditingController);
    });

    test('Should return ' ' if [input is only text]', () {
      newBreedingModel.newBreedingTextEditingController.text = 'abc xyz';

      newBreedingModel.clearData();
      String actualNewBreedingTextEditingController = newBreedingModel.newBreedingTextEditingController.text;

      String expectedNewBreedingTextEditingController = '';

      expect(actualNewBreedingTextEditingController, expectedNewBreedingTextEditingController);
    });
  });
}
