class Portfolio {
  final String userId;
  final String stockName;
  final double buyingPrice;
  final int quantityBuyed;
  final double totalAmount;

  Portfolio(
      {required this.userId,
      required this.stockName,
      required this.buyingPrice,
      required this.quantityBuyed,
      required this.totalAmount});
}
