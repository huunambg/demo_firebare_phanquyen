class Infor {
  String? tenKhach;
  int? sdt;
  String? diemA;
  String? diemB;
  int? gia;
  Infor({this.tenKhach, this.sdt, this.diemA, this.diemB, this.gia});
  Map<String, dynamic> toJson() => {
        'tenKhach': tenKhach,
        'sdt': sdt,
        'diemA': diemA,
        'diemB': diemB,
        'gia': gia
      };
}
