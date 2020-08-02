import 'package:bitcoin/app/bitcoin/controller/bitcoin_controller.dart';
import 'package:flutter/material.dart';

class BitCoinWidget extends StatefulWidget {
  final BitCoinController controller;

  BitCoinWidget(this.controller);

  @override
  _BitCoinWidgetState createState() => _BitCoinWidgetState();
}

class _BitCoinWidgetState extends State<BitCoinWidget> {
  @override
  Widget build(BuildContext context) {
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
                        value: widget.controller.dropdownValue,
                        icon: Icon(Icons.arrow_drop_down,
                            color: Theme.of(context).primaryColor),
                        iconSize: 20,
                        // elevation: 2,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: "Ubuntu",
                            fontWeight: FontWeight.w900),
                        onChanged: (String newValue) {
                          widget.controller.dropdownValue = newValue;
                          widget.controller.obterValorBitCoin(newValue);
                        },
                        items: widget.controller.valuesDropDown
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
                            widget.controller.valorCompra,
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
                      widget.controller.valorVenda,
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
