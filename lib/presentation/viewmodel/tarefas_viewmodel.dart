import 'package:app_tarefas/data/model/tarefas_model.dart';
import 'package:app_tarefas/data/repositories/tarefas_repositeries.dart';
import 'package:flutter/material.dart';

class TaskViewModel extends ChangeNotifier {
  final TarefaRepository _repository = TarefaRepository();
  List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas => _tarefas;

  // Carregar todas as tarefas
  Future<void> loadTarefas() async {
    _tarefas = await _repository.getTarefas();
    notifyListeners();
  }

  // Adicionar uma nova tarefa
  Future<void> addTarefa(Tarefa tarefa) async {
    await _repository.insertTarefa(tarefa);
    await loadTarefas(); // Recarrega a lista após a inserção
  }

  // Atualizar uma tarefa existente
  Future<void> updateTarefa(Tarefa tarefa) async {
    await _repository.updateTarefa(tarefa);
    await loadTarefas(); // Recarrega a lista após a atualização
  }

  // Excluir uma tarefa
  Future<void> deleteTarefa(int id) async {
    await _repository.deleteTarefa(id);
    await loadTarefas(); // Recarrega a lista após a exclusão
  }
}
