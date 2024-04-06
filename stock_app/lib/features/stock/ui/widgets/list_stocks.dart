import 'package:flutter/material.dart';
import 'package:stock_app/features/stock/model/stock_model.dart';
import 'package:stock_app/features/stock/ui/screens/try_buy_sell.dart';

class ListStocks extends StatelessWidget {
  const ListStocks({Key? key, required this.stocks}) : super(key: key);
  final List<StockModel> stocks;

  void onClick(StockModel stock, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return TryBuySell(
            stock: stock,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.shade400,
        );
      },
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final longName = stocks[index].longName;
        final shortName = stocks[index].shortName;
        final price = stocks[index].price;
        final changeInPrice = stocks[index].changeInPrice;
        return ListTile(
          onTap: () {
            return onClick(stocks[index], context);
          },
          contentPadding: const EdgeInsets.all(10),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(
                  longName.characters.first,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shortName,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      longName,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price.toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (changeInPrice >= 0)
                Text(
                  '+${changeInPrice.toStringAsFixed(2)}%',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                  ),
                )
              else
                Text(
                  '${changeInPrice.toStringAsFixed(2)}%',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
