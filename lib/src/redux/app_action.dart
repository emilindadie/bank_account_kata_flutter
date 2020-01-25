
import 'auth_action.dart';

class AppAction {
  AuthAction authAction;

  AppAction({this.authAction});
  AppAction.create(this.authAction);
}