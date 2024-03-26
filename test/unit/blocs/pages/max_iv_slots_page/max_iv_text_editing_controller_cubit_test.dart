import 'package:breeder/blocks/pages/max_iv_slots_creator_page/a_max_iv_slots_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/max_iv_slots_cubit.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/states/max_iv_slots_amount_change_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/states/max_iv_slots_initial_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/states/max_iv_slots_sum_changed_state.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/max_iv_slots_amount_model/max_iv_slots_model.dart';
import 'package:breeder/shared/models/max_iv_slots_amount_model/max_iv_text_editing_controllers_list.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  await initLocator();

  group('Tests of MaxIVTextEditingControllersCubit process', () {
    final MaxIVTextEditingControllersList maxIVTextEditingControllersList = MaxIVTextEditingControllersList();
    final MaxIVSlotsModel maxIVSlotsModel = MaxIVSlotsModel()
      ..maxIVTextEditingControllersList = maxIVTextEditingControllersList.maxIVTextEditingControllersList;
    MaxIVSlotsCubit actualMaxIVSlotsCubit = globalLocator<MaxIVSlotsCubit>();
    maxIVTextEditingControllersList.maxIVTextEditingControllersList[0].text = '2';
    maxIVTextEditingControllersList.maxIVTextEditingControllersList[1].text = '1';
    maxIVTextEditingControllersList.maxIVTextEditingControllersList[2].text = '1';
    maxIVTextEditingControllersList.maxIVTextEditingControllersList[3].text = '1';
    maxIVTextEditingControllersList.maxIVTextEditingControllersList[4].text = '1';

    test('Should emit initial state', () async {
      AMaxIVSlotsState expectMaxIVSlotsState = MaxIVSlotsInitialState();

      // ignore: avoid_print
      print('Should return MaxIVTextEditingControllersInitial');

      expect(actualMaxIVSlotsCubit.state.runtimeType, expectMaxIVSlotsState.runtimeType);

      // ************************************************************************************************
    });

    test('Should return MaxIVSlotsAmountChangeState', () async {
      actualMaxIVSlotsCubit.maxIVSlotsAmountList();

      AMaxIVSlotsState expectMaxIVSlotsState = MaxIVSlotsAmountChangedState(maxIVSlotsAmountList: maxIVSlotsModel.getMaxIVSlotsAmountList());

      // ignore: avoid_print
      print('Should return MaxIVSlotsAmountChangeState');

      expect(actualMaxIVSlotsCubit.state.runtimeType, expectMaxIVSlotsState.runtimeType);

      // ************************************************************************************************
    });

    test('Should return return MaxIVSlotsSumChangedState', () async {
      actualMaxIVSlotsCubit.calculateMaxIVSlotsSum();

      AMaxIVSlotsState expectMaxIVSlotsState = MaxIVSlotsSumChangedState(maxIVSlotsSum: maxIVSlotsModel.calculateMaxIVSlotsSum());

      // ignore: avoid_print
      print('Should return MaxIVSlotsSumChangedState');

      expect(actualMaxIVSlotsCubit.state.runtimeType, expectMaxIVSlotsState.runtimeType);
    });
  });
}
