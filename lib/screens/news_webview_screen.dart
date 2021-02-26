import 'package:cointopper/bloc/news_details_bloc/news_details_bloc.dart';
import 'package:cointopper/bloc/news_details_bloc/news_details_event.dart';
import 'package:cointopper/bloc/news_details_bloc/news_details_state.dart';
import 'package:cointopper/widget/close_button.dart';
import 'package:cointopper/widget/custom_safearea_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class NewsWebview extends StatefulWidget {
  final int id;

  NewsWebview({
    @required this.id,
  });

  @override
  _NewsWebviewState createState() => _NewsWebviewState();
}

class _NewsWebviewState extends State<NewsWebview> {
  get globalKey => GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewsDetailsBloc>(context).add(LoadNewsDetails(widget.id));
    return CustomSafeAreaWidget(
      color1: Color(0xFFdb1ec9),
      color2: Color(0xFFff005a),
      child: Scaffold(
        body: BlocBuilder<NewsDetailsBloc, NewsDetailsState>(
          builder: (context, state) {
            if (state is NewsDetailsLoadSuccess) {
              var data = state.newsDetailsList[0];
              print('data details ==>>  ${data.detailsEn}');
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFdb1ec9),
                          Color(0xFFff005a),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "News",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08,
                                color: Colors.white,
                              ),
                            ),
                            CloseButtonWidget(context: context),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFFdb1ec9), Color(0xFFff005a)],
                            ),
                          ),
                          child: Text(
                            data.titleEn.toString(),
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Image(
                            width: MediaQuery.of(context).size.width,
                            height: 160,
                            fit: BoxFit.fill,
                            image: NetworkImage(data.photoFile.toString()),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                  child: HtmlWidget(data.detailsEn))),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        // body: _buildWebView(data),
      ),
    );
  }
}
