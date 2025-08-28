import 'dart:convert';

import 'package:cattle_health/models/feeds_models.dart';
import 'package:http/http.dart' as http;

class HeartRate {
  List<FeedsModel> heart=[];

  Future<void> getHeart()async{
    String url = "https://api.thingspeak.com/channels/2769547/fields/3.json?api_key=CLC2P68LXMZ7KDN4&results=1";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=='ok'){
      jsonData["feeds"].forEach((element){
        if(element["field3"]!=null && element["entry_id"]!=null){
          FeedsModel feedsModel = FeedsModel(
            sensor : element["field3"]
          );
          heart.add(feedsModel);
        }
      });
    }
  }
}