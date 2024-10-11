import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}
