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
    url: "https://odewakauccgjwtzwdwkx.supabase.co",
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9kZXdha2F1Y2Nnand0endkd2t4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxODA4OTEsImV4cCI6MjA3NDc1Njg5MX0.lAp1QWRpHWFcSr6narPi-21rH3jpzlbqxjAG-UUtldU'
  ).then((_) => Get.put(AuthenticationRepository()));
  runApp(App());
}

final supabase = Supabase.instance.client;