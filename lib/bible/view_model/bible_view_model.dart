import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samples/bible/model/bible_book_model.dart';
import 'package:samples/bible/model/bible_model.dart';
import 'package:samples/bible/service/local_storage_service.dart';

class BibleViewModel with ChangeNotifier {
  int initialBookIndex = 0;

  int tabLength = 0;
  int tabInitialChaptersIndex = 0;

  List<Book> englisBibleVerses = [];
  List<Book> malayalamBibleVerses = [];

  List<String> malayalamBooks = [];
  List<String> englishBooks = [];

  List<Chapter> malayalamChapters = [];
  List<Chapter> englishChapters = [];

  late TabController booksTabController;
  late TabController chaptersTabController;
  late TickerProvider ticker;

  String selectedValue = 'പഴയ നിയമം';
  String currentBookName = "";

  bool isScrollActive = false;

  Future<bool> getSavedData() async {
    String bookIndex = await LocalStorageService.getSavedData(
        key: LocalStorageService.bookIndexKey);
    String chapterIndex = await LocalStorageService.getSavedData(
        key: LocalStorageService.chapterIndexKey);
    String selectedTestment = await LocalStorageService.getSavedData(
        key: LocalStorageService.testmentKey);

    try {
      initialBookIndex = int.tryParse(bookIndex) ?? 0;
      tabInitialChaptersIndex = int.tryParse(chapterIndex) ?? 0;

      if (selectedTestment != '') {
        selectedValue = selectedTestment;
      }

      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  initializeTabs(TickerProvider ticker) async {
    this.ticker = ticker;
    booksTabController = TabController(
      initialIndex: initialBookIndex,
      length: malayalamBooks.length,
      vsync: ticker,
    );
    chaptersTabController = TabController(
        initialIndex: tabInitialChaptersIndex,
        length: tabLength,
        vsync: ticker);
    addListner();
    getCurrentBookName();
  }

  addListner() {
    chaptersTabController.addListener(() {
      tabInitialChaptersIndex = chaptersTabController.index;
      LocalStorageService.saveToLocalStorage(
          key: LocalStorageService.chapterIndexKey,
          value: tabInitialChaptersIndex.toString());
      notifyListeners();
    });
  }

  Future<bool> loadBibleData() async {
    return getSavedData().then((value) async {
      await getMalayalamBibleBooks();
      await getEnglishBibleBooks();
      await getMalayalamBibleVerses();
      await getEnglishBibleVerses();
      return true;
    });
  }

  Future<bool> getEnglishBibleVerses() async {
    try {
      String englishVerses =
          await rootBundle.loadString('assets/json/english.json');

      final List<Book> list = await Isolate.run<List<Book>>(() async {
        Map<String, dynamic> json = jsonDecode(englishVerses);
        BibleModel model = BibleModel.fromJson(json);
        final list = model.book ?? [];
        return list;
      });

      if (list.isNotEmpty) {
        englisBibleVerses = [];
        englisBibleVerses.addAll(list);
        print(englisBibleVerses.length);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> getMalayalamBibleVerses() async {
    try {
      String malayalamVerses =
          await rootBundle.loadString('assets/json/malayalam.json');
      final List<Book> list = await Isolate.run<List<Book>>(() async {
        Map<String, dynamic> json = jsonDecode(malayalamVerses);
        BibleModel model = BibleModel.fromJson(json);
        final list = model.book ?? [];
        return list;
      });
      if (list.isNotEmpty) {
        malayalamBibleVerses = [];
        malayalamBibleVerses.addAll(list);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> getMalayalamBibleBooks() async {
    try {
      String mBooks =
          await rootBundle.loadString('assets/json/malayalam_books.json');
      final List<String> list = await Isolate.run<List<String>>(() async {
        Map<String, dynamic> json = jsonDecode(mBooks);
        BibleBook model = BibleBook.fromJson(json);
        final list = model.books ?? [];
        return list;
      });

      if (list.isNotEmpty) {
        malayalamBooks = [];
        malayalamBooks.addAll(list);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> getEnglishBibleBooks() async {
    try {
      String mBooks =
          await rootBundle.loadString('assets/json/english_books.json');

      final List<String> list = await Isolate.run<List<String>>(() async {
        Map<String, dynamic> json = jsonDecode(mBooks);
        BibleBook model = BibleBook.fromJson(json);
        final list = model.books ?? [];
        return list;
      });

      if (list.isNotEmpty) {
        englishBooks = [];
        englishBooks.addAll(list);
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  getTabLenght() {
    malayalamChapters = [];
    englishChapters = [];
    malayalamChapters = malayalamBibleVerses[initialBookIndex].chapter ?? [];
    englishChapters = englisBibleVerses[initialBookIndex].chapter ?? [];
    if (malayalamChapters.isNotEmpty && englishChapters.isNotEmpty) {
      tabLength = malayalamChapters.length;
    } else {
      tabLength = 0;
    }
    notifyListeners();
  }

  getChaptersIndex(int index) {
    tabInitialChaptersIndex = index;
    LocalStorageService.saveToLocalStorage(
        key: LocalStorageService.chapterIndexKey, value: index.toString());
    notifyListeners();
  }

  getBooksIndex(int index) {
    tabInitialChaptersIndex = 0;
    initialBookIndex = index;
    if (index >= 39) {
      selectedValue = "പുതിയ നിയമം";
      LocalStorageService.saveToLocalStorage(
          key: LocalStorageService.testmentKey, value: selectedValue);
    } else {
      selectedValue = "പഴയ നിയമം";
      LocalStorageService.saveToLocalStorage(
          key: LocalStorageService.testmentKey, value: selectedValue);
    }
    getTabLenght();
    chaptersTabController.dispose();

    chaptersTabController = TabController(
        initialIndex: tabInitialChaptersIndex,
        length: tabLength,
        vsync: ticker);
    LocalStorageService.saveToLocalStorage(
        key: LocalStorageService.bookIndexKey, value: index.toString());
    LocalStorageService.saveToLocalStorage(
        key: LocalStorageService.chapterIndexKey,
        value: tabInitialChaptersIndex.toString());
    addListner();
    getCurrentBookName();
    notifyListeners();
  }

  updateTestements(int index, String testment) {
    selectedValue = testment;
    LocalStorageService.saveToLocalStorage(
        key: LocalStorageService.testmentKey, value: selectedValue);

    booksTabController.dispose();
    initialBookIndex = index;
    booksTabController = TabController(
        initialIndex: index, length: malayalamBooks.length, vsync: ticker);
    LocalStorageService.saveToLocalStorage(
        key: LocalStorageService.bookIndexKey, value: index.toString());
    getBooksIndex(index);
    notifyListeners();
  }

  getCurrentBookName() {
    currentBookName = malayalamBooks[initialBookIndex];
    notifyListeners();
  }

  Future<String> getIsScrollActive() async {
    String value = await LocalStorageService.getSavedData(
        key: LocalStorageService.canSaveScrolledPositionKey);
    if (value == "1") {
      isScrollActive = true;
    } else {
      isScrollActive = false;
    }
    return value;
  }

  Future<void> canSaveScrollPosition(String value) async {
    LocalStorageService.saveToLocalStorage(
        key: LocalStorageService.canSaveScrolledPositionKey, value: value);
  }

  update() {
    notifyListeners();
  }
}
