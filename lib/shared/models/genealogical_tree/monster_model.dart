import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/monster_gen.dart';
import 'package:equatable/equatable.dart';

class MonsterModel extends Equatable {
  final List<IVColor> _ivColorList;
  final bool _isAutoFilledBool;
  final MonsterGen _monsterGen;

  const MonsterModel({
    required List<IVColor> ivColorList,
    required bool isAutoFilledBool,
    required MonsterGen monsterGen,
  })  : _ivColorList = ivColorList,
        _isAutoFilledBool = isAutoFilledBool,
        _monsterGen = monsterGen;

  List<IVColor> get ivColorList => List<IVColor>.unmodifiable(_ivColorList);

  bool get isAutoFilledBool => _isAutoFilledBool;

  MonsterGen get monsterGen => _monsterGen;

  @override
  List<Object?> get props => <Object?>[_ivColorList, _isAutoFilledBool, _monsterGen];

  MonsterModel updateIVColor(List<IVColor> ivColorList, IVColor ivColor) {
    // Create a new list to avoid mutating the original list
    List<IVColor> updatedList = List<IVColor>.from(ivColorList);

    // Find the index of ivColor or defaultColor and update it
    int replaceIndex;
    if (updatedList.contains(ivColor)) {
      replaceIndex = updatedList.indexWhere((IVColor color) => color == ivColor);
      updatedList[replaceIndex] = IVColor.defaultColor;
    } else {
      replaceIndex = updatedList.indexWhere((IVColor color) => color == IVColor.defaultColor);
      if (replaceIndex >= 0) {
        updatedList[replaceIndex] = ivColor;
      }
    }

    if (updatedList.contains(IVColor.defaultColor)) {
      return MonsterModel(
        ivColorList: updatedList,
        isAutoFilledBool: isAutoFilledBool,
        monsterGen: monsterGen,
      );
    } else {
      updatedList.sort((IVColor firstIVColor, IVColor secondIVColor) => firstIVColor.index.compareTo(secondIVColor.index));
    }
    return MonsterModel(
      ivColorList: updatedList,
      isAutoFilledBool: _isAutoFilledBool,
      monsterGen: _monsterGen,
    );
  }

  // Inherit IVColor values and the generation from another MonsterModel
  MonsterModel inheritValues(List<IVColor> ivColorList, MonsterGen monsterGen) {
    // Ensure the list is sorted based on the IVColor index
    ivColorList.sort((IVColor firstIVColor, IVColor secondIVColor) => firstIVColor.index.compareTo(secondIVColor.index));

    // Create a new model with inherited values
    return MonsterModel(
      ivColorList: ivColorList,
      isAutoFilledBool: true, // Mark as auto-filled
      monsterGen: monsterGen,
    );
  }

  // Reset the IVColor list to the default values
  MonsterModel getDefaultIVColors() {
    // Create a list filled with the default color, sized according to the generation value
    List<IVColor> defaultList = List<IVColor>.filled(_monsterGen.value, IVColor.defaultColor);

    // Return a new model with the default list and auto-filled flag set to false
    return MonsterModel(
      ivColorList: defaultList,
      isAutoFilledBool: false,
      monsterGen: _monsterGen,
    );
  }
}
