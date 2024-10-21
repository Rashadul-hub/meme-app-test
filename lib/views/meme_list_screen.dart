import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/MemeViewModel.dart';
import 'meme_detail_screen.dart';


class MemeListScreen extends StatefulWidget {
  @override
  _MemeListScreenState createState() => _MemeListScreenState();
}

class _MemeListScreenState extends State<MemeListScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<MemeProvider>(context, listen: false).fetchMemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Memes'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) =>
                  Provider.of<MemeProvider>(context, listen: false)
                      .filterMemes(value),
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<MemeProvider>(
        builder: (context, memeProvider, child) {
          return ListView.builder(
            itemCount: memeProvider.memes.length,
            itemBuilder: (context, index) {
              final meme = memeProvider.memes[index];
              return ListTile(
                title: Text(meme.name),
                leading: Image.network(meme.url, width: 50),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemeDetailScreen(meme: meme),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}