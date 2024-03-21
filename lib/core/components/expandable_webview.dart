import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExpandableWebView extends StatefulWidget {
  final String url;
  final EdgeInsets padding;

  const ExpandableWebView(
    this.url, {
    super.key,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<ExpandableWebView> createState() => _ExpandableWebViewState();
}

class _ExpandableWebViewState extends State<ExpandableWebView> {
  double contentHeight = 0;
  bool loaded = false;
  late WebViewController webViewController;
  late double defaultFontSize;
  late double pixelRatio = MediaQuery.of(context).devicePixelRatio;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    defaultFontSize = context.textTheme.bodyMedium?.fontSize ?? 14;
  }

  bool isStillContainLoadingInHtml(String html) {
    return html.contains('Loading');
  }

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'extents',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('[webView/javascriptChannels] ${message.message}');
          final height = Platform.isIOS
              ? double.parse(message.message)
              : double.parse(message.message) / pixelRatio;
          setState(() {
            contentHeight = height;
          });
        },
      )
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('[webView/onProgress] progress: $progress');
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            if (Platform.isIOS) {
              Future<bool> isContainLoadingInHtml() async =>
                  await webViewController
                      .runJavaScriptReturningResult(
                        "document.documentElement.innerHTML.includes('Loading');",
                      )
                      .then((value) => value.toString() == 'true');
              var isLoading = await isContainLoadingInHtml();
              while (isLoading) {
                await Future.delayed(const Duration(milliseconds: 500));
                isLoading = await isContainLoadingInHtml();
              }
            }
            debugPrint('[webView/onPageFinished] finished loading "$url"');
            await webViewController.runJavaScript(
              "document.querySelectorAll('*:not(script):not(style)').forEach((text) => {text.style.fontSize = '${defaultFontSize}px';});",
            );
            await webViewController.runJavaScript(
              "window.extents.postMessage(document.body.clientHeight);",
            );
            setState(() {
              loaded = true;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[webView/build] url: ${widget.url}');

    return Container(
        margin: widget.padding,
        width: double.infinity,
        height: contentHeight,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _buildWebView(context),
            if (!loaded) const LinearProgressIndicator(),
          ],
        ));
  }

  Widget _buildWebView(BuildContext context) {
    return WebViewWidget(controller: webViewController);
  }
}
