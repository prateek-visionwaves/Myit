import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myit/permissions/permission_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionManager().requestMicrophonePermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyIt',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationDelegate = NavigationDelegate(
      onNavigationRequest: (req) async {
        log("Navigation ${req.url}");
        if (req.url.contains('http://') ||
            req.url.contains('https://') ||
            req.url.contains('file://')) {
          return NavigationDecision.navigate;
        } else {
          final uri = Uri.parse(req.url);
          await launchUrl(uri);
          return NavigationDecision.prevent;
        }
      },
    );

    final controller = WebViewController(
      onPermissionRequest: (request) async {
        log("Permission request ${request.toString()}");
        await Permission.microphone.request();
        request.grant();
      },
    );

    controller
      ..loadRequest(Uri.parse('https://www.oration.ai/playground/aramco'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(navigationDelegate);
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyIT'),
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}

/*class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final InAppWebViewController controller = InAppWebViewController();
    // controller..onLoadStart = (controller, url) => debugPrint('Loading URL: $url');
    // controller..onLoadStop = (controller, url) => debugPrint('Finished loading: $url');
    // controller..onPermissionRequest = (controller, origin, resources) async {
    //   resources.forEach((resource) => await Permission.microphone.request());
    // };
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyIT'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri('https://www.oration.ai/playground/aramco')),
        // onWebViewCreated: (controller) => this.controller = controller,
        // onLoadStart: controller.onLoadStart,
        // onLoadStop: controller.onLoadStop,
        onPermissionRequest: (controller, request)async{
          log("Permission ${request.resources}");
          return PermissionResponse(action: PermissionResponseAction.GRANT, resources: request.resources);
        },
        onMicrophoneCaptureStateChanged: (c,cs,cse)async{
          log('message');
        },
      ),
    );
  }
}*/

/*
class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: WebView(
        initialUrl: 'https://www.oration.ai/playground/aramco',
        javascriptMode: JavascriptMode.unrestricted,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        debuggingEnabled: true,
        allowsInlineMediaPlayback: true,

      ),
    );
  }

}*/
