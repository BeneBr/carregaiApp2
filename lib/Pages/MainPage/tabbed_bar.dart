import 'package:carregaai/Pages/MainPage/cadastro.dart';
import 'package:carregaai/Pages/MainPage/login.dart';
import 'package:flutter/material.dart';



class TabbedBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            tabs: <Widget>[
              Tab(text: "ENTRAR", icon: Icon(Icons.person),),
              Tab(text: "CADASTRAR", icon: Icon(Icons.person_add),),
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
}
