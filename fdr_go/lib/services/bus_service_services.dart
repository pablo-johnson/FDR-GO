import 'dart:async';
import 'dart:io';

import 'package:fdr_go/data/requests/service_request.dart';
import 'package:fdr_go/data/responses/bus_services_response.dart';
import 'package:fdr_go/data/responses/common_response.dart';
import 'package:fdr_go/data/responses/service_mode_response.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String url = Consts.busBaseUrl;

Future<ServiceModeResponse> getBusServiceModes() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  String languageCode = prefs.getString("languageCode");
  final response = await http.get(
    '$url/schema/query/syn.tra.parameter.service_modes',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token,
      HttpHeaders.acceptLanguageHeader: languageCode
    },
  );
  return serviceModeResponseFromJson(response.body);
}

Future<CommonResponse> requestBusService(int studentId, String dateFrom,
    String dateRequest, String serviceMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  String languageCode = prefs.getString("languageCode");
  RequestServiceRequest request = new RequestServiceRequest(
      studentId: studentId,
      dateFrom: dateFrom,
      dateRequest: dateRequest,
      serviceMode: serviceMode);
  final response = await http.post('$url/trasportation/services/request',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
        HttpHeaders.acceptLanguageHeader: languageCode
      },
      body: requestServiceRequestToJson(request));
  return commonResponseFromJson(response.body);
}

Future<BusServicesResponse> getBusServices() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  String languageCode = prefs.getString("languageCode");
  final response = await http.get(
    '$url/trasportation/services',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token,
      HttpHeaders.acceptLanguageHeader: languageCode
    },
  );
  return servicesResponseFromJson(response.body);
}

Future<String> getTermsAndConditions(int serviceRequestId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  String languageCode = prefs.getString("languageCode");
  final response = await http.get(
    '$url/trasportation/services/request/$serviceRequestId/contract/html',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token,
      HttpHeaders.acceptLanguageHeader: languageCode
    },
  );
  return response.body;
}

Future<CommonResponse> acceptTerms(int serviceRequestId, bool accept) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  String languageCode = prefs.getString("languageCode");
  final response = await http.put(
    '$url/trasportation/services/request/$serviceRequestId/accept?accept=$accept',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token,
      HttpHeaders.acceptLanguageHeader: languageCode
    },
  );
  return commonResponseFromJson(response.body);
}
