import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_localizations.dart';
import 'package:cryptocurrency_flutter/widgets/selected_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class LanguageSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('lbl_app_languages'.translate, style: boldTextStyle(size: 22)),
        ),
        body: Container(
          child: LanguageListWidget(
            trailing: SelectedItemWidget(),
            onLanguageChange: (v) {
              selectedLanguageDataModel = v;
              appStore.setLanguage(v.languageCode!);
            },
          ),
        ),
      ),
    );
  }
}
