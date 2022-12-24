# P1d.metrics

User's privacy aware analytics and tagging SDK for iOS, macOS, watchOS and tvOS. 

## How to use it

1. Deploy a [**Collector service**](https://github.com/p1d-metrics/collector.p1dme) using [**MongoDB Atlas**](https://www.mongodb.com/cloud/atlas) or on-premise MongoDB

2. Create a **Configuration Property List** (plist) with the following content

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>applicationId</key>
	<string>{{APPLICATION_ID}}</string>
	<key>serviceURL</key>
	<string>{{SERVICE_URL}}</string>
	<key>apiKey</key>
	<string>{{SERVICE_API_KEY}}</string>
</dict>
</plist>
```

Defining:

- {{APPLICATION_ID}}: A unique identifier per application (I can be the bundle identifier, or an internal application id)

- {{SERVICE_URL}}: URL of the deployed **Collector Service** accesible by any instance of your application

- {{SERVICE_API_KEY}}: A strong API key used by the SDK to authenticate API calls.

The initialization can also be done passing this parameters in a **setup call**, in order to avoid saving the API Key in a file inside your application.

3. Call P1dme SDK setup

```swift
try! P1dme.setup(fileName: "p1dme-config")
```

or using parameters

```swift
try! P1dme.setup(serviceURL: URL(string: "http://127.0.0.1:8080/")!, apiKey: "test-key")
```

4. Send events using the **logEvent** function

```swift
P1dme.shared.logEvent(
    name: "test-event",
    category: "test",
    parameters: [
        "key1": "value1",
        "key2": "value2",
    ]
)
```

The callback parameter can be omitted, but it returns the *event* as stored by the server. Which can be useful if you would like to show your users what information of his/her behaviour is stored server-side.

## Documentation

* [SDK Documentation (Swift-DocC)](https://p1d-metrics.github.io/p1dme.swift/documentation/p1dme)

## Author

* [Ezequiel (Kimi) Aceto](ezequiel.aceto+p1dme@gmail.com)