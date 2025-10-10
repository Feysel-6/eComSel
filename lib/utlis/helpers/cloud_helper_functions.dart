import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ECloudHelperFunctions {
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> asyncSnapshot) {
    if (asyncSnapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!asyncSnapshot.hasData || asyncSnapshot.data == null) {
      return const Center(child: Text('No Data Found'));
    }
    if (asyncSnapshot.hasError) {
      return const Center(child: Text('Something went wrong'));
    }
    return null;
  }

  static Widget? checkMultipleRecordState<T>({
    required AsyncSnapshot<List<T>> asyncSnapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (asyncSnapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!asyncSnapshot.hasData ||
        asyncSnapshot.data == null ||
        asyncSnapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found'));
    }
    if (asyncSnapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong'));
    }
    return null;
  }

  static Future<String> getURLFromFilePathAndName(
    String bucket,
    String path,
  ) async {
    try {
      if (path.isEmpty) return '';

      final client = Supabase.instance.client;

      // Get the public URL for this file
      final String publicUrl = client.storage.from(bucket).getPublicUrl(path);

      return publicUrl;
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}
