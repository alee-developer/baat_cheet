void main(){
  // Man().writeName();
  // Man().writeManName();
  // Boy().writeBoyName();
  Human()._writeName();
  // Man().writeName();
}

// single

class Human{
  void _writeName(){
    print("Man or Woman");
  }
}
class Man extends Human{
  writeManName(){
    print("Man");
  }

  @override
  _writeName() {
    print("This is man");
  }
}

// multi-level
// class Boy extends Man{
//
//   writeBoyName(){
//     print("Boy");
//   }
// }

class Woman extends Human{
  writeWomanName(){
    print("Woman");
  }
}