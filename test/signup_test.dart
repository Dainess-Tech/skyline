import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/signup.dart';

void main() {
  testWidgets('validates fields and submits account details', (tester) async {
    String? submittedName;
    String? submittedEmail;
    String? submittedPassword;

    await tester.pumpWidget(
      MaterialApp(
        home: SignUpPage(
          onSignUp: ({
            required String name,
            required String email,
            required String password,
          }) async {
            submittedName = name;
            submittedEmail = email;
            submittedPassword = password;
          },
        ),
      ),
    );

    await tester.ensureVisible(find.text('Create account').last);
    await tester.tap(find.text('Create account').last);
    await tester.pumpAndSettle();
    expect(find.text('Enter your name.'), findsOneWidget);
    expect(find.text('Enter your email address.'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '  Ada Lovelace  ');
    await tester.enterText(fields.at(1), 'ada@example.com');
    await tester.enterText(fields.at(2), 'password123');
    await tester.enterText(fields.at(3), 'password123');

    await tester.ensureVisible(find.text('Create account').last);
    await tester.tap(find.text('Create account').last);
    await tester.pumpAndSettle();

    expect(submittedName, 'Ada Lovelace');
    expect(submittedEmail, 'ada@example.com');
    expect(submittedPassword, 'password123');
  });
}
