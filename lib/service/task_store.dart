import 'dart:convert';
import 'package:agenda/model/tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskStorageService {
  static const String storageKey = 'tarefas_storage';

  Future<List<Tarefa>> getAllTarefas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTasks = prefs.getString(storageKey);

    if (storedTasks != null) {
      List<dynamic> decodedTasks = jsonDecode(storedTasks);
      List<Tarefa> tarefas =
          decodedTasks.map((task) => Tarefa.fromJson(task)).toList();
      return tarefas;
    }
    return [];
  }

  Future<void> salvaTarefa(Tarefa tarefa) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Tarefa> tarefas = await getAllTarefas();
    int id = tarefas.length;
    tarefa.id = id;
    tarefas.add(tarefa);
    String encodedTasks = jsonEncode(tarefas);
    await prefs.setString(storageKey, encodedTasks);
  }

  Future<void> finalizaTarefa(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Tarefa> tarefas = await getAllTarefas();
    for (int i = 0; i < tarefas.length; i++) {
      if (tarefas[i].id == id) {
        tarefas[i].finalizado = true;
        break;
      }
    }
    String encodedTasks = jsonEncode(tarefas);
    await prefs.setString(storageKey, encodedTasks);
  }

  Future<void> deletaTarefa(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Tarefa> tasks = await getAllTarefas();
    tasks.removeWhere((task) => task.id == id);
    String encodedTasks = jsonEncode(tasks);
    await prefs.setString(storageKey, encodedTasks);
  }
}
