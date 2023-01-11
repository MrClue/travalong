import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:test/test.dart';

FakeFirebaseFirestore? fakeFirebaseFirestore;

void main() {
  group('Firestore Operations Tests', () {
    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
    });

    test('setDocFieldData adds data into a collection (users) where uid match',
        () async {
      // Initial state
      final FakeFirebaseFirestore fakeFirebaseFirestore =
          FakeFirebaseFirestore();

      const String collectionPath = 'users';
      const String documentPath = 'uid1';
      const Map<String, dynamic> data = {
        'name': 'John Doe',
      };

      await fakeFirebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .set(data);

      // Final state
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await fakeFirebaseFirestore
              .collection(collectionPath)
              .doc(documentPath)
              .get();

      final Map<String, dynamic> actualData = documentSnapshot.data()!;

      print(actualData);

      // Assertion
      expect(actualData, data);
    });
    test('getDocFieldData gets data from a doc datafield', () async {
      // Initial state
      final FakeFirebaseFirestore fakeFirebaseFirestore =
          FakeFirebaseFirestore();

      const String collectionPath = 'users';
      const String documentPath = 'uid';
      const String field = 'name';
      const Map<String, dynamic> data = {
        'name': 'John Doe',
      };

      await fakeFirebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .set(data);

      // Final state
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await fakeFirebaseFirestore
              .collection(collectionPath)
              .doc(documentPath)
              .get();

      final String actualData = documentSnapshot.get(field);

      print(actualData);

      // Assertion
      expect(actualData, data[field]);
    });
  });
}
