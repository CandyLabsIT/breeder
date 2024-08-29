import 'dart:ui';

enum IVColor {
  defaultColor(Color(0xFFD9D9D9)),
  atkColor(Color(0xFFFA4A78)),
  hpColor(Color(0xFF7AE3FC)),
  spAtkColor(Color(0xFFFDFB8E)),
  defColor(Color(0xFFFFDAD6)),
  spDefColor(Color(0xFFCFA9F2)),
  speedColor(Color(0xFF96EF9E));

  final Color color;

  const IVColor(this.color);
}

extension IVColorExtension on IVColor {
  static IVColor fromInt(int value) {
    return IVColor.values.firstWhere((IVColor ivColor) => ivColor.index == value, orElse: () => IVColor.defaultColor);
  }
}
