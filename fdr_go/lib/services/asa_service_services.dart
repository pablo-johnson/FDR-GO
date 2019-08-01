import 'dart:io';

import 'package:fdr_go/data/requests/save_activities_request.dart';
import 'package:fdr_go/data/requests/save_activity_request.dart';
import 'package:fdr_go/data/responses/activities_response.dart';
import 'package:fdr_go/data/responses/asa_services_response.dart';
import 'package:fdr_go/data/responses/common_response.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

Future<ActivitiesResponse> getAsaActivities(
    int studentId, int frequency) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.get(
    '$url/afterschool/services/$studentId/applications/$frequency',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    },
  );
  return activitiesResponseFromJson(response.body);
}

Future<CommonResponse> saveAsaActivities(int studentId, int frequency,
    SaveActivitiesRequest saveActivitiesRequest) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.post(
      '$url/afterschool/services/$studentId/applications/$frequency',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: saveActivitiesRequestToJson(saveActivitiesRequest));
  return commonResponseFromJson(response.body);
}

Future<CommonResponse> saveAsaActivity(
    int studentId, int frequency, SaveActivityRequest activityRequest) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.post(
      '$url/afterschool/services/$studentId/registration/$frequency',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: saveActivityRequestToJson(activityRequest));
  return commonResponseFromJson(response.body);
}
