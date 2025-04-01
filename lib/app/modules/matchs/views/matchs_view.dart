import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/matchs_controller.dart';

class MatchsView extends GetView<MatchsController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Matchs',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Obx(() {
                return Column(
                  children: [
                    FilterCard(
                      search: controller.search,
                      isGeneralSearch: true,
                      isMatch: true,
                      onPressed: () {
                        print(controller.search.text);
                        controller.loadMatchs(controller.search.text.isNotEmpty
                            ? controller.search.text
                            : "");
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: MoralarButton(
                        onPressed: () {
                          controller.extractReport(controller.search.text);
                        },
                        child: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Extrair Relatório',
                                  style: textTheme.labelLarge,
                                ),
                              ),
                      ),
                    ),
                    Visibility(
                      visible: controller.isLoading.value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 128),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      replacement: Visibility(
                        visible: controller.matchs.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              List.generate(controller.matchs.length, (index) {
                            return MatchCard(
                              match: controller.matchs[index],
                            );
                          }),
                        ),
                        replacement: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 128),
                          child: Text(
                            'Nenhum match encontrado.\n\nPesquise acima.',
                            style: textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
