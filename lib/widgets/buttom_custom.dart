import 'package:flutter/material.dart';
import 'package:hotelio_app/config/app.color.dart';

class ButtomCustom extends StatelessWidget {
  const ButtomCustom({
    super.key,
    required this.label,
    required this.onTap,
    this.isExpanded,
  });

  final String label;
  final Function onTap;
  final bool? isExpanded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0, 0.7),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.primary,
                    offset: Offset(0, 5),
                    blurRadius: 16,
                  )
                ],
              ),
              width: isExpanded == null
                  ? null
                  : isExpanded!
                      ? double.infinity
                      : null,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(label),
            ),
          ),
          Align(
            child: Material(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => onTap(),
                child: Container(
                  width: isExpanded == null
                      ? null
                      : isExpanded!
                          ? double.infinity
                          : null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 12,
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
