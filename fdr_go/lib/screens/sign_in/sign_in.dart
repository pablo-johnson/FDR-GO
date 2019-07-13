import 'package:fdr_go/data/responses/login_response.dart';
import 'package:fdr_go/dialogs/create_account.dart';
import 'package:fdr_go/screens/landing/landing.dart';
import 'package:fdr_go/services/account_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:fdr_go/util/validations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var _obscure = true;
  FocusNode focusPassword = FocusNode();
  bool _isValidEmail = true;
  bool _passwordOk = false;
  bool _isLoginButtonEnabled = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var _loading = false;

  Widget _getPrefixIcon(String icon) {
    return Container(
      width: 0,
      alignment: Alignment(-0.5, 0.0),
      child: Image.asset(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final border = const UnderlineInputBorder(
      borderSide: const BorderSide(
        color: const Color(0xffBECCDA),
        width: 0.0,
      ),
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: AssetImage('assets/images/splash_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 110,
                    width: 160,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: AssetImage('assets/images/logo_fdr_go.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: 50.0,
                    height: 1.0,
                    color: primarySwatch['white70'],
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 40,
                    width: 180,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: AssetImage('assets/images/school_name.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextField(
                    onChanged: _validateEmail,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(focusPassword);
                    },
                    decoration: InputDecoration(
                      prefixIcon:
                          _getPrefixIcon('assets/images/signin_user.png'),
                      focusedBorder: border,
                      enabledBorder: border,
                      border: border,
                      hintStyle: TextStyle(color: Colors.white70),
                      labelStyle: TextStyle(color: Colors.white70),
                      labelText: "Email",
                      errorText: _isValidEmail ? null : "Email inválido",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    onChanged: _validatePassword,
                    controller: passwordController,
                    focusNode: focusPassword,
                    keyboardType: TextInputType.text,
                    obscureText: _obscure,
                    style: TextStyle(color: Colors.white),
                    onSubmitted: (value) {},
                    decoration: InputDecoration(
                      prefixIcon:
                          _getPrefixIcon('assets/images/signin_padlock.png'),
                      suffixIcon: IconButton(
                        icon: _obscure
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscure = !_obscure;
                          });
                        },
                        color: primarySwatch['white70'],
                      ),
                      focusedBorder: border,
                      enabledBorder: border,
                      border: border,
                      labelText: "Contraseña",
                      hintStyle: TextStyle(color: Colors.white70),
                      labelStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  _buildLoginButton(),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "¿Has olvidado tu contraseña?",
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  addAccountWidget()
                ],
              ),
            ),
          ),
          _loading
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: primarySwatch['progressBackground'],
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return new SizedBox(
      width: double.infinity,
      height: Consts.commonButtonHeight,
      child: RaisedButton(
        color: primarySwatch['red'],
        textColor: Colors.white,
        disabledColor: primarySwatch['redDisabled'],
        disabledTextColor: primarySwatch['whiteDisabled'],
        splashColor: primarySwatch['redPressed'],
        onPressed: _isLoginButtonEnabled && !_loading ? () => _login() : null,
        child: Text(
          "Ingresar",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  Widget addAccountWidget() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) =>
              CreateAccountDialog(), //(BuildContext context) => CreateAccountDialog(),
        );
      },
      child: Text(
        "Agregar cuenta",
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _validateEmail(String value) {
    setState(() {
      _isValidEmail = validateEmail(value);
      _enableLoginButton();
    });
  }

  _validatePassword(String value) {
    setState(() {
      _passwordOk = validatePassword(value);
      _enableLoginButton();
    });
  }

  void _enableLoginButton() {
    _isLoginButtonEnabled = _isValidEmail && _passwordOk;
  }

  _login() {
    setState(() {
      _loading = true;
    });
    login(emailController.text, passwordController.text).then((loginResponse) {
      if (loginResponse.error != null) {
        setState(() {
          _loading = false;
          _showErrorMessage(loginResponse.error.detail);
        });
      } else if (loginResponse.success) {
        setState(() {
          _loading = false;
        });
        _changeThePage(loginResponse);
      }
    }).catchError((error) {
      _showErrorMessage("Error");
      print('error : $error');
    });
  }

  _changeThePage(LoginResponse loginResponse) {
    _savePersonalData(loginResponse);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LandingPage(loginResponse: loginResponse)));
  }

  void _showErrorMessage(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: primarySwatch['red'],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void dispose() {
    focusPassword.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future _savePersonalData(LoginResponse loginResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', loginResponse.name);
    await prefs.setString('userEmail', loginResponse.email);
  }
}
