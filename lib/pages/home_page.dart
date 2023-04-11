import 'package:flutter/material.dart';
import 'package:myapp/widgets/character_dashboard.dart';
import 'package:myapp/widgets/character_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.list),
                text: 'Characters list',
              ),
              Tab(
                icon: Icon(Icons.dashboard),
                text: 'Dashboard',
              ),
            ],
          ),
          title: Text(widget.title),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              CharacterListScreen(),
              CharacterDashboardScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
