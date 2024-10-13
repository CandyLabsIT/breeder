import 'dart:core';

import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_colors_changed_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_init_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/states/first_gen_monster_default_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_model.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstGenCubit extends Cubit<ASecondGenState> {
  FirstGenModel firstGenModel = FirstGenModel();
  MaxIVFormCubit maxIVFormCubit = globalLocator<MaxIVFormCubit>();

  FirstGenCubit() : super(InitSecondGenState());

  void setColors(FirstGenIndex secondGenIndex, IVColor ivColor) {
    firstGenModel.updateIVColor(secondGenIndex, ivColor);
    Map<FirstGenIndex, List<IVColor>> secondGenMap = Map<FirstGenIndex, List<IVColor>>.from(firstGenModel.firstGenMap);
    emit(FirstGenColorsChangedState(firstGenMap: secondGenMap));
  }

  void resetAllToDefaultColors() {
    firstGenModel.resetAll();
    Map<FirstGenIndex, List<IVColor>> secondGenMap = Map<FirstGenIndex, List<IVColor>>.from(firstGenModel.firstGenMap);
    emit(FirstGenColorsChangedState(firstGenMap: secondGenMap));
  }

  void resetMonsterToDefaultIVColors(FirstGenIndex firstGenIndex) {
    firstGenModel.resetMonsterToDefaultIVColors(firstGenIndex);
    Map<FirstGenIndex, List<IVColor>> secondGenMap = Map<FirstGenIndex, List<IVColor>>.from(firstGenModel.firstGenMap);
    emit(SecondGenMonsterDefaultState(firstGenMap: secondGenMap));
  }

  Map<FirstGenIndex, List<IVColor>> getColors() {
    if (state is FirstGenColorsChangedState) {
      return (state as FirstGenColorsChangedState).firstGenMap;
    } else if (state is SecondGenMonsterDefaultState) {
      return (state as SecondGenMonsterDefaultState).firstGenMap;
    }
    Map<FirstGenIndex, List<IVColor>> secondGenMap = Map<FirstGenIndex, List<IVColor>>.from(firstGenModel.firstGenMap);
    return secondGenMap;
  }

  Map<FirstGenIndex, bool> getMonsterButtonState() {
    Map<FirstGenIndex, bool> monsterButtonsMap = <FirstGenIndex, bool>{};
    for (FirstGenIndex firstGenIndex in FirstGenIndex.values) {
      monsterButtonsMap[firstGenIndex] = isMonsterPairEnabled(firstGenIndex);
    }
    return monsterButtonsMap;
  }

  bool isMonsterPairEnabled(FirstGenIndex firstGenIndex) {
    bool isEnabledBool = false;

    List<int> maxIVList = maxIVFormCubit.maxIVFormModel.getAmountList();
    int maxIVSum = maxIVFormCubit.maxIVFormModel.calculateWeightedSum();
    int firstGenIndexValue = firstGenIndex.value;

    if (maxIVList[0] != 0 && maxIVSum > maxIVList[0] && firstGenIndexValue <= maxIVList[0]) {
      if (firstGenIndexValue <= 2) {
        isEnabledBool = true;
        return isEnabledBool;
      }
      if (firstGenIndexValue > maxIVList[0]) {
        return isEnabledBool;
      } else {
        isEnabledBool = firstGenModel.isPreviousPairFilled(firstGenIndex);
      }
    } else if (maxIVList[0] == 0 || maxIVSum == maxIVList[0] || firstGenIndexValue <= maxIVList[0]) {
      if (firstGenIndexValue <= 2) {
        isEnabledBool = true;
        return isEnabledBool;
      }
      isEnabledBool = firstGenModel.isPreviousPairFilled(firstGenIndex);
      return isEnabledBool;
    }
    return isEnabledBool;
  }

  bool isRestartButtonEnabled(FirstGenIndex secondGenIndex) {
    bool restartButtonEnabledBool = firstGenModel.hasIVValue(secondGenIndex);
    return restartButtonEnabledBool;
  }

  Map<IVColor, bool> getIVButtonsState(FirstGenIndex secondGenIndex) {
    FirstGenIndex femaleIndex = firstGenModel.getFemaleIndex(secondGenIndex);
    FirstGenIndex maleIndex = firstGenModel.getMaleIndex(secondGenIndex);

    List<IVColor> femaleIVList = firstGenModel.firstGenMap[femaleIndex]!;
    List<IVColor> maleIVList = firstGenModel.firstGenMap[maleIndex]!;

    if (secondGenIndex == femaleIndex) {
      return _setIVButtonsState(femaleIVList, maleIVList, femaleIndex, maleIndex);
    } else {
      return _setIVButtonsState(maleIVList, femaleIVList, maleIndex, femaleIndex);
    }
  }

  Map<IVColor, bool> _setIVButtonsState(
      List<IVColor> activeMonsterIVList, List<IVColor> pairedMonsterIVList, FirstGenIndex activeGenIndex, FirstGenIndex pairedGenIndex) {
    Map<IVColor, bool> ivButtonsMap = generateIVButtonMap();

    int indexValue = activeGenIndex.value;
    Set<IVColor> firstGenSet;
    Set<IVColor> previousPairSet;
    Set<IVColor> partlyIVColorSet;

    if (firstGenModel.hasIVValue(activeGenIndex)) {
      for (IVColor key in ivButtonsMap.keys) {
        ivButtonsMap[key] = activeMonsterIVList.contains(key);
      }
      return ivButtonsMap;
    }
    if (indexValue <= 2) {
      if (firstGenModel.hasIVValue(pairedGenIndex)) {
        return isNotPairedMonsterIV(pairedMonsterIVList, ivButtonsMap);
      }
      return ivButtonsMap;
    }

    if (indexValue < 5) {
      firstGenSet = firstGenModel.getFirstGenSet(FirstGenIndex.two);
      if (firstGenModel.hasIVValue(pairedGenIndex)) {
        if (firstGenSet.containsAll(pairedMonsterIVList)) {
          return isNotInFirstGenSet(firstGenSet, ivButtonsMap);
        } else {
          return isInFirstGenSet(firstGenSet, ivButtonsMap);
        }
      }
    }
    previousPairSet = firstGenModel.getPreviousPair(activeGenIndex);
    if (indexValue < 9) {
      firstGenSet = firstGenModel.getFirstGenSet(FirstGenIndex.four);
      if (indexValue < 7) {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          if (firstGenSet.containsAll(pairedMonsterIVList)) {
            return isNotPairedMonsterIV(pairedMonsterIVList, ivButtonsMap);
          } else {
            return isInFirstGenSet(firstGenSet, ivButtonsMap);
          }
        } else {
          return ivButtonsMap;
        }
      } else {
        if (firstGenSet.containsAll(previousPairSet)) {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              return isNotInFirstGenSet(firstGenSet, ivButtonsMap);
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            return isInPreviousPairOrNotFirstGen(firstGenSet, previousPairSet, ivButtonsMap);
          }
        } else {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              return isInFirstGenSetAndNotInInPreviousPair(firstGenSet, previousPairSet, ivButtonsMap);
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            return isKeyInFirstGenOrPreviousPair(firstGenSet, previousPairSet, ivButtonsMap);
          }
        }
      }
    } else if (indexValue < 17) {
      partlyIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.nine, FirstGenIndex.twelve);
      firstGenSet = firstGenModel.getFirstGenSet(FirstGenIndex.eight);
      if (indexValue < 11) {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          if (firstGenSet.containsAll(pairedMonsterIVList)) {
            return isNotPairedMonsterIV(pairedMonsterIVList, ivButtonsMap);
          } else {
            return isInFirstGenSet(firstGenSet, ivButtonsMap);
          }
        } else {
          return ivButtonsMap;
        }
      } else if (indexValue < 13) {
        if (firstGenSet.containsAll(previousPairSet)) {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              for (IVColor key in ivButtonsMap.keys) {
                ivButtonsMap[key] = !previousPairSet.contains(key);
              }
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          }
          return ivButtonsMap;
        } else {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              return isInFirstGenSetAndNotInInPreviousPair(firstGenSet, previousPairSet, ivButtonsMap);
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            return isKeyInFirstGenOrPreviousPair(firstGenSet, previousPairSet, ivButtonsMap);
          }
        }
      } else {
        if (firstGenSet.containsAll(partlyIVColorSet)) {
          if (indexValue < 15) {
            if (firstGenModel.hasIVValue(pairedGenIndex)) {
              if (partlyIVColorSet.containsAll(pairedMonsterIVList)) {
                for (IVColor key in ivButtonsMap.keys) {
                  ivButtonsMap[key] = !(firstGenSet.difference(partlyIVColorSet).contains(key) || pairedMonsterIVList.contains(key));
                }
              } else {
                for (IVColor key in ivButtonsMap.keys) {
                  ivButtonsMap[key] = partlyIVColorSet.contains(key) && !pairedMonsterIVList.contains(key);
                }
              }
            } else {
              for (IVColor key in ivButtonsMap.keys) {
                ivButtonsMap[key] = firstGenSet.intersection(partlyIVColorSet).contains(key) || !firstGenSet.contains(key);
              }
            }
            return ivButtonsMap;
          } else {
            if (partlyIVColorSet.containsAll(previousPairSet)) {
              if (firstGenModel.hasIVValue(pairedGenIndex)) {
                if (previousPairSet.containsAll(pairedMonsterIVList)) {
                  for (IVColor key in ivButtonsMap.keys) {
                    ivButtonsMap[key] = !(firstGenSet.contains(key) || partlyIVColorSet.contains(key) || pairedMonsterIVList.contains(key));
                  }
                } else {
                  return isInPreviousPair(previousPairSet, ivButtonsMap);
                }
              } else {
                return isInPreviousPairOrNotFirstGen(firstGenSet, previousPairSet, ivButtonsMap);
              }
            } else {
              if (firstGenModel.hasIVValue(pairedGenIndex)) {
                if (previousPairSet.containsAll(pairedMonsterIVList)) {
                  return isInPartlyIVColorAndNotInPreviousPair(partlyIVColorSet, previousPairSet, ivButtonsMap);
                } else {
                  return isInPreviousPair(previousPairSet, ivButtonsMap);
                }
              } else {
                return isInPartlyIVColorOrPreviousPair(partlyIVColorSet, previousPairSet, ivButtonsMap);
              }
            }
          }
        } else {
          if (indexValue < 15) {
            if (firstGenModel.hasIVValue(pairedGenIndex)) {
              if (partlyIVColorSet.containsAll(pairedMonsterIVList)) {
                for (IVColor key in ivButtonsMap.keys) {
                  ivButtonsMap[key] = (firstGenSet.contains(key) || partlyIVColorSet.contains(key)) && !pairedMonsterIVList.contains(key);
                }
              } else {
                for (IVColor key in ivButtonsMap.keys) {
                  ivButtonsMap[key] = partlyIVColorSet.contains(key);
                }
              }
            } else {
              for (IVColor key in ivButtonsMap.keys) {
                ivButtonsMap[key] = firstGenSet.contains(key) || partlyIVColorSet.contains(key);
              }
            }
            return ivButtonsMap;
          } else {
            if (partlyIVColorSet.containsAll(previousPairSet)) {
              if (firstGenModel.hasIVValue(pairedGenIndex)) {
                if (previousPairSet.containsAll(pairedMonsterIVList)) {
                  for (IVColor key in ivButtonsMap.keys) {
                    ivButtonsMap[key] = firstGenSet.difference(partlyIVColorSet).contains(key) && !previousPairSet.contains(key);
                  }
                } else {
                  return isInPreviousPair(previousPairSet, ivButtonsMap);
                }
              } else {
                for (IVColor key in ivButtonsMap.keys) {
                  ivButtonsMap[key] = firstGenSet.difference(partlyIVColorSet).contains(key) || previousPairSet.contains(key);
                }
              }
              return ivButtonsMap;
            } else {
              if (firstGenModel.hasIVValue(pairedGenIndex)) {
                if (previousPairSet.containsAll(pairedMonsterIVList)) {
                  return isInPartlyIVColorAndNotInPreviousPair(partlyIVColorSet, previousPairSet, ivButtonsMap);
                } else {
                  return isInPreviousPair(previousPairSet, ivButtonsMap);
                }
              } else {
                return isInPartlyIVColorOrPreviousPair(partlyIVColorSet, previousPairSet, ivButtonsMap);
              }
            }
          }
        }
      }
    }
    firstGenSet = firstGenModel.getFirstGenSet(FirstGenIndex.sixteen);
    if (indexValue > 16) {
      firstGenSet = firstGenModel.getFirstGenSet(FirstGenIndex.sixteen);
      partlyIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.seventeen, FirstGenIndex.thirtyTwo);
      print(indexValue);
      if (indexValue < 25) {
        return getIVButtonMapIndexBelow25(firstGenSet, activeMonsterIVList, pairedMonsterIVList, activeGenIndex, pairedGenIndex, indexValue);
      } else {
        if (firstGenSet.containsAll(partlyIVColorSet)) {
          return getIVIVButtonMapAbove25(firstGenSet, activeMonsterIVList, pairedMonsterIVList, activeGenIndex, pairedGenIndex, indexValue);
        } else {
          return getIVIVButtonMapAbove25P2(firstGenSet, activeMonsterIVList, pairedMonsterIVList, activeGenIndex, pairedGenIndex, indexValue);
        }
      }
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> getIVButtonMapIndexBelow25(Set<IVColor> firstGenSet, List<IVColor> activeMonsterIVList, List<IVColor> pairedMonsterIVList,
      FirstGenIndex activeGenIndex, FirstGenIndex pairedGenIndex, int indexValue) {
    Map<IVColor, bool> ivButtonsMap = generateIVButtonMap();

    Set<IVColor> secondPartIVColorSet;
    Set<IVColor> previousPairSet;

    if (firstGenModel.hasIVValue(activeGenIndex)) {
      for (IVColor key in ivButtonsMap.keys) {
        ivButtonsMap[key] = activeMonsterIVList.contains(key);
      }
      return ivButtonsMap;
    }
    if (indexValue <= 18) {
      if (firstGenModel.hasIVValue(pairedGenIndex)) {
        return isNotPairedMonsterIV(pairedMonsterIVList, ivButtonsMap);
      }
      return ivButtonsMap;
    }

    if (indexValue < 21) {
      secondPartIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.seventeen, FirstGenIndex.eighteen);
      if (firstGenModel.hasIVValue(pairedGenIndex)) {
        if (secondPartIVColorSet.containsAll(pairedMonsterIVList)) {
          return isNotInFirstGenSet(secondPartIVColorSet, ivButtonsMap);
        } else {
          return isInFirstGenSet(secondPartIVColorSet, ivButtonsMap);
        }
      }
    }
    previousPairSet = firstGenModel.getPreviousPair(activeGenIndex);
    if (indexValue < 25) {
      secondPartIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.seventeen, FirstGenIndex.twenty);
      if (indexValue < 23) {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          if (secondPartIVColorSet.containsAll(pairedMonsterIVList)) {
            return isNotPairedMonsterIV(pairedMonsterIVList, ivButtonsMap);
          } else {
            return isInFirstGenSet(secondPartIVColorSet, ivButtonsMap);
          }
        } else {
          return ivButtonsMap;
        }
      } else {
        if (secondPartIVColorSet.containsAll(previousPairSet)) {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              return isNotInFirstGenSet(secondPartIVColorSet, ivButtonsMap);
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            return isInPreviousPairOrNotFirstGen(secondPartIVColorSet, previousPairSet, ivButtonsMap);
          }
        } else {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              return isInFirstGenSetAndNotInInPreviousPair(secondPartIVColorSet, previousPairSet, ivButtonsMap);
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            return isKeyInFirstGenOrPreviousPair(secondPartIVColorSet, previousPairSet, ivButtonsMap);
          }
        }
      }
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> getIVIVButtonMapAbove25(Set<IVColor> firstGenSet, List<IVColor> activeMonsterIVList, List<IVColor> pairedMonsterIVList,
      FirstGenIndex activeGenIndex, FirstGenIndex pairedGenIndex, int indexValue) {
    Map<IVColor, bool> ivButtonsMap = generateIVButtonMap();

    Set<IVColor> secondPartIVColorSet;
    Set<IVColor> previousPairSet;
    Set<IVColor> partlyIVColorSet;

    previousPairSet = firstGenModel.getPreviousPair(activeGenIndex);
    secondPartIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.seventeen, FirstGenIndex.twentyFour);

    if (indexValue < 29) {
      if (indexValue < 27) {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = !pairedMonsterIVList.contains(key) && !firstGenSet.difference(secondPartIVColorSet).contains(key);
          }
        } else {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = !firstGenSet.difference(secondPartIVColorSet).contains(key);
          }
        }
      } else {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          if (previousPairSet.containsAll(pairedMonsterIVList)) {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = !previousPairSet.contains(key) && !firstGenSet.difference(secondPartIVColorSet).contains(key);
            }
          } else {
            return isInPreviousPair(previousPairSet, ivButtonsMap);
          }
        } else {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = !firstGenSet.difference(secondPartIVColorSet).contains(key);
          }
        }
      }
      return ivButtonsMap;
    } else {
      partlyIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.twentyFive, FirstGenIndex.twentyEight);
      if (indexValue < 31) {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          if (partlyIVColorSet.containsAll(pairedMonsterIVList)) {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = !(firstGenSet.difference(secondPartIVColorSet).contains(key) ||
                  secondPartIVColorSet.difference(partlyIVColorSet).contains(key) ||
                  pairedMonsterIVList.contains(key));
            }
          }
        } else {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] =
                !(firstGenSet.difference(secondPartIVColorSet).contains(key) || secondPartIVColorSet.difference(partlyIVColorSet).contains(key));
          }
        }
        return ivButtonsMap;
      } else {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          if (previousPairSet.containsAll(pairedMonsterIVList)) {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = !firstGenSet.contains(key);
            }
          } else {
            return isInPreviousPair(previousPairSet, ivButtonsMap);
          }
        } else {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = !firstGenSet.contains(key) || previousPairSet.contains(key);
          }
        }
      }
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> getIVIVButtonMapAbove25P2(Set<IVColor> firstGenSet, List<IVColor> activeMonsterIVList, List<IVColor> pairedMonsterIVList,
      FirstGenIndex activeGenIndex, FirstGenIndex pairedGenIndex, int indexValue) {
    Map<IVColor, bool> ivButtonsMap = generateIVButtonMap();

    Set<IVColor> secondPartIVColorSet;
    Set<IVColor> previousPairSet;
    Set<IVColor> partlyIVColorSet;

    previousPairSet = firstGenModel.getPreviousPair(activeGenIndex);
    partlyIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.seventeen, FirstGenIndex.twentyFour);

    if (indexValue < 29) {
      if (indexValue < 27) {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          secondPartIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.seventeen, FirstGenIndex.twentyFive);
          if (secondPartIVColorSet.length < 5) {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = !pairedMonsterIVList.contains(key);
            }
          } else {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = !pairedMonsterIVList.contains(key) && secondPartIVColorSet.contains(key);
            }
          }
        }
        return ivButtonsMap;
      } else {
        secondPartIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.seventeen, FirstGenIndex.twentySix);
        if (secondPartIVColorSet.length < 5) {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              for (IVColor key in ivButtonsMap.keys) {
                ivButtonsMap[key] = !previousPairSet.contains(key);
              }
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          }
          return ivButtonsMap;
        } else {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              for (IVColor key in ivButtonsMap.keys) {
                ivButtonsMap[key] = !previousPairSet.contains(key) && partlyIVColorSet.contains(key);
              }
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            return isInFirstGenSet(partlyIVColorSet.union(previousPairSet), ivButtonsMap);
          }
        }
      }
      return ivButtonsMap;
    }
    secondPartIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.seventeen, FirstGenIndex.twentyFour);
    if (indexValue < 31) {
      partlyIVColorSet = firstGenModel.getPartlyIVColorSet(FirstGenIndex.twentyFive, FirstGenIndex.twentyEight);
      if (secondPartIVColorSet.union(partlyIVColorSet).length < 5) {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          if (partlyIVColorSet.containsAll(pairedMonsterIVList)) {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = !pairedMonsterIVList.contains(key);
            }
          } else {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = !pairedMonsterIVList.contains(key) && partlyIVColorSet.contains(key);
            }
          }
        } else {
          return ivButtonsMap;
        }
        return ivButtonsMap;
      } else {
        if (firstGenModel.hasIVValue(pairedGenIndex)) {
          for (IVColor key in ivButtonsMap.keys) {
            ivButtonsMap[key] = !pairedMonsterIVList.contains(key) && partlyIVColorSet.union(partlyIVColorSet).contains(key);
          }
        } else {
          return isInFirstGenSet(secondPartIVColorSet.union(partlyIVColorSet), ivButtonsMap);
        }
      }
    } else {
      print('1 ${secondPartIVColorSet.union(partlyIVColorSet).length}');
      print('2 ${partlyIVColorSet.containsAll(previousPairSet)}');
      if (secondPartIVColorSet.union(partlyIVColorSet).union(previousPairSet).length < 5) {
        if (firstGenSet.containsAll(secondPartIVColorSet.union(partlyIVColorSet))) {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              for (IVColor key in ivButtonsMap.keys) {
                ivButtonsMap[key] = !firstGenSet.contains(key) && !partlyIVColorSet.union(partlyIVColorSet).contains(key);
              }
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] =
                  previousPairSet.contains(key) || !(firstGenSet.contains(key) && secondPartIVColorSet.union(partlyIVColorSet).contains(key));
            }
          }
        } else {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              print('3 ${firstGenSet.difference(secondPartIVColorSet.union(partlyIVColorSet))}');
              for (IVColor key in ivButtonsMap.keys) {
                ivButtonsMap[key] = firstGenSet.difference(secondPartIVColorSet.union(partlyIVColorSet)).contains(key);
              }
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = previousPairSet.contains(key) || firstGenSet.difference(secondPartIVColorSet.union(partlyIVColorSet)).contains(key);
            }
          }
        }
      } else {
        if (partlyIVColorSet.containsAll(previousPairSet)) {
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              for (IVColor key in ivButtonsMap.keys) {
                ivButtonsMap[key] = secondPartIVColorSet.difference(partlyIVColorSet).contains(key);
              }
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = secondPartIVColorSet.difference(partlyIVColorSet).contains(key) && previousPairSet.contains(key);
            }
          }
        } else {
          print('4 $partlyIVColorSet');
          if (firstGenModel.hasIVValue(pairedGenIndex)) {
            if (previousPairSet.containsAll(pairedMonsterIVList)) {
              for (IVColor key in ivButtonsMap.keys) {
                ivButtonsMap[key] = partlyIVColorSet.contains(key) && !pairedMonsterIVList.contains(key);
              }
            } else {
              return isInPreviousPair(previousPairSet, ivButtonsMap);
            }
          } else {
            for (IVColor key in ivButtonsMap.keys) {
              ivButtonsMap[key] = partlyIVColorSet.contains(key) || previousPairSet.contains(key);
            }
          }
        }
      }
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> generateIVButtonMap() {
    Map<IVColor, bool> ivButtonsMap = <IVColor, bool>{
      for (IVColor ivColor in IVColor.values.where((IVColor ivColor) => ivColor != IVColor.defaultColor)) ivColor: true
    };
    return ivButtonsMap;
  }

  Map<IVColor, bool> isNotPairedMonsterIV(List<IVColor> pairedMonsterIVList, Map<IVColor, bool> ivButtonsMap) {
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = !pairedMonsterIVList.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> isInFirstGenSet(Set<IVColor> firstGenSet, Map<IVColor, bool> ivButtonsMap) {
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = firstGenSet.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> isInFirstGenSetAndNotInInPreviousPair(Set<IVColor> firstGenSet, Set<IVColor> previousPairSet, Map<IVColor, bool> ivButtonsMap) {
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = firstGenSet.contains(key) && !previousPairSet.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> isNotInFirstGenSet(Set<IVColor> firstGenSet, Map<IVColor, bool> ivButtonsMap) {
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = !firstGenSet.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> isInPreviousPair(Set<IVColor> previousPairSet, Map<IVColor, bool> ivButtonsMap) {
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = previousPairSet.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> isInPreviousPairOrNotFirstGen(Set<IVColor> firstGenSet, Set<IVColor> previousPairSet, Map<IVColor, bool> ivButtonsMap) {
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = previousPairSet.contains(key) || !firstGenSet.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> isKeyInFirstGenOrPreviousPair(Set<IVColor> firstGenSet, Set<IVColor> previousPairSet, Map<IVColor, bool> ivButtonsMap) {
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = firstGenSet.contains(key) || previousPairSet.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> isInPartlyIVColorAndNotInPreviousPair(
      Set<IVColor> partlyIVColorSet, Set<IVColor> previousPairSet, Map<IVColor, bool> ivButtonsMap) {
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = partlyIVColorSet.contains(key) && !previousPairSet.contains(key);
    }
    return ivButtonsMap;
  }

  Map<IVColor, bool> isInPartlyIVColorOrPreviousPair(Set<IVColor> partlyIVColorSet, Set<IVColor> previousPairSet, Map<IVColor, bool> ivButtonsMap) {
    for (IVColor key in ivButtonsMap.keys) {
      ivButtonsMap[key] = partlyIVColorSet.contains(key) || previousPairSet.contains(key);
    }
    return ivButtonsMap;
  }
}
