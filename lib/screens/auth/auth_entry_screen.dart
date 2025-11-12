import 'package:flutter/material.dart';
import 'package:suggest_doctor/screens/home/home_screen_modern.dart';

class AuthEntryScreen extends StatelessWidget {
  const AuthEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              // Welcome text
              Text(
                'Welcome to',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              Text(
                'Suggest Doctor',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Your health is our priority. Connect with top doctors and manage your health journey.',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              // Illustration
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Icon(
                    Icons.health_and_safety,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sign in options
              Text(
                'Sign in with',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // Phone OTP option
              _AuthOptionCard(
                icon: Icons.phone,
                title: 'Phone Number',
                subtitle: 'Quick sign in with OTP',
                onTap: () {
                  Navigator.pushNamed(context, '/signup_phone');
                },
              ),

              const SizedBox(height: 16),

              // Email/Password option
              _AuthOptionCard(
                icon: Icons.email,
                title: 'Email & Password',
                subtitle: 'Traditional sign in method',
                onTap: () {
                  Navigator.pushNamed(context, '/signin_email');
                },
              ),

              const SizedBox(height: 10),

              // Social login options
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _AuthOptionCardWithSocial(
                    imageAsset:
                        'assets/icons/google_logo.png', // <-- your Google logo
                    title: 'Google',
                    subtitle: 'Continue with Google',
                    onTap: () {
                      // Google login implementation
                    },
                  ),

                  _AuthOptionCardWithSocial(
                    imageAsset:
                        'assets/icons/facebook_logo.png', // <-- your Google logo
                    title: 'Facebook',
                    subtitle: 'Continue with Facebook',
                    onTap: () {
                      // Google login implementation
                    },
                  ),
                ],
              ),

              // Continue as guest
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomeScreenModern(),
                        maintainState: false,
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Continue as Guest',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              // Why sign in tooltip
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    // Show why sign in dialog
                    _showWhySignInDialog(context);
                  },
                  icon: const Icon(Icons.info_outline, size: 16),
                  label: const Text('Why sign in?'),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showWhySignInDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Why Sign In?'),
          content: const Text(
            'Signing in allows you to:\n\n'
            '• Save your medical history\n'
            '• Track appointments\n'
            '• Access prescriptions\n'
            '• Book appointments faster\n'
            '• Sync data across devices',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }
}

class _AuthOptionCard extends StatelessWidget {
  final IconData? icon; // null when using an image
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AuthOptionCard({
    this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // ── Logo container (icon **or** image) ───────────────
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthOptionCardWithSocial extends StatelessWidget {
  final String? imageAsset;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AuthOptionCardWithSocial({
    this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.asset(
              imageAsset!,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
