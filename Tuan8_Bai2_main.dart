import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(PhotoCaptureApp());
}

class PhotoCaptureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Capture & Preview',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true, // Sử dụng giao diện Material 3 hiện đại
      ),
      home: PhotoCaptureHome(),
    );
  }
}

class PhotoCaptureHome extends StatefulWidget {
  @override
  _PhotoCaptureHomeState createState() => _PhotoCaptureHomeState();
}

class _PhotoCaptureHomeState extends State<PhotoCaptureHome> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  /// Yêu cầu quyền truy cập
  Future<void> _requestPermission(Permission permission) async {
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  /// Chọn ảnh từ gallery
  Future<void> _pickImageFromGallery() async {
    await _requestPermission(Permission.photos);
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  /// Chụp ảnh từ camera
  Future<void> _captureImageFromCamera() async {
    await _requestPermission(Permission.camera);
    final XFile? capturedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (capturedFile != null) {
      setState(() {
        _imageFile = File(capturedFile.path);
      });
    }
  }

  /// Xem trước ảnh toàn màn hình
  void _showFullScreenPreview(BuildContext context) {
    if (_imageFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenImage(imageFile: _imageFile!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Capture & Preview'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImagePreview(),
              const SizedBox(height: 30),
              _buildActionButton(
                onPressed: _pickImageFromGallery,
                icon: Icons.photo_library,
                label: 'Chọn ảnh từ Gallery',
              ),
              const SizedBox(height: 10),
              _buildActionButton(
                onPressed: _captureImageFromCamera,
                icon: Icons.camera_alt,
                label: 'Chụp ảnh từ Camera',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_imageFile == null) {
      return Column(
        children: [
          Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
          Text('Chưa có ảnh nào được chọn.', style: TextStyle(color: Colors.grey)),
        ],
      );
    }
    return GestureDetector(
      onTap: () => _showFullScreenPreview(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.file(
          _imageFile!,
          height: 300,
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(250, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

/// Widget xem trước toàn màn hình
class FullScreenImage extends StatelessWidget {
  final File imageFile;
  FullScreenImage({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Nền đen để ảnh nổi bật hơn
      appBar: AppBar(
        title: Text('Xem trước'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: InteractiveViewer( // Cho phép người dùng zoom ảnh
          child: Image.file(imageFile),
        ),
      ),
    );
  }
}