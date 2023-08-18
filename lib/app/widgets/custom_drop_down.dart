import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/utils/app_colors.dart';
import '../../app/utils/helper.dart';

class CustomDropDown extends StatefulWidget {
  final double? width;
  final double? height;
  final String? headLine;
  final String dropDownHint;
  final TextStyle? dropDownHintTextStyle;
  String? selectedValue;
  final List<String> items;
  final Function(String value) onItemChanged;
  CustomDropDown({Key? key,this.width,this.height,this.selectedValue,this.headLine="",
    required this.dropDownHint,
    this.dropDownHintTextStyle,
    this.items=const [''],required  this.onItemChanged}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //selectedValue=widget.items.first;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width??double.infinity,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1.5,color: AppColors.grey9CABBC),
        color: AppColors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.headLine??"",
                style:  TextStyle(
                  fontSize:14.sp,
                  color: AppColors.grey9A9A9A,
                  fontFamily: fontRegular,
                  // fontFamily: "DIN-DEMI",
                ),
              ),
            ],
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children:  [
                    Expanded(
                      child: Text(
                        widget.dropDownHint,
                        style: widget.dropDownHintTextStyle??TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.green,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: widget.items
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      item,
                      style: widget.dropDownHintTextStyle??TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.green,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ))
                    .toList(),
                value: widget.selectedValue,
                onChanged: (value) {
                  setState(() {
                    widget.selectedValue = value as String;
                  });
                  widget.onItemChanged(value as String);
                },
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.black,
                ),
                iconSize: 24,
                alignment: Alignment.centerRight,
                iconEnabledColor: AppColors.grey9A9A9A,
                // buttonHeight: 48,
                // buttonWidth: 1000,
                buttonPadding: const EdgeInsets.only(left: 0, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: AppColors.green,
                ),
                buttonElevation: 0,
                itemHeight: 47,
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: 200,
                dropdownWidth: MediaQuery.of(context).size.width-64,
                dropdownPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.green,
                ),
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(0, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
