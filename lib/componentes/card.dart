import 'package:agenda/componentes/text.dart';
import 'package:agenda/service/task_store.dart';
import 'package:agenda/model/tarefa.dart';
import 'package:flutter/material.dart';

class TarefaCard extends StatefulWidget {
  const TarefaCard(
      {super.key, required this.tarefa, required this.paginaIndex});

  final Tarefa tarefa;
  final int paginaIndex;

  @override
  State<TarefaCard> createState() => _TarefaCardState();
}

class _TarefaCardState extends State<TarefaCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 160,
        child: GestureDetector(
          onDoubleTap: () async {
            TaskStorageService taskStorageService = TaskStorageService();
            if (widget.paginaIndex == 0) {
              if (widget.tarefa.id != null) {
                await taskStorageService.deletaTarefa(widget.tarefa.id as int);
              }
            }
            if (widget.paginaIndex == 1) {
              if (widget.tarefa.id != null) {
                await taskStorageService
                    .finalizaTarefa(widget.tarefa.id as int);
              }
            }
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Define o raio da borda
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 22,
                  width: MediaQuery.of(context).size.width,
                  child: CustomText(widget.tarefa.nome,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center),
                ),
                const Divider(
                  color: Colors.blueGrey,
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: CustomText(widget.tarefa.descricao,
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 16),
                          textAlign: TextAlign.start)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration: BoxDecoration(
                    color: widget.tarefa.finalizado
                        ? Colors.green
                        : Colors.blue[300],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
