// This is a basic Flutter widget test.
import 'package:agenda/model/tarefa.dart';
import 'package:agenda/service/task_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'taks_storage_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('TaskStorageService', () {
    late TaskStorageService taskStorageService;
    late MockSharedPreferences mockSharedPreferences;
    SharedPreferences.setMockInitialValues({});
    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      taskStorageService = TaskStorageService();
    });

    group("getAllTarefas", () {
      test('Deve retornar uma lista vazia.', () async {
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas, []);
      });
    });

    group("salvaTarefa", () {
      test("Deve salvar 1 tarefa com sucesso", () async {
        Tarefa novaTarefa = Tarefa();
        novaTarefa.id = 0;
        novaTarefa.nome = "Finalizar testes ao projeto";
        novaTarefa.finalizado = false;

        await taskStorageService.salvaTarefa(novaTarefa);

        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 1);
        expect(tarefasAmazenadas[0].id, 0);
        expect(tarefasAmazenadas[0].finalizado, false);
      });
    });

    group("finalizaTarefa ", () {
      test("Deve passar a tarefa para status finalizado pelo Id", () async {
        await taskStorageService.finalizaTarefa(0);

        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 1);
        expect(tarefasAmazenadas[0].id, 0);
        expect(tarefasAmazenadas[0].finalizado, true);
      });
    });

    group("deletaTarefa ", () {
      test("Deve apagar a tarefa pelo id", () async {
        await taskStorageService.deletaTarefa(0);

        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 0);
      });
    });

    group("Testes de integração", () {
      setUp(() {
        SharedPreferences.setMockInitialValues({});
        mockSharedPreferences = MockSharedPreferences();
        taskStorageService = TaskStorageService();
      });

      test(
          "Deve iniciar com array vazio, salvar 1 tarefa e retornar apenas 1 tarefa",
          () async {
        Tarefa novaTarefa = Tarefa();
        novaTarefa.id = 0;
        novaTarefa.nome = "Finalizar testes ao projeto";
        novaTarefa.finalizado = false;

        when(mockSharedPreferences.getString(any)).thenReturn(null);
        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas, []);

        await taskStorageService.salvaTarefa(novaTarefa);

        tarefasAmazenadas = await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 1);
        expect(tarefasAmazenadas[0].id, 0);
        expect(tarefasAmazenadas[0].finalizado, false);
      });

      test(
          "Deve iniciar com array vazio, salvar 2 tarefa e retornar apenas 2 tarefa",
          () async {
        Tarefa novaTarefa = Tarefa();
        novaTarefa.id = 0;
        novaTarefa.nome = "Finalizar testes ao projeto";
        novaTarefa.finalizado = false;

        Tarefa novaTarefa2 = Tarefa();
        novaTarefa2.id = 1;
        novaTarefa2.nome = "Gravar video para o projeto";
        novaTarefa2.finalizado = false;

        when(mockSharedPreferences.getString(any)).thenReturn(null);
        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas, []);

        await taskStorageService.salvaTarefa(novaTarefa);
        await taskStorageService.salvaTarefa(novaTarefa2);

        tarefasAmazenadas = await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 2);
      });

      test(
          "Deve iniciar com array vazio, salvar 2 tarefa, deleter a primeira tarefa e retornar apenas 1",
          () async {
        Tarefa novaTarefa = Tarefa();
        novaTarefa.id = 0;
        novaTarefa.nome = "Finalizar testes ao projeto";
        novaTarefa.finalizado = false;

        Tarefa novaTarefa2 = Tarefa();
        novaTarefa2.id = 1;
        novaTarefa2.nome = "Gravar video para o projeto";
        novaTarefa2.finalizado = false;

        when(mockSharedPreferences.getString(any)).thenReturn(null);
        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas, []);

        await taskStorageService.salvaTarefa(novaTarefa);
        await taskStorageService.salvaTarefa(novaTarefa2);

        tarefasAmazenadas = await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 2);

        await taskStorageService.deletaTarefa(0);

        tarefasAmazenadas = await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 1);
        expect(tarefasAmazenadas[0].id, 1);
      });

      test(
          "Deve iniciar com array vazio, salvar 2 tarefa, segunda tarefa deve retornar como finalizadas",
          () async {
        Tarefa novaTarefa = Tarefa();
        novaTarefa.id = 0;
        novaTarefa.nome = "Finalizar testes ao projeto";
        novaTarefa.finalizado = false;

        Tarefa novaTarefa2 = Tarefa();
        novaTarefa2.id = 1;
        novaTarefa2.nome = "Gravar video para o projeto";
        novaTarefa2.finalizado = false;

        when(mockSharedPreferences.getString(any)).thenReturn(null);
        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas, []);

        await taskStorageService.salvaTarefa(novaTarefa);
        await taskStorageService.salvaTarefa(novaTarefa2);

        tarefasAmazenadas = await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 2);
        await taskStorageService.finalizaTarefa(1);
        tarefasAmazenadas = await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas[0].id, 0);
        expect(tarefasAmazenadas[0].finalizado, false);
        expect(tarefasAmazenadas[1].id, 1);
        expect(tarefasAmazenadas[1].finalizado, true);
      });

      test(
          "Deve iniciar com array vazio, salvar 2 tarefa, primeira tarefa deve retornar como finalizadas",
          () async {
        Tarefa novaTarefa = Tarefa();
        novaTarefa.id = 0;
        novaTarefa.nome = "Finalizar testes ao projeto";
        novaTarefa.finalizado = false;

        Tarefa novaTarefa2 = Tarefa();
        novaTarefa2.id = 1;
        novaTarefa2.nome = "Gravar video para o projeto";
        novaTarefa2.finalizado = false;

        when(mockSharedPreferences.getString(any)).thenReturn(null);
        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas, []);

        await taskStorageService.salvaTarefa(novaTarefa);
        await taskStorageService.salvaTarefa(novaTarefa2);

        await taskStorageService.finalizaTarefa(0);

        tarefasAmazenadas = await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 2);
        expect(tarefasAmazenadas[0].id, 0);
        expect(tarefasAmazenadas[0].finalizado, true);
        expect(tarefasAmazenadas[1].id, 1);
        expect(tarefasAmazenadas[1].finalizado, false);
      });

      test(
          "Deve iniciar com array vazio, salvar 2 tarefa, finalizar primeira e tarefa e deletar a segunda tarefa",
          () async {
        Tarefa novaTarefa = Tarefa();
        novaTarefa.id = 0;
        novaTarefa.nome = "Finalizar testes ao projeto";
        novaTarefa.finalizado = false;

        Tarefa novaTarefa2 = Tarefa();
        novaTarefa2.id = 1;
        novaTarefa2.nome = "Gravar video para o projeto";
        novaTarefa2.finalizado = false;

        when(mockSharedPreferences.getString(any)).thenReturn(null);
        List<Tarefa> tarefasAmazenadas =
            await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas, []);

        await taskStorageService.salvaTarefa(novaTarefa);
        await taskStorageService.salvaTarefa(novaTarefa2);

        await taskStorageService.finalizaTarefa(0);
        await taskStorageService.deletaTarefa(1);

        tarefasAmazenadas = await taskStorageService.getAllTarefas();

        expect(tarefasAmazenadas.length, 1);
        expect(tarefasAmazenadas[0].id, 0);
        expect(tarefasAmazenadas[0].finalizado, true);
      });
    });
  });
}
