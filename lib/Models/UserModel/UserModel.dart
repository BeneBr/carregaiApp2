import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{
  bool _carregando = false;
  bool _conectado = true;
  String _token;
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

  String getCpnCnpj(){
    return this._cpfCnpj;
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
  String getFoto(){
    return this._foto;
  }

  void setPontos(double pontos){
    this._pontos = pontos;
    notifyListeners();
  }

  double getPontos(){
    return this._pontos;
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

  void setToken(String token){
    this._token = token;
    notifyListeners();
  }

  String getToken(){
    return this._token;
  }
}