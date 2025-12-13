import 'package:flutter/material.dart';

/// Брейкпоинты для адаптивного дизайна
class Breakpoints {
  static const double mobile = 640;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double wide = 1280;
  static const double ultraWide = 1536;
}

/// Типы устройств
enum DeviceType {
  mobile,
  tablet,
  desktop,
  wide,
}

/// Адаптивный layout builder
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? wide;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
  });

  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= Breakpoints.wide) return DeviceType.wide;
    if (width >= Breakpoints.desktop) return DeviceType.desktop;
    if (width >= Breakpoints.tablet) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Breakpoints.tablet;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= Breakpoints.tablet && width < Breakpoints.desktop;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= Breakpoints.desktop;

  static bool isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= Breakpoints.wide;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= Breakpoints.wide) {
          return wide ?? desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= Breakpoints.desktop) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= Breakpoints.tablet) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// Адаптивное значение
class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;
  final T? wide;

  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
  });

  T getValue(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= Breakpoints.wide && wide != null) return wide!;
    if (width >= Breakpoints.desktop && desktop != null) return desktop!;
    if (width >= Breakpoints.tablet && tablet != null) return tablet!;
    return mobile;
  }
}

/// Адаптивный контейнер с padding
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? 1280,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? 24
            : isTablet
                ? 64
                : 120,
      ),
      child: child,
    );
  }
}

/// Адаптивная сетка
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final double runSpacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = 24,
    this.runSpacing = 24,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    final columns = isMobile
        ? mobileColumns
        : isTablet
            ? tabletColumns
            : desktopColumns;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children.map((child) {
            return SizedBox(
              width: itemWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}