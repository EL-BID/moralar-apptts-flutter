import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              MoralarButton(
                function: () {
                  Get.toNamed(Routes.EDIT);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Editar Perfil',
                    style: textTheme.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
