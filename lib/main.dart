import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:moralar_widgets/models/answer_adapter.dart';
import 'package:moralar_widgets/models/description_adapter.dart';
import 'package:moralar_widgets/models/family_tts_adapter.dart';
import 'package:moralar_widgets/models/question_response_adapter.dart';
import 'package:moralar_widgets/models/quiz_details_adapter.dart';
import 'package:moralar_widgets/models/schedule_details_adapter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive
    ..init(documentDirectory.path)
    ..registerAdapter(QuizDetailsAdapter())
    ..registerAdapter(QuestionResponseAdapter())
    ..registerAdapter(DescriptionAdapter())
    ..registerAdapter(FamilyTTSAdapter())
    ..registerAdapter(ScheduleDetailsAdapter())
    ..registerAdapter(AnswerAdapter());
  await MoralarWidgets.initialize(
    userType: UserType.tts,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Moralar TTS",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: makeAppTheme(),
    ),
  );
}
