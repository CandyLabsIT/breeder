import 'package:breeder/shared/models/monsters_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of MonsterDataModel.calculateMonstersSum', () {
    test('Should return [sum of all inputs] if [all inputs are digits]', () {
      List<TextEditingController> controllers = <TextEditingController>[
        TextEditingController(text: '2'),
        TextEditingController(text: '1'),
        TextEditingController(text: '1'),
        TextEditingController(text: '1'),
        TextEditingController(text: '1'),
      ];
      MonstersModel monstersModel = MonstersModel(monstersNumber: controllers);

      expect(monstersModel.calculateMonstersSum(), 32);
    });
    test('Should return [sum of valid inputs] if [some inputs are empty]', () {
      List<TextEditingController> controllers = <TextEditingController>[
        TextEditingController(text: '2'),
        TextEditingController(text: ''),
        TextEditingController(text: '2'),
        TextEditingController(text: '1'),
        TextEditingController(text: ''),
      ];
      MonstersModel monstersModel = MonstersModel(monstersNumber: controllers);

      expect(monstersModel.calculateMonstersSum(), 18);
    });
    test('Should return [0 (zero)] if [all inputs are empty]', () {
      List<TextEditingController> controllers = <TextEditingController>[
        TextEditingController(text: ''),
        TextEditingController(text: ''),
        TextEditingController(text: ''),
        TextEditingController(text: ''),
        TextEditingController(text: ''),
      ];
      MonstersModel monstersModel = MonstersModel(monstersNumber: controllers);

      expect(monstersModel.calculateMonstersSum(), 0);
    });
  });
}
