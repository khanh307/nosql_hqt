import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class BaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  BaseService() {
    if (kIsWeb) {
      firestore
          .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
      print('setting firesore web');
    } else {
      firestore.settings = const Settings(
        persistenceEnabled: true,
      );
      print('setting firesore mobile');
    }
  }
}