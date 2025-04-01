import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:share/share.dart';

class MatchsProvider extends RemoteProvider {
  Future<bool> extractReport(String search) async {
    try {
      final user = MegaFlutter.instance.auth.currentUser as TTS;
      const filename = 'Matchs - Lista de Relatório.xlsx';

      http.Response response = await postHttps(
        MoralarWidgets.instance.baseUrlForHTTP,
        Urls.tts.matchExport,
        {"Authorization": "Bearer ${user.token.accessToken.toString()}"},
        body: {
          "columns[0][data]": "holderNumber",
          "columns[0][name]": "HolderNumber",
          "columns[0][searchable]": "true",
          "columns[1][data]": "holderName",
          "columns[1][name]": "HolderName",
          "columns[1][searchable]": "true",
          "columns[2][data]": "holderCpf",
          "columns[2][name]": "HolderCpf",
          "columns[2][searchable]": "true",
          "columns[3][data]": "residencialCode",
          "columns[3][name]": "ResidencialCode",
          "columns[3][searchable]": "true",
          "start": "0",
          "length": "1000",
          "order[0][column]": "1",
          "order[0][dir]": "asc",
          "search[value]": search,
          "holderNumber": "",
          "holderName": "",
          "holderCpf": "",
          "residencialCode": "",
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

  Future<List<Match>> getMatchs(Map<String, String> body) async {
    final user = MegaFlutter.instance.auth.currentUser as TTS;
    final String token = user.token.accessToken.toString();

    try {
      final headersList = {'Accept': '*/*', 'Authorization': 'Bearer $token'};

      final url = Uri.parse(
          MoralarWidgets.instance.baseUrlForHTTP + Urls.tts.loadMatchsTTS);

      final req = http.MultipartRequest('POST', url);
      req.headers.addAll(headersList);
      req.fields.addAll(body);

      final streamedResponse = await req.send();

      if (streamedResponse.statusCode == 200) {
        return await bytesToListMatchs(streamedResponse);
      } else {
        return [];
      }
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<Property>> getMatchsByFamilyId(String id) async {
    try {
      final response = await get(
        "${Urls.tts.matchsFamily}/$id",
      );
      print(response.data);
      return (response.data as List)
          .map((item) => Property.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<Match>> bytesToListMatchs(
      http.StreamedResponse streamedResponse) async {
    // Convert streamedResponse to a String
    final responseString = await streamedResponse.stream.bytesToString();

    final response = jsonDecode(responseString);

    final List<dynamic> jsonResponse = response["data"];

    // Map each item in the List<dynamic> to ScheduleDetails
    return jsonResponse.map((item) => Match.fromJson(item)).toList();
  }
}
