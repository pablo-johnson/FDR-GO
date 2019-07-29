import 'dart:io';

import 'package:fdr_go/data/responses/asa_services_response.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String url = Consts.asaBaseUrl;

Future<AsaServicesResponse> getAsaServices() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.get(
    '$url/afterschool/services',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    },
  );
  return asaServicesResponseFromJson(response.body);
}
