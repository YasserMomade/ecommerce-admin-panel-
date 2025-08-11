import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utility/constants.dart';

class SubCategoryHeader extends StatelessWidget {
  const SubCategoryHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Row(
    children:  [
      Text("Sub Category",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey [900],
        ),
      ),
      Spacer(flex: 2),
      Expanded(
        child: SearchField(
          onChange: (val) {
            context.dataProvider.filterSubCategories(val);
          },
        ),
      ),
      ProfileCard()
    ],
  );
}
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: Row(
        children:  [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile_pic.png"),
            radius: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Text(
              "Yasmin Momade",
              style: TextStyle(
                color: Colors.blueGrey [900],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.blueGrey [700]),
        ],
      ),
    );
  }
}


class SearchField extends StatelessWidget {
  final Function(String) onChange;

  const SearchField({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey [600]),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade100),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade100),
          borderRadius: BorderRadius.circular(12),
        ),

        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding  * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg", color: Colors.white),
          ),
        ),
      ),
      onChanged: (value) {
        onChange(value);
      },
    );
  }
}
