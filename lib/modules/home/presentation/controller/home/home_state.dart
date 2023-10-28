part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int currentIndex;
  final List<Widget> screens;
  final File? imagePicked;

  final user_entity.User? user;
  final RequestState userState;
  final String userError;

  final RequestState publishState;
  final String publishError;

  final List<Post> posts;
  final RequestState postsState;
  final String postsError;
  final bool isLoading;

  final RequestState likeState;
  final String likeError;
  final Map<String, bool> isLikedMap;

  final RequestState saveState;
  final String saveError;
  final Map<String, bool> savedPosts;

  final Map<String, user_entity.User> postsUsers;
  final Map<String, int> postsLikes;
  final Map<String, int> postsComments;

  final String deletePostError;
  final RequestState deletePostState;

  const HomeState({
    this.currentIndex = 0,
    this.imagePicked,
    this.screens = const [
      PostsScreen(),
      MessagesScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ],
    this.user,
    this.userState = RequestState.nothing,
    this.userError = '',
    this.publishState = RequestState.nothing,
    this.publishError = '',
    this.posts = const [],
    this.postsState = RequestState.loading,
    this.postsError = '',
    this.postsUsers = const {},
    this.isLoading = false,
    this.likeState = RequestState.nothing,
    this.likeError = '',
    this.isLikedMap = const {},
    this.postsLikes = const {},
    this.postsComments = const {},
    this.deletePostState = RequestState.nothing,
    this.deletePostError = '',
    this.savedPosts = const {},
    this.saveState = RequestState.nothing,
    this.saveError = '',
  });

  HomeState copyWith({
    int? currentIndex,
    List<Widget>? screens,
    File? imagePicked,
    user_entity.User? user,
    String? userError,
    RequestState? userState,
    RequestState? publishState,
    String? publishError,
    List<Post>? posts,
    RequestState? postsState,
    String? postsError,
    Map<String, user_entity.User>? postsUsers,
    bool? isLoading,
    RequestState? likeState,
    String? likeError,
    Map<String, bool>? isLikedMap,
    Map<String, int>? postsLikes,
    Map<String, int>? postsComments,
    String? deletePostError,
    RequestState? deletePostState,
    Map<String, bool>? savedPosts,
    String? saveError,
    RequestState? saveState,
  }) =>
      HomeState(
        currentIndex: currentIndex ?? this.currentIndex,
        screens: screens ?? this.screens,
        imagePicked: imagePicked ?? this.imagePicked,
        userError: userError ?? this.userError,
        userState: userState ?? this.userState,
        user: user ?? this.user,
        posts: posts ?? this.posts,
        postsState: postsState ?? this.postsState,
        postsError: postsError ?? this.postsError,
        postsUsers: postsUsers ?? this.postsUsers,
        publishState: publishState ?? this.publishState,
        publishError: publishError ?? this.publishError,
        isLoading: isLoading ?? this.isLoading,
        likeState: likeState ?? this.likeState,
        likeError: likeError ?? this.likeError,
        isLikedMap: isLikedMap ?? this.isLikedMap,
        postsLikes: postsLikes ?? this.postsLikes,
        postsComments: postsComments ?? this.postsComments,
        deletePostError: deletePostError ?? this.deletePostError,
        deletePostState: deletePostState ?? this.deletePostState,
        savedPosts: savedPosts ?? this.savedPosts,
        saveError: saveError ?? this.saveError,
        saveState: deletePostState ?? this.saveState,
      );

  @override
  List<Object?> get props => [
        currentIndex,
        screens,
        imagePicked,
        user,
        userState,
        userError,
        publishState,
        publishError,
        posts,
        postsState,
        postsError,
        isLoading,
        likeState,
        likeError,
        isLikedMap,
        saveState,
        saveError,
        savedPosts,
        postsUsers,
        postsLikes,
        postsComments,
        deletePostError,
        deletePostState,
      ];
}
