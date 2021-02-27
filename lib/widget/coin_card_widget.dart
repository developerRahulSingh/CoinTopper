import 'package:cointopper/bloc/top_view_coin_list_bloc/top_viewed_coin_list_bloc.dart';
import 'package:cointopper/bloc/top_view_coin_list_bloc/top_viewed_coin_list_event.dart';
import 'package:cointopper/bloc/top_view_coin_list_bloc/top_viewed_coin_list_state.dart';
import 'package:cointopper/screens/top_viewed_coin_view_all_screen.dart';
import 'package:cointopper/widget/top_viewed_coin_list_widget/top_viewed_coin_list_card_slider_widget.dart';
import 'package:cointopper/widget/top_viewed_coin_list_widget/top_viewed_coin_list_view_all_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class CoinCardWidget extends StatefulWidget {
  final String currencyCode;
  final String currencySymbol;

  CoinCardWidget(
    this.currencyCode,
    this.currencySymbol,
  );

  @override
  _CoinCardWidgetState createState() => _CoinCardWidgetState();
}

class _CoinCardWidgetState extends State<CoinCardWidget> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TopViewedCoinListBloc>(context)
        .add(LoadTopViewedCoinList(widget.currencyCode));
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          width: MediaQuery.of(context).size.width * 1,
          child: Text(
            "Top Viewed",
            style: TextStyle(
                color: HexColor("#005580"),
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w600),
          ),
        ),
        BlocBuilder<TopViewedCoinListBloc, TopViewedCoinListState>(
          builder: (context, state) {
            if (state is TopViewedCoinListLoadSuccess) {
              return Container(
                height: 110.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.topViewedCoinsList.length - 4,
                  itemBuilder: (context, index) {
                    return index == 5
                        ? TopViewedCoinListViewAllButton(
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => TopViewedCoinViewAllScreen(
                                      widget.currencyCode,
                                      widget.currencySymbol)));
                            },
                            title: 'View All',
                          )
                        : TopViewedCoinListCardSliderWidget(
                            symbol: state.topViewedCoinsList[index].symbol,
                            name: state.topViewedCoinsList[index].name,
                            price: state.topViewedCoinsList[index].price,
                            percentChange24h: state
                                .topViewedCoinsList[index].percentChange24h,
                            logo: state.topViewedCoinsList[index].logo,
                            color1: state.topViewedCoinsList[index].color1,
                            color2: state.topViewedCoinsList[index].color2,
                            currencyCode: widget.currencyCode,
                            currencySymbol: widget.currencySymbol,
                          );
                  },
                ),
              );
            }
            return Container(
              height: 110.0,
              alignment: AlignmentDirectional.topStart,
              child: TopViewedCoinListViewAllButton(
                onPress: () {},
                title: 'View All',
              ),
            );
          },
        ),
      ],
    );
  }
}
