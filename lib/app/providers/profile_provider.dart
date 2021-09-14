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

  Future<List<FamilyTTS>> searchTimeline(
      String searchTerm, String typeSubject) async {
    try {
      final response = await post(
        Urls.tts.timeline,
        body: {
          'searchTerm': searchTerm,
          'typeSubject': typeSubject,
        },
      );
      return (response.data as List)
          .map((item) => FamilyTTS.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<Quiz>> quizByFamily(String familyId, String typeQuiz) async {
    try {
      final response = await get(
        Urls.tts.quizByFamily,
        queryParameters: {
          'familyId': familyId,
          'typeQuiz': typeQuiz,
        },
      );
      return (response.data as List)
          .map((item) => Quiz.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<CourseTTS>> courseByFamily(String familyId) async {
    try {
      final response = await get(
        Urls.tts.courseByFamily,
        queryParameters: {
          'familyId': familyId,
        },
      );
      return (response.data as List)
          .map((item) => CourseTTS.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<ScheduleDetails> detailsReunionPGM(String familyId) async {
    try {
      final response = await get(
        '${Urls.tts.detailsReunionPGM}/$familyId',
      );
      return ScheduleDetails.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
