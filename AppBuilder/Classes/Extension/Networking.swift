//
//  Networking.swift
//  AppBuilder
//
//  Created by 许朕 on 2021/4/9.
//

import Foundation
import Combine


class ResponseStatus: Responseable {
    let code: Int?
    let message: String?
    let sysTime: Int?
}


/// 服务器返回字段result为字典时使用
class BaseResponse<T: Responseable>: Responseable {
    var status: ResponseStatus?
    var result: T? = nil
    
    init() {}
}
/// 服务器返回字段result为数组时使用
class BaseResponses<T: Responseable>: Responseable {
    var status: ResponseStatus?
    var result: [T]? = nil
}

enum RequestError: Error {
    // 401
    case userExpired
    // 403
    case userLogout
    case unlegal
    case reqeustSuccessButDecodeError
    case sessionError(error: Error)
    case unkonwn
    
    var description: String {
        switch self {
        case .userExpired:
            return "用户身份过期"
        case .userLogout:
            return "用户身份凭证失效，请重新登录"
        case .unlegal:
            return "不合法的请求"
        case .reqeustSuccessButDecodeError:
            return "请求成功，但是JsonDecoder解码失败了"
        case .sessionError(let error):
            return "我们遇到了HTTP ERROR：\(error.localizedDescription)"
        case .unkonwn:
            return "未知错误，无法识别。"
        }
    }
}


protocol Requestable {
    
    var request: URLRequest {get}
    
    @available(iOS 13.0, *)
    func fetch()-> AnyPublisher<Data, Error>
}

protocol DataTaskAble: Requestable, ParameterChecker {
    var baseurl: String {get}
    var path: String {get}
    var method: String {get}
    var parameters: [String: Any] {get}
    var headers: [String: String] {get}
}

extension DataTaskAble {
    var request: URLRequest {
        get {
            var r = URLRequest(url: URL(string: baseurl + path)!)
            r.httpMethod = method
            _ = headers.map { (headers) in
                r.setValue(headers.value, forHTTPHeaderField: headers.key)
            }
            r.setValue("application/json", forHTTPHeaderField: "Content-Type")
            r.httpBody = parameters.jsonData
            return r
        }
    }
    
    /// 一次有效的网络请求
    /// 代表着成功从服务器收到响应，并且能够让接收者解析出数据
    /// 但网络请求总会出现错误，需要正确的处理他们
    /// 定义：
    /// - httpcode:200 statuscode: 200 成功
    /// - httpcode:200 statuscode: 204 无数据
    /// - httpcode:200 statuscode: 202 成功，但应当对用户做出提示
    /// - httpcode:401 statuscode: nil 用户身份过期，尝试更换token
    /// - httpcode:403 statuscode: nil 用户身份失效，应当重新登录
    /// DataTaskable 应当拥有判断以上状态的实现，并且根据响应数据，动态的更新策略，保证响应成功发送给接收者。
    /// 具体来说：
    /// Request -> Response -> code
    /// 200 -> send
    /// 202 -> send
    /// 204 -> send
    /// 401 -> catch 并交由另一个请求执行changeToken的动作
    /// 403 -> failure 终止请求，用户需重新登录才能访问
    @available(iOS 13.0, *)
    func fetch()-> AnyPublisher<Data, Error> {
        print("请求参数:\(parameters)")
        URLSession.shared.invalidateAndCancel()
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .mapError ({ $0 as Error })
            .flatMap { (output) -> AnyPublisher<Data, Error> in
                guard
                    let httpResponse = output.response as? HTTPURLResponse
                else {
                    return Fail(error: RequestError.unlegal).eraseToAnyPublisher()
                }
                
                switch httpResponse.statusCode {
                case 200 :
                    return Result.success(output.data).publisher.eraseToAnyPublisher()
                case 401:
                    return Fail(error: RequestError.userExpired).eraseToAnyPublisher()
                case 403:
                    return Fail(error: RequestError.userLogout).eraseToAnyPublisher()
                default:
                    return Fail(error: RequestError.unlegal).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
