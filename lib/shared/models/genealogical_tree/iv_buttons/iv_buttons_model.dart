import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';

class IVButtonsModel {
  late Map<IVColor, bool> ivButtonsMap;

  IVButtonsModel() {
    ivButtonsMap = <IVColor, bool>{for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true};
  }
}
