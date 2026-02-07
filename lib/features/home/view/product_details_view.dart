import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:matjar/features/home/cubit/product_cubit.dart';
import 'package:matjar/features/home/data/product_model.dart';
import 'package:matjar/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late String currentTitle;
  late int currentPrice;

  final TextEditingController _editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentTitle = widget.product.title ?? "No Title";
    currentPrice = widget.product.price ?? 0;
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage((widget.product.images!.first)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: currentTitle,
                      size: 22,
                      weight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showEditDialog("Title", currentTitle, false);
                    },
                    icon: const Icon(Icons.edit, color: Colors.blue),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  CustomText(
                    text: "\$$currentPrice",
                    size: 20,
                    weight: FontWeight.w600,
                    color: Colors.green,
                  ),
                  const Gap(10),
                  IconButton(
                    onPressed: () {
                      showEditDialog("Price", currentPrice.toString(), true);
                    },
                    icon: const Icon(Icons.edit, color: Colors.blue),
                  ),
                ],
              ),
              const Gap(20),
              const Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Gap(5),
              Text(
                widget.product.description ?? "No description available",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void showEditDialog(String fieldName, String currentValue, bool isPrice) {
    _editController.text = currentValue;
    final cubit = context.read<ProductCubit>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update $fieldName"),
          content: TextField(
            controller: _editController,
            keyboardType: isPrice ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: "Enter new $fieldName",
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newValue = _editController.text;
                if (newValue.isNotEmpty) {
                  Navigator.pop(context);
                  setState(() {
                    if (isPrice) {
                      currentPrice = int.tryParse(newValue) ?? currentPrice;
                    } else {
                      currentTitle = newValue;
                    }
                  });
                  if (isPrice) {
                    cubit.updateProduct(
                      widget.product.id!,
                      price: int.tryParse(newValue) ?? 0,
                    );
                  } else {
                    cubit.updateProduct(widget.product.id!, title: newValue);
                  }
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
