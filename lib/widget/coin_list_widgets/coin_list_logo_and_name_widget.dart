import 'package:flutter/material.dart';

class CoinListLogoAndNameWidget extends StatelessWidget {
  final String logo;
  final String name;
  final String symbol;
  final String marketCapUSD;

  CoinListLogoAndNameWidget({
    Key key,
    this.logo,
    this.name,
    this.symbol,
    this.marketCapUSD,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Image(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
                image: NetworkImage(logo),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "$symbol / $marketCapUSD",
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
