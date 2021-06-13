# SwiftDuration

![tests](https://github.com/4ndrewHarri5/SwiftDuration/actions/workflows/swift-test.yml/badge.svg)

Parse durations from natural language into seconds

```swift
Duration.parse("10 days, 6 minutes and 5 seconds")
---
864365
```
| units               |
|---------------------|
| second, sec,  s   	|
| minute, min,  m   	|
| hour, hr, h  	      |
| day, dy, d          |
| week, wk, w         |
| month, mon, mo, mth |
| year, yr, y         |


Convert seconds back to natual language

```swift
Duration.stringify(83)
---
"1 minute 23 seconds"
```

```swift
Duration.stringify(83, format: .short)
```

| long   	| short 	| micro 	| crono 	|
|--------	|-------	|-------	|-------	|
| second 	| sec   	| s     	| :     	|
| minute 	| min   	| m     	| :     	|
| hour   	| hr    	| h     	| :     	|
| day    	| day   	| d     	| :     	|
| week   	| wk    	| w     	| :     	|
| month  	| mon   	| mth   	| :     	|
| year   	| yr    	| y     	| :     	|

```swift
Duration.stringify(83, joiner: .pretty)
---
"1 minute and 23 seconds"
```
```swift
Duration.stringify(864365, joiner: .pretty)
---
"10 days, 6 minutes and 5 seconds"
```



