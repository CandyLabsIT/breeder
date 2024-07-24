enum IVValues{
  defaultValue(0),
  atkValue(1),
  hpValue(2),
  spAtkValue(3),
  defValue(4),
  spDefValue(5),
  speedValue(6);

  final int ivValue;
  const IVValues(this.ivValue);

  int get value => ivValue;
}