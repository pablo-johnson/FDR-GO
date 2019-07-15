import 'dart:async';
import 'dart:io';

import 'package:fdr_go/data/requests/service_request.dart';
import 'package:fdr_go/data/responses/request_service_response.dart';
import 'package:fdr_go/data/responses/service_mode_response.dart';
import 'package:fdr_go/data/responses/services_response.dart';
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

Future<RequestServiceResponse> requestService(int studentId, String dateFrom,
    String dateRequest, String serviceMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  RequestServiceRequest request = new RequestServiceRequest(
      studentId: studentId,
      dateFrom: dateFrom,
      dateRequest: dateRequest,
      serviceMode: serviceMode);
  final response = await http.post('$url/trasportation/services/request',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      },
      body: requestServiceRequestToJson(request));
  return requestServiceResponseFromJson(response.body);
}

Future<ServicesResponse> getServices() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.get(
    '$url/trasportation/services',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token
    },
  );
  return servicesResponseFromJson(response.body);
}

Future<String> getTermsAndConditions(int serviceRequestId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.get(
    '$url/trasportation/services/request/$serviceRequestId/contract/html',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token
    },
  );
  return response.body;
}

Future<RequestServiceResponse> acceptTerms(
    int serviceRequestId, bool accept) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.put(
    '$url/trasportation/services/request/$serviceRequestId/accept?accept=$accept',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token
    },
  );
  return requestServiceResponseFromJson(response.body);
}
