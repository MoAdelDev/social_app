import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../controller/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        int currentIndex = state.currentIndex;
        return Scaffold(
          extendBody: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    title: Text(
                      'Image source',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    content: Text(
                      'Please choose image source',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => context.read<HomeBloc>().add(
                              HomePickImageFromCameraOrGallery(
                                true,
                                context,
                              ),
                            ),
                        child: Text(
                          'Camera',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.read<HomeBloc>().add(
                              HomePickImageFromCameraOrGallery(
                                false,
                                context,
                              ),
                            ),
                        child: Text(
                          'Gallery',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    ],
                  );
                },
              );
            },
            isExtended: true,
            disabledElevation: 0,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.primary,
            child: SvgPicture.asset('assets/icons/add.svg'),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 0.0,
            height: 60.0,
            notchMargin: 10.0,
            shape: const CircularNotchedRectangle(),
            color: const Color(0xff5790DF).withOpacity(0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () => context
                      .read<HomeBloc>()
                      .add(HomeChangeBottomNavIndexEvent(0)),
                  splashColor: Theme.of(context).colorScheme.secondary,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        state.currentIndex == 0 ? Iconsax.home5 : Iconsax.home,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      if (state.currentIndex == 0)
                        SvgPicture.asset('assets/icons/rectangle.svg')
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => context
                      .read<HomeBloc>()
                      .add(HomeChangeBottomNavIndexEvent(1)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        state.currentIndex == 1
                            ? CupertinoIcons.chat_bubble_2_fill
                            : CupertinoIcons.chat_bubble_2,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      if (state.currentIndex == 1)
                        SvgPicture.asset('assets/icons/rectangle.svg')
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => context
                      .read<HomeBloc>()
                      .add(HomeChangeBottomNavIndexEvent(2)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        state.currentIndex == 2
                            ? CupertinoIcons.person_fill
                            : CupertinoIcons.person,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      if (state.currentIndex == 2)
                        SvgPicture.asset('assets/icons/rectangle.svg')
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => context
                      .read<HomeBloc>()
                      .add(HomeChangeBottomNavIndexEvent(3)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        state.currentIndex == 3
                            ? Icons.settings
                            : Iconsax.setting_2,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      if (state.currentIndex == 3)
                        SvgPicture.asset('assets/icons/rectangle.svg')
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: state.screens[currentIndex],
        );
      },
    );
  }
}
