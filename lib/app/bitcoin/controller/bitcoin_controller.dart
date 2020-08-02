import 'dart:convert';
import 'package:bitcoin/app/bitcoin/model/bitcoin_model.dart';
import 'package:bitcoin/app/bitcoin/service/bitcoin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BitCoinController extends ChangeNotifier {
  bool ocupado = false;
  String valorCompra = "-- 0,00";
  String valorVenda = "-- 0,00";
  String dropdownValue = "";
  List<String> valuesDropDown = List();
  final BitCoinService service;

  BitCoinController(this.service) {
    valueDropDown();
  }

  valueDropDown() async {
    ocupado = true;
    notifyListeners();
    http.Response response = await service.requestApiBitCoin();
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      valuesDropDown = map.keys.toList();
      dropdownValue = map.keys.first;
      ocupado = true;
      obterValorBitCoin(map.keys.first);
    }
  }

  obterValorBitCoin(String value) async {
    String compra = " 0,00";
    String venda = " 0,00";
    String coin = "";
    try {
      ocupado = true;
      http.Response response = await service.requestApiBitCoin();
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        BitCoin bitCoin = BitCoin.fromJson(map[value]);
        compra = bitCoin.buy.toString();
        venda = bitCoin.sell.toString();
        coin = bitCoin.symbol;
      }
    } catch (e) {}
    valorCompra = "$coin $compra";
    valorVenda = "$coin $venda";
    ocupado = !ocupado;
    notifyListeners();
  }
}
