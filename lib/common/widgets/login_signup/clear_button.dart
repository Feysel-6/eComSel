import 'package:ecom_sel/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ClearButton extends StatelessWidget {
  const ClearButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => AuthenticationRepository.instance.logout(),
      icon: const Icon(CupertinoIcons.clear),
    );
  }
}