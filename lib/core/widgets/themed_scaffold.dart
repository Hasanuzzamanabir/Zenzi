import 'package:flutter/material.dart';
import 'package:zenzi/core/theme/app_theme.dart';

/// A themed scaffold that automatically applies day/night background colors.
/// Day (6am-6pm): Uses AppTheme.dayBackgroundColor
/// Night (6pm-6am): Uses AppTheme.nightGradient
///
/// AppBars should use `backgroundColor: Colors.transparent` to inherit the theme.
class ThemedScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;

  const ThemedScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    final int currentHour = DateTime.now().hour;
    final bool isDay = currentHour >= 6 && currentHour < 18;

    final BoxDecoration themeDecoration = BoxDecoration(
      color: isDay ? AppTheme.dayBackgroundColor : null,
      gradient: isDay ? null : AppTheme.nightGradient,
    );

    return Container(
      decoration: themeDecoration,
      child: Scaffold(
        extendBody: extendBody,
        extendBodyBehindAppBar: true, // Always extend behind AppBar for theming
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: Colors.transparent,
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        body: body,
      ),
    );
  }
}
