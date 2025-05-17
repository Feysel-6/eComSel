import 'package:ecom_sel/features/shop/screens/home/home.dart';
import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: dark ? EColors.black : EColors.white,
          indicatorColor: dark ? EColors.white.withValues(alpha: 0.1) : EColors.black.withValues(alpha: 0.1),
        
          destinations: const [
            NavigationDestination(
              icon: Icon(HugeIcons.strokeRoundedHome01),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(HugeIcons.strokeRoundedStore02),
              label: 'Store',
            ),
            NavigationDestination(
              icon: Icon(HugeIcons.strokeRoundedFavourite),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: Icon(HugeIcons.strokeRoundedUser),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx (() => controller.screens[controller.selectedIndex.value],)
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeScreen(),Container(color: Colors.blue,),Container(color: Colors.deepPurple,),Container(color: Colors.orange,)];
}
