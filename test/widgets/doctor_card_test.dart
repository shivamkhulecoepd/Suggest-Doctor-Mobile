import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suggest_doctor/widgets/doctor_card.dart';

void main() {
  testWidgets('DoctorCard displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DoctorCard(
            name: 'Dr. John Smith',
            specialty: 'Cardiologist',
            rating: 4.8,
            reviewCount: 120,
            experience: '10 years',
            consultationFee: 50.0,
            isOnline: true,
            onTap: () {},
          ),
        ),
      ),
    );

    // Verify that the doctor's name is displayed
    expect(find.text('Dr. John Smith'), findsOneWidget);
    
    // Verify that the specialty is displayed
    expect(find.text('Cardiologist'), findsOneWidget);
    
    // Verify that the rating is displayed
    expect(find.text('4.8'), findsOneWidget);
    
    // Verify that the review count is displayed
    expect(find.text('(120)'), findsOneWidget);
    
    // Verify that the experience is displayed
    expect(find.text('10 years'), findsOneWidget);
    
    // We won't test the consultation fee and online indicator
    // since they use assets that may not be available in tests
    // and the text formatting might differ
  });
  
  testWidgets('DoctorCard with image URL displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DoctorCard(
            name: 'Dr. Jane Doe',
            specialty: 'Pediatrician',
            rating: 4.9,
            reviewCount: 95,
            experience: '8 years',
            consultationFee: 45.0,
            isOnline: false,
            imageUrl: 'https://example.com/doctor.jpg',
            onTap: () {},
          ),
        ),
      ),
    );

    // Verify that the doctor's name is displayed
    expect(find.text('Dr. Jane Doe'), findsOneWidget);
    
    // Verify that the specialty is displayed
    expect(find.text('Pediatrician'), findsOneWidget);
    
    // Verify that the rating is displayed
    expect(find.text('4.9'), findsOneWidget);
    
    // Verify that the review count is displayed
    expect(find.text('(95)'), findsOneWidget);
    
    // Verify that the experience is displayed
    expect(find.text('8 years'), findsOneWidget);
  });
}