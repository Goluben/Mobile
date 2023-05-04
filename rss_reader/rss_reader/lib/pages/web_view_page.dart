import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  InAppWebViewController? viewController;
  

  @override
  Widget build(BuildContext context) {

    Map inArgs = ModalRoute.of(context)!.settings.arguments as Map;
    String url = inArgs['url'];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              onWebViewCreated: (controller) => viewController = controller,
              initialUrlRequest: URLRequest(
                url: Uri.parse(url),
              ),
            ),
          ),
        ],
      )
    );
  }
}