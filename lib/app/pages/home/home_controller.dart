import 'package:cc_uffs/app/utils/app_drawer_controller.dart';
import 'package:cc_uffs/app/utils/default_controller.dart';
import 'package:cc_uffs/session.dart';
import 'package:navigate/navigate.dart';

class HomeController extends DefaultController implements AppDrawerController {
  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  @override
  void logOff() {
    Session.user = null;
    navigateTo('login', ReplaceRoute.all);
  }
}