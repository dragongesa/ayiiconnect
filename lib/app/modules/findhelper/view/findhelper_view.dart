import 'package:ayiconnect/app/data/styles/buttons.dart';
import 'package:ayiconnect/app/modules/findhelper/pages/select_role_page.dart';
import 'package:ayiconnect/app/modules/findhelper/provider/findhelper_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/personal_information_page.dart';
import '../pages/profesional_information_page.dart';

class FindHelperView extends StatelessWidget {
  const FindHelperView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FindHelperProvider(),
      child: Consumer<FindHelperProvider>(
        builder: (context, provider, child) => Scaffold(
          bottomNavigationBar: AnimatedSize(
            alignment: Alignment.bottomCenter,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: Container(
              child: provider.currentIndex == 0
                  ? const SizedBox()
                  : BottomAppBar(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          style: Buttons.primaryButton(),
                          onPressed: () async {
                            if (provider.currentIndex <
                                provider.steps.length - 1) {
                              provider.changeCurrentIndex(
                                  provider.currentIndex + 1);
                            } else {
                              // provider.changeCurrentIndex(0);
                              var padding = MediaQuery.of(context).padding;
                              var location =
                                  await provider.currentLatLngGeocoding;
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => DraggableScrollableSheet(
                                  expand: false,
                                  minChildSize: .2,
                                  maxChildSize: 1,
                                  snap: true,
                                  builder: (context, scrollController) =>
                                      SafeArea(
                                    child: SingleChildScrollView(
                                      padding: padding,
                                      controller: scrollController,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ['Role', provider.selectedRole],
                                          ['Fullname', provider.fullName],
                                          ['Gender', provider.selectedGender],
                                          [
                                            'Date of Birth',
                                            provider.dateOfBirth
                                          ],
                                          [
                                            'Phone Number',
                                            '${provider.selectedDialCountry?.code} ${provider.phoneNumber}'
                                          ],
                                          ['Current location', location],
                                          ['Occupation', provider.occupation],
                                          ['Company', provider.company],
                                          [
                                            'language',
                                            provider.selectedLanguage
                                          ],
                                          [
                                            'Prefered Service',
                                            provider.preferedService
                                          ],
                                          ['Description', provider.userDesc],
                                        ]
                                            .map<Widget>(
                                                (e) => Text('${e[0]}: ${e[1]}'))
                                            .toList()
                                          ..add(ElevatedButton(
                                              onPressed: () {
                                                provider.changeCurrentIndex(0);
                                              },
                                              child:
                                                  const Text('Back to start'))),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Next'),
                        ),
                      ),
                    ),
            ),
          ),
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff00cccc),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: SafeArea(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: provider.steps
                      .asMap()
                      .entries
                      .map(
                        (e) => _buildStep(
                          e.key + 1,
                          e.value,
                          isActive: e.key == provider.currentIndex,
                          isLast: e.key == provider.steps.length - 1,
                          isDone: e.key < provider.currentIndex,
                          isFirst: e.key == 0,
                        ),
                      )
                      .toList(),
                )),
              ),
              Expanded(
                child: IndexedStack(
                  index: provider.currentIndex,
                  alignment: Alignment.topCenter,
                  children: [
                    provider.currentIndex == 0
                        ? const SelectRolePage()
                        : const SizedBox(),
                    provider.currentIndex == 1
                        ? const PersonalInformationPage()
                        : const SizedBox(),
                    provider.currentIndex == 2
                        ? const ProfesionalInformationPage()
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int index, String label,
      {bool isActive = false,
      bool isLast = false,
      bool isDone = false,
      bool isFirst = false}) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: !isFirst
                      ? Divider(
                          indent: !isFirst ? 0 : 8,
                          endIndent: 8,
                          color: Colors.white,
                        )
                      : const SizedBox()),
              CircleAvatar(
                radius: 16,
                foregroundColor: const Color(0xff00cccc),
                backgroundColor: isActive || isDone
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                child: isDone
                    ? const Icon(Icons.check)
                    : Text(
                        index.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              Expanded(
                child: !isLast
                    ? Divider(
                        indent: 8,
                        endIndent: !isLast ? 0 : 8,
                        color: Colors.white,
                      )
                    : const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive || isDone ? Colors.white : Colors.white70,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
