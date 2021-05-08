import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopProvider extends ChangeNotifier {
  List<String> _locations = ['any'];
  String _selectedLoaction = 'any';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<String> get locations => _locations;
  String get selectedLoaction => _selectedLoaction;

  void changeSelectedLoaction(String value) {
    _selectedLoaction = value;
    notifyListeners();
  }

  Future<void> getLocations() async {
    _isLoading = true;
    notifyListeners();
    try {
      await FirebaseFirestore.instance.collection('shops').get().then((data) {
        if (data != null) {
          for (int i = 0; i < data.docs.length; i++) {
            String area = data.docs[i].data()['area'];
            if (!_locations.contains(area)) {
              _locations.add(area);
            }
          }
        }
      });
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
