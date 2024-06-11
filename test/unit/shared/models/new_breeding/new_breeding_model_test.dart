import 'package:breeder/shared/models/new_breeding/new_breeding_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of NewBreedingModel', () {
    // Act
    NewBreedingModel actualNewBreedingModel = NewBreedingModel()..newBreedingTextEditingController.text = 'Test123';

    test('Should return [empty TextEditingController.text] when [input is text and digits]', () {
      // Arrange
      String expectedNewBreedingTextEditingController = '';

      // Act
      actualNewBreedingModel.clearData();
      String actualNewBreedingTextEditingController = actualNewBreedingModel.newBreedingTextEditingController.text;

      // Assert
      expect(actualNewBreedingTextEditingController, expectedNewBreedingTextEditingController);
    });

    test('Should return [empty TextEditingController.text] when [input is only digits]', () {
      // Arrange
      String expectedNewBreedingTextEditingController = '';

      // Act
      actualNewBreedingModel.newBreedingTextEditingController.text = '13 54';
      actualNewBreedingModel.clearData();
      String actualNewBreedingTextEditingController = actualNewBreedingModel.newBreedingTextEditingController.text;

      // Assert
      expect(actualNewBreedingTextEditingController, expectedNewBreedingTextEditingController);
    });

    test('Should return [empty TextEditingController.text] when [input is only text]', () {
      // Arrange
      String expectedNewBreedingTextEditingController = '';

      // Act
      actualNewBreedingModel.newBreedingTextEditingController.text = 'abc xyz';
      actualNewBreedingModel.clearData();
      String actualNewBreedingTextEditingController = actualNewBreedingModel.newBreedingTextEditingController.text;

      // Assert
      expect(actualNewBreedingTextEditingController, expectedNewBreedingTextEditingController);
    });
  });
}
