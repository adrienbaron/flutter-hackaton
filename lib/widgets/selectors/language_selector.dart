import 'package:flutter/material.dart';
import 'package:flutter_mentor/blocs/helpers/bloc_provider.dart';
import 'package:flutter_mentor/blocs/translations_bloc.dart';
import 'package:flutter_mentor/config/config.dart';
import 'package:flutter_mentor/config/global_translations.dart';
import 'package:flutter_mentor/widgets/selectors/button_menu.dart';

const double _kWidth = 32.0;
const double _kHeight = 32.0;
const double _kFlagRadius = 32.0;

class LanguageSelector extends StatefulWidget {
  LanguageSelector({
    Key key,
    this.width: _kWidth,
    this.height: _kHeight,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  LanguageSelectorState createState() {
    return new LanguageSelectorState();
  }
}

class LanguageSelectorState extends State<LanguageSelector> {
  List<ButtonMenuItem> _flags;

  @override
  void initState() {
    super.initState();

    // Initialize the flags
    _flags = config.supportedLanguages.map((String lang) {
      return ButtonMenuItem<String>(
        value: lang,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildFlagIcon(lang),
              Spacer(),
              Text(allTranslations.text('language_selector.$lang')), 
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildFlagIcon(String lang){
    return CircleAvatar(
                radius: _kFlagRadius,
                child: Image.asset(
                  'assets/images/flag-$lang.png',
                  width: _kFlagRadius,
                  height: _kFlagRadius,
                ),
                backgroundColor: Colors.black.withOpacity(0.05),
              );
  }

  @override
  Widget build(BuildContext context) {
    final TranslationsBloc bloc = BlocProvider.of<TranslationsBloc>(context);

    return StreamBuilder<String>(
      stream: bloc.currentLanguage,
      initialData: allTranslations.currentLanguage,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return ButtonMenu<String>(
        maxItemWithBasedOnButtonRatio: 2.5,
        elevation: 8.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0,),
        openingDirection: VerticalDirection.down,
        items: _flags,
        itemHeight: 64.0,
        child: _buildFlagIcon(snapshot.data),
        onChanged: (String newLang){
          // When the user selects a new language,
          // we emit an event that triggers all 
          // actions related to this language selection

          bloc.setNewLanguage(newLang);
        },
      );

    });
  }
}
