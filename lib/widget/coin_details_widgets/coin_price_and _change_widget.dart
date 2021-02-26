import 'package:flutter/material.dart';

class CoinPriceAndChangeWidget extends StatelessWidget {
  final String price;
  final String title;
  final dynamic change;
  final double priceFontSize;
  final double changeFontSize;
  final double titleFontSize;

  const CoinPriceAndChangeWidget({
    Key key,
    this.price,
    this.title,
    this.change,
    this.priceFontSize,
    this.changeFontSize,
    this.titleFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            price,
            style: TextStyle(
                fontSize: priceFontSize,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          change != null
              ? Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      height: 12,
                      width: 12,
                      image: AssetImage(change > 0
                          ? "assets/images/up_arrow.png"
                          : "assets/images/down_arrow.png"),
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                )
              : SizedBox(
                  width: 5,
                ),
          Text(
            change != null ? '${change.toStringAsFixed(2)}' : title,
            style: TextStyle(
                fontSize: change != null ? changeFontSize : titleFontSize,
                color: Colors.white60,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
