import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freeforweebs/apis/video_api.dart';
import 'package:freeforweebs/models/episode.dart';
import 'package:freeforweebs/monetization/unity_ad_service.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoUI extends StatefulWidget {
  final Episode episode;
  const VideoUI({Key? key, required this.episode}) : super(key: key);

  @override
  State<VideoUI> createState() => _VideoUIState();
}

class _VideoUIState extends State<VideoUI> {
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose(); // Show an interstitial ad
    InterstitialAd.load(
        adUnitId: "ca-app-pub-8047401597057812/1807205724",
        request: const AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          ad.show();
        }, onAdFailedToLoad: (error) {
          print(error);
        }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InterstitialAd.load(
        adUnitId: "ca-app-pub-8047401597057812/5934701731",
        request: const AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          ad.show();
        }, onAdFailedToLoad: (error) {
          print(error);
        }));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    double height = Go(context).size.height;
    double width = height * 16 / 9;
    return ThemeConsumer(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<String>(
            future: VideoApi().fetchIframe(link: widget.episode.link),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              String iframelink = snapshot.data!;

              return Center(
                child: Container(
                  width: width,
                  height: height,
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    navigationDelegate: (NavigationRequest request) {
                      return NavigationDecision.prevent;
                    },
                    initialUrl: Uri.dataFromString(
                      VideoApi.url(iframelink),
                      mimeType: 'text/html',
                    ).toString(),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
