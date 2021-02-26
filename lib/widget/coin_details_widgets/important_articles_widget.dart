import 'package:cointopper/widget/coin_details_widgets/details_img_carousel.dart';
import 'package:flutter/material.dart';

class ImportantArticlesWidget extends StatelessWidget {
  final dynamic guides;

  const ImportantArticlesWidget({
    Key key,
    @required this.guides,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Important Articles",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DetailsImageCarousel(
                guides: guides,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
