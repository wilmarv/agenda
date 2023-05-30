import 'package:agenda/componentes/text.dart';
import 'package:agenda/controller/task_store.dart';
import 'package:agenda/model/tarefa.dart';
import "package:flutter/material.dart";

class AdicionarTarefa extends StatefulWidget {
  const AdicionarTarefa({super.key, required this.setState});

  final void Function(int) setState;
  
  @override
  State<AdicionarTarefa> createState() => _AdicionarTarefaState();
}

class _AdicionarTarefaState extends State<AdicionarTarefa> {
  TextEditingController textNomeController = TextEditingController();
  TextEditingController textDescricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(height: 30, color: Colors.transparent),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextField(
            controller: textNomeController,
            decoration: InputDecoration(
              hintText: 'Nome da tarefa',
              prefixIcon: const Icon(Icons.check_circle),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
          ),
        ),
        const Divider(height: 30, color: Colors.transparent),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextField(
            controller: textDescricaoController,
            decoration: InputDecoration(
              hintText: 'Descrição da Tarefa',
              prefixIcon: const Icon(Icons.description),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
          ),
        ),
        const Divider(height: 30, color: Colors.transparent),
        ElevatedButton(
          onPressed: () async {
            Tarefa novaTarefa = Tarefa(
                nome: textNomeController.text,
                descricao: textDescricaoController.text);
            TaskStorageService taskStorageService = TaskStorageService();
            textNomeController.text = "";
            textDescricaoController.text = "";
            await taskStorageService.salvaTarefa(novaTarefa);
            widget.setState(1);
          },
          child: const CustomText(
            'Adicionar tarefa',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
