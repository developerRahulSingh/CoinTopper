import 'package:cointopper/entities/guides_entity.dart';
import 'package:cointopper/widget/coin_details_widgets/build_total_cap_widget.dart';
import 'package:cointopper/widget/coin_details_widgets/coin_detail_card_container_style_widget.dart';
import 'package:cointopper/widget/coin_details_widgets/coin_detail_intro_widget.dart';
import 'package:cointopper/widget/coin_details_widgets/important_articles_widget.dart';
import 'package:cointopper/widget/graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'coin_details_widgets/coin_important_links.dart';

class CoinDetailCardComponentWidget extends StatefulWidget {
  final double volume;
  final dynamic availableSupply;
  final dynamic marketCapUSD;
  final String intro;
  final String youtube;
  final String website;
  final String explorer;
  final String facebook;
  final String blog;
  final String forum;
  final String github;
  final String raddit;
  final String slack;
  final String paper;
  final List<GuidesEntity> guides;
  final int marketId;
  final String color1;
  final String color2;
  final String currencySymbol;

  CoinDetailCardComponentWidget(
    this.volume,
    this.availableSupply,
    this.marketCapUSD,
    this.intro,
    this.youtube,
    this.website,
    this.explorer,
    this.facebook,
    this.blog,
    this.forum,
    this.github,
    this.raddit,
    this.slack,
    this.paper,
    this.guides,
    this.marketId,
    this.color1,
    this.color2,
    this.currencySymbol,
  );

  @override
  _CoinDetailCardComponentWidgetState createState() =>
      _CoinDetailCardComponentWidgetState();
}

class _CoinDetailCardComponentWidgetState
    extends State<CoinDetailCardComponentWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: GraphWidget(
              marketId: widget.marketId,
              color1: widget.color1,
              color2: widget.color2,
              leftSizeShowTitles: true,
              bottomSideShowTitles: true,
            ),
          ),
          CoinDetailCardContainerStyleWidget(
            child: Column(
              children: [
                BuildTotalCapWidget(
                  name: "Total Coins",
                  value: NumberFormat.compactCurrency(
                    decimalDigits: 2,
                    symbol: '${widget.currencySymbol}',
                  ).format(widget.volume),
                ),
                Divider(
                  color: Colors.blue[800],
                  thickness: 2,
                ),
                BuildTotalCapWidget(
                  name: "Total Coins",
                  value: NumberFormat.compactCurrency(
                    decimalDigits: 2,
                    symbol: '${widget.currencySymbol}',
                  ).format(widget.availableSupply),
                ),
                Divider(
                  color: Colors.blue[800],
                  thickness: 2,
                ),
                BuildTotalCapWidget(
                  name: "Market Cap",
                  value: NumberFormat.compactCurrency(
                    decimalDigits: 2,
                    symbol: '${widget.currencySymbol}',
                  ).format(widget.marketCapUSD),
                ),
              ],
            ),
          ),
          CoinDetailIntroWidget(
            heading: "About",
            intro: widget.intro,
            youtube: widget.youtube,
          ),
          CoinDetailCardContainerStyleWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    "Important Links",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      color: Colors.black54,
                    ),
                  ),
                ),
                CoinImportantLinks(
                  widget.youtube,
                  widget.website,
                  widget.explorer,
                  widget.facebook,
                  widget.blog,
                  widget.forum,
                  widget.github,
                  widget.raddit,
                  widget.slack,
                  widget.paper,
                ),
              ],
            ),
          ),
          ImportantArticlesWidget(guides: widget.guides),
        ],
      ),
    );
  }
}
