import 'package:cointopper/widget/coin_details_widgets/details_youtube_player.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CoinDetailIntroWidget extends StatelessWidget {
  final String heading;
  final String intro;
  final String youtube;

  CoinDetailIntroWidget({
    Key key,
    this.heading,
    this.intro,
    this.youtube,
  }) : super(key: key);

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ReadMoreText(
                removeAllHtmlTags(intro),
                trimLines: 1,
                colorClickableText: Colors.blue,
                trimCollapsedText: '...Show more',
                trimExpandedText: ' show less',
              ),
              SizedBox(
                height: 10,
              ),
              DetailsYoutubePlayer(youtube),
            ],
          ),
        ),
      ),
    );
  }
}
