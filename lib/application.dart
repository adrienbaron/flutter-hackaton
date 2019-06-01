import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mentor/blocs/helpers/bloc_provider.dart';
import 'package:flutter_mentor/blocs/translations_bloc.dart';
import 'package:flutter_mentor/config/config.dart';
import 'package:flutter_mentor/config/global_translations.dart';
import 'package:flutter_mentor/pages/onboarding_page.dart';
import 'package:flutter_mentor/routes.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  TranslationsBloc translationsBloc;

  @override
  void initState() {
    super.initState();
    translationsBloc = TranslationsBloc();
  }

  @override
  void dispose() {
    translationsBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return blocsTree(
      [
        blocTreeNode<TranslationsBloc>(translationsBloc),
      ],
      child: StreamBuilder<Locale>(
        stream: translationsBloc.currentLocale,
        initialData: allTranslations.locale,
        builder: (BuildContext context, AsyncSnapshot<Locale> snapshotLocale) {
          return MaterialApp(
            title: config.applicationName,
            debugShowCheckedModeBanner: false,

            ///
            /// Multi lingual
            ///
            locale: snapshotLocale.data ?? allTranslations.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              _FallbackCupertinoLocalisationsDelegate(),
            ],
            supportedLocales: config.supportedLocales(),

            ///
            /// Routes
            ///
            routes: ApplicationRoutes.routes,

            ///
            /// For unknown reason, we need to launch an intermediate
            /// fake page, which will only and directly redirect to
            /// the ControllerPage, in order for the latter to be
            /// able to listen to Stream events !!!
            ///
            home: OnBoardingPage(),
          );
        },
      ),
    );
  }
}

///
/// At the moment, there is no CupertinoLocalizations.delegate
///
/// As a consequence, if you try to load a Cupertino dialog, it fails.
///
/// This is a work-around
///
class _FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(_FallbackCupertinoLocalisationsDelegate old) => false;
}
