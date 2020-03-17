import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carregaai/Models/UserModel/UserModel.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  bool conectado;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return (
              WillPopScope(
                onWillPop: sairApp,
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text("CarregAI"),
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
                                      backgroundImage: AssetImage(
                                          'images/user.png'),
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
                                        onPressed: () => null,
                                      ),
                                    )
                                  ]
                              ),
                              Text("NOME DO FULANO", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.star, color: Colors.amber,),
                                  Icon(Icons.star, color: Colors.amber,),
                                  Icon(Icons.star, color: Colors.amber,),
                                  Icon(Icons.star, color: Colors.amber,),
                                  Icon(Icons.star_half, color: Colors.amber,),
                                ],
                              )
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
                            "Minhas Demandas", style: TextStyle(fontSize: 18),),
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
                      ],
                    ),
                  ),
                ),
              )
          );
        }
    );
  }

  Future<bool> sairApp() async {
    return showDialog(context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("SAIR DO APP?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('NAO', style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 18),),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                FlatButton(
                  color: Theme.of(context).primaryColorLight,
                  child: Text('SIM', style: TextStyle(color: Colors.white, fontSize: 18),),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            )
    );
  }
}