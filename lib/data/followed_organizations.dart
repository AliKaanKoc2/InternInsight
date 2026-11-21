import 'package:flutter/foundation.dart';

import 'models/organization.dart';
import 'mock_organizations.dart';

class FollowedOrganizations extends ChangeNotifier {
  final List<Organization> _items = [
    mockOrganizations[0],
    mockOrganizations[1],
  ];

  List<Organization> get items => List.unmodifiable(_items);

  bool contains(String id) {
    return _items.any((organization) => organization.id == id);
  }

  void toggle(Organization organization) {
    if (contains(organization.id)) {
      remove(organization.id);
    } else {
      _items.add(organization);
      notifyListeners();
    }
  }

  void remove(String id) {
    final previousLength = _items.length;

    _items.removeWhere((organization) => organization.id == id);

    if (_items.length != previousLength) {
      notifyListeners();
    }
  }
}

final followedOrganizations = FollowedOrganizations();