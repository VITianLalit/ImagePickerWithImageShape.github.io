import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _image;
  ImageShape _selectedShape = ImageShape.Circle;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image picked');
      }
    });
  }

  Future<void> _showShapeOptions(BuildContext context) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildShapeOption(
                context,
                shape: ImageShape.Circle,
                imagePath: 'assets/images/frames/user_image_frame_3.png',
              ),
              SizedBox(height: 16),
              _buildShapeOption(
                context,
                shape: ImageShape.Square,
                imagePath: 'assets/images/frames/user_image_frame_2.png',
              ),
              SizedBox(height: 16),
              _buildShapeOption(
                context,
                shape: ImageShape.Rectangle,
                imagePath: 'assets/images/frames/user_image_frame_4.png',
              ),
              SizedBox(height: 16),
              _buildShapeOption(
                context,
                shape: ImageShape.Heart,
                imagePath: 'assets/images/frames/user_image_frame_1.png',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShapeOption(BuildContext context,
      {required ImageShape shape, required String imagePath}) {
    return InkWell(
      onTap: () {
        _applyShape(shape);
        Navigator.pop(context); // Close the bottom sheet
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          imagePath,
          width: 50, // Adjust the width as needed
          height: 50, // Adjust the height as needed
        ),
      ),
    );
  }

  void _applyShape(ImageShape shape) {
    setState(() {
      _selectedShape = shape;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _image != null
                      ? _buildImageByShape(_image!)
                      : Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                getImageGallery();
              },
              child: Text("Choose Image"),
            ),
            ElevatedButton(
              onPressed: () {
                _showShapeOptions(context);
              },
              child: Text("Choose Shape"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageByShape(File image) {
    switch (_selectedShape) {
      case ImageShape.Circle:
        return ClipOval(
          child: Image.file(
            image.absolute,
            fit: BoxFit.cover,
          ),
        );
      case ImageShape.Square:
        return Image.file(
          image.absolute,
          fit: BoxFit.cover,
        );
      case ImageShape.Rectangle:
        return Image.file(
          image.absolute,
          fit: BoxFit.cover,
        );
      case ImageShape.Heart:
        return ClipPath(
          clipper: HeartShapeClipper(),
          child: Image.file(
            image.absolute,
            fit: BoxFit.cover,
          ),
        );
    }
  }
}

enum ImageShape { Circle, Square, Rectangle, Heart }

class HeartShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Move to the bottom-center
    path.moveTo(size.width / 2, size.height);

    // left side
    path.cubicTo(
      size.width * 0.2,
      size.height * 0.6,
      0,
      size.height * 0.5,
      0,
      size.height * 0.3,
    );

    // top-left
    path.cubicTo(
      0,
      size.height * 0.1,
      size.width * 0.3,
      size.height * 0.1,
      size.width * 0.5,
      0,
    );

    // top-right
    path.cubicTo(
      size.width * 0.7,
      size.height * 0.1,
      size.width,
      size.height * 0.1,
      size.width,
      size.height * 0.3,
    );

    // right side
    path.cubicTo(
      size.width,
      size.height * 0.5,
      size.width * 0.8,
      size.height * 0.6,
      size.width / 2,
      size.height,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
