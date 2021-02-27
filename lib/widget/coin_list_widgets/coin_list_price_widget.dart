import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CoinListPriceWidget extends StatelessWidget {
  final dynamic priceBTC;
  final dynamic price;

  CoinListPriceWidget({
    Key key,
    @required this.price,
    @required this.priceBTC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            price,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.03,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.btc,
                color: Colors.grey[500],
                size: MediaQuery.of(context).size.width * 0.03,
              ),
              Text(
                "${priceBTC.toStringAsFixed(8)}",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
