import 'package:flutter/material.dart';

class CoinDetailLogoAndNameWidget extends StatelessWidget {
  final String logo;
  final String name;
  final String symbol;

  CoinDetailLogoAndNameWidget({
    Key key,
    @required this.logo,
    @required this.name,
    @required this.symbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white30,
          ),
          child: Image(
            width: 32,
            height: 32,
            image: NetworkImage(logo),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          '$name/ $symbol',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}
