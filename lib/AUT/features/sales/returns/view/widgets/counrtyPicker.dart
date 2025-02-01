import 'package:code_icons/data/model/data_model/countryDM.dart';
import 'package:code_icons/AUT/features/sales/invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryDropdown extends StatefulWidget {
  final List<Country> countries;
  SalesInvoiceCubit salesInvoiceCubit;

  CountryDropdown({
    required this.countries,
    Key? key,
    required this.salesInvoiceCubit,
  }) : super(key: key);

  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  String? _selectedCountry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCountry = widget.salesInvoiceCubit.selectDefaultCountry()?.name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.salesInvoiceCubit,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              /*  labelText: labelText, */
              labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.blackColor.withOpacity(0.8)),
              hintText: "اختيار",
              prefixIcon:
                  const Icon(Icons.location_on_outlined, color: Colors.blue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.lightBlue[50],
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
            ),
            onTap: () {
              _showCountryDropdown();
            },
            readOnly: true,
            controller: TextEditingController(
              text: _selectedCountry ?? '',
            ),
          ),
        ],
      ),
    );
  }

  void _showCountryDropdown() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => CountryDropdownDialog(countries: widget.countries),
    );
    if (selected != null) {
      setState(() {
        _selectedCountry = selected;
      });
    }
  }
}

class CountryDropdownDialog extends StatefulWidget {
  final List<Country> countries;

  const CountryDropdownDialog({required this.countries, Key? key})
      : super(key: key);

  @override
  _CountryDropdownDialogState createState() => _CountryDropdownDialogState();
}

class _CountryDropdownDialogState extends State<CountryDropdownDialog> {
  List<Country> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                /*  labelText: labelText, */
                labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.blackColor.withOpacity(0.8)),
                hintText: "اختيار",
                prefixIcon:
                    const Icon(Icons.location_on_outlined, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.lightBlue[50],
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
              ),
              onChanged: (value) {
                setState(() {
                  _filteredCountries = widget.countries
                      .where((country) => country.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = _filteredCountries[index];
                  return ListTile(
                    title: Text(country.name),
                    onTap: () {
                      ControllerManager()
                          .invoiceAddCustomerCountryController
                          .text = country.code;
                      Navigator.pop(context, country.name);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
