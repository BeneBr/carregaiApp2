import 'dart:ffi';
import 'package:scoped_model/scoped_model.dart';

class DemandsModel extends Model {
  bool isLoading = false;

  bool empresa;
  bool aceito = false;
  bool pago = false;

  Map<String,dynamic> _enderecoOrigem = {"Endereco": "", "Numero": "", "Complemento": ""};
  Map<String, dynamic> _enderecoDestino = {"Endereco": "", "Numero": "", "Complemento": ""};

  String nomeRequisitante;
  String cpfCnpjRequisitante;
  String nomeEntregador;
  String cpfCnpjEntregador;

  List<String> fotos;
  String tempo;
  int distancia;
  Float preco;

  void setEnderecoOrigem(String endereco, int numero, String complemento){
    this._enderecoOrigem["Endereco"] = endereco;
    this._enderecoOrigem["Numero"] = numero;
    this._enderecoOrigem["Complemento"] = complemento;
  }

  void setEnderecoDestino(String endereco, int numero, String complemento){
    this._enderecoDestino["Endereco"] = endereco;
    this._enderecoDestino["Numero"] = numero;
    this._enderecoDestino["Complemento"] = complemento;
  }

  void getEnderecoOrigem(){
    print(this._enderecoOrigem);
  }
  void getEnderecoDestino(){
    print(this._enderecoDestino);
  }


  void setPreco(Float preco){
    this.preco = preco;
    notifyListeners();
  }

}