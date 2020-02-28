import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';
import 'package:bank_account_kata_flutter/src/blocs/consult_bloc.dart';
import 'package:bank_account_kata_flutter/src/blocs/manage_bloc.dart';
import 'package:bank_account_kata_flutter/src/redux/app_action.dart';
import 'package:bank_account_kata_flutter/src/redux/app_state.dart';
import 'package:bank_account_kata_flutter/src/redux/auth_action.dart';
import 'package:bank_account_kata_flutter/src/redux/home_action.dart';
import 'package:bank_account_kata_flutter/src/repositories/account_repo.dart';
import 'package:bank_account_kata_flutter/src/repositories/operation_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'consult.dart';
import 'manage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildHomepage();
  }

  List<BottomNavigationBarItem> androidNav() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.credit_card), title: Text('Consult')),
      BottomNavigationBarItem(
          icon: Icon(Icons.call_to_action), title: Text('Manage')),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications), title: Text('Settings')),
    ];
  }

  Scaffold buildHomepage() {
    return Scaffold(
      body: new StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          if (state.authState.user != null) {
            return _widgetOptions(state)[state.homeState.currentIndex];
          } else {
            return Center();
          }
        },
      ),
      bottomNavigationBar: StoreConnector<AppState, Function>(
        converter: (store) {
          return (newType) => store.dispatch(AppAction(
              authAction: AuthAction(type: ''),
              homeAction: HomeAction(type: newType)));
        },
        builder: (context, callback) {
          return new StoreConnector<AppState, int>(
            converter: (store) => store.state.homeState.currentIndex,
            builder: (context, index) {
              return BottomNavigationBar(
                currentIndex: index,
                onTap: (index) {
                  if (index == 0) callback('consult');
                  if (index == 1) callback('manage');
                  if (index == 2) callback('settings');
                },
                items: androidNav(),
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Color(0xFF5274CC),
              );
            },
          );
        },
      ),
    );
  }

  List<Widget> _widgetOptions(AppState state) {
    return [
      MyBlocProvider<ConsultBloc>(
        bloc: ConsultBloc(
            repository: AccountRepository(),
            user: state.authState.user,
            accessToken: state.authState.accessToken),
        child: ConsultPage(title: state.homeState.title),
      ),
      MyBlocProvider<ManageBloc>(
        bloc: ManageBloc(
            accountRepository: AccountRepository(),
            operationRepository: OperationRepository(),
            user: state.authState.user,
            accessToken: state.authState.accessToken),
        child: ManagePage(title: state.homeState.title),
      ),
      Center(),
    ];
  }
}
