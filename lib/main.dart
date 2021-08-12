import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await MoralarWidgets.initialize(
    userType: UserType.tts,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: makeAppTheme(),
    ),
  );
}
