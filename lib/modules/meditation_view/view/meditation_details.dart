// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';

class MeditationDetails extends StatefulWidget {
  const MeditationDetails({super.key});

  @override
  State<MeditationDetails> createState() => _MeditationDetailsState();
}

class _MeditationDetailsState extends State<MeditationDetails> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    setState(() {
      _isInitialized = false;
      _hasError = false;
    });

    // Using a more reliable and smaller sample URL
    _controller =
        VideoPlayerController.networkUrl(
            Uri.parse('https://vjs.zencdn.net/v/oceans.mp4'),
          )
          ..initialize()
              .then((_) {
                if (mounted) {
                  setState(() {
                    _isInitialized = true;
                  });
                  _controller.setLooping(true);
                  _controller.play();
                }
              })
              .catchError((error) {
                debugPrint("Video initialization failed: $error");
                if (mounted) {
                  setState(() {
                    _hasError = true;
                  });
                }
              });

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Top Icon Row (Back, Love, Save) - OUTSIDE video card
              _buildTopIconRow(context),

              SizedBox(height: 16.h),

              // Video Card Section
              _buildVideoCard(),

              SizedBox(height: 16.h),

              // Icons Row (Heart, Size Box, Share)
              _buildIconsRow(),

              SizedBox(height: 20.h),

              // Title and Duration
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meditation 101',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Duration : ${_formatDuration(_controller.value.duration)}',
                      style: TextStyle(
                        color: AppColors.secondarycolor,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Information',
                      style: TextStyle(
                        color: AppColors.secondarycolor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'This meditation is designed to gently slow your thoughts, soften tension, and bring you attention to a state of deep relaxation. Follow the breath, stay present, and let peaceful energy flow through you.',
                      style: TextStyle(
                        color: Color(0xFFD4A574),
                        fontSize: 13.sp,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Benefits Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: _buildBenefitsCard(),
              ),

              SizedBox(height: 24.h),

              // Challenge Progress Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: _buildChallengeSection(),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopIconRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          // Back Arrow Icon
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.secondarycolor,
              size: 24.sp,
            ),
          ),

          Spacer(),

          // Love/Favorite Icon
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.congratsscrennbuttonclr,
              shape: BoxShape.circle,
            ),
            child: Image.asset(AppAssets.lovbe, width: 20.w, height: 20.w),
          ),

          SizedBox(width: 16.w),

          // Download Icon
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.congratsscrennbuttonclr,
              shape: BoxShape.circle,
            ),
            child: Image.asset(AppAssets.download, width: 20.w, height: 20.w),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      height: 260.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            // Video or Thumbnail
            _isInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.black38,
                    child: Center(
                      child: _hasError
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 40.sp,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  "Failed to load video",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                TextButton(
                                  onPressed: _initializeVideo,
                                  child: Text(
                                    "Retry",
                                    style: TextStyle(
                                      color: AppColors.primarycolor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(color: Colors.white),
                                SizedBox(height: 12.h),
                                Text(
                                  "Loading Video...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

            // Gradient overlay for better text visibility
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),

            // Top right icons (small buttons and three dots)
            Positioned(
              top: 12.h,
              right: 12.w,
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.smallButtons,
                    width: 32.w,
                    height: 32.w,
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => _showVideoOptionsMenu(context),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),

            // Center Control Buttons
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.seekTo(
                        _controller.value.position - Duration(seconds: 10),
                      );
                    },
                    child: Image.asset(
                      AppAssets.secondaryButtons2,
                      width: 40.w,
                      height: 40.w,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    },
                    child: Container(
                      width: 64.w,
                      height: 64.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(AppAssets.mainController),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 32.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () {
                      _controller.seekTo(
                        _controller.value.position + Duration(seconds: 10),
                      );
                    },
                    child: Image.asset(
                      AppAssets.secondaryButtons,
                      width: 40.w,
                      height: 40.w,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Text and Time
            Positioned(
              bottom: 16.h,
              left: 16.w,
              right: 16.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Left Side: Title and Time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Meditation 01',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Text(
                                'Season 1',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  _formatDuration(_controller.value.position),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Right Side: Duration
                      Text(
                        '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2.r),
                    child: LinearProgressIndicator(
                      value: _isInitialized
                          ? _controller.value.position.inMilliseconds /
                                _controller.value.duration.inMilliseconds
                          : 0.0,
                      minHeight: 3.h,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconsRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          // Heart Icon with count
          Row(
            children: [
              Icon(Icons.favorite, color: Color(0xFFFF6B6B), size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                '89',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(width: 16.w),

          Spacer(),

          // Share Icon
          Row(
            children: [
              Image.asset(
                AppAssets.computerArrowUp,
                width: 20.w,
                height: 20.w,
                color: Color(0xFFD4A574),
              ),
              SizedBox(width: 6.w),
              Text(
                'share',
                style: TextStyle(color: Color(0xFFD4A574), fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.textfieldiconcolor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Benefits',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildBenefitItem('Reduces stress and anxiety'),
          SizedBox(height: 12.h),
          _buildBenefitItem('Improves emotional well-being'),
          SizedBox(height: 12.h),
          _buildBenefitItem('Enhances self-awareness'),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Row(
      children: [
        Image.asset(AppAssets.mark, width: 18.w, height: 18.w),
        SizedBox(width: 12.w),
        Text(
          text,
          style: TextStyle(color: AppColors.secondarycolor, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildChallengeSection() {
    return Row(
      children: [
        // Circular Progress Indicator
        SizedBox(
          width: 40.w,
          height: 40.h,
          child: CircularProgressIndicator(
            value: 23 / 60,
            strokeWidth: 4.w,
            backgroundColor: AppColors.navbackground,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primarycolor),
          ),
        ),

        SizedBox(width: 16.w),

        // Text Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '23 min of 60 min',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Challenge days',
                style: TextStyle(
                  color: AppColors.secondarycolor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Arrow Button
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.primarycolor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.navbackground,
            size: 20.sp,
          ),
        ),
      ],
    );
  }

  void _showVideoOptionsMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 100, 20, 0),
      color: Color(0xFFB88A5C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      items: [
        PopupMenuItem(
          value: 'pip',
          child: Text(
            'picture in picture',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
        PopupMenuItem(
          value: 'download',
          child: Text(
            'Download',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        // Handle menu item selection
        if (value == 'pip') {
          // Handle picture in picture
        } else if (value == 'download') {
          // Handle download
        }
      }
    });
  }
}
