class Oportunidade {
  final String id;
  final String titulo;
  final String descricao;
  final String cidade;
  final String generoMusical;
  final DateTime dataEvento;
  final double cacheOferecido;
  final String contratante;

  Oportunidade({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.cidade,
    required this.generoMusical,
    required this.dataEvento,
    required this.cacheOferecido,
    required this.contratante,
  });
}