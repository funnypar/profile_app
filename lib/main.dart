import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark) {
              _themeMode = ThemeMode.light;
            } else {
              _themeMode = ThemeMode.dark;
            }
          });
        },
        selectedLanguageChanged: (_Language selectedLanguageByUser) =>
            setState(() {
              _locale = selectedLanguageByUser == _Language.en
                  ? Locale('en')
                  : Locale('fa');
            }),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChanged;

  const MyHomePage({
    super.key,
    required this.toggleThemeMode,
    required this.selectedLanguageChanged,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum _SkillType { photoshop, xd, illustrator, afterEffect, lightroom }

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _skill = _SkillType.photoshop;
  _Language _language = _Language.en;

  void updateSelectedSkill(_SkillType type) {
    setState(() {
      _skill = type;
    });
  }

  void updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localziation = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localziation.profileTitle),
        actions: [
          InkWell(
            onTap: widget.toggleThemeMode,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(CupertinoIcons.sun_max),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: Icon(CupertinoIcons.chat_bubble),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: Icon(CupertinoIcons.ellipsis_vertical),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/profile_image.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localziation.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 2),
                        Text(localziation.job),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_circle,
                              size: 18,
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall!.color,
                            ),
                            SizedBox(width: 4),
                            Text(
                              AppLocalizations.of(context)!.location,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: Text(localziation.summery),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localziation.selectedLanguage),
                  CupertinoSlidingSegmentedControl(
                    thumbColor: Theme.of(context).primaryColor,
                    groupValue: _language, // Default Value
                    children: {
                      _Language.en: Text(localziation.enLanguage),
                      _Language.fa: Text(localziation.faLanguage),
                    },
                    onValueChanged: (value) => {
                      if (value != null) updateSelectedLanguage(value),
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 12),
              child: Row(
                children: [
                  Text(
                    localziation.skills,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(CupertinoIcons.chevron_down, size: 12),
                ],
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Skill(
                    type: _SkillType.photoshop,
                    title: 'Photoshop',
                    shadowColor: Colors.blue,
                    imagePath: 'assets/images/app_icon_01.png',
                    isActive: _skill == _SkillType.photoshop,
                    onTap: () {
                      updateSelectedSkill(_SkillType.photoshop);
                    },
                  ),
                  Skill(
                    type: _SkillType.xd,
                    title: 'Adobe XD',
                    shadowColor: Colors.pink,
                    imagePath: 'assets/images/app_icon_05.png',
                    isActive: _skill == _SkillType.xd,
                    onTap: () {
                      updateSelectedSkill(_SkillType.xd);
                    },
                  ),
                  Skill(
                    type: _SkillType.illustrator,
                    title: 'Illustrator',
                    shadowColor: Colors.orange,
                    imagePath: 'assets/images/app_icon_04.png',
                    isActive: _skill == _SkillType.illustrator,
                    onTap: () {
                      updateSelectedSkill(_SkillType.illustrator);
                    },
                  ),
                  Skill(
                    type: _SkillType.afterEffect,
                    title: 'After Effect',
                    shadowColor: Colors.blue.shade800,
                    imagePath: 'assets/images/app_icon_03.png',
                    isActive: _skill == _SkillType.afterEffect,
                    onTap: () {
                      updateSelectedSkill(_SkillType.afterEffect);
                    },
                  ),
                  Skill(
                    type: _SkillType.lightroom,
                    title: 'Lightroom',
                    shadowColor: Colors.blue,
                    imagePath: 'assets/images/app_icon_02.png',
                    isActive: _skill == _SkillType.lightroom,
                    onTap: () {
                      updateSelectedSkill(_SkillType.lightroom);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localziation.personalInformation,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localziation.email,
                      prefixIcon: Icon(CupertinoIcons.at),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localziation.password,
                      prefixIcon: Icon(CupertinoIcons.lock),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(localziation.save),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = 'IranYekan';
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
    : primaryTextColor = Colors.white,
      secondaryTextColor = Colors.white70,
      surfaceColor = Color(0x0dffffff),
      backgroundColor = Color.fromARGB(255, 30, 30, 30),
      appBarColor = Colors.black,
      brightness = Brightness.dark;

  MyAppThemeConfig.light()
    : primaryTextColor = Colors.grey.shade900,
      secondaryTextColor = Colors.grey.shade900.withValues(alpha: 0.8),
      surfaceColor = Color(0x0d000000),
      backgroundColor = Colors.white,
      appBarColor = Color.fromARGB(255, 235, 235, 235),
      brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      useMaterial3: false,
      brightness: brightness,
      primaryColor: primaryColor,
      dividerColor: surfaceColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(primaryColor),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        foregroundColor: primaryTextColor,
        titleTextStyle: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
      ),
      textTheme: languageCode == 'fa' ? faPrimaryTextTheme : enPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(
    TextTheme(
      bodyMedium: TextStyle(fontSize: 15, color: primaryTextColor),
      bodySmall: TextStyle(fontSize: 13, color: secondaryTextColor),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: primaryTextColor,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
    ),
  );

  TextTheme get faPrimaryTextTheme => TextTheme(
    bodyMedium: TextStyle(
      fontSize: 15,
      color: primaryTextColor,
      fontFamily: faPrimaryFontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      color: secondaryTextColor,
      fontFamily: faPrimaryFontFamily,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: primaryTextColor,
      fontFamily: faPrimaryFontFamily,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: primaryTextColor,
      fontFamily: faPrimaryFontFamily,
    ),
  );
}

class Skill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagePath;
  final Color shadowColor;
  final bool isActive;

  final Function() onTap;

  const Skill({
    super.key,
    required this.type,
    required this.title,
    required this.imagePath,
    required this.shadowColor,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        width: 110,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor.withValues(alpha: 0.5),
                          blurRadius: 20,
                        ),
                      ],
                    )
                  : null,
              child: Image.asset(imagePath, width: 40, height: 40),
            ),
            SizedBox(height: 2),
            Text(title),
          ],
        ),
      ),
    );
  }
}

enum _Language { en, fa }
