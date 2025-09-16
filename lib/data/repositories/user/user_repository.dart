import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/authentication/models/user_model.dart';
import '../../../main.dart';
import '../authentication/authentication_repository.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = Supabase.instance.client;
  final supabaseAdmin = SupabaseClient(
    'https://pybloyeycvcppapxifrp.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB5YmxveWV5Y3ZjcHBhcHhpZnJwIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NjczNDc5OCwiZXhwIjoyMDcyMzEwNzk4fQ.OcJLu_TgxWA9qRjLdtnKtSzevGxdHVfGV8akyB_EsF8',
  );

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.from('users').insert(user.toJSON());
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final response =
          await _db
              .from('users')
              .select()
              .eq('id', AuthenticationRepository.instance.authUser!.id)
              .single();
      if (response.isNotEmpty) {
        return UserModel.fromJSON(response);
      } else {
        return UserModel.empty();
      }
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .from('users')
          .update(updatedUser.toJSON())
          .eq('id', updatedUser.id);
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .from('users')
          .update(json)
          .eq('id', AuthenticationRepository.instance.authUser!.id);
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await supabaseAdmin.auth.admin.deleteUser(userId);
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final avatarFile = File(image.path);

      await supabase.storage.from('avatars').upload(
        path,
        avatarFile,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
      );

      final String publicUrl =
      supabase.storage.from('avatars').getPublicUrl(path);

      return publicUrl;
    } on StorageException catch (e) {
      throw Exception('Storage Error: ${e.message}');
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } on FormatException {
      throw const FormatException('Invalid format');
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'A platform error occurred');
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

}
