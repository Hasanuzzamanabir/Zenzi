import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/core/widgets/text_label.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';

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
      dateController.text = DateFormat('MM/dd/yyyy').format(picked);
    });
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

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: SingleChildScrollView(
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
                  hintText: '13/09/1999',
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
                AppButton(
                  title: 'Edit',
                  onTap: () {
                    // Handle save profile
                  },
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
