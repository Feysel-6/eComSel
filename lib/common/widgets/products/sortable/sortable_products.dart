import 'package:ecom_sel/features/shop/controllers/all_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../../features/shop/models/product_model.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../layout/grid_layout.dart';
import '../product_cards/product_card.dart';

class ESortableProducts extends StatelessWidget {
  const ESortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          initialValue: 'Name',
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.sort),
          ),
          items:
          [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity',
          ]
              .map(
                (option) => DropdownMenuItem(
              value: option,
              child: Text(option),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: ESizes.spaceBtwSections),
        Obx(() =>
          EGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => EProductCard(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}
