import "package:agenda/componentes/card.dart";
import "package:agenda/componentes/text.dart";
import "package:agenda/controller/task_store.dart";
import "package:agenda/model/tarefa.dart";
import "package:flutter/material.dart";

class TodasAsTarefas extends StatefulWidget {
  const TodasAsTarefas({super.key});

  @override
  State<TodasAsTarefas> createState() => _TodasAsTarefasState();
}

class _TodasAsTarefasState extends State<TodasAsTarefas> {
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
              return TarefaCard(tarefa: tarefa, paginaIndex: 0);
            },
          );
        } else {
          return const Text('Nenhuma tarefa encontrada');
        }
      },
    );
  }
}