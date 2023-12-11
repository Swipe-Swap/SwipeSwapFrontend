import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:swipeswap/main.dart';
import 'package:swipeswap/src/screens/home/profile.dart';

import 'package:mockito/annotations.dart';

// TODO: still have to learn how to use mockito
// As well as how to

@GenerateMocks([Profile])
void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient((request) => null);
  });
  testWidgets('Get', (WidgetTester tester) async {
    await tester.pumpWidget(const Profile());

    // TODO

    // Verify that a user's profile contains:
    // 1. A circle avatar for the users icon
    // 2. The users name
    // 3. The users phone number
    // 4. A logout button
    expect(find.byWidget(CircleAvatar()), findsOneWidget);
    expect(find.byWidget(CircleAvatar()), findsOneWidget);

    // Verify that the user can interact with:
    // 1. Circle avatar (file drop down)
    // 2. Name
    // 3. Phone number
    // 4. Logout button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
  });
  testWidgets('Update - valid', (WidgetTester tester) async {
    await tester.pumpWidget(const Profile());

    // Verify that the user can update their
    // 1. Avatar
    // 2. Name
    // 3. Phone Number
    // 4. Logout button
    // with valid data
  });
  testWidgets('Update - invalid', (WidgetTester tester) async {
    await tester.pumpWidget(const Profile());

    // Verify that the user can update their
    // 1. Avatar
    // 2. Name
    // 3. Phone Number
    // 4. Logout button
    // with valid data
  });
}
