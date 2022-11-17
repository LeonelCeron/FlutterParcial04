import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Gestion de usuarios"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.supervised_user_circle
                ),
                text: "Agregar",
              )
            ]
          ),
        )
      ),
    );
  }
}