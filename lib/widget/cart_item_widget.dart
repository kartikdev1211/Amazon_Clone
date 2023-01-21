import 'package:clone_amazon/models/product_model.dart';
import 'package:clone_amazon/resources/cloudfirestore_methods.dart';
import 'package:clone_amazon/screens/product_screen.dart';
import 'package:clone_amazon/utils/color_theme.dart';
import 'package:clone_amazon/utils/utils.dart';
import 'package:clone_amazon/widget/custom_simple_rounded_button.dart';
import 'package:clone_amazon/widget/product_information.dart';
import 'package:clone_amazon/widget/square_custom_button.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) =>
                        ProductScreen(productModel: product)),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Image.network(
                          product.url,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ProductInformationWidget(
                      productName: product.productName,
                      cost: product.cost,
                      sellerName: product.sellerName,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomSquareButton(
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(Icons.remove),
                ),
                CustomSquareButton(
                  onPressed: () {},
                  color: Colors.white,
                  dimension: 40,
                  child: const Text(
                    "0",
                    style: TextStyle(color: activeCyanColor),
                  ),
                ),
                CustomSquareButton(
                  onPressed: () async {
                    CloudFirestoreClass().addProductToCart(
                        productModel: ProductModel(
                            url: product.url,
                            productName: product.productName,
                            cost: product.cost,
                            discount: product.discount,
                            uid: product.uid,
                            sellerName: product.sellerName,
                            sellerUid: product.sellerUid,
                            rating: product.rating,
                            noOfRating: product.noOfRating));
                  },
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CustomSimpleRoundedButton(
                            onPressed: () async {
                              CloudFirestoreClass()
                                  .deleteProductFromCart(uid: product.uid);
                            },
                            text: "Delete"),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomSimpleRoundedButton(
                            onPressed: () {}, text: "Save for later"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "See more like this",
                          style: TextStyle(color: activeCyanColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
