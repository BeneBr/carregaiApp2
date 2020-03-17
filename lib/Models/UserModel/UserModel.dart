import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{
  bool _carregando = false;
  bool _conectado = true;
  String _nomeRazao;
  String _cpfCnpj;
  String _telefone;
  String _email;
  String _foto;
  double _pontos;

  void setCarregando(bool valor){
    this._carregando = valor;
    notifyListeners();
  }

  void setConectado(bool valor){
    this._conectado = valor;
    notifyListeners();
  }

  void setNomeRazao(String nomeRazao){
    this._nomeRazao = nomeRazao;
    notifyListeners();
  }

  void setcpfCnpj(String cpfCnpj){
    this._cpfCnpj = cpfCnpj;
    notifyListeners();
  }

  void setTelefone(String telefone){
    this._telefone = telefone;
    notifyListeners();
  }

  void setEmail(String email){
    this._email = email;
    notifyListeners();
  }

  void setFoto(String foto){
    this._foto = foto;
    notifyListeners();
  }

  String getNomeRazao(){
    return this._nomeRazao;
  }

  bool getConectado(){
    return this._conectado;
  }

  bool getCarregando(){
    return this._carregando;
  }
}