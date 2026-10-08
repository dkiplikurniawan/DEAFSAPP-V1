import 'package:dul/app/modules/BellScreen/views/bell_screen_view.dart';
import 'package:dul/app/modules/ChatScreen/views/chat_screen_view.dart';
import 'package:dul/app/modules/Profile/views/profile_view.dart';
import 'package:dul/app/modules/Search/views/search_view.dart';
import 'package:dul/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:dul/app/data/constants.dart';


import 'app/data/components/animated_bar.dart';
import 'package:dul/app/data/models/rive_asset.dart';
import 'package:dul/app/data/utils/rive_utils.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final _selectedIndex = 0.obs;

  final List<Widget> _screens = [
    const HomeView(),
    const SearchView(),
    const ChatScreenView(),
    BellScreenView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: _screens.elementAt(_selectedIndex.value),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    _onItemTapped(index);
                    bottomNavs[index].input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      bottomNavs[index].input!.change(false);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ignore: unrelated_type_equality_checks
                      AnimatedBar(isActive: _selectedIndex == index),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          // ignore: unrelated_type_equality_checks
                          opacity: _selectedIndex == index ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomNavs.first.src,
                            artboard: bottomNavs[index].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(artboard,
                                      stateMachineName:
                                          bottomNavs[index].stateMachineName);

                              bottomNavs[index].input =
                                  controller.findSMI("active") as SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
