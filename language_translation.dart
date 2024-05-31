///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obocwwb/main.dart';

void main() {
  runApp(GetMaterialApp(
    home: MyApp(),
    translations: WorldLanguage(), //Language class from world_languages.dart
    locale: Locale('en', 'US'), // translations will be displayed in that locale
    fallbackLocale: Locale('en',
        'US'), // specify the fallback locale in case an invalid locale is selected.
  ));
}

class WorldLanguage extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello, How are you?',
          'going': 'Where are you going?',
          'email': 'Hello @name, your email is @email'
        },

        'es_ES': {
          'hello': '¿Hola, cómo estás?',
          'going': '¿Adónde vas?',
          'email': 'Hola @name, tu correo electrónico es @email'
        },

        'ru_RU': {
          'hello': 'Привет, как дела?',
          'going': 'Куда ты направляешься?',
          'email': 'Здравствуйте @name, ваш адрес электронной почты @email',
        }

        //add more language here
      };
}

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({Key? key}) : super(key: key);

  @override
  _LanguageTranslationState createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Language Translation"),
          backgroundColor: Colors.deepOrangeAccent),
      body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(15),
          child: Column(children: [
            Text("hello".tr),
            Text("going".tr),
            Text("email"
                .trParams({'name': 'John', 'email': 'johnabc@gmail.com'})),
            ElevatedButton(
              onPressed: () {
                var locale = Locale('en', 'US');
                Get.updateLocale(locale);
                //you can save this language on preference, and get on app start
              },
              child: Text("Translate to English"),
            ),
            ElevatedButton(
              onPressed: () {
                var locale = Locale('es', 'ES');
                Get.updateLocale(locale);
                //you can save this language on preference, and get on app start
              },
              child: Text("Translate to Spanish"),
            ),
            ElevatedButton(
              onPressed: () {
                var locale = Locale('ru', 'RU');
                Get.updateLocale(locale);
                //you can save this language on preference, and get on app start
              },
              child: Text("Translate to Russian"),
            )
          ])),
    );
  }
}
