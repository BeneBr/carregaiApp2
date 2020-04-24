import 'package:carregaai/Pages/MainPage/tabbed_bar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carregaai/Models/UserModel/UserModel.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  UserModel userModel = UserModel();

  runApp(

    ScopedModel<UserModel>(
      model: userModel,
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          dividerColor: Color.fromRGBO(57, 121, 107, 1),
          primaryColor: Color.fromRGBO(0, 77, 64, 1.0),
          primaryColorLight: Color.fromRGBO(57, 121, 107, 1),
          primaryColorDark: Color.fromRGBO(0, 37, 26, 1),
          cursorColor: Color.fromRGBO(0, 37, 26, 1),
          fontFamily: 'Baloo Chettan 2',
          iconTheme: IconThemeData(
            color: Color.fromRGBO(0, 37, 26, 1),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color.fromRGBO(57, 121, 107, 1),
          ),
        ),
        home: TabbedBar(),
      )
    )
  );
}



