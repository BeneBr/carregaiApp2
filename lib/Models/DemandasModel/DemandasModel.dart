import 'dart:ffi';
import 'package:scoped_model/scoped_model.dart';

class DemandsModel extends Model {
  bool isLoading = false;

  bool forBusiness;
  bool accepted = false;
  bool alreadyPay = false;

  String requesterName;
  String cpfCnpjRequester;
  String deliveryManName;
  String cpfCnpjDeliveryMan;

  List<String> photos;
  Map<String, dynamic> _origem;
  Map<String, dynamic> _destino;
  String time;
  int distance;
  Float price;

  void setOrigem(String endereco, int numero, String complemento){
    this._origem = {
      'Endereco' : endereco,
      'Numero' : numero,
      'Complemento' : complemento
    };
  }
  void setDestino(String endereco, int numero, String complemento){
    this._destino = {
      'Endereco' : endereco,
      'Numero' : numero,
      'Complemento' : complemento
    };
  }

  Map<String, dynamic> getOrigem(){
    return this._origem;
  }
  Map<String, dynamic> getDestino(){
    return this._origem;
  }

}