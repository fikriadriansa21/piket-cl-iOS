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

    enum TokenCodingKeys: String, CodingKey {
        case status
        case message
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: TokenCodingKeys.self)

        status = try container.decode(Int.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decode(Token.self, forKey: .data)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TokenCodingKeys.self)

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

struct ResponsePiket: Codable {
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
    let nim: String?
    let nama_anggota: String?
    let jenis_piket: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nim = "nim"
        case namaAnggota = "nama_anggota"
        case jenisPiket = "jenis_piket"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        nim = try container.decode(String.self, forKey: .nim)
        nama_anggota = try container.decode(String.self, forKey: .namaAnggota)
        jenis_piket = try container.decode(String.self, forKey: .jenisPiket)
        status = try container.decode(String.self, forKey: .status)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(nim, forKey: .nim)
        try container.encode(nama_anggota, forKey: .namaAnggota)
        try container.encode(jenis_piket, forKey: .jenisPiket)
        try container.encode(status, forKey: .status)

    }

}





