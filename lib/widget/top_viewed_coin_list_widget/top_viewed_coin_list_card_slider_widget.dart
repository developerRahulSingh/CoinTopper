import 'package:cointopper/screens/coin_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TopViewedCoinListCardSliderWidget extends StatelessWidget {
  final String symbol;
  final String name;
  final dynamic price;
  final dynamic percentChange24h;
  final String logo;
  final String color1;
  final String color2;
  final String currencyCode;
  final dynamic currencySymbol;

  TopViewedCoinListCardSliderWidget({
    Key key,
    @required this.symbol,
    @required this.name,
    @required this.price,
    @required this.percentChange24h,
    @required this.logo,
    @required this.color1,
    @required this.color2,
    @required this.currencyCode,
    @required this.currencySymbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _formattedPrice = NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '$currencySymbol',
    ).format(price);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CoinDetail(symbol, currencyCode, currencySymbol)));
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: EdgeInsets.all(8.0),
          width: 180,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [HexColor("$color1"), HexColor("$color2")],
              ),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "${price > 99999 ? _formattedPrice : '$currencySymbol' + price.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Image(
                        width: 12,
                        height: 12,
                        image: AssetImage("assets/images/up_arrow.png"),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "\$${double.parse((percentChange24h).toStringAsFixed(4))}%",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
