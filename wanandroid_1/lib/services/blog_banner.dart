import 'dart:convert';
import 'package:http/http.dart';
import 'package:banner_carousel/banner_carousel.dart';

class BlogBanner {
  List<BannerModel> banners = List.empty();

  Future<List<BannerModel>> getBanners() async {
    Response response =
        await get(Uri.parse('https://www.wanandroid.com/banner/json'));

    Map responseBody = JsonDecoder().convert(response.body);

    List<dynamic> data = responseBody['data'];
    if (data.isNotEmpty) {
      List<BannerModel> banners = [];
      for (var item in data) {
        banners.add(
            BannerModel(imagePath: item['imagePath'], id: '${item['order']}'));
      }

      return banners;
    }

    return List.empty();
  }
}
