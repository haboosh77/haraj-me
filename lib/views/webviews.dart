import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebView> {
  // For Loading Sign
  bool isLoading = true;

  // Webview Controller
  WebViewController controller = WebViewController();

  // Function for changing URL
  changeUrl(String url) {
    WebViewController newcontroller = WebViewController();
    newcontroller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse(url),
      );
    if (mounted) {
      setState(() {
        controller = newcontroller;
      });
    }
  }

  int _selectedIndex = 0;
  final List<String> urlList = <String>[
    'https://haraj-me.com/',
    'https://haraj-me.com/#services',
    'https://haraj-me.com/#portfolio',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeUrl(urlList[_selectedIndex]);
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    changeUrl(urlList[index]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.lightGreen,
          ),
        )
            : WillPopScope(

            onWillPop: ()async {
              if(await controller.canGoBack()){
                controller.goBack();
                return false;
              }else{
                return true;
              }
            },
            child: WebViewWidget(controller: controller)),
        // Bottom Navigation Bar

        // bottomNavigationBar: BottomNavigationBar(
        //         //   selectedItemColor: Colors.black,
        //         //   items: const <BottomNavigationBarItem>[
        //         //     BottomNavigationBarItem(
        //         //       icon: Icon(Icons.home),
        //         //       label: 'Home',
        //         //     ),
        //         //     BottomNavigationBarItem(
        //         //       icon: Icon(Icons.business),
        //         //       label: 'Business',
        //         //     ),
        //         //     BottomNavigationBarItem(
        //         //       icon: Icon(Icons.school),
        //         //       label: 'School',
        //         //     ),
        //         //   ],
        //         //   currentIndex: _selectedIndex,
        //         //   onTap: _onTabTapped,
        //         // ),
      ),
    );
  }
}



// Previous Webview Example

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewApp extends StatefulWidget {
//   const WebViewApp({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewApp> createState() => _WebViewAppState();
// }
//
// class _WebViewAppState extends State<WebViewApp> {
//   WebViewController controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//   //..setBackgroundColor(const Color(0x00000000))
//     ..setNavigationDelegate(
//       NavigationDelegate(
//         onProgress: (int progress) {
//           // Update loading bar.
//         },
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           if (request.url.startsWith('https://flutter.dev/')) {
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(
//       Uri.parse('https://usamasadiq.engineer/'),
//     );
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WebViewWidget(controller: controller),
//       ),
//     );
//   }
// }
