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

String url = Consts.busBaseUrl;

Future<CreateAccountResponse> createAccount(
    CreateAccountRequest request) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString("languageCode");
  final response = await http.post('$url/education/accounts/add',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '',
        HttpHeaders.acceptLanguageHeader: languageCode
      },
      body: createAccountRequestToJson(request));
  return createAccountResponseFromJson(response.body);
}

Future<CommonResponse> forgotPassword(ForgotPasswordRequest request) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString("languageCode");
  final response = await http.post('$url/education/accounts/recovery',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '',
        HttpHeaders.acceptLanguageHeader: languageCode
      },
      body: forgotPasswordRequestToJson(request));
  return commonResponseFromJson(response.body);
}

Future<LoginResponse> login(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString("languageCode");
  LoginRequest request = new LoginRequest(
    username: username,
    password: password,
    appId: Consts.appId,
  );
  final response = await http.post('$url/education/accounts/authenticate',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '',
        HttpHeaders.acceptLanguageHeader: languageCode
      },
      body: loginRequestToJson(request));
  LoginResponse loginResponse = loginResponseFromJson(response.body);
  await prefs.setString('authToken', loginResponse.token);
  return loginResponse;
}

Future<CommonResponse> logout(CreateAccountRequest request) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString("languageCode");
  final response = await http.post('$url/education/accounts/logout',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '',
        HttpHeaders.acceptLanguageHeader: languageCode
      },
      body: createAccountRequestToJson(request));
  return commonResponseFromJson(response.body);
}
