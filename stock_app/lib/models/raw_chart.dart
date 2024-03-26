class ChartModel {
  Chart? chart;

  ChartModel({this.chart});

  ChartModel.fromJson(Map<String, dynamic> json) {
    chart = json['chart'] != null ? new Chart.fromJson(json['chart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chart != null) {
      data['chart'] = this.chart!.toJson();
    }
    return data;
  }
}

class Chart {
  List<Result>? result;

  Chart({this.result});

  Chart.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  List<int>? timestamp;
  Indicators? indicators;

  Result({this.timestamp, this.indicators});

  Result.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'].cast<int>();
    indicators = json['indicators'] != null
        ? new Indicators.fromJson(json['indicators'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    if (this.indicators != null) {
      data['indicators'] = this.indicators!.toJson();
    }
    return data;
  }
}

class Indicators {
  List<Quote>? quote;

  Indicators({this.quote});

  Indicators.fromJson(Map<String, dynamic> json) {
    if (json['quote'] != null) {
      quote = <Quote>[];
      json['quote'].forEach((v) {
        quote!.add(new Quote.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quote != null) {
      data['quote'] = this.quote!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quote {
  List<double>? open;
  List<double>? high;
  List<int>? volume;
  List<double>? low;
  List<double>? close;

  Quote({this.open, this.high, this.volume, this.low, this.close});

  Quote.fromJson(Map<String, dynamic> json) {
    open = json['open'].cast<double>();
    high = json['high'].cast<double>();
    volume = json['volume'].cast<int>();
    low = json['low'].cast<double>();
    close = json['close'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['high'] = this.high;
    data['volume'] = this.volume;
    data['low'] = this.low;
    data['close'] = this.close;
    return data;
  }
}
