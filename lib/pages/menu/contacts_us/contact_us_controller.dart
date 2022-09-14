import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  static ContactUsController get() => Get.find();

  ContactUsController();

  static ContactUsController? _this;

  static ContactUsController? get controller => _this;

  Future<void> didTapSendEmail() async {
    final mailtoUri = Uri(
        scheme: 'mailto',
        path: 'example@example.com',
        queryParameters: {'subject': 'Example'});

    _launchUri(mailtoUri);
  }

  Future<void> didTapWebsite() async {
    const url = 'https://www.google.de/';
    _launchUri(Uri.parse(url));

  }

  Future<void> didTapCall() async {
    String phoneNumber = "+4112343331231";
    final url = "tel:$phoneNumber";

    _launchUri(Uri.parse(url));
  }

  Future<void> _launchUri(Uri uri) async {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $uri';
    }
  }
}