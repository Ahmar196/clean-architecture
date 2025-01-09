import 'package:apis_/utilis/app_url.dart';

import '../data/network/network_api_services.dart';
import '../model/photos.dart';


class PhotosRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<Photos>> fetchPhotos() async {
    final response = await _apiServices.getGetApiResponse(AppUrl.photos);
    return (response as List).map((json) => Photos.fromJson(json)).toList();
  }
}
