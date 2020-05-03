import 'dart:async';
import 'package:carregaai/Models/DemandasModel/DemandasModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carregaai/Controllers/SearchAddressDelegate.dart';

class Demands extends StatefulWidget {
  @override
  _DemandsState createState() => _DemandsState();
}

class _DemandsState extends State<Demands> {
  StreamController _suggestionsController;
  Stream _suggestionsStream;
  Timer debounce;
  GlobalKey<FormState> _formStateOrigem = GlobalKey<FormState>();
  GlobalKey<FormState> _formStateDestino = GlobalKey<FormState>();
  ScrollController _scrollController;

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
    Map<String, dynamic> origem;


  @override
  Widget build(BuildContext context) {

    return ScopedModel<DemandsModel>(
      model: DemandsModel(),
      child: Scaffold(
      appBar: AppBar(
        title: Text("Solicitar Entrega"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<DemandsModel>(

        builder: (context, child, model){
          return (
            SingleChildScrollView(
              padding: EdgeInsets.only(left:10, right: 10),
              child: Column(
              children: <Widget>[
                locations("Onde Retirar a Encomenda?",_enderecOrigem, _nrOrigem, _complementoOrigem,_formStateOrigem),
                Divider(),
                locations("Onde Entregar a Encomenda?",_enderecDestino, _nrDestino, _complementoDestino,_formStateDestino),
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
                      onPressed: (){
                        if(_formStateOrigem.currentState.validate() && _formStateDestino.currentState.validate()){
                          ScopedModel.of<DemandsModel>(context).setEnderecoOrigem(_enderecOrigem.text, int.parse(_nrOrigem.text), _complementoOrigem.text);
                          ScopedModel.of<DemandsModel>(context).setEnderecoDestino(_enderecDestino.text, int.parse(_nrDestino.text), _complementoDestino.text);
                        }
                        ScopedModel.of<DemandsModel>(context).getEnderecoDestino();
                        ScopedModel.of<DemandsModel>(context).getEnderecoOrigem();
                      },
                  ),
                ),
                Text("Etapa 1/2", style: TextStyle(color: Colors.black),),
              ], 
              ),
            )
          );
        }
      )
    ),
    );
  }

  Widget locations(String texto,TextEditingController endereco,nr,complemento, GlobalKey<FormState> key){
    return (
      Card(
           elevation: 10.0,
           child: Form(
             key: key,
             child: Column(
               children: <Widget>[
                Text(texto,style: TextStyle(fontSize: 18)),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: endereco,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(icon: Icon(Icons.location_searching), onPressed: null),
                      labelText: "Endereço de Retirada",
                      hintText: "Nome da rua, bairro, cidade ou CEP"
                    ),
                    onTap: (){
                      showSearch(context: context, delegate: searcAddressDelegate());
                    },
                    validator: (value){
                      if(value == null || value.length < 5){
                        return "Endereço inválido";
                      }else{
                        return null;
                      }
                    }
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
                          validator: (value){
                            if(value == null || value.length == 0){
                              return "Invalido";
                            }else{
                              return null;
                            }
                          }
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
                          validator: (value){
                            if(value == null || value.length == 0){
                              return "Inválido";
                            }else{
                              return null;
                            }
                          }
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
}