import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:zenzi/modules/affirmation/view/affirmationview.dart';
import 'package:zenzi/modules/auth/view/forgot_password/view/forgot_password_view.dart';
import 'package:zenzi/modules/auth/view/login/view/log_in_view.dart';
import 'package:zenzi/modules/auth/view/otp/view/otp_verification.dart';
import 'package:zenzi/modules/auth/view/signup/view/signup_view.dart';
import 'package:zenzi/modules/bottom_navigation_bar/view/custom_buttom_navigation_bar.dart';
import 'package:zenzi/modules/breath_page/view/breath_page_view.dart';
import 'package:zenzi/modules/chat/bindings/chat_bindings.dart';
import 'package:zenzi/modules/chat/view/chat_view.dart';
import 'package:zenzi/modules/download/view/download_view.dart';
import 'package:zenzi/modules/help_and_support/view/help_and_support.dart';
import 'package:zenzi/modules/favourite/bindings/favourite_binding.dart';
import 'package:zenzi/modules/favourite/view/favourite_page_view.dart';
import 'package:zenzi/modules/home/view/home_view.dart';
import 'package:zenzi/modules/journal/view/journal_view.dart';
import 'package:zenzi/modules/journal/view/optionPage/daily_page.dart';
import 'package:zenzi/modules/journal/view/optionPage/history_page.dart';
import 'package:zenzi/modules/just%20breathe/view/just_breathe_view.dart';
import 'package:zenzi/modules/meditation_view/bindings/mediation_page_binding.dart';
import 'package:zenzi/modules/meditation_view/view/levelup_view.dart';
import 'package:zenzi/modules/meditation_view/view/meditation_details.dart';
import 'package:zenzi/modules/meditation_view/view/meditation_page.dart';
import 'package:zenzi/modules/music/bindings/music_page_binding.dart';
import 'package:zenzi/modules/music/view/music_page.dart';

import 'package:zenzi/modules/music/view/play_music.dart';
import 'package:zenzi/modules/notification/view/notification_view.dart';
import 'package:zenzi/modules/preference/binding/preference_page_bindings.dart';
import 'package:zenzi/modules/preference/view/option_page.dart';
import 'package:zenzi/modules/preference/view/preference_page.dart';
import 'package:zenzi/modules/setting/view/account_deletion.dart';
import 'package:zenzi/modules/setting/view/account_setting.dart';
import 'package:zenzi/modules/profile/view/edit_profile.dart';
import 'package:zenzi/modules/setting/view/notification.dart';
import 'package:zenzi/modules/setting/view/set_time.dart';
import 'package:zenzi/modules/setting/view/update_password.dart';
import 'package:zenzi/modules/splash/splash_screen.dart';
import 'package:zenzi/modules/statistics_and_achivement/view/statistic_and_achivement_view.dart';
import 'package:zenzi/modules/subscription/view/premium_subscription.dart';
import 'package:zenzi/modules/subscription/view/subscription_view.dart';
import 'package:zenzi/modules/terms_and_condition/terms_and_condition.dart';

class AppRoute {
  //auth
  static const String otpverificationPage = '/otpverificationPage';
  static const String signupView = '/signupView';
  static const String loginView = '/loginView';
  static const String forgotPasswordView = '/forgotPasswordView';
  //splash
  static const String splashView = '/splashView';
  //home
  static const String homeView = '/homeView';
  //bottom navigation bar
  static const String custombottomNavigationBar = '/custombottomNavigationBar';
  //breath page
  static const String breathPageView = '/breathPageView';
  //Meditaion Page
  static const String meditationPage = '/meditaionPage';
  static const String meditationDetails = '/meditationDetails';
  static const String levelupView = '/levelupView';
  //settings
  static const String accountSetting = '/accountSetting';
  static const String edit = '/editProfile';
  static const String updatePassword = '/updatePassword';
  static const String accountDeletion = '/accountDeletion';
  static const String notificationPage = '/notificationPage';
  static const String helpAndSupportPage = '/helpAndSupportPage';
  static const String termsAndConditionPage = '/termsAndConditionPage';
  static const String setTimeView = '/setTimeView';

  //chat page
  static const String chatView = '/chatView';
  //statistics and achivement page
  static const String statisticAndAchivementView =
      '/statisticAndAchivementView';
  static const String statistictAndachivementPage =
      '/statisticAndAchivementView';
  static const String statisticPage = '/statisticPage';
  static const String achivementPage = '/achivementPage';

  //music page
  static const String musicPage = '/musicPage';
  static const String playMusic = '/playMusic';
  static const String sleepTab = '/sleepTab';
  //journal page
  static const String journalView = '/journalView';
  static const String dailyPage = '/dailyPage';
  static const String historyPage = '/historyPage';
  //favorite page
  static const String favouritePageView = '/favouritePageView';
  //download page
  static const String downloadView = '/downloadView';
  //notification view
  static const String notificationView = '/notificationView';
  static const String affirmationView = '/affirmationView';
  //preference page
  static const String optionPage = '/optionPage';
  //subscription page
  static const String subscriptionView = '/subscriptionView';
  static const String premiumSubscriptionView = '/premiumSubscriptionView';
  //pereference page
  static const String preferencePage = '/preferencePage';
  //just breathe page
  static const String justBreathePageView = '/justBreathePageView';

