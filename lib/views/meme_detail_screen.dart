import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
 import 'package:image_picker/image_picker.dart';

import '../model/Meme.dart';

import 'dart:io';
import 'package:flutter/material.dart';


class MemeDetailScreen extends StatefulWidget {
  final Meme meme;

  const MemeDetailScreen({Key? key, required this.meme}) : super(key: key);

  @override
  _MemeDetailScreenState createState() => _MemeDetailScreenState();
}

class _MemeDetailScreenState extends State<MemeDetailScreen> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveImage() async {
    if (_imageFile != null) {
      final result = await ImageGallerySaver.saveFile(_imageFile!.path);
      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image saved to gallery!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Meme'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
             Container(
              width: double.infinity,
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _imageFile != null
                    ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                )
                    : Image.network(
                  widget.meme.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),


            Text(
              widget.meme.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Width: ${widget.meme.width}px', style: TextStyle(fontSize: 16)),
            Text('Height: ${widget.meme.height}px', style: TextStyle(fontSize: 16)),
            Text('Box Count: ${widget.meme.boxCount}', style: TextStyle(fontSize: 16)),
            Text('Captions Count: ${widget.meme.captions}', style: TextStyle(fontSize: 16)),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Pick Image'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveImage,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Save Image'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

