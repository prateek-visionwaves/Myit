import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myit/permissions/permission_manager.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyIt',
      home: HomeScreen(),
    );
  }
}
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = WebViewController(
//       onPermissionRequest: (request){
//         log(request.toString());
//         request.grant();
//       }
//     );
//     controller..loadRequest(Uri.parse('https://translate.google.co.in/?sl=en&tl=hi&op=translate'))
//     ..setJavaScriptMode(JavaScriptMode.unrestricted);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('MyIT'),
//       ),
//       body: WebViewWidget(controller: controller,)
//     );
//   }
// }


class HomeScreen extends StatelessWidget {
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
        initialUrlRequest: URLRequest(url: WebUri('https://translate.google.co.in/?sl=en&tl=hi&op=translate')),
        // onWebViewCreated: (controller) => this.controller = controller,
        // onLoadStart: controller.onLoadStart,
        // onLoadStop: controller.onLoadStop,
        onPermissionRequest: (controller, request)async{
          await PermissionManager().requestMicrophonePermission();
          log(request.resources.length.toString());
          return PermissionResponse(action: PermissionResponseAction.GRANT, resources: request.resources);
        },
        onMicrophoneCaptureStateChanged: (c,cs,cse)async{
          log('message');
        },
      ),
    );
  }
}