import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageContent(BuildContext context) {
    return [
      _buildOnboardingPage(
          context,
          MyColor.putih,
          'Selamat Datang',
          'KonsulDok adalah aplikasi untuk membuat jadwal konsultasi dengan dokter. Temukan jadwal untuk konsultasi kesehatan Anda dengan dokter dengan mudah.',
          'assets/images/ob_welcome2.png'),
      _buildOnboardingPage(
          context,
          MyColor.putih,
          'Fitur Hebat',
          'Terdapat fitur cari dokter, penjadwalan janji, hingga pengelolaan profil pasien, yang dirancang untuk memberikan pengalaman yang efisien dan menyeluruh.',
          'assets/images/ob_fitur.png'),
      _buildOnboardingPage(
          context,
          MyColor.putih,
          'Mulai Sekarang',
          'Kemudahan Anda adalah prioritas kami. Mari kita mulai penjadwalan kesehatan yang lebih mudah dan lebih baik bersama KonsulDok.',
          'assets/images/ob_mulai2.png'),
    ];
  }

  Widget _buildOnboardingPage(BuildContext context, Color color, String title,
      String description, String imagepath) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.sizeOf(context).height * 55 / 100,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 100,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [MyColor.putihForm, MyColor.putih],
                    )),
                  ),
                ),
                Positioned(
                  // top: 350,
                  top: MediaQuery.sizeOf(context).width * 2 / 7,
                  left: MediaQuery.sizeOf(context).width * 1 / 7,
                  child: Container(
                    height: MediaQuery.sizeOf(context).width * 5 / 7,
                    width: MediaQuery.sizeOf(context).width * 5 / 7,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagepath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //     decoration: BoxDecoration(
                    // gradient: MyColor.gradientBiru,)
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xff67C6E3), Color(0xff378CE7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds),
            child: Text(
              title,
              style: MyTextStyle.onboard.copyWith(color: MyColor.putih),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(
              description,
              style: const TextStyle(fontFamily: 'outfit', fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: isCurrentPage ? 12.0 : 8.0,
      width: isCurrentPage ? 12.0 : 8.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isCurrentPage
              ? [const Color(0xff67C6E3), const Color(0xff378CE7)]
              : [MyColor.abuForm, MyColor.abuForm],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _onSkip() {
    _pageController.animateToPage(
      _buildPageContent(context).length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _onNext() {
    if (_currentPage < _buildPageContent(context).length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      // Navigasi ke layar beranda atau layar lain setelah onboarding selesai
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _buildPageContent(context).length,
            itemBuilder: (context, index) {
              return _buildPageContent(context)[index];
            },
          ),
          Positioned(
            bottom: 30.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: List.generate(
                        _buildPageContent(context).length,
                        (index) => _buildPageIndicator(index == _currentPage),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: _onNext,
                    //   child: Text('Berikutnya',
                    //       style: TextStyle(color: Colors.blue)),
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                myButtonWidget(text: "Berikutnya", onTap: _onNext),
                TextButton(
                  onPressed: _onSkip,
                  child: const Text('Lewati',
                      style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 14,
                          color: Colors.blue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
