import 'package:app_tarefas/core/database_helper.dart';
import 'package:app_tarefas/data/model/tarefas_model.dart';
import 'package:sqflite/sqflite.dart';

class TarefaRepository {
  // Inserir uma nova tarefa
  Future<void> insertTarefa(Tarefa tarefa) async {
    final db = await TaskDatabaseHelper.getDatabase();
    await db.insert(
      'tarefas',
      tarefa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obter todas as tarefas
  Future<List<Tarefa>> getTarefas() async {
    final db = await TaskDatabaseHelper.getDatabase();
    final List<Map<String, dynamic>> tarefaMaps = await db.query('tarefas');

    return tarefaMaps.map((map) => Tarefa.fromMap(map)).toList();
  }

  // Atualizar uma tarefa existente
  Future<void> updateTarefa(Tarefa tarefa) async {
    final db = await TaskDatabaseHelper.getDatabase();
    await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  // Excluir uma tarefa
  Future<void> deleteTarefa(int id) async {
    final db = await TaskDatabaseHelper.getDatabase();
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
