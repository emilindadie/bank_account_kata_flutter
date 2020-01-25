
import 'package:bank_account_kata_flutter/src/redux/auth_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    authState: authReducer(state.authState, action.authAction),
  );
}
