import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';

import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';

class FirstGenIVButtonsState extends AFirstGenState {
  final Map<IVColor, bool> ivButtonMap;
  
  const FirstGenIVButtonsState({required this.ivButtonMap});

  @override
  List<Map<IVColor, bool>> get props => <Map<IVColor, bool>>[ivButtonMap];
}