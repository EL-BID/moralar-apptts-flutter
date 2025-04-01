import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class RegistrationDataProvider extends RemoteProvider {
  Future<bool> editPersonalData(FamilyUser user) async {
    try {
      await post(Urls.family.edit, body: user.toJson());
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<FamilyUser> getInfoFamily() async {
    try {
      final endpoint = Urls.family.getInfo;
      final response = await get(endpoint);
      log(response.data.toString());
      return FamilyUser.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
