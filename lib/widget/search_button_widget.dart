import 'dart:ui';

import 'package:flutter/material.dart';

class SearchButtonWidget extends StatelessWidget {
  const SearchButtonWidget({
    Key key,
    @required this.onPress,
    this.color,
    this.width,
    this.alignment,
  }) : super(key: key);

  final double width;
  final Color color;
  final AlignmentGeometry alignment;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: alignment,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: FlatButton(
        onPressed: onPress,
        child: Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
      ),
    );
  }
}
