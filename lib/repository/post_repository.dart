import 'package:apis_/utilis/app_url.dart';

import '../data/network/network_api_services.dart';
import '../model/post_model.dart';


class PostRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<PostModel>> fetchPosts() async {
    final response = await _apiServices.getGetApiResponse(AppUrl.posts);
    return (response as List).map((json) => PostModel.fromJson(json)).toList();
  }
}
