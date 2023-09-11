import 'package:flutter/cupertino.dart';

import '../models/authmodels/cities_model.dart';
import '../models/authmodels/countries_model.dart';
import '../models/authmodels/user_model.dart';
import '../repositories/auth_repo.dart';
import '../states/auth_states.dart';

class AuthProvider extends ChangeNotifier{
   Future<CountriesModel> getCountries()async{
    States.countriesState = CountriesState.LOADING;
    notifyListeners();
    Map response = await AuthRepositories.getCountries();
    try{
      CountriesModel countriesModel = CountriesModel.fromJson(response);
      States.countriesState = CountriesState.LOADED;
      notifyListeners();
      return countriesModel;
    }catch(e){
      States.countriesState = CountriesState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }
   Future<CitiesModel> getCities(id)async{
    States.citiesState = CitiesState.LOADING;
    notifyListeners();
    var response = await AuthRepositories.getCities(id);
    try{
      CitiesModel citiesModel = CitiesModel.fromJson(response);
      States.citiesState = CitiesState.LOADED;
      notifyListeners();
      return citiesModel;
    }catch(e){
      States.citiesState = CitiesState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<UserModel> register(formData)async{
    States.registerState = RegisterState.LOADING;
    notifyListeners();
    try{
Map response = await AuthRepositories.register(formData);
     UserModel userModel = UserModel.fromJson(response);
      States.registerState = RegisterState.LOADED;
      notifyListeners();
      // throw Exception("");
      return userModel;
    }catch(e){
      States.registerState = RegisterState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  Future<UserModel> login(formData)async{
    States.registerState = RegisterState.LOADING;
    notifyListeners();
    try{
      var response = await AuthRepositories.login(formData);
     UserModel userModel = UserModel.fromJson(response);
      States.registerState = RegisterState.LOADED;
      notifyListeners();
      return userModel;
      // throw Exception();
    }catch(e){
      States.registerState = RegisterState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  forgotPass(formData)async{
    States.registerState = RegisterState.LOADING;
    notifyListeners();
    try{
      Map response = await AuthRepositories.forgotPass(formData);
      States.registerState = RegisterState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      States.registerState = RegisterState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }



}
