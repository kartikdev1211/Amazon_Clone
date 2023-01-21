import 'package:clone_amazon/models/user_details_model.dart';
import 'package:clone_amazon/providers/user_details_provider.dart';
import 'package:clone_amazon/utils/color_theme.dart';
import 'package:clone_amazon/utils/constants.dart';
import 'package:clone_amazon/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailBar extends StatelessWidget {
  final double offset;
  const UserDetailBar({super.key, required this.offset});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    UserDetailsModel? userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Positioned(
      top: -offset / 3,
      child: Container(
        height: kAppBarHeight / 2,
        width: screenSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: lightBackgroundaGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[900],
                ),
              ),
              Text(
                "Deliver to ${userDetails.name} - ${userDetails.address}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[900]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
