
class CreateOperation {
  int amount;
  int accountId;

  CreateOperation({this.accountId, this.amount});
  CreateOperation.create(this.accountId, this.amount);

  CreateOperation.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId.toString();
    data['amount'] =  this.amount.toString();
    return data;
  }
}
