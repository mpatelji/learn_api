import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:learn_api/user_data_model.dart';


class HomeScreenProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<UsersIteamModel> list = [];

  bool get isLoading => _isLoading;
  List<UsersIteamModel> get Data => list;

  final  String _baseUrl = 'https://api.unsplash.com/photos';
  final String _apiKey = 'iLArk3rxHqOxWZqJ6CEod7Gz1qmybMquEcIgAG9vKD8';

  void setIsLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  void setPhotos(List<UsersIteamModel> usersIteamModel) {
    list = usersIteamModel;
    notifyListeners();
  }

  Future<void> fetchPhotos() async {
    setIsLoading(true);
    try {
      final response = await http.get(Uri.parse('$_baseUrl/?client_id=$_apiKey'));
      if (response.statusCode == 200) {
        var data = usersIteamModelFromJson(response.body);
        setPhotos(data);
        setIsLoading(false);
      } else {
        setIsLoading(false);
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      setIsLoading(false);

      print(e);

    } finally {
      setIsLoading(false);
    }
  }
}
















//
// import 'dart:convert';
//
//
// import 'package:wallpaper_api/users_modal_class.dart';
// import 'package:http/http.dart' as http;
//
// class UsersDetails {
//   Future<List<UsersModel>>getImage()async{
//     var apiUrl = Uri.parse("https://api.unsplash.com/photos");
//     var headers = {
//       "Authorization": 'Client-ID E_wuGUqCN5SoXjyI0S1vq5Yd2wmirPjWGdHhmerPELg'
//     };
//     var responce = await http.get(apiUrl,headers: headers);
//     if(responce.statusCode == 200){
//       print("secc");
//       var decode = jsonDecode(responce.body)as List;
//       var data =decode.map((json) => UsersModel.fromJson(json)).toList() ;
//       return data;
//     }else{
//       return [];
//     }
//   }
//
//
// }