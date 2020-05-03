import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carregaai/Controllers/UserController.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class searcAddressDelegate extends SearchDelegate<String>{
  @override

  String get searchFieldLabel => "Nome da Rua, cidade, ou o CEP";

  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () async {
          query = "";
        }
        
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation), 
      onPressed: (){
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List>(
      future: searchSuggestions(query),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(snapshot.connectionState == ConnectivityResult.none){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.cloud_off, size: 40,),
                Text("Sem conexão com a internet.",style: TextStyle(fontSize: 20),)
              ],
            ),
          );
        }

        if(!snapshot.hasData){
          return Center(
            child: Text("Sem resultados de busca", style: TextStyle(fontSize: 20)),
          );
        }
        else{
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              return Text(snapshot.data[index]['description']);
            }
          );
        }
        
      }
    );
  }

}

Future<List> searchSuggestions(String address) async{
  String key = "AIzaSyArWkZvkfZPt2eB8knbmvSted82KgQP4rc";
  List results;
  http.Response response;
  try{
      if(address.length != 0 && address != null && address.length > 5){
        response = await http.get(
        url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$address&types=geocode&language=pt_BR&key=$key"
        );
      }
      if(response.statusCode == 200){
        results = jsonDecode(response.body)['predictions'];
        return results;
      }
    
  }catch(error){
    print(error);
  }
  
}