import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

// ignore: subtype_of_sealed_class
class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {
  @override
  String get id => 'siliosilio';

  @override
  Map<String, dynamic> data() => {
        'title': 'que mock grande!',
        'description': 'que mock grande, descicao!',
      };
}
