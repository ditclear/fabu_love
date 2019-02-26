
import 'package:flutter/cupertino.dart';

class BaseViewModel with ChangeNotifier{

}

class CountViewModel extends BaseViewModel{
  final count = ValueNotifier(0);
  increment(){
    count.value = count.value+1;
  }

}