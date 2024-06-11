import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/first_gen/first_gen_cubit.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/pages/genealogical_tree_page/first_gen_widgets/first_gen_sliding_panel.dart';
import 'package:breeder/views/pages/genealogical_tree_page/first_gen_widgets/first_gen_widget.dart';
import 'package:breeder/views/pages/genealogical_tree_page/second_gen_widgets/second_gen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@RoutePage()
class GenealogicalTreePage extends StatefulWidget {
  const GenealogicalTreePage({super.key});

  @override
  _GenealogicalTreePageState createState() => _GenealogicalTreePageState();
}

class _GenealogicalTreePageState extends State<GenealogicalTreePage> {
  final FirstGenCubit _firstGenCubit = globalLocator<FirstGenCubit>();
  final SecondGenCubit _secondGenCubit = globalLocator<SecondGenCubit>();

  late PanelController _panelController;
  late VoidCallback _setIVButtonMethod;
  FirstGenIndex _firstGenIndex = FirstGenIndex.one;

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
    _setIVButtonMethod = _firstGenCubit.setIVStateIndexOne;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<FirstGenCubit>.value(value: _firstGenCubit),
        BlocProvider<SecondGenCubit>.value(value: _secondGenCubit),
      ],
      child: PopScope(
        canPop: false,
        onPopInvoked: _onPopInvoked,
        child: Scaffold(
          body: SlidingUpPanel(
            controller: _panelController,
            panel: FirstGenSlidingPanel(
              firstGenIndex: _firstGenIndex,
              setIVButtonMethod: _setIVButtonMethod,
            ),
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height * 0.5,
            body: Scrollbar(
              thickness: 5,
              thumbVisibility: true,
              child: ListView(
                children: <Widget>[
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: SingleChildScrollView(
                          child: BlocBuilder<FirstGenCubit, AFirstGenState>(
                            builder: (BuildContext context, AFirstGenState firstGenState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  FirstGenWidget(onTogglePanel: _togglePanel),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        child: SingleChildScrollView(
                          child: BlocBuilder<SecondGenCubit, ASecondGenState>(
                            builder: (BuildContext context, ASecondGenState secondGenState) {
                              return const Column(
                                children: <Widget>[
                                  SecondGenWidget(),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPopInvoked(bool didPop) {
    if (_panelController.isPanelOpen) {
      _panelController.close();
    } else {
      AutoRouter.of(context).push(const MaxIVFormRoute());
    }
  }

  Future<void> _togglePanel(FirstGenIndex currentFirstGenIndex, VoidCallback setIVButtonMethod) async {
    setState(() {
      _firstGenIndex = currentFirstGenIndex;
      _setIVButtonMethod = setIVButtonMethod;
    });

    if (_panelController.isPanelOpen) {
      await _panelController.close();
    } else {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await _panelController.open();
    }
  }
}
