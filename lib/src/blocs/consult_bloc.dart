import 'dart:async';
import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/account/account_create.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/account_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_provider.dart';

class ConsultBloc implements BlocBase {

  BehaviorSubject<String> _createAccountController = BehaviorSubject<String>.seeded("");
  StreamController<List<Account>> _accountController = new StreamController<List<Account>>.broadcast();
  Stream<List<Account>> get accounts => _accountController.stream;

  Stream<String> get account => _createAccountController.stream;
  Function(String) get updateAccount => _createAccountController.sink.add;

  AccountRepository repository;

  User user;
  String accessToken;

  ConsultBloc({this.repository, this.user, this.accessToken}){
    loadAccounts();
  }


  void dispose(){
    _accountController.close();
  }

  resetPopup(){
    _createAccountController.sink.add('');
  }

  void loadAccounts() async {
    repository.loadAccounts(user.id, accessToken).then((accounts) {
      _accountController.sink.add(List.unmodifiable(accounts));
    });
  }

  void refresh() async {
    repository.loadAccounts(user.id, accessToken).then((accounts) {
      _accountController.sink.add(List.unmodifiable(accounts));
    });
  }

  Future<Account> createAccount(String name, User user) async {
    return repository.createAccount(CreateAccount.create(name, user), accessToken);
  }
}