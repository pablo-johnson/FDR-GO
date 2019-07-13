import 'dart:async';
import 'dart:io';

import 'package:fdr_go/data/responses/service_mode_response.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String url = Consts.baseUrl;

Future<ServiceModeResponse> getServiceModes() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.get(
    '$url/schema/query/syn.tra.parameter.service_modes',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token
    },
  );
  return serviceModeResponseFromJson(response.body);
}
