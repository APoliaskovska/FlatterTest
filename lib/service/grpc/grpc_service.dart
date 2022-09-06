import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pbgrpc.dart';
import 'package:build_grpc_channel/build_grpc_channel.dart';

//const host = 'http://127.0.0.1';// for iOS
const host = 'http://172.20.10.5'; // for Android build

int get port => kIsWeb ? 8888 : 5555;

class MainService extends GetxService {
  late final SampleClient stub;

  MainService(){
    print("port = " + port.toString() + " host = " + host);
    stub = SampleClient(buildGrpcChannel(host: host, port: port, secure: false));
  }

  //AUTH

  Future<dynamic> loginWith(String login, String password) async {
    return await stub.loginWith(AuthRequest(login: login, password: password));
  }

  //CARDS

  Future<dynamic> getUserCards(User user) async {
    return await stub.getCards(user);
  }

  Future<dynamic> getUserDetails() async {
    return await stub.getUserDetails(User(id: 1));
  }

  Future<dynamic> getUserAvatar() async {
    return await stub.getUserAvatar(User(id: 1));
  }

  Future<dynamic> getTransactions(int cardId) async {
    return await stub.getTransactionsList(TransactionsListRequest(cardId: cardId));
  }

  //UPLOAD

  Future<dynamic> uploadDocs(List<PlatformFile> docs) async {
    dynamic error;
    bool success = true;
    for (PlatformFile doc in docs) {
       FileUploadChunkRequest request = FileUploadChunkRequest(
         uuid: UniqueKey().toString(),
         name: DateTime.now().toString() + doc.name,
         type: doc.extension
       );
       await stub.uploadFileChunk(request).then((p0) => null, onError: (e){
         error = e;
         success = false;
       });
     }
    print("Upload doc result = " + success.toString() + " error = " + error.toString());
    return success ? true : error;
  }

  //FOLDERS & FILES

  Future<dynamic> getFolders(String userId) async {
    return stub.getFileFolders(FileFoldersRequest(userId: userId));
  }

  Future<dynamic> getFolderFiles(String userId, String folderId) async {
    return stub.getFilesFromFolder(FilesFromFoldersRequest(userId: userId, folderId: folderId));
  }

  Stream<FileData> downloadFile(String userId, String fileId) {
    return stub.downloadFile(DownloadFileRequest(userId: userId, fileId: fileId));
  }
}