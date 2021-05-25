import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  var _selectDate = DateTime.now();

  _onSubmit() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              onSubmitted: (_) => _onSubmit(),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _onSubmit(),
              controller: _valueController,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectDate == null
                        ? 'Nenhuma data selecionada!'
                        : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectDate)}'),
                  ),
                  TextButton(
                    child: Text('Selecionar Data'),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text(
                    'Nova transação',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
