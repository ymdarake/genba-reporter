class Stock {
  String title;
  String member;

  Stock(this.title, this.member);

  Map<String, dynamic> toJson() => {
        'title': title,
        'member': member,
      };

  Stock.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        member = json['member'];
}
