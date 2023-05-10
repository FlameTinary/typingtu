import 'dart:convert';

List<PuzzleModel> puzzleModelFromJson(String str) => List<PuzzleModel>.from(json.decode(str).map((x) => PuzzleModel.fromJson(x)));

String puzzleModelToJson(List<PuzzleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PuzzleModel {
    PuzzleModel({
        required this.count,
        required this.content,
    });

    String count;
    List<Content> content;

    factory PuzzleModel.fromJson(Map<String, dynamic> json) => PuzzleModel(
        count: json["count"],
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
    };
}

class Content {
    Content({
        required this.type,
        required this.icon,
    });

    String type;
    String icon;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        type: json["type"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "icon": icon,
    };
}