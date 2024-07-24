enum GenderValues{
  female(0),
  male(1);

  final int genderValue;

  const GenderValues(this.genderValue);

  int get value => genderValue;
}

