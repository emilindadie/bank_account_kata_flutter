
import 'auth_state.dart';

AuthState authReducer(AuthState state, dynamic action) {
    if (action.type == 'load_user') {
      state.isAuthenticated = true;
      state.user = action.user;
      state.accessToken = action.accessToken;
      return state;
    } else if (action.type == 'log_out') {
      state.isAuthenticated = false;
      state.user = null;
      state.accessToken = "";
      return state;
    }
    return state;
}
