class Mensagem {
  final String id;
  final String remetenteId;
  final String texto;
  final DateTime dataHora;
  final bool enviadaPorMim;

  Mensagem({
    required this.id,
    required this.remetenteId,
    required this.texto,
    required this.dataHora,
    required this.enviadaPorMim,
  });
}