import 'package:flutter/material.dart';

class BuildTotalCapWidget extends StatelessWidget {
  final String name;
  final String value;

  BuildTotalCapWidget({
    Key key,
    @required this.name,
  @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              color: Colors.blue[800],
            ),
          ),
        ],
      ),
    );
  }
}
