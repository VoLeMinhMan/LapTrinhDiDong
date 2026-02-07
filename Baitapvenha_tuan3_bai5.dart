import 'package:flutter/material.dart';
void main() {
  runApp(const UniversityApp());
}
class UniversityApp extends StatelessWidget {
  const UniversityApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FacultyInfoScreen(),
    );
  }
}
class FacultyInfoScreen extends StatefulWidget {
  const FacultyInfoScreen({super.key});

  @override
  State<FacultyInfoScreen> createState() => _FacultyInfoScreenState();
}
class _FacultyInfoScreenState extends State<FacultyInfoScreen> {
  String detailTitle = "NGÀNH CÔNG NGHỆ THÔNG TIN";
  List<String> details = [
    "Mã ngành: 7480201",
    "Thời gian đào tạo: 4 năm",
    "Chỉ tiêu dự kiến: 400 sinh viên",
    "Các chuyên ngành: Công nghệ phần mềm, Hệ thống thông tin",
    "Kỹ năng: Lập trình Mobile, Web, AI, Big Data",
    "Vị trí việc làm: Lập trình viên, Tester, Quản trị hệ thống"
  ];
  Color detailColor = Colors.red;

  void updateInfo(String major) {
    setState(() {
      if (major == "IT") {
        detailTitle = "NGÀNH CÔNG NGHỆ THÔNG TIN";
        details = [
          "Mã ngành: 7480201",
          "Thời gian đào tạo: 4 năm",
          "Chỉ tiêu dự kiến: 400 sinh viên",
          "Các chuyên ngành: Công nghệ phần mềm, Hệ thống thông tin",
          "Kỹ năng: Lập trình Mobile, Web, AI, Big Data",
          "Vị trí việc làm: Lập trình viên, Tester, Quản trị hệ thống"
        ];
        detailColor = Colors.red;
      } else {
        detailTitle = "NGÀNH AN TOÀN THÔNG TIN";
        details = [
          "Mã ngành: 7480202",
          "Thời gian đào tạo: 4 năm",
          "Chỉ tiêu dự kiến: 150 sinh viên",
          "Chuyên ngành: An ninh mạng, Bảo mật hệ thống",
          "Kỹ năng: Mật mã học, Phòng chống mã độc, Điều tra số",
          "Vị trí việc làm: Chuyên viên bảo mật, Kỹ sư an ninh mạng"
        ];
        detailColor = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Giới thiệu Ngành học",
          style: TextStyle(color: Color.fromARGB(255, 201, 229, 16), fontSize: 18),
        ),
        backgroundColor: Colors.blue[900],
        leading: const Icon(Icons.home, color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            child: ExpansionTile(
              title: const Text(
                "Ngành học",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.blue),
              children: [
                ListTile(
                  title: const Text("Công nghệ Thông tin (IT)"),
                  leading: const Icon(Icons.computer, color: Colors.red),
                  onTap: () => updateInfo("IT"),
                ),
                ListTile(
                  title: const Text("An toàn Thông tin (ATT)"),
                  leading: const Icon(Icons.security, color: Colors.green),
                  onTap: () => updateInfo("ATT"),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailTitle,
                    style: TextStyle(color: detailColor, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  ...details.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("• ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 54, 63, 244),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
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
    );
  }
}