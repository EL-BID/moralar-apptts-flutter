import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class DashboardProvider extends RemoteProvider {
  Future<Dashboard> getDashboard() async {
    try {
      final response = await get(
        Urls.tts.dashboard,
      );
      return Dashboard.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
