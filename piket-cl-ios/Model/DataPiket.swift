//
//  User.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 05/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation

struct ResponseToken: Codable {
    let status: Int?
    let message: String?
    let data: Token?
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)

        status = try container.decode(Int.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decode(Token.self, forKey: .data)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(status, forKey: .status)
        try container.encode(message, forKey: .message)
        try container.encode(data, forKey: .data)
    }
}

struct Token: Codable {
    let token: String?

    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}

struct Response: Codable {
    let status: Int?
    let message: String?
    let data: [Piket]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)

        status = try container.decode(Int.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decode([Piket].self, forKey: .data)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(status, forKey: .status)
        try container.encode(message, forKey: .message)
        try container.encode(data, forKey: .data)
    }
}

struct Piket: Codable {
    let id: Int?
    let nama_anggota: String?
    let jenis_piket: String?
    let status: String?
    let token: String?
    let tanggal_piket: String?
    let diperiksa_oleh: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case nama_anggota
        case jenis_piket
        case status
        case token
        case tanggal_piket
        case diperiksa_oleh
    }
    
}




