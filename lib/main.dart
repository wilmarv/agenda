import 'package:flutter/material.dart';
import 'package:agenda/componentes/navigation_bar.dart';
import 'package:agenda/componentes/text.dart';
import 'package:agenda/componentes/card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Simples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Agenda Simples'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexPageSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            title: const CustomText("Agenda Simples",
                style: TextStyle(fontWeight: FontWeight.bold))),
        bottomNavigationBar: BarraNavegacao(
          indexPageSelecionada: indexPageSelecionada,
          setState: (int index) {
            setState(() {
              indexPageSelecionada = index;
            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [TarefaCard()]),
        ));
  }
}
