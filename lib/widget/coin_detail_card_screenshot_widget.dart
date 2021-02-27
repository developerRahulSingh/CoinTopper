import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cointopper/widget/coin_details_widgets/coin_detail_card_graph_date_and_logo_widget.dart';
import 'package:cointopper/widget/coin_details_widgets/coin_detail_logo_and_name_widget.dart';
import 'package:cointopper/widget/coin_details_widgets/coin_detail_pricebtc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:intl/intl.dart';

import 'coin_details_widgets/coin_detail_card_screenshot_button_widget.dart';
import 'coin_details_widgets/coin_price_and _change_widget.dart';

class CoinDetailCardWidget extends StatefulWidget {
  final dynamic data;
  final dynamic currencySymbol;

  CoinDetailCardWidget(
    this.data,
    this.currencySymbol,
  );

  @override
  _CoinDetailCardWidgetState createState() => _CoinDetailCardWidgetState();
}

class _CoinDetailCardWidgetState extends State<CoinDetailCardWidget> {
  GlobalKey _globalKey = new GlobalKey();

  Future<void> _captureScreenshot(_globalKey, var data) async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
//      var png = byteData.buffer.asUint8List();
      final snackBar = SnackBar(
        content: Text('Saved to Gallery'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code
          },
        ),
      );
      var filePath = await ImagePickerSaver.saveFile(
          fileData: byteData.buffer.asUint8List());
      print(filePath);
      Scaffold.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  dynamic shareButton() {
    return CoinDetailCardScreenShotButtonWidget(
      onPress: () {},
      iconName: Icons.share,
    );
  }

  dynamic downloadButton(var data) {
    return CoinDetailCardScreenShotButtonWidget(
      onPress: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _captureScreenshot(_globalKey, widget.data);
      },
      iconName: Icons.arrow_downward,
    );
  }

  dynamic closeButton() {
    return CoinDetailCardScreenShotButtonWidget(
      onPress: () {
        Navigator.of(context).pop();
      },
      iconName: Icons.close,
    );
  }

  @override
  Widget build(BuildContext context) {
    var currDt = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy \n kk:mm:ss').format(currDt);
    var cap = NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '${widget.currencySymbol}',
    ).format(widget.data.marketCapUSD);

    return Container(
      child: AlertDialog(
        actionsOverflowDirection: VerticalDirection.up,
        elevation: 0,
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.only(
          top: 32,
          left: 8,
          right: 8,
        ),
        buttonPadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(0),
        content: Container(
          height: 240,
          child: new Column(
            children: <Widget>[
              RepaintBoundary(
                key: _globalKey,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  child: Container(
                    height: 220,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          HexColor(widget.data.color1),
                          HexColor(widget.data.color2)
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CoinDetailLogoAndNameWidget(
                          logo: widget.data.logo,
                          name: widget.data.name,
                          symbol: widget.data.symbol,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CoinPriceAndChangeWidget(
                                  price: widget.data.price > 99999
                                      ? NumberFormat.compactCurrency(
                                          decimalDigits: 2,
                                          symbol: '${widget.currencySymbol}',
                                        ).format(widget.data.price)
                                      : '${widget.currencySymbol}' +
                                          widget.data.price.toStringAsFixed(2),
                                  change: widget.data.percentChange24h,
                                  priceFontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  changeFontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                CoinDetailPricebtcWidget(
                                  priceBTC:
                                      widget.data.priceBTC.toStringAsFixed(8),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CoinPriceAndChangeWidget(
                                            price: widget.data.high24USD > 99999
                                                ? NumberFormat.compactCurrency(
                                                    decimalDigits: 2,
                                                    symbol:
                                                        '${widget.currencySymbol}',
                                                  ).format(
                                                    widget.data.high24USD)
                                                : '${widget.currencySymbol}' +
                                                    widget.data.high24USD
                                                        .toStringAsFixed(2),
                                            priceFontSize:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                            title: "24 HRS HIGH",
                                            titleFontSize:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.025,
                                          ),
                                          CoinPriceAndChangeWidget(
                                            price: widget.data.low24USD > 99999
                                                ? NumberFormat.compactCurrency(
                                                    decimalDigits: 2,
                                                    symbol:
                                                        '${widget.currencySymbol}',
                                                  ).format(widget.data.low24USD)
                                                : '${widget.currencySymbol}' +
                                                    widget.data.low24USD
                                                        .toStringAsFixed(2),
                                            priceFontSize:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                            title: "24 HRS LOW",
                                            titleFontSize:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.025,
                                          ),
                                          CoinPriceAndChangeWidget(
                                            price: cap,
                                            priceFontSize:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                            title: "Market Cap",
                                            titleFontSize:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.025,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            CoinDetailCardGraphDateAndLogoWidget(
                              marketId: widget.data.marketId,
                              formattedDate: formattedDate,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                shareButton(),
                downloadButton(widget.data),
                closeButton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
