import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}
