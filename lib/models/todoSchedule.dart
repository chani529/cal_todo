// ignore_for_file: non_constant_identifier_names, file_names

class TodoSchedule {
  int start_year;
  int start_month;
  int start_date;

  int end_year;
  int end_month;
  int end_date;

  String title;
  String desc;
  String color;

  bool? is_disabled;
  String reg_user_id;
  String reg_date;

  TodoSchedule(
      this.start_year,
      this.start_month,
      this.start_date,
      this.end_year,
      this.end_month,
      this.end_date,
      this.title,
      this.desc,
      this.color,
      this.reg_user_id,
      this.reg_date);
}
