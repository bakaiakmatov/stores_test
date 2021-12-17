import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    required this.context,
    required this.id,
    required this.type,
    required this.hydraMember,
    required this.hydraTotalItems,
    required this.hydraView,
  });

  final String context;
  final String id;
  final String type;
  final List<HydraMember> hydraMember;
  final int hydraTotalItems;
  final HydraView? hydraView;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        context: json["@context"],
        id: json["@id"],
        type: json["@type"],
        hydraMember: List<HydraMember>.from(
            json["hydra:member"].map((x) => HydraMember.fromJson(x))),
        hydraTotalItems: json["hydra:totalItems"],
         hydraView: json["hydra:view"] == null ? null:  HydraView.fromJson(json["hydra:view"]),
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@id": id,
        "@type": type,
        "hydra:member": List<dynamic>.from(hydraMember.map((x) => x.toJson())),
        "hydra:totalItems": hydraTotalItems,
        "hydra:view": hydraView?.toJson(),
      };
}

class HydraMember {
  HydraMember({
    required this.type,
    required this.id,
    required this.hydraMemberId,
    required this.eeCatId,
    required this.name,
    required this.slug,
    required this.categories,
  });

  final String type;
  final String id;
  final int hydraMemberId;
  final int eeCatId;
  final String name;
  final String slug;
  final List<CategoryElement> categories;

  factory HydraMember.fromJson(Map<String, dynamic> json) => HydraMember(
        type: json["@type"],
        id: json["@id"],
        hydraMemberId: json["id"],
        eeCatId: json["eeCatId"],
        name: json["name"],
        slug: json["slug"],
        categories: List<CategoryElement>.from(
            json["categories"].map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "@id": id,
        "id": hydraMemberId,
        "eeCatId": eeCatId,
        "name": name,
        "slug": slug,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class CategoryElement {
  CategoryElement({
    required this.id,
    required this.name,
    required this.slug,
    required this.eeCatId,
    required this.imageUrl,
    required this.categories,
  });

  final int id;
  final String name;
  final String slug;
  final int eeCatId;
  final dynamic imageUrl;
  final List<CategoryElement> categories;

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        eeCatId: json["eeCatId"],
        imageUrl: json["imageUrl"],
        categories: json["categories"] == null
            ? <CategoryElement>[]
            : List<CategoryElement>.from(
                json["categories"].map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "eeCatId": eeCatId,
        "imageUrl": imageUrl,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class HydraView {
  HydraView({
    required this.id,
    required this.type,
    required this.hydraFirst,
    required this.hydraLast,
    required this.hydraNext,
  });

  final String id;
  final String type;
  final String hydraFirst;
  final String hydraLast;
  final String hydraNext;

  factory HydraView.fromJson(Map<String, dynamic> json) => HydraView(
        id: json["@id"],
        type: json["@type"],
        hydraFirst: json["hydra:first"],
        hydraLast: json["hydra:last"],
        hydraNext: json["hydra:next"],
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
        "@type": type,
        "hydra:first": hydraFirst,
        "hydra:last": hydraLast,
        "hydra:next": hydraNext,
      };
}
