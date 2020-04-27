import 'package:carregaai/Models/UserModel/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Demands extends StatefulWidget {
  @override
  _DemandsState createState() => _DemandsState();
}

class _DemandsState extends State<Demands> {

  @override
  Widget build(BuildContext context) {

    

    TextEditingController _enderecOrigem = TextEditingController();
    TextEditingController _nrOrigem = TextEditingController();
    TextEditingController _complementoOrigem = TextEditingController();
    TextEditingController _enderecDestino = TextEditingController();
    TextEditingController _nrDestino = TextEditingController();
    TextEditingController _complementoDestino = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Solicitar Entrega"),
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
                      print(name);
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
            decoration: InputDecoration(
              labelText: "Rua Liberdade, Itaqui ou CEP"
            ),
            controller: controller,
          ),
          content: SingleChildScrollView(
              
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