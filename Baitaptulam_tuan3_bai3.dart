import 'package:flutter/material.dart';
void main() {
  runApp(const ProductApp());
}
class ProductApp extends StatelessWidget {
  const ProductApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailScreen(),
    );
  }
}
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết sản phẩm",
          style: TextStyle(
            color: Color.fromARGB(255, 201, 229, 16),
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.blue[900],
        leading: const Icon(Icons.home, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hình ảnh sản phẩm:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProductImage("assets/images/sp1.png"),
                _buildProductImage("assets/images/sp2.png"),
                _buildProductImage("assets/images/sp3.png"),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "iPhone 15 Pro Max 256GB",
              style: TextStyle(
                color: Color.fromARGB(255, 235, 19, 19),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Giá bán: 29.990.000đ",
              style: TextStyle(
                color: Color.fromARGB(255, 169, 13, 248),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildInfoText("Mã sản phẩm:", "IP15PM-001"),
            _buildInfoText("Nhà sản xuất:", "Apple Inc."),
            const SizedBox(height: 20),
            const Text(
              "Mô tả sản phẩm:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sở hữu khung viền Titan bền bỉ, chip A17 Pro mạnh mẽ nhất thế giới smartphone. Hệ thống camera chuyên nghiệp giúp quay phim và chụp ảnh chất lượng điện ảnh.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
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
    );
  }
  Widget _buildProductImage(String path) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 50, color: Colors.grey),
        ),
      ),
    );
  }
  Widget _buildInfoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 54, 63, 244)),
          children: [
            TextSpan(text: "$label ", style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}