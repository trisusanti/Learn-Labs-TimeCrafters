class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['is_completed'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['is_completed'] = this.isCompleted;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['color'] = this.color;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    return data;
  }
}
