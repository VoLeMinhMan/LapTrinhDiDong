import 'dart:io';
abstract class MonHoc {
  String maMon;
  String tenMon;
  int soTinChi;
  MonHoc(this.maMon, this.tenMon, this.soTinChi);
  double tinhDTB();
  String quyDoiDiemChu() {
    double dtb = tinhDTB();
    if (dtb >= 8.5) return 'A';
    if (dtb >= 7.0) return 'B';
    if (dtb >= 5.5) return 'C';
    if (dtb >= 4.0) return 'D';
    return 'F';
  }
  void hienThi() {
    print('Ma: $maMon | Ten: $tenMon | TC: $soTinChi | DTB: ${tinhDTB().toStringAsFixed(1)} | He 4: ${quyDoiDiemChu()}');
  }
}
class LyThuyet extends MonHoc {
  double diemTL, diemCK;
  LyThuyet(String ma, String ten, int tc, this.diemTL, this.diemCK) : super(ma, ten, tc);
  @override
  double tinhDTB() => (diemTL * 0.3 + diemCK * 0.7);
}
class ThucHanh extends MonHoc {
  double d1, d2, d3;
  ThucHanh(String ma, String ten, int tc, this.d1, this.d2, this.d3) : super(ma, ten, tc);
  @override
  double tinhDTB() => (d1 + d2 + d3) / 3;
}
class DoAn extends MonHoc {
  double diemGVHD, diemGVPB;
  DoAn(String ma, String ten, int tc, this.diemGVHD, this.diemGVPB) : super(ma, ten, tc);
  @override
  double tinhDTB() => (diemGVHD + diemGVPB) / 2;
}
void main() async {
  List<MonHoc> danhSach = [];
  // 1. Nhap danh sach mon hoc tu ban phim
  stdout.write("Nhap so luong mon hoc tu ban phim: ");
  String? inputN = stdin.readLineSync();
  if (inputN != null && inputN.isNotEmpty) {
    int n = int.parse(inputN);
    for (int i = 0; i < n; i++) {
      print("\n--- Nhap mon hoc thu ${i + 1} ---");
      danhSach.add(nhapTuBanPhim());
    }
  }
  // 2. Xuat danh sach mon hoc vua nhap
  print("\n--- DANH SACH MON HOC VUA NHAP ---");
  for (var m in danhSach) {
    m.hienThi();
  }
  // 3. Kiem tra sap xep tang dan theo ten
  bool checkSorted = true;
  for (int i = 0; i < danhSach.length - 1; i++) {
    if (danhSach[i].tenMon.toLowerCase().compareTo(danhSach[i + 1].tenMon.toLowerCase()) > 0) {
      checkSorted = false;
      break;
    }
  }
  print("\n>> Danh sach mon hoc ${checkSorted ? 'co' : 'khong'} sap xep tang dan theo ten");
  // 4. Sap xep danh sach tang dan theo so tin chi
  danhSach.sort((a, b) => a.soTinChi.compareTo(b.soTinChi));
  print("\n--- DANH SACH SAU KHI SAP XEP TANG DAN THEO TIN CHI ---");
  for (var m in danhSach) {
    m.hienThi();
  }
  // 5. Mon hoc co so tin chi cao nhat
  if (danhSach.isNotEmpty) {
    int maxTC = danhSach.map((m) => m.soTinChi).reduce((a, b) => a > b ? a : b);
    print("\n--- MON CO SO TIN CHI CAO NHAT ($maxTC) ---");
    danhSach.where((m) => m.soTinChi == maxTC).forEach((m) => m.hienThi());
  }
  // 6. Tim kiem mon hoc theo ten
  stdout.write("\nNhap ten mon hoc can tim: ");
  String? searchName = stdin.readLineSync();
  if (searchName != null) {
    var found = danhSach.where((m) => m.tenMon.toLowerCase() == searchName.toLowerCase());
    if (found.isEmpty) {
      print("Khong tim thay mon: '$searchName'. Vui long nhap mon moi vao danh sach:");
      danhSach.add(nhapTuBanPhim());
      print("Da them mon moi vao danh sach thanh cong");
    } else {
      print("Thong tin mon hoc tim thay:");
      for (var m in found) {
        m.hienThi();
      }
    }
  }
  List<MonHoc> danhSachFile = [];
  print("\n--- Dang doc du lieu tu file monhoc.txt... ---");
  await docFileMonHoc(danhSachFile);
  // 7. Xuat danh sach monhoc.txt
  print("\n--- DANH SACH MON HOC TRONG FILE TXT ---");
  if (danhSachFile.isEmpty) {
    print("File trong hoac khong ton tai.");
  } else {
    for (var m in danhSachFile) {
      m.hienThi();
    }
    // 8. Tinh so tin chi trung binh cac mon trong file monhoc.txt
    double tongTC = danhSachFile.fold(0, (sum, m) => sum + m.soTinChi);
    double tbTC = tongTC / danhSachFile.length;
    print("\n==> So tin chi trung binh cua cac mon trong file monhoc.txt: ${tbTC.toStringAsFixed(2)}");
  }
}
MonHoc nhapTuBanPhim() {
  stdout.write("Chon loai mon (Chi nhap so) (1: Ly thuyet, 2: Thuc hanh, 3: Do An): ");
  int loai = int.parse(stdin.readLineSync()!);
  stdout.write("Ma mon: ");
  String ma = stdin.readLineSync()!;
  stdout.write("Ten mon: ");
  String ten = stdin.readLineSync()!;
  stdout.write("So tin chi: ");
  int tc = int.parse(stdin.readLineSync()!);
  switch (loai) {
    case 1:
      stdout.write("Diem tieu luan: ");
      double tl = double.parse(stdin.readLineSync()!);
      stdout.write("Diem cuoi ky: ");
      double ck = double.parse(stdin.readLineSync()!);
      return LyThuyet(ma, ten, tc, tl, ck);
    case 2:
      stdout.write("Nhap diem 3 bai KT (Enter sau moi diem): \n");
      double d1 = double.parse(stdin.readLineSync()!);
      double d2 = double.parse(stdin.readLineSync()!);
      double d3 = double.parse(stdin.readLineSync()!);
      return ThucHanh(ma, ten, tc, d1, d2, d3);
    case 3:
      stdout.write("Diem GVHD (Giao vien huong dan): ");
      double gvhd = double.parse(stdin.readLineSync()!);
      stdout.write("Diem GVPB (Giao vien phan bien): ");
      double gvpb = double.parse(stdin.readLineSync()!);
      return DoAn(ma, ten, tc, gvhd, gvpb);
    default:
      return LyThuyet(ma, ten, tc, 0, 0);
  }
}
Future<void> docFileMonHoc(List<MonHoc> danhSach) async {
  final file = File('monhoc.txt');
  if (await file.exists()) {
    List<String> lines = await file.readAsLines();
    for (var line in lines) {
      if (line.trim().isEmpty) continue;
      var d = line.split('#');
      try {
        if (d[0] == 'LT') danhSach.add(LyThuyet(d[1], d[2], int.parse(d[3]), double.parse(d[4]), double.parse(d[5])));
        if (d[0] == 'TH') danhSach.add(ThucHanh(d[1], d[2], int.parse(d[3]), double.parse(d[4]), double.parse(d[5]), double.parse(d[6])));
        if (d[0] == 'DA') danhSach.add(DoAn(d[1], d[2], int.parse(d[3]), double.parse(d[4]), double.parse(d[5])));
      } catch (e) {
      }
    }
  } else {
    print("File monhoc.txt chua ton tai.");
  }
}