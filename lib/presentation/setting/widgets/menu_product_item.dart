import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:possapp/core/components/buttins.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/core/constants/variables.dart';
import 'package:possapp/data/models/response/product_response_model.dart';

class MenuProductItem extends StatelessWidget {
  final Product data;
  const MenuProductItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 2,
            color: AppColors.blueLight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: CachedNetworkImage(
                imageUrl: '${Variables.imageBaseUrl}${data.image}',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.food_bank_outlined,
                  size: 80,
                ),
              )),
          const SpaceWidth(22.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SpaceHeight(5.0),
              Text(
                data.category,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 129, 129, 129),
                ),
              ),
              const SpaceHeight(10.0),
              Row(
                children: [
                  Flexible(
                    child: Button.outlined(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(16),
                                content: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SpaceHeight(10.0),
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${Variables.imageBaseUrl}${data.image}',
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.food_bank_rounded,
                                            size: 80,
                                          ),
                                          width: 80,
                                          height: 80,
                                        ),
                                      ),
                                      const SpaceHeight(10),
                                      Text(
                                        data.category,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(255, 85, 84, 84),
                                        ),
                                      ),
                                      const SpaceHeight(10),
                                      Text(
                                        data.price.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromARGB(255, 85, 84, 84),
                                        ),
                                      ),
                                      const SpaceHeight(10),
                                      Text(
                                        data.stock.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(255, 85, 84, 84),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      label: 'Detail',
                      fontSize: 8,
                      height: 31,
                    ),
                  ),
                  const SpaceHeight(6.0),
                  Flexible(
                    child: Button.outlined(
                      onPressed: () {
                        // context.push(EditProductPage(data: data));
                      },
                      label: 'Ubah Produk',
                      fontSize: 8,
                      height: 31,
                    ),
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
