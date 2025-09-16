import 'package:ecom_sel/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';

Future<void> main() async {
  //Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //Init Local Storage
  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://pybloyeycvcppapxifrp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB5YmxveWV5Y3ZjcHBhcHhpZnJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY3MzQ3OTgsImV4cCI6MjA3MjMxMDc5OH0.BSWEfYtIVtvY-yaXM_Oc7zhqXmEY6T6lsoVoMbfW6SM'
  ).then((_) => Get.put(AuthenticationRepository()));
  runApp(App());
}

final supabase = Supabase.instance.client;