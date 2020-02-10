
import 'auth_state.dart';

import 'home_state.dart';

class AppState {
  AuthState authState;
  HomeState homeState;

  AppState({this.authState, this.homeState});
}