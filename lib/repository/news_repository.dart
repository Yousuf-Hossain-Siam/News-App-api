
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_api/model/categories_news_model.dart';
import 'package:news_app_api/model/news_channels_headlines_model.dart';

class NewsRepository {

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi()async{
    
    String url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=1cf2beb96c064ee38a21476b2500fb34';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
     return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }


  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{
    
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=1cf2beb96c064ee38a21476b2500fb34';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
     return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}