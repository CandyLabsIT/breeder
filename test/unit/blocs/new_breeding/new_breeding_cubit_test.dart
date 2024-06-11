import 'package:breeder/blocks/pages/genealogical_tree/first_gen/first_gen_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/new_breeding_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/states/new_breeding_init_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of NewBreedingCubit process', () {
    // Arrange
    NewBreedingCubit actualNewBreedingCubit = globalLocator<NewBreedingCubit>();
    FirstGenCubit firstGenCubit = globalLocator<FirstGenCubit>();

    test('Should emit [NewBreedingInitState] state', () {
      // Arrange
      NewBreedingInitState expectedNewBreedingState = const NewBreedingInitState();

      // Assert
      expect(actualNewBreedingCubit.state, expectedNewBreedingState);
    });

    test('Should return [empty TextEditingController] when resetData() is activated', () {
      // Arrange
      String expectedNewBreedingTextEditingController = '';

      // Act
      actualNewBreedingCubit.resetData();
      String actualNewBreedingTextEditingController = actualNewBreedingCubit.newBreedingModel.newBreedingTextEditingController.text;

      // Assert
      expect(actualNewBreedingTextEditingController, expectedNewBreedingTextEditingController);
    });

    test('Should return [default IVColorMap] when resetData() is activated', () {
      // Arrange
      Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = <FirstGenIndex, List<IVColor>>{
        for (FirstGenIndex index in FirstGenIndex.values) index: <IVColor>[IVColor.defaultColor],
      };

      // Act
      actualNewBreedingCubit.resetData();
      Map<FirstGenIndex, List<IVColor>> actualIVColorMap = firstGenCubit.firstGenModel.firstGenMap.map(
          (FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
              MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));

      // Assert
      expect(actualIVColorMap, expectedIVColorMap);
    });
  });
}
