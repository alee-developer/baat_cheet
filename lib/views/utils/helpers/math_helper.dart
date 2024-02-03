import 'package:baat_cheet_app/views/utils/extensions/string_extensions.dart';

class MathHelper{

 static double calculatePercentage(List<int> digits,int totalNo){
    var add = 0;
    for(var digit in digits){
      add = add+digit;
    }
    return ((add/totalNo)*100).toStringAsFixed(2).toDouble();
  }

  static double calculateGenericPurity(List<double> values){
   double add = 0;
   for(var i in values){
     add = add+i;
   }
   return 100-add;
  }

}