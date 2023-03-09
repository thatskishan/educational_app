import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';

class W3School extends StatefulWidget {
  const W3School({Key? key}) : super(key: key);

  @override
  State<W3School> createState() => _W3SchoolState();
}

class _W3SchoolState extends State<W3School> {
  String data = "";
  String myUrl = "https://www.w3schools.com/#gsc.tab=0&gsc.q=flutter";
  bool canGoBack = false;
  bool canGoForward = false;
  String currentUrl = "";
  List history = [];
  List bookMark = [];
  double progress = 0;

  late InAppWebViewController myWeb;
  late PullToRefreshController refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myUrl = "https://www.w3schools.com/#gsc.tab=0&gsc.q=$data";
    refreshController = PullToRefreshController(
      onRefresh: () {
        setState(() {
          refreshController.endRefreshing();
        });
      },
      options: PullToRefreshOptions(
        enabled: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return WillPopScope(
      onWillPop: () async {
        if (await myWeb.canGoBack()) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "W3School",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  bookMark.contains(currentUrl)
                      ? bookMark.remove(currentUrl)
                      : bookMark.add(currentUrl);
                });
              },
              icon: Icon(
                (bookMark.contains(currentUrl))
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                myWeb.goBack();
              },
              icon: Icon(
                CupertinoIcons.back,
                color: canGoBack ? Colors.blue : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                myWeb.reload();
              },
              icon: const Icon(
                CupertinoIcons.refresh,
              ),
            ),
            IconButton(
              onPressed: () {
                myWeb.goForward();
              },
              icon: Icon(
                CupertinoIcons.forward,
                color: canGoBack ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // TextField(
              //   onChanged: (v) => setState(() {
              //     data = v;
              //   }),
              //   onSubmitted: (v) {
              //     history.add(data);
              //     myUrl = "https://www.w3schools.com/#gsc.tab=0&gsc.q$data";
              //     myWeb.loadUrl(
              //       urlRequest: URLRequest(
              //         url: Uri.parse(myUrl),
              //       ),
              //     );
              //   },
              //   decoration: InputDecoration(
              //     suffixIcon: GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           history.add(data);
              //           myUrl =
              //               "https://www.w3schools.com/#gsc.tab=0&gsc.q=$data";
              //           myWeb.loadUrl(
              //             urlRequest: URLRequest(
              //               url: Uri.parse(myUrl),
              //             ),
              //           );
              //         });
              //       },
              //       child: const Icon(
              //         Icons.search,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              LinearProgressIndicator(
                value: progress,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: InAppWebView(
                  onWebViewCreated: (con) {
                    myWeb = con;
                  },
                  onProgressChanged: (controller, p) {
                    setState(() {
                      progress = p.toDouble();
                    });
                  },
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(myUrl),
                  ),
                  pullToRefreshController: refreshController,
                  onLoadStart: (con, c) async {
                    Uri? dummy = await myWeb.getUrl();
                    currentUrl = dummy!.scheme;
                    this.currentUrl = c.toString();
                    canGoBack = await myWeb.canGoBack();
                    canGoForward = await myWeb.canGoForward();
                    setState(() {});
                  },
                  onLoadStop: (InAppWebViewController controller, Uri? url) {
                    this.currentUrl = url.toString();
                    refreshController.endRefreshing();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
