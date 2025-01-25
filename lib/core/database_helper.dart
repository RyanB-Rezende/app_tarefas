import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDatabaseHelper {
  static Future<Database> initDb() async {
    // Obtém o caminho do banco de dados
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tasks.db');

    // Abre ou cria o banco de dados
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Criação da tabela de tarefas
        await db.execute('''
          CREATE TABLE tarefas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            descricao TEXT,
            status TEXT NOT NULL,
            data_inicio TEXT NOT NULL,
            data_fim TEXT NOT NULL
          );
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Adicione lógica de upgrade de versão, se necessário
      },
    );
  }

  // Método para obter o banco de dados
  static Future<Database> getDatabase() async {
    return await initDb();
  }
}
