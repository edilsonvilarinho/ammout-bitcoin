import 'package:bitcoin/app/bitcoin/controller/bitcoin_controller.dart';
import 'package:bitcoin/app/bitcoin/customs/bitcoin_widget.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BitCoinView extends StatefulWidget {
  @override
  _BitCoinViewState createState() => _BitCoinViewState();
}

class _BitCoinViewState extends State<BitCoinView> {
  @override
  void initState() {
    super.initState();
  }

  Widget exibicaoValorBitCoin(BitCoinController controller) {
    if (controller.ocupado) {
      return Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromRGBO(247, 147, 26, 1)),
        ),
      );
    } else {
      return BitCoinWidget(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<BitCoinController>(
        builder: (context, controller, child) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        CryptoFontIcons.BTC,
                        color: Theme.of(context).primaryColor,
                        size: MediaQuery.of(context).size.aspectRatio * 100,
                      ),
                      Image.asset(
                        "images/logoname.png",
                        width: 200,
                      )
                    ],
                  ),
                  exibicaoValorBitCoin(controller),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: RawMaterialButton(
                      onPressed: () {
                        controller.obterValorBitCoin(controller.dropdownValue);
                      },
                      elevation: 2.0,
                      fillColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.refresh,
                        color: Theme.of(context).backgroundColor,
                        // size: 30.0,
                      ),
                      shape: CircleBorder(),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
