import 'package:get/get.dart';
import 'package:mira_care/resources/controller/notes_controller.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class InitRequiredControllers extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewController());
    Get.lazyPut(() => NotesController());
  }
}
