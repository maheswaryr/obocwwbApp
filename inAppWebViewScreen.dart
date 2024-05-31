/*
import 'package:flutter/material.dart';
import 'package:obocwwb/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';


class InAppWebView extends StatefulWidget {
  const InAppWebView({Key? key}) : super(key: key);

  @override
  State<InAppWebView> createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView> {
  late final WebViewController _controller;
  @override
  void initState() {

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    super.initState();

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Text('Payment'),
        ),
        body: WebViewWidget(controller: _controller)
        */
/*const WebView(
        initialUrl: 'https://www.onlinesbi.com',
        javascriptMode: JavascriptMode.unrestricted,
      ),*//*

        );
  }
}
*/
