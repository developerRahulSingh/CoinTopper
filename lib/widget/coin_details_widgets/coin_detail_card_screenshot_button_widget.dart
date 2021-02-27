import 'package:flutter/material.dart';

class CoinDetailCardScreenShotButtonWidget extends StatelessWidget {
  final IconData iconName;
  final VoidCallback onPress;

  const CoinDetailCardScreenShotButtonWidget({
    Key key,
    this.iconName,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white30,
          ),
          child: Icon(
            iconName,
            color: Colors.white,
          )),
      onPressed: onPress,
    );
  }
}
