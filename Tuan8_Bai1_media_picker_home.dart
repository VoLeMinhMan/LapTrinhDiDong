import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class MediaPickerHome extends StatefulWidget {
  @override
  _MediaPickerHomeState createState() => _MediaPickerHomeState();
}

class _MediaPickerHomeState extends State<MediaPickerHome> {
  File? _mediaFile;
  VideoPlayerController? _videoController;
  final ImagePicker _picker = ImagePicker();

  /// Request necessary permissions
  Future<void> _requestPermission(Permission permission) async {
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  /// Select image or video from gallery
  Future<void> _pickMedia(ImageSource source, bool isVideo) async {
    // Request permissions based on platform and type
    if (isVideo) {
      await _requestPermission(Permission.storage);
    } else {
      await _requestPermission(Permission.photos);
    }

    final XFile? pickedFile = isVideo
        ? await _picker.pickVideo(source: source)
        : await _picker.pickImage(
      source: source,
      imageQuality: 100,
      maxWidth: 1920,
      maxHeight: 1080,
    );

    if (pickedFile != null) {
      _handleMediaSelection(File(pickedFile.path), isVideo);
    } else {
      _showSnackBar('No media selected');
    }
  }

  /// Capture image or video using the camera
  Future<void> _captureMedia(bool isVideo) async {
    await _requestPermission(Permission.camera);
    if (isVideo) {
      await _requestPermission(Permission.microphone);
    }

    final XFile? capturedFile = isVideo
        ? await _picker.pickVideo(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.camera);

    if (capturedFile != null) {
      _handleMediaSelection(File(capturedFile.path), isVideo);
    } else {
      _showSnackBar('No media captured');
    }
  }

  /// Processes the selected/captured file
  void _handleMediaSelection(File file, bool isVideo) {
    setState(() {
      _mediaFile = file;

      // Clean up previous controller
      _videoController?.dispose();
      _videoController = null;

      if (isVideo || file.path.toLowerCase().endsWith('.mp4')) {
        _videoController = VideoPlayerController.file(_mediaFile!);
        _videoController!.initialize().then((_) {
          setState(() {}); // Refresh to show video
          _videoController!.play();
          _videoController!.setLooping(true);
        });
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Media Picker App')),
      body: SingleChildScrollView(
        // Remove 'width: double.infinity' from here
        child: SizedBox(
          width: double.infinity, // Move the width constraint here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Ensures horizontal centering
            children: [
              SizedBox(height: 30),
              _displayMedia(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickMedia(ImageSource.gallery, false),
                child: Text('Chọn ảnh từ Gallery'),
              ),
              ElevatedButton(
                onPressed: () => _captureMedia(false),
                child: Text('Chụp ảnh từ Camera'),
              ),
              ElevatedButton(
                onPressed: () => _pickMedia(ImageSource.gallery, true),
                child: Text('Chọn video từ Gallery'),
              ),
              ElevatedButton(
                onPressed: () => _captureMedia(true),
                child: Text('Quay video từ Camera'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayMedia() {
    if (_mediaFile == null) {
      return Text('Chưa chọn ảnh hoặc video.');
    }

    if (_videoController != null && _videoController!.value.isInitialized) {
      return Container(
        constraints: BoxConstraints(maxHeight: 400),
        child: AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
      );
    } else {
      return Image.file(_mediaFile!, height: 300);
    }
  }
}