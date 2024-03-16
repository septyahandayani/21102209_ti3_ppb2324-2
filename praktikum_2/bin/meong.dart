import 'hewan.dart';

class Meong extends Hewan {
  String _warnaBulu;

  Meong(String nama, int umur, double berat, this._warnaBulu)
      : super(nama, umur, berat);

  void jalan() {
    print('\${nama} is walking');
  }
}
