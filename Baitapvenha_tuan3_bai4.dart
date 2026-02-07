import 'package:flutter/material.dart';
void main() {
  runApp(const GroupApp());
}
class GroupApp extends StatelessWidget {
  const GroupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroupListScreen(),
    );
  }
}
class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});
  final List<Map<String, String>> members = const [
    {"msv": "2001210001", "name": "Nguyễn Văn A", "role": "Nhóm trưởng"},
    {"msv": "2001210002", "name": "Trần Thị B", "role": "Thành viên"},
    {"msv": "2001210003", "name": "Lê Văn C", "role": "Thành viên"},
    {"msv": "2001210004", "name": "Phạm Thị D", "role": "Thành viên"},
    {"msv": "2001210005", "name": "Hoàng Văn E", "role": "Thành viên"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin Nhóm",
          style: TextStyle(color: Color.fromARGB(255, 201, 229, 16), fontSize: 18),
        ),
        backgroundColor: Colors.blue[900],
        leading: const Icon(Icons.home, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tên nhóm: Nhóm 1",
              style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text("Mã nhóm: G01", style: TextStyle(fontSize: 18)),
            const Text("Số lượng thành viên: 5", style: TextStyle(fontSize: 18)),
            const Divider(height: 30, thickness: 2),
            const Text(
              "DANH SÁCH THÀNH VIÊN:",
              style: TextStyle(color: Colors.purple, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tên: ${members[index]['name']}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 54, 63, 244),
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("MSSV: ${members[index]['msv']}"),
                        Text(
                          "Vai trò: ${members[index]['role']}",
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}