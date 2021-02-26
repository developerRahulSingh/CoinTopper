import 'package:cointopper/bloc/top_view_coin_list_bloc/top_viewed_coin_list_bloc.dart';
import 'package:cointopper/bloc/top_view_coin_list_bloc/top_viewed_coin_list_event.dart';
import 'package:cointopper/bloc/top_view_coin_list_bloc/top_viewed_coin_list_state.dart';
import 'package:cointopper/screens/coin_detail_screen.dart';
import 'package:cointopper/widget/close_button.dart';
import 'package:cointopper/widget/coin_list_widgets/coin_list_logo_and_name_widget.dart';
import 'package:cointopper/widget/coin_list_widgets/coin_list_logo_change_widget.dart';
import 'package:cointopper/widget/coin_list_widgets/coin_list_price_widget.dart';
import 'package:cointopper/widget/coin_list_widgets/list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TopViewedCoinViewAllScreen extends StatefulWidget {
  final String currencyCode;
  final dynamic currencySymbol;

  TopViewedCoinViewAllScreen(
    this.currencyCode,
    this.currencySymbol,
  );

  @override
  _TopViewedCoinViewAllScreenState createState() =>
      _TopViewedCoinViewAllScreenState();
}

class _TopViewedCoinViewAllScreenState
    extends State<TopViewedCoinViewAllScreen> {
  bool isSort = true;
  bool isSortChange = true;
  bool isSortPrice = true;
  var _sortColumnIndex;
  var loadData = 20;

  void initState() {
    super.initState();
    BlocProvider.of<TopViewedCoinListBloc>(context)
        .add(LoadTopViewedCoinList(widget.currencyCode));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFE70814), Color(0xFFDE4546)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.17,
                padding: EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFE70814), Color(0xFFDE4546)],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to Cointopper",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.white,
                          ),
                        ),
                        CloseButtonWidget(
                          context: context,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Top Viewed Coins",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.08,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: BlocBuilder<TopViewedCoinListBloc,
                        TopViewedCoinListState>(
                      builder: (context, state) {
                        if (state is TopViewedCoinListLoadSuccess) {
                          return DataTable(
                            columnSpacing: 8.0,
                            horizontalMargin: 4.0,
                            showBottomBorder: true,
                            dataRowHeight:
                                MediaQuery.of(context).size.height * 0.08,
                            headingRowHeight:
                                MediaQuery.of(context).size.height * 0.05,
                            sortColumnIndex: _sortColumnIndex,
                            sortAscending: isSort,
                            columns: [
                              DataColumn(
                                label: ListHeaderWidget(
                                  headerName: 'NAME/ M.CAP',
                                  isSort: isSort,
                                ),
                                onSort: (i, b) {
                                  setState(() {
                                    if (i == 0) {
                                      _sortColumnIndex = i;
                                      if (isSort) {
                                        state.topViewedCoinsList.sort(
                                            (a, b) => b.name.compareTo(a.name));
                                        isSort = false;
                                      } else {
                                        state.topViewedCoinsList.sort(
                                            (a, b) => a.name.compareTo(b.name));
                                        isSort = true;
                                      }
                                    }
                                  });
                                },
                              ),
                              DataColumn(
                                label: ListHeaderWidget(
                                  headerName: 'CHANGE',
                                  isSort: isSortChange,
                                ),
                                onSort: (i, b) {
                                  setState(() {
                                    if (i == 1) {
                                      _sortColumnIndex = i;
                                      if (isSortChange) {
                                        state.topViewedCoinsList.sort((a, b) =>
                                            b.percentChange24h
                                                .compareTo(a.percentChange24h));
                                        isSortChange = false;
                                      } else {
                                        state.topViewedCoinsList.sort((a, b) =>
                                            a.percentChange24h
                                                .compareTo(b.percentChange24h));
                                        isSortChange = true;
                                      }
                                    }
                                  });
                                },
                              ),
                              DataColumn(
                                label: ListHeaderWidget(
                                  headerName: 'PRICE',
                                  isSort: isSortPrice,
                                ),
                                onSort: (i, b) {
                                  setState(() {
                                    if (i == 2) {
                                      _sortColumnIndex = i;
                                      if (isSortPrice) {
                                        state.topViewedCoinsList.sort((a, b) =>
                                            b.price.compareTo(a.price));
                                        isSortPrice = false;
                                      } else {
                                        state.topViewedCoinsList.sort((a, b) =>
                                            a.price.compareTo(b.price));
                                        isSortPrice = true;
                                      }
                                    }
                                  });
                                },
                              ),
                            ],
                            rows: state.topViewedCoinsList.length != 0
                                ? state.topViewedCoinsList
                                    .map(
                                      (coin) => DataRow(
                                        cells: [
                                          DataCell(
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            CoinDetail(
                                                              coin.symbol,
                                                              widget
                                                                  .currencyCode,
                                                              widget
                                                                  .currencySymbol,
                                                            )));
                                              },
                                              child: CoinListLogoAndNameWidget(
                                                logo: coin.logo,
                                                name: coin.name,
                                                symbol: coin.symbol,
                                                marketCapUSD:
                                                    "${coin.symbol} / ${NumberFormat.compactCurrency(
                                                  decimalDigits: 2,
                                                  symbol:
                                                      '${widget.currencySymbol}',
                                                ).format(coin.marketCapUSD)}",
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            CoinListLogoChangeWidget(
                                              percentChange24h:
                                                  coin.percentChange24h,
                                            ),
                                          ),
                                          DataCell(
                                            CoinListPriceWidget(
                                              price: '${coin.price > 99999 ? NumberFormat.compactCurrency(
                                                  decimalDigits: 2,
                                                  symbol:
                                                      '${widget.currencySymbol}',
                                                ).format(coin.price) : '${widget.currencySymbol}' + coin.price.toStringAsFixed(2)}',
                                              priceBTC: coin.priceBTC,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList()
                                : "Not an arry",
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
