import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carregaai/Models/UserModel/UserModel.dart';
import 'package:carregaai/Pages/MainPage/tabbed_bar.dart';


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
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("CarregAI", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
              body: Text("OLA"),
            )
          );
        }
    );
  }

}