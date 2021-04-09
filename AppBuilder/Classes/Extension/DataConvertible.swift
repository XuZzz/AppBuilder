//
//  DataConvertible.swift
//  AppBuilder
//
//  Created by 许朕 on 2021/4/9.
//

import Foundation


/// 数据转换 可将data数据序列化为Model。
/// Model类需要遵从Decodable
protocol Parseable {
    static func parse(data: Data)-> Self?
}

extension Parseable where Self: Decodable {
    static func parse(data: Data)-> Self? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Self.self, from: data)
        } catch  {
            print(error.localizedDescription)
        }
        return nil
    }
}

/// 一个响应，想要被序列化，需要实现Decodable&Parseable
/// 这里直接起别名，方便实用
typealias Responseable = Decodable & Parseable


/// 参数转换
/// Model类遵从此协议后，可直接调用convertToDict()将model转化为[String: Any]? 用作请求参数等其他用途
protocol ParameterConvertable: Codable {
    func convertToDict()-> [String: Any]?
    func convertToData()-> Data?
}

extension ParameterConvertable where Self: Codable {
    func convertToDict()-> [String: Any]? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
    func convertToData()-> Data? {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(self)
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
}


// --------------------------------------------------------
// 参数包装
// 通过check()，为请求参数增加time stamp和 sign用作网络请求
// --------------------------------------------------------
protocol ParameterChecker {
    func check(para: [String: Any], setSign: @autoclosure()-> String)-> [String: Any]
}
extension ParameterChecker {
    func check(para: [String: Any], setSign: @autoclosure()-> String)-> [String: Any] {
        var p = setTimestamp(para)
        p["sign"] = setSign()
        return p
    }
    
    private func setTimestamp(_ para: [String: Any])-> [String: Any] {
        var p = para
        
        let date = Date(timeIntervalSinceNow: 0)
        let time = date.timeIntervalSince1970 * 1000
        let timeStr = String(format: "%.0f", time)
        p["timestamp"] = timeStr
        return p
    }
}
