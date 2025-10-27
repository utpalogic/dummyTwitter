import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saveload_app/features/auth/presentation/provider/auth_dependency_provider.dart';
import 'package:saveload_app/features/quotes/data/quote_repo_impl.dart';
import 'package:saveload_app/features/quotes/domain/quote_repo.dart';
import 'package:saveload_app/features/quotes/domain/quote_model.dart';

final quoteRepoProvider = Provider<QuoteRepo>((ref) {
  return QuoteRepoImpl(ref.watch(dioProvider));
});

final quotesProvider = FutureProvider<QuotesModel>((ref) async {
  return await ref.read(quoteRepoProvider).fetchQuotes();
});
