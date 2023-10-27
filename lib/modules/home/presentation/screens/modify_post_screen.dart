import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/core/components/default_app_bar_icon.dart';
import 'package:social_app/core/components/default_progress_indicator.dart';
import 'package:social_app/core/components/default_shimmer.dart';
import 'package:social_app/core/router/screen_arguments.dart';
import 'package:social_app/core/style/fonts.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/main.dart';
import 'package:social_app/modules/home/presentation/controller/home/home_bloc.dart';
import 'package:social_app/modules/home/presentation/controller/modify_post/modify_post_bloc.dart';
import '../../../../generated/l10n.dart';
import '../widgets/image_picker_dialog.dart';

class ModifyPostScreen extends StatefulWidget {
  final ScreenArguments args;

  const ModifyPostScreen({
    super.key,
    required this.args,
  });

  @override
  State<ModifyPostScreen> createState() => _ModifyPostScreenState();
}

class _ModifyPostScreenState extends State<ModifyPostScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.args.post.captionText;
    BlocProvider.of<ModifyPostBloc>(context)
        .add(const ModifyPostRemoveImagePickedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModifyPostBloc, ModifyPostState>(
      listener: (context, state) {
        if (state.modifyPostState == RequestState.success) {
          BlocProvider.of<HomeBloc>(context).add(const HomeLoadPostsEvent());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultAppBarIcon(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ConditionalBuilder(
                        condition:
                            state.modifyPostState != RequestState.loading,
                        builder: (context) {
                          return DefaultAppBarIcon(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              context.read<ModifyPostBloc>().add(
                                    ModifyPostEvent(
                                      widget.args.post.id,
                                      controller.text,
                                    ),
                                  );
                            },
                            child: SvgPicture.asset(
                              MyApp.isDark
                                  ? 'assets/icons/light/edit.svg'
                                  : 'assets/icons/dark/edit.svg',
                              width: 25,
                              height: 25,
                            ),
                          );
                        },
                        fallback: (context) => const Center(
                          child: DefaultProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const ImagePickerDialog(
                                  isModify: true,
                                );
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(35),
                          splashColor: Colors.grey,
                          radius: 35,
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(30.0),
                            child: state.imagePicked?.path != ''
                                ? Image.file(
                                    state.imagePicked ?? File(''),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            DefaultShimmer(
                                      child: Container(),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: widget.args.post.image,
                                    height: 100,
                                    width: 100,
                                    placeholder: (context, url) =>
                                        DefaultShimmer(child: Container()),
                                    errorWidget: (context, url, error) =>
                                        DefaultShimmer(
                                      child: Container(),
                                    ),
                                    imageBuilder: (context, imageProvider) {
                                      return Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20.0,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff000000)
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            ),
                                            child: Text(
                                              S.of(context).modifyTitle,
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white,
                                                fontFamily: AppFonts.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: S.of(context).writeCaptionTitle,
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
