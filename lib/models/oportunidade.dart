class Oportunidade {
  final String id;
  final String titulo;
  final String descricao;
  final String cidade;
  final String generoMusical;
  final DateTime dataEvento;
  final double cacheOferecido;
  final String contratante;
  final bool interesseEnviado;

  Oportunidade({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.cidade,
    required this.generoMusical,
    required this.dataEvento,
    required this.cacheOferecido,
    required this.contratante,
    bool? interesseEnviado,
  }) : interesseEnviado = interesseEnviado ?? false;

  Oportunidade copyWith({
    String? id,
    String? titulo,
    String? descricao,
    String? cidade,
    String? generoMusical,
    DateTime? dataEvento,
    double? cacheOferecido,
    String? contratante,
    bool? interesseEnviado,
  }) {
    return Oportunidade(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      cidade: cidade ?? this.cidade,
      generoMusical: generoMusical ?? this.generoMusical,
      dataEvento: dataEvento ?? this.dataEvento,
      cacheOferecido: cacheOferecido ?? this.cacheOferecido,
      contratante: contratante ?? this.contratante,
      interesseEnviado: interesseEnviado ?? this.interesseEnviado,
    );
  }
}