import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/app_urls.dart';

class CardsRepo extends GetxService {
  CardsRepo();

  var token = "";

  Future<http.Response> getCardList() async {
    http.Response res = await http.get(
      Uri.parse(AppUrl.GET_CARDS),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return res;
  }
}
