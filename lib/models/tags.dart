

enum Tags {
  fundamentals,
  architecture,
  animations,
  hummingbird,
  desktop,
}

class TagsHelper {
  static Tags fromText(String text){
    Tags tags = Tags.fundamentals;

    tags = Tags.values.firstWhere((e) => e.toString().split('.')[1] == text);
 
    return tags;
  }
}
