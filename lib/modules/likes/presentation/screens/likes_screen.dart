import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/default_scroll_physics.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/presentation/widgets/bottom_sheet_divider.dart';
import 'package:social_app/modules/likes/presentation/widgets/likes_item_widget.dart';
import 'package:social_app/modules/likes/presentation/widgets/likes_loading_widget.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../controller/likes/likes_bloc.dart';

class LikesScreen extends StatelessWidget {
  final Post post;

  const LikesScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikesBloc(sl())..add(LikesGetUsersEvent(post.id)),
      child: BlocBuilder<LikesBloc, LikesState>(
        builder: (context, state) {
          if(state.likesState == RequestState.loading){
            return const LikesLoadingWidget();
          }
          else if (state.users.isEmpty) {
            return Center(
              child: Text(
                S.of(context).noLikesTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            );
          }
          return Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              const BottomSheetDivider(),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    User user = state.users[index];
                    return LikesItemWidget(
                      user: user,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
                  itemCount: state.users.length,
                  physics: DefaultScrollPhysics.bouncing(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
