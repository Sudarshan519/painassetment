import 'dart:io';

import 'package:get/get.dart';

class HttpRequestHandler extends GetConnect {
  sendRequest(String requestType, String requestUrl,
      {var requestHeader, var requestBody, token}) async {
    try {
      if (requestType == "GET") {
        if (requestBody == null) {
          var resp = await get(requestUrl,
              headers: token != null
                  ? {
                      'Content-Type': 'application/json',
                      "Authorization": "Bearer $token"
                    }
                  : {
                      'Content-Type': 'application/json',
                    });

          if (resp.statusCode == 200) {
            return resp.body;
          } else {
            return (resp.body ?? resp.statusText);
          }
        } else {
          var resp = await httpClient.request(requestUrl, 'GET',
              body: requestBody,
              headers: {
                'Content-Type': 'application/json',
                "Authorization": "Bearer $token"
              });
          if (resp.statusCode == 200) {
            return resp.body;
          } else {
            return (resp.body ?? resp.statusText);
          }
        }
      } else {
        try {
          var resp = await post(requestUrl, requestBody,
              headers: token != null
                  ? {"Authorization": "Bearer $token"}
                  : {
                      'Content-Type': 'application/json',
                    });
          if (!resp.hasError) {
            if (resp.statusCode! >= 200 && resp.statusCode! < 300) {
              return resp.body;
            } else {
              return {"status": "error", "message": resp.statusText};
            }
          } else {
            // print(resp.body);
            return {"status": "error", "message": resp.body["message"]};
          }
        } catch (e) {
          return {"status": "error", "message": "Server Error"};
          // print(e.toString());
        }
      }
    } on SocketException catch (e) {
      return {e.message};
    }
  }
}

final requestHandler = HttpRequestHandler();
