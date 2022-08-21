import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:square_tickets/data/remote/events/models/event_model.dart';
import 'package:square_tickets/data/remote/events/models/tickets_model.dart';
import 'package:square_tickets/di/injector.dart';
import 'package:square_tickets/helpers/app_utils.dart';
import 'package:square_tickets/presenter/bloc/events_bloc/events_bloc.dart';

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key, required this.url, required this.onSuccess,  required this.ticket})
      : super(key: key);
  final String url;
  final VoidCallback onSuccess;
  final TicketModel ticket;


  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  // final rentalUrl = 'https://bondlogisticsllc.com/Rental-Webview';

  final GlobalKey webViewKey = GlobalKey();
  final EventsBloc _eventsBloc = EventsBloc(injector.get());


  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  late PullToRefreshController pullToRefreshController;
  bool shimmerVisible = true;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );

    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (webViewController != null) {
          bool canGoback = await webViewController!.canGoBack();
          if (canGoback) {
            webViewController?.goBack();
            return false;
          } else {
            return true;
          }
        } else {
          return true;
        }
      },
      child: BlocListener<EventsBloc, EventsState>(
        bloc: _eventsBloc,
        listener: (context, state) {
          if(state is CompleteBookingTicketLoadingState){
            AppUtils.showAnimatedProgressDialog(
                context, title: 'Finishing up');

          } if(state is CompleteBookingTicketSuccessState){
            Navigator.of(context);
            Navigator.of(context);
            widget.onSuccess();

          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Visibility(
                visible: true,
                child: SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: InAppWebView(

                    key: webViewKey,

                    // contextMenu: contextMenu,
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),

                    // initialFile: "assets/index.html",


                    initialUserScripts: UnmodifiableListView<UserScript>([]),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      log('created');
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        shimmerVisible = true;
                        log(shimmerVisible.toString());
                        // this.rentalUrl = url.toString();
                        // urlController.text = this.url;
                      });
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading: (controller,
                        navigationAction) async {
                      var uri = navigationAction.request.url!;

                      // if (![
                      //   "http",
                      //   "https",
                      //   "file",
                      //   "chrome",
                      //   "data",
                      //   "javascript",
                      //   "about"
                      // ].contains(uri.scheme)) {
                      //   if (await canLaunch(url)) {
                      //     // Launch the App
                      //     await launch(
                      //       url,
                      //     );
                      //     // and cancel the request
                      //     return NavigationActionPolicy.CANCEL;
                      //   }
                      // }

                      if (uri.toString().contains('https://facebook.com')) {
                        log(uri.toString());
                       _eventsBloc.add(CompleteBookingTicketEvent(widget.ticket));
                        log('Completed');
                        setState(() {
                          shimmerVisible = true;
                          // this.rentalUrl = url.toString();
                          // urlController.text = this.url;
                        });
                        return NavigationActionPolicy.CANCEL;
                      } else {}

                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) async {
                      pullToRefreshController.endRefreshing();

                      setState(() {
                        shimmerVisible = false;
                        log(shimmerVisible.toString());


                        // this.url = url.toString();
                        // urlController.text = this.url;
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      setState(() {
                        shimmerVisible = false;
                      });

                      pullToRefreshController.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      log(progress.toString());
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                        setState(() {
                          shimmerVisible = false;

                          // this.progress = progress / 100;
                          // urlController.text = this.url;
                        });
                      }

                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      setState(() {
                        // this.url = url.toString();
                        // urlController.text = this.url;

                      });
                    },
                    onConsoleMessage: (controller, consoleMessage) {

                    },
                  ),
                ),
              ),
              Visibility(
                visible: shimmerVisible == true,
                child:  Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).scaffoldBackgroundColor,
                    child: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: CircularProgressIndicator(

                          color: Colors.indigo,),
                      ),
                    )),)
            ],
          ),
        ),
      ),

    );
  }
}
