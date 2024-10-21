import 'package:flutter/material.dart';
 import '../model/Meme.dart';
import '../services/meme_service.dart';


class MemeProvider with ChangeNotifier {
  List<Meme> _memes = [];
  List<Meme> _filteredMemes = [];

  List<Meme> get memes => _filteredMemes;

  Future<void> fetchMemes() async {
    _memes = await MemeService().fetchMemes();
    _filteredMemes = _memes;
    notifyListeners();
  }

  void filterMemes(String query) {
    if (query.isEmpty) {
      _filteredMemes = _memes;
    } else {
      _filteredMemes = _memes
          .where((meme) => meme.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}