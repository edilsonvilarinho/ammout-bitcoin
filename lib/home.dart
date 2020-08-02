import 'dart:convert';

import 'package:bitcoin/bitcoin.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool ocupado = false;
  String _valorCompra = "-- 0,00";
  String _valorVenda = "-- 0,00";
  String _valorMercadoA15minutos = "-- 0,00";
  String dropdownValue = "";
  List<String> valuesDropDown = List();

  @override
  void initState() {
    super.initState();
    valueDropDown();
  }

  Future<http.Response> requestApiBitCoin() async {
    try {
      http.Response response = await http.get("https://blockchain.info/ticker");
      return response;
    } catch (e) {
      return null;
    }
  }

  valueDropDown() async {
    http.Response response = await requestApiBitCoin();
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      setState(() {
        valuesDropDown = map.keys.toList();
        dropdownValue = map.keys.first;
        ocupado = true;
        obterValorBitCoin(map.keys.first);
      });
    }
  }

  obterValorBitCoin(String value) async {
    String valorCompra = " 0,00";
    String valorVenda = " 0,00";
    String valorMercadoA15minutos = " 0,00";
    String coin = "";
    try {
      http.Response response = await requestApiBitCoin();

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        BitCoin bitCoin = BitCoin.fromJson(map[value]);
        valorCompra = bitCoin.buy.toString();
        valorVenda = bitCoin.sell.toString();
        valorMercadoA15minutos = bitCoin.d15m.toString();
        coin = bitCoin.symbol;
      }
    } catch (e) {}

    setState(() {
      _valorCompra = "$coin $valorCompra";
      _valorVenda = "$coin $valorVenda";
      _valorMercadoA15minutos = "$coin $valorMercadoA15minutos";
      ocupado = !ocupado;
    });
  }

  Widget exibicaoValorBitCoin() {
    if (ocupado) {
      return Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromRGBO(247, 147, 26, 1)),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Center(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.0),
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: Theme.of(context).backgroundColor,
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down,
                              color: Theme.of(context).primaryColor),
                          iconSize: 20,
                          // elevation: 2,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontFamily: "Ubuntu",
                              fontWeight: FontWeight.w900),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              ocupado = true;
                            });
                            obterValorBitCoin(newValue);
                          },
                          items: valuesDropDown
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(
                                      inherit: false,
                                      color: Theme.of(context).primaryColor,
                                      decorationColor:
                                          Theme.of(context).backgroundColor)),
                            );
                          }).toList(),
                        ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/compra.png",
                      width: 40,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              _valorCompra,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.aspectRatio *
                                          40,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      "images/venda.png",
                      width: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        _valorVenda,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize:
                                MediaQuery.of(context).size.aspectRatio * 40,
                            fontFamily: 'Roboto'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
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
              exibicaoValorBitCoin(),
              Padding(
                padding: EdgeInsets.only(top: 1),
                child: RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      ocupado = true;
                    });
                    obterValorBitCoin(dropdownValue);
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
      ),
    );
  }
}
