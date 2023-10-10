import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/modules/home/presentation/screens/explore_screen.dart';

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
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Explore', style: TextStyle(color: Colors.black),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
        color:  const Color(0xff5790DF).withOpacity(0.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: (){},
              splashColor: Theme.of(context).colorScheme.secondary,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/home.svg'),
                  SvgPicture.asset('assets/icons/rectangle.svg')
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/icons/message.svg'),
                SvgPicture.asset('assets/icons/rectangle.svg')
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/icons/person.svg'),
                SvgPicture.asset('assets/icons/rectangle.svg')
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/icons/notifications.svg'),
                SvgPicture.asset('assets/icons/rectangle.svg')
              ],
            ),
          ],
        ),
      ),
      body: const ExploreScreen(),
    );
  }
}
