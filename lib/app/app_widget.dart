import 'package:bitcoin/app/bitcoin/controller/bitcoin_controller.dart';
import 'package:bitcoin/app/bitcoin/service/bitcoin_service.dart';
import 'package:bitcoin/app/bitcoin/view/bitcoin_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BitCoinController>.value(
            value: BitCoinController(BitCoinService()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFF7931B),
          backgroundColor: Color(0xFFE1E1E1), // 0xFF
        ),
        home: BitCoinView(),
      ),
    );
  }
}
