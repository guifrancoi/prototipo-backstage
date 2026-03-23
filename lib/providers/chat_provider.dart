import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/conversa.dart';
import '../models/mensagem.dart';

class ChatProvider extends ChangeNotifier {
  final List<Conversa> _conversas = [...MockData.conversas];

  List<Conversa> get conversas => _conversas;

  Conversa? buscarConversaPorId(String id) {
    try {
      return _conversas.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  void enviarMensagem(String conversaId, String texto) {
    final index = _conversas.indexWhere((c) => c.id == conversaId);
    if (index == -1) return;

    _conversas[index].mensagens.add(
      Mensagem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        remetenteId: 'me',
        texto: texto,
        dataHora: DateTime.now(),
        enviadaPorMim: true,
      ),
    );

    notifyListeners();
  }
}