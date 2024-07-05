import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gsy_github_app/widget/gsy_common_option_widget.dart';

import '../../common/localization/default_localizations.dart';
import '../../common/style/gsy_style.dart';

class LoginWebView extends StatefulWidget {
  final String url;
  final String title;

  const LoginWebView(this.url, this.title, {super.key});

  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
  }

  _renderTitle() {
    if (widget.url.isEmpty) {
      return Text(widget.title);
    }
    return Row(children: [
      Expanded(
          child: Text(
        widget.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )),
      GSYCommonOptionWidget(url: widget.url),
    ]);
  }

  final FocusNode focusNode = FocusNode();

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _renderTitle(),
      ),
      body: Stack(
        children: <Widget>[
          TextField(
            focusNode: focusNode,
          ),
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            onWebViewCreated: (controller) {
              webViewController = controller;
              webViewController?.loadUrl(
                  urlRequest: URLRequest(url: WebUri(widget.url)));
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            initialSettings: InAppWebViewSettings(
              useShouldOverrideUrlLoading: true,
            ),
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var url = navigationAction.request.url!.toString();
              if (url.startsWith("gsygithubapp://authed")) {
                var code = Uri.parse(url).queryParameters["code"];
                if (kDebugMode) {
                  print("code $code");
                }
                Navigator.of(context).pop(code);
                return NavigationActionPolicy.CANCEL;
              }
              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              setState(() {
                isLoading = false;
              });
              if (url.toString().startsWith("gsygithubapp://authed")) {
                var code = Uri.parse(url.toString()).queryParameters["code"];
                if (kDebugMode) {
                  print("code $code");
                }
                Navigator.of(context).pop(code);
              }
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
          if (isLoading)
            Center(
              child: Container(
                width: 200.0,
                height: 200.0,
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitDoubleBounce(color: Theme.of(context).primaryColor),
                    Container(width: 10.0),
                    Text(GSYLocalizations.i18n(context)!.loading_text,
                        style: GSYConstant.middleText),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
