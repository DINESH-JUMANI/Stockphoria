class BuyedStocksModel {
  final String stockName;
  final double buyingPrice;
  final int quantityBuyed;
  final double totalAmount;

  BuyedStocksModel(
      {required this.stockName,
      required this.buyingPrice,
      required this.quantityBuyed,
      required this.totalAmount});
}
