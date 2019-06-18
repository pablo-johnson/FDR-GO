import 'package:fdr_go/screens/sign_in/signInBloc.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  changeThePage(BuildContext context) {
//    Navigator.of(context)
//        .push(MaterialPageRoute(builder: (context) => PageTwo()));
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
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              prefixIcon: _getPrefixIcon(
                                  'assets/images/signin_padlock.png'),
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
                            height: 60.0,
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
                                "Submit",
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
                  Text(
                    "Agregar cuenta",
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
