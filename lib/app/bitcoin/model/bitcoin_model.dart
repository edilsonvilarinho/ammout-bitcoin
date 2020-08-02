class BitCoin {
  double _d15m;
  double _last;
  double _buy;
  double _sell;
  String _symbol;

  BitCoin({double d15m, double last, double buy, double sell, String symbol}) {
    this._d15m = d15m;
    this._last = last;
    this._buy = buy;
    this._sell = sell;
    this._symbol = symbol;
  }

  double get d15m => _d15m;

  double get last => _last;

  double get buy => _buy;

  double get sell => _sell;

  String get symbol => _symbol;

  BitCoin.fromJson(Map<String, dynamic> json) {
    _d15m = json['15m'];
    _last = json['last'];
    _buy = json['buy'];
    _sell = json['sell'];
    _symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['15m'] = this._d15m;
    data['last'] = this._last;
    data['buy'] = this._buy;
    data['sell'] = this._sell;
    data['symbol'] = this._symbol;
    return data;
  }
}
