import 'package:bethel_app_final/FRONT_END/colors/color.dart';
import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TERMS AND CONDITIONS'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            // removed const from here
            // Changed from a single Text widget to a Column widget
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "February 17, 2024 ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                " AGREEMENT TO OUR LEGAL TERMS   ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                " We are Church Tap (Company, we, us, our), a company registered  "
                " in the Philippines at Tagum City, Davao del Norte Philippines, Tagum City, Tagum City Davao  "
                " del Norte 8100. ",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Text(
                " We operate the mobile application Church Tap (the App), as well as any other related "
                " products and services that refer or link to these legal terms (the Legal Terms) (collectively, the Services). ",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 20),
              Text(
                " Church Tap: Connect, Organize, and Grow Your Faith Community Church Tap is a comprehensive church management system designed to simplify your day-to-day operations and strengthen your faith community. Locate Outreach Churches: Easily find and connect with other churches in your area, fostering collaboration and shared resources. Appointment Management: Streamline communication and scheduling with a user-friendly appointment request system. Members can easily book meetings with pastors or staff right from their mobile devices. Event Calendar: Create, manage, and promote events seamlessly. Organize: Centralized Management: Manage all aspects of your church – from member information, group management and volunteer coordination – in one intuitive platform. Member Engagement: Foster deeper connections within your community with discussion forums, prayer walls, and online groups. Additional Features: Mobile App: Church Tap is available as a user-friendly mobile app for both Web and Android devices, ensuring on-the-go access for everyone. Customizable: Tailor the app to your specific church's needs and branding. Secure: Rest assured knowing your data is protected with industry-standard security measures. Church Tap is more than just a management system; it's a powerful tool to connect, organize, and grow your faith community. By streamlining your operations and fostering deeper connections, you can empower your members and achieve your church's mission.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "You can contact us by phone at 09057481403, email at finalprojectchurchtap@gmail.com, or by mail to Tagum City, Davao del Norte Philippines, Tagum City, Tagum City Davao del Norte 8100, Philippines.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "These Legal Terms constitute a legally binding agreement made between you, whether personally or on behalf of an entity (you), and Church Tap, concerning your access to and use of the Services. You agree that by accessing the Services, you have read, understood, and agreed to be bound by all of these Legal Terms. IF YOU DO NOT AGREE WITH ALL OF THESE LEGAL TERMS, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SERVICES AND YOU MUST DISCONTINUE USE IMMEDIATELY.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "We will provide you with prior notice of any scheduled changes to the Services you are using. The modified Legal Terms will become effective upon posting or notifying you by finalprojectchurchtap@gmail.com, as stated in the email message. By continuing to use the Services after the effective date of any changes, you agree to be bound by the modified terms.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "All users who are minors in the jurisdiction in which they reside (generally under the age of 18) must have the permission of, and be directly supervised by, their parent or guardian to use the Services. If you are a minor, you must have your parent or guardian read and agree to these Legal Terms prior to you using the Services.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "TABLE OF CONTENTS",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "1. OUR SERVICES",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "2. INTELLECTUAL PROPERTY RIGHTS",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "3. USER REPRESENTATIONS",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "4. USER REGISTRATION",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "5. PROHIBITED ACTIVITIES",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "6. USER GENERATED CONTRIBUTIONS",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "7. CONTRIBUTION LICENSE",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "8. GUIDELINES FOR REVIEWS",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "9. MOBILE APPLICATION LICENSE",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "10. SOCIAL MEDIA",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "11. THIRD-PARTY WEBSITES AND CONTENT",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "12. SERVICES MANAGEMENT",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "13. TERM AND TERMINATION",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "14. MODIFICATIONS AND INTERRUPTIONS",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "15. GOVERNING LAW",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "16. DISPUTE RESOLUTION",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "17. CORRECTIONS",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "18. DISCLAIMER",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "19. LIMITATIONS OF LIABILITY",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "20. INDEMNIFICATION",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "21. USER DATA",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "22. ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "23. MISCELLANEOUS",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "24. CONTACT US",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "1. OUR SERVICES",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "The information provided when using the Services is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country. Accordingly, those persons who choose to access the Services from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "2. INTELLECTUAL PROPERTY RIGHTS",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Our intellectual property",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We are the owner or the licensee of all intellectual property rights in our Services, including all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics in the Services (collectively, the Content), as well as the trademarks, service marks, and logos contained therein (the Marks).",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "Our Content and Marks are protected by copyright and trademark laws (and various other intellectual property rights and unfair competition laws) and treaties in the United States and around the world.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "The Content and Marks are provided in or through the Services AS IS for your personal, non-commercial use or internal business purpose only.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Your use of our Services",
                style: TextStyle(
                  fontSize: 18,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Subject to your compliance with these Legal Terms, including the "
                "PROHIBITED ACTIVITIES"
                " section below, we grant you a non-exclusive, non-transferable, revocable license to:",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "-	access the Services; and",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "-	download or print a copy of any portion of the Content to which you have properly gained access.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Except as set out in this section or elsewhere in our Legal Terms, no part of the Services and no Content or Marks may be copied, reproduced, aggregated, republished, uploaded, posted, publicly displayed, encoded, translated, transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose whatsoever, without our express prior written permission.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "If you wish to make any use of the Services, Content, or Marks other than as set out in this section or elsewhere in our Legal Terms, please address your request to: finalprojectchurchtap@gmail.com. If we ever grant you the permission to post, reproduce, or publicly display any part of our Services or Content, you must identify us as the owners or licensors of the Services, Content, or Marks and ensure that any copyright or proprietary notice appears or is visible on posting, reproducing, or displaying our Content.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "We reserve all rights not expressly granted to you in and to the Services, Content, and Marks.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Any breach of these Intellectual Property Rights will constitute a material breach of our Legal Terms and your right to use our Services will terminate immediately.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Your submissions",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "Please review this section and the PROHIBITED ACTIVITIES section carefully prior to using our Services to understand the (a) rights you give us and (b) obligations you have when you post or upload any content through the Services.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Submissions: By directly sending us any question, comment, suggestion, idea, feedback, or other information about the Services (Submissions), you agree to assign to us all intellectual property rights in such Submission. You agree that we shall own this Submission and be entitled to its unrestricted use and dissemination for any lawful purpose, commercial or otherwise, without acknowledgment or compensation to you.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "You are responsible for what you post or upload: By sending us Submissions through any part of the Services you:",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "*	confirm that you have read and agree with our PROHIBITED ACTIVITIES and will not post, send, publish, upload, or transmit through the Services any Submission that is illegal, harassing, hateful, harmful, defamatory, obscene, bullying, abusive, discriminatory, threatening to any person or group, sexually explicit, false, inaccurate, deceitful, or misleading;",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "*	to the extent permissible by applicable law, waive any and all moral rights to any such Submission;",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "*	warrant that any such Submission are original to you or that you have the necessary rights and licenses to submit such Submissions and that you have full authority to grant us the above-mentioned rights in relation to your Submissions; and",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "*	warrant and represent that your Submissions do not constitute confidential information.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "You are solely responsible for your Submissions and you expressly agree to reimburse us for any and all losses that we may suffer because of your breach of (a) this section, (b) any third party’s intellectual property rights, or (c) applicable law.You are solely responsible for your Submissions and you expressly agree to reimburse us for any and all losses that we may suffer because of your breach of (a) this section, (b) any third party’s intellectual property rights, or (c) applicable law.You are solely responsible for your Submissions and you expressly agree to reimburse us for any and all losses that we may suffer because of your breach of (a) this section, (b) any third party’s intellectual property rights, or (c) applicable law.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "3. USER REPRESENTATIONS",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "By using the Services, you represent and warrant that: (1) all registration information you submit will be true, accurate, current, and complete; (2) you will maintain the accuracy of such information and promptly update such registration information as necessary; (3) you have the legal capacity and you agree to comply with these Legal Terms; (4) you are not a minor in the jurisdiction in which you reside, or if a minor, you have received parental permission to use the Services; (5) you will not access the Services through automated or non-human means, whether through a bot, script or otherwise; (6) you will not use the Services for any illegal or unauthorized purpose; and (7) your use of the Services will not violate any applicable law or regulation.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "If you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the Services (or any portion thereof).",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "4. USER REGISTRATION",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "You may be required to register to use the Services. You agree to keep your password confidential and will be responsible for all use of your account and password. We reserve the right to remove, reclaim, or change a username you select if we determine, in our sole discretion, that such username is inappropriate, obscene, or otherwise objectionable.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "5. PROHIBITED ACTIVITIES",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "You may not access or use the Services for any purpose other than that for which we make the Services available. The Services may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "As a user of the Services, you agree not to:",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "* 	Systematically retrieve data or other content from the Services to create or compile, directly or indirectly, a collection, compilation, database, or directory without written permission from us.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "*	Trick, defraud, or mislead us and other users, especially in any attempt to learn sensitive account information such as user passwords.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "* 	Circumvent, disable, or otherwise interfere with security-related features of the Services, including features that prevent or restrict the use or copying of any Content or enforce limitations on the use of the Services and/or the Content contained therein.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "* 	Disparage, tarnish, or otherwise harm, in our opinion, us and/or the Services.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "* 	Use any information obtained from the Services in order to harass, abuse, or harm another person.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "* 	Make improper use of our support services or submit false reports of abuse or misconduct.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                " *  Use the Services in a manner inconsistent with any applicable laws or regulations",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "* 	Engage in unauthorized framing of or linking to the Services",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "* 	Upload or transmit (or attempt to upload or to transmit) viruses, Trojan horses, or other material, including excessive use of capital letters and spamming (continuous posting of repetitive text), that interferes with any party’s uninterrupted use and enjoyment of the Services or modifies, impairs, disrupts, alters, or interferes with the use, features, functions, operation, or maintenance of the Services.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "* 	Engage in any automated use of the system, such as using scripts to send comments or messages, or using any data mining, robots, or similar data gathering and extraction tools.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "* 	Delete the copyright or other proprietary rights notice from any Content.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "*  Attempt to impersonate another user or person or use the username of another user",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "* 	Use the Services as part of any effort to compete with us or otherwise use the Services and/or the Content for any revenue-generating endeavor or commercial enterprise.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "6. USER GENERATED CONTRIBUTIONS",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "The Services does not offer users to submit or post content. We may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or on the Services, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, Contributions). Contributions may be viewable by other users of the Services and through third-party websites. When you create or make available any Contributions, you thereby represent and warrant that:",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "7. CONTRIBUTION LICENSE",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "You and Services agree that we may access, store, process, and use any information and personal data that you provide and your choices (including settings)."
                "By submitting suggestions or other feedback regarding the Services, you agree that we can use and share such feedback for any purpose without compensation to you.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area on the Services. You are solely responsible for your Contributions to the Services and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "8. GUIDELINES FOR REVIEWS",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "We may provide you areas on the Services to leave reviews or ratings. When posting a review, you must comply with the following criteria: (1) you should have firsthand experience with the person/entity being reviewed; (2) your reviews should not contain offensive profanity, or abusive, racist, offensive, or hateful language; (3) your reviews should not contain discriminatory references based on religion, race, gender, national origin, age, marital status, sexual orientation, or disability; (4) your reviews should not contain references to illegal activity; (5) you should not be affiliated with competitors if posting negative reviews; (6) you should not make any conclusions as to the legality of conduct; (7) you may not post any false or misleading statements; and (8) you may not organize a campaign encouraging others to post reviews, whether positive or negative.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "We may accept, reject, or remove reviews in our sole discretion. We have absolutely no obligation to screen reviews or to delete reviews, even if anyone considers reviews objectionable or inaccurate. Reviews are not endorsed by us, and do not necessarily represent our opinions or the views of any of our affiliates or partners. We do not assume liability for any review or for any claims, liabilities, or losses resulting from any review. By posting a review, you hereby grant to us a perpetual, non-exclusive, worldwide, royalty-free, fully paid, assignable, and sublicensable right and license to reproduce, modify, translate, transmit by any means, display, perform, and/or distribute all content relating to review.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "9. MOBILE APPLICATION LICENSE",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "If you access the Services via the App, then we grant you a revocable, non-exclusive, non-transferable, limited right to install and use the App on wireless electronic devices owned or controlled by you, and to access and use the App on such devices strictly in accordance with the terms and conditions of this mobile application license contained in these Legal Terms. You shall not: (1) except as permitted by applicable law, decompile, reverse engineer, disassemble, attempt to derive the source code of, or decrypt the App; (2) make any modification, adaptation, improvement, enhancement, translation, or derivative work from the App; (3) violate any applicable laws, rules, or regulations in connection with your access or use of the App; (4) remove, alter, or obscure any proprietary notice (including any notice of copyright or trademark) posted by us or the licensors of the App; (5) use the App for any revenue-generating endeavor, commercial enterprise, or other purpose for which it is not designed or intended; (6) make the App available over a network or other environment permitting access or use by multiple devices or users at the same time; (7) use the App for creating a product, service, or software that is, directly or indirectly, competitive with or in any way a substitute for the App; (8) use the App to send automated queries to any website or to send any unsolicited commercial email; or (9) use any proprietary information or any of our interfaces or our other intellectual property in the design, development, manufacture, licensing, or distribution of any applications, accessories, or devices for use with the App.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Apple and Android Devices",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "The following terms apply when you use the App obtained from either the Apple Store or Google Play (each an App Distributor) to access the Services: (1) the license granted to you for our App is limited to a non-transferable license to use the application on a device that utilizes the Apple iOS or Android operating systems, as applicable, and in accordance with the usage rules set forth in the applicable App Distributor’s terms of service; (2) we are responsible for providing any maintenance and support services with respect to the App as specified in the terms and conditions of this mobile application license contained in these Legal Terms or as otherwise required under applicable law, and you acknowledge that each App Distributor has no obligation whatsoever to furnish any maintenance and support services with respect to the App; (3) in the event of any failure of the App to conform to any applicable warranty, you may notify the applicable App Distributor, and the App Distributor, in accordance with its terms and policies, may refund the purchase price, if any, paid for the App, and to the maximum extent permitted by applicable law, the App Distributor will have no other warranty obligation whatsoever with respect to the App; ",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "(4) you represent and warrant that (i) you are not located in a country that is subject to a US government embargo, or that has been designated by the US government as a terrorist supporting country and (ii) you are not listed on any US government list of prohibited or restricted parties; (5) you must comply with applicable third-party terms of agreement when using the App, e.g., if you have a VoIP application, then you must not be in violation of their wireless data service agreement when using the App; and (6) you acknowledge and agree that the App Distributors are third-party beneficiaries of the terms and conditions in this mobile application license contained in these Legal Terms, and that each App Distributor will have the right (and will be deemed to have accepted the right) to enforce the terms and conditions in this mobile application license contained in these Legal Terms against you as a third-party beneficiary thereof.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "10. SOCIAL MEDIA",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "As part of the functionality of the Services, you may link your account with online accounts you have with third-party service providers (each such account, a Third-Party Account) by either: (1) providing your Third-Party Account login information through the Services; or (2) allowing us to access your Third-Party Account, as is permitted under the applicable terms and conditions that govern your use of each Third-Party Account. You represent and warrant that you are entitled to disclose your Third-Party Account login information to us and/or grant us access to your Third-Party Account, without breach by you of any of the terms and conditions that govern your use of the applicable Third-Party Account, and without obligating us to pay any fees or making us subject to any usage limitations imposed by the third-party service provider of the Third-Party Account. By granting us access to any Third-Party Accounts, you understand that (1) we may access, make available, and store (if applicable) any content that you have provided to and stored in your Third-Party Account ",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "(the Social Network Content) so that it is available on and through the Services via your account, including without limitation any friend lists and (2) we may submit to and receive from your Third-Party Account additional information to the extent you are notified when you link your account with the Third-Party Account. Depending on the Third-Party Accounts you choose and subject to the privacy settings that you have set in such Third-Party Accounts, personally identifiable information that you post to your Third-Party Accounts may be available on and through your account on the Services. Please note that if a Third-Party Account or associated service becomes unavailable or our access to such Third-Party Account is terminated by the third-party service provider, then Social Network Content may no longer be available on and through the Services. You will have the ability to disable the connection between your account on the Services and your Third-Party Accounts at any time. PLEASE NOTE THAT YOUR RELATIONSHIP WITH THE THIRD-PARTY SERVICE PROVIDERS ASSOCIATED WITH YOUR THIRD-PARTY ACCOUNTS ",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              Text(
                "IS GOVERNED SOLELY BY YOUR AGREEMENT(S) WITH SUCH THIRD-PARTY SERVICE PROVIDERS. We make no effort to review any Social Network Content for any purpose, including but not limited to, for accuracy, legality, or non-infringement, and we are not responsible for any Social Network Content. You acknowledge and agree that we may access your email address book associated with a Third-Party Account and your contacts list stored on your mobile device or tablet computer solely for purposes of identifying and informing you of those contacts who have also registered to use the Services. You can deactivate the connection between the Services and your Third-Party Account by contacting us using the contact information below or through your account settings (if applicable). We will attempt to delete any information stored on our servers that was obtained through such Third-Party Account, except the username and profile picture that become associated with your account.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "11. THIRD-PARTY WEBSITES AND CONTENT",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "As a user of the Services, you agree not to:",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "The Services may contain (or you may be sent via the App) links to other websites (Third-Party Websites) as well as articles, photographs, text, graphics, pictures, designs, music, sound, video, information, applications, software, and other content or items belonging to or originating from third parties (Third-Party Content). Such Third-Party Websites and Third-Party Content are not investigated, monitored, or checked for accuracy, appropriateness, or completeness by us, and we are not responsible for any Third-Party Websites accessed through the Services or any Third-Party Content posted on, available through, or installed from the Services, including the content, accuracy, offensiveness, opinions, reliability, privacy practices, or other policies of or contained in the Third-Party Websites or the Third-Party Content. Inclusion of, linking to, or permitting the use or installation of any Third-Party Websites or any Third-Party Content does not imply approval or endorsement thereof by us. If you decide to leave the Services and access the Third-Party Websites or to use or install any Third-Party Content, you do so at your own risk, and you should be aware these Legal Terms no longer govern. You should review the applicable terms and policies, including privacy and data gathering practices, of any website to which you navigate from the Services or relating to any applications you use or install from the Services. Any purchases you make through Third-Party Websites will be through other websites and from other companies, and we take no responsibility whatsoever in relation to such purchases which are exclusively between you and the applicable third party. You agree and acknowledge that we do not endorse the products or services offered on Third-Party Websites and you shall hold us blameless from any harm caused by your purchase of such products or services. Additionally, you shall hold us blameless from any losses sustained by you or harm caused to you relating to or resulting in any way from any Third-Party Content or any contact with Third-Party Websites.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "12. SERVICES MANAGEMENT",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "We reserve the right, but not the obligation, to: (1) monitor the Services for violations of these Legal Terms; (2) take appropriate legal action against anyone who, in our sole discretion, violates the law or these Legal Terms, including without limitation, reporting such user to law enforcement authorities; (3) in our sole discretion and without limitation, refuse, restrict access to, limit the availability of, or disable (to the extent technologically feasible) any of your Contributions or any portion thereof; (4) in our sole discretion and without limitation, notice, or liability, to remove from the Services or otherwise disable all files and content that are excessive in size or are in any way burdensome to our systems; and (5) otherwise manage the Services in a manner designed to protect our rights and property and to facilitate the proper functioning of the Services.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "13. TERM AND TERMINATION",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "These Legal Terms shall remain in full force and effect while you use the Services. WITHOUT LIMITING ANY OTHER PROVISION OF THESE LEGAL TERMS, WE RESERVE THE RIGHT TO, IN OUR SOLE DISCRETION AND WITHOUT NOTICE OR LIABILITY, DENY ACCESS TO AND USE OF THE SERVICES (INCLUDING BLOCKING CERTAIN IP ADDRESSES), TO ANY PERSON FOR ANY REASON OR FOR NO REASON, INCLUDING WITHOUT LIMITATION FOR BREACH OF ANY REPRESENTATION, WARRANTY, OR COVENANT CONTAINED IN THESE LEGAL TERMS OR OF ANY APPLICABLE LAW OR REGULATION. WE MAY TERMINATE YOUR USE OR PARTICIPATION IN THE SERVICES OR DELETE YOUR ACCOUNT AND ANY CONTENT OR INFORMATION THAT YOU POSTED AT ANY TIME, WITHOUT WARNING, IN OUR SOLE DISCRETION.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "If we terminate or suspend your account for any reason, you are prohibited from registering and creating a new account under your name, a fake or borrowed name, or the name of any third party, even if you may be acting on behalf of the third party. In addition to terminating or suspending your account, we reserve the right to take appropriate legal action, including without limitation pursuing civil, criminal, and injunctive redress.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "14. MODIFICATIONS AND INTERRUPTIONS",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "We reserve the right to change, modify, or remove the contents of the Services at any time or for any reason at our sole discretion without notice. However, we have no obligation to update any information on our Services. We will not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the Services.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "We cannot guarantee the Services will be available at all times. We may experience hardware, software, or other problems or need to perform maintenance related to the Services, resulting in interruptions, delays, or errors. We reserve the right to change, revise, update, suspend, discontinue, or otherwise modify the Services at any time or for any reason without notice to you. You agree that we have no liability whatsoever for any loss, damage, or inconvenience caused by your inability to access or use the Services during any downtime or discontinuance of the Services. Nothing in these Legal Terms will be construed to obligate us to maintain and support the Services or to supply any corrections, updates, or releases in connection therewith.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "15. GOVERNING LAW",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "These Legal Terms shall be governed by and defined following the laws of the Philippines. Church Tap and yourself irrevocably consent that the courts of the Philippines shall have exclusive jurisdiction to resolve any dispute which may arise in connection with these Legal Terms.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "16. DISPUTE RESOLUTION",
                style: TextStyle(
                    fontSize: 18, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "Informal Negotiations",
                style: TextStyle(
                    fontSize: 14, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "To expedite resolution and control the cost of any dispute, controversy, or claim related to these Legal Terms (each a Dispute and collectively, the Disputes) brought by either you or us (individually, a Party and collectively, the Parties), the Parties agree to first attempt to negotiate any Dispute (except those Disputes expressly provided below) informally for at least __________ days before initiating arbitration. Such informal negotiations commence upon written notice from one Party to the other Party.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Binding Arbitration",
                style: TextStyle(
                    fontSize: 14, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "Any dispute arising out of or in connection with these Legal Terms, including any question regarding its existence, validity, or termination, shall be referred to and finally resolved by the International Commercial Arbitration Court under the European Arbitration Chamber (Belgium, Brussels, Avenue Louise, 146) according to the Rules of this ICAC, which, as a result of referring to it, is considered as the part of this clause. The number of arbitrators shall be __________. The seat, or legal place, or arbitration shall be __________. The language of the proceedings shall be __________. The governing law of these Legal Terms shall be substantive law of __________.:",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Restrictions",
                style: TextStyle(
                    fontSize: 14, color: appBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "The Parties agree that any arbitration shall be limited to the Dispute between the Parties individually. To the full extent permitted by law, (a) no arbitration shall be joined with any other proceeding; (b) there is no right or authority for any Dispute to be arbitrated on a class-action basis or to utilize class action procedures; and (c) there is no right or authority for any Dispute to be brought in a purported representative capacity on behalf of the general public or any other persons.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "18. DISCLAIMER",
                style: TextStyle(
                    fontSize: 18,
                     color: appBlack, 
                    fontWeight: FontWeight.bold
                    ),
              ),
              SizedBox(height: 20),
              Text(
                "THE SERVICES ARE PROVIDED ON AN AS-IS AND AS-AVAILABLE BASIS. YOU AGREE THAT YOUR USE OF THE SERVICES WILL BE AT YOUR SOLE RISK. TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE SERVICES AND YOUR USE THEREOF, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY OR COMPLETENESS OF THE SERVICES' CONTENT OR THE CONTENT OF ANY WEBSITES OR MOBILE APPLICATIONS LINKED TO THE SERVICES AND WE WILL ASSUME NO LIABILITY OR RESPONSIBILITY FOR ANY (1) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT AND MATERIALS, (2) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF THE SERVICES, (3) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (4) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE SERVICES, (5) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE SERVICES BY ANY THIRD PARTY, AND/OR (6) ANY ERRORS OR OMISSIONS IN ANY CONTENT AND MATERIALS OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE SERVICES. WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE SERVICES, ANY HYPERLINKED WEBSITE, OR ANY WEBSITE OR MOBILE APPLICATION FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND ANY THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. AS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "19. LIMITATIONS OF LIABILITY",
                style: TextStyle(
                  fontSize: 18,
                  color: appBlack,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20),
              Text(
                "IN NO EVENT WILL WE OR OUR DIRECTORS, EMPLOYEES, OR AGENTS BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL, OR PUNITIVE DAMAGES, INCLUDING LOST PROFIT, LOST REVENUE, LOSS OF DATA, OR OTHER DAMAGES ARISING FROM YOUR USE OF THE SERVICES, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, OUR LIABILITY TO YOU FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO THE AMOUNT PAID, IF ANY, BY YOU TO US. CERTAIN US STATE LAWS AND INTERNATIONAL LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MAY HAVE ADDITIONAL RIGHTS.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "20. INDEMNIFICATION",
                style: TextStyle(
                  fontSize: 18,
                  color: appBlack,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20),
              Text(
                "You agree to defend, indemnify, and hold us harmless, including our subsidiaries, affiliates, and all of our respective officers, agents, partners, and employees, from and against any loss, damage, liability, claim, or demand, including reasonable attorneys’ fees and expenses, made by any third party due to or arising out of: (1) use of the Services; (2) breach of these Legal Terms; (3) any breach of your representations and warranties set forth in these Legal Terms; (4) your violation of the rights of a third party, including but not limited to intellectual property rights; or (5) any overt harmful act toward any other user of the Services with whom you connected via the Services. Notwithstanding the foregoing, we reserve the right, at your expense, to assume the exclusive defense and control of any matter for which you are required to indemnify us, and you agree to cooperate, at your expense, with our defense of such claims. We will use reasonable efforts to notify you of any such claim, action, or proceeding which is subject to this indemnification upon becoming aware of it.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
                SizedBox(height: 20),
              Text(
                "21. USER DATA",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                  fontWeight: FontWeight.bold
                ),
              ),
                SizedBox(height: 20),
              Text(
                "We will maintain certain data that you transmit to the Services for the purpose of managing the performance of the Services, as well as data relating to your use of the Services. Although we perform regular routine backups of data, you are solely responsible for all data that you transmit or that relates to any activity you have undertaken using the Services. You agree that we shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us arising from any such loss or corruption of such data.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
                SizedBox(height: 20),
              Text(
                "22. ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES",
                style: TextStyle(
                  fontSize: 18,
                  color: appBlack,
                   fontWeight: FontWeight.bold
                ),
              ),
                SizedBox(height: 20),
              Text(
                "Visiting the Services, sending us emails, and completing online forms constitute electronic communications. You consent to receive electronic communications, and you agree that all agreements, notices, disclosures, and other communications we provide to you electronically, via email and on the Services, satisfy any legal requirement that such communication be in writing. YOU HEREBY AGREE TO THE USE OF ELECTRONIC SIGNATURES, CONTRACTS, ORDERS, AND OTHER RECORDS, AND TO ELECTRONIC DELIVERY OF NOTICES, POLICIES, AND RECORDS OF TRANSACTIONS INITIATED OR COMPLETED BY US OR VIA THE SERVICES. You hereby waive any rights or requirements under any statutes, regulations, rules, ordinances, or other laws in any jurisdiction which require an original signature or delivery or retention of non-electronic records, or to payments or the granting of credits by any means other than electronic means.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
                SizedBox(height: 20),
              Text(
                "23.   MISCELLANEOUS ",
                style: TextStyle(
                  fontSize: 18,
                  color: appBlack,
                   fontWeight: FontWeight.bold
                ),
              ),
                SizedBox(height: 20),
              Text(
                "These Legal Terms and any policies or operating rules posted by us on the Services or in respect to the Services constitute the entire agreement and understanding between you and us. Our failure to exercise or enforce any right or provision of these Legal Terms shall not operate as a waiver of such right or provision. These Legal Terms operate to the fullest extent permissible by law. We may assign any or all of our rights and obligations to others at any time. We shall not be responsible or liable for any loss, damage, delay, or failure to act caused by any cause beyond our reasonable control. If any provision or part of a provision of these Legal Terms is determined to be unlawful, void, or unenforceable, that provision or part of the provision is deemed severable from these Legal Terms and does not affect the validity and enforceability of any remaining provisions. There is no joint venture, partnership, employment or agency relationship created between you and us as a result of these Legal Terms or use of the Services. You agree that these Legal Terms will not be construed against us by virtue of having drafted them. You hereby waive any and all defenses you may have based on the electronic form of these Legal Terms and the lack of signing by the parties hereto to execute these Legal Terms.",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
                SizedBox(height: 20),
              Text(
                "24. CONTACT US",
                style: TextStyle(
                  fontSize: 18,
                  color: appBlack,
                   fontWeight: FontWeight.bold
                ),
              ),
                SizedBox(height: 20),
              Text(
                "In order to resolve a complaint regarding the Services or to receive further information regarding use of the Services, please contact us at:",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
                SizedBox(height: 20),
              Text(
                "Church Tap",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
                
              Text(
                "Tagum City",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
               
              Text(
                "Davao del Norte Philippines",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
                
              Text(
                "Tagum City, Tagum City Davao del Norte 8100",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
               
              Text(
                "Philippines",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
                
              Text(
                "Phone: 09057481403",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
               Text(
                "finalprojectchurchtap@gmail.com",
                style: TextStyle(
                  fontSize: 14,
                  color: appBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
