import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class ProfileProvider extends RemoteProvider {
  Future<TTS> getInfo() async {
    try {
      final response = await get(
        Urls.tts.getInfo,
      );
      return TTS.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> editProfile(TTS user) async {
    try {
      await post(
        Urls.tts.edit,
        body: user.toJson(),
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
