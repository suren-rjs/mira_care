
import 'package:get/get.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class ScreenController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewController());
  }
}