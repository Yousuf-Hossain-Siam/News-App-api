import 'package:news_app_api/model/categories_news_model.dart';
import 'package:news_app_api/model/news_channels_headlines_model.dart';
import 'package:news_app_api/repository/news_repository.dart';

class NewsViewModel {
  
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi() async{
     final response = await _rep.fetchNewsChannelsHeadlinesApi();
     return response;
  }

   Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
     final response = await _rep.fetchCategoriesNewsApi(category);
     return response;
  }
}