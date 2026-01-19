import 'package:flutter/material.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';

class LevelupView extends StatelessWidget {
  const LevelupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFD08C0D),
                  Color(0xFFCDA434),
                  Color(0xFFB47510),
                ],
              ),
            ),
          ),

          // Confetti GIF at the very top of the screen
          Column(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppAssets
                      .congretsgif, // Or AppAssets.confettiGif if available
                  width: double.infinity,
                  height: 380,
                  // fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppAssets.levelup, width: 340, fit: BoxFit.contain),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Level Up!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Rising',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFC95600),
                  ),
                ),
              ),
              SizedBox(height: 22),
              Center(
                child: Text(
                  'Total score : 345',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondarycolor,
                  ),
                ),
              ),
              SizedBox(height: 40),
              AppButton(
                backgroundColor: AppColors.backgroundcolor,
                title: 'GOT IT',
                onTap: () {},
                width: 80,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
