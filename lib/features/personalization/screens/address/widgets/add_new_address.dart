import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(showBackArrow: true, title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(HugeIcons.strokeRoundedUser),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: ESizes.spaceBtwInputFields),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(HugeIcons.strokeRoundedSmartPhone01),
                    labelText: 'Phone',
                  ),
                ),
                SizedBox(height: ESizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(HugeIcons.strokeRoundedBuilding03),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                    SizedBox(width: ESizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(HugeIcons.strokeRoundedCodesandbox),
                          labelText: 'Portal Code',
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(HugeIcons.strokeRoundedCity01),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    SizedBox(width: ESizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(HugeIcons.strokeRoundedActivity01),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ESizes.spaceBtwInputFields),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(HugeIcons.strokeRoundedActivity01),
                    labelText: 'State',
                  ),
                ),
                SizedBox(height: ESizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){}, child: Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
