import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final double _containerHeight;
  final double _containerWidth;
  final List<Widget> _columnItems;

  const CustomContainer({
    required double containerHeight,
    required double containerWidth,
    required List<Widget> columnItems,
    Key? key,
  })  : _containerWidth = containerWidth,
        _containerHeight = containerHeight,
        _columnItems = columnItems,
        super(key: key);

  @override
  State<CustomContainer> createState() {
    return _CustomContainerState();
  }
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFfed291),
                ),
                color: const Color(0xFFfed291),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 8),
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    color: Color(0xFFfed291),
                    offset: Offset(-4, 0),
                  ),
                ],
              ),
              width: widget._containerWidth,
              height: widget._containerHeight,
              child: Column(
                children: widget._columnItems,
              ),
            )
          ],
        ),
      ),
    );
  }
}
