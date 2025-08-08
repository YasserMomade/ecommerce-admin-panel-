import '../../../core/data/data_provider.dart';
import '../../../models/sub_category.dart';
import 'add_sub_category_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../category/components/add_category_form.dart';


class SubCategoryListSection extends StatelessWidget {
  const SubCategoryListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueGrey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All SubCategory",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF11182C),
            ),
          ),
          const SizedBox(height: defaultPadding),
          _buildTableHeader(),
          const SizedBox(height: 8),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              final subCategories = dataProvider.subCategories;
              if (subCategories.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Text(
                      'No Subcategories available.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              }

              return Column(
                children: List.generate(
                  subCategories.length,
                      (index) => _buildSubcategoryRow(
                    context,
                        subCategories: subCategories[index],
                    onEdit: () {
                      showAddSubCategoryForm(context, dataProvider.subCategories[index]);
                    },
                    onDelete: () {
                      //TODO: should complete call deleteSubCategory
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A4DA3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text("SubCategory Name",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text("Category",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("Added Date",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("Edit",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("Delete",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSubcategoryRow(
      BuildContext context, {
        required SubCategory subCategories,
        required VoidCallback onEdit,
        required VoidCallback onDelete,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [

                Text(
                  subCategories.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              subCategories.createdAt ?? '',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.indigo),
                onPressed: onEdit,
                tooltip: "Edit subCategory",
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
                tooltip: "Delete subCategory",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
