import 'package:ecom_sel/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Supabase.initialize(
    url: 'https://jfxmmyqpfbhlvlnwxaio.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpmeG1teXFwZmJobHZsbnd4YWlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE5MTUxNDgsImV4cCI6MjA2NzQ5MTE0OH0.pzqa2BZEWZK0-8p2rnG3YCxj9dAEn4sr5MjN8X2D5p4'
  ).then((_) => Get.put(AuthenticationRepository()));
  runApp(App());
}

final supabase = Supabase.instance.client;