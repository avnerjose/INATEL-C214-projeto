import 'package:books_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  const BookListItem(
      {Key? key,
      required this.title,
      required this.authors,
      required this.imageUrl,
      required this.averageRating})
      : super(key: key);

  final String title;
  final List<String> authors;
  final String imageUrl;
  final double averageRating;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: AppColors.dark,
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Image.network(imageUrl, height: 136),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(
                  authors.join(", "),
                  style:
                      const TextStyle(color: AppColors.lightGray, fontSize: 14),
                ),
                Text(
                  "Nota média: $averageRating/5.0",
                  style:
                      const TextStyle(color: AppColors.lightGray, fontSize: 14),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 56, vertical: 8),
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                      primary: Colors.white,
                      side: const BorderSide(color: Colors.white)),
                  child: const Text("Detalhes"),
                )
              ],
            ),
          )
        ]));
  }
}
