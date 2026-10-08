import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/modules//home//views/ar.dart';
import '../../../app/modules//home//views/bahasa_isyarat.dart';
import '../../../app/modules//home//controllers/quis/quis.dart';
import '../../../app/modules//home//views/video_hologram.dart';

class Course {
  final String title, description, iconSrc;
  final Color bgColor;
  final Function()? onTap;

  Course({
    required this.title,
    this.description = "Pembelajaran Bareng Teman dan Guru Bersama DeafsApp",
    this.iconSrc = "assets/icons/ios.svg",
    this.bgColor = const Color(0xFF7553F6),
    this.onTap,
  });
}

List<Course> courses = [
  Course(
    title: "Belajar Online Lebih Asyik",
    iconSrc: "assets/icons/code.svg",
    bgColor: const Color.fromARGB(255, 138, 24, 128),
    onTap: null,
  ),
  Course(
    title: "Mari Belajar Bersama",
    iconSrc: "assets/icons/code.svg",
    bgColor: const Color(0xFF80A4FF),
    onTap: null,
  ),
];

List<Course> recentCourses = [
  Course(
    title: "Mari Latihan Quis",
    bgColor: const Color.fromARGB(255, 59, 176, 176),
    iconSrc: "assets/icons/code.svg",
    onTap: () => Get.to(() => Quis()),
  ),
  Course(
      title: "Deteksi Bahasa Isyarat",
      bgColor: const Color.fromARGB(255, 37, 18, 181),
      iconSrc: "assets/icons/code.svg",
      onTap: () => Get.to(() => BahasaIsyarat())),
  Course(
    title: "Mengenal Hologram",
    bgColor: const Color.fromARGB(255, 247, 45, 116),
    iconSrc: "assets/icons/code.svg",
    onTap: () => Get.to(() => Hologram()),
  ),
  Course(
      title: "Mengenal Augmented Reality",
      bgColor: const Color.fromARGB(255, 166, 45, 247),
      iconSrc: "assets/icons/code.svg",
      onTap: () => Get.to(() => AR())),
];
