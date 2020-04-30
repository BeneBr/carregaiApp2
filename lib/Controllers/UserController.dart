import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carregaai/Models/UserModel/UserModel.dart';
import 'dart:convert';

String url = "http://192.168.1.104:8080";

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

void login(String cpfCnpj, String password, UserModel model, Function loginResult) async{
  model.setCarregando(true);

  var body = {
    'cpfCnpj': cpfCnpj,
    'password': password
  };
  http.Response response;
  try{
    response = await http.post(
      url+'/login',
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(body),
    );
    var responseDecoded = jsonDecode(response.body);
    if(response.statusCode == 200){
      model.setToken(responseDecoded['token']);
      model.setNomeRazao(responseDecoded['user']['nomeRazao']);
      model.setcpfCnpj(responseDecoded['user']['cpfCnpj']);
      model.setFoto(responseDecoded['user']['foto']);
      model.setPontos(double.parse(responseDecoded['user']['pontos'] + 0.0));
      print(model.getFoto());
      loginResult(response.statusCode, responseDecoded['mensagem']);
      model.setCarregando(false);
    }else{
      loginResult(response.statusCode, responseDecoded['mensagem']);
      model.setCarregando(false);
    }
  }catch(erro){
    loginResult(response.statusCode, "Erro Inexperado");
    model.setCarregando(false);
  }
}

void enviarFoto(String cpf, String foto, String token) async {
    var body = {
      'cpfCnpj': cpf,
      'foto': foto,
    };
    http.Response response;
    try{
      response = await http.post(
        url+'/user/image',
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body)
      );
      print(response.statusCode);
    }catch(err){
      print(err);
    }
  }

