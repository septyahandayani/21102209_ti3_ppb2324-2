// class Hewan {
//   String nama;
//   int umur;
//   double berat;

//   Hewan(this.nama, this.umur, this.berat);

//   void makan() {
//     print('$nama makan.');
//     berat = berat + 0.2;
//   }

//   void tidur() {
//     print('$nama sedang tidur');
//   }
// }

// 

// abstract class Hewan {
//   String _nama = '';
//   int _umur = 0;
//   double _berat = 0;

//   Hewan(this._nama, this._umur, this._berat);

//   // Getter for name
//   String get nama => _nama;

//   // Getter for weight
//   double get berat => _berat;

//   void makan() {
//     print('$_nama is eating.');
//     _berat = _berat + 0.2;
//   }

//   void tidur() {
//     print('$_nama is sleeping.');
//   }

//   void poop() {
//     print('$_nama is pooping.');
//     _berat = _berat - 0.1;
//   }
// }

class Hewan {
  String _nama = '';
  int _umur = 0;
  double _berat = 0;

  Hewan(this._nama, this._umur, this._berat);

  // Getter for name
  String get nama => _nama;

  // Getter for weight
  double get berat => _berat;

  void makan() {
    print('$_nama is eating.');
    _berat = _berat + 0.2;
  }

  void tidur() {
    print('$_nama is sleeping.');
  }

  void poop() {
    print('$_nama is pooping.');
    _berat = _berat - 0.1;
  }
}
