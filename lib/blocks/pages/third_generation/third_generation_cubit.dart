import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/displayed_third_generation_widget_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/init_third_generation_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/restarted_third_generation_female_values_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/restarted_third_generation_male_values_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/third_generation_female_color_state.dart';
import 'package:breeder/blocks/pages/third_generation/state/third_generation_male_color_state.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_generation_model.dart';
import 'package:breeder/views/widgets/generic/custom_container.dart';
import 'package:breeder/views/widgets/generic/third_generation/third_generation_sliding_panel/third_generation_female_sliding_panel.dart';
import 'package:breeder/views/widgets/generic/third_generation/third_generation_sliding_panel/third_generation_male_sliding_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdGenerationCubit extends Cubit<AThirdGenerationState> {
  ThirdGenerationModel thirdGenerationModel = ThirdGenerationModel();

  ThirdGenerationCubit() : super(InitSecondGenerationFamilyState());

  void getFemaleColors(int listNumber, int value) {
    thirdGenerationModel.updateValues(thirdGenerationModel.thirdGenerationIVList[listNumber][0], value);
    emit(ThirdGenerationFemaleColorsState(valuesList: _getColorsList(0)));
  }

  void getMaleColors(int listNumber, int value) {
    thirdGenerationModel.updateValues(thirdGenerationModel.thirdGenerationIVList[listNumber][1], value);
    emit(
      ThirdGenerationMaleColorsState(valuesList: _getColorsList(1)),
    );
  }

  void resetFemaleValues(int listNumber) {
    if (thirdGenerationModel.isSumPositive(thirdGenerationModel.thirdGenerationIVList[listNumber][0])) {
      thirdGenerationModel.restartListValues(thirdGenerationModel.thirdGenerationIVList[listNumber][0]);
    }
    emit(
      RestartedThirdGenerationFemaleValuesState(
        valuesList: _getColorsList(0),
      ),
    );
  }

  void resetThirdMaleValues(int listNumber) {
    if (thirdGenerationModel.isSumPositive(thirdGenerationModel.thirdGenerationIVList[listNumber][1])) {
      thirdGenerationModel.restartListValues(thirdGenerationModel.thirdGenerationIVList[listNumber][1]);
    }
    emit(
      RestartedThirdGenerationMaleValuesState(valuesList: _getColorsList(1)),
    );
  }

  void getThirdGenerationWidget(int number, int listIndex) {
    if (number == 0) {
      emit(
        DisplayedThirdGenerationWidgetState(thirdGenerationWidget: ThirdGenerationFemaleSlidingPanel(listIndex: listIndex)),
      );
    } else {
      emit(
        DisplayedThirdGenerationWidgetState(thirdGenerationWidget: ThirdGenerationMaleSlidingPanel(listIndex: listIndex)),
      );
    }
  }

  Widget getWidget() {
    if (state is DisplayedThirdGenerationWidgetState) {
      return (state as DisplayedThirdGenerationWidgetState).thirdGenerationWidget;
    }
    return const CustomContainer(
      containerHeight: 10,
      containerWidth: 10,
      columnItems: <Widget>[],
    );
  }

  List<Color> getFemaleButtonColors(int listNumber) {
    if (state is ThirdGenerationFemaleColorsState) {
      return (state as ThirdGenerationFemaleColorsState).valuesList;
    } else if (state is RestartedThirdGenerationFemaleValuesState) {
      return (state as RestartedThirdGenerationFemaleValuesState).valuesList;
    }
    return _getColorsList(0);
  }

  List<Color> getMaleButtonColors(int listNumber) {
    if (state is ThirdGenerationMaleColorsState) {
      return (state as ThirdGenerationMaleColorsState).valuesList;
    } else if (state is RestartedThirdGenerationMaleValuesState) {
      return (state as RestartedThirdGenerationMaleValuesState).valuesList;
    }
    return _getColorsList(1);
  }

  List<Color> _getColorsList(int index) {
    return <Color>[
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[0][index][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[0][index][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[0][index][2]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[1][index][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[1][index][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[1][index][2]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[2][index][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[2][index][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[2][index][2]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[3][index][0]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[3][index][1]).color,
      IVColorExtension.fromInt(thirdGenerationModel.thirdGenerationIVList[3][index][2]).color,
    ];
  }
}
