import 'dart:async';

import 'package:flutter_mentor/config/global_translations.dart';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class EmailValidator {
  final StreamTransformer<String,String> validateEmail = StreamTransformer<String,String>.fromHandlers(handleData: (email, sink){
    final RegExp emailExp = new RegExp(_kEmailRule);

    if (!emailExp.hasMatch(email) || email.isEmpty){
      sink.addError(allTranslations.text('validators.invalid.email'));
    } else {
      sink.add(email);
    }
  });
}

//const String _kMin8CharsOneLetterOneNumber = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
const String _kMin8CharsOneLetterOneNumberOneSpecialCharacter = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\-_\$%\^&\*])(?=.{8,})";
//const String _kMin8CharsOneLetterOneNumberOnSpecialCharacter = r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*_\-#?&])[A-Za-z\d@$!%*\-_#?&]{8,}$";
//const String _kMin8CharsOneUpperLetterOneLowerLetterOnNumber = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$";
//const String _kMin8CharsOneUpperOneLowerOneNumberOneSpecial = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
//const String _kMin8Max10OneUpperOneLowerOneNumberOneSpecial = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$";


class PasswordValidator {
  final StreamTransformer<String,String> validatePassword = StreamTransformer<String,String>.fromHandlers(handleData: (password, sink){
    final RegExp passwordExp =
        new RegExp(_kMin8CharsOneLetterOneNumberOneSpecialCharacter);

    if (!passwordExp.hasMatch(password)){
      sink.addError(allTranslations.text('validators.invalid.password'));
    } else {
      sink.add(password);
    }
  });
}

class NotEmptyValidator {
  final StreamTransformer<String,String> validateNotEmpty = StreamTransformer<String, String>.fromHandlers(handleData: (entry, sink){
    String cleanEntry = entry.trim();

    if (cleanEntry == ""){
      sink.addError(allTranslations.text('validators.invalid.empty'));
    } else {
      sink.add(entry);
    }
  });
}

class IsCheckedValidator {
  final StreamTransformer<bool,bool> validateChecked = StreamTransformer<bool, bool>.fromHandlers(handleData: (entry, sink){
    if (entry == false){
      sink.addError(allTranslations.text('validators.invalid.not_checked'));
    }
    sink.add(entry);
  });
}

class AliasValidator {
  final StreamTransformer<String,String> validateAlias = StreamTransformer<String, String>.fromHandlers(handleData: (entry, sink){
    String cleanEntry = entry.trim();
    int len = cleanEntry.length;

    if (len < 3 || len > 20){
      sink.addError(allTranslations.text('validators.invalid.alias'));
    } else {
      sink.add(entry);
    }
  });
}