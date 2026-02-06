import 'dart:io';
abstract class PhongTro {
  String maSo;
  int soNguoi;
  int soDien;
  int soNuoc;
  PhongTro(this.maSo, this.soNguoi, this.soDien, this.soNuoc);
  double tinhTien(); 
  void hienThi() {
    print('Ma: $maSo | Nguoi: $soNguoi | Dien: $soDien | Nuoc: $soNuoc | Tong Tien: ${tinhTien()}');
  }
}
class PhongLoaiA extends PhongTro {
  int soNguoiThan;
  PhongLoaiA(String ma, int nguoi, int dien, int nuoc, this.soNguoiThan)
      : super(ma, nguoi, dien, nuoc);
  @override
  double tinhTien() {
    return (1400 + 2 * soDien + 8 * soNuoc + 50 * soNguoiThan).toDouble();
  }
  @override
  void hienThi() {
    stdout.write('[Loai A] ');
    super.hienThi();
  }
}
class PhongLoaiB extends PhongTro {
  int giatUi;
  int soMay;
  PhongLoaiB(String ma, int nguoi, int dien, int nuoc, this.giatUi, this.soMay)
      : super(ma, nguoi, dien, nuoc);

  @override
  double tinhTien() {
    return (2000 + 2 * soDien + 8 * soNuoc + giatUi * 5 + soMay * 100).toDouble();
  }
  @override
  void hienThi() {
    stdout.write('[Loai B] ');
    super.hienThi();
  }
}
void main() async {
  List<PhongTro> danhSachPhong = [];
  final file = File('phongthue.txt');
  if (!await file.exists()) {
    print('Khong tim thay file phongthue.txt');
    return;
  }
  try {
    List<String> lines = await file.readAsLines();
    for (var line in lines) {
      if (line.trim().isEmpty) continue; 

      var data = line.split('#');
      if (data[0].startsWith('A')) {
        danhSachPhong.add(PhongLoaiA(
          data[0], 
          int.parse(data[1]), 
          int.parse(data[2]), 
          int.parse(data[3]), 
          int.parse(data[4])
        ));
      } else if (data[0].startsWith('B')) {
        danhSachPhong.add(PhongLoaiB(
          data[0], 
          int.parse(data[1]), 
          int.parse(data[2]), 
          int.parse(data[3]), 
          int.parse(data[4]), 
          int.parse(data[5])
        ));
      }
    }
    print('\n--- DANH SACH PHONG ---');
    for (var p in danhSachPhong) {
      p.hienThi();
    }
    print('\n--- PHONG CO SO NGUOI THUE > 2 ---');
    danhSachPhong.where((p) => p.soNguoi > 2).forEach((p) => p.hienThi());
    double tongTien = danhSachPhong.fold(0, (sum, p) => sum + p.tinhTien());
    print('\n==> TONG TIEN THU DUOC: $tongTien');
    print('\n--- SAP XEP GIAM DAN THEO SO DIEN ---');
    danhSachPhong.sort((a, b) => b.soDien.compareTo(a.soDien));
    for (var p in danhSachPhong) {
      p.hienThi();
    }
    print('\n--- DANH SACH PHONG LOAI A ---');
    danhSachPhong.whereType<PhongLoaiA>().forEach((p) => p.hienThi());
  } catch (e) {
    print('Loi khi doc file: $e');
  }
}