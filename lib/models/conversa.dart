import 'mensagem.dart';

class Conversa {
  final String id;
  final String nomeContato;
  final List<Mensagem> mensagens;

  Conversa({
    required this.id,
    required this.nomeContato,
    required this.mensagens,
  });

  String get ultimaMensagem =>
      mensagens.isNotEmpty ? mensagens.last.texto : 'Sem mensagens';
}