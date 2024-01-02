import 'package:budget_buddy/presenters/profile_presenter.dart';
import 'package:budget_buddy/resources/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_strategy/url_strategy.dart';
import 'resources/utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:budget_buddy/resources/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
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
    return MaterialApp.router(
        theme: AppTheme.lightTheme,
        locale: currentLocale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: AppRoutes.routes);
  }

  @override
  void onUpdateLocaleSuccess(Locale newLocale) {
    setState(() {
      currentLocale = newLocale;
    });
  }
}
