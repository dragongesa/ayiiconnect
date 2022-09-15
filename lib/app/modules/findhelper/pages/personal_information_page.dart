import 'dart:async';
import 'dart:developer';

import 'package:ayiconnect/app/data/data/dial_countries.dart';
import 'package:ayiconnect/app/data/models/dial_country/dial_country.dart';
import 'package:ayiconnect/app/data/styles/buttons.dart';
import 'package:ayiconnect/app/data/styles/input_decorations.dart';
import 'package:ayiconnect/app/data/widgets/label_field.dart';
import 'package:ayiconnect/app/modules/findhelper/provider/findhelper_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({
    super.key,
  });

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  @override
  void initState() {
    log('init');
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Timer? debouncer;

  debounce() {
    if (debouncer?.isActive == true) {
      debouncer!.cancel();
      return;
    }
    debouncer = Timer(
      const Duration(milliseconds: 300),
      () {
        formKey.currentState?.save();
      },
    );
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FindHelperProvider>(
      builder: (context, provider, child) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 36,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 16,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Text('Add profile photo'),
                                  ),
                                  Icon(Icons.add_circle_outline_rounded),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'Add a profile to make it more personal.\nIt makes a difference',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Divider(),
              const Divider(),
              LabelField(
                label: 'Full Name',
                field: TextFormField(
                  onChanged: (v) {
                    provider.onFullnameChanged(v);
                  },
                  initialValue: provider.fullName,
                  decoration: InputDecorations.outlined(
                    hintText: 'Your Fullname',
                  ),
                ),
              ),
              LabelField(
                label: 'Select Your Gender',
                field: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Male',
                    'Female',
                    'Others',
                  ]
                      .asMap()
                      .entries
                      .map(
                        (e) => Material(
                          color: provider.selectedGender == e.value
                              ? const Color(0xffFA9D6B)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              provider.onSelectGender(e.value);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: provider.selectedGender ==
                                                    e.value
                                                ? Colors.white
                                                : Colors.blueGrey
                                                    .withOpacity(.3),
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: CircleAvatar(
                                            radius: 10 - 3,
                                            backgroundColor:
                                                provider.selectedGender ==
                                                        e.value
                                                    ? Colors.white
                                                    : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    e.value,
                                    style: TextStyle(
                                      color: provider.selectedGender == e.value
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              LabelField(
                label: 'Choose Your Date of Birth',
                field: TextFormField(
                  initialValue: provider.dateOfBirth == null
                      ? null
                      : DateFormat('MM/dd/yyyy').format(provider.dateOfBirth!),
                  decoration: InputDecorations.outlined(
                    hintText: 'MM/DD/YYYY',
                    suffixIcon: const Icon(
                      Icons.calendar_month_outlined,
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 200,
                                child: ScrollDatePicker(
                                  selectedDate:
                                      provider.dateOfBirth ?? DateTime.now(),
                                  onDateTimeChanged: (value) {
                                    provider.onSelectDateOfBirth(value);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: Buttons.primaryButton(),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Select'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    formKey.currentState!.reset();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
              LabelField(
                label: 'Phone Number',
                field: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  initialValue: provider.phoneNumber,
                  onChanged: provider.onPhoneChanged,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecorations.outlined().copyWith(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: SizedBox(
                      width: 60 + 16 * 2 + 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: SizedBox(
                                  width: 60,
                                  child: PopupMenuButton(
                                    onSelected: provider.onSelectedDialCountry,
                                    child: Center(
                                        child: Row(
                                      children: [
                                        Text(provider
                                                .selectedDialCountry?.code ??
                                            ''),
                                        const Icon(
                                            Icons.arrow_drop_down_rounded),
                                      ],
                                    )),
                                    itemBuilder: (context) => dialCountries
                                        .map(
                                          (e) => DialCountry(
                                            e['dial_code']!,
                                            e['name']!,
                                          ),
                                        )
                                        .map(
                                          (e) => PopupMenuItem(
                                            value: e,
                                            child: Text(e.countryName),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                              const VerticalDivider(width: 1, thickness: 1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              LabelField(
                label: 'Current Location*',
                field: FutureBuilder(
                  future: provider.currentLatLngGeocoding,
                  builder: (context, snapshot) {
                    return TextFormField(
                      initialValue: snapshot.data,
                      decoration: InputDecorations.outlined().copyWith(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await provider.getCurrentLocation();
                            FocusManager.instance.primaryFocus?.unfocus();
                            // if (snapshot.hasData) {
                            Future.microtask(() {
                              formKey.currentState!.reset();
                            });
                            // }
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
