import 'package:dio/dio.dart';
import 'package:saveload_app/features/quotes/domain/quote_repo.dart';
import 'package:saveload_app/features/quotes/domain/quote_model.dart';

class QuoteRepoImpl implements QuoteRepo {
  final Dio _dio;
  QuoteRepoImpl(this._dio);

  @override
  Future<QuotesModel> fetchQuotes() async {
    final response = await _dio.get("https://dummyjson.com/quotes");
    return QuotesModel.fromJson(response.data);
  }
}
