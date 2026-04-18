import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
void main() {
  runApp(SimpleAudioPlayer());
}
class SimpleAudioPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Audio Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: AudioPlayerHome(),
    );
  }
}
class AudioPlayerHome extends StatefulWidget {
  @override
  _AudioPlayerHomeState createState() => _AudioPlayerHomeState();
}
class _AudioPlayerHomeState extends State<AudioPlayerHome> {
  late AudioPlayer _audioPlayer;
  int _currentSongIndex = 0;
  bool _isPlaying = false;
  // Danh sách các bài hát trong assets
  final List<String> _songs = [
    'audios/sample1.mp3',
    'audios/sample2.mp3',
    'audios/sample3.mp3',
  ];

  final List<String> _songTitles = ['Bài hát 1', 'Bài hát 2', 'Bài hát 3'];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Lắng nghe trạng thái phát (Playing/Paused/Stopped)
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });

    // Tự động chuyển bài khi kết thúc
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  /// Phát bài hát hiện tại
  Future<void> _playSong() async {
    // Lưu ý: AssetSource mặc định tìm trong thư mục assets/
    // nên ta chỉ truyền đường dẫn tương đối từ sau assets/
    await _audioPlayer.play(AssetSource(_songs[_currentSongIndex]));
  }

  Future<void> _pauseSong() async {
    await _audioPlayer.pause();
  }

  Future<void> _stopSong() async {
    await _audioPlayer.stop();
  }

  void _nextSong() {
    setState(() {
      _currentSongIndex = (_currentSongIndex + 1) % _songs.length;
    });
    _playSong();
  }

  void _previousSong() {
    setState(() {
      _currentSongIndex = (_currentSongIndex - 1 + _songs.length) % _songs.length;
    });
    _playSong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Audio Player'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Đĩa nhạc giả lập hoặc Icon
            Container(
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.music_note,
                size: 100,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 40),
            // Hiển thị tên bài hát
            Text(
              _songTitles[_currentSongIndex],
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              'Đang phát từ Assets',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 40),
            // Các nút điều khiển
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildControlButton(Icons.skip_previous, _previousSong),
                SizedBox(width: 20),
                _buildPlayPauseButton(),
                SizedBox(width: 20),
                _buildControlButton(Icons.stop, _stopSong),
                SizedBox(width: 20),
                _buildControlButton(Icons.skip_next, _nextSong),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 45,
      color: Colors.blue[800],
      onPressed: onPressed,
    );
  }

  Widget _buildPlayPauseButton() {
    return CircleAvatar(
      radius: 35,
      backgroundColor: Colors.blue,
      child: IconButton(
        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
        iconSize: 40,
        color: Colors.white,
        onPressed: () {
          if (_isPlaying) {
            _pauseSong();
          } else {
            _playSong();
          }
        },
      ),
    );
  }
}