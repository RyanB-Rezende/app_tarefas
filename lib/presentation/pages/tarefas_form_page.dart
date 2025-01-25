import 'package:app_tarefas/data/model/tarefas_model.dart';
import 'package:app_tarefas/data/repositories/tarefas_repositeries.dart';
import 'package:flutter/material.dart';
import 'package:in':

class TaskFormPage extends StatefulWidget {
  const TaskFormPage({super.key});

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  String _status = 'pendente';
  DateTime _dataInicio = DateTime.now();
  DateTime? _dataFim;

  final TarefaRepository _repository = TarefaRepository();

  // Função para salvar a tarefa
  Future<void> _saveTask() async {
    if (_formKey.currentState?.validate() ?? false) {
      final tarefa = Tarefa(
        nome: _nomeController.text,
        descricao: _descricaoController.text,
        status: _status,
        dataInicio: DateFormat('yyyy-MM-dd').format(_dataInicio),
        dataFim: _dataFim != null ? DateFormat('yyyy-MM-dd').format(_dataFim!) : null,
      );

      await _repository.insertTarefa(tarefa);
      Navigator.pop(context); // Volta para a tela anterior após salvar
    }
  }

  // Função para selecionar a data de início
  Future<void> _selectDataInicio(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataInicio,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dataInicio) {
      setState(() {
        _dataInicio = picked;
      });
    }
  }

  // Função para selecionar a data de término
  Future<void> _selectDataFim(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataFim ?? _dataInicio,
      firstDate: _dataInicio,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dataFim) {
      setState(() {
        _dataFim = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Tarefa',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da tarefa';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                maxLines: 3,
              ),
              DropdownButtonFormField<String>(
                value: _status,
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                items: <String>['pendente', 'em andamento', 'concluído']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              ListTile(
                title: Text('Data de Início: ${DateFormat('yyyy-MM-dd').format(_dataInicio)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDataInicio(context),
              ),
              if (_dataFim != null)
                ListTile(
                  title: Text('Data de Término: ${DateFormat('yyyy-MM-dd').format(_dataFim!)}'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _selectDataFim(context),
                ),
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
