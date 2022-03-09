// ignore_for_file: file_names, non_constant_identifier_names

class UIInfo {
  int? start_date;
  int? end_date;
  String? docID;
  String title;
  String desc;
  int color;
  // String reg_user;
  int bar_length;

  UIInfo(this.start_date, this.end_date, this.docID, this.title, this.desc,
      this.color, this.bar_length);

  @override
  String toString() {
    return 'Student: {start: ${start_date}, end: ${end_date}, title : ${title}, len : ${bar_length}}';
  }
}
