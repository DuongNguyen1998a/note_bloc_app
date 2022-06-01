import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String title;
  final String createDate;
  final bool isCompleted;

  const Note(
      {required this.title,
      required this.createDate,
      required this.isCompleted});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      createDate: json['createDate'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['createDate'] = createDate;
    data['isCompleted'] = isCompleted;
    return data;
  }

  String getDay() {
    return DateTime.parse(createDate).day.toString();
  }

  String getMonthAndYear() {
    List months = [
      'Jan',
      'Feb',
      'Mar',
      'April',
      'May',
      'Jun',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    int monthName = DateTime.parse(createDate).month;
    return '${months[monthName - 1]} ${DateTime.parse(createDate).year}';
  }

  String getTime() {
    List days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
    int dayOfWeek = DateTime.parse(createDate).weekday;
    String minutes = '';
    if (DateTime.parse(createDate).minute < 10) {
      minutes = '0${DateTime.parse(createDate).minute}';
    } else {
      minutes = '${DateTime.parse(createDate).minute}';
    }

    return '${DateTime.parse(createDate).hour}:$minutes, ${days[dayOfWeek - 1]}';
  }

  @override
  List<Object?> get props => [title, createDate, isCompleted];

  static List<Note> fetchNotes() {
    return [
      const Note(
          title: 'working with flutter',
          createDate: '2022-05-25 11:25:00',
          isCompleted: false),
      const Note(
          title: 'lunch time',
          createDate: '2022-05-25 12:03:00',
          isCompleted: false),
      const Note(
          title: 'lunch time 1',
          createDate: '2022-05-26 12:03:00',
          isCompleted: true),
      const Note(
          title: 'lunch time 2',
          createDate: '2022-05-27 12:03:00',
          isCompleted: true),
    ];
  }
}
