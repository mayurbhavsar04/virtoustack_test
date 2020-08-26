import 'package:dio/dio.dart';
import 'package:virtoustack_test_app/model/home_data_model.dart';
import 'package:http/http.dart' as http;

class HomeDataApiService {
  static Future<List<HomeDataModel>> getHomeDta() async {
    String url = 'https://5d55541936ad770014ccdf2d.mockapi.io/api/v1/paths';

//    var dio = Dio();
//    var response = await dio.get(url);
//    List<HomeDataModel> homeDataModelList =
//        homeDataModelFromJson(response.);
//
//    return homeDataModelList;

    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        final List<HomeDataModel> homeDataModelList = homeDataModelFromJson(response.body);
        return homeDataModelList;
      }else{
        print("Erorrrr");

        return List<HomeDataModel>();
      }

    }catch(e){
      print("Erorrrr");
      print(e);
      return List<HomeDataModel>();
    }

  }
}
