import 'package:get/get.dart';
import 'package:zomm_clone/app/modules/home/controllers/jitsi_meeting_controller.dart';

import '../controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<JitsiMeetingController>(() => JitsiMeetingController(),
        fenix: true);
  }
}
