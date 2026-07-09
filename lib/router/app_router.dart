import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/core/models/community_event_model.dart';
import 'package:portalixmx_app/core/models/community_poll_model.dart';
import 'package:portalixmx_app/core/models/payment_model.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/presentation/screens/payment_detail/payment_detail_page.dart';
import 'package:portalixmx_app/presentation/screens/preview_image/preview_image_screen.dart';
import 'package:portalixmx_app/router/go_router_refresh.dart';
import 'package:portalixmx_app/services/auth_service/auth_service.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/presentation/screens/account_pending/account_pending_page.dart';
import '../core/models/access_request_model.dart';
import '../core/models/complaints_model.dart';
import '../presentation/screens/authentication/create_account_page.dart';
import '../presentation/screens/authentication/forget_password_page.dart';
import '../presentation/screens/authentication/login_page.dart';
import '../presentation/screens/authentication/otp_page.dart';
import '../presentation/screens/complete_profile_screen/complete_profile_screen.dart';
import '../presentation/screens/main_menu/access/access_page.dart';
import '../presentation/screens/main_menu/access/access_summary_page.dart';
import '../presentation/screens/main_menu/homepage/home_page.dart';
import '../presentation/screens/main_menu/homepage/visitor_detail_page.dart';
import '../presentation/screens/main_menu/maintenance/complaint_summary_page.dart';
import '../presentation/screens/main_menu/maintenance/maintenance_page.dart';
import '../presentation/screens/main_menu/payments_menu.dart';
import '../presentation/screens/main_menu/profile_menu/community_calendar.dart';
import '../presentation/screens/main_menu/profile_menu/community_detail_page.dart';
import '../presentation/screens/community_polls/community_polls_detail_page.dart';
import '../presentation/screens/community_polls/community_polls_page.dart';
import '../presentation/screens/main_menu/profile_menu/directory_detail_page.dart';
import '../presentation/screens/main_menu/profile_menu/directory_page.dart';
import '../presentation/screens/main_menu/profile_menu/edit_profile_page.dart';
import '../presentation/screens/main_menu/profile_menu/emergency_calls_page.dart';
import '../presentation/screens/main_menu/profile_menu/guard_tracking_map_page.dart';
import '../presentation/screens/main_menu/profile_menu/profile_guards_page.dart';
import '../presentation/screens/main_menu/profile_menu/profile_page.dart';
import '../presentation/screens/main_menu/main_menu.dart';

final _authRefreshListenable =
    GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges());

