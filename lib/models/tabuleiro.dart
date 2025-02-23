import 'dart:math';

import 'campo.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int quantidadeDeBombas;
  final List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.quantidadeDeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  List<Campo> get campos => _campos;

  bool get resolvido => _campos.every((campo) => campo.resolvido);

  void _criarCampos() {
    for (int linha = 0; linha < linhas; linha++) {
      for (int coluna = 0; coluna < colunas; coluna++) {
        _campos.add(Campo(linha: linha, coluna: coluna));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    var sortadas = 0;

  if(quantidadeDeBombas > linhas * colunas){
    return;
  }

    while (sortadas < quantidadeDeBombas) {
      int i = Random().nextInt(_campos.length);
      if (_campos[i].minado) {
        sortadas++;
        _campos[i].minar();
      }
    }
  }

  void revelarBombas() {
    _campos.forEach((campo) => campo.revelarBomba());
  }

  void reiniciar() {
    _campos.forEach((campo) => campo.reiniciar());
    _sortearMinas();
  }
}