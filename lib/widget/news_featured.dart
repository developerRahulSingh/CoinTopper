import 'package:carousel_slider/carousel_slider.dart';
import 'package:cointopper/bloc/featured_news_bloc/featured_news_bloc.dart';
import 'package:cointopper/bloc/featured_news_bloc/featured_news_state.dart';
import 'package:cointopper/screens/news_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'news_widget/news_featured_list_title_widget.dart';

class NewsFeatured extends StatefulWidget {
  @override
  _NewsFeaturedState createState() => _NewsFeaturedState();
}

class _NewsFeaturedState extends State<NewsFeatured> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedNewsBloc, FeaturedNewsState>(
      builder: (context, state) {
        if (state is FeaturedNewsListLoadSuccess) {
          final data = state.featuredNewsList;
          return Column(children: [
            Container(
              padding:
                  EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
              width: MediaQuery.of(context).size.width * 1,
              child: Text(
                "FEATURED NEWS",
                style: TextStyle(
                  color: HexColor("#005580"),
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),
            // featuredNews(context, data)
            NewsSlider(data)
          ]);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class NewsSlider extends StatefulWidget {
  final data;

  NewsSlider(this.data);

  @override
  _NewsSliderState createState() => _NewsSliderState(this.data);
}

class _NewsSliderState extends State<NewsSlider> {
  final data;

//  final _key = UniqueKey();

  _NewsSliderState(this.data);

//  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Widget carousel = data == null
        ? Center(
            child: Container(
              child: Text(
                "No Data Available",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          )
        : CarouselSlider(
            options: CarouselOptions(
                height: 140,
                autoPlay: true,
                viewportFraction: 1,
                aspectRatio: 1.5,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
//                  print('News Featured page ');
//                  setState(() {
//                    _current = index;
//                  });
                }),
            items: data.map<Widget>((e) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => NewsWebview(
                        id: e.id,
                      ),
                    ),
                  );
                },
                child: new Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(),
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            child: Stack(
                              children: <Widget>[
                                Image.network(
                                  e.photoFile,
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: NewsFeaturedListTitleWidget(
                                    title: e.titleEn,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    )),
              );
            }).toList(),
          );
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data != null
                ? Container(
                    color: Colors.grey[100],
                    child: Column(
                      children: <Widget>[carousel],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
