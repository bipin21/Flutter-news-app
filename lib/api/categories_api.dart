import 'dart:io';

import 'package:http/http.dart' as http;
import 'api_util.dart';

class CategoiresApi{

  fetchAllCategories() async{
    var _client = new HttpClient();
    _client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    String allCategories = ApiUtil.MAIN_API_URL + ApiUtil.ALL_CATEGORIES;
    Map<String,String> headers = {
      'Accept' : 'application/json'
    };

    var response = await http.get(allCategories, headers: headers);
//    var response = await _client.getUrl((Uri.parse(allCategories)));
//    if(response.statusCode == 200){

//    }

  print(response.statusCode);
  print(response.body);
  }
}