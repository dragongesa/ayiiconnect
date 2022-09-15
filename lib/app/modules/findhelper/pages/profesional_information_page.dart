import 'package:ayiconnect/app/data/styles/input_decorations.dart';
import 'package:ayiconnect/app/data/widgets/label_field.dart';
import 'package:ayiconnect/app/modules/findhelper/provider/findhelper_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfesionalInformationPage extends StatefulWidget {
  const ProfesionalInformationPage({super.key});

  @override
  State<ProfesionalInformationPage> createState() =>
      _ProfesionalInformationPageState();
}

class _ProfesionalInformationPageState
    extends State<ProfesionalInformationPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Consumer<FindHelperProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              LabelField(
                label: 'Occupation',
                field: TextFormField(
                  onChanged: provider.onOccupationChanged,
                  decoration: InputDecorations.outlined(
                      hintText: 'Add your occupation'),
                ),
              ),
              LabelField(
                label: 'Company',
                field: TextFormField(
                  onChanged: provider.onCompanyChanged,
                  decoration: InputDecorations.outlined(
                      hintText: 'Add your company name'),
                ),
              ),
              LabelField(
                label: 'Fluently spoken language(s)',
                field: Builder(builder: (context) {
                  return TextFormField(
                    initialValue: provider.selectedLanguage,
                    onTap: () {
                      Future.microtask(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                    },
                    readOnly: true,
                    decoration:
                        InputDecorations.outlined(hintText: 'Add language')
                            .copyWith(
                                suffixIcon: PopupMenuButton(
                      child: const Icon(Icons.add_circle_outline_rounded),
                      onSelected: (v) {
                        Future.microtask(() {
                          FocusManager.instance.primaryFocus?.unfocus();
                        });
                        provider.onAddLanguage(v, () {
                          Future.microtask(() {
                            formKey.currentState!.reset();
                          });
                        });
                      },
                      itemBuilder: (context) => [
                        'Spanish',
                        'Mandarin',
                        'English'
                      ]
                          .map((e) => PopupMenuItem(value: e, child: Text(e)))
                          .toList(),
                    )),
                  );
                }),
              ),
              LabelField(
                label: 'Prefered Service',
                field: DropdownButtonFormField(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  value: provider.preferedService,
                  decoration: InputDecorations.outlined(
                          hintText: 'Add your prefered service')
                      .copyWith(),
                  items: const [
                    'Child Care',
                    'Senior Care',
                    'Home Care',
                    'Other Services',
                  ]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) {
                    provider.onPreferedServiceChanged(v);
                    Future.microtask(() {
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                ),
              ),
              LabelField(
                label: 'Tell us about you*',
                field: Stack(
                  children: [
                    TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      maxLength: 100,
                      minLines: 3,
                      maxLines: 3,
                      onChanged: provider.onDescChanged,
                      decoration: InputDecorations.outlined(
                              hintText:
                                  'Provide some brief about yourself, so helper can get to know your a litle better before your connection.')
                          .copyWith(
                        counter: const SizedBox(),
                        contentPadding:
                            const EdgeInsets.fromLTRB(16, 16, 16, 48),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 16, bottom: 16),
                            child: Text.rich(
                              TextSpan(
                                text: '${provider.userDesc?.length ?? 0}',
                                children: [
                                  TextSpan(
                                      text: '/100',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.color
                                              ?.withOpacity(.5))),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
