class Stock {
  String id;
  String title;
  String member;
  String detail;

  Stock(this.id, this.title, this.member, this.detail);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'member': member,
        'detail': detail,
      };

  Stock.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        member = json['member'],
        detail = json['detail'];
}
