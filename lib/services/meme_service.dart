import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/Meme.dart';

class MemeService {
  static const String apiUrl = 'https://api.imgflip.com/get_memes';

  Future<List<Meme>> fetchMemes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Meme> memes = (data['data']['memes'] as List)
          .map((meme) => Meme.fromJson(meme))
          .toList();
       return memes;
    } else {
      throw Exception('Failed to load memes');
    }
  }
}
