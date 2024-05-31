/*
///Updated on 19/12/2022 by Arsha

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:obocwwb/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebView extends StatefulWidget {
  const InAppWebView({Key? key}) : super(key: key);

  @override
  State<InAppWebView> createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Payment'),
      ),
      body: const WebView(
        initialUrl: 'https://www.onlinesbi.com',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
*/
