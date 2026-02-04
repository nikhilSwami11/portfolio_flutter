// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioData _$PortfolioDataFromJson(Map<String, dynamic> json) =>
    PortfolioData(
      landing: LandingSection.fromJson(json['landing'] as Map<String, dynamic>),
      about: AboutSection.fromJson(json['about'] as Map<String, dynamic>),
      socialLinks: (json['socialLinks'] as List<dynamic>)
          .map((e) => SocialLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      experiences: (json['experiences'] as List<dynamic>)
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PortfolioDataToJson(PortfolioData instance) =>
    <String, dynamic>{
      'landing': instance.landing,
      'about': instance.about,
      'socialLinks': instance.socialLinks,
      'experiences': instance.experiences,
    };

LandingSection _$LandingSectionFromJson(Map<String, dynamic> json) =>
    LandingSection(
      title: json['title'] as String,
      createdAt: json['createdAt'] as String,
      projectTitle: json['projectTitle'] as String,
      projectDescription: json['projectDescription'] as String,
      startPrompt: json['startPrompt'] as String,
      creatorTitle: json['creatorTitle'] as String,
      creatorName: json['creatorName'] as String,
    );

Map<String, dynamic> _$LandingSectionToJson(LandingSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'createdAt': instance.createdAt,
      'projectTitle': instance.projectTitle,
      'projectDescription': instance.projectDescription,
      'startPrompt': instance.startPrompt,
      'creatorTitle': instance.creatorTitle,
      'creatorName': instance.creatorName,
    };

AboutSection _$AboutSectionFromJson(Map<String, dynamic> json) => AboutSection(
      tagline: json['tagline'] as String,
      descriptionTitle: json['descriptionTitle'] as String,
      description: json['description'] as String,
      skillsTitle: json['skillsTitle'] as String,
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      otherSkills: (json['otherSkills'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      experienceTitle: json['experienceTitle'] as String,
      experienceSummary: json['experienceSummary'] as String,
      profileImage: json['profileImage'] as String,
    );

Map<String, dynamic> _$AboutSectionToJson(AboutSection instance) =>
    <String, dynamic>{
      'tagline': instance.tagline,
      'descriptionTitle': instance.descriptionTitle,
      'description': instance.description,
      'skillsTitle': instance.skillsTitle,
      'skills': instance.skills,
      'otherSkills': instance.otherSkills,
      'experienceTitle': instance.experienceTitle,
      'experienceSummary': instance.experienceSummary,
      'profileImage': instance.profileImage,
    };

SocialLink _$SocialLinkFromJson(Map<String, dynamic> json) => SocialLink(
      platform: json['platform'] as String,
      url: json['url'] as String,
      iconAsset: json['iconAsset'] as String,
      hoverColorHex: json['hoverColorHex'] as String?,
    );

Map<String, dynamic> _$SocialLinkToJson(SocialLink instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'url': instance.url,
      'iconAsset': instance.iconAsset,
      'hoverColorHex': instance.hoverColorHex,
    };

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      companyName: json['companyName'] as String,
      siteUrl: json['siteUrl'] as String,
      role: json['role'] as String,
      location: json['location'] as String,
      duration: json['duration'] as String,
      logoAsset: json['logoAsset'] as String,
      summary: json['summary'] as String,
      appName: json['appName'] as String,
      appDownloads: json['appDownloads'] as String,
      backgroundColorHex: json['backgroundColorHex'] as String,
      detailBannerData: (json['detailBannerData'] as List<dynamic>)
          .map((e) => DetailBannerData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'siteUrl': instance.siteUrl,
      'role': instance.role,
      'location': instance.location,
      'duration': instance.duration,
      'logoAsset': instance.logoAsset,
      'summary': instance.summary,
      'appName': instance.appName,
      'appDownloads': instance.appDownloads,
      'backgroundColorHex': instance.backgroundColorHex,
      'detailBannerData': instance.detailBannerData,
    };

DetailBannerData _$DetailBannerDataFromJson(Map<String, dynamic> json) =>
    DetailBannerData(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
    );

Map<String, dynamic> _$DetailBannerDataToJson(DetailBannerData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
    };
