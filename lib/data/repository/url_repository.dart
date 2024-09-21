import 'package:path_finder/data/data_sourses/local_data_client.dart';
import 'package:path_finder/domain/repository/url_repository.dart';

class UrlRepositoryImpl implements UrlRepository {
  final LocalDataClient _localDataSource;

  UrlRepositoryImpl({LocalDataClient? localDataSource})
      : _localDataSource = localDataSource ?? LocalDataClient();

  @override
  Future<String> getUrl() async {
    return await _localDataSource.getUrl() ?? '';
  }

  @override
  Future<void> saveUrl(String url) async {
    await _localDataSource.saveUrl(url);
  }
}
