import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements User {
  @override
  String get uid => 'siliosiliosilio';

  @override
  String? get email => 'siliosffreitas@gmail.com';
}
