import 'package:flutter/material.dart';

import '../model/Meme.dart';
import '../views/meme_detail_screen.dart';


class MemeListItem extends StatelessWidget {
  final Meme meme;

  MemeListItem({required this.meme});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(meme.url, width: 50, height: 50),
      title: Text(meme.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemeDetailScreen(meme: meme)),
        );
      },
    );
  }
}
