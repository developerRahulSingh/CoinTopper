import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CoinListLogoChangeWidget extends StatelessWidget {
  final dynamic percentChange24h;

  CoinListLogoChangeWidget({
    Key key,
    @required this.percentChange24h,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            width: 15,
            height: 15,
            image: AssetImage(percentChange24h > 0
                ? "assets/images/up_arrow_green.png"
                : "assets/images/down_arrow_red.png"),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            '${percentChange24h.toStringAsFixed(2)}%',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontWeight: FontWeight.bold,
              color: percentChange24h > 0
                  ? Colors.green[600]
                  : HexColor("#a94442"),
            ),
          ),
        ],
      ),
    );
  }
}
