import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class MatchsProvider extends RemoteProvider {
  Future<List<Match>> searchTimeline(
      String search, String residencialCode) async {
    try {
      final response = await post(
        Urls.tts.matchs,
        body: {
          'search': search,
          'residencialCode': residencialCode,
        },
      );
      return (response.data as List)
          .map((item) => Match.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
