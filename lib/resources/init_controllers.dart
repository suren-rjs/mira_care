import 'package:get/get.dart';
import 'package:mira_care/resources/controller/auth_controller.dart';
import 'package:mira_care/resources/controller/event_controller.dart';
import 'package:mira_care/resources/controller/notes_controller.dart';
import 'package:mira_care/resources/controller/remainder_controller.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class InitRequiredControllers extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ViewController());
    Get.lazyPut(() => NotesController());
    Get.lazyPut(() => RemainderController());
    Get.lazyPut(() => EventController());
  }
}
