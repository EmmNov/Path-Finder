abstract interface class UrlRepository {
  Future<void> saveUrl(String url);
  Future<String> getUrl();
}