GoRouter appRouter = GoRouter(
  refreshListenable: _authRefreshListenable,
  initialLocation: NamedRoutes.createAccount.routeName,
  routes: [
    GoRoute(path: NamedRoutes.createAccount.routeName, builder: (ctx, state)=> CreateAccountPage()),
    GoRoute(path: NamedRoutes.accountPending.routeName, builder: (ctx, state)=> const PendingRequestPage()),

    GoRoute(path: NamedRoutes.completeProfile.routeName, builder: (ctx, state)=> CompleteProfileScreen()),
    GoRoute(path: NamedRoutes.login.routeName, builder: (ctx, state)=> LoginPage()),
      GoRoute(path: NamedRoutes.forgetPassword.routeName, builder: (ctx, state)=> ForgetPasswordPage()),
      StatefulShellRoute.indexedStack(
          builder: (ctx, state, navigationShell){
            return MainMenuPage(navigationShell: navigationShell,);
          },
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => HomePage())
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: NamedRoutes.paymentsBilling.routeName, builder: (ctx, state) => PaymentsMenu())
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: NamedRoutes.maintenance.routeName, builder: (ctx, state) => MaintenanceMenu())
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: NamedRoutes.accessRequests.routeName, builder: (ctx, state) => AccessMenu())
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: NamedRoutes.profile.routeName, builder: (ctx, state) => ProfileMenu())
            ]),
          ]),
      GoRoute(path: NamedRoutes.guestDetail.routeName, builder: (ctx, state){
        return GuestDetailPage(visitor: state.extra as BaseVisitor);
      }),
    GoRoute(path: NamedRoutes.paymentDetail.routeName, builder: (ctx, state)=> PaymentDetailPage(payment: state.extra as PaymentModel)),

    GoRoute(path: NamedRoutes.accessRequestDetail.routeName, builder: (ctx, state)=> AccessSummaryPage(access: state.extra as AccessRequestModel)),
    GoRoute(path: NamedRoutes.complaintSummary.routeName, builder: (ctx, state)=> ComplaintSummaryPage(complaint: state.extra as ComplaintModel,)),
      GoRoute(path: NamedRoutes.editProfile.routeName, builder: (ctx, state)=> EditProfilePage()),
      GoRoute(path: NamedRoutes.userDirectory.routeName, builder: (ctx, state)=> DirectoryPage()),
    GoRoute(path: NamedRoutes.directoryDetail.routeName, builder: (ctx, state)=> DirectoryDetailPage()),

    GoRoute(path: NamedRoutes.communityCalendar.routeName, builder: (ctx, state)=> CommunityCalendarPage()),
    GoRoute(path: NamedRoutes.communityCalendarDetail.routeName, builder: (ctx, state)=> CommunityDetailPage(event: state.extra as CommunityEventModel,)),

    GoRoute(path: NamedRoutes.communityPolls.routeName, builder: (ctx, state)=> CommunityPollsPage()),
    GoRoute(path: NamedRoutes.communityPollsDetail.routeName, builder: (ctx, state)=> CommunityPollsDetailPage(poll: state.extra as CommunityPollModel,)),

    GoRoute(path: NamedRoutes.profileGuard.routeName, builder: (ctx, state)=> ProfileGuardsPage()),

    GoRoute(path: NamedRoutes.carPooling.routeName, builder: (ctx, state)=> Center(child: Text("Car Pooling Page"),)),
      GoRoute(path: NamedRoutes.emergencyCalls.routeName, builder: (ctx, state)=> EmergencyCallsPage()),
    GoRoute(path: NamedRoutes.guardTracking.routeName, builder: (ctx, state)=> GuardTrackingMapPage()),

    GoRoute(path: NamedRoutes.privacyPolicy.routeName, builder: (ctx, state)=> Center(child: Text("Privacy Policy Page"),)),
    GoRoute(path: NamedRoutes.verifyOtp.routeName, builder: (ctx, state)=> VerifyOTPPage()),
    GoRoute(path: NamedRoutes.previewImage.routeName, builder: (ctx, state){
      final map = state.extra as Map<String, dynamic>;
      return PreviewImageScreen(title: map['title'] as String, imageUrl:  map['imageUrl'],);
    }),

  ],
  redirect: (BuildContext context, GoRouterState state) async {
    final loc = state.matchedLocation;
    final isOnLoginPage = loc == NamedRoutes.login.routeName;
    final isOnSignupPage = loc == NamedRoutes.createAccount.routeName;
    final isOnForgetPasswordPage = loc == NamedRoutes.forgetPassword.routeName;
    final isOnCompleteProfilePage = loc == NamedRoutes.completeProfile.routeName;
    final isOnAccountPendingPage = loc == NamedRoutes.accountPending.routeName;

    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      if (!isOnSignupPage &&
          !isOnLoginPage &&
          !isOnForgetPasswordPage &&
          !isOnCompleteProfilePage) {
        return NamedRoutes.createAccount.routeName;
      }
      return null;
    }

    UserModel? profile;
    try {
      profile = await AuthService.instance.getCurrentUser();
    } catch (_) {
      return null;
    }

    if (profile == null) {
      if (!isOnCompleteProfilePage) {
        return NamedRoutes.completeProfile.routeName;
      }
      return null;
    }

   /* if (profile.status == UserStatus.pending) {
      if (isOnAccountPendingPage || isOnCompleteProfilePage) {
        return null;
      }
      return NamedRoutes.accountPending.routeName;
    }*/

    if (isOnAccountPendingPage || isOnLoginPage || isOnSignupPage) {
      return NamedRoutes.home.routeName;
    }

    return null;
  },
);

enum NamedRoutes {
  createAccount('/create-account'),
  login("/login"),
  forgetPassword('/forget-password'),
  home('/home'),
  paymentsBilling('/payments-billing'),
  maintenance('/maintenance'),
  accessRequests('/access-requests'),
  profile('/profile-menu'),
  guestDetail('/guest-detail'),
  accessRequestDetail('/access-request-detail'),
  complaintSummary('/complaint-detail'),
  editProfile('/edit-profile'),
  userDirectory('/user-directory'),
  directoryDetail('/directory-detail'),
  communityCalendar('/community-calendar'),
  communityCalendarDetail('/community-calendar-detail'),
  communityPolls('/community-polls'),
  communityPollsDetail('/community-poll-detail'),
  profileGuard('/profile-guard'),
  guardTracking('/guard-tracking'),
  carPooling('/car-pooling'),
  emergencyCalls('/emergency-calls'),
  privacyPolicy('/privacy-policy'),
  completeProfile('/complete-profile'),
  verifyOtp('/verify-otp'),
  accountPending('/account-pending'),
  paymentDetail('/payment-details'),
  previewImage('/preview-image')
  ;
  final String routeName;
  const NamedRoutes(this.routeName);
}