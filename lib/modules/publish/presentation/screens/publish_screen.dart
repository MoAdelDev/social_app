import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/core/components/default_app_bar_icon.dart';
import 'package:social_app/core/components/default_progress_indicator.dart';
import 'package:social_app/core/router/screen_arguments.dart';
import 'package:social_app/core/services/service_locator.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/modules/publish/presentation/controller/publish_bloc.dart';

class PublishScreen extends StatelessWidget {
  final ScreenArguments args;
  final TextEditingController controller = TextEditingController();

  PublishScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PublishBloc(sl()),
      child: BlocBuilder<PublishBloc, PublishState>(
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
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                        ConditionalBuilder(
                          condition: state.publishState != RequestState.loading,
                          builder: (context) {
                            return DefaultAppBarIcon(
                              onPressed: () {
                                context.read<PublishBloc>().add(PublishEvent(args.imageFile, controller.text, context));
                              },
                              child: SvgPicture.asset(
                                'assets/icons/publish.svg',
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
                          horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(30.0),
                              child: Image.file(
                                args.imageFile,
                                fit: BoxFit.cover,
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
                                    hintText: 'Write a caption ...',
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
      ),
    );
  }
}
