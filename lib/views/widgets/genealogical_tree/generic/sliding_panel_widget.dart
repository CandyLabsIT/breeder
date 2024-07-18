import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanelWidget extends StatelessWidget {
  final PanelController controller;
  final VoidCallback? onTap;
  final Widget panel;
  final Widget bodyContent;

  const SlidingPanelWidget({
    required this.controller,
    required this.onTap,
    required this.panel,
    required this.bodyContent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          SlidingUpPanel(
            controller: controller,
            color: const Color(0xffffbc77),
            panel: panel,
            body: bodyContent,
            collapsed: Container(),
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height * 0.5,
            backdropEnabled: true,
            backdropTapClosesPanel: false,
          ),
        ],
      ),
    );
  }
}
