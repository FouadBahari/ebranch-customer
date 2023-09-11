
import 'package:e_branch_customer/repositories/public_repo.dart';

class AuthRepositories{

  static Future<Map> getCountries() async {
    return await PublicRopository.repo("countries","get");
  }

  static Future<Map> getCities(id) async {
    return await PublicRopository.repo("cities/$id","get");
  }

  static Future<Map> register(formData) async {
    return await PublicRopository.repo("signup-user","post",formData: formData);
  }

  static Future<Map> login(formData) async {
    return await PublicRopository.repo("logins","post",formData: formData);
  }

  static Future<Map> forgotPass(formData) async {
    return await PublicRopository.repo("Forget-Password","post",formData: formData);
  }

}
