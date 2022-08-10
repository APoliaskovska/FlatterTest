import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pbgrpc.dart';
import 'package:build_grpc_channel/build_grpc_channel.dart';

const host = 'http://127.0.0.1';

int get port => kIsWeb ? 8888 : 5555;

class MainService extends GetxService {
  late final SampleClient stub;

  MainService(){
    print("port = " + port.toString() + " host = " + host);
    stub = SampleClient(buildGrpcChannel(host: host, port: port, secure: false));
  }

  Future<dynamic> getUserCards(User user) async {
    print("call getUserCards()");
    return await stub.getCards(user);
  }

  Future<dynamic> getUserDetails() async {
    print("call getUserCards()");
    return await stub.getUserDetails(User(id: 1));
  }
}