import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utlis/validators/validation.dart';
import '../../../../shop/controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: EAppBar(showBackArrow: true, title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) => EValidator.validateEmptyText('Name', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: ESizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: EValidator.validatePhoneNumber,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone',
                  ),
                ),
                SizedBox(height: ESizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) => EValidator.validateEmptyText('Street', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                    SizedBox(width: ESizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) => EValidator.validateEmptyText('Postal Code', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ESizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) => EValidator.validateEmptyText('City', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    SizedBox(width: ESizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) => EValidator.validateEmptyText('State', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ESizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.country,
                  validator: (value) => EValidator.validateEmptyText('Country', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                ),
                SizedBox(height: ESizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: controller.addNewAddresses, child: Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
