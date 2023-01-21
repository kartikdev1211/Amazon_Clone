import 'package:clone_amazon/screens/result_screen.dart';
import 'package:clone_amazon/screens/search_screen.dart';
import 'package:clone_amazon/utils/color_theme.dart';
import 'package:clone_amazon/utils/constants.dart';
import 'package:clone_amazon/utils/utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  SearchBarWidget(
      {super.key, required this.isReadOnly, required this.hasBackButton})
      : preferredSize = const Size.fromHeight(kAppBarHeight);
  @override
  final Size preferredSize;
  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(color: Colors.grey, width: 1),
  );
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Container(
        height: kAppBarHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            hasBackButton
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  )
                : Container(),
            SizedBox(
              width: screenSize.width * 0.7,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: TextField(
                  onSubmitted: (String query) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsScreen(
                          query: query,
                        ),
                      ),
                    );
                  },
                  readOnly: isReadOnly,
                  onTap: () {
                    if (isReadOnly) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const SearchScreen()),
                        ),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Search Amazon.in",
                    fillColor: Colors.white,
                    filled: true,
                    border: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic_none_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
