import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carregaai/Models/UserModel/UserModel.dart';
import 'package:carregaai/Controllers/UserController.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  bool _conectado;
  bool exibirSenha = true;
  String dica = "Visualizar";

  TextEditingController _cpfController = MaskedTextController(mask: "000.000.000-00");
  TextEditingController _cnpjController = MaskedTextController(mask: "00.000.000/0000-00");
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _cpfCnpjController = TextEditingController();

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final _telefoneController = MaskedTextController(mask: "(00) 00000-0000");

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _cnpjController.dispose();
    _senhaController.dispose();
    _cpfCnpjController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();

  }

  @override
  Widget build(BuildContext context) {


    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        _conectado = ScopedModel.of<UserModel>(context).getConectado();

        if(model.getCarregando()){
          return Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
                  ),
                  Divider(color: Colors.white,),
                  Text("EFETUANDO CADASTRO", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          );
        }


        return SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("INFORME SEUS DADOS", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                Divider(),
                campos("Nome ou Razao Social", _nomeController, TextInputType.text, false, nomeValidator),
                Divider(),
                cpfCnpj("CPF OU CNPJ"),
                Divider(),
                campos("Telefone", _telefoneController, TextInputType.number, false, telefoneValidator),
                Divider(),
                campos("Email",_emailController,TextInputType.emailAddress, false, emailValidator),
                Divider(),
                password("Senha"),
                Divider(),
                cadastrar("EFETUAR CADASTRO", model),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget cpfCnpj(String label){
    return (
        TextFormField(
          style: TextStyle(fontSize: 18),
          keyboardType: TextInputType.number,
          controller: _cpfCnpjController,
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
          decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
        )
    );
  }

  Widget campos(String label, TextEditingController controller, TextInputType type, bool obscure, Function validator){
    return (
      TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 18),
        obscureText: obscure,
        keyboardType: type,
        validator: validator,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 18),
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
          validator: (value){
            if(value.length != 8){
              return "Senha precisa de 8 caracteres";
            }{
              return null;
            }
          },
          maxLength: 8,
          style: TextStyle(fontSize: 18),
          keyboardType: TextInputType.text,
          obscureText: exibirSenha,
          controller: _senhaController,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 18),
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

  Widget cadastrar(String label, UserModel model){
    return (
        Container(
          color: Theme.of(context).primaryColor,
          height: 40,
          width: double.infinity,
          child: FlatButton(
            disabledColor: Colors.grey,
            splashColor: Theme.of(context).primaryColorLight,
            child: Text(label, style: TextStyle(fontSize: 18, color: Colors.white),),
            onPressed: _conectado ? () async {
              if(_form.currentState.validate()){
                Map<String,dynamic> user = {
                  'nomeRazao': _nomeController.text,
                  'cpfCnpj': _cpfCnpjController.text.length > 14 ? CNPJValidator.strip(_cnpjController.text) :
                      CPFValidator.strip(_cpfController.text),
                  'telefone': _telefoneController.text,
                  'email': _emailController.text
                };
                print(_senhaController.text);
                realizarCadastro(user, _senhaController.text , model, cadastroResult, context);
              }
            } : null,
          ),
        )
    );
  }

  String nomeValidator(String name){
    if(name.isEmpty || name.length < 7 || name.split(" ").length < 2){
      return "Nome Invalido";
    }else{
      return null;
    }
  }

  String emailValidator(String email){
    if(EmailValidator.validate(email)){
      return null;
    }else{
      return "EMAIL INVALIDO";
    }
  }

  String telefoneValidator(String telefone){
    if(telefone.length < 15){
      return "Telefone Invalido";
    }else{
      return null;
    }
  }

  void cadastroResult(int codigo, String Mensagem){
    showDialog(context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        elevation: 20.0,
        title: codigo == 201 ? Text("Cadastro Efetuado",textAlign: TextAlign.center,) : Text(Mensagem, textAlign: TextAlign.center,),
        content: Icon(codigo == 201 ? Icons.check : Icons.error, color: Theme.of(context).primaryColorLight,size: 60,),
        actions: <Widget>[
          FlatButton(
            color: Theme.of(context).primaryColorLight,
            child: Text("OK",style: TextStyle(color: Colors.white,fontSize: 20),),
            onPressed: (){Navigator.pop(context);},
          ),
        ],
      )
    );
  }
}
