import 'package:flutter/material.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';

class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Terms & Conditions',
          style: TextStyle(color: AppColors.primarytext),
        ),
        iconTheme: IconThemeData(color: AppColors.primarytext),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Information We Collect'),
            _buildSectionContent(
              'We may collect the following types of information:',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('2. Acceptance of Terms'),
            _buildSectionContent(
              'By accessing or using Zenzi, you confirm that you are at least 18 years old or have permission from a legal guardian. You agree to comply with all terms, policies, and updates provided by Zenzi.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('3. Description of the Service'),
            _buildSectionContent(
              'Zenzi provides wellness-related tools including:',
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Guided meditation'),
            _buildBulletPoint('Breathing exercises'),
            _buildBulletPoint('Sleep sounds & stories'),
            _buildBulletPoint('Focus music'),
            _buildBulletPoint('Affirmations'),
            _buildBulletPoint('Mood check-ins'),
            _buildBulletPoint('Gamification rewards'),
            _buildBulletPoint(
              'Therapy directory & chat-based counselling (Phase 1)',
            ),
            const SizedBox(height: 8),
            _buildSectionContent(
              'Zenzi does NOT provide medical, psychological, or emergency mental health care. The app is for well-being support only.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('4. Not a Medical Service'),
            _buildSectionContent(
              'Zenzi is not a substitute for professional medical advice, diagnosis, or treatment. If you are facing a crisis, mental health emergency, or feel unsafe, seek help immediately through your local emergency number or a licensed mental health professional.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('5. User Accounts'),
            _buildSectionContent('When creating an account, you agree to:'),
            const SizedBox(height: 8),
            _buildBulletPoint('Provide accurate and truthful information'),
            _buildBulletPoint('Keep your login credentials secure'),
            _buildBulletPoint('Not share your account with others'),
            const SizedBox(height: 8),
            _buildSectionContent(
              'You are responsible for all activities under your account.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('6. Subscription & Payments'),
            _buildSectionContent(
              'Some features are free, while premium features require a subscription. Zenzi uses Paystack (and may use additional payment processors) for secure transactions.',
            ),
            const SizedBox(height: 8),
            _buildSectionContent('By subscribing, you agree that:'),
            const SizedBox(height: 8),
            _buildBulletPoint(
              'Payments are non-refundable unless required by law',
            ),
            _buildBulletPoint('Subscriptions auto-renew unless cancelled'),
            _buildBulletPoint('Prices may change, with notice provided'),
            const SizedBox(height: 24),
            _buildSectionTitle('7. Privacy & Data Protection'),
            _buildSectionContent(
              'Zenzi collects and stores limited user data to operate the service, such as:',
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Email or authentication details'),
            _buildBulletPoint('Mood check-ins'),
            _buildBulletPoint('Session history'),
            _buildBulletPoint('Favorites & preferences'),
            const SizedBox(height: 8),
            _buildSectionContent(
              'Zenzi does NOT sell personal data. Please review our separate Privacy Policy for full details.',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('8. Limitation of Liability'),
            _buildSectionContent(
              'Zenzi is provided "as is" without warranties. Zenzi is not liable for:',
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Data loss'),
            _buildBulletPoint('Service interruptions'),
            _buildBulletPoint('Third-party therapist actions'),
            _buildBulletPoint('Emotional outcomes or lack of results'),
            const SizedBox(height: 8),
            _buildSectionContent('Your use of the app is at your own risk.'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primarytext,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        color: AppColors.secondarycolor,
        fontSize: 14,
        height: 1.5,
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(color: AppColors.secondarycolor, fontSize: 14),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.secondarycolor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
