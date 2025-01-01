  import 'package:hive/hive.dart';

  part 'tasks.g.dart';

  @HiveType(typeId: 0)
  class PersonalTask {
    @HiveField(0)
    String title;

    @HiveField(1)
    String description;

    @HiveField(2)
    bool isRelatedToMoney;

    @HiveField(3)
    double? money; // Optional field

    @HiveField(4)
    DateTime dueDate;

    PersonalTask({
      required this.title,
      required this.description,
      required this.isRelatedToMoney,
      required this.money,
      required this.dueDate,
    });
  }

  @HiveType(typeId: 1)
  class AcademicTask {
    @HiveField(0)
    String courseCode;

    @HiveField(1)
    String description;

    @HiveField(2)
    DateTime dueDate;

    AcademicTask({
      required this.courseCode,
      required this.description,
      required this.dueDate,
    });
  }
