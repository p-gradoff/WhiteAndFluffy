//
//  InfoModel.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 16.09.2024.
//

import Foundation

// MARK: InfoModel
struct InfoModel: Codable {
    let id, createdAt, updatedAt: String?
    let width, height: Int?
    let color: String?
    let likes: Int?
    let likedByUser: Bool?
    let description: String?
    let user: User?
    let currentUserCollections: CurrentUserCollections?
    let urls: InfoUrls?
    let links: InfoLinks?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case likes
        case likedByUser = "liked_by_user"
        case description, user
        case currentUserCollections = "current_user_collections"
        case urls, links
    }
}

// MARK: info structures
struct CurrentUserCollections: Codable { }
struct InfoUrls: Codable { }
struct InfoLinks: Codable { }

// MARK: User
struct User: Codable {
    let id, username, name, portfolioUrl, bio, location: String?
    let totalLikes, totalPhotos, totalCollections: Int?
    let instagramUsername, twitterUsername: String?
    let profileImage: ProfileImage?
    let links: UserLinks?
    
    enum CodingKeys: String, CodingKey {
        case id, username, name
        case portfolioUrl = "portfolio_url"
        case bio, location
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case instagramUsername = "instagram_username"
        case twitterUsername = "twitter_username"
        case profileImage = "profile_image"
        case links
    }
}

// MARK: user's structures
struct ProfileImage: Codable { }
struct UserLinks: Codable { }
