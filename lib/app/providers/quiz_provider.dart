import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class QuizProvider extends RemoteProvider {
  Future<http.StreamedResponse> getResponseQuizedLoadDataByDropdown(
      String search) async {
    final defaultItem = {'id': '-1', 'name': 'Selecione'};
    final user = MegaFlutter.instance.auth.currentUser as TTS;
    final String token = user.token.accessToken.toString();

    final body = {
      'columns[0][data]': 'number',
      'columns[0][name]': 'Number',
      'columns[0][searchable]': 'false',
      'start': '0',
      'length': '10',
      'order[0][column]': '0',
      'order[0][dir]': 'asc',
      'search[value]': search,
      'number': '',
      'holderName': '',
      'holderCpf': '',
      'status': '',
    };

    try {
      final headersList = {'Accept': '*/*', 'Authorization': 'Bearer $token'};

      final url = Uri.parse(
          MoralarWidgets.instance.baseUrlForHTTP + Urls.family.quizLoadData);

      final req = http.MultipartRequest('POST', url);
      req.headers.addAll(headersList);
      req.fields.addAll(body);

      final streamedResponse = await req.send();

      return streamedResponse;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<QuizLoadData>> getQuizLoadData(String search) async {
    final user = MegaFlutter.instance.auth.currentUser as TTS;
    final String token = user.token.accessToken.toString();

    try {
      final headersList = {'Accept': '*/*', 'Authorization': 'Bearer $token'};

      final url = Uri.parse(
          MoralarWidgets.instance.baseUrlForHTTP + Urls.family.quizLoadData);

      final body = {
        'columns[0][data]': 'number',
        'columns[0][name]': 'Number',
        'columns[0][searchable]': 'false',
        'start': '0',
        'length': '10',
        'order[0][column]': '0',
        'order[0][dir]': 'asc',
        'search[value]': search,
        'number': '',
        'holderName': '',
        'holderCpf': '',
        'status': '',
      };

      final req = http.MultipartRequest('POST', url);
      req.headers.addAll(headersList);
      req.fields.addAll(body);

      final streamedResponse = await req.send();

      if (streamedResponse.statusCode == 200) {
        final List<QuizLoadData> scheduleDetailsList =
            await bytesToListOfQuizLoadData(streamedResponse);
        return scheduleDetailsList;
      } else {
        return [];
      }
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<QuizLoadData>> bytesToListOfQuizLoadData(
      http.StreamedResponse streamedResponse) async {
    // Convert streamedResponse to a String
    final responseString = await streamedResponse.stream.bytesToString();

    final response = jsonDecode(responseString);

    final List<dynamic> jsonResponse = response["data"];

    // Map each item in the List<dynamic> to ScheduleDetails
    // ignore: unnecessary_lambdas
    return jsonResponse.map((item) => QuizLoadData.fromJson(item)).toList();
  }

  static Future<List<Map<String, String>>> getDropdownDataBySResponse(
      String streamString) async {
    final defaultItem = {'id': '-1', 'name': 'Selecione'};
    List<Map<String, String>> dataDropdown =
        await QuizProvider.bytesToListDropdownModelDynamic(streamString);
    if (dataDropdown.isNotEmpty) {
      dataDropdown = [defaultItem, ...dataDropdown];
    }
    return dataDropdown;
  }

  static Future<List<Map<String, String>>> bytesToListDropdownModelDynamic(
      String streamString) async {
    final response = jsonDecode(streamString);

    return convertList(response["data"]);
  }

  static Future<List<QuizLoadData>> bytesToListQuizLoadData(
      String streamString) async {
    // Convert streamedResponse to a String
    final response = jsonDecode(streamString);

    final List<dynamic> jsonResponse = response["data"];

    // Map each item in the List<dynamic> to ScheduleDetails
    return jsonResponse.map((item) => QuizLoadData.fromJson(item)).toList();
  }

  static List<Map<String, String>> convertList(List<dynamic> jsonList) {
    return jsonList.map((x) {
      return {"id": x['id'].toString(), "name": "${x['title']}"};
    }).toList();
  }

  Future<List<Quiz>> getQuiz() async {
    try {
      final response = await get(
        "${Urls.tts.quiz}1",
        queryParameters: {
          'typeQuiz': 'Quiz',
        },
      );
      print(response.data);
      return (response.data as List)
          // ignore: unnecessary_lambdas
          .map((item) => Quiz.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<QuizDetails> getQuizDetails(String id) async {
    try {
      final response = await get(
        '${Urls.family.quizDetails}/$id',
      );
      return QuizDetails.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<AnswerDetails>> getAnswerDetails(
      String quizId, String familyId) async {
    print(Urls.tts.responseByFamily);
    print({
      'familyId': familyId,
      'quizId': quizId,
    }.toString());
    try {
      final response = await get(
          "${Urls.tts.responseByFamily}?quizId=$quizId&familyId=$familyId");
      print(response.data);
      return (response.data as List)
          // ignore: unnecessary_lambdas
          .map((item) => AnswerDetails.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      print(e);
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> registerQuiz(
      String familyId, String quizId, List<Answer> answers) async {
    try {
      await post(
        Urls.family.registerQuiz,
        body: {
          'familyId': familyId,
          'responsibleForResponsesId': familyId,
          'quizId': quizId,
          'questions': answers.map((e) => e.toJson()).toList(),
        },
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
