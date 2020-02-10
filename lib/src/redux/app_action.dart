
import 'auth_action.dart';
import 'home_action.dart';

class AppAction {
  AuthAction authAction;
  HomeAction homeAction;

  AppAction({this.authAction, this.homeAction});
  AppAction.create(this.authAction, this.homeAction);
}