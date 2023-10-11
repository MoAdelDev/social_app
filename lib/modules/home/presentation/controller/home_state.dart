part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int currentIndex;
  final List<Widget> screens;

  const HomeState({
    this.currentIndex = 0,
    this.screens = const [
      ExploreScreen(),
      MessagesScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ],
  });

  HomeState copyWith({int? currentIndex, List<Widget>? screens}) =>
      HomeState(
        currentIndex: currentIndex ?? this.currentIndex,
        screens: screens ?? this.screens,
      );

  @override
  List<Object> get props => [currentIndex, screens];
}
