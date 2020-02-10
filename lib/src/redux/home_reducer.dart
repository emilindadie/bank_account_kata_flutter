
import 'home_state.dart';

HomeState homeReducer(HomeState state, dynamic action) {
    if (action.type == 'consult') {
        state.currentIndex = 0;
        state.title = 'CONSULT';
        return state;
    } else if (action.type == 'manage') {
        state.currentIndex = 1;
        state.title = 'MANAGE';
        return state;
    }
    else if (action.type == 'settings') {
        state.currentIndex = 2;
        state.title = 'SETTINGS';
        return state;
    }
    return state;
}
