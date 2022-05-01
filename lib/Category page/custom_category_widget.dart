import 'package:money_manager_app/Hive/HiveClass/database.dart';

List<List<Transactions>> incomeorExpense(List<Transactions> list) {
  List<Transactions> incomeList = [];
  List<Transactions> expenseList = [];
  List<List<Transactions>> transactionsList = [incomeList, expenseList];
  for (int i = 0; i < list.length; i++) {
    if (list[i].type == true) {
      incomeList.add(list[i]);
    } else {
      expenseList.add(list[i]);
    }
  }
  return transactionsList;
}
