class BibleModel {
  List<Book>? book;

  BibleModel({this.book});

  BibleModel.fromJson(Map<String, dynamic> json) {
    if (json['Book'] != null) {
      book = <Book>[];
      json['Book'].forEach((v) {
        book!.add(Book.fromJson(v));
      });
    }
  }
}

class Book {
  List<Chapter>? chapter;

  Book({this.chapter});

  Book.fromJson(Map<String, dynamic> json) {
    if (json['Chapter'] != null) {
      chapter = <Chapter>[];
      json['Chapter'].forEach((v) {
        chapter!.add(Chapter.fromJson(v));
      });
    }
  }
}

class Chapter {
  List<Verse>? verse;

  Chapter({this.verse});

  Chapter.fromJson(Map<String, dynamic> json) {
    if (json['Verse'] != null) {
      verse = <Verse>[];
      json['Verse'].forEach((v) {
        verse!.add(Verse.fromJson(v));
      });
    }
  }
}

class Verse {
  String? verseid;
  String? verse;

  Verse({this.verseid, this.verse});

  Verse.fromJson(Map<String, dynamic> json) {
    verseid = json['Verseid'];
    verse = json['Verse'];
  }
}
