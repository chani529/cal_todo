// ignore_for_file: non_constant_identifier_names, file_names

class TaskInfo {
  int start_date;
  int end_date;

  String? title;
  String? desc;
  String? color;

  bool? is_disabled;
  String reg_user_id;
  String reg_date;

  TaskInfo(this.start_date, this.end_date, this.title, this.desc, this.color,
      this.reg_user_id, this.reg_date);
}
