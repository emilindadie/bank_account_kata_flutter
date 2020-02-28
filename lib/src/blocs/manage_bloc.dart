
import 'dart:async';
import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/operation/operation.dart';
import 'package:bank_account_kata_flutter/src/models/operation/operation_create.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/account_repo.dart';
import 'package:bank_account_kata_flutter/src/repositories/operation_repo.dart';
import 'package:bank_account_kata_flutter/src/validators/manage.validators.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_provider.dart';

class ManageBloc with ManageValidators implements BlocBase {

  BehaviorSubject<String> _actionController = BehaviorSubject<String>.seeded("Withdraw");
  Stream<String> get action => _actionController.stream;
  StreamController<List<Account>> _accountController = new StreamController<List<Account>>.broadcast();
  BehaviorSubject<String> _amountController = BehaviorSubject<String>.seeded("0");
  BehaviorSubject<bool> _disabledSubmitController = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<int> _selectedAccountIndexController = BehaviorSubject<int>.seeded(0);
  BehaviorSubject<Account> _selectedAccountController = BehaviorSubject<Account>.seeded(Account());
  Stream<String> get amount => _amountController.stream;
  Stream<bool> get disabledSubmit => _disabledSubmitController.stream.transform(buttonValidator(_amountController));
  Stream<int> get selectedAccountIndex => _selectedAccountIndexController.stream;
  Stream<Account> get selectedAccount => _selectedAccountController.stream;
  Stream<List<Account>> get accounts => _accountController.stream;

  Function(String) get updateAmount {
    _disabledSubmitController.sink.add(true);
    return _amountController.sink.add;
  }

  Function(int) get updateSelectedAccountIndex => _selectedAccountIndexController.sink.add;

  Function(String) get updateAction => _actionController.sink.add;
  Function(Account) get updateSelectedAccount => _selectedAccountController.sink.add;

  AccountRepository accountRepository;
  OperationRepository operationRepository;

  User user;
  String accessToken;

  ManageBloc({this.accountRepository, this.operationRepository, this.user, this.accessToken}){
    loadAccounts();
  }

  void dispose(){
    _actionController.close();
  }

  void loadAccounts() async {
    accountRepository.loadAccounts(user.id, accessToken).then((accounts) {
      _accountController.sink.add(List.unmodifiable(accounts));
    });
  }

  Future<Operation> createOperation(int amount, int accountId) async {
    return operationRepository.createOperation(CreateOperation.create(accountId, amount), accessToken);
  }

}