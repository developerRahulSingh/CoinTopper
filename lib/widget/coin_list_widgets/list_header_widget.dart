import 'package:flutter/material.dart';

class ListHeaderWidget extends StatefulWidget {
  final String headerName;
  final bool isSort;

  ListHeaderWidget({
    Key key,
    this.headerName,
    this.isSort,
  }) : super(key: key);

  @override
  _ListHeaderWidgetState createState() => _ListHeaderWidgetState();
}

class _ListHeaderWidgetState extends State<ListHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            widget.headerName,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontWeight: FontWeight.w600,
              color: Color(0xFF005580),
            ),
          ),
          widget.isSort != null ?
          Icon(
            widget.isSort ? Icons.arrow_downward : Icons.arrow_upward,
            size: MediaQuery.of(context).size.width * 0.03,
            color: Color(0xFF005580),
          ): Container(),
        ],
      ),
    );
  }
}
