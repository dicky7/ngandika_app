import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/presentation/bloc/auth/auth_cubit.dart';
import 'package:ngandika_app/presentation/pages/onboarding/login/login_otp_page.dart';
import 'package:ngandika_app/presentation/pages/onboarding/widgets/login_app_bar.dart';
import 'package:ngandika_app/presentation/widget/custom_button.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:ngandika_app/utils/functions/app_dialogs.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "login";

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();

  late String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(
        title: Text(
          "Enter Your Phone Numbers",
          style: TextStyle(color: kBlue),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: kGreyColor),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Column(
            children: [
              Text(
                "Ngandika will need to verify your phone number.",
                textAlign: TextAlign.center,
                //style: context.bodyLarge,
                style: context.titleMedium,
              ),
              const SizedBox(height: 15),
              Text(
                "What\'s my number?",
                style: context.titleMedium
                    ?.copyWith(color: kBlue, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                width: context.width(0.7),
                child: Column(
                  children: [
                    buildPickCountry(context),
                    const Divider(height: 2, thickness: 0.7),
                    const SizedBox(height: 15),
                    buildPhoneNumber(context)
                  ],
                ),
              ),
              const SizedBox(height: 50),
              buildButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPickCountry(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                onSelect: (country) {
                  context.read<AuthCubit>().setCountry(country);
                },
              );
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSetCountrySuccess) {
                  Future.microtask(() =>
                      countryCodeController.text = state.country.phoneCode);
                  return Text(
                    state.country.name,
                    textAlign: TextAlign.center,
                    style: context.titleLarge
                        ?.copyWith(fontWeight: FontWeight.normal),
                  );
                } else {
                  return Text(
                    'No Country Set',
                    textAlign: TextAlign.center,
                    style: context.titleLarge
                        ?.copyWith(fontWeight: FontWeight.normal),
                  );
                }
              },
            ),
          ),
        ),
        Icon(
          Icons.arrow_drop_down,
          color: context.colorScheme.primary,
          size: 28,
        ),
      ],
    );
  }

  Widget buildPhoneNumber(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            readOnly: true,
            autofocus: true,
            controller: countryCodeController,
            style: context.titleLarge?.copyWith(fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              prefix: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 10,
                alignment: Alignment.bottomLeft,
                child: Text(
                  '+',
                  style: context.titleLarge!.copyWith(color: kBlackColor),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          flex: 3,
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            cursorColor: context.colorScheme.secondary,
            cursorHeight: 30,
            style: context.titleLarge?.copyWith(fontWeight: FontWeight.normal),
            decoration: const InputDecoration(
              hintText: "Phone Number",
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context,
              LoginOtpPage.routeName,
              arguments: phoneNumber,
              (route) => false);
        } else if (state is AuthError) {
          AppDialogs.showCustomDialog(
              context: context,
              icons: Icons.close,
              title: "Error",
              content: state.message,
              onPressed: () => Navigator.pop(context));
        }
      },
      child: CustomButton(
        text: "Next",
        color: kBlueDark,
        width: context.width(0.65),
        onPress: () {
          if (countryCodeController.text.isNotEmpty && phoneController.text.isNotEmpty) {
            var number = phoneController.text.trim();
            if (number.startsWith('0')) {
              number = number.substring(1); // remove leading zero
            }
            var countryCode = countryCodeController.text;
            phoneNumber = "+$countryCode$number";

            AppDialogs.submitPhoneDialog(
              context: context,
              phoneNumber: phoneNumber,
              okPressed: () {
                context.read<AuthCubit>().signInWithPhone(phoneNumber);
              },
            );
          }
        },
      ),

    );
  }
}
