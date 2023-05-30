class Tarefa {
  int? id;
  String nome;
  String descricao;
  bool finalizado;

  Tarefa({
    this.id,
    this.nome = "",
    this.descricao = "",
    this.finalizado = false,
  });

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
        id: json['id'],
        nome: json['nome'],
        descricao: json['descricao'],
        finalizado: json['finalizado']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'finalizado': finalizado
    };
  }
}
