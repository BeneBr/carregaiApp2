import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carregaai/Models/UserModel/UserModel.dart';
import '../MainPage/tabbed_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carregaai/Controllers/UserController.dart';
import 'package:carregaai/Pages/Demands/addresses.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  bool conectado;
  String foto;
  String imagemEncoded;
  String nomeRazao;
  String cpfCnpj;
  String token;
  double pontos;

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          foto = model.getFoto();
          nomeRazao = model.getNomeRazao();
          cpfCnpj = model.getCpnCnpj();
          pontos = model.getPontos();
          token = model.getToken();

          return (
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("CarregAI", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Demands()));
                },
                ),
              drawer: Drawer(
                elevation: 10.0,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Column(
                        children: <Widget>[
                          Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: foto == null ? AssetImage( 'images/user.png') : MemoryImage( base64Decode(foto)),
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                ),
                                Positioned(
                                  top: 40,
                                  left: 15,
                                  child: IconButton(
                                    icon: Icon(Icons.edit, size: 30,),
                                    color: Colors.white,
                                    splashColor: Colors.grey,
                                    onPressed: (){
                                      tirarFoto();
                                    },
                                  ),
                                )
                              ]
                          ),
                          Text(nomeRazao, style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                          Text(cpfCnpj, style: TextStyle(color: Colors.white, fontSize: 16),)
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .primaryColorLight
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Minhas Solicitações", style: TextStyle(fontSize: 18),),
                      onTap: () => null,
                      leading: Image(
                        image: AssetImage('images/product.png'),
                        width: 40,
                        height: 40,),
                    ),
                    ListTile(
                      title: Text(
                        "Minhas Entregas", style: TextStyle(fontSize: 18),),
                      onTap: () => null,
                      leading: Image(
                        image: AssetImage('images/shipping.png'),
                        width: 40,
                        height: 40,),
                    ),
                    ListTile(
                      title: Text("Saldo", style: TextStyle(fontSize: 18),),
                      onTap: () => null,
                      leading: Image(image: AssetImage('images/profit.png'),
                        width: 40,
                        height: 40,),
                    ),
                    ListTile(
                      title: Text("Sair do App", style: TextStyle(fontSize: 18)),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TabbedBar()));
                      },
                      leading: Image(image: AssetImage('images/exit_app.png'),
                        width: 30,
                      )
                    ),
                  ],
                ),
              ),
              body: Center(
                
              )
            )
          );
        }
    );
  }

  void tirarFoto() async {
    var imagem = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 5);
    if(imagem != null){
       ScopedModel.of<UserModel>(context).setFoto(base64Encode(imagem.readAsBytesSync()));
      setState(() {
        foto = ScopedModel.of<UserModel>(context).getFoto();
      });
      enviarFoto(cpfCnpj, foto, token);
    }
  }
}