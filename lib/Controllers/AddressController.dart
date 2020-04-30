import 'dart:async';
import 'dart:convert';
import 'package:carregaai/Controllers/UserController.dart';
import 'package:http/http.dart' as http;


void searchSuggestions(String address, StreamController _suggestionsController) async{
  String key = "AIzaSyArWkZvkfZPt2eB8knbmvSted82KgQP4rc";
  http.Response response;
  try{
      if(address.length != 0 && address != null && address.length > 5){
        _suggestionsController.add("Aguardando");
        response = await http.post(
        url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$address&types=geocode&language=pt_BR&key=$key"
        );
      }else{
        _suggestionsController.add(null);
      }
      _suggestionsController.add(jsonDecode(response.body));
  }catch(error){
    print(error);
  }
}