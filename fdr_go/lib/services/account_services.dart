import 'dart:async';
import 'dart:io';

import 'package:fdr_go/data/requests/create_account_request.dart';
import 'package:fdr_go/data/requests/forgot_password_request.dart';
import 'package:fdr_go/data/requests/login_request.dart';
import 'package:fdr_go/data/responses/common_response.dart';
import 'package:fdr_go/data/responses/create_account_response.dart';
import 'package:fdr_go/data/responses/login_response.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String url = Consts.baseUrl;

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

Future<CommonResponse> forgotPassword(ForgotPasswordRequest request) async {
  final response = await http.post('$url/education/accounts/recovery',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: forgotPasswordRequestToJson(request));
  return commonResponseFromJson(response.body);
}

Future<LoginResponse> login(String username, String password) async {
  LoginRequest request = new LoginRequest(
    username: username,
    password: password,
    appId: Consts.appId,
  );
  final response = await http.post('$url/education/accounts/authenticate',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: loginRequestToJson(request));
  LoginResponse loginResponse = loginResponseFromJson(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('authToken', loginResponse.token);
  return loginResponse;
}
