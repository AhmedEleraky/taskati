import 'package:hive/hive.dart';

class ProjectLocalStorage {
  static late Box box;
  init() {
    box = Hive.box('user');
  }

  static casheData(key, value) {
    box.put(key, value);
  }

  static getCashedData(key) {
    return box.get(key);
  }
}
