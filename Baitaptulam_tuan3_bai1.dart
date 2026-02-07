import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentInfoScreen(),
    );
  }
}
class StudentInfoScreen extends StatelessWidget {
  const StudentInfoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin sinh viên",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.blue[900],
        leading: const Icon(Icons.home, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey,
                  // Sử dụng Icon mặc định thay cho AssetImage
                  child: Icon(Icons.person, size: 80, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Họ và tên: Nguyễn Văn A",
                style: TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "MSSV: 2001221234",
                style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "Lớp: 13DHTH02",
                style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "Khóa: 13 Đại học",
                style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "Ngành: Công nghệ thông tin",
                style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "Trường: Đại học Công Thương Thành phố Hồ Chí Minh",
                style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    foregroundColor: Colors.blue[800],
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Trở về"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}