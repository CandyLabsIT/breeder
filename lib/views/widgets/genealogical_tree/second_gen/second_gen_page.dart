import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/second_gen/second_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/second_gen/second_gen_index.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/sliding_panel_widget.dart';
import 'package:breeder/views/widgets/genealogical_tree/second_gen/second_gen_sliding_panel/second_gen_sliding_panel.dart';
import 'package:breeder/views/widgets/genealogical_tree/second_gen/second_gen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@RoutePage()
class SecondGenPage extends StatefulWidget {
  const SecondGenPage({super.key});

  @override
  _SecondGenPageState createState() => _SecondGenPageState();
}

class _SecondGenPageState extends State<SecondGenPage> {
  final SecondGenCubit secondGenCubit = globalLocator<SecondGenCubit>();

  late PanelController _panelController;
  SecondGenIndex secondGenIndex = SecondGenIndex.one;
  bool _isPanelActionInProgress = false;

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  Future<void> _togglePanel(SecondGenIndex index) async {
    if (_isPanelActionInProgress) {
      return;
    }
    setState(() {
      _isPanelActionInProgress = true;
      secondGenIndex = index;
    });

    if (_panelController.isPanelOpen) {
      await _panelController.close();
    } else {
      await _panelController.open();
    }

    setState(() {
      _isPanelActionInProgress = false;
    });
  }

  void _onPopInvoked(bool didPop) {
    if (_panelController.isPanelOpen) {
      _panelController.close();
    } else if (_panelController.isPanelClosed) {
      AutoRouter.of(context).push(const NewBreedingRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SecondGenCubit>.value(
      value: secondGenCubit,
      child: BlocBuilder<SecondGenCubit, ASecondGenState>(
        bloc: secondGenCubit,
        builder: (BuildContext context, ASecondGenState state) {
          final Map<SecondGenIndex, List<IVColor>> colors = secondGenCubit.getColors();
          final Map<ThirdGenIndex, List<IVColor>> childrenMap = secondGenCubit.getChildren();
          return PopScope(
            canPop: false,
            onPopInvoked: _onPopInvoked,
            child: Scaffold(
              body: Scrollbar(
                thickness: 5,
                thumbVisibility: true,
                child: Stack(
                  children: <Widget>[
                    SecondGenWidget(colorsMap: colors, onTogglePanel: _togglePanel, childrenMap: childrenMap,),
                    SlidingPanelWidget(
                      controller: _panelController,
                      panel: SecondGenSlidingPanel(secondGenIndex: secondGenIndex),
                      onTap: () {},
                      bodyContent: Container(),
                    ),
                    Positioned(
                      bottom: 16,
                        right: 16,
                        child: FloatingActionButton(
                          onPressed: () => AutoRouter.of(context).push(const ThirdGenRoute()),
                          child: const Icon(Icons.navigate_next),
                        ),
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
}
