import 'dart:convert';
import 'package:freeforweebs/resources/constant.dart';
import 'package:http/http.dart';

class VideoApi {
  Client http = Client();

  Uri uri(String url) => Uri.parse(url);

  Future<Response> responseByPost(Uri uri, Map<String, dynamic> body) async {
    return await http.post(uri, body: body);
  }

  Future<String> fetchIframe({required String link}) async {
    Response response =
        await responseByPost(uri("${Constant.baseUrl}/video"), {"link": link});

    return json.decode(response.body)["data"]['iframe'];
  }

  Future<String> fetchDownload({required String link}) async {
    Response response =
        await responseByPost(uri("${Constant.baseUrl}/video"), {"link": link});
    return json.decode(response.body)["data"]['download'];
  }

  static String url(String iframelink) {
    return ("""
<!DOCTYPE html>
  <html>
      <head>
        <style>
           html { overflow: auto;}
           html, body, iframe {
                        margin: 0px;
                        padding: 0px;
                        height: 100%;
                        border: none; 
                      }
           iframe {
               display: block;
               width: 100%;
               border: none;
               overflow-y: auto;
               overflow-x: hidden;
              }
           body { background-color: black;}
        </style>
      </head>
    <body>
      <iframe 
            src="$iframelink" 
            frameborder="0" 
            allowfullscreen="true" 
            frameborder="0" 
            marginwidth="0" 
            marginheight="0" 
            scrolling="no">
      </iframe>
    </body>
  </html>
""");
  }
}
