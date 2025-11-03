import 'package:ecom_sel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecom_sel/data/repositories/user/user_repository.dart';
import 'package:ecom_sel/features/authentication/screens/login/login.dart';
import 'package:ecom_sel/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:ecom_sel/utlis/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';
import '../../../utlis/constants/image_strings.dart';
import '../../../utlis/helpers/network_manager.dart';
import '../../../utlis/loaders/loaders.dart';
import '../../authentication/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepo = Get.put(UserRepository());

  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      final user = await userRepo.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
  }

  Future<void> saveUserRecord(AuthResponse credentials) async {
    try {
      final nameParts = UserModel.nameParts(
        credentials.user!.userMetadata!['name'] ?? '',
      );
      final username = UserModel.generateUsername(
        credentials.user!.userMetadata!['name'] ?? '',
      );

      final user = UserModel(
        id: credentials.user!.id,
        firstName: nameParts[0],
        lastName: nameParts[1],
        username: username,
        email: credentials.user!.email ?? '',
        phoneNumber:
            credentials.user!.phone?.isNotEmpty == true
                ? credentials.user!.phone
                : null,
        profilePicture: credentials.user!.userMetadata!['avatar_url'] ?? '',
      );

      await UserRepository.instance.saveUserRecord(user);
    } catch (e) {
      ELoaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your profile.',
      );
    }
  }

  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (image != null) {
        final imageUrl = await userRepo.uploadImage(
          'Users/Images/Profile/${supabase.auth.currentUser!.id}.jpg',
          image,
        );

        final freshUrl = '$imageUrl?t=${DateTime.now().millisecondsSinceEpoch}';

        Map<String, dynamic> json = {'profile_picture': freshUrl};
        await userRepo.updateSingleField(json);

        user.value.profilePicture = freshUrl;
        user.refresh();
        ELoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Profile Image has been updated!',
        );
      }
    } catch (e) {
      ELoaders.errorSnackBar(
        title: 'Oh Snap',
        message: 'Something went wrong while uploading your profile picture.',
      );
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      EFullScreenLoader.openLoadingDialog('Processing', EImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        ELoaders.errorSnackBar(
          title: 'No Internet',
          message: 'Please check your connection and try again.',
        );
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) return;

      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );
      await userRepo.removeUserRecord(
        AuthenticationRepository.instance.authUser!.id,
      );

      EFullScreenLoader.stopLoading(
        onFinish: () {
          ELoaders.successSnackBar(
            title: "Successful",
            message: 'Your name has been updated',
          );
          Get.offAll(() => const LoginScreen());
        },
      );
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void deleteUserAccount() async {
    try {
      EFullScreenLoader.openLoadingDialog('Processing', EImages.docerAnimation);

      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.appMetadata['provider'];
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await UserRepository.instance.removeUserRecord(auth.authUser!.id);
          ();
          EFullScreenLoader.stopLoading();
          Get.offAll(() => LoginScreen());
        } else if (provider == 'email') {
          EFullScreenLoader.stopLoading();
          Get.to(() => ReAuthenticateUserLoginForm());
        }
      }
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ESizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: ESizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(), // closes the dialog safely
        child: const Text('Cancel'),
      ),
    );
  }
}
