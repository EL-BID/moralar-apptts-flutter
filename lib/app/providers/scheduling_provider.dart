import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:http/http.dart' as http;

class SchedulingProvider extends RemoteProvider {
  Future<List<ScheduleDetails>> getSchedulings(
      bool started,
      String search,
      Map<String, String> searchList,
      String searchStatus,
      String searchType,
      DateTimeRange? searchRangeDates) async {
    final user = MegaFlutter.instance.auth.currentUser as TTS;
    final String token = user.token.accessToken.toString();

    try {
      final headersList = {'Accept': '*/*', 'Authorization': 'Bearer $token'};

      final url = Uri.parse(MoralarWidgets.instance.baseUrlForHTTP +
          Urls.family.scheduleLoadData);

      final body = {
        'columns[0][data]': 'date',
        'columns[0][name]': 'Date',
        'columns[0][searchable]': 'false',
        'columns[1][data]': 'typeScheduleStatus',
        'columns[1][name]': 'TypeScheduleStatus',
        'columns[1][searchable]': 'true',
        'start': '0',
        'length': started ? '20' : '1000',
        'order[0][column]': '0',
        'order[0][dir]': 'desc',
        'search[value]': search,
        'number': searchList.containsKey('holderNumber')
            ? searchList['holderNumber']!
            : "",
        'holderName': searchList.containsKey('holderName')
            ? searchList['holderName']!
            : "",
        'holderCpf':
            searchList.containsKey('holderCpf') ? searchList['holderCpf']! : "",
        'status': searchStatus != '-1' ? searchStatus : '',
        'type': searchType != '-1' ? searchType : '',
        'startDate': searchRangeDates != null
            ? MoralarDate.simpleFormatDateToNumber(
                    MoralarDate.convertDateTimeToStartDate(
                        searchRangeDates.start))
                .toString()
            : '',
        'endDate': searchRangeDates != null
            ? (MoralarDate.itsSameDay(
                    searchRangeDates.start, searchRangeDates.end)
                ? ''
                : MoralarDate.simpleFormatDateToNumber(
                        MoralarDate.convertDateTimeToEndDate(
                            searchRangeDates.end))
                    .toString())
            : ''
      };

      final req = http.MultipartRequest('POST', url);
      req.headers.addAll(headersList);
      req.fields.addAll(body);

      final streamedResponse = await req.send();

      if (streamedResponse.statusCode == 200) {
        List<ScheduleDetails> scheduleDetailsList =
            await bytesToListOfScheduleDetails(streamedResponse);
        return scheduleDetailsList;
      } else {
        return [];
      }
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<ScheduleDetails>> getTimeLine(String id) async {
    try {
      final endpoint = Urls.family.schedulingTimeLine;
      final response = await get('$endpoint/$id');
      print("STATUS: " + response.data.toString());
      return (response.data as List)
          .map((item) => ScheduleDetails.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<ScheduleDetails>> getSchedulingHistory(String id) async {
    try {
      final endpoint = Urls.family.schedulingHistory;
      final response = await get('$endpoint/$id');
      print("STATUS: " + response.data.toString());
      return (response.data as List)
          .map((item) => ScheduleDetails.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<ScheduleDetails> getSchedulingDetails(String id) async {
    try {
      final endpoint = Urls.family.schedulingDetails;
      final response = await get('$endpoint/$id');
      return ScheduleDetails.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> editStatus(ScheduleDetails schedule) async {
    try {
      await post(Urls.family.changeStatusSchedule, body: schedule.toJson());
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<ScheduleDetails>> bytesToListOfScheduleDetails(
      http.StreamedResponse streamedResponse) async {
    // Convert streamedResponse to a String
    final responseString = await streamedResponse.stream.bytesToString();

    final response = jsonDecode(responseString);

    final List<dynamic> jsonResponse = response["data"];

    // Map each item in the List<dynamic> to ScheduleDetails
    return jsonResponse.map((item) => ScheduleDetails.fromJson(item)).toList();
  }

  Future<ValidationMessage> registerSchedule(
      RegisterSchedule createdData) async {
    try {
      final response = await post(
        Urls.tts.registerSchedule,
        body: createdData.toJson(),
      );
      return ValidationMessage(true, response.data.toString());
    } on MegaResponseException catch (e) {
      return ValidationMessage(false, e.message.toString());
    }
  }
}
