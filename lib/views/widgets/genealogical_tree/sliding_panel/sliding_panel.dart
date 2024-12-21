import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanel extends StatelessWidget {
  final PanelController _controller;
  final VoidCallback? _onTap;
  final Widget _panel;
  final Widget _bodyContent;

  const SlidingPanel({
    required PanelController controller,
    required void Function()? onTap,
    required Widget panel,
    required Widget bodyContent,
    Key? key,
  })  : _controller = controller,
        _onTap = onTap,
        _panel = panel,
        _bodyContent = bodyContent,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Stack(
        children: <Widget>[
          SlidingUpPanel(
            controller: _controller,
            color: const Color(0xffddc0ab),
            panel: _panel,
            body: _bodyContent,
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
