import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:erp_easy_chat_state/pages/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late int selectedPage;
  late final PageController pageController;


  @override
  void initState() {
    selectedPage = 0;
    pageController = PageController(initialPage: selectedPage);
    super.initState();
  }


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: const DecorationImage(
          fit: BoxFit.cover,
          opacity:  0.2,
          image: AssetImage("assets/images/bg_pattern.png"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              spreadRadius: 5,
                              blurRadius: 10
                            )
                          ],
                          borderRadius: BorderRadius.circular(75)
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                            gradient: const LinearGradient(
                              colors: [
                                LightThemeColors.primaryColor,
                                LightThemeColors.secondaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                0.2, 1.0
                              ]
                            )
                          ),
                          padding: const EdgeInsets.all(22),
                          child: Image.asset("assets/images/sms_message.png", color: Colors.white,),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      Expanded(
                        child: PageView(
                              controller: pageController,
                             physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                              onPageChanged: (page) {
                                setState(() {
                                  selectedPage = page;
                                });
                              },
                              children: const [
                                PhoneBuild(),
                                OTPBuild(),
                              ],
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 60,
                              child: SmoothPageIndicator(
                                  controller: pageController,  // PageController
                                  count:  2,
                                  effect: ExpandingDotsEffect(
                                    dotHeight: 5,
                                    dotWidth: 20,
                                    activeDotColor: Theme.of(context).colorScheme.secondary,
                                  ),
                                  onDotClicked: (index){}
                              ),
                            ),
                            const Spacer(),
                            FloatingActionButton(
                              onPressed: (){
                                if(selectedPage == 0) {
                                  pageController.animateToPage(2,
                                      duration: const Duration(
                                          milliseconds: 250),
                                      curve: Curves.linear);
                                }else{
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) => const HomeView(),
                                      ));
                                }
                              },
                              elevation: 0,
                              child: const Icon(Icons.arrow_forward, color: Colors.white,),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                    ],
                  ),
            ),
          )
      ),
    );
  }
}

class OTPBuild extends StatelessWidget {
  const OTPBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "OTP sms sent to your phone",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        OtpTextField(
          numberOfFields: 4,
          borderColor: Theme.of(context).colorScheme.secondary,
          //set to true to show as box or false to show as dash
          showFieldAsBox: false,
          focusedBorderColor: Theme.of(context).colorScheme.secondary,
          //runs when a code is typed in
          // onCodeChanged: (String code) {
          //   //handle validation or checks here
          // },
          autoFocus: true,

          //runs when every textfield is filled
          onSubmit: (String verificationCode){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: const Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),
                  );
                }
            );
          }, // end onSubmit
        ),
        const SizedBox(height: 25,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Did not receive the code ?",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Text(
              " RESEND CODE",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Theme.of(context).colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 45,),
      ],
    );
  }
}

class PhoneBuild extends StatelessWidget {
  const PhoneBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Enter your mobile number to login or register",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        IntlPhoneField(
          decoration: const InputDecoration(
            //labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              counterText: "",
              hintText: "Your mobile number "
          ),
          initialCountryCode: 'PS',
          onChanged: (phone) {
            //print(phone.completeNumber);
          },
        ),
        const Spacer(),
        const SizedBox(height: 45,),
      ],
    );
  }
}
