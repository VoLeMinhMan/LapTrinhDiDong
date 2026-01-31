import 'dart:io';
void main() {
  stdout.write("Nhap so luong que kem: ");
  int soLuong = int.parse(stdin.readLineSync()!);
  stdout.write("Nhap gia 1 que kem: ");
  double giaTien = double.parse(stdin.readLineSync()!);
  double tongTien = soLuong * giaTien;
  double giamGia = 0;
  if (soLuong > 10) {
    giamGia = 0.1; 
  } else if (soLuong >= 5) {
    giamGia = 0.05; 
  }
  double phaiTra = tongTien * (1 - giamGia);
  print("Tong so tien phai tra: $phaiTra VND");
}