import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../models/expense.dart";
import "../services/expense_repository.dart";

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key, required this.repository});

  final ExpenseRepository repository;

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  String _category = "Food";
  DateTime _date = DateTime.now();

  static const _categories = [
    "Food",
    "Transport",
    "Shopping",
    "Bills",
    "Other",
  ];

  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    final title = _title.text.trim();
    final raw = _amount.text.trim();
    final amount = double.tryParse(raw.replaceAll(",", "."));
    if (title.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a title and a valid amount.")),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      await widget.repository.add(
        Expense(
          userId: widget.repository.userId,
          title: title,
          amount: amount,
          category: _category,
          date: _date,
        ),
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Save failed: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 20 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("New expense", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _title,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: "What was it?",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9.,]")),
            ],
            decoration: const InputDecoration(
              labelText: "Amount",
              border: OutlineInputBorder(),
              prefixText: "\$ ",
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((c) {
              final selected = c == _category;
              return FilterChip(
                label: Text(c),
                selected: selected,
                onSelected: (_) => setState(() => _category = c),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today_outlined),
            label: Text(
              MaterialLocalizations.of(context).formatFullDate(_date),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text("Save"),
          ),
        ],
      ),
    );
  }
}
