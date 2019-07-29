import 'dart:convert';

import 'package:fdr_go/data/bus_service.dart';
import 'package:fdr_go/services/bus_service_services.dart';
import 'package:fdr_go/util/ToastUtil.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsPage extends StatefulWidget {
  final BusService service;

  const TermsPage({@required this.service}) : assert(service != null);

  @override
  State<StatefulWidget> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool _loading = true;
  bool _isSubmitButtonEnabled = false;

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text("Contrato"),
      ),
      backgroundColor: Colors.white,
      body: buildAbsenceWidget(widget.service),
    );
  }

  Widget buildAbsenceWidget(BusService service) {
    return Stack(
      children: <Widget>[
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _buildMainForm(service),
            ),
            _buildActionButtons(),
          ],
        ),
      ],
    );
  }

  Widget _buildMainForm(BusService service) {
    return WebView(
      initialUrl: '',
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: Set.from([
        JavascriptChannel(
            name: 'fdrBridge',
            onMessageReceived: (JavascriptMessage message) {
              _enableSubmitButton(message.message == "true");
            }),
        // we can have more than one channels
      ]),
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
        _loadHtml(service.requestService.id);
      },
    );
  }

  _loadHtml(serviceRequestId) async {
//    String html = await rootBundle.loadString('assets/test.html');
//    _controller.loadUrl(Uri.dataFromString(
//      html,
//      mimeType: 'text/html',
//      encoding: Encoding.getByName('utf-8'),
//    ).toString());
//    setState(() {
//      _loading = false;
//    });
    getTermsAndConditions(serviceRequestId).then((html) {
      _controller.loadUrl(Uri.dataFromString(
        html,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString());
      setState(() {
        _loading = false;
      });
    });
  }

  Row _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: new SizedBox(
            height: Consts.commonButtonHeight,
            child: RaisedButton(
              textColor: Colors.white,
              color: primarySwatch['red'],
              disabledColor: primarySwatch['redDisabled'],
              disabledTextColor: primarySwatch['whiteDisabled'],
              child: Text(
                "Rechazar",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              onPressed: _loading ? null : () => _acceptTerms(false),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: new SizedBox(
            height: Consts.commonButtonHeight,
            child: RaisedButton(
              textColor: Colors.white,
              color: primarySwatch['blue'],
              disabledColor: primarySwatch['blueDisabled'],
              disabledTextColor: primarySwatch['whiteDisabled'],
              child: Text(
                "Aceptar",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              onPressed: _loading || !_isSubmitButtonEnabled
                  ? null
                  : () => _acceptTerms(true)(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _enableSubmitButton(bool enable) {
    setState(() {
      _isSubmitButtonEnabled = enable;
    });
  }

  _dismiss(bool refresh) {
    Navigator.pop(context, refresh);
  }

  _acceptTerms(bool accept) {
    setState(() {
      _loading = true;
    });
    acceptTerms(widget.service.requestService.id, accept)
        .then((acceptServiceResponse) {
      showSuccessToast(acceptServiceResponse.successful.message);
      _dismiss(true);
    });
  }
}
