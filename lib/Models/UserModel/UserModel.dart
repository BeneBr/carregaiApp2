import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{
  bool carregando;
  bool conectado = true;
  String nomeRazao;
  String cpfCnpj;
  String telefone;
  String email;
  String foto;

  void setNomeRazao(String nomeRazao){
    this.nomeRazao = nomeRazao;
    notifyListeners();
  }

  void setcpfCnpj(String cpfCnpj){
    this.cpfCnpj = cpfCnpj;
    notifyListeners();
  }

  void setTelefone(String telefone){
    this.telefone = telefone;
    notifyListeners();
  }

  void setEmail(String email){
    this.email = email;
    notifyListeners();
  }

  void setFoto(String foto){
    this.foto = foto;
    notifyListeners();
  }
}