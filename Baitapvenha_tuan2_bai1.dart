import 'dart:io';
abstract class HoaDon {
  String _maKH = "";
  String _tenKH = "";
  int soLuong = 0;
  double giaBan = 0;
  HoaDon.macDinh() {
    _maKH = "KH0000";
    _tenKH = "Chua dat ten";
    soLuong = 1;
    giaBan = 0;
  }
  HoaDon(String ma, String ten, this.soLuong, this.giaBan) {
    maKH = ma;
    tenKH = ten;
  }
  String get maKH => _maKH;
  set maKH(String value) {
    RegExp reg = RegExp(r'^KH\d{4}$');
    if (reg.hasMatch(value)) {
      _maKH = value;
    } else {
      print("Loi: Ma KH phai co dang KHxxxx (4 so).");
      _maKH = "KH0000";
    }
  }
  String get tenKH => _tenKH;
  set tenKH(String value) {
    if (value.isNotEmpty) _tenKH = value;
    else print("Loi: Ten khong duoc de trong.");
  }
  double tinhChietKhau();
  double tinhTroGia() => 0; 
  double tinhVAT() => soLuong * giaBan * 0.1;
  double tinhThanhTien() {
    return (soLuong * giaBan) - tinhChietKhau() + tinhVAT() - tinhTroGia();
  }
  void nhap() {
    stdout.write("Nhap Ma KH (KHxxxx): ");
    maKH = stdin.readLineSync()!;
    stdout.write("Nhap Ten KH: ");
    tenKH = stdin.readLineSync()!;
    stdout.write("Nhap So luong: ");
    soLuong = int.parse(stdin.readLineSync()!);
    stdout.write("Nhap Gia ban: ");
    giaBan = double.parse(stdin.readLineSync()!);
  }
  void xuat() {
    print("Ma: $_maKH | Ten: $_tenKH | SL: $soLuong | Gia: ${giaBan.toStringAsFixed(0)} " 
          "| Tro gia: ${tinhTroGia().toStringAsFixed(0)} | Thanh tien: ${tinhThanhTien().toStringAsFixed(0)}");
  }
}
class CaNhan extends HoaDon {
  double khoangCach = 0;
  CaNhan(String ma, String ten, int sl, double gia, this.khoangCach) : super(ma, ten, sl, gia);
  CaNhan.macDinh() : super.macDinh();
  @override
  double tinhChietKhau() {
    double ck = 0;
    if (soLuong >= 3) ck = 0.05 * giaBan * soLuong;
    if (khoangCach < 10) ck += 50000 * soLuong;
    return ck;
  }
  @override
  double tinhTroGia() {
    double tg = (0.02 * giaBan) * soLuong;
    if (soLuong > 2) tg += 100000;
    return tg;
  }
  @override
  void nhap() {
    super.nhap();
    stdout.write("Nhap khoang cach giao hang (km): ");
    khoangCach = double.parse(stdin.readLineSync()!);
  }
}
class DaiLy extends HoaDon {
  int namHopTac = 0;
  DaiLy(String ma, String ten, int sl, double gia, this.namHopTac) : super(ma, ten, sl, gia);
  DaiLy.macDinh() : super.macDinh();
  @override
  double tinhChietKhau() {
    double tileCK = 0.3;
    if (namHopTac > 5) {
      tileCK += (namHopTac - 5) * 0.01;
    }
    if (tileCK > 0.35) tileCK = 0.35;
    return tileCK * giaBan * soLuong;
  }
  @override
  void nhap() {
    super.nhap();
    stdout.write("Nhap so nam hop tac: ");
    namHopTac = int.parse(stdin.readLineSync()!);
  }
}
class CongTy extends HoaDon {
  int soNhanVien = 0;
  CongTy(String ma, String ten, int sl, double gia, this.soNhanVien) : super(ma, ten, sl, gia);
  CongTy.macDinh() : super.macDinh();
  @override
  double tinhChietKhau() {
    double tile = 0;
    if (soNhanVien > 5000) tile = 0.07;
    else if (soNhanVien > 1000) tile = 0.05;
    return tile * giaBan * soLuong;
  }
  @override
  double tinhTroGia() => 120000.0 * soLuong;
  @override
  void nhap() {
    super.nhap();
    stdout.write("Nhap so luon nhan vien: ");
    soNhanVien = int.parse(stdin.readLineSync()!);
  }
}
class QuanLyHoaDon {
  List<HoaDon> danhSach = [];
  void nhapDanhSach() {
    stdout.write("Nhap so luong hoa don: ");
    int n = int.parse(stdin.readLineSync()!);
    for (int i = 0; i < n; i++) {
      print("\n--- Chon loai KH: 1: Ca nhan, 2: Dai ly, 3: Cong ty ---");
      int loai = int.parse(stdin.readLineSync()!);
      HoaDon? hd;
      if (loai == 1) hd = CaNhan.macDinh();
      else if (loai == 2) hd = DaiLy.macDinh();
      else hd = CongTy.macDinh();
      
      hd.nhap();
      danhSach.add(hd);
    }
  }
  void xuatDanhSach() {
    print("\n--- DANH SACH HOA DON ---");
    for (var hd in danhSach) hd.xuat();
  }
  double tongThanhTien() => danhSach.fold(0, (sum, hd) => sum + hd.tinhThanhTien());
  double tongTroGia() => danhSach.fold(0, (sum, hd) => sum + hd.tinhTroGia());
  void khachHangMuaNhieuNhat() {
    if (danhSach.isEmpty) return;
    int maxSL = danhSach.map((e) => e.soLuong).reduce((a, b) => a > b ? a : b);
    print("\n--- KH Mua nhieu nhat ($maxSL san pham) ---");
    danhSach.where((hd) => hd.soLuong == maxSL).forEach((hd) => hd.xuat());
  }
  void tongCKCongTy() {
    double ck = 0;
    for (var hd in danhSach) {
      if (hd is CongTy) ck += hd.tinhChietKhau();
    }
    print("\nTong chiet khau cho Khach hang Cong ty: ${ck.toStringAsFixed(0)}");
  }
  void sapXep() {
    danhSach.sort((a, b) {
      int compareSL = a.soLuong.compareTo(b.soLuong);
      if (compareSL != 0) return compareSL;
      return b.tinhThanhTien().compareTo(a.tinhThanhTien());
    });
    print("\n>> Da sap xep tang dan SL, giam dan Thanh tien.");
  }
  void timKiem(String x) {
    var found = danhSach.where((hd) => hd.maKH == x);
    if (found.isEmpty) {
      print("\n-> Khach hang la");
    } else {
      print("\n--- Hoa don cua ma $x ---");
      for (var hd in found) hd.xuat();
    }
  }
}
void main() {
  QuanLyHoaDon ql = QuanLyHoaDon();
  ql.nhapDanhSach();
  ql.xuatDanhSach();
  print("\nTong thanh tien: ${ql.tongThanhTien().toStringAsFixed(0)}");
  print("Tong tro gia: ${ql.tongTroGia().toStringAsFixed(0)}");
  ql.khachHangMuaNhieuNhat();
  ql.tongCKCongTy();
  ql.sapXep();
  ql.xuatDanhSach();
  stdout.write("\nNhap ma KH can tim (x): ");
  String x = stdin.readLineSync()!;
  ql.timKiem(x);
}