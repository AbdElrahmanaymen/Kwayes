import 'package:flutter/cupertino.dart';
import 'package:kwayes/localization/demo_localization.dart';

String getTranslated(BuildContext context, String key) {
  return DemoLoacalization.of(context).translate(key);
}
