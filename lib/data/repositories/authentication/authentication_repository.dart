import 'package:ecom_sel/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecom_sel/features/authentication/screens/signup/verify_email.dart';
import 'package:ecom_sel/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../navigation_menu.dart';
import '../../../utlis/exceptions/supabase_auth_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = supabase.auth;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Get.offAll(() => const NavigationMenu());
      }
    });
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailConfirmedAt != null) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  Future<AuthResponse> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithPassword(email: email, password: password);
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } on AuthException catch (e) {
      throw EAuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<AuthResponse> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signUp(email: email, password: password);
    } on AuthException catch (e) {
      throw EAuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      return await _auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw EAuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on AuthException catch (e) {
      throw EAuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<AuthResponse> signInWithGoogle() async {
    const webClientId =
        '544846410104-m8n69f6317461hjjrekl4ntdgdcc5gt0.apps.googleusercontent.com';
    const iosClientId =
        '544846410104-rdj77ik1riimf2pr211n967v77eroars.apps.googleusercontent.com';

    final googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}
