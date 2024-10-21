import 'package:flutter/material.dart';
import 'package:meme_app/view_model/MemeViewModel.dart';
import 'package:meme_app/views/meme_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meme App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MemeListScreen(),
      ),
    );
  }
}
