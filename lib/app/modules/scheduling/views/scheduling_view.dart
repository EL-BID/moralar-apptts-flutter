import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../../rescheduling/controllers/rescheduling_controller.dart';
import '../controllers/scheduling_controller.dart';

class SchedulingView extends GetView<SchedulingController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget _openSheduling(ScheduleDetails schedule) {
      return Column(
        children: [
          Container(
            height: 128,
            width: 128,
            child: MoralarImage.asset(Assets.images.agendamento),
          ),
          const SizedBox(height: 64),
          DetailScheduleCard(
            scheduleDetails: schedule,
            function: () {},
            onReschedule: () {
              Get.find<ReSchedulingController>().receiveData(schedule);
              Get.toNamed(Routes.RESCHEDULING);
            },
            onCancel: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Confirmação',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                    content: const Text('Deseja cancelar esse agendamento?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Não',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Sim, cancelar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.purple,
                            )),
                        onPressed: () {
                          controller.handleChangeStatusSchedule(schedule, 5);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      );
    }

    Widget _finalizedSheduling() {
      return FinalizedCard(schedule: controller.scheduling.value);
    }

    return Obx(() => MoralarScaffold(
          appBar: MoralarAppBar(
            titleText: 'Detalhes do agendamento',
            backgroundColor: Scheduling.statusColor(
                controller.scheduling.value.typeScheduleStatus!),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              child: Visibility(
                visible: controller.isLoading.value,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 256),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Scheduling.statusColor(
                          controller.scheduling.value.typeScheduleStatus!),
                    ),
                  ),
                ),
                replacement:
                    controller.scheduling.value.typeScheduleStatus! != 4
                        ? _openSheduling(controller.scheduling.value)
                        : _finalizedSheduling(),
              ),
            ),
          ),
        ));
  }
}
