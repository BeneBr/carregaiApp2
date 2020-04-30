import 'dart:async';
import 'package:carregaai/Controllers/AddressController.dart';
import 'package:carregaai/Models/DemandasModel/DemandasModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Demands extends StatefulWidget {
  @override
  _DemandsState createState() => _DemandsState();
}

class _DemandsState extends State<Demands> {
  StreamController _suggestionsController;
  Stream _suggestionsStream;
  Timer debounce;

   @override
    initState(){
      _suggestionsController = StreamController.broadcast();
      _suggestionsStream = _suggestionsController.stream;
    }

    TextEditingController _enderecOrigem = TextEditingController();
    TextEditingController _nrOrigem = TextEditingController();
    TextEditingController _complementoOrigem = TextEditingController();
    TextEditingController _enderecDestino = TextEditingController();
    TextEditingController _nrDestino = TextEditingController();
    TextEditingController _complementoDestino = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return ScopedModel<DemandsModel>(
      model: DemandsModel(),
      child: Scaffold(
      appBar: AppBar(
        title: Text("Solicitar Entrega"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left:10, right: 10),
        child: Column(
         children: <Widget>[
           locations("Onde Retirar a Encomenda?",_enderecOrigem, _nrOrigem, _complementoOrigem),
           Divider(),
           locations("Onde Entregar a Encomenda?",_enderecDestino, _nrDestino, _complementoDestino),
           Divider(),
           Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Descrição da Encomenda", style: TextStyle(color: Colors.white),),
                  Icon(Icons.navigate_next, color: Colors.white,),
                ],
              ),
                onPressed: () => null,
            ),
          ),
          Text("Etapa 1/2", style: TextStyle(color: Colors.black),),
         ], 
        ),
      )
    ),
    );
  }

  Widget locations(texto,TextEditingController endereco,nr,complemento){
    return (
      Card(
           elevation: 10.0,
           child: Form(
             child: Column(
               children: <Widget>[
                Text(texto,style: TextStyle(fontSize: 18)),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    enableInteractiveSelection: false,
                    keyboardType: TextInputType.text,
                    controller: endereco,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(icon: Icon(Icons.location_searching), onPressed: null),
                      labelText: "Endereço de Retirada",
                      hintText: "Rua Liberdade, Itaqui ou CEP"
                    ),
                    onTap: (){
                      searcAddress(endereco, context);
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(right: 60, left: 20),
                        child: TextFormField(
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          controller: nr,
                          decoration: InputDecoration(
                            labelText: "Número",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: complemento,
                          decoration: InputDecoration(
                            labelText: "Complemento",
                            hintText: "Fundos, apt 201"
                          ),
                        ),
                      ),
                    ),
                  ],
                )
               ],
             ),
           ),
         )
    );
  }

  Future<void> searcAddress(TextEditingController controller, BuildContext context){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          title: TextField(
            onChanged: (value){
              if(debounce ?.isActive ?? false) debounce.cancel();
              debounce = Timer(Duration(seconds: 1), (){
                searchSuggestions(value, _suggestionsController);
              });
            },
            decoration: InputDecoration(
              labelText: "Rua Liberdade, Itaqui ou CEP"
            ),
            controller: controller,
          ),
          content: StreamBuilder(
            stream: _suggestionsStream,
            builder: (context, snapshot){
              if(snapshot.data == null){
                return Text("Nenhum Resultado Encontrado");
              }

              if(snapshot.data == "Aguardando"){
                return Container(
                  child: Center(child: CircularProgressIndicator(),),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data["predictions"].length,
                itemBuilder: (context, index){
                  return (
                    ListTile(
                      onTap: (){
                        controller.text = snapshot.data["predictions"][index]["description"].toString();
                        Navigator.of(context).pop();
                      },
                      dense: true,
                      leading: Icon(Icons.place),
                      title: Text("${snapshot.data["predictions"][index]["terms"][2]["value"]}"),
                      subtitle: Text("${snapshot.data["predictions"][index]["description"]}"),
                    )
                    //Text("${snapshot.data["predictions"][index]["terms"]}")
                  );
                }
              
              );
            }
          
          ),
          actions: <Widget>[
            FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text("Ok"),
              onPressed: (){
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}