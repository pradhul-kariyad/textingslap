import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:textingslap/provider/themesProvider.dart';
import 'package:textingslap/theme/theme.dart';

class DarkMode extends StatelessWidget {
  const DarkMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Center(
          widthFactor: 1.8.sp,
          child: Text(
            "Dark Mode",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h, left: 2.w),
            child: Row(
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(color: Colors.black, fontSize: 19.sp),
                ),
                Consumer<ThemesProvider>(
                  builder: (BuildContext context, theme, Widget? child) {
                    return CupertinoSwitch(
                        // activeColor: ColorData.red,
                        value: theme.getTheme() == darkMode,
                        onChanged: (value) {
                          toggleTheme(context);
                        });
                    // return Switch(
                    //   value: theme.getTheme() == darkMode,
                    //   // Provider.of<ThemeProvider>(context).getTheme() == lightMode,
                    //   onChanged: (value) {
                    //     toggleTheme(context);
                    //   },
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
