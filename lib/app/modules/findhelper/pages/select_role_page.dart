import 'package:ayiconnect/app/data/styles/buttons.dart';
import 'package:ayiconnect/app/modules/findhelper/provider/findhelper_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectRolePage extends StatelessWidget {
  const SelectRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FindHelperProvider>(
      builder: (context, provider, child) => Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            _buildItem(
              buttonLabel: 'Find a helper',
              label: 'Are you seeking care for your\nlove one?',
              onPressed: () {
                provider.onSelectRole(0);
              },
            ),
            _buildItem(
              buttonLabel: 'Find for a Job',
              label: "Or you're looking for a care, housekeeper, or tutor job?",
              buttonColor: const Color(0xffFA9D6B),
              onPressed: () {
                provider.onSelectRole(1);
              },
            ),
          ]),
        ),
      ),
    );
  }

  _buildItem({
    String? label,
    String? buttonLabel,
    Function()? onPressed,
    Color? buttonColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 56,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              label ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: Buttons.primaryButton(
              backgroundColor: buttonColor,
            ),
            child: Text(buttonLabel ?? ''),
          )
        ],
      ),
    );
  }
}
