import 'package:clone_amazon/models/product_model.dart';
import 'package:clone_amazon/screens/product_screen.dart';
import 'package:clone_amazon/utils/color_theme.dart';
import 'package:clone_amazon/utils/utils.dart';
import 'package:clone_amazon/widget/cost_widget.dart';
import 'package:clone_amazon/widget/rating_star_widget.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel product;
  const ResultWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModel: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(product.url),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                product.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenSize.width / 5,
                      child: FittedBox(
                          child: RatingStarWidget(rating: product.rating))),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      product.noOfRating.toString(),
                      style: const TextStyle(color: activeCyanColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWidget(
                  color: const Color.fromARGB(255, 92, 9, 3),
                  cost: product.cost,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
