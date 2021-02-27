import 'package:cointopper/widget/news_featured.dart';
import 'package:cointopper/widget/search_button_widget.dart';
import 'package:flutter/material.dart';

import 'news_list_screen.dart';
import 'news_search.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var textInput;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFdb1ec9), Color(0xFFff005a)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFdb1ec9), Color(0xFFff005a)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "CoinTopper",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white60,
                      ),
                    ),
                    Text(
                      "News",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SearchButtonWidget(
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: Colors.black12,
                      alignment: Alignment.centerLeft,
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => NewsSearch(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              NewsFeatured(),
              Expanded(
                child: NewsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
