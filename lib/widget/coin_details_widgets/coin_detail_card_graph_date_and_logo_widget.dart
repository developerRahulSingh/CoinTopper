import 'package:cointopper/widget/graph_widget.dart';
import 'package:flutter/material.dart';

class CoinDetailCardGraphDateAndLogoWidget extends StatelessWidget {
  const CoinDetailCardGraphDateAndLogoWidget({
    Key key,
    @required this.marketId,
    @required this.formattedDate,
  }) : super(key: key);

  final int marketId;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                color: Colors.transparent,
                padding: EdgeInsets.all(4.0),
                child: GraphWidget(
                  marketId: marketId,
                  color1: '#FFFAFA',
                  color2: '#F5F5F5',
                  leftSizeShowTitles: false,
                  bottomSideShowTitles: false,
                ),
              ),
              Text(
                "$formattedDate ISD",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.white60,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Image(
                width: MediaQuery.of(context).size.width * 0.2,
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
