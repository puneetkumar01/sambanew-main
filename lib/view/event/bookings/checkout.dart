import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sambanew/theme/apptheme.dart';
import 'package:sambanew/view/event/bookings/order_summary.dart';
import '../../../components/button.dart';
import '../../../components/small_input_field.dart';
import '../../../controller/eventController.dart';
import '../../../controller/ticketsController.dart';
import '../../../service/date_converter.dart';
import '../../../service/shared_pref.dart';
import 'components/event_header.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getData();
    final ticketController = Get.find<TicketController>();

    if (Get.arguments != null) {
      final arguments = Get.arguments;
      if (arguments['data'] == "login") {
        Future.delayed(const Duration(milliseconds: 400), () {
          filldetails();
        });
      }
    }
  }

  Widget tabBarViewContent(int currentTabIndex) {
    List content;
    final ticketController = Get.find<TicketController>();
    content = ticketController.dynamicJsonList.map((form) {
      int formIndex = ticketController.dynamicJsonList.indexOf(form);
      return buildForm(form, formIndex);
    }).toList();
    return content[currentTabIndex];
  }

  void _saveForms() {
    bool allValid = true;

    // Initialize an empty map to store the attendees' responses
    Map<String, Map<String, dynamic>> attendees = {};

    for (var i = 0; i < Get.find<TicketController>().formKeys.length; i++) {
      //  Validate each form
      // if (Get.find<TicketController>().formValues[i].isEmpty) {
      //   Get.find<TicketController>().tabController.index = i;
      //   setState(() {});
      //   Future.delayed(Duration(milliseconds: 400), () {
      //     Get.find<TicketController>().formKeys[i].currentState!.validate();
      //   });

      //   allValid = false;

      //   break;
      //   //}
      // } else {
      List<dynamic> dynamicCheckout = jsonDecode(
          Get.find<TicketController>().dynamicJsonList[i]['dynamicCheckout']);

      // Get.find<TicketController>().formValues[i].forEach((key, value) {
      // Check if the value is null, an empty string, an empty list, or false (for checkboxes)
      for (var field in dynamicCheckout) {
        String fieldName = field['label'];
        bool isRequired = field['Required'] ?? false;
        // if (value == null ||
        //     value == '' ||
        //     (value is List && value.isEmpty) ||
        //     (value is bool && value == false)) {
        if (isRequired &&
            (Get.find<TicketController>().formValues[i][fieldName] == null ||
                Get.find<TicketController>().formValues[i][fieldName] == '' ||
                (Get.find<TicketController>().formValues[i][fieldName]
                        is List &&
                    Get.find<TicketController>()
                        .formValues[i][fieldName]
                        .isEmpty) ||
                (Get.find<TicketController>().formValues[i][fieldName]
                        is bool &&
                    Get.find<TicketController>().formValues[i][fieldName] ==
                        false))) {
          Get.find<TicketController>().tabController.index = i;
          setState(() {});

          Future.delayed(const Duration(seconds: 1), () {
            Get.find<TicketController>().formKeys[i].currentState!.validate();
          });
          allValid = false;
        }
      }
      if (!allValid) {
        break;
      }

      // Get.find<TicketController>().formKeys[i].currentState!.save();

      //  Build each attendee's response
      String attendeeKey =
          'attendee_${i + 1}'; // e.g., attendee_1, attendee_2, etc.
      attendees[attendeeKey] = Get.find<TicketController>()
          .formValues[i]; // Save form values for each attendee

      //  Add the ticket name for each attendee
      attendees[attendeeKey]!["Ticket"] =
          Get.find<TicketController>().dynamicJsonList[i]['ticketName'];
    }

    if (allValid) {
      // Convert the attendees map to JSON format
      String dynamicCheckoutJson = jsonEncode(attendees);
      Get.find<TicketController>().dynamicJsonCheckoutJson =
         "["+ dynamicCheckoutJson+']';
      setState(() {});
      print('DynamicCheckoutJson: $dynamicCheckoutJson');
      if (Get.find<TicketController>().error == "" &&
          Get.find<TicketController>().error1 == "") {
        Get.to(
          const OrderSummary(),
          transition: Transition.rightToLeft,
        );
        // controller.applyPromo(
        //     "0", events.first.eventInfo!.eventId);
      }
      // Now you can use dynamicCheckoutJson to submit to the server or perform any other actions
    }
  }

  Future<void> getData() async {
    // Get instances of your controllers
    final ticketController = Get.find<TicketController>();
    final eventController = Get.find<Eventcontroller>();

    // First, apply the promo code
    ticketController.applyPromo(
        "0", // Pass your promo code here
        eventController.eventData.first.eventInfo!.eventId,
        1 // Pass the event ID here
        );

    // After successfully applying the promo, fetch the dynamic JSON
    //
  }

  filldetails() {
    if (PreferenceUtils.isLoggedIn()) {
      Get.find<TicketController>().name.text =
          PreferenceUtils.getString("name");
      Get.find<TicketController>().email.text =
          PreferenceUtils.getString("email");
      Get.find<TicketController>().cnemail.text =
          PreferenceUtils.getString("email");
      Get.find<TicketController>().mobile.text =
          PreferenceUtils.getString("mobile") == "null"
              ? ""
              : PreferenceUtils.getString("mobile");
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = Get.find<Eventcontroller>().eventData;
    var height = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: GetBuilder<TicketController>(builder: (controller) {
        return !controller.isloadedDynamic
            ? Scaffold(
                body: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(50)),
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/preloader.gif',
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
              backgroundColor: Get.theme.cardColor,
              body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height + 20.h,
                        ),
                        HeaderEvent(
                          title: events.first.eventInfo!.eventName!,
                          ontap: () {
                            Get.back();
                          },
                          date:
                              "${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.startDate.toString()))} at ${events.first.eventInfo!.startTime.toString()} - ${DateConverter.formatDate(DateTime.parse(events.first.eventInfo!.endDate.toString()))} at ${events.first.eventInfo!.endTime.toString()}",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        if (!PreferenceUtils.isLoggedIn())
                          InkWell(
                            onTap: () {
                              PreferenceUtils.setString(
                                  "lastPage", "eventdetails");
                              Get.toNamed("/login")!.then(
                                (value) {
                                  print(value);
                                  if (value != 1) {
                                    filldetails();
                                  }
                                },
                              );
                            },
                            child: Container(
                                height: 40,
                                width: Get.width / 2.2,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IntrinsicHeight(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Align(
                                        child: Text(
                                          "HAVE AN ACCOUNT? ".tr,
                                          style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color:
                                                  AppTheme.whiteBackgroundColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Positioned(
                                          right: 10,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 18,
                                            color: AppTheme.whiteBackgroundColor,
                                          )),
                                    ],
                                  ),
                                )),
                          ),
                        if (!PreferenceUtils.isLoggedIn())
                          const SizedBox(
                            height: 20,
                          ),
                        if (!PreferenceUtils.isLoggedIn())
                          Text(
                            "or".tr,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        if (!PreferenceUtils.isLoggedIn())
                          const SizedBox(
                            height: 20,
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Checkout".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 24),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              if (controller.dynamicJsonList.isNotEmpty)
                                Container(
                                  color: Get.theme.cardColor,
                                  alignment: Alignment.topLeft,
                                  child: TabBar(
                                      controller: Get.find<TicketController>()
                                          .tabController,
                                      indicatorColor: AppTheme.primaryColor,
                                      dividerColor: Colors.transparent,
                                      tabAlignment: TabAlignment.start,
                                      onTap: (value) {
                                        controller.tabController.index = value;
                                        setState(() {});
                                        //\\\  controller.selectIndex(value, profileList[0].data!.uuid.toString());
                                      },
                                      isScrollable: true,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      padding: EdgeInsets.zero,
                                      indicatorPadding: EdgeInsets.zero,
                                      labelPadding:
                                          const EdgeInsets.only(right: 20, left: 0),
                                      tabs: List.generate(
                                        controller.dynamicJsonList.length,
                                        (index) {
                                          return Tab(
                                              text: "Attendee ${index + 1}");
                                        },
                                      )),
                                ),
                              SizedBox(
                                height: 15.h,
                              ),
                              if (controller.dynamicJsonList.isNotEmpty)
                                tabBarViewContent(Get.find<TicketController>()
                                    .tabController
                                    .index),
                              SizedBox(
                                height: 15.h,
                              ),
                              // ConstrainedBox(
                              //   constraints: BoxConstraints(
                              //     minHeight:
                              //         400, // Adjust this based on the expected content size
                              //   ),
                              //   child: IntrinsicHeight(
                              //     // This allows dynamic height
              
                              //     child: TabBarView(
                              //       controller: Get.find<TicketController>()
                              //           .tabController,
                              //       children:
                              //           controller.dynamicJsonList.map((form) {
                              //         int formIndex = controller.dynamicJsonList
                              //             .indexOf(form);
                              //         return buildForm(form, formIndex);
                              //       }).toList(),
                              //     ),
                              //   ),
                              // ),
                              Text(
                                "Enter Your contact details".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("name".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!),
                                      MySmallTextField(
                                          hintText: "Name",
                                          textEditingController: controller.name,
                                          validation: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'full_name_is_required'.tr;
                                            }
                                            return null;
                                          },
                                          color: const Color(0xff585A60)),
                                    ],
                                  )),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("mobile".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!),
                                      MySmallTextField(
                                          hintText: "mobile".tr,
                                          textEditingController:
                                              controller.mobile,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          validation: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Mobile is required";
                                            }
                                            return null;
                                          },
                                          color: const Color(0xff585A60)),
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text("email_address".tr,
                                  style: Theme.of(context).textTheme.bodySmall!),
                              MySmallTextField(
                                  hintText: "email_address".tr,
                                  textEditingController: controller.email,
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'email_is_required'.tr;
                                    } else if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'enter_valid_email'.tr;
                                    }
                                    return null;
                                  },
                                  color: const Color(0xff585A60)),
                              const SizedBox(
                                height: 6,
                              ),
                              Text("confirm_email_address".tr,
                                  style: Theme.of(context).textTheme.bodySmall!),
                              MySmallTextField(
                                  hintText: "confirm_email_address".tr,
                                  textEditingController: controller.cnemail,
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'email_is_required'.tr;
                                    } else if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'enter_valid_email'.tr;
                                    }
                                    return null;
                                  },
                                  color: const Color(0xff585A60)),
                              Transform.translate(
                                offset: const Offset(-12, 0),
                                child: ListTileTheme(
                                  horizontalTitleGap: 0,
                                  contentPadding: EdgeInsets.zero,
                                  child: CheckboxListTile(
                                    visualDensity: VisualDensity.compact,
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Text(
                                        'I’d like to know about more events from this organizer!'
                                            .tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              fontSize: 12,
                                            ),
                                      ),
                                    ),
                                    value: controller.knowEvant,
                                    onChanged: (bool? value) {
                                      controller.onChangKnowEvent(value);
                                      // if (value == true) {
                                      //   if (_controller.educationCloseDate.text !=
                                      //       null) {
                                      //     _controller.educationCloseDate.clear();
                                      //   }
                                      // }
                                      // _controller.educationDurationCheckbox(value);
                                    },
                                  ),
                                ),
                              ),
                              Text(controller.error,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 12,
                                          height: 0,
                                          color: Colors.red)),
                              Transform.translate(
                                offset: const Offset(-12, 0),
                                child: ListTileTheme(
                                  horizontalTitleGap: 0,
                                  contentPadding: EdgeInsets.zero,
                                  child: CheckboxListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal: -4.0, vertical: -4.0),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Text(
                                        'Send me emails about all the new, best events happening!'
                                            .tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                    value: controller.sendMail,
                                    onChanged: (bool? value) {
                                      controller.onChangeSendMail(value);
                                      // if (value == true) {
                                      //   if (_controller.educationCloseDate.text !=
                                      //       null) {
                                      //     _controller.educationCloseDate.clear();
                                      //   }
                                      // }
                                      // _controller.educationDurationCheckbox(value);
                                    },
                                  ),
                                ),
                              ),
                              Text(controller.error1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 12,
                                          height: 0,
                                          color: Colors.red)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Button(
                            tittle: "Checkout".toUpperCase().tr,
                            tap: () {
                              if (controller.dynamicJsonList.isEmpty) {
                                if (_formKey.currentState!.validate()) {
                                  //  controller.onCheckheckout();
                                  if (controller.error == "" &&
                                      controller.error1 == "") {
                                    Get.to(
                                      const OrderSummary(),
                                      transition: Transition.rightToLeft,
                                    );
                                    // controller.applyPromo(
                                    //     "0", events.first.eventInfo!.eventId);
                                  }
                                  // Get.to(
                                  //   OrderSummary(),
                                  //   transition: Transition.rightToLeft,
                                  // );
                                }
                              } else {
                                _formKey.currentState!.validate();
                                _saveForms();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            );
      }),
    );
  }

  Widget buildForm(dynamic form, int formIndex) {
    List<dynamic> dynamicCheckout = jsonDecode(form['dynamicCheckout']);

    return Get.find<TicketController>().formKeys.isNotEmpty
        ? Form(
            key: Get.find<TicketController>().formKeys[formIndex],
            child: Column(
              children: dynamicCheckout
                  .map((field) => buildFormField(field, formIndex))
                  .toList(),
            ),
          )
        : Container();
  }

  Widget buildFormField(dynamic field, int formIndex) {
    switch (field['type']) {
      case 'select':
        return buildDropdownField(field, formIndex);
      case 'text':
        return buildTextField(field, formIndex);
      case 'multiselect':
        return buildMultiDropdownField(field, formIndex);
      case 'date':
        return buildDateField(field, formIndex);
      case 'checkbox':
        return Transform.translate(
          offset: const Offset(-12, 0),
          child: ListTileTheme(
            horizontalTitleGap: 0,
            contentPadding: EdgeInsets.zero,
            child: CheckboxListTile(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  field['label'],
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 14,
                      ),
                ),
              ),
              value: Get.find<TicketController>().formValues[formIndex]
                  [field['label']]=="true"?true:false,
              onChanged: (bool? value) {
                Get.find<TicketController>().formValues[formIndex]
                    [field['label']] = value.toString();
                setState(() {});
                //controller.onChangKnowEvent(value);
                // if (value == true) {
                //   if (_controller.educationCloseDate.text !=
                //       null) {
                //     _controller.educationCloseDate.clear();
                //   }
                // }
                // _controller.educationDurationCheckbox(value);
              },
            ),
          ),
        );
      default:
        return Container();
    }
  }

  List<String> selectedItems = []; // Pre-selected items if any
  Widget buildTextField(dynamic field, int formIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 6,
        ),
        Text(field['label'], style: Theme.of(context).textTheme.bodySmall!),
        MySmallTextField(
            hintText: "Enter " + field['label'],
            textEditingController: TextEditingController(
                text: Get.find<TicketController>().formValues[formIndex]
                    [field['label']]),
            onChanged: (value) {
              // setState(() {
              Get.find<TicketController>().formValues[formIndex]
                  [field['label']] = value;
              // });
              //  setState(() {

              //  });
            },
            validation: (value) {
              if (field['Required'] && value == "") {
                return 'Required';
              }
              return null;
            },
            color: const Color(0xff585A60)),
      ],
    );
    // return DropdownButtonFormField<String>(
    //   decoration: InputDecoration(labelText: field['label']),
    //   items: options
    //       .map((option) => DropdownMenuItem<String>(
    //             value: option,
    //             child: Text(option),
    //           ))
    //       .toList(),
    //   onChanged: (value) {
    //     setState(() {
    //       Get.find<TicketController>().formValues[formIndex][field['label']] =
    //           value;
    //     });
    //   },
    //   validator: (value) {
    //     if (field['Required'] && value == null) {
    //       return 'This field is required';
    //     }
    //     return null;
    //   },
    //   onSaved: (value) {
    //     Get.find<TicketController>().formValues[formIndex][field['label']] =
    //         value;
    //   },
    // );
  }

  Widget buildDropdownField(dynamic field, int formIndex) {
    List<String> options = [];

    if (field['options'] != null &&
        field['options'] is String &&
        (field['options'] as String).isNotEmpty) {
      options = (field['options'] as String)
          .split(',')
          .where((option) => option.trim().isNotEmpty)
          .toList();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 6,
        ),
        Text(field['label'], style: Theme.of(context).textTheme.bodySmall!),
        MySmallTextField(
            hintText: "Select " + field['label'],
            textEditingController: TextEditingController(
                text: Get.find<TicketController>().formValues[formIndex]
                    [field['label']]),
            readOnly: true,
            ontap: () {
              showModal(context, options, "format_name", (value) {
                setState(() {
                  Get.find<TicketController>().formValues[formIndex]
                      [field['label']] = value;
                });
              }, (value) {
                // formatId = mediumList[0][value]["format_id"].toString();
                setState(() {});
              },
                  Get.find<TicketController>().formValues[formIndex]
                      [field['label']]);

              // showMultiSelectModal(
              //   context,
              //   options,
              //   selectedItems,
              //   (List<String> updatedSelection) {
              //     print("Selected items: $updatedSelection");
              //     // Handle the updated list of selected items here
              //   },
              // );
            },
            onChanged: (value) {
              setState(() {
                Get.find<TicketController>().formValues[formIndex]
                    [field['label']] = value;
              });
            },
            validation: (value) {
              if (field['Required'] && value == "") {
                return 'Required';
              }
              return null;
            },
            icon: const Icon(Icons.arrow_drop_down),
            color: const Color(0xff585A60)),
      ],
    );
    // return DropdownButtonFormField<String>(
    //   decoration: InputDecoration(labelText: field['label']),
    //   items: options
    //       .map((option) => DropdownMenuItem<String>(
    //             value: option,
    //             child: Text(option),
    //           ))
    //       .toList(),
    //   onChanged: (value) {
    //     setState(() {
    //       Get.find<TicketController>().formValues[formIndex][field['label']] =
    //           value;
    //     });
    //   },
    //   validator: (value) {
    //     if (field['Required'] && value == null) {
    //       return 'This field is required';
    //     }
    //     return null;
    //   },
    //   onSaved: (value) {
    //     Get.find<TicketController>().formValues[formIndex][field['label']] =
    //         value;
    //   },
    // );
  }

  Widget buildDateField(dynamic field, int formIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 6,
        ),
        Text(field['label'], style: Theme.of(context).textTheme.bodySmall!),
        MySmallTextField(
            hintText: "Select " + field['label'],
            textEditingController: TextEditingController(
                text: Get.find<TicketController>().formValues[formIndex]
                    [field['label']]),
            readOnly: true,
            ontap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));

              print(pickedDate);
             if(pickedDate!=null){
               String formattedDate =
               DateFormat('dd-MMM-yyyy').format(pickedDate);
               print(formattedDate);
               Get.find<TicketController>().formValues[formIndex]
               [field['label']] = formattedDate;
             }

              // availablesDates.text =
              //     formattedDate; //set output date to TextField value.
              setState(() {});
                        },
            validation: (value) {
              if (field['Required'] && value == "") {
                return 'Required';
              }
              return null;
            },
            icon: const Icon(Icons.calendar_today),
            color: const Color(0xff585A60)),
      ],
    );
    // return DropdownButtonFormField<String>(
    //   decoration: InputDecoration(labelText: field['label']),
    //   items: options
    //       .map((option) => DropdownMenuItem<String>(
    //             value: option,
    //             child: Text(option),
    //           ))
    //       .toList(),
    //   onChanged: (value) {
    //     setState(() {
    //       Get.find<TicketController>().formValues[formIndex][field['label']] =
    //           value;
    //     });
    //   },
    //   validator: (value) {
    //     if (field['Required'] && value == null) {
    //       return 'This field is required';
    //     }
    //     return null;
    //   },
    //   onSaved: (value) {
    //     Get.find<TicketController>().formValues[formIndex][field['label']] =
    //         value;
    //   },
    // );
  }

  Widget buildMultiDropdownField(dynamic field, int formIndex) {
    List<String> options = [];

    if (field['options'] != null &&
        field['options'] is String &&
        (field['options'] as String).isNotEmpty) {
      options = (field['options'] as String)
          .split(',')
          .where((option) => option.trim().isNotEmpty)
          .toList();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 6,
        ),
        Text(field['label'], style: Theme.of(context).textTheme.bodySmall!),
        MySmallTextField(
            hintText: "Select ${field['label']}",
            textEditingController: TextEditingController(
                text:  Get.find<TicketController>().formValues[formIndex]
                    [field['label']].isEmpty?"":Get.find<TicketController>().formValues[formIndex]
                    [field['label'].toString()].toString()),
            readOnly: true,
            ontap: () {
              showMultiSelectModal(
                context,
                options,
                Get.find<TicketController>().formValues[formIndex]
                    [field['label']],
                (List<String> updatedSelection) {
                  print("Selected items: $updatedSelection");
                  Get.find<TicketController>().formValues[formIndex]
                          [field['label']] =
                      updatedSelection.isEmpty
                          ? []
                          : updatedSelection;
                  setState(() {});
                  // Handle the updated list of selected items here
                },
              );
            },
            onChanged: (value) {
              setState(() {
                Get.find<TicketController>().formValues[formIndex]
                    [field['label']] = value;
              });
            },
            validation: (value) {
              if (field['Required'] && value == "") {
                return 'Required';
              }
              return null;
            },
            icon: const Icon(Icons.arrow_drop_down),
            color: const Color(0xff585A60)),
      ],
    );
    // return DropdownButtonFormField<String>(
    //   decoration: InputDecoration(labelText: field['label']),
    //   items: options
    //       .map((option) => DropdownMenuItem<String>(
    //             value: option,
    //             child: Text(option),
    //           ))
    //       .toList(),
    //   onChanged: (value) {
    //     setState(() {
    //       Get.find<TicketController>().formValues[formIndex][field['label']] =
    //           value;
    //     });
    //   },
    //   validator: (value) {
    //     if (field['Required'] && value == null) {
    //       return 'This field is required';
    //     }
    //     return null;
    //   },
    //   onSaved: (value) {
    //     Get.find<TicketController>().formValues[formIndex][field['label']] =
    //         value;
    //   },
    // );
  }

  showModal(context, List items, String? key, final ValueChanged<String> update,
      final ValueChanged<int> indexselct,
      [String? selValue]) {
    String? val;
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0.r),
            topRight: Radius.circular(10.0.r),
          ),
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        // useSafeArea: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                //  Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // Icon(
                    //   Icons.remove,
                    //   color: Colors.grey[600],
                    //   size: 40,
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 12.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      items[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 15),
                                    ),
                                    if (items[index] == selValue)
                                      const Icon(CupertinoIcons.checkmark,
                                          size: 24, color: Colors.blue)
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       border: Border.all(
                                    //         color: Theme.of(context)
                                    //             .canvasColor,
                                    //       )),
                                    //       alignment: Alignment.center,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(2),
                                    //     child: Icon(Icons.circle,
                                    //         size: 10,
                                    //         color: Colors.blue),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              onTap: () {
                                // Get.find<AccountSetUpController>()
                                //     .setAccountValue(items[index]);
                                //    _controller.accountType.value =  TextEditingController(text: _items[index]);
                                indexselct(index);
                                update(items[index]);
                                Navigator.pop(context);
                              });
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                  ]),
                ),
              ));
        });
  }

  showMultiSelectModal(BuildContext context, List<String> items, selectedItems,
      final ValueChanged<List<String>> update) {
    List<String> result =selectedItems.isNotEmpty?selectedItems:[];
    result = result.map((item) => item.trim().toString()).toList();
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, setState) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    // Optional: Close modal on outside tap
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 30),
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              bool isSelected = result.contains(items[index]);
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        items[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 15),
                                      ),
                                      if (isSelected)
                                        const Icon(Icons.check_box,
                                            size: 24, color: Colors.blue)
                                      else
                                        const Icon(Icons.check_box_outline_blank,
                                            size: 24, color: Colors.blue)
                                      // Checkbox(
                                      //   value: isSelected,
                                      //   onChanged: (checked) {
                                      //     setState(() {
                                      //       if (checked == true) {
                                      //         selected.add(items[index]);
                                      //       } else {
                                      //         selected.remove(items[index]);
                                      //       }
                                      //     });
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      result.remove(items[index]);
                                    } else {
                                      result.add(items[index]);
                                    }
                                    update(
                                        result); // Send the updated list back
                                  });
                                },
                              );
                            },
                          ),
                          // SizedBox(height: 10),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     update(result); // Send the updated list back
                          //     Navigator.pop(context); // Close the modal
                          //   },
                          //   child: Text("Confirm Selection"),
                          // ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ));
      },
    );
  }
}
