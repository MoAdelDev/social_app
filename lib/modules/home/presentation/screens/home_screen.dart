import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/modules/home/presentation/widgets/image_picker_dialog.dart';
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
                  return const ImagePickerDialog(
                    isModify: false,
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
                      SvgPicture.asset(
                        state.currentIndex == 0
                            ? 'assets/icons/home_filled.svg'
                            : 'assets/icons/home.svg',
                        width: 27.0,
                        height: 27.0,
                      ),
                      if (state.currentIndex == 0)
                        Column(
                          children: [
                            const SizedBox(
                              height: 3.0,
                            ),
                            SvgPicture.asset('assets/icons/rectangle.svg'),
                          ],
                        )
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
                      SvgPicture.asset(
                        state.currentIndex == 1
                            ? 'assets/icons/messages_filled.svg'
                            : 'assets/icons/messages.svg',
                        width: 27.0,
                        height: 27.0,
                      ),
                      if (state.currentIndex == 1)
                        Column(
                          children: [
                            const SizedBox(
                              height: 3.0,
                            ),
                            SvgPicture.asset('assets/icons/rectangle.svg'),
                          ],
                        )
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
                      SvgPicture.asset(
                        state.currentIndex == 2
                            ? 'assets/icons/person_filled.svg'
                            : 'assets/icons/person.svg',
                        width: 27.0,
                        height: 27.0,
                      ),
                      if (state.currentIndex == 2)
                        Column(
                          children: [
                            const SizedBox(
                              height: 3.0,
                            ),
                            SvgPicture.asset('assets/icons/rectangle.svg'),
                          ],
                        )
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
                      SvgPicture.asset(
                        state.currentIndex == 3
                            ? 'assets/icons/settings_filled.svg'
                            : 'assets/icons/settings.svg',
                        width: 27.0,
                        height: 27.0,
                      ),
                      if (state.currentIndex == 3)
                        Column(
                          children: [
                            const SizedBox(
                              height: 3.0,
                            ),
                            SvgPicture.asset('assets/icons/rectangle.svg'),
                          ],
                        )
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
