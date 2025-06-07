// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';

mixin SplashMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  void init(TickerProvider vsync, BuildContext context) {
    // Animasyon denetleyicisini oluştur
    controller = AnimationController(
      duration: const Duration(seconds: 1), // Döngü süresi
      vsync: vsync,
    );

    // İlk animasyonu tanımla (sürekli döngü için)
    _setLoopingAnimation();

    // Döngüyü başlat
    controller.repeat();

    // API isteğini başlat
    _simulateApiRequest(context);
  }

  void _setLoopingAnimation() {
    scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.5, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.5)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
    ]).animate(controller);
  }

  void _setFinalAnimation() {
    scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 40.0,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(controller);
  }

  Future<void> _simulateApiRequest(BuildContext context) async {
    // API isteği simülasyonu

    await Future.delayed(const Duration(seconds: 2));

    // Döngüyü durdur ve son animasyonu başlat
    controller.stop();
    controller.reset();

    // Yeni animasyonu ata
    _setFinalAnimation();

    // Yeni animasyonu başlat
    controller.duration = const Duration(
      milliseconds: 500,
    ); // Son animasyon süresi
    controller.forward();
    await Future.delayed(const Duration(milliseconds: 250));
    GoRouter.of(context).pushReplacementNamed(RouteConstants().welcome);
  }
}
