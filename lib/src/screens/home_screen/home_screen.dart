import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:myit/src/permissions/permission_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PermissionManager().requestMicrophonePermission();
    const url = "https://www.oration.ai/playground/aramco";
    log(url);
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
      ..loadRequest(Uri.parse(url))
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