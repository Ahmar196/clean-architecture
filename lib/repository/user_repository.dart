import 'package:apis_/utilis/app_url.dart';

import '../data/network/network_api_services.dart';
import '../model/user_model.dart';


class UserRepository {
  final _apiService = NetworkApiServices();

  Future<List<UserModel>> fetchUsers() async {
    final response = await _apiService.getGetApiResponse(AppUrl.users);
    return (response as List).map((json) => UserModel.fromJson(json)).toList();
  }
}
