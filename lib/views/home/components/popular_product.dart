import 'package:db_vendor/controllers/controllers.dart';
import 'package:db_vendor/modals/modals.dart';
import 'package:db_vendor/modals/size_config.dart';

import 'package:flutter/material.dart';
import 'package:db_vendor/helpers/product_card.dart';
import 'package:get/get.dart';
import 'package:db_vendor/views/views.dart';

import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  final ProductController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Popular Products",
              press: () {
                Get.to(() => AllProducts());
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => Row(
              children: [
                ...List.generate(
                  _controller.products.length,
                  (index) {
                    Products wooProducts = _controller.products[index];
                    return ProductCard(product: wooProducts);
                    // here by default width and height is 0
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DBPopularProducts extends StatelessWidget {
  final ProductController _controller = Get.find();
  final String title, first;
  DBPopularProducts({Key key, this.title, this.first}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: title,
              press: () {
                //Get.to(() => AllProducts());
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => Row(
              children: [
                ...List.generate(
                  _controller.products.length,
                  (index) {
                    Products wooProducts = _controller.products[index];
                    return DBProductCard(
                      product: wooProducts,
                      index: index + 1,
                      first: first,
                    );
                    // here by default width and height is 0
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          ),
        )
      ],
    );
  }
}