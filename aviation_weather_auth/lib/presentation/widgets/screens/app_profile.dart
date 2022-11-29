import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../data/constants.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../cubit/navigation_bar_cubit.dart';
import '../../shared/app_navigator.dart';
import '../../shared/app_popup.dart';
import '../../shared/app_snackbar.dart';
import '../../shared/widgets.dart';
import '../user/app_user_header.dart';

class AppProfile extends StatelessWidget with AppColors, AppGaps {
  AppProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;
    return BaseAppLayout(
      imagePath: 'assets/images/profile.pdf',
      maxHeightHeaderPercent: 0.2,
      headerChild: AppUserHeader(),
      children: <Widget>[
        AppGap(medium, direction: AppGapDirection.vertical),
        AppProfileItem('premium.svg', localization.premiumAccess, onTap: () {}),
        if (user != null)
          AppProfileItem(
            'edit.svg',
            localization.editProfile,
            onTap: () => AppNavigator.toNamed(context, '/edit-profile'),
          ),
        if (user != null)
          AppProfileItem('favorite.svg', localization.favoriteStations,
              onTap: () {}),
        BlocConsumer<ProfileBloc, ProfileState>(
          listener: _onListenFeedback,
          builder: _onBuildFeedback,
        ),
        AppProfileItem('settings.svg', localization.widgetSettings,
            onTap: () {}),
        AppProfileItem(
          'terms.svg',
          localization.termsOfUsage,
          onTap: () {},
        ),
        AppProfileItem(
          'policy.svg',
          localization.privacyPolicy,
          onTap: () {},
        ),
        AppProfileItem('rate.svg', localization.rateTheApp, onTap: () async {
          if (await InAppReview.instance.isAvailable()) {
            await InAppReview.instance.requestReview();
          }
        }),
        if (user == null)
          AppProfileItem(
            'login.svg',
            localization.login,
            onTap: () => AppNavigator.toNamed(context, '/login'),
          )
        else
          BlocConsumer<AuthBloc, AuthState>(
            listener: _onListenLogout,
            builder: _onBuildLogout,
          ),
      ],
    );
  }

  void _onListenLogout(BuildContext context, AuthState state) {
    if (state is UserAuthFailed) {
      showSnackBar(
        context,
        state.message,
        SnackbarState.error,
      );
    } else if (state is UserAuthSignedUp) {
      context.read<NavigationBarCubit>().navigateTo('Explore', 0);
    }
  }

  void _onLogout(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    showPopup(
      context,
      title: AppText(localizations.logout),
      content: AppText(localizations.wantLogout),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            AppNavigator.pop(context);
            final AuthBloc userAuthBloc = context.read<AuthBloc>();
            userAuthBloc.add(UserSignOut(userAuthBloc.auth));
          },
          child: AppText(localizations.yes),
        ),
        TextButton(
          onPressed: () {
            AppNavigator.pop(context);
          },
          child: AppText(localizations.no),
        ),
      ],
    );
  }

  Widget _onBuildLogout(BuildContext context, AuthState state) {
    return AppProfileItem(
      'logout.svg',
      AppLocalizations.of(context)!.logout,
      onTap: state is UserAuthLoading ? () {} : () => _onLogout(context),
    );
  }

  void _onListenFeedback(BuildContext context, ProfileState state) {
    if (state is EmailSendingCancelled) {
      showSnackBar(
        context,
        'Email sent failed',
        SnackbarState.error,
      );
    }
  }

  Widget _onBuildFeedback(BuildContext context, ProfileState state) {
    return AppProfileItem(
      'feedback.svg',
      AppLocalizations.of(context)!.feedback,
      onTap: () {
        context.read<ProfileBloc>().add(const SendEmail());
      },
    );
  }
}
