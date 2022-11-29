import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/constants.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../controllers/user_auth_controllers.dart';
import '../../shared/app_navigator.dart';
import '../../shared/app_snackbar.dart';
import '../../shared/widgets.dart';

class AppAuthorize extends StatelessWidget
    with AppColors, AppGaps, UserAuthControllers {
  AppAuthorize(this._authType, {super.key});

  final AuthType _authType;

  @override
  Widget build(BuildContext context) {
    final AuthBloc userAuthBloc = context.read<AuthBloc>();
    final AppLocalizations localization = AppLocalizations.of(context)!;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is UserAuthFailed) {
          showSnackBar(context, state.message, SnackbarState.error);
        }
        if (state is UserAuthLoaded) {
          showSnackBar(
            context,
            'Logged in\nemail: ${state.user.email!}',
            SnackbarState.success,
          );
          AppNavigator.pop(context, true);
        }
      },
      builder: (BuildContext context, AuthState state) {
        return BaseAppLayout(
          imagePath: 'assets/images/profile.pdf',
          children: <Widget>[
            AppGap(medium, direction: AppGapDirection.vertical),
            AppText(
              _authType == AuthType.signIn
                  ? localization.login
                  : localization.signUp,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: primaryColor,
            ),
            if (_authType == AuthType.signUp)
              AppGap(medium, direction: AppGapDirection.vertical),
            if (_authType == AuthType.signUp)
              AppInput(
                controller: nameController,
                header: localization.name,
                textCapitalization: TextCapitalization.sentences,
              ),
            AppGap(small, direction: AppGapDirection.vertical),
            AppInput(
              controller: emailController,
              header: localization.email,
              textInputType: TextInputType.emailAddress,
            ),
            AppGap(small, direction: AppGapDirection.vertical),
            AppInput(
              controller: passwordController,
              header: localization.password,
              isPassword: true,
              textInputAction: TextInputAction.done,
            ),
            AppGap(small, direction: AppGapDirection.vertical),
            if (_authType == AuthType.signIn)
              InkWell(
                onTap: () => AppNavigator.toNamed(context, '/forgot-password'),
                child: AppText(
                  '${localization.forgotPassword}?',
                  fontSize: 12,
                  textAlign: TextAlign.end,
                  textDecoration: TextDecoration.underline,
                  color: secondaryColor,
                ),
              ),
            AppGap(medium, direction: AppGapDirection.vertical),
            if (_authType == AuthType.signIn)
              AppButton(
                  text: localization.loginButton,
                  onPressed: (state is UserAuthLoading)
                      ? null
                      : () => _login(userAuthBloc))
            else
              AppButton(
                text: localization.signUpButton,
                onPressed: (state is UserAuthLoading)
                    ? null
                    : () => _register(userAuthBloc),
              ),
            AppGap(medium, direction: AppGapDirection.vertical),
            AppHaveAnAccount(_authType),
            AppGap(medium, direction: AppGapDirection.vertical),
            AppDivider(
              withText: localization.or,
            ),
            AppGap(high, direction: AppGapDirection.vertical),
            if (state is UserAuthLoading)
              const AppLoading()
            else
              AppSignInButtons(),
            AppGap(high, direction: AppGapDirection.vertical),
            const Spacer(),
            AppAuthorizationFooter(_authType)
          ],
        );
      },
    );
  }

  void _login(AuthBloc userAuthBloc) => userAuthBloc.add(
        UserSignInWithEmail(
          email: emailController.text,
          password: passwordController.text,
        ),
      );

  void _register(AuthBloc userAuthBloc) => userAuthBloc.add(
        UserSignUpWithEmail(
          email: emailController.text,
          name: nameController.text,
          password: passwordController.text,
        ),
      );
}
