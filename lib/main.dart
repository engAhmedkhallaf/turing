import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turing/controllers/authController.dart';
import 'package:turing/controllers/control_view.dart';
import 'package:turing/core/utils/styles.dart';
import 'package:turing/data/helper/binding.dart';
import 'package:turing/presentation/articles/articles_view.dart';
import 'package:turing/controllers/articles_controller.dart';
import 'package:turing/presentation/articles/screens/article_details/article_details_view.dart';
import 'package:turing/presentation/articles/screens/new_article/create_new_article_view.dart';
import 'package:turing/presentation/auth/forget_password/forget_view.dart';
import 'package:turing/presentation/auth/login/login_view.dart';
import 'package:turing/presentation/auth/register/register_view.dart';
import 'package:turing/presentation/communities/communities_view.dart';
import 'package:turing/presentation/communities/screens/community_details/community_details_view.dart';
import 'package:turing/presentation/home/home_view.dart';
import 'package:turing/presentation/onboarding/obboarding_view.dart';
import 'package:turing/presentation/profile/screens/edit_profile/edit_profile.dart';
import 'package:turing/presentation/settings/settings_view.dart';
import 'package:turing/presentation/rooms/screens/view/rooms_view.dart';
import 'package:turing/presentation/change_theme/dark_light_mode_view.dart';
import 'package:turing/presentation/splash/splash_view.dart';
import 'controllers/communities_controller.dart';
import 'controllers/meeting_controller.dart';
import 'presentation/communities/screens/create_community/create_new_community_view.dart';


int? onboardScreen ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
    Get.put(ArticlesController());
    Get.put(CommunitiesControllerCloud());
    Get.put(MeetingController());
  });
  await AuthController.instance.getUserData();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  onboardScreen = await prefs.getInt("releaseTime");
  await prefs.setInt("releaseTime", 1);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: kPrimaryColor
        )
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky );

    return GetMaterialApp(
      //initialRoute: 'SplashView',
      // initialBinding: Binding(),
      getPages: [
        GetPage(name: SplashView.id, page: ()=>  const SplashView()),
        GetPage(name: OnBoardingView.id, page: ()=>  const OnBoardingView()),
        GetPage(name: RegisterView.id, page: ()=>  const RegisterView()),
        GetPage(name: LoginView.id, page: ()=>  const LoginView()),
        GetPage(name: ForgetView.id, page: ()=>  const ForgetView()),
        GetPage(name: ControlView.id, page: ()=>  ControlView(), binding: Binding()),
        GetPage(name: HomeView.id, page: ()=>  const HomeView()),
        GetPage(name: RoomsView.id, page: ()=>  const RoomsView()),
        GetPage(name: ArticlesView.id, page: ()=>  const ArticlesView()),
        GetPage(name: SettingsView.id, page: ()=>  const SettingsView()),
        // GetPage(name: ProfilePage.id, page: () => ProfilePage()),
        GetPage(name: DarkLightModeView.id, page: ()=>  const DarkLightModeView()),
        GetPage(name: CommunitiesView.id, page: ()=>  const CommunitiesView()),
        GetPage(name: CommunityPageDetailsView.id, page: ()=> const CommunityPageDetailsView()),
        GetPage(name: CreateCommunityView.id, page: ()=>   const CreateCommunityView()),
        GetPage(name: ArticleDetailsView.id, page: ()=>   const ArticleDetailsView()),
        GetPage(name: CreateNewArticleView.id, page: ()=>    const CreateNewArticleView()),
        GetPage(name: EditProfileView.id, page: () => EditProfileView()),

      ],

      title: 'Turing Application',
      debugShowCheckedModeBanner: false, // Remove Banner of Debug
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kPrimaryColor,
        fontFamily: 'Poppins',
        backgroundColor: kBackgroundColor,

        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundColor,
          toolbarTextStyle: TextStyle(
              fontFamily: 'Poppins'
          ),
          iconTheme: IconThemeData(
            color: kPrimaryColor,
          ),
          foregroundColor: kPrimaryColor,
        ),
      ),

      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        primaryColor: kBackgroundColor,
        backgroundColor: kPrimaryColor,

        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          toolbarTextStyle: TextStyle(
              fontFamily: 'Poppins'
          ),
          iconTheme: IconThemeData(
            color: kLightColor,
          ),
          foregroundColor: kLightColor,
        ),
      ),
    );
  }
}

