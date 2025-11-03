import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utlis/helpers/helper_functions.dart';
import '../../../../shop/models/address_model.dart';

class ESingleAddress extends StatelessWidget {
  const ESingleAddress({
    super.key,
    required this.addressModel,
    required this.onTap,
  });

  final AddressModel addressModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Obx(() {
      return InkWell(
        onTap: onTap,
        child: ERoundedContainer(
          width: double.infinity,
          padding: EdgeInsets.all(ESizes.md),
          showBorder: true,
          backgroundColor:
              addressModel.selected.value
                  ? EColors.primary.withValues(alpha: 0.5)
                  : Colors.transparent,
          borderColor:
              addressModel.selected.value
                  ? Colors.transparent
                  : dark
                  ? EColors.darkerGrey
                  : EColors.grey,
          margin: EdgeInsets.only(bottom: ESizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  addressModel.selected.value ? Iconsax.tick_circle5 : null,
                  color:
                      addressModel.selected.value
                          ? dark
                              ? EColors.light
                              : EColors.dark
                          : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addressModel.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: ESizes.sm / 2),
                  Text(
                    addressModel.formattedPhoneNo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: ESizes.sm / 2),
                  Text(
                    addressModel.toString(),
                    maxLines: 2,
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
