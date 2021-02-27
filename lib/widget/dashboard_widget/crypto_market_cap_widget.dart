import 'package:cointopper/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:cointopper/bloc/dashboard_bloc/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CryptoMarketCapWidget extends StatelessWidget {
  const CryptoMarketCapWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'CRYPTOM.CAP',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.03,
            color: Colors.white,
          ),
        ),
        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoadSuccess) {
              var _formattedMarketCap = NumberFormat.compactCurrency(
                decimalDigits: 2,
                symbol: '\$',
              ).format(state.globalDataCoin[0].totalMarketCap);
              return Text(
                _formattedMarketCap,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Text(
                '--',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
