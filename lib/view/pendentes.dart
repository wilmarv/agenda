import 'package:agenda/componentes/card.dart';
import 'package:agenda/componentes/text.dart';
import 'package:agenda/service/task_store.dart';
import 'package:agenda/model/tarefa.dart';
import "package:flutter/material.dart";

class Pendentes extends StatefulWidget {
  const Pendentes({super.key});

  @override
  State<Pendentes> createState() => _PendentesState();
}

class _PendentesState extends State<Pendentes> {
  late Future<List<Tarefa>> _listaTarefasSalvas;

  @override
  void initState() {
    super.initState();
    _listaTarefasSalvas = TaskStorageService().getAllTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tarefa>>(
      future: _listaTarefasSalvas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const CustomText('Erro ao carregar as tarefas');
        } else if (snapshot.hasData) {
          List<Tarefa> taskList = snapshot.data!;
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              Tarefa tarefa = taskList[index];
              if (tarefa.finalizado == false) {
                return TarefaCard(
                  tarefa: tarefa,
                  paginaIndex: 1,
                );
              }
              return Container();
            },
          );
        } else {
          return const Text('Nenhuma tarefa encontrada');
        }
      },
    );
  }
}
