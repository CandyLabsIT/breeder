import 'package:auto_route/auto_route.dart';
import 'package:breeder/blocks/pages/genealogical_tree/third_generation/a_third_gen_state.dart';
import 'package:breeder/blocks/pages/genealogical_tree/third_generation/third_gen_cubit.dart';
import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/models/genealogical_tree/iv_colors.dart';
import 'package:breeder/shared/models/genealogical_tree/third_generation/third_gen_index.dart';
import 'package:breeder/views/widgets/genealogical_tree/generic/sliding_panel_widget.dart';
import 'package:breeder/views/widgets/generic/third_generation/third_generation_pair_widget.dart';
import 'package:breeder/views/widgets/generic/third_generation/third_generation_sliding_panel/third_gen_sliding_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@RoutePage()
class ThirdGenPage extends StatefulWidget {
  const ThirdGenPage({super.key});

  @override
  _ThirdGenState createState() => _ThirdGenState();
}

class _ThirdGenState extends State<ThirdGenPage> {
  final ThirdGenCubit thirdGenCubit = globalLocator<ThirdGenCubit>();
  late PanelController _panelController;
  ThirdGenIndex thirdGenIndex = ThirdGenIndex.one;
  bool _isPanelActionInProgress = false;

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  Future<void> _togglePanel(ThirdGenIndex index) async {
    if (_isPanelActionInProgress) {
      return;
    }
    setState(() {
      _isPanelActionInProgress = true;
      thirdGenIndex = index;
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
      // AutoRouter.of(context).push();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThirdGenCubit>.value(
      value: thirdGenCubit,
      child: BlocBuilder<ThirdGenCubit, AThirdGenState>(
        bloc: thirdGenCubit,
        builder: (BuildContext context, AThirdGenState state) {
          final Map<ThirdGenIndex, List<IVColor>> colors = thirdGenCubit.getColors();
          return PopScope(
            canPop: false,
            onPopInvoked: _onPopInvoked,
            child: Scaffold(
              body: Scrollbar(
                thickness: 5,
                thumbVisibility: true,
                child: Stack(
                  children: <Widget>[
                    ThirdGenPairWidget(colorsMap: colors, onTogglePanel: _togglePanel),
                    SlidingPanelWidget(
                      controller: _panelController,
                      onTap: () {},
                      panel: ThirdGeSlidingPanel(
                        thirdGenIndex: thirdGenIndex,
                      ),
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
}
