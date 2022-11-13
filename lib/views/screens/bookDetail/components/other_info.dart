import 'package:books_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class OtherInfo extends StatelessWidget {
  final String publisher;
  final String categories;

  const OtherInfo({Key? key, required this.publisher, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      color: AppColors.dark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Outras informações",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
          const SizedBox(height: 8),
          Text(
            '\u2022 Editora: $publisher',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            '\u2022 Categorias: $categories',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }
}