  static String getOtpverificationPage() => otpverificationPage;
  static String getSignupView() => signupView;
  static String getSplashView() => splashView;
  static String getLoginView() => loginView;
  static String getForgotPasswordView() => forgotPasswordView;
  static String getCustomBottomNavigationBar() => custombottomNavigationBar;
  static String getHomeView() => homeView;
  static String getBreathPageView() => breathPageView;
  static String getMeditaionPage() => meditationPage;
  static String getMeditationDetails() => meditationDetails;
  static String getAccountSetting() => accountSetting;
  static String getEditProfile() => edit;
  static String getUpdatePassword() => updatePassword;
  static String getAccountDeletion() => accountDeletion;
  static String getNotificationPage() => notificationPage;
  static String getChatView() => chatView;
  static String getMusicPage() => musicPage;
  static String getPlayMusic() => playMusic;
  static String getJournalView() => journalView;
  static String getDailyPage() => dailyPage;
  static String getHistoryPage() => historyPage;
  static String getStatisticAndAchivementPage() => statistictAndachivementPage;
  static String getStatisticPage() => statisticPage;
  static String getAchivementPage() => achivementPage;
  static String getFavouritePageView() => favouritePageView;
  static String getHelpAndSupportPage() => helpAndSupportPage;
  static String getTermsAndConditionPage() => termsAndConditionPage;
  static String getDownloadView() => downloadView;
  static String getNotificationView() => notificationView;
  static String getAffirmationView() => affirmationView;
  static String getSetTimeView() => setTimeView;
  static String getOptionPage() => optionPage;
  static String getSubscriptionView() => subscriptionView;
  static String getPremiumSubscriptionView() => premiumSubscriptionView;
  static String getLevelupView() => levelupView;
  static String getPreferencePage() => preferencePage;
  static String getJustBreathePageView() => justBreathePageView;
  static String getSleepTab() => sleepTab;

  static List<GetPage> routes = [
    GetPage(name: splashView, page: () => SplashScreen()),
    GetPage(name: otpverificationPage, page: () => OtpVerification()),
    GetPage(name: signupView, page: () => SignupView()),
    GetPage(name: loginView, page: () => LogInView()),
    GetPage(name: forgotPasswordView, page: () => ForgotPasswordView()),
    GetPage(
      name: custombottomNavigationBar,
      page: () => CustomButtomNavigationBar(),
    ),
    GetPage(name: homeView, page: () => HomeView()),
    GetPage(name: breathPageView, page: () => BreathPageView()),
    GetPage(
      name: meditationPage,
      page: () => MeditationPage(),
      binding: MeditationPageBinding(),
    ),
    GetPage(name: meditationDetails, page: () => MeditationDetails()),
    //settings
    GetPage(name: accountSetting, page: () => AccountSetting()),
    GetPage(name: edit, page: () => EditProfile()),
    GetPage(name: updatePassword, page: () => UpdatePassword()),
    GetPage(name: accountDeletion, page: () => AccountDeletion()),
    GetPage(name: notificationPage, page: () => NotificationPage()),
    GetPage(name: chatView, page: () => ChatView(), binding: ChatBinding()),
    GetPage(name: setTimeView, page: () => SetTimeView()),
    GetPage(
      name: musicPage,
      page: () => MusicPage(),
      binding: MusicPageBinding(),
    ),
    GetPage(name: playMusic, page: () => const PlayMusic()),
    //journal
    GetPage(name: journalView, page: () => JournalView()),
    GetPage(name: dailyPage, page: () => DailyPage()),
    GetPage(name: historyPage, page: () => HistoryPage()),
    GetPage(name: helpAndSupportPage, page: () => HelpAndSupportPage()),
    GetPage(name: termsAndConditionPage, page: () => TermsAndConditionPage()),
    GetPage(name: downloadView, page: () => DownloadView()),
    GetPage(name: notificationView, page: () => NotificationView()),
    GetPage(name: affirmationView, page: () => AffirmationView()),
    GetPage(name: subscriptionView, page: () => SubscriptionView()),
    GetPage(name: levelupView, page: () => LevelupView()),

    GetPage(
      name: premiumSubscriptionView,
      page: () => PremiumSubscriptionView(),
    ),

    GetPage(
      name: statisticAndAchivementView,
      page: () => StatisticAndAchivementView(),
    ),
    GetPage(name: optionPage, page: () => OptionPage()),
    GetPage(
      name: preferencePage,
      page: () => PreferencePage(),
      binding: PreferencePageBindings(),
    ),
    // GetPage(name: statisticPage, page: () => StatisticPage()),
    // GetPage(name: achivementPage, page: () => AchivementPage()),
    GetPage(name: justBreathePageView, page: () => JustBreathePageView()),
    GetPage(
      name: favouritePageView,
      page: () => const FavouritePageView(),
      binding: FavouriteBinding(),
    ),
  ];
}
