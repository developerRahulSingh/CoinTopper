import 'package:flutter/material.dart';

class CoinDetailCardContainerStyleWidget extends StatelessWidget {
  final Widget child;

  CoinDetailCardContainerStyleWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: child
        ),
      ),
    );
  }
}
