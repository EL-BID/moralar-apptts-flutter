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
                      searchFamily: controller.familySearch,
                      searchProperty: controller.propertySearch,
                      isMatch: true,
                      onPressed: () {
                        print(controller.familySearch.text);
                        print(controller.propertySearch.text);
                        controller.searchMatchs();
                      },
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
                            style: textTheme.headline1,
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
