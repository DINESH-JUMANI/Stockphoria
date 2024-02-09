import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/providers/wishlist.dart';
import 'package:stock_app/screens/buy_sell.dart';

class ShowStocks extends ConsumerWidget {
  const ShowStocks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfWishListStocks = ref.watch(wishListProvider);
    return ListView.separated(
      itemCount: listOfWishListStocks.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey.shade400,
        );
      },
      itemBuilder: (context, index) {
        final shortName = listOfWishListStocks[index].shortName;
        final longName = listOfWishListStocks[index].longName;
        double? price = listOfWishListStocks[index].price;
        double? changeInPrice = listOfWishListStocks[index].changeInPrice;

        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => BuySell(stock: listOfWishListStocks[index])));
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
            mainAxisAlignment: MainAxisAlignment.end,
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
