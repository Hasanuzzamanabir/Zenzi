// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_textfield.dart';
import '../../../core/widgets/themed_scaffold.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSend() {
    // Handle send logic here
    final name = _nameController.text;
    final email = _emailController.text;
    final description = _descriptionController.text;

    if (name.isEmpty || email.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Message sent successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primarytext),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Help & Support',
          style: TextStyle(
            color: AppColors.primarytext,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: TextStyle(
                  color: AppColors.primarytext,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              AppTextField(
                hintText: 'e.g. John Doe',
                controller: _nameController,
              ),
              SizedBox(height: 20.h),
              Text(
                'Email',
                style: TextStyle(
                  color: AppColors.primarytext,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              AppTextField(
                hintText: 'e.g. John@gmail.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              Text(
                'Description',
                style: TextStyle(
                  color: AppColors.primarytext,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: double.maxFinite,
                height: 180.h,
                decoration: BoxDecoration(
                  color: AppColors.secondarycolor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(color: AppColors.darktext, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Write your description here...',
                    hintStyle: TextStyle(fontSize: 14.sp),
                    filled: false,
                    contentPadding: EdgeInsets.all(16.w),
                    //border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              AppButton(title: 'Send', onTap: _handleSend),
            ],
          ),
        ),
      ),
    );
  }
}
