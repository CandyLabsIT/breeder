import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_first_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/first_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/first_gen/first_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/pages/second_gen_page/widgets/first_gen_widget.dart';
import 'package:breeder/views/pages/second_gen_page/widgets/second_gen_sliding_panel.dart';
import 'package:breeder/views/widgets/genealogical_tree/sliding_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@RoutePage()
class FirstGenPage extends StatefulWidget {
  const FirstGenPage({super.key});

  @override
  _FirstGenPageState createState() => _FirstGenPageState();
}

class _FirstGenPageState extends State<FirstGenPage> {
  final FirstGenCubit firstGenCubit = globalLocator<FirstGenCubit>();

  late PanelController _panelController;
  FirstGenIndex firstGenIndex = FirstGenIndex.one;
  bool isEnabled = true;

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirstGenCubit>.value(
      value: firstGenCubit,
      child: BlocBuilder<FirstGenCubit, ASecondGenState>(
        bloc: firstGenCubit,
        builder: (BuildContext context, ASecondGenState state) {
          final Map<FirstGenIndex, List<IVColor>> colors = firstGenCubit.getColors();
          final Map<FirstGenIndex, bool> monsterButtonStateMap = firstGenCubit.getMonsterButtonState();
          return PopScope(
            canPop: false,
            onPopInvoked: _onPopInvoked,
            child: Scaffold(
              body: Scrollbar(
                thickness: 5,
                thumbVisibility: true,
                child: Stack(
                  children: <Widget>[
                    FirstGenWidget(colorsMap: colors, onTogglePanel: _togglePanel, monsterButtonsMap: monsterButtonStateMap,),
                    SlidingPanelWidget(
                      controller: _panelController,
                      panel: FirstGenSlidingPanel(firstGenIndex: firstGenIndex),
                      onTap: () {},
                      bodyContent: Container(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onPopInvoked(bool didPop) {
    if (_panelController.isPanelOpen) {
      _panelController.close();
    } else if (_panelController.isPanelClosed) {
      AutoRouter.of(context).push(const NewBreedingRoute());
    }
  }

  Future<void> _togglePanel(FirstGenIndex index) async {
    setState(() {
      firstGenIndex = index;
    });

    if (_panelController.isPanelOpen) {
      await _panelController.close();
    } else {
      await _panelController.open();
    }
  }
  
  bool _isEnabled(FirstGenIndex index) {
    setState(() {
      isEnabled = firstGenCubit.isMonsterPairEnabled(firstGenIndex);
    });
    return isEnabled;
  }
}
