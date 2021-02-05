class Counter {
  Map<dynamic, dynamic> map = {};

  void increaseValue(dynamic key){
    if(!map.containsKey(key)){
      map[key] = 1;
    }else{
      map[key] += 1;
    }
  }
  void decreaseValue(dynamic key){
    if(!map.containsKey(key)){
      map[key] = -1;
    }else{
      map[key] -= 1;
    }
  }


  dynamic getValue(dynamic key){
    if(!map.containsKey(key)){
      return 0;
    }else{
      return map[key];
    }
  }

}