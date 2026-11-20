import 'package:flutter/foundation.dart';

import 'models/experience.dart';

class SavedExperiences extends ChangeNotifier {
  final List<Experience> _items = [];

  List<Experience> get items => List.unmodifiable(_items);

  bool contains(String id) {
    return _items.any((experience) => experience.id == id);
  }

  void toggle(Experience experience) {
    if (contains(experience.id)) {
      remove(experience.id);
    } else {
      _items.insert(0, experience);
      notifyListeners();
    }
  }

  void remove(String id) {
    final previousLength = _items.length;

    _items.removeWhere((experience) => experience.id == id);

    if (_items.length != previousLength) {
      notifyListeners();
    }
  }
}

final savedExperiences = SavedExperiences();