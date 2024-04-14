import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/views/pages/single_iv_form_page/single_iv_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleIVTextFormsWidget extends StatelessWidget {
  final MaxIVFormCubit maxIVFormCubit = globalLocator<MaxIVFormCubit>();

  SingleIVTextFormsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaxIVFormCubit, AMaxIVFormState>(
        bloc: maxIVFormCubit,
        builder: (BuildContext context, AMaxIVFormState maxIVFormState) {
          return SizedBox(
            width: 200,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 40),
                  child: SingleIVTextFormWidget(
                    indexTextEditingControllerList: 0,
                    ivTextInfo: 'HP',
                    maxLength: getLength(),
                    maxSlots: maxIVFormCubit.maxIVFormModel.getAmountList()[0],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 40),
                  child: SingleIVTextFormWidget(
                    indexTextEditingControllerList: 1,
                    ivTextInfo: 'Atk',
                    maxLength: getLength(),
                    maxSlots: maxIVFormCubit.maxIVFormModel.getAmountList()[0],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: SingleIVTextFormWidget(
                    indexTextEditingControllerList: 2,
                    ivTextInfo: 'Def',
                    maxLength: getLength(),
                    maxSlots: maxIVFormCubit.maxIVFormModel.getAmountList()[0],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: SingleIVTextFormWidget(
                    indexTextEditingControllerList: 3,
                    ivTextInfo: 'Speed',
                    maxLength: getLength(),
                    maxSlots: maxIVFormCubit.maxIVFormModel.getAmountList()[0],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: SingleIVTextFormWidget(
                    indexTextEditingControllerList: 4,
                    ivTextInfo: 'Sp.Atk',
                    maxLength: getLength(),
                    maxSlots: maxIVFormCubit.maxIVFormModel.getAmountList()[0],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: SingleIVTextFormWidget(
                    indexTextEditingControllerList: 5,
                    ivTextInfo: 'Sp.Def',
                    maxLength: getLength(),
                    maxSlots: maxIVFormCubit.maxIVFormModel.getAmountList()[0],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  int getLength() {
    List<int> valuesList = maxIVFormCubit.maxIVFormModel.getAmountList();
    String value = valuesList[0].toString();
    return value.length;
  }
}
