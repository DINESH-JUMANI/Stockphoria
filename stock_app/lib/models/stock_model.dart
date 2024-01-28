class StockModel {
  final String shortName;
  final String longName;
  final double price;
  final double changeInPrice;

  StockModel(
      {required this.shortName,
      required this.longName,
      required this.price,
      required this.changeInPrice});
}
