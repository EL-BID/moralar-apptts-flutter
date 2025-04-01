import 'package:get/get.dart';

import '../../../providers/profile_provider.dart';
import '../../../providers/registration_data_provider.dart';
import '../../../providers/scheduling_provider.dart';
import '../controllers/schedulings_controller.dart';

class SchedulingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchedulingsController>(
      SchedulingsController.new,
    );
    Get.lazyPut<RegistrationDataProvider>(
      RegistrationDataProvider.new,
    );
    Get.lazyPut<SchedulingProvider>(
      SchedulingProvider.new,
    );
    Get.lazyPut<ProfileProvider>(
      ProfileProvider.new,
    );
  }
}
