import 'package:budget_buddy/data_sources/repositories/login_repository.dart';
import 'package:budget_buddy/presenters/profile_presenter.dart';
import 'package:budget_buddy/views/landing_view.dart';
import 'package:budget_buddy/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'resources/utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:budget_buddy/views/home_view.dart';
import 'package:budget_buddy/resources/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var profilePresenter = ProfilePresenter();
  await profilePresenter.loadSettings();
  runApp(MainApp(profilePresenter));
}

// The initial widget for theme, configuration and more
class MainApp extends StatefulWidget {
  const MainApp(this.presenter, {super.key});

  final ProfilePresenter presenter;
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> implements MainAppViewContract {
  late Locale currentLocale;

  late ProfilePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = widget.presenter;
    currentLocale = _presenter.currentLocale;
    _presenter.mainAppViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        locale: currentLocale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: FutureBuilder<List<Object?>>(
          future: getFirstRunAndLoginUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            bool firstRun = snapshot.data![0] as bool;
            User? user = snapshot.data![1] as User?;
            if (firstRun) {
              return const LoginView();
            }
            if (user == null) {
              //Chưa đăng nhập
              return const LoginView();
            }
            // Đã đăng nhập, vào màn hình chính
            return const HomeView();
          },
        ));
  }

  // Run all async task and return first run state and current login user
  Future<List<Object?>> getFirstRunAndLoginUser() async {
    var futureFirstRun = LoginRepository().isFirstTime();
    var futureLoginUser = FirebaseAuth.instance.authStateChanges();
    bool firstRun = await futureFirstRun;
    User? user = await futureLoginUser.first;
    return [firstRun, user];
  }

  @override
  void onUpdateLocaleSuccess(Locale newLocale) {
    setState(() {
      currentLocale = newLocale;
    });
  }
}
