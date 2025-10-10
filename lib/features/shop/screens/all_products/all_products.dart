import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecom_sel/features/shop/screens/product/widgets/product_attribute.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:ecom_sel/utlis/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../controllers/all_product_controller.dart';
import '../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final PostgrestTransformBuilder<PostgrestList>? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: const EAppBar(
        title: Text('Popular Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetProductsByQuery(query),
            builder: (context, asyncSnapshot) {
              const loader = EVerticalProductShimmer();
              final widget = ECloudHelperFunctions.checkMultipleRecordState(asyncSnapshot: asyncSnapshot, loader: loader);
              if(widget != null) return widget;

              final products = asyncSnapshot.data!;

              return ESortableProducts(products: products,);
            }
          ),
        ),
      ),
    );
  }
}

