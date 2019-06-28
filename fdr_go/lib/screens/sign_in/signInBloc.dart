import 'dart:async';
import 'dart:io';

import 'package:fdr_go/data/requests/login_request.dart';
import 'package:fdr_go/data/responses/login_response.dart';
import 'package:fdr_go/mixins/validator.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends Object with Validators implements BaseBloc {
  String url = Consts.baseUrl;
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;

  Function(String) get passwordChanged => _passwordController.sink.add;

  //Another way
  // StreamSink<String> get emailChanged => _emailController.sink;
  // StreamSink<String> get passwordChanged => _passwordController.sink;

  Stream<String> get email => _emailController.stream.transform(emailValidator);

  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<Future<LoginResponse>> get submitCheck =>
      Observable.combineLatest2(email, password, (e, p) => submit(e, p));

  Future<LoginResponse> submit(String email, String password) async {
    LoginRequest request = new LoginRequest();
    request.username = email;
    request.password = password;
    request.appId = Consts.appId;
    final response = await http.post('$url/education/accounts/authenticate',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: ''
        },
        body: loginRequestToJson(request));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponse loginResponse = loginResponseFromJson(response.body);
    await prefs.setString('authToken', loginResponse.token);
    return loginResponse;
  }

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
