import 'package:auto_route/auto_route.dart';
import 'package:breeder/shared/cubit/input_cubit.dart';
import 'package:breeder/shared/models/monsters_model.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/buttons/custom_text_button.dart';
import 'package:breeder/views/widgets/generic/custom_container.dart';
import 'package:breeder/views/widgets/generic/custom_text_forms_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MonstersNumberPage extends StatefulWidget {
  const MonstersNumberPage({Key? key}) : super(key: key);

  @override
  _MonstersNumberState createState() => _MonstersNumberState();
}

class _MonstersNumberState extends State<MonstersNumberPage> {
  late MonstersModel _monstersModel;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _monstersModel = MonstersModel(
      monstersNumber: <TextEditingController>[
        _controller1,
        _controller2,
        _controller3,
        _controller4,
        _controller5,
      ],
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InputCubit>(
      create: (_) => InputCubit(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: CustomContainer(
              containerWidth: 350,
              containerHeight: 650,
              columnItems: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 25),
                  child: const Text(
                    'Input the number of monsters with max IVs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                CustomTextFormsWidget(model: _monstersModel),
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
                          onPressed:  () {
                            List<int> monstersCount = _monstersModel.getListValues();
                            if (monstersCount.isNotEmpty && monstersCount[0] != 0) {
                              // AutoRouter.of(context).push(OneIvMonstersRoute(monstersModel: _monstersModel));
                            }
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
