import 'dart:io';
void main() {
  stdout.write("Nhap mot so nguyen duong (n > 10): ");
  String input = stdin.readLineSync()!;
  int n = int.parse(input);
  if (n <= 10) {
    print("So nhap vao phai > 10!");
    return;
  }
  print("a. so $n co ${input.length} chu so");
  int tong = 0;
  bool coSoLe = false;
  for (int i = 0; i < input.length; i++) {
    int chuSo = int.parse(input[i]);
    tong += chuSo;
    if (chuSo % 2 != 0) coSoLe = true;
  }
  print("b. Tong cac chu so cua $n: $tong");
  print("c. so $n ${coSoLe ? 'co' : 'khong'} chua chu so le");
}