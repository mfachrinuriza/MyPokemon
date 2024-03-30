//
//  BaseResponse.swift
//  core
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import Foundation

public struct BaseResponse<T: Codable> {
    public var results: T?
}

extension BaseResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            results = try container.decode(T.self, forKey: .results)
        } catch {
            Logger.printLog("=== DECODE ERROR ===")
            Logger.printLog(error)
        }
    }
}

struct Nil: Codable {}
