// ignore_for_file: prefer_void_to_null

class Stocks {
  Finance? finance;

  Stocks({this.finance});

  Stocks.fromJson(Map<String, dynamic> json) {
    finance =
        json['finance'] != null ? Finance.fromJson(json['finance']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (finance != null) {
      data['finance'] = finance!.toJson();
    }
    return data;
  }
}

class Finance {
  List<Result>? result;
  Null error;

  Finance({this.result, this.error});

  Finance.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }
}

class Result {
  int? count;
  List<Quotes>? quotes;
  int? jobTimestamp;
  int? startInterval;

  Result({this.count, this.quotes, this.jobTimestamp, this.startInterval});

  Result.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(Quotes.fromJson(v));
      });
    }
    jobTimestamp = json['jobTimestamp'];
    startInterval = json['startInterval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (quotes != null) {
      data['quotes'] = quotes!.map((v) => v.toJson()).toList();
    }
    data['jobTimestamp'] = jobTimestamp;
    data['startInterval'] = startInterval;
    return data;
  }
}

class Quotes {
  String? language;
  String? region;
  String? quoteType;
  String? typeDisp;
  String? quoteSourceName;
  bool? triggerable;
  String? customPriceAlertConfidence;
  double? trendingScore;
  int? firstTradeDateMilliseconds;
  int? priceHint;
  double? regularMarketChange;
  double? regularMarketChangePercent;
  int? regularMarketTime;
  double? regularMarketPrice;
  double? regularMarketPreviousClose;
  String? exchange;
  String? market;
  String? fullExchangeName;
  String? shortName;
  String? longName;
  String? marketState;
  int? sourceInterval;
  int? exchangeDataDelayedBy;
  String? exchangeTimezoneName;
  String? exchangeTimezoneShortName;
  int? gmtOffSetMilliseconds;
  bool? esgPopulated;
  bool? tradeable;
  bool? cryptoTradeable;
  String? symbol;

  Quotes(
      {this.language,
      this.region,
      this.quoteType,
      this.typeDisp,
      this.quoteSourceName,
      this.triggerable,
      this.customPriceAlertConfidence,
      this.trendingScore,
      this.firstTradeDateMilliseconds,
      this.priceHint,
      this.regularMarketChange,
      this.regularMarketChangePercent,
      this.regularMarketTime,
      this.regularMarketPrice,
      this.regularMarketPreviousClose,
      this.exchange,
      this.market,
      this.fullExchangeName,
      this.shortName,
      this.longName,
      this.marketState,
      this.sourceInterval,
      this.exchangeDataDelayedBy,
      this.exchangeTimezoneName,
      this.exchangeTimezoneShortName,
      this.gmtOffSetMilliseconds,
      this.esgPopulated,
      this.tradeable,
      this.cryptoTradeable,
      this.symbol});

  Quotes.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    region = json['region'];
    quoteType = json['quoteType'];
    typeDisp = json['typeDisp'];
    quoteSourceName = json['quoteSourceName'];
    triggerable = json['triggerable'];
    customPriceAlertConfidence = json['customPriceAlertConfidence'];
    trendingScore = json['trendingScore'];
    firstTradeDateMilliseconds = json['firstTradeDateMilliseconds'];
    priceHint = json['priceHint'];
    regularMarketChange = json['regularMarketChange'];
    regularMarketChangePercent = json['regularMarketChangePercent'];
    regularMarketTime = json['regularMarketTime'];
    regularMarketPrice = json['regularMarketPrice'];
    regularMarketPreviousClose = json['regularMarketPreviousClose'];
    exchange = json['exchange'];
    market = json['market'];
    fullExchangeName = json['fullExchangeName'];
    shortName = json['shortName'];
    longName = json['longName'];
    marketState = json['marketState'];
    sourceInterval = json['sourceInterval'];
    exchangeDataDelayedBy = json['exchangeDataDelayedBy'];
    exchangeTimezoneName = json['exchangeTimezoneName'];
    exchangeTimezoneShortName = json['exchangeTimezoneShortName'];
    gmtOffSetMilliseconds = json['gmtOffSetMilliseconds'];
    esgPopulated = json['esgPopulated'];
    tradeable = json['tradeable'];
    cryptoTradeable = json['cryptoTradeable'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language'] = language;
    data['region'] = region;
    data['quoteType'] = quoteType;
    data['typeDisp'] = typeDisp;
    data['quoteSourceName'] = quoteSourceName;
    data['triggerable'] = triggerable;
    data['customPriceAlertConfidence'] = customPriceAlertConfidence;
    data['trendingScore'] = trendingScore;
    data['firstTradeDateMilliseconds'] = firstTradeDateMilliseconds;
    data['priceHint'] = priceHint;
    data['regularMarketChange'] = regularMarketChange;
    data['regularMarketChangePercent'] = regularMarketChangePercent;
    data['regularMarketTime'] = regularMarketTime;
    data['regularMarketPrice'] = regularMarketPrice;
    data['regularMarketPreviousClose'] = regularMarketPreviousClose;
    data['exchange'] = exchange;
    data['market'] = market;
    data['fullExchangeName'] = fullExchangeName;
    data['shortName'] = shortName;
    data['longName'] = longName;
    data['marketState'] = marketState;
    data['sourceInterval'] = sourceInterval;
    data['exchangeDataDelayedBy'] = exchangeDataDelayedBy;
    data['exchangeTimezoneName'] = exchangeTimezoneName;
    data['exchangeTimezoneShortName'] = exchangeTimezoneShortName;
    data['gmtOffSetMilliseconds'] = gmtOffSetMilliseconds;
    data['esgPopulated'] = esgPopulated;
    data['tradeable'] = tradeable;
    data['cryptoTradeable'] = cryptoTradeable;
    data['symbol'] = symbol;
    return data;
  }
}
