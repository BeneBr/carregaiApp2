import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carregaai/Models/UserModel/UserModel.dart';
import 'dart:convert';


String url = "http://192.168.0.109:8080";

void realizarCadastro(Map<String, dynamic> user, String password, UserModel model, Function cadastroResult, BuildContext context) async {
  model.setCarregando(true);

  var body = {
    'nomeRazao': user['nomeRazao'],
    'password': password,
    'cpfCnpj': user['cpfCnpj'],
    'telefone': user['telefone'],
    'email': user['email']
  };
  http.Response response;
  try{
    http.Response response = await http.post(
      url+"/register",
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(body),
    );
    var responseDecode = jsonDecode(response.body);
    cadastroResult(response.statusCode, responseDecode['mensagem']);
    model.setCarregando(false);

  }catch(erro){
    cadastroResult(response.statusCode, "Erro Inexperado");
    model.setCarregando(false);
  }
}


