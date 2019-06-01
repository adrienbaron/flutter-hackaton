import 'package:flutter_mentor/config/global_translations.dart';

enum Tags {
  fundamentals,
  architecture,
  animations,
  hummingbird,
  desktop,
}

class TagsHelper {
  static String translation(Tags tag){
    return allTranslations.text('tags.${tag.toString()}');
  }

}