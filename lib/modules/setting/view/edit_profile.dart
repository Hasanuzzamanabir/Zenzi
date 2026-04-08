import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zenzi/core/base_url/base_url.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/core/widgets/text_label.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/setting/controller/edit_profile_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  String selectedGender = 'Male';
  String? avatarUrl;

  final editProfileController = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateController.dispose();
  }

  Future<void> _selectValidityDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;

    setState(() {
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    });
  }

  String _formatDateForDisplay(String rawDate) {
    final normalized = rawDate.trim();
    if (normalized.isEmpty) return '';

    final formats = [
      DateFormat('yyyy-MM-dd'),
      DateFormat('yyyy/MM/dd'),
      DateFormat('dd/MM/yyyy'),
      DateFormat('MM/dd/yyyy'),
    ];

    for (final format in formats) {
      try {
        return DateFormat('dd/MM/yyyy').format(format.parseStrict(normalized));
      } catch (_) {
        continue;
      }
    }

    return normalized;
  }

  String _formatDateForApi(String rawDate) {
    final normalized = rawDate.trim();
    if (normalized.isEmpty) return normalized;

    final formats = [
      DateFormat('dd/MM/yyyy'),
      DateFormat('yyyy/MM/dd'),
      DateFormat('MM/dd/yyyy'),
      DateFormat('yyyy-MM-dd'),
    ];

    for (final format in formats) {
      try {
        return DateFormat('yyyy-MM-dd').format(format.parseStrict(normalized));
      } catch (_) {
        continue;
      }
    }

    return normalized;
  }

  Future<void> _loadProfile() async {
    final profile = await editProfileController.fetchProfile();
    if (profile == null || !mounted) return;

    setState(() {
      fullNameController.text = profile.name;
      emailController.text = profile.email;
      phoneController.text = profile.phoneNumber;
      dateController.text = _formatDateForDisplay(profile.dateOfBirth);
      selectedGender = _normalizeGender(profile.gender);
      avatarUrl = profile.avatarUrl;
    });
  }

  String _normalizeGender(String value) {
    if (value.isEmpty) return genderOptions.first;
    final normalized =
        value[0].toUpperCase() + value.substring(1).toLowerCase();
    if (genderOptions.contains(normalized)) {
      return normalized;
    }
    return genderOptions.first;
  }

  String? _resolveAvatarUrl(String? rawUrl) {
    if (rawUrl == null) return null;
    final trimmed = rawUrl.trim();
    if (trimmed.isEmpty) return null;

    final uri = Uri.tryParse(trimmed);
    if (uri != null && uri.hasScheme) {
      return trimmed;
    }

    final normalizedPath = trimmed.startsWith('/') ? trimmed : '/$trimmed';
    return '${BaseUrl.baseUrl}$normalizedPath';
  }

  XFile? pickedImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = image;
      });
    }
  }

  Future<void> _onSubmit() async {
    final success = await editProfileController.updateProfile(
      fullNameController.text.trim(),
      emailController.text.trim(),
      phoneController.text.trim(),
      _formatDateForApi(dateController.text),
      selectedGender,
      pickedImage == null ? null : File(pickedImage!.path),
    );

    if (!mounted) return;
    if (success) {
      // Let success snackbar render before leaving this page.
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted) return;
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final resolvedAvatarUrl = _resolveAvatarUrl(avatarUrl);

    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondarycolor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Edit Profile",
          style: AppTextStyle.h2.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => SafeArea(
          child: editProfileController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primarycolor,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),

                        //SizedBox(height: 24.h),

                        // Title
                        Text(
                          'Personal Information',
                          style: AppTextStyle.h2.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // Subtitle
                        Text(
                          'Provide your basics information',
                          style: AppTextStyle.h5.copyWith(
                            color: AppColors.secondarycolor,
                            fontSize: 13.sp,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Profile Image with Edit Icon
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 120.w,
                                height: 120.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF1976D2),
                                    width: 3,
                                  ),
                                ),
                                child: ClipOval(
                                  child: pickedImage != null
                                      ? Image.file(
                                          File(pickedImage!.path),
                                          fit: BoxFit.cover,
                                        )
                                      : (resolvedAvatarUrl != null)
                                      ? Image.network(
                                          resolvedAvatarUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Image.asset(
                                                  AppAssets.editprofile,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                          loadingBuilder:
                                              (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: SizedBox(
                                                    width: 24.w,
                                                    height: 24.w,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: AppColors
                                                              .primarycolor,
                                                        ),
                                                  ),
                                                );
                                              },
                                        )
                                      : Image.asset(
                                          AppAssets.editprofile,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 110,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1976D2),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                  onPressed: _pickImage,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40.h),

                        // Full Name Label
                        TextLabel(text: 'Full Name'),

                        SizedBox(height: 8.h),

                        // Full Name Field
                        AppTextField(
                          hintText: 'e.g. John Doe',
                          controller: fullNameController,
                        ),

                        SizedBox(height: 20.h),

                        // Email Label
                        TextLabel(text: 'Email'),

                        SizedBox(height: 8.h),

                        SizedBox(height: 8.h),

                        // Email Field
                        AppTextField(
                          hintText: 'e.g. John@gmail.com',
                          controller: emailController,
                          readOnly: true,
                          textColor: AppColors.backgroundcolor,
                          fillColor: AppColors.secondarycolor.withValues(
                            alpha: 0.55,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 20.h),

                        // Phone Number Label
                        TextLabel(text: 'Phone Number'),

                        SizedBox(height: 8.h),

                        // Phone Number Field
                        AppTextField(
                          hintText: 'e.g. +67647236425',
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 20.h),
                        TextLabel(text: 'Date of Birth'),

                        SizedBox(height: 8.h),

                        // Date of Birth Field
                        AppTextField(
                          hintText: 'dd/MM/yyyy',
                          controller: dateController,
                          readOnly: true,
                          onTap: () => _selectValidityDate(context),
                          suffixIcon: Icon(
                            Icons.calendar_today_sharp,
                            color: AppColors.darktext,
                          ),
                        ),

                        SizedBox(height: 20.h),
                        TextLabel(text: 'Gender'),

                        SizedBox(height: 8.h),

                        SizedBox(
                          width: 370.w,
                          height: 48.h,
                          child: DropdownButtonFormField<String>(
                            hint: Text(
                              'Select Gender',
                              style: TextStyle(
                                color: AppColors.backgroundcolor,
                                fontSize: 14.sp,
                              ),
                            ),

                            isExpanded: true,
                            dropdownColor: AppColors.secondarycolor,

                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.darktext,
                            ),
                            style: TextStyle(
                              color: AppColors.darktext,
                              fontSize: 14.sp,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.secondarycolor,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.secondarycolor,
                                  width: 1,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.secondarycolor,
                                  width: 1.2,
                                ),
                              ),
                            ),
                            items: genderOptions
                                .map(
                                  (gender) => DropdownMenuItem<String>(
                                    value: gender,
                                    child: Text(gender),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                        ),

                        //SizedBox(height: 20.h),
                        SizedBox(height: 40.h),

                        // Save Button
                        Obx(
                          () => AppButton(
                            title: 'Edit',
                            isLoading: editProfileController.isSubmitting.value,
                            onTap: editProfileController.isSubmitting.value
                                ? () {}
                                : () => _onSubmit(),
                          ),
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
