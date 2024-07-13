import 'dart:convert';
import 'package:http/http.dart' as http;

fetchdata(String url, String method, Map<String, String> JsonData, String jwtToken) async{
  if(method == "get"){
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
  else{
    if(method == "post"){
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $jwtToken",
          },
          body: jsonEncode(JsonData));

      return response.body;
    }
    else{

      if(method == "put"){
        http.Response response = await http.put(Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(JsonData));
        return response.body;
      }
      else{

        if(method == "delete"){
          http.Response response = await http.delete(Uri.parse(url),
              headers: {"Content-Type": "application/json"},
              body: jsonEncode(JsonData));
          return response.body;
        }

      }

    }
  }
}