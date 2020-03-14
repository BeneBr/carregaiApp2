import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  bool exibirSenha = true;
  String dica = "Visualizar";

  TextEditingController _cpfController = MaskedTextController(mask: "000.000.000-00");
  TextEditingController _cnpjController = MaskedTextController(mask: "00.000.000/0000-00");
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _cpfCnpjController;

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final _telefoneController = MaskedTextController(mask: "(00)00000-0000");



  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          campos("Nome ou Razao Social", _nomeController, TextInputType.text, false),
          Divider(),
          cpfCnpj("CPF OU CNPJ"),
          Divider(),
          campos("Telefone", _telefoneController, TextInputType.number, false),
          Divider(),
          campos("Email",_emailController,TextInputType.emailAddress, false),
          Divider(),
          password("Senha"),
          Divider(),
          cadastrar("EFETUAR CADASTRO"),
          ],
        ),
      ),
    );
  }

  Widget cpfCnpj(String label){
    return (
        TextFormField(
          style: TextStyle(fontSize: 20),
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
          decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(fontSize: 25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
        )
    );
  }

  Widget campos(String label, TextEditingController controller, TextInputType type, bool obscure){
    return (
      TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 20),
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 25),
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
          style: TextStyle(fontSize: 20),
          keyboardType: TextInputType.text,
          obscureText: exibirSenha,
          controller: _senhaController,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 25),
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

  Widget cadastrar(String label){
    return (
        Container(
          color: Theme.of(context).primaryColorDark,
          height: 40,
          width: double.infinity,
          child: FlatButton(
            splashColor: Theme.of(context).primaryColorLight,
            child: Text(label, style: TextStyle(fontSize: 20, color: Colors.white),),
            onPressed: ()=>null,
          ),
        )
    );
  }
}
