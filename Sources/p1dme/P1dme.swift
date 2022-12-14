//
//  P1dme.swift
//

import Foundation

/// Entry point for the metrics P1d.metrics SDK
public final class P1dme {
    /// Shared instance. It should be the only one iavailable in the user's app.
    public static var shared: P1dme!
        
    internal let config: Config
    internal let installationId: String
    internal var referer: String?

    internal init(config: Config) {
        let userDefaults = UserDefaults(suiteName: "p1dme-sdk-config")
        
        self.config = config
        self.installationId = userDefaults?.string(forKey: "installationId") ?? UUID().uuidString
    }
    
    /// Setup P1dme SDK using a plist file. The shared instance will be configured and ready to use if this call success.
    /// It throws an error of it the SDK cannot be configured with the given parameters
    /// - Parameters:
    ///     - bundle: The `Bundle` where the configuration file is present. Defaults to `Bundle.main`
    ///     - fileName: The name of the file (of type properly list / plist) from where the configuration parameters should be retrieved. Defaults to `p1dme`
    public static func setup(bundle: Bundle = .main, fileName: String = "p1dme") throws {
        do {
            let config = try Config.parse(bundle: bundle, fileName: fileName)
            shared = P1dme(config: config)
            shared.referer = bundle.bundleIdentifier
        } catch {
            throw error
        }
    }
    
    /// Setup P1dme SDK with parameters. The shared instance will be configured and ready to use if this call success.
    /// It throws an error of it the SDK cannot be configured with the given parameters
    /// - Parameters:
    ///     - bundle: The `Bundle` where the configuration file is present. Defaults to `Bundle.main`
    ///     - applicationId: A unique identifier for this application. Defaults to `BundleIdentifier`
    ///     - serviceURL: URL of the Collector Service
    ///     - apiKey: API Key to authenticate calls to the Collector Service
    public static func setup(bundle: Bundle = .main,
                             applicationId: String? = nil,
                             serviceURL: URL,
                             apiKey: String) throws {
        do {
            let appId = applicationId?.trimmingCharacters(in: .whitespacesAndNewlines) ?? Bundle.main.bundleIdentifier
            guard let appId = appId else {
                throw Errors.invalidConfiguration("applicationId")
            }

            if apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                throw Errors.invalidConfiguration("apiKey")
            }
            
            let config = Config(applicationId: appId, serviceURL: serviceURL, apiKey: apiKey)
            shared = P1dme(config: config)
            shared.referer = bundle.bundleIdentifier
        } catch {
            throw error
        }
    }
    
    /// Logs an event by it's name, category and parameters. This is a network operation and the event is sent in real-time.
    /// - Parameters:
    ///     - name: The event`Name`
    ///     - category:  A category (optional)  to which the event can belong.
    ///     - parameters: Additional parameters that are related to the event.
    ///     - completion: An optional callback that returns the complete event (just like the service stores it) or an error.
    public func logEvent(name: String,
                         category: String? = nil,
                         parameters: [String: String]? = nil,
                         _ completion: @escaping ((EventDetails?, (any Error)?) -> Void)) {
            
        var request: URLRequest
        do {
            request = prepareCreateEventRequest()
            request.addPlatformAnalytics()
            let payload = preparePayload(event: name, category: category, parameters: parameters)
            let requestData = try JSONSerialization.data(withJSONObject: payload)
            request.httpBody = requestData
        } catch {
            DispatchQueue.main.async {
                completion(nil, P1dme.Errors.cannotCreateRequest)
            }
            return
        }
        
        DispatchQueue.global(qos: .default).async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
                guard let eventResponse = try? JSONDecoder().decode(EventResponse.self, from: data) else {
                    DispatchQueue.main.async {
                        completion(nil, P1dme.Errors.invalidServiceResponse)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(eventResponse.event, nil)
                }
            }
            task.resume()
        }
    }
}

extension P1dme {
    public enum Errors: Error {
        /// thrown when the service replied with an error, or response, that cannot be parsed
        case invalidServiceResponse
        /// thrown when the SDK cannot create a valid (HTTP) request to send the service
        case cannotCreateRequest
        /// thrown when a parameter of the Configuration is invalid
        case invalidConfiguration(String)
    }
}
