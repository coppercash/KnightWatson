# Knight Watson

## Installation with CocoaPods

### Podfile

Add following line to your `Podfile`

```shell
pod 'KnightWatson'
```

### Usage

```objectivec
#import <KnightWatson/KNWTheme.h>
```

## How to use

```objectivec
    UIButton
    *button = [[UIButton alloc] init];
    [button.knw_themable setTitleColor:(id)@{@"daylight": UIColor.whiteColor,
                                             @"night": UIColor.blackColor,}
                              forState:UIControlStateNormal];
    
    KNWThemeContext.defaultThemeContext.theme = @"night";
```
