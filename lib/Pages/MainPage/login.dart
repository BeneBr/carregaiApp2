import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:connectivity/connectivity.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  bool exibirSenha = true;
  String dica = "Visualizar";

  TextEditingController _cpfController = MaskedTextController(mask: "000.000.000-00");
  TextEditingController _cnpjController = MaskedTextController(mask: "00.000.000/0000-00");
  TextEditingController _senhaController = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _cpfCnpjController;
  final _conexaoStream = StreamController<ConnectivityResult>();


  @override
  void dispose() {
    super.dispose();
    _cpfController.dispose();
    _cnpjController.dispose();
    _senhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(bottom: 50), child: Text("ENTRAR", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
                  cpfCnpj("CPF ou CNPJ"),
                  Divider(),
                  password("SENHA"),
                  Divider(),
                  entrar("ENTRAR"),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      esqueciaSenha("Baa, esqueci a senha.")
                    ],
                  ),
                ],
              ),
            ),
          )
        );
  }

  Widget cpfCnpj(String label){
    return (
      TextFormField(
        style: TextStyle(fontSize: 18),
        keyboardType: TextInputType.number,
        controller: _cpfCnpjController,
        validator: (value){
          if(value.length > 14){
            if(CNPJValidator.isValid(value)){
              return null;
            }else{
              return "CNPJ INVALIDO";
            }
          }else{
            if(CPFValidator.isValid(value)){
              return null;
            }else{
              return "CPF INVALIDO";
            }
          }

        },
        onChanged: (value){
          if(value.length > 14){
            setState(() {
              _cnpjController.text = value;
              _cpfCnpjController = _cnpjController;
            });
          }else{
            setState(() {
              _cpfController.text = value;
              _cpfCnpjController = _cpfController;
            });
          }
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 18),
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
        ),
      )
    );
  }

  Widget password(String label){
    return (
        TextFormField(
          maxLength: 8,
          style: TextStyle(fontSize: 18),
          keyboardType: TextInputType.text,
          obscureText: exibirSenha,
          controller: _senhaController,
          validator: (value){
            if(value.length != 8){
              return "Senha precisa de 8 caracteres";
            }{
              return null;
            }
          },
          decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(fontSize: 18),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: exibirSenha == true ? Icon(Icons.visibility_off) : Icon(Icons.visibility) ,
                onPressed: (){
                  setState(() {
                    exibirSenha = !exibirSenha;
                    if(exibirSenha){
                      dica = "Visualizar";
                    }else{
                      dica = "Ocultar";
                    }
                  });
                },
              ),
              suffix: Text(dica),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
          ),
        )
    );
  }

  String cpfValidator(String value){
    if(CPFValidator.isValid(value) || CNPJValidator.isValid(value)){
      return null;
    }else{
      return "CPF OU CNPJ INVALIDO";
    }
  }

  Widget entrar(String label){
    return (
        Container(
          color: Theme.of(context).primaryColor,
          height: 40,
          width: double.infinity,
          child: FlatButton(
            splashColor: Theme.of(context).primaryColorLight,
            child: Text(label, style: TextStyle(fontSize: 18, color: Colors.white),),
            onPressed: ()=>null,
          ),
        )
    );
  }
  
  Widget esqueciaSenha(String label){
    return (
      Container(
        child: FlatButton(
          child: Text(label, style: TextStyle(fontSize: 18),),
          onPressed: ()=>null,
        ),
      )
    );
  }

  void verificarConexao() async{
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    _conexaoStream.add(connectivityResult);
  }

}
