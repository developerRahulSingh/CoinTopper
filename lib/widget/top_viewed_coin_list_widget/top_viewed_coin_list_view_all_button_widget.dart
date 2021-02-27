import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TopViewedCoinListViewAllButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;

  const TopViewedCoinListViewAllButton({
    Key key,
    @required this.onPress,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: EdgeInsets.all(8.0),
          width: 180,
          decoration: BoxDecoration(
              border: Border.all(
                color: HexColor("#005580"),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: HexColor("#005580"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
