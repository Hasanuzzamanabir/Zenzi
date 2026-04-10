// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/meditation_view/controller/meditations_like_controller.dart';
import 'package:zenzi/modules/meditation_view/model/meditations_details_model.dart';

class MeditationDetails extends StatefulWidget {
  const MeditationDetails({super.key});

  @override
  State<MeditationDetails> createState() => _MeditationDetailsState();
}

class _MeditationDetailsState extends State<MeditationDetails> {
  final ApiServices _apiServices = ApiServices();

  VideoPlayerController? _controller;
  MeditationDetailsModel? _details;
  int? _meditationId;
  int _likesCount = 0;
  bool _isDetailsLoading = true;
  bool _isVideoLoading = false;
  bool _hasVideoError = false;
  bool _isLikeLoading = false;
  bool _showVideoControls = false;
  String? detailsError;

  @override
  void initState() {
    super.initState();
    _meditationId = _resolveMeditationId(Get.arguments);
    _loadMeditationDetails();
  }

  int? _resolveMeditationId(dynamic arguments) {
    if (arguments is int) {
      return arguments;
    }

    if (arguments is String) {
      return int.tryParse(arguments);
    }

    if (arguments is Map<String, dynamic>) {
      final dynamic value = arguments['id'];
      if (value is int) {
        return value;
      }
      if (value is String) {
        return int.tryParse(value);
      }
    }

    return null;
  }

  Future<void> _loadMeditationDetails() async {
    if (mounted) {
      setState(() {
        _isDetailsLoading = true;
        detailsError = null;
      });
    }

    try {
      final int? meditationId = _meditationId;

      if (meditationId == null) {
        _details = MeditationDetailsModel.fallback();
      } else {
        final response = await _apiServices.get(
          '/api/v1/content/meditations/$meditationId/',
          requireAuth: true,
        );

        if (response.statusCode == 200 && response.data['success'] == true) {
          final Map<String, dynamic> data =
              response.data['data'] as Map<String, dynamic>? ??
              <String, dynamic>{};
          _details = MeditationDetailsModel.fromJson(data);
          _likesCount = _details?.likesCount ?? 0;
        } else {
          throw Exception('Unexpected meditation detail response');
        }
      }

      await _initializeVideo(
        _details?.mediaFile.isNotEmpty == true
            ? _details!.mediaFile
            : 'https://vjs.zencdn.net/v/oceans.mp4',
      );
    } catch (error) {
      debugPrint('Error loading meditation details: $error');
      detailsError = 'Unable to load meditation details';
      _details = MeditationDetailsModel.fallback();
      await _initializeVideo(_details!.mediaFile);
    } finally {
      if (mounted) {
        setState(() {
          _isDetailsLoading = false;
        });
      }
    }
  }

  Future<void> _refreshLikeDetails() async {
    final int? meditationId = _meditationId;
    if (meditationId == null) {
      return;
    }

    try {
      final response = await _apiServices.get(
        '/api/v1/content/meditations/$meditationId/',
        requireAuth: true,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final Map<String, dynamic> data =
            response.data['data'] as Map<String, dynamic>? ??
            <String, dynamic>{};

        if (mounted) {
          setState(() {
            _details = MeditationDetailsModel.fromJson(data);
            _likesCount = _details?.likesCount ?? 0;
          });
        }
      }
    } catch (error) {
      debugPrint('Error refreshing like details: $error');
    }
  }

  Future<void> _initializeVideo(String videoUrl) async {
    final String safeVideoUrl = videoUrl.trim().isEmpty
        ? 'https://vjs.zencdn.net/v/oceans.mp4'
        : videoUrl;

    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    _controller = null;

    if (mounted) {
      setState(() {
        _isVideoLoading = true;
        _hasVideoError = false;
      });
    }

    final controller = VideoPlayerController.networkUrl(
      Uri.parse(safeVideoUrl),
    );
    _controller = controller;

    try {
      await controller.initialize();
      await controller.setLooping(true);

      if (mounted) {
        controller.addListener(_videoListener);
        await controller.play();
        setState(() {
          _isVideoLoading = false;
        });
      }
    } catch (error) {
      debugPrint('Video initialization failed: $error');
      if (mounted) {
        setState(() {
          _isVideoLoading = false;
          _hasVideoError = true;
        });
      }
    }
  }

  void _videoListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _toggleVideoControls() {
    if (mounted) {
      setState(() {
        _showVideoControls = !_showVideoControls;
      });
      if (_showVideoControls) {
        _autoHideControls();
      }
    }
  }

