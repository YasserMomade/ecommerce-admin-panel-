import '../../../models/category.dart';
import '../provider/category_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_text_field.dart';


class CategorySubmitForm extends StatelessWidget {
  final Category? category;
  const CategorySubmitForm({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Caso de editar
    context.categoryProvider.setDataForUpdateCategory(category);

    return SingleChildScrollView(
      child: Form(
        key: context.categoryProvider.addCategoryFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6FA), // ← branco acinzentado
            borderRadius: BorderRadius.circular(16.0),

            border: Border.all(color: Colors.blueGrey.shade100),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category == null ? "New Category" : "Edit Category",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                ),
              ),
              Gap(defaultPadding * 1.5),


              Consumer<CategoryProvider>(
                builder: (context, catProvider, child) {
                  return Center(
                    child: SizedBox(
                      width: 180, // ⬆️ levemente maior
                      height: 180,
                      child: CategoryImageCard(
                        labelText: "Category Image",
                        imageFile: catProvider.selectedImage,
                        imageUrlForUpdateImage: category?.image,
                        onTap: () {
                          catProvider.pickImage();
                        },
                      ),
                    ),
                  );
                },
              ),

              Gap(defaultPadding * 1.5),
              CustomTextField(
                controller: context.categoryProvider.categoryNameCtrl,
                labelText: 'Category Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              Gap(defaultPadding * 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blueGrey,
                      side: BorderSide(color: Colors.blueGrey.shade300),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (context.categoryProvider.addCategoryFormKey.currentState!.validate()) {
                        context.categoryProvider.addCategoryFormKey.currentState!.save();
                        context.categoryProvider.submitcategory();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showAddCategoryForm(BuildContext context, Category? category) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent, // ← mantém fundo sem camada escura
        contentPadding: const EdgeInsets.all(16),
        content: CategorySubmitForm(category: category),
      );
    },
  );
}
