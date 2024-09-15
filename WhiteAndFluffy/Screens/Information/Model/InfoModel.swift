//
//  InfoModel.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 16.09.2024.
//

import Foundation

// MARK: - InfoModel
struct InfoModel: Codable {
    let id, slug: String
    let alternativeSlugs: AlternativeSlugs?
    let createdAt, updatedAt: Date
    let promotedAt: Date?
    let width, height: Int
    let color, blurHash: String
    let description: String?
    let altDescription: String?
    let breadcrumbs: [Breadcrumb]?
    let urls: Urls?
    let links: InfoLinks?
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [UserCollection]?
    let sponsorship: Sponsorship?
    let topicSubmissions: TopicSubmissions?
    let assetType: String?
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, slug
        case alternativeSlugs = "alternative_slugs"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case breadcrumbs, urls, links, likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship
        case topicSubmissions = "topic_submissions"
        case assetType = "asset_type"
        case user
    }
}

// MARK: - UserModel
struct User: Codable {
    let id: String
    let updatedAt: Date
    let username, name, firstName, lastName: String?
    let twitterUsername: String?
    let portfolioURL: String?
    let bio: String?
    let location: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos, totalPromotedPhotos: Int?
    let totalIllustrations, totalPromotedIllustrations: Int?
    let acceptedTos, forHire: Bool?
    let social: Social?

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalPromotedPhotos = "total_promoted_photos"
        case totalIllustrations = "total_illustrations"
        case totalPromotedIllustrations = "total_promoted_illustrations"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case social
    }
}

struct AlternativeSlugs: Codable { }
struct Breadcrumb: Codable { }
struct InfoLinks: Codable { }
struct Sponsorship: Codable { }
struct UserCollection: Codable { }
struct UserLinks: Codable { }
struct ProfileImage: Codable { }
struct Social: Codable { }
struct TopicSubmissions: Codable { }
struct Urls: Codable { }




