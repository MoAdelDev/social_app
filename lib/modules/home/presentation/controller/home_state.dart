part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int currentIndex;
  final List<Widget> screens;
  final File? imagePicked;

  final RequestState publishState;
  final String publishError;

  final List<Post> posts;
  final RequestState postsState;
  final String postsError;

  final Map<String, user_entity.User> postsUsers;

  const HomeState({
    this.currentIndex = 0,
    this.imagePicked,
    this.screens = const [
      PostsScreen(),
      MessagesScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ],
    this.publishState = RequestState.nothing,
    this.publishError = '',
    this.posts = const [],
    this.postsState = RequestState.loading,
    this.postsError = '',
    this.postsUsers = const {},
  });

  HomeState copyWith({
    int? currentIndex,
    List<Widget>? screens,
    File? imagePicked,
    RequestState? publishState,
    String? publishError,
    List<Post>? posts,
    RequestState? postsState,
    String? postsError,
    Map<String, user_entity.User>? postsUsers,
  }) =>
      HomeState(
        currentIndex: currentIndex ?? this.currentIndex,
        screens: screens ?? this.screens,
        imagePicked: imagePicked ?? this.imagePicked,
        posts: posts ?? this.posts,
        postsState: postsState ?? this.postsState,
        postsError: postsError ?? this.postsError,
        postsUsers: postsUsers ?? this.postsUsers,
        publishState: publishState ?? this.publishState,
        publishError: publishError ?? this.publishError,
      );

  @override
  List<Object?> get props =>
      [
        currentIndex,
        screens,
        imagePicked,
        publishState,
        publishError,
        posts,
        postsState,
        postsError,
        postsUsers,
      ];
}
