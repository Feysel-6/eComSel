import 'package:ecom_sel/features/shop/controllers/address_controller.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/texts/section_heading.dart';

class EBillingAddressSection extends StatelessWidget {
  const EBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ESectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
        addressController.selectedAddress.value.id!.isNotEmpty
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coded by Fe',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: ESizes.spaceBtwItems / 2),

                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey, size: 16),
                    const SizedBox(width: ESizes.spaceBtwItems),
                    Text(
                      '+251-383-3838',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwItems / 2),

                Row(
                  children: [
                    const Icon(
                      Icons.location_history,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: ESizes.spaceBtwItems),
                    Text(
                      'Addis Ababa, Gurara 4944, Ethiopia',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
              ],
            )
            : Text(
              'Select Address',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
      ],
    );
  }
}
