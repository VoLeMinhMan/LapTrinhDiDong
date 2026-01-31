import 'dart:io';
import 'dart:math';
void main() {
  Random r = Random();
  List<int> ds = List.generate(10, (_) => r.nextInt(96) + 5);
  print("a. Danh sach so nguyen ngau nhien (5-100): $ds");
  var soLe = ds.where((n) => n % 2 != 0);
  if (soLe.isEmpty) {
    print("b. Danh sach khong co so le.");
  } else {
    print("b. Trung binh cong so le: ${soLe.reduce((a, b) => a + b) / soLe.length}");
  }
  bool doiXung = ds.toString() == ds.reversed.toString();
  print("c. Danh sach so tren ${doiXung ? 'co' : 'khong'} doi xung");
  bool tangDan = true;
  for(int i=0; i<ds.length-1; i++) if(ds[i] > ds[i+1]) tangDan = false;
  print("d. Danh sach so tren ${tangDan ? 'co' : 'khong'} duoc sap xep tang dan");
  print("e. So lon nhat trong danh sach: ${ds.reduce(max)}");
  var soChan = ds.where((n) => n % 2 == 0);
  print("f. So chan lon nhat trong danh sach: ${soChan.isEmpty ? 'Khong co' : soChan.reduce(max)}");
  stdout.write("g. Nhap so can xoa trong danh sach: ");
  int val = int.parse(stdin.readLineSync()!);
  if (!ds.contains(val)) {
    print("Khong tim thay so $val trong danh sach.");
  } else {
    ds.removeWhere((e) => e == val);
    print("Da xoa so $val ra khoi danh sach");
    print("Danh sach moi: $ds");
  }
}
