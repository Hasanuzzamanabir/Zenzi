import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/auth/view/log_in_view.dart';
import 'package:zenzi/modules/just%20breathe/controller/just_breathe_controller.dart';
import '../painters/just_breathe_painter.dart';

class JustBreathePageView extends StatelessWidget {
  const JustBreathePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final JustBreatheController controller = Get.put(JustBreatheController());

    // Dynamic color based on time (6 PM to 6 AM)
    final now = DateTime.now();
    final bool isNight = now.hour >= 18 || now.hour < 6;
    final Color brownColor = isNight
        ? const Color(0xFF1D1249)
        : AppColors.coreprimarydark;

    return Scaffold(
      backgroundColor: brownColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            ScreenUtil.init(
              context,
              designSize: Size(375, 812),
              minTextAdapt: true,
            );
            final double screenW = constraints.maxWidth;
            final double screenH = constraints.maxHeight;

            // Animation area
            final double animSize = screenW * 0.74;
            final double animTop = 128.h;
            final double animRectRadius = 36.r;
            final Color rectColor = AppColors.coreprimarydark.withOpacity(0.92);

            // Text
            final double textLeft = 28.w;
            final double textTop = 32.h;
            final double textSpacing = 10.h;

            // Slider
            final double sliderBottom = 32.h;
            final double sliderHorizontal = 18.w;

            return Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Centered rounded rectangle with animation
                  Positioned(
                    top: animTop,
                    left: (screenW - animSize) / 2,
                    child: Container(
                      width: animSize,
                      height: animSize,
                      decoration: BoxDecoration(
                        //color: rectColor,
                        borderRadius: BorderRadius.circular(animRectRadius),
                      ),
                      child: AnimatedBuilder(
                        animation: controller.animationController,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: JustBreathePainter(
                              animationValue:
                                  controller.animationController.value,
                              dotColor: Colors.white,
                              dotRadius: (animSize * 0.010).clamp(7.0, 13.0),
                              strokeWidth: 2.2.w,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Text section
                  Positioned(
                    left: textLeft,
                    top: animTop + animSize + textTop + 80.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Zenzi wellness",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.92),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(height: textSpacing),
                        Text(
                          "Just breathe",
                          style: TextStyle(
                            color: AppColors.primarytext,
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.13,
                            //letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Slider at bottom right (50% width)
                  Positioned(
                    right: sliderHorizontal,
                    bottom: sliderBottom,
                    width: screenW * 0.59,
                    child: SlideActionBtn(
                      onSubmit: () {
                        Get.to(const LogInView());
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SlideActionBtn extends StatefulWidget {
  final VoidCallback onSubmit;
  const SlideActionBtn({super.key, required this.onSubmit});

  @override
  State<SlideActionBtn> createState() => _SlideActionBtnState();
}

class _SlideActionBtnState extends State<SlideActionBtn> {
  double _dragValue = 0.0;
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    final double pillHeight = 58.h;
    final double pillRadius = 29.h;
    final double pillPadding = 6.w;
    final double handleSize = 46.h;
    final double textPadding = 12.w;
    final double textFont = 16.sp;
    final Color pillColor = const Color(0xFFE2C7B0).withOpacity(0.62);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Safe max drag calculation
        final maxDrag = (constraints.maxWidth - handleSize - (pillPadding * 2))
            .clamp(0.0, double.infinity);

        return Container(
          height: pillHeight,
          decoration: BoxDecoration(
            color: pillColor,
            borderRadius: BorderRadius.circular(pillRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(pillRadius),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Background Content strictly using Row
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: pillPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Space for handle + spacing
                        SizedBox(width: handleSize + textPadding),

                        // Text
                        Expanded(
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              color: AppColors.primarytext,
                              fontSize: textFont,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Three Arrows with Gradient Opacity
                        Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                widthFactor: 0.6,
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color(0xFF838383).withOpacity(0.9),
                                  size: 24.sp,
                                ),
                              ),
                              Align(
                                widthFactor: 0.6,
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color(0xFFA6A6A6).withOpacity(0.9),
                                  size: 24.sp,
                                ),
                              ),
                              Align(
                                widthFactor: 0.6,
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: AppColors.primarytext,
                                  size: 24.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Draggable Handle
                Positioned(
                  left: pillPadding + (_dragValue * maxDrag),
                  top: (pillHeight - handleSize) / 2,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (_submitted) return;
                      setState(() {
                        // Prevent division by zero
                        if (maxDrag > 0) {
                          double dx = details.primaryDelta! / maxDrag;
                          _dragValue += dx;
                          _dragValue = _dragValue.clamp(0.0, 1.0);
                        }
                      });
                    },
                    onHorizontalDragEnd: (details) {
                      if (_submitted) return;
                      // Threshold to snap
                      if (_dragValue > 0.85) {
                        setState(() {
                          _dragValue = 1.0;
                          _submitted = true;
                        });
                        HapticFeedback.mediumImpact();
                        widget.onSubmit();
                      } else {
                        setState(() {
                          _dragValue = 0.0;
                        });
                      }
                    },
                    child: Container(
                      width: handleSize,
                      height: handleSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF1C1B1F),
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
