class Urls {
  static const String baseUrl = 'https://gateway.marvel.com:443/v1/public';
  static const String timeStamp = '';
  static const String apiKey = '';
  static const String hash = '';
  static String characters(int limit, int offset) =>
      '$baseUrl/characters?limit=$limit&offset=$offset&ts=$timeStamp&apikey=$apiKey&hash=$hash';
}
