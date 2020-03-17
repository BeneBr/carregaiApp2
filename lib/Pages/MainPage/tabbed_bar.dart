import 'package:carregaai/Pages/MainPage/cadastro.dart';
import 'package:carregaai/Pages/MainPage/login.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carregaai/Models/UserModel/UserModel.dart';

class TabbedBar extends StatefulWidget {

  @override
  _TabbedBarState createState() => _TabbedBarState();
}

class _TabbedBarState extends State<TabbedBar> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.none){
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("SEM CONEXAO COM A INTERNET"),
            )
        );
        setState(() {
          ScopedModel.of<UserModel>(context).setConectado(false);
        });
      }else{
        setState(() {
          ScopedModel.of<UserModel>(context).setConectado(true);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              bottom: TabBar(
                labelStyle: TextStyle(fontSize: 18),
                indicatorColor: Theme.of(context).primaryColor,
                tabs: <Widget>[
                  Tab(text: "ENTRAR", icon: Icon(Icons.person, size: 25,),),
                  Tab(text: "CADASTRAR", icon: Icon(Icons.person_add, size: 25,),),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Login(),
                Cadastro(),
              ],
            ),
          ),
        );
      }
    );
  }
}
