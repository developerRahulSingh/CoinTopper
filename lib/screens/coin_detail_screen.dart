import 'package:cointopper/bloc/coin_detail_bloc/coin_detail_bloc.dart';
import 'package:cointopper/bloc/coin_detail_bloc/coin_detail_event.dart';
import 'package:cointopper/bloc/coin_detail_bloc/coin_detail_state.dart';
import 'package:cointopper/widget/close_button.dart';
import 'package:cointopper/widget/coin_detail_card_component_widget.dart';
import 'package:cointopper/widget/coin_detail_card_screenshot_widget.dart';
import 'package:cointopper/widget/coin_details_widgets/coin_detail_logo_and_name_widget.dart';
import 'package:cointopper/widget/coin_details_widgets/coin_detail_pricebtc_widget.dart';
import 'package:cointopper/widget/coin_details_widgets/coin_price_and%20_change_widget.dart';
import 'package:cointopper/widget/custom_safearea_widget.dart';
import 'package:cointopper/widget/icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class CoinDetail extends StatefulWidget {
  final String symbol;
  final String currencyCode;
  final dynamic currencySymbol;

  CoinDetail(
    this.symbol,
    this.currencyCode,
    this.currencySymbol,
  );

  @override
  _CoinDetailState createState() => _CoinDetailState();
}

class _CoinDetailState extends State<CoinDetail> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CoinDetailBloc>(context)
        .add(LoadCoinDetail(widget.symbol, widget.currencyCode));
    return BlocBuilder<CoinDetailBloc, CoinDetailState>(
        builder: (context, state) {
      if (state is CoinDetailLoadSuccess) {
        var data = state.coinDetail[0];
        return CustomSafeAreaWidget(
          color1: HexColor(data.color1),
          color2: HexColor(data.color2),
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        HexColor(data.color1),
                        HexColor(data.color2),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CoinDetailLogoAndNameWidget(
                            logo: data.logo,
                            name: data.name,
                            symbol: data.symbol,
                          ),
                          CloseButtonWidget(
                            context: context,
                          ),
                        ],
                      ),
                      CoinPriceAndChangeWidget(
                        price: data.price > 99999
                            ? NumberFormat.compactCurrency(
                                decimalDigits: 2,
                                symbol: '${widget.currencySymbol}',
                              ).format(data.price)
                            : '${widget.currencySymbol}' +
                                data.price.toStringAsFixed(2),
                        change: data.percentChange24h,
                        priceFontSize: MediaQuery.of(context).size.width * 0.08,
                        changeFontSize:
                            MediaQuery.of(context).size.width * 0.03,
                      ),
                      CoinDetailPricebtcWidget(
                        priceBTC: data.priceBTC.toStringAsFixed(8),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                CoinPriceAndChangeWidget(
                                  price: data.high24USD > 99999
                                      ? NumberFormat.compactCurrency(
                                          decimalDigits: 2,
                                          symbol: '${widget.currencySymbol}',
                                        ).format(data.high24USD)
                                      : '${widget.currencySymbol}' +
                                          data.high24USD.toStringAsFixed(2),
                                  priceFontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  title: "24 HRS HIGH",
                                  titleFontSize:
                                      MediaQuery.of(context).size.width * 0.025,
                                ),
                                CoinPriceAndChangeWidget(
                                  price: data.low24USD > 99999
                                      ? NumberFormat.compactCurrency(
                                          decimalDigits: 2,
                                          symbol: '${widget.currencySymbol}',
                                        ).format(data.low24USD)
                                      : '${widget.currencySymbol}' +
                                          data.low24USD.toStringAsFixed(2),
                                  priceFontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  title: "24 HRS LOW",
                                  titleFontSize:
                                      MediaQuery.of(context).size.width * 0.025,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButtonWidget(
                                  iconBackgroundColor: Colors.white24,
                                  iconColor: Colors.white,
                                  iconName: Icons.alarm,
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                IconButtonWidget(
                                  iconBackgroundColor: Colors.white24,
                                  iconColor: Colors.white,
                                  iconName: Icons.star_border,
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                IconButtonWidget(
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                  iconBackgroundColor: Colors.white24,
                                  iconColor: Colors.white,
                                  iconName: Icons.pages,
                                  onPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: CoinDetailCardWidget(
                                              data, widget.currencySymbol),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CoinDetailCardComponentWidget(
                    data.volume24hUSD,
                    data.availableSupply,
                    data.marketCapUSD,
                    data.intro,
                    data.youtube,
                    data.website,
                    data.explorer,
                    data.facebook,
                    data.blog,
                    data.forum,
                    data.github,
                    data.raddit,
                    data.slack,
                    data.paper,
                    data.guides,
                    data.marketId,
                    data.color1,
                    data.color2,
                    widget.currencySymbol,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
