import 'package:flutter/material.dart';
void main() {
  runApp(const DoAnApp());
}
class DoAnApp extends StatelessWidget {
  const DoAnApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProjectDetailScreen(),
    );
  }
}
class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin Đồ án",
          style: TextStyle(
            color: Color.fromARGB(255, 201, 229, 16),
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Tên đề tài: Xây dựng ứng dụng quản lý học tập",
              style: TextStyle(
                color: Color.fromARGB(255, 235, 19, 19),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Mã đề tài: DA_2024_001",
              style: TextStyle(
                color: Color.fromARGB(255, 54, 63, 244),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Số lượng SV tối đa: 02",
              style: TextStyle(
                color: Color.fromARGB(255, 54, 63, 244),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Chuyên ngành: Công nghệ phần mềm",
              style: TextStyle(
                color: Color.fromARGB(255, 54, 63, 244),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Giảng viên hướng dẫn: Vũ Văn Vinh",
              style: TextStyle(
                color: Color.fromARGB(255, 54, 63, 244),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Yêu cầu đề tài:",
              style: TextStyle(
                color: Color.fromARGB(255, 169, 13, 248),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "- Hoàn thành đúng tiến độ.\n"
                  "- Sử dụng Flutter và Firebase.\n"
                  "- Giao diện dễ sử dụng.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const Spacer(),
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
    );
  }
}