class BibleBook {
  List<String>? books;

  BibleBook({this.books});

  BibleBook.fromJson(Map<String, dynamic> json) {
    books = json['books'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['books'] = books;
    return data;
  }
}
