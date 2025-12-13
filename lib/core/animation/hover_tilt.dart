import 'package:flutter/material.dart';


/// 3D Tilt эффект при наведении мыши
class HoverTilt extends StatefulWidget {
  final Widget child;
  final double maxTilt;
  final Duration duration;
  final bool enableScale;
  final double scaleValue;
  final bool enableShadow;

  const HoverTilt({
    super.key,
    required this.child,
    this.maxTilt = 0.05,
    this.duration = const Duration(milliseconds: 200),
    this.enableScale = true,
    this.scaleValue = 1.02,
    this.enableShadow = true,
  });

  @override
  State<HoverTilt> createState() => _HoverTiltState();
}

class _HoverTiltState extends State<HoverTilt>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _pointerPosition = Offset.zero;
  Size _widgetSize = Size.zero;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateTilt(PointerEvent details) {
    if (!mounted) return;
    
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    
    _widgetSize = box.size;
    final localPosition = box.globalToLocal(details.position);
    
    setState(() {
      _pointerPosition = Offset(
        (localPosition.dx - _widgetSize.width / 2) / (_widgetSize.width / 2),
        (localPosition.dy - _widgetSize.height / 2) / (_widgetSize.height / 2),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final tiltX = _isHovered ? _pointerPosition.dy * widget.maxTilt : 0.0;
    final tiltY = _isHovered ? -_pointerPosition.dx * widget.maxTilt : 0.0;
    final scale = _isHovered && widget.enableScale ? widget.scaleValue : 1.0;

    return MouseRegion(
      onEnter: (event) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (event) {
        setState(() {
          _isHovered = false;
          _pointerPosition = Offset.zero;
        });
        _controller.reverse();
      },
      onHover: _updateTilt,
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(tiltX)
          ..rotateY(tiltY)
          ..scale(scale),
        transformAlignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}

/// Простой hover эффект с подъёмом
class HoverLift extends StatefulWidget {
  final Widget child;
  final double liftAmount;
  final Duration duration;
  final double scaleAmount;

  const HoverLift({
    super.key,
    required this.child,
    this.liftAmount = 8,
    this.duration = const Duration(milliseconds: 200),
    this.scaleAmount = 1.02,
  });

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -widget.liftAmount : 0.0)
          ..scale(_isHovered ? widget.scaleAmount : 1.0),
        child: widget.child,
      ),
    );
  }
}

/// Магнитный эффект - элемент следует за курсором
class MagneticHover extends StatefulWidget {
  final Widget child;
  final double magneticForce;
  final Duration duration;

  const MagneticHover({
    super.key,
    required this.child,
    this.magneticForce = 0.3,
    this.duration = const Duration(milliseconds: 150),
  });

  @override
  State<MagneticHover> createState() => _MagneticHoverState();
}

class _MagneticHoverState extends State<MagneticHover> {
  Offset _offset = Offset.zero;
  bool _isHovered = false;

  void _updateOffset(PointerEvent details) {
    if (!mounted) return;
    
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    
    final size = box.size;
    final localPosition = box.globalToLocal(details.position);
    
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    final deltaX = (localPosition.dx - centerX) * widget.magneticForce;
    final deltaY = (localPosition.dy - centerY) * widget.magneticForce;
    
    setState(() {
      _offset = Offset(deltaX, deltaY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) {
        setState(() {
          _isHovered = false;
          _offset = Offset.zero;
        });
      },
      onHover: _updateOffset,
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
        child: widget.child,
      ),
    );
  }
}

/// Пульсирующий hover эффект
class PulseHover extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final Duration duration;

  const PulseHover({
    super.key,
    required this.child,
    this.minScale = 1.0,
    this.maxScale = 1.05,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<PulseHover> createState() => _PulseHoverState();
}

class _PulseHoverState extends State<PulseHover>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: widget.minScale, end: widget.maxScale)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: widget.maxScale, end: widget.minScale)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.repeat();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.stop();
        _controller.reset();
      },
      child: ScaleTransition(
        scale: _isHovered ? _scaleAnimation : AlwaysStoppedAnimation(1.0),
        child: widget.child,
      ),
    );
  }
}

/// Glow эффект при наведении
class GlowHover extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double glowRadius;

  const GlowHover({
    super.key,
    required this.child,
    required this.glowColor,
    this.glowRadius = 20,
  });

  @override
  State<GlowHover> createState() => _GlowHoverState();
}

class _GlowHoverState extends State<GlowHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.glowColor.withOpacity(0.5),
                    blurRadius: widget.glowRadius,
                    spreadRadius: widget.glowRadius / 4,
                  ),
                ]
              : null,
        ),
        child: widget.child,
      ),
    );
  }
}