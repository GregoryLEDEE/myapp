import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page.dart';

import 'package:provider/provider.dart';

import 'repository/character_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CharacterListModel>(
          create: (_) => CharacterListModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Star Wars Characters App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(title: 'Star Wars Characters App'),
      ),
    );
  }
}
