import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/max_iv_form_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/pages/single_iv_form_page/single_iv_forms_widget.dart';
import 'package:breeder/views/widgets/buttons/custom_text_button.dart';
import 'package:breeder/views/widgets/generic/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleIVFormPage extends StatefulWidget {
  final MaxIVFormCubit _maxIVFormCubit = globalLocator<MaxIVFormCubit>();

  SingleIVFormPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleIVFormState();
}

class _SingleIVFormState extends State<SingleIVFormPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaxIVFormCubit, AMaxIVFormState>(
      bloc: widget._maxIVFormCubit,
      builder: (BuildContext context, AMaxIVFormState maxIVFormState) {
        return CustomContainer(
          containerHeight: 850,
          containerWidth: 350,
          columnItems: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
              child: const Text(
                'Input the number of monsters with one max IV',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SingleIVTextFormsWidget(),
            SizedBox(
              width: 300,
              child: Center(
                child: Row(
                  children: <Widget>[
                    CustomTextButton(
                      buttonText: 'Back',
                      icon: Icons.navigate_before,
                      leftMargin: 25,
                      onPressed: () {
                        widget._maxIVFormCubit.calculateSum();
                      },
                    ),
                    CustomTextButton(
                      buttonText: 'Cancel',
                      icon: Icons.cancel,
                      leftMargin: 25,
                      onPressed: () => AutoRouter.of(context).push(const MainMenuRoute()),
                    ),
                    const CustomTextButton(
                      buttonText: 'Next',
                      icon: Icons.navigate_next,
                      leftMargin: 25,
                      // onPressed: (){
                      //   widget._maxIVFormCubit.calculateSum();
                      // },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
