import 'dart:convert';
import 'dart:io';

void main() async {
  final jsonPath = 'lib/core/widgets/csvjson (2).json';
  final outputPath = 'lib/featuer/reviews/data/review_data.dart';

  final jsonFile = File(jsonPath);
  if (!await jsonFile.exists()) {
    print('Error: JSON file not found at $jsonPath');
    exit(1);
  }

  final jsonString = await jsonFile.readAsString();
  final List<dynamic> data = jsonDecode(jsonString);

  final buffer = StringBuffer();
  buffer.writeln("import 'models/review_model.dart';");
  buffer.writeln("");
  buffer.writeln("List<ReviewModel> getReviews() {");
  buffer.writeln("  final List<Map<String, dynamic>> jsonData = [");

  for (final item in data) {
    buffer.writeln("    {");
    buffer.writeln("      'star_rate': ${item['star_rate']},");
    buffer.writeln("      'reviewer': '${_escape(item['reviewer'])}',");
    buffer.writeln("      'reviewer_url': '${_escape(item['reviewer_url'])}',");
    buffer.writeln("      'reviewr_pic': '${_escape(item['reviewr_pic'])}',");
    buffer.writeln("      'review_text': '${_escape(item['review_text'])}',");
    buffer.writeln("      'reviewer_meta_Info': '${_escape(item['reviewer_meta_Info'])}',");
    buffer.writeln("    },");
  }

  buffer.writeln("  ];");
  buffer.writeln("");
  buffer.writeln("  return jsonData.map((data) => ReviewModel.fromJson(data)).toList();");
  buffer.writeln("}");

  await File(outputPath).writeAsString(buffer.toString());
  print('Successfully updated $outputPath');
}

String _escape(dynamic value) {
  if (value == null) return '';
  return value.toString().replaceAll("'", "\\'").replaceAll("\n", "\\n");
}
