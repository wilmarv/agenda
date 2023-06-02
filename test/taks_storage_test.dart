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
  });
}
