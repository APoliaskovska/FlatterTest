import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';

import '../../../service/repository/cards_repo.dart';
import '../../../utils/event.dart';

class SearchTransactionController extends GetxController with StateMixin {
  static SearchTransactionController get() => Get.find();

  final CardsRepo cardsRepo;

  SearchTransactionController({required this.cardsRepo});

  final RxList _transactions = [].obs;
  final RxList _filterTransactions = [].obs;
  final RxList _filterDate = [].obs;

  RxList get transactions => _transactions;
  RxList get filterTransactions => _filterTransactions;
  RxList get filterDate => _filterDate;

  @override
  void onInit() async {
    super.onInit();
    var data = Get.arguments;
    print("DATA TRANSACTIONS" + data.toString());
    if (data != null){
      _transactions.clear();
      _transactions.addAll(data);

      _filterTransactions.clear();
      _filterTransactions.addAll(data);
    }
  }

  void runFilter(String enteredKey) {
    List<dynamic>? result = [];
    if (enteredKey.isEmpty) {
      result = transactions.toList();
    } else {
      result = transactions.where((tr) {
        return (tr as Transaction).referenceNumber.toLowerCase().contains(enteredKey.toLowerCase());
      }).toList();
    }
    _filterTransactions(result);
  }

  List<Event> getEventsForDay(DateTime day) {
    List<dynamic> list = _transactions.where((tr) {
      DateTime date = DateFormat("dd/MM/yyyy hh:mm").parse((tr as Transaction).date);
      bool checkData = date.year == day.year && date.month == day.month
          && date.day == day.day;
      return checkData;
    }).toList();
    return list.map((e) {
      Event event = Event((e as Transaction).referenceNumber);
      return event;
    }).toList();
  }

  DateTime focusDate(){
    List<DateTime> list = _transactions.map((tr) {
      return DateFormat("dd/MM/yyyy hh:mm").parse((tr as Transaction).date);
    }).toList();
    list.sort((a,b) => a.compareTo(b));
    return list.last;
  }

  void didTapDay(DateTime date){
    List<dynamic> dateList = filterDate.toList();
    if (filterDate.contains(date)){
      dateList.add(date);
    } else {
      dateList.remove(date);
    }
    _filterDate(dateList);
  }

  bool isDaySelected(DateTime date){
    for (int i = 0; i < filterDate.length; i++) {
      if (_compareDates(filterDate[i], date)) {
        return true;
      }
    }
    return false;
  }

  //HELPERS

  bool _compareDates(DateTime date1, DateTime date2){
    return date1.year == date2.year && date1.month == date2.month
        && date1.day == date2.day;
  }
}