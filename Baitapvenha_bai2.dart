import 'dart:io';
void main() {
  stdout.write("Nhap chuoi: ");
  String s = stdin.readLineSync()!;
  print("a. Chuoi vua nhap: $s");
  int nguyenAm = RegExp(r'[aeiouAEIOU]').allMatches(s).length;
  print("b. Chuoi co $nguyenAm ky tu la nguyen am");
  List<String> words = s.trim().split(RegExp(r'\s+'));
  print("c. So tu trong chuoi: ${words.length}");
  String reversedS = s.split('').reversed.join('');
  print("d. Chuoi ${s == reversedS ? 'co' : 'khong'} doi xung");
  print("e. Dao nguoc tu trong chuoi: ${words.reversed.join(' ')}");
}
