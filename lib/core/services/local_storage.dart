import 'package:hive/hive.dart';
import 'package:taskati/features/data/task_model.dart';

class ProjectLocalStorage {
  static late Box box;
  static late Box<TaskModel> taskBox;
  
  init() {
    box = Hive.box('user');
    taskBox = Hive.box('task');
  }

  static casheData(key, value) {
    box.put(key, value);
  }

  static getCashedData(key) {
    return box.get(key);
  }

  static casheTask(key, TaskModel value) {
    taskBox.put(key, value);
  }

  static TaskModel? getCashedTask(key) {
    return taskBox.get(key);
  }
}
