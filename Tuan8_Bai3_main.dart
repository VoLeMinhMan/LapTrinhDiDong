import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(VideoRecorderApp());
}

class VideoRecorderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Recorder & Playback',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: VideoRecorderHome(),
    );
  }
}

class VideoRecorderHome extends StatefulWidget {
  @override
  _VideoRecorderHomeState createState() => _VideoRecorderHomeState();
}

class _VideoRecorderHomeState extends State<VideoRecorderHome> {
  File? _videoFile;
  VideoPlayerController? _videoController;
  final ImagePicker _picker = ImagePicker();

  /// Yêu cầu quyền truy cập
  Future<void> _requestPermission(Permission permission) async {
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  /// Chọn video từ gallery
  Future<void> _pickVideoFromGallery() async {
    await _requestPermission(Permission.photos);
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _loadVideo(File(pickedFile.path));
    }
  }

  /// Quay video từ camera
  Future<void> _recordVideoFromCamera() async {
    await _requestPermission(Permission.camera);
    await _requestPermission(Permission.microphone);
    final XFile? recordedFile = await _picker.pickVideo(
      source: ImageSource.camera,
    );
    if (recordedFile != null) {
      _loadVideo(File(recordedFile.path));
    }
  }

  /// Tải và khởi tạo video
  void _loadVideo(File videoFile) {
    // Giải phóng controller cũ trước khi tạo mới
    _videoController?.dispose();

    _videoController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {
          _videoFile = videoFile;
        });
        _videoController!.play();
        _videoController!.setLooping(true); // Tự động lặp lại video
      });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Recorder & Playback'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildVideoDisplay(),
            const SizedBox(height: 20),
            _buildControls(),
            const SizedBox(height: 30),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoDisplay() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
        ),
      );
    } else {
      return Container(
        height: 250,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.video_library, size: 50, color: Colors.grey),
              Text('Chưa có video nào được chọn.'),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildControls() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return SizedBox.shrink();
    }
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.purple,
      child: IconButton(
        iconSize: 35,
        color: Colors.white,
        onPressed: () {
          setState(() {
            _videoController!.value.isPlaying
                ? _videoController!.pause()
                : _videoController!.play();
          });
        },
        icon: Icon(
          _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _pickVideoFromGallery,
          icon: Icon(Icons.collections),
          label: Text('Chọn video từ Gallery'),
          style: ElevatedButton.styleFrom(minimumSize: Size(250, 50)),
        ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: _recordVideoFromCamera,
          icon: Icon(Icons.videocam),
          label: Text('Quay video từ Camera'),
          style: ElevatedButton.styleFrom(minimumSize: Size(250, 50)),
        ),
      ],
    );
  }
}