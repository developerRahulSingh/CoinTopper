import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CoinDetailPricebtcWidget extends StatelessWidget {
  final String priceBTC;

  const CoinDetailPricebtcWidget({
    Key key,
    @required this.priceBTC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.btc,
          color: Colors.white60,
          size: 14,
        ),
        Text(
          priceBTC,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
