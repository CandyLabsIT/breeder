import 'package:breeder/blocks/pages/genealogical_tree/first_gen/first_gen_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/new_breeding_cubit.dart';
import 'package:breeder/blocks/pages/new_breeding/states/new_breeding_init_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_model.dart';
import 'package:breeder/shared/models/new_breeding/new_breeding_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of NewBreedingCubit process', () {
    NewBreedingCubit actualNewBreedingCubit = globalLocator<NewBreedingCubit>();
    FirstGenCubit firstGenCubit = globalLocator<FirstGenCubit>();

    NewBreedingModel newBreedingModel = NewBreedingModel()..newBreedingTextEditingController.text = 'Test123';

    test('Should emit [NewBreedingInitState] state', () {
      NewBreedingInitState expectedNewBreedingState = const NewBreedingInitState();

      expect(actualNewBreedingCubit.state, expectedNewBreedingState);
    });

    test('Should emit [NewBreedingInitState] state when when [NewBreedingModel] data is initialized', () {
      actualNewBreedingCubit.newBreedingModel = newBreedingModel;

      NewBreedingInitState expectedNewBreedingState = const NewBreedingInitState();

      expect(actualNewBreedingCubit.state, expectedNewBreedingState);
    });

    test('Should reset data in new breeding model when resetData is activated', () {
      String expectedNewBreedingTextEditingController = '';

      actualNewBreedingCubit.resetData();

      String actualNewBreedingTextEditingController = actualNewBreedingCubit.newBreedingModel.newBreedingTextEditingController.text;

      expect(actualNewBreedingTextEditingController, expectedNewBreedingTextEditingController);
    });

    test('Should reset data in new breeding model when resetData is activated', () {
      String expectedNewBreedingTextEditingController = '';

      actualNewBreedingCubit.resetData();

      String actualNewBreedingTextEditingController = actualNewBreedingCubit.newBreedingModel.newBreedingTextEditingController.text;

      expect(actualNewBreedingTextEditingController, expectedNewBreedingTextEditingController);
    });

    test('Should return "" in new breeding model when resetData is activated', () {
      Map<FirstGenIndex, List<IVColor>> expectedIVColorMap = <FirstGenIndex, List<IVColor>>{
        for (FirstGenIndex index in FirstGenIndex.values) index: <IVColor>[IVColor.defaultColor],
      };

      actualNewBreedingCubit.resetData();

      Map<FirstGenIndex, List<IVColor>> actualIVColorMap = firstGenCubit.firstGenModel.firstGenMap.map(
          (FirstGenIndex firstGenIndex, MonsterModel monsterModel) =>
              MapEntry<FirstGenIndex, List<IVColor>>(firstGenIndex, monsterModel.ivColorList));

      expect(actualIVColorMap, expectedIVColorMap);
    });
  });
}
