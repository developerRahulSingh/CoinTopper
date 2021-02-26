import 'dart:convert';

import 'package:cointopper/entities/coin_list_entity.dart';
import 'package:cointopper/models/coin_list_response_model.dart';
import 'package:cointopper/screens/coin_detail_screen.dart';
import 'package:cointopper/widget/coin_list_widgets/coin_list_logo_and_name_widget.dart';
import 'package:cointopper/widget/coin_list_widgets/coin_list_logo_change_widget.dart';
import 'package:cointopper/widget/coin_list_widgets/list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import 'coin_list_widgets/coin_list_price_widget.dart';

Stream<List<CoinListResponseModel>> fetchCoinList(
    String currencyCode, int offset, int limit) async* {
  final response = await http.get(
      Uri.encodeFull(
          '${"https://api.cointopper.com/api/v3/" + "ticker?offset=$offset&limit=$limit&currency=$currencyCode"}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> results = map["data"];
  yield results
      .map((dynamic item) => CoinListResponseModel.fromEntity(
          CoinListEntity.fromJson(item as Map<String, dynamic>)))
      .toList();
}

class CoinListWidget extends StatefulWidget {
  final String currencyCode;
  final dynamic currencySymbol;

  CoinListWidget(
    this.currencyCode,
    this.currencySymbol,
  );

  @override
  _CoinListWidgetState createState() => _CoinListWidgetState();
}

class _CoinListWidgetState extends State<CoinListWidget> {
  bool isSort = true;
  bool isSortChange = true;
  bool isSortPrice = true;
  String code = 'USD';

  int page = -10;
  ScrollController controller;

  static const _pageSize = 20;

  final PagingController<int, CoinListResponseModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, widget.currencyCode);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey, String code) async {
    try {
      final newItems = await fetchCoinList(code, pageKey, _pageSize).single;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  dynamic refreshControl() {
    if (widget.currencyCode != code) {
      code = widget.currencyCode;
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    refreshControl();
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          primary: false,
          backgroundColor: Colors.white,
          elevation: 3,
          toolbarHeight: 40,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSort) {
                        _pagingController.itemList
                            .sort((a, b) => b.name.compareTo(a.name));
                        isSort = false;
                      } else {
                        _pagingController.itemList
                            .sort((a, b) => a.name.compareTo(b.name));
                        isSort = true;
                      }
                    });
                  },
                  child: ListHeaderWidget(
                    headerName: 'NAME/ M.CAP',
                    isSort: isSort,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSortChange) {
                        _pagingController.itemList.sort((a, b) =>
                            b.percentChange24h.compareTo(a.percentChange24h));
                        isSortChange = false;
                      } else {
                        _pagingController.itemList.sort((a, b) =>
                            a.percentChange24h.compareTo(b.percentChange24h));
                        isSortChange = true;
                      }
                    });
                  },
                  child: ListHeaderWidget(
                    headerName: 'CHANGE',
                    isSort: isSortChange,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSortPrice) {
                        _pagingController.itemList
                            .sort((a, b) => b.price.compareTo(a.price));
                        isSortPrice = false;
                      } else {
                        _pagingController.itemList
                            .sort((a, b) => a.price.compareTo(b.price));
                        isSortPrice = true;
                      }
                    });
                  },
                  child: ListHeaderWidget(
                    headerName: 'PRICE',
                    isSort: isSortPrice,
                  ),
                ),
              ],
            ),
          ),
        ),
        PagedSliverList<int, CoinListResponseModel>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                padding: EdgeInsets.only(left: 4.0, right: 4.0),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CoinDetail(
                        item.symbol,
                        widget.currencyCode,
                        widget.currencySymbol,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CoinListLogoAndNameWidget(
                      logo: item.logo,
                      name: item.name,
                      symbol: item.symbol,
                      marketCapUSD:
                          "${item.symbol} / ${NumberFormat.compactCurrency(
                        decimalDigits: 2,
                        symbol: '${widget.currencySymbol}',
                      ).format(item.marketCapUSD)}",
                    ),
                    CoinListLogoChangeWidget(
                      percentChange24h: item.percentChange24h,
                    ),
                    CoinListPriceWidget(
                      price: '${item.price > 99999 ? NumberFormat.compactCurrency(
                          decimalDigits: 2,
                          symbol: '${widget.currencySymbol}',
                        ).format(item.price) : '${widget.currencySymbol}' + item.price.toStringAsFixed(2)}',
                      priceBTC: item.priceBTC,
                    ),
                  ],
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
