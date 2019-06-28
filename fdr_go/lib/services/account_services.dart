import 'dart:async';
import 'dart:io';

import 'package:fdr_go/data/requests/create_account_request.dart';
import 'package:fdr_go/data/responses/create_account_response.dart';
import 'package:http/http.dart' as http;

String url = 'http://161.132.77.40/Synergy.Tra.App/api/v1';

Future<CreateAccountResponse> createAccount(
    CreateAccountRequest request) async {
  final response = await http.post('$url/education/accounts/add',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: createAccountRequestToJson(request));
  return createAccountResponseFromJson(response.body);
}
