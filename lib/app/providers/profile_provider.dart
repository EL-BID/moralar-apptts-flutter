import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:mime_type/mime_type.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

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

  Future<List<FamilyTTS>> getFamiliesTimelineLoadData(
      Map<String, String> body) async {
    final user = MegaFlutter.instance.auth.currentUser as TTS;
    final String token = user.token.accessToken.toString();

    try {
      final headersList = {'Accept': '*/*', 'Authorization': 'Bearer $token'};

      final url = Uri.parse(MoralarWidgets.instance.baseUrlForHTTP +
          Urls.family.timelineLoadData);

      final req = http.MultipartRequest('POST', url);
      req.headers.addAll(headersList);
      req.fields.addAll(body);

      final streamedResponse = await req.send();

      if (streamedResponse.statusCode == 200) {
        return await bytesToListFamiliesTimeLine(streamedResponse);
      } else {
        return [];
      }
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<FamilyLoadData>> getFamiliesLoadData(
      Map<String, String> body) async {
    final user = MegaFlutter.instance.auth.currentUser as TTS;
    final String token = user.token.accessToken.toString();

    try {
      final headersList = {'Accept': '*/*', 'Authorization': 'Bearer $token'};

      final url = Uri.parse(
          MoralarWidgets.instance.baseUrlForHTTP + Urls.family.familyLoadData);

      final req = http.MultipartRequest('POST', url);
      req.headers.addAll(headersList);
      req.fields.addAll(body);

      final streamedResponse = await req.send();

      if (streamedResponse.statusCode == 200) {
        return await bytesToListFamilies(streamedResponse);
      } else {
        return [];
      }
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<Map<String, String>>> getFamiliesLoadDataByDropdown(
      Map<String, String> body) async {
    final defaultItem = {'id': '-1', 'name': 'Selecione'};
    final user = MegaFlutter.instance.auth.currentUser as TTS;
    final String token = user.token.accessToken.toString();

    try {
      final headersList = {'Accept': '*/*', 'Authorization': 'Bearer $token'};

      final url = Uri.parse(
          MoralarWidgets.instance.baseUrlForHTTP + Urls.family.familyLoadData);

      final req = http.MultipartRequest('POST', url);
      req.headers.addAll(headersList);
      req.fields.addAll(body);

      final streamedResponse = await req.send();

      if (streamedResponse.statusCode == 200) {
        List<Map<String, String>> data =
            await bytesToListFamiliesDropdownModelDynamic(streamedResponse);
        if (data.isNotEmpty) {
          data = [defaultItem, ...data];
        } else {
          data = [defaultItem];
        }
        return data;
      } else {
        return [defaultItem];
      }
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<FamilyTTS>> bytesToListFamiliesTimeLine(
      http.StreamedResponse streamedResponse) async {
    // Convert streamedResponse to a String
    final responseString = await streamedResponse.stream.bytesToString();

    final response = jsonDecode(responseString);

    final List<dynamic> jsonResponse = response["data"];

    // Map each item in the List<dynamic> to ScheduleDetails
    return jsonResponse.map((item) => FamilyTTS.fromJson(item)).toList();
  }

  Future<List<FamilyLoadData>> bytesToListFamilies(
      http.StreamedResponse streamedResponse) async {
    // Convert streamedResponse to a String
    final responseString = await streamedResponse.stream.bytesToString();

    final response = jsonDecode(responseString);

    final List<dynamic> jsonResponse = response["data"];

    // Map each item in the List<dynamic> to ScheduleDetails
    return jsonResponse.map((item) => FamilyLoadData.fromJson(item)).toList();
  }

  Future<List<Map<String, String>>> bytesToListFamiliesDropdownModelDynamic(
      http.StreamedResponse streamedResponse) async {
    // Convert streamedResponse to a String
    final responseString = await streamedResponse.stream.bytesToString();

    final response = jsonDecode(responseString);

    return convertList(response["data"]);
  }

  String formatText(String input) {
    if (input != '') {
      return Formats.cpfMaskFormatter.maskText(input);
    } else {
      return input;
    }
  }

  List<Map<String, String>> convertList(List<dynamic> jsonList) {
    return jsonList.map((x) {
      return {
        "id": x['id'].toString(),
        "name":
            "Nº ${x['number'].toString()} | ${x['name']} | ${formatText(x['cpf'])}"
      };
    }).toList();
  }

  Future<List<DropdownModel>> bytesToListFamiliesDropdownModel(
      http.StreamedResponse streamedResponse) async {
    // Convert streamedResponse to a String
    final responseString = await streamedResponse.stream.bytesToString();

    final response = jsonDecode(responseString);

    return response["data"];
  }

  Future<FamilyTTS> getDetailTimeline(String familyId, int typeSubject) async {
    try {
      final response = await get(
        "${Urls.tts.timelineData}/$familyId/$typeSubject",
      );
      // print(response.data);
      return FamilyTTS.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<String> nextStage(String familyId) async {
    try {
      final response = await post(Urls.tts.nextStage, body: {"id": familyId});
      return response.data;
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
      print(familyId);
      final response = await get(
        '${Urls.tts.detailsReunionPGM}/$familyId',
      );
      log(response.data.toString());
      return ScheduleDetails.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> changeTypeSubject(FamilyTTS schedule, int typeSubject) async {
    try {
      schedule.typeScheduleStatus = 4;
      schedule.date = (DateTime.now()
                  .toUtc()
                  .subtract(Duration(
                      hours: MoralarWidgets.instance.regionUtcSubstract))
                  .millisecondsSinceEpoch /
              1000)
          .round();
      await post(Urls.family.changeStatusSchedule, body: schedule.toJson());
      await post(
        Urls.tts.changeTypeSubject,
        body: {
          'place': schedule.place,
          'description': schedule.description,
          'date': schedule.date,
          'familyId': schedule.familyId,
          'typeSubject': typeSubject,
          'id': schedule.id,
        },
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> extractReport(String searchTerm, int typeSubject) async {
    try {
      final user = MegaFlutter.instance.auth.currentUser as TTS;
      const filename = 'TimeLine.xlsx';

      http.Response response = await getHttps(
        MoralarWidgets.instance.baseUrlForHTTP,
        Urls.tts.timelineExport,
        {"Authorization": "Bearer ${user.token.accessToken.toString()}"},
        body: {
          "SearchTerm": searchTerm,
          "TypeSubject": typeSubject.toString(),
        },
      );

      final String dir = (await getApplicationDocumentsDirectory()).path;
      final File file = File('$dir/$filename');
      await file.writeAsBytes(response.bodyBytes);
      // OpenFile.open(file.path);
      Share.shareFiles([file.path]);
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
