import 'package:saveload_app/features/quotes/domain/quote_model.dart';

abstract class QuoteRepo {
  Future<QuotesModel> fetchQuotes();
}
