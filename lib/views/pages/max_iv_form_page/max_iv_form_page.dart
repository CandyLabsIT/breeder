import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/pages/max_iv_form_page/max_iv_text_forms_widget.dart';
import 'package:breeder/views/widgets/buttons/custom_text_button.dart';
import 'package:breeder/views/widgets/generic/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaxIVFormPage extends StatefulWidget {
  final MaxIVFormCubit _maxIVFormCubit = globalLocator<MaxIVFormCubit>();

  MaxIVFormPage({Key? key}) : super(key: key);

  @override
  State<MaxIVFormPage> createState() {
    return _MaxIVFormPageState();
  }
}

class _MaxIVFormPageState extends State<MaxIVFormPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaxIVFormCubit, AMaxIVFormState>(
        bloc: widget._maxIVFormCubit,
        builder: (BuildContext context, AMaxIVFormState maxIVFormState) {
          return CustomContainer(
            containerWidth: 350,
            containerHeight: 650,
            columnItems: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 25),
                child: const Text(
                  'Enter the quantity of monsters with maximum IVs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const MaxIVTextFormsWidget(),
              SizedBox(
                width: 300,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      CustomTextButton(
                        buttonText: 'Back',
                        icon: Icons.navigate_before,
                        leftMargin: 25,
                        onPressed: () => AutoRouter.of(context).push(const NewBreedingRoute()),
                      ),
                      CustomTextButton(
                        buttonText: 'Cancel',
                        icon: Icons.cancel,
                        leftMargin: 25,
                        onPressed: () => AutoRouter.of(context).push(const MainMenuRoute()),
                      ),
                      CustomTextButton(
                        buttonText: 'Next',
                        icon: Icons.navigate_next,
                        leftMargin: 25,
                        onPressed: () {
                          widget._maxIVFormCubit.getListAmount();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
