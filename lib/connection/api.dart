import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

class BooksApi{

  final String url = 'https://biblia-catolica.herokuapp.com/api/biblia';

  Future <Map> loadBooks(String book) async{

    String apiUrl = '$url/$book/capitulos';
    // Make a HTTP GET request to the CoinMarketCap API.
    // Await basically pauses execution until the get() function returns a Response

    try{
      http.Response response = await http.get(apiUrl);
      // Using the JSON class to decode the JSON String
      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(_){
      return null;
    }

  }

  Future <Map> loadVersiculos(String book, String chapter) async{

    String apiUrl = '$url/$book/capitulos/$chapter/versiculos';
    // Make a HTTP GET request to the CoinMarketCap API.
    // Await basically pauses execution until the get() function returns a Response

    try{
      http.Response response = await http.get(apiUrl);
      // Using the JSON class to decode the JSON String
      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(_){
      return null;
    }


  }

  Future <Map> loadSearch(query) async{

    String apiUrl = '$url/notice/search/$query';
    // Make a HTTP GET request to the CoinMarketCap API.
    // Await basically pauses execution until the get() function returns a Response
    http.Response response = await http.get(apiUrl);
    // Using the JSON class to decode the JSON String
    const JsonDecoder decoder = const JsonDecoder();

    return decoder.convert(response.body);

  }

}