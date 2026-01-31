import 'dart:io';
import 'dart:math';
bool laSoNguyenTo(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) return false;
  }
  return true;
}
void main() {
  stdout.write("Nhap danh sach so nguyen (cach nhau bang khoang trang): ");
  List<int> ds = stdin.readLineSync()!.split(' ').map(int.parse).toList();
  print("a. Danh sach so nguyen vua nhap: $ds");
  print("b. Tong cac phan tu co trong danh sach: ${ds.reduce((a, b) => a + b)}");
  print("c. Cac so nguyen to co trong danh sach: ${ds.where((n) => laSoNguyenTo(n)).toList()}");
  stdout.write("d. Nhap gia tri can tim: ");
  int x = int.parse(stdin.readLineSync()!);
  int index = ds.indexOf(x);
  if (index != -1) {
    print("Gia tri $x o vi tri : $index");
  } else {
    ds.insert(0, x);
    print("Khong co $x trong danh sach");
    print("Da them $x vao dau danh sach: $ds");
  }
}
