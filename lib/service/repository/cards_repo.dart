import '../../constants/app_urls.dart';
import '../request_builder.dart';

class CardsRepo extends ReguestBuilder {
  CardsRepo();

  Future<JsonResponse> getCardList() async {
    return await preformRequest(type: RequestType.get, url: AppUrl.GET_CARDS);
  }
}


