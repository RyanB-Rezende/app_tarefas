class Tarefa {
  final int? id;
  final String nome;
  final String? descricao;
  final String status;
  final String dataInicio;
  final String? dataFim;

  Tarefa({
    this.id,
    required this.nome,
    this.descricao,
    required this.status,
    required this.dataInicio,
    required this.dataFim,
  });

  // Converte um objeto Tarefa para um Map (para inserção no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'status': status,
      'data_inicio': dataInicio,
      'data_fim': dataFim,
    };
  }

  // Converte um Map do banco para um objeto Tarefa
  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String?,
      status: map['status'] as String,
      dataInicio: map['data_inicio'] as String,
      dataFim: map['data_fim'] as String,
    );
  }
}
