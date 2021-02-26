import 'package:artCraftLiving/Payment/PaymnetMain.dart';
import 'package:artCraftLiving/artwork/my_soldartwork.dart';
import 'package:artCraftLiving/artwork/purchased_artwork.dart';
import 'package:artCraftLiving/artwork/sold_artwork.dart';
import 'package:artCraftLiving/artwork/users.artwork.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/home_screen.dart';
import 'package:artCraftLiving/login/buyapp.dart';
import 'package:artCraftLiving/login/forgot_password.dart';
import 'package:artCraftLiving/login/login.dart';
import 'package:artCraftLiving/login/sign_up.dart';
import 'package:artCraftLiving/menu/collected_points.dart';
import 'package:artCraftLiving/menu/exhibition.dart';
import 'package:artCraftLiving/menu/help/help.dart';
import 'package:artCraftLiving/menu/my_supporters.dart';
import 'package:artCraftLiving/menu/mysold.dart';
import 'package:artCraftLiving/menu/payment.dart';
import 'package:artCraftLiving/menu/purchased.dart';
import 'package:artCraftLiving/menu/communitysales.dart';
import 'package:artCraftLiving/profiles/SupporterUserProfile.dart';
import 'package:artCraftLiving/profiles/after_signup.dart';
import 'package:artCraftLiving/profiles/edit_Profile.dart';
import 'package:artCraftLiving/profiles/my_gallery.dart';
import 'package:artCraftLiving/profiles/user_profile.dart';
import 'package:artCraftLiving/splash_screen.dart';
import 'package:artCraftLiving/uplaod_art.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

import 'login/inapp_payment_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InAppPurchaseConnection.enablePendingPurchases();

  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ArtCraftLiving());
}

class ArtCraftLiving extends StatelessWidget {
  const ArtCraftLiving({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderModel(),
      child: MaterialApp(
        title: 'main page',
        routes: <String, WidgetBuilder>{
          SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
          LOGIN: (BuildContext context) => LogIn(),
          SIGN_UP: (BuildContext context) => SignUp(),
          FORGOT_PASSWORD: (BuildContext context) => ForgotPassword(),
          AFTER_SIGNUP: (BuildContext context) => AfterSignup(),
          EDIT_PROFILE: (BuildContext context) => EditProfile(),
          UPLOAD_ART: (BuildContext context) => UploadArt(),
          HOME_SCREEN: (BuildContext context) => Home(),
          MY_GALLERY: (BuildContext context) => MyGallery(),
          USER_PROFILE: (BuildContext context) => UserProfile(),
          SUPPORTER_USER_PROFILE: (BuildContext context) =>
              SupportedUserProfile(),
          USERS_ARTWORK: (BuildContext context) => UsersArtwork(),
          COMMUNITY_SALE: (BuildContext context) => CommunitySales(),
          SOLD_ARTWORKS: (BuildContext context) => SoldArtwork(),
          MYSOLD: (BuildContext context) => MySold(),
          MYSOLD_ARTWORKS: (BuildContext context) => MySoldArtwork(),
          PURCHASED: (BuildContext context) => Purchased(),
          PURCHASED_ARTWORKS: (BuildContext context) => PurchasedArtwork(),
          MY_SUPPOERTERS: (BuildContext context) => MySupporters(),
          COLLECTED_POINTS: (BuildContext context) => CollectedPoints(),
          PAYMENT: (BuildContext context) => Payment(),
          BUYAPP: (BuildContext context) => BuyApp(),
          HELP: (BuildContext context) => Help(),
          EXHIBITION: (BuildContext context) => Exhibition(),
          PAYMENTMAIN: (BuildContext context) => PaymentMain(),
        },
        initialRoute: SPLASH_SCREEN,
      ),
    );
  }
}
