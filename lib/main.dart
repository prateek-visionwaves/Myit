import 'package:flutter/material.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
