import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_user.dart';

class MockUserCredential extends Mock implements UserCredential {
  @override
  User? get user => MockUser();
}
