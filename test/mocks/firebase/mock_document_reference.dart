import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}
