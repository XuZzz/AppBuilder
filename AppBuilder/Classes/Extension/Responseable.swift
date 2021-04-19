//
//  Responseable.swift
//  AppBuilder
//
//  Created by 许朕 on 2021/4/19.
//

import Foundation


public class ResponseStatus: Responseable {
    public let code: Int?
    public let message: String?
    let sysTime: Int?
}


/// 服务器返回字段result为字典时使用
public class BaseResponse<T: Responseable>: Responseable {
    public var status: ResponseStatus?
    public var result: T? = nil

    public init() {}
}
/// 服务器返回字段result为数组时使用
public class BaseResponses<T: Responseable>: Responseable {
    public var status: ResponseStatus?
    public var result: [T]? = nil

    public init() {

    }
}
