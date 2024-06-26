import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gsy_github_app/widget/particle/particle_model.dart';
import 'package:gsy_github_app/widget/particle/particle_painter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged_dart/supercharged_dart.dart';

class ParticlesWidget extends StatefulWidget {
  final int numberOfParticles;

  const ParticlesWidget(this.numberOfParticles, {super.key});

  @override
  State<ParticlesWidget> createState() => _ParticlesWidgetState();
}

class _ParticlesWidgetState extends State<ParticlesWidget>
    with WidgetsBindingObserver {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    widget.numberOfParticles.times(() => particles.add(ParticleModel(random)));
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 从后台切回来时重置粒子
    if (state == AppLifecycleState.resumed) {
      for (var particle in particles) {
        particle.restart();
        particle.shuffle();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder(
      tween: ConstantTween(1),
      duration: const Duration(seconds: 1),
      builder: (context, child, dynamic _) {
        _simulateParticles();
        return CustomPaint(
          painter: ParticlePainter(particles),
        );
      },
    );
  }

  _simulateParticles() {
    for (var particle in particles) {
      particle.checkIfParticleNeedsToBeRestarted();
    }
  }
}
