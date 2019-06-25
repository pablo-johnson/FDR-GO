import 'package:fdr_go/dialogs/create_account.dart';
import 'package:fdr_go/screens/landing/landing.dart';
import 'package:fdr_go/screens/sign_in/signInBloc.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var _obscure = true;
  FocusNode focusPassword = FocusNode();

  changeThePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LandingPage()));
  }

  Widget _getPrefixIcon(String icon) {
    return Container(
      width: 0,
      alignment: Alignment(-0.5, 0.0),
      child: Image.asset(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signInBloc = SignInBloc();
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
              height: MediaQuery.of(context).size.height,
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
                  StreamBuilder<String>(
                    stream: signInBloc.email,
                    builder: (context, snapshot) => TextField(
                          onChanged: signInBloc.emailChanged,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.next,
                          onSubmitted: (value) {
                            FocusScope.of(context).requestFocus(focusPassword);
                          },
                          decoration: InputDecoration(
                              prefixIcon: _getPrefixIcon(
                                  'assets/images/signin_user.png'),
                              focusedBorder: border,
                              enabledBorder: border,
                              border: border,
                              hintStyle: TextStyle(color: Colors.white70),
                              labelStyle: TextStyle(color: Colors.white70),
                              labelText: "Email",
                              errorText: snapshot.error),
                        ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<String>(
                    stream: signInBloc.password,
                    builder: (context, snapshot) => TextField(
                          onChanged: signInBloc.passwordChanged,
                          focusNode: focusPassword,
                          keyboardType: TextInputType.text,
                          obscureText: _obscure,
                          style: TextStyle(color: Colors.white),
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              prefixIcon: _getPrefixIcon(
                                  'assets/images/signin_padlock.png'),
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
                              errorText: snapshot.error),
                        ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  StreamBuilder<bool>(
                      stream: signInBloc.submitCheck,
                      builder: (context, snapshot) => new SizedBox(
                            width: double.infinity,
                            height: Consts.commonButtonHeight,
                            child: RaisedButton(
                              disabledColor: primarySwatch['redDisabled'],
                              disabledTextColor: primarySwatch['whiteDisabled'],
                              textColor: Colors.white,
                              color: primarySwatch['red'],
                              splashColor: primarySwatch['redPressed'],
                              onPressed: snapshot.hasData
                                  ? () => changeThePage(context)
                                  : null,
                              child: Text(
                                "Ingresar",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          )),
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
        ],
      ),
    );
  }

  Widget addAccountWidget() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => CreateAccountDialog(),
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

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusPassword.dispose();

    super.dispose();
  }
}
