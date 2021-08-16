import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/matchs_controller.dart';

class MatchsView extends GetView<MatchsController> {
  @override
  Widget build(BuildContext context) {
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Matchs',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const FilterCard(isMatch: true),
              Column(
                children: List.generate(3, (index) => const MatchCard()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
