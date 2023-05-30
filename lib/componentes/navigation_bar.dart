import 'package:agenda/componentes/icone.dart';
import 'package:flutter/material.dart';

class BarraNavegacao extends StatefulWidget {
  const BarraNavegacao(
      {super.key, required this.indexPageSelecionada, required this.setState});

  final int indexPageSelecionada;
  final void Function(int) setState;

  @override
  State<BarraNavegacao> createState() => _BarraNavegacaoState();
}

class _BarraNavegacaoState extends State<BarraNavegacao> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.blue[300],
      onDestinationSelected: widget.setState,
      selectedIndex: widget.indexPageSelecionada,
      destinations: <Widget>[
        NavigationDestination(
          icon: defaultIcon(DefaultIcon.procurar),
          label: "Todas as tarefas",
        ),
        NavigationDestination(
          icon: defaultIcon(DefaultIcon.pendentes),
          label: 'Pendentes',
        ),
        NavigationDestination(
          icon: defaultIcon(DefaultIcon.calendar),
          label: 'Novas Tarefas',
        ),
      ],
    );
  }
}
