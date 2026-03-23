import 'package:flutter/material.dart';

class AgendaProvider extends ChangeNotifier {
  final List<DateTime> _datasDisponiveis = [
    DateTime(2026, 3, 20),
    DateTime(2026, 3, 25),
    DateTime(2026, 3, 28),
  ];

  List<DateTime> get datasDisponiveis => _datasDisponiveis;

  void adicionarData(DateTime data) {
    _datasDisponiveis.add(data);
    notifyListeners();
  }

  void removerData(DateTime data) {
    _datasDisponiveis.removeWhere(
      (item) =>
          item.year == data.year &&
          item.month == data.month &&
          item.day == data.day,
    );
    notifyListeners();
  }
}