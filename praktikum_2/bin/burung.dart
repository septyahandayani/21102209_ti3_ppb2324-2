import 'Hewan.dart';
import 'Flyable.dart';

class Burung extends Hewan with Flyable {
  String warna;

  Burung(String nama, int umur, double berat, this.warna) : super(nama, umur, berat);

  void jalan() {
    print('$nama is walking.');
  }

  @override
  void fly() {
    print('$nama is flying.');
  }
}
