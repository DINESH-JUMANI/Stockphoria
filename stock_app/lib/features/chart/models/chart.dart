class Chart {
  Chart({
    required this.x,
    required this.open,
    required this.close,
    required this.high,
    required this.low,
  });
  final DateTime? x;
  final num? open;
  final num? close;
  final num? high;
  final num? low;
}
