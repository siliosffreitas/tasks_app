import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {
  @override
  String get id => 'siliosilio';

  @override
  Map<String, dynamic> data() {
    return {
      'title': 'que mock grande!',
      'description': 'que mock grande, descicao!',
    };
  }
}
