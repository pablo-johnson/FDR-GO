import 'dart:async';
import 'dart:io';

import 'package:fdr_go/data/requests/absense_request.dart';
import 'package:fdr_go/data/responses/absense_response.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String url = Consts.busBaseUrl;

Future<AbsenceResponse> registerAbsence(
    int studentId, String dateFrom, String dateTo, String observation) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  print(token);
  AbsenceRequest request = new AbsenceRequest(
    studentId: studentId,
    dateFrom: dateFrom,
    dateTo: dateTo,
    observation: observation,
  );
  final response =
      await http.post('$url/trasportation/services/request/nogetbus',
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ' + token
          },
          body: absenceRequestToJson(request));
  return absenceResponseFromJson(response.body);
}
