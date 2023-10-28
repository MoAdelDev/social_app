// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get forgotPasswordQuestion {
    return Intl.message(
      'Forgot Password ?',
      name: 'forgotPasswordQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Aren't you have an account?`
  String get registerQuestion {
    return Intl.message(
      'Aren\'t you have an account?',
      name: 'registerQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameLabel {
    return Intl.message(
      'Name',
      name: 'nameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phoneLabel {
    return Intl.message(
      'Phone',
      name: 'phoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email Address`
  String get emailInputError {
    return Intl.message(
      'Enter Email Address',
      name: 'emailInputError',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get passwordInputError {
    return Intl.message(
      'Enter Password',
      name: 'passwordInputError',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name`
  String get nameInputError {
    return Intl.message(
      'Enter Name',
      name: 'nameInputError',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone`
  String get phoneInputError {
    return Intl.message(
      'Enter Phone',
      name: 'phoneInputError',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `The post has been published successfully`
  String get postSuccessMsg {
    return Intl.message(
      'The post has been published successfully',
      name: 'postSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `You have been logged in successfully`
  String get loginSuccessMsg {
    return Intl.message(
      'You have been logged in successfully',
      name: 'loginSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `The post delete successfully`
  String get deletePostSuccessMsg {
    return Intl.message(
      'The post delete successfully',
      name: 'deletePostSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete the post. Try again`
  String get deletePostErrorMsg {
    return Intl.message(
      'Failed to delete the post. Try again',
      name: 'deletePostErrorMsg',
      desc: '',
      args: [],
    );
  }

  /// `Delete Post`
  String get deletePostTitle {
    return Intl.message(
      'Delete Post',
      name: 'deletePostTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit Post`
  String get editPostTitle {
    return Intl.message(
      'Edit Post',
      name: 'editPostTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to permanently remove this post ?`
  String get deletePostMsg {
    return Intl.message(
      'Are you want to permanently remove this post ?',
      name: 'deletePostMsg',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelTitle {
    return Intl.message(
      'Cancel',
      name: 'cancelTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteTitle {
    return Intl.message(
      'Delete',
      name: 'deleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get modifyTitle {
    return Intl.message(
      'Modify',
      name: 'modifyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Write a caption ...`
  String get writeCaptionTitle {
    return Intl.message(
      'Write a caption ...',
      name: 'writeCaptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment for `
  String get addCommentHintText {
    return Intl.message(
      'Add a comment for ',
      name: 'addCommentHintText',
      desc: '',
      args: [],
    );
  }

  /// `Please add comment`
  String get addCommentWarningText {
    return Intl.message(
      'Please add comment',
      name: 'addCommentWarningText',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get cameraTitle {
    return Intl.message(
      'Camera',
      name: 'cameraTitle',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get galleryTitle {
    return Intl.message(
      'Gallery',
      name: 'galleryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Image source`
  String get imageSourceTitle {
    return Intl.message(
      'Image source',
      name: 'imageSourceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please choose image source`
  String get imageSourceMsg {
    return Intl.message(
      'Please choose image source',
      name: 'imageSourceMsg',
      desc: '',
      args: [],
    );
  }

  /// `No Comments Yet`
  String get noCommentsMsg {
    return Intl.message(
      'No Comments Yet',
      name: 'noCommentsMsg',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
