import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/features/authentication/create_account_page.dart';
import 'package:portalixmx_app/features/authentication/forget_password_page.dart';
import 'package:portalixmx_app/features/authentication/login_page.dart';
import 'package:portalixmx_app/features/authentication/otp_page.dart';
import 'package:portalixmx_app/features/complete_profile_screen/complete_profile_screen.dart';
import 'package:portalixmx_app/features/main_menu/access/access_page.dart';
import 'package:portalixmx_app/features/main_menu/access/access_summary_page.dart';
import 'package:portalixmx_app/features/main_menu/homepage/home_page.dart';
import 'package:portalixmx_app/features/main_menu/homepage/visitor_detail_page.dart';
import 'package:portalixmx_app/features/main_menu/maintenance/complaint_summary_page.dart';
import 'package:portalixmx_app/features/main_menu/maintenance/maintenance_page.dart';
import 'package:portalixmx_app/features/main_menu/payments_menu.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/community_calendar.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/community_detail_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/community_polls_detail_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/community_polls_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/directory_detail_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/directory_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/edit_profile_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/emergency_calls_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/guard_tracking_map_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/profile_guards_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/profile_page.dart';
import 'package:portalixmx_app/features/main_menu/resident_main_menu_page.dart';
import 'package:portalixmx_app/models/access_control_api_response.dart';
import 'package:portalixmx_app/models/complaints_api_response.dart';
import 'package:portalixmx_app/models/guest_api_response.dart';
import 'package:portalixmx_app/models/visitor_api_response.dart';

GoRouter appRouter = GoRouter(
  initialLocation: NamedRoutes.createAccount.routeName,
  routes: [
      GoRoute(path: NamedRoutes.createAccount.routeName, builder: (ctx, state)=> CreateAccountPage()),
      GoRoute(path: NamedRoutes.login.routeName, builder: (ctx, state)=> LoginPage()),
      GoRoute(path: NamedRoutes.forgetPassword.routeName, builder: (ctx, state)=> ForgetPasswordPage()),
      StatefulShellRoute.indexedStack(
          builder: (ctx, state, navigationShell){
            return ResidentMainMenuPage(navigationShell: navigationShell,);
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
        Guest? guest = state.extra as Guest?;
        Visitor? visitor = state.extra as Visitor?;
        return GuestDetailPage(guest: guest, visitor: visitor,);
      }),
    GoRoute(path: NamedRoutes.accessRequestDetail.routeName, builder: (ctx, state)=> AccessSummaryPage(access: state.extra as AccessRequestModel)),
    GoRoute(path: NamedRoutes.complaintSummary.routeName, builder: (ctx, state)=> ComplaintSummaryPage(complaint: state.extra as Complaint,)),
      GoRoute(path: NamedRoutes.editProfile.routeName, builder: (ctx, state)=> EditProfilePage()),
      GoRoute(path: NamedRoutes.userDirectory.routeName, builder: (ctx, state)=> DirectoryPage()),
    GoRoute(path: NamedRoutes.directoryDetail.routeName, builder: (ctx, state)=> DirectoryDetailPage()),

    GoRoute(path: NamedRoutes.communityCalendar.routeName, builder: (ctx, state)=> CommunityCalendarPage()),
    GoRoute(path: NamedRoutes.communityCalendar.routeName, builder: (ctx, state)=> CommunityCalendarPage()),
    GoRoute(path: NamedRoutes.communityCalendarDetail.routeName, builder: (ctx, state)=> CommunityDetailPage()),

    GoRoute(path: NamedRoutes.communityPolls.routeName, builder: (ctx, state)=> CommunityPollsPage()),
    GoRoute(path: NamedRoutes.communityPollsDetail.routeName, builder: (ctx, state)=> CommunityPollsDetailPage()),

    GoRoute(path: NamedRoutes.profileGuard.routeName, builder: (ctx, state)=> ProfileGuardsPage()),

    GoRoute(path: NamedRoutes.carPooling.routeName, builder: (ctx, state)=> Center(child: Text("Car Pooling Page"),)),
      GoRoute(path: NamedRoutes.emergencyCalls.routeName, builder: (ctx, state)=> EmergencyCallsPage()),
    GoRoute(path: NamedRoutes.guardTracking.routeName, builder: (ctx, state)=> GuardTrackingMapPage()),

    GoRoute(path: NamedRoutes.privacyPolicy.routeName, builder: (ctx, state)=> Center(child: Text("Privacy Policy Page"),)),
    GoRoute(path: NamedRoutes.completeProfile.routeName, builder: (ctx, state)=> CompleteProfileScreen()),
    GoRoute(path: NamedRoutes.verifyOtp.routeName, builder: (ctx, state)=> VerifyOTPPage()),

  ],
  redirect: (BuildContext context, GoRouterState state) {
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;
    final isOnLoginPage = state.matchedLocation == NamedRoutes.login.routeName;
    final isOnSignupPage = state.matchedLocation == NamedRoutes.createAccount.routeName;
    final isOnForgetPasswordPage = state.matchedLocation == NamedRoutes.forgetPassword.routeName;
    final isOnCompleteProfilePage = state.matchedLocation == NamedRoutes.completeProfile.routeName;
    final isOnVerifyOtpProfilePage = state.matchedLocation == NamedRoutes.verifyOtp.routeName;

    if (isAuthenticated && (isOnLoginPage || isOnSignupPage)) {
      return NamedRoutes.home.routeName;
    }

    if (!isAuthenticated && !isOnSignupPage && !isOnLoginPage && !isOnForgetPasswordPage && !isOnCompleteProfilePage && !isOnVerifyOtpProfilePage) {
      return NamedRoutes.createAccount.routeName;
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
  accessRequestDetail('access-request-detail'),
  complaintSummary('complaint-detail'),
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
  verifyOtp('/verify-otp')
  ;
  final String routeName;
  const NamedRoutes(this.routeName);
}