  void _autoHideControls() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _showVideoControls) {
        setState(() {
          _showVideoControls = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> _shareMeditationVideo(MeditationDetailsModel details) async {
    final String videoUrl = details.mediaFile.trim();
    if (videoUrl.isEmpty || Uri.tryParse(videoUrl)?.hasAbsolutePath != true) {
      Get.snackbar('Share', 'Video link is not available');
      return;
    }

    await SharePlus.instance.share(
      ShareParams(text: 'Watch this meditation video: $videoUrl'),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isDetailsLoading && _details == null) {
      return const ThemedScaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final MeditationDetailsModel details =
        _details ?? MeditationDetailsModel.fallback();

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
              _buildIconsRow(details),

              SizedBox(height: 20.h),

              // Title and Duration
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Duration : ${details.durationLabel}',
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
                      details.description,
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
                child: _buildBenefitsCard(details),
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
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.secondarycolor,
              size: 24.sp,
            ),
          ),
          Spacer(),

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
    final VideoPlayerController? controller = _controller;
    final bool isInitialized = controller?.value.isInitialized ?? false;
    final Duration currentPosition =
        controller?.value.position ?? Duration.zero;
    final Duration totalDuration = controller?.value.duration ?? Duration.zero;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            height: 260.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                children: [
                  if (isInitialized)
                    GestureDetector(
                      onTap: _toggleVideoControls,
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: controller!.value.size.width,
                            height: controller.value.size.height,
                            child: VideoPlayer(controller),
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      color: Colors.black38,
                      child: Center(
                        child: _hasVideoError
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
                                    'Failed to load video',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  TextButton(
                                    onPressed: () {
                                      final details =
                                          _details ??
                                          MeditationDetailsModel.fallback();
                                      _initializeVideo(details.mediaFile);
                                    },
                                    child: Text(
                                      'Retry',
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
                                  const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    _isVideoLoading
                                        ? 'Loading Video...'
                                        : 'Preparing Video...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  if (_showVideoControls && isInitialized)
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final VideoPlayerController? controller =
                                  _controller;
                              if (controller == null) {
                                return;
                              }
                              controller.seekTo(
                                controller.value.position -
                                    const Duration(seconds: 10),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.replay_10,
                                color: Colors.white,
                                size: 32.sp,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final VideoPlayerController? controller =
                                  _controller;
                              if (controller == null) {
                                return;
                              }
                              controller.value.isPlaying
                                  ? controller.pause()
                                  : controller.play();
                            },
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColors.primarycolor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _controller?.value.isPlaying == true
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 40.sp,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final VideoPlayerController? controller =
                                  _controller;
                              if (controller == null) {
                                return;
                              }
                              controller.seekTo(
                                controller.value.position +
                                    const Duration(seconds: 10),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.forward_10,
                                color: Colors.white,
                                size: 32.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_showVideoControls && isInitialized)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black54],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.h,
                          ),
                          child: Column(
                            children: [
                              SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 3.h,
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 6.w,
                                    elevation: 0,
                                  ),
                                  overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 8.w,
                                  ),
                                ),
                                child: Slider(
                                  value:
                                      isInitialized &&
                                          totalDuration.inMilliseconds > 0
                                      ? currentPosition.inMilliseconds
                                                .toDouble() /
                                            totalDuration.inMilliseconds
                                                .toDouble()
                                      : 0.0,
                                  onChanged: (double value) {
                                    if (controller != null) {
                                      final Duration newPosition = Duration(
                                        milliseconds:
                                            (value *
                                                    totalDuration
                                                        .inMilliseconds)
                                                .toInt(),
                                      );
                                      controller.seekTo(newPosition);
                                    }
                                  },
                                  min: 0.0,
                                  max: 1.0,
                                  activeColor: AppColors.primarycolor,
                                  inactiveColor: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(currentPosition),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text(
                                      _formatDuration(totalDuration),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconsRow(MeditationDetailsModel details) {
    final controller = Get.put(MeditationsLikeController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: _isLikeLoading || _meditationId == null
                    ? null
                    : () async {
                        setState(() {
                          _isLikeLoading = true;
                        });

                        await controller.handleLikeTap(
                          meditationId: _meditationId.toString(),
                          reloadDetails: _refreshLikeDetails,
                        );

                        if (mounted) {
                          setState(() {
                            _isLikeLoading = false;
                          });
                        }
                      },
                icon: Icon(
                  details.isLikedByUser
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Color(0xFFFF6B6B),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                _likesCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          const Spacer(),
          GestureDetector(
            onTap: () => _shareMeditationVideo(details),
            child: Row(
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
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsCard(MeditationDetailsModel details) {
    final List<String> benefits = details.benefits.isNotEmpty
        ? details.benefits
        : MeditationDetailsModel.fallback().benefits;

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
          ..._buildBenefitItems(benefits),
        ],
      ),
    );
  }

  List<Widget> _buildBenefitItems(List<String> benefits) {
    if (benefits.isEmpty) {
      return <Widget>[_buildBenefitItem('No benefits available yet')];
    }

    final List<Widget> items = <Widget>[];
    for (int index = 0; index < benefits.length; index++) {
      items.add(_buildBenefitItem(benefits[index]));
      if (index != benefits.length - 1) {
        items.add(SizedBox(height: 12.h));
      }
    }
    return items;
  }

  Widget _buildBenefitItem(String text) {
    return Row(
      children: [
        Image.asset(AppAssets.mark, width: 18.w, height: 18.w),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: AppColors.secondarycolor, fontSize: 14.sp),
          ),
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

  // void _showVideoOptionsMenu(BuildContext context) {
  //   showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(1000, 100, 20, 0),
  //     color: Color(0xFFB88A5C),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  //     items: [
  //       PopupMenuItem(
  //         value: 'pip',
  //         child: Text(
  //           'picture in picture',
  //           style: TextStyle(color: Colors.white, fontSize: 14.sp),
  //         ),
  //       ),
  //       PopupMenuItem(
  //         value: 'download',
  //         child: Text(
  //           'Download',
  //           style: TextStyle(color: Colors.white, fontSize: 14.sp),
  //         ),
  //       ),
  //     ],
  //   ).then((value) {
  //     if (value != null) {
  //       // Handle menu item selection
  //       if (value == 'pip') {
  //         // Handle picture in picture
  //       } else if (value == 'download') {
  //         // Handle download
  //       }
  //     }
  //   });
  // }
}
