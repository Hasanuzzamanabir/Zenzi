import 'dart:io';

class EditProfileModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String? avatarUrl; // remote URL from API response
  final File? avatarFile;  // local file when user picks a new image

  EditProfileModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    this.avatarUrl,
    this.avatarFile,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> map) {
    return EditProfileModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      dateOfBirth: map['date_of_birth'] ?? '',
      gender: map['gender'] ?? '',
      avatarUrl: map['avatar'] is String ? map['avatar'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'gender': gender.toUpperCase(),
    };
  }

  EditProfileModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? avatarUrl,
    File? avatarFile,
  }) {
    return EditProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarFile: avatarFile ?? this.avatarFile,
    );
  }
}
