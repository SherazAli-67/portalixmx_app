import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/providers/authentication_provider/authentication_provider.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:portalixmx_app/providers/profile_provider.dart';
import 'package:portalixmx_app/router/app_router.dart';
import 'package:portalixmx_app/services/auth_service/auth_service.dart';
import 'package:provider/provider.dart';

import '../../../core/res/app_icons.dart';
import '../../../core/res/app_textstyles.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/primary_btn.dart';

class PendingRequestPage extends StatefulWidget {
  const PendingRequestPage({super.key});

  @override
  State<PendingRequestPage> createState() => _PendingRequestPageState();
}

class _PendingRequestPageState extends State<PendingRequestPage> {
  bool _refreshing = false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const .symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: .center,
              spacing: 16,
              children: [
                Image.asset(AppIcons.accountPending, height: 48, width: 48, color: Colors.white,),
                FutureBuilder(
                  future: AuthService.instance.getSociety(),
                  builder: (ctx, snapshot) {
                    String societyName = snapshot.data?.name ?? localization.society;
                    return Text(localization.accountRequestPending(societyName), style: AppTextStyles.regularTextStyle, textAlign: .center,);
                  },
                ),
                SizedBox(
                  height: 48,
                  width: .infinity,
                  child: PrimaryBtn(
                    onTap: _refreshing ? () {} : _onRefreshTap,
                    btnText: localization.refresh,
                    isLoading: _refreshing,
                  ),
                ),
                TextButton(
                  onPressed: _onLogoutTap,
                  child: Text(localization.logout, style: AppTextStyles.tileTitleTextStyle2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefreshTap() async {
    setState(() => _refreshing = true);
    final profileProvider = context.read<ProfileProvider>();
    final homeProvider = context.read<HomeProvider>();
    try {
      final user = await AuthService.instance.getCurrentUser();
      if (!mounted) return;
      if (user != null && user.status == UserStatus.approved) {
        await profileProvider.reloadProfile();
        await homeProvider.reloadForCurrentUser();
        if (!mounted) return;
        context.go(NamedRoutes.home.routeName);
        return;
      }
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.accountStillPending);
    } catch (_) {
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.unableToRefreshStatus);
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  Future<void> _onLogoutTap() async {
    final authProvider = context.read<AuthenticationProvider>();
    final homeProvider = context.read<HomeProvider>();
    final profileProvider = context.read<ProfileProvider>();
    await authProvider.logout();
    homeProvider.clearUserState();
    profileProvider.clearUserState();
    if (!mounted) return;
    context.go(NamedRoutes.login.routeName);
  }
}
