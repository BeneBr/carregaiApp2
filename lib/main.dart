import 'package:carregaai/Pages/MainPage/tabbed_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(
    MaterialApp(
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
      ),
      home: TabbedBar(),
    )
);


