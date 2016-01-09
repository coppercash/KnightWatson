# Knight Watson

## Usage

```objectivec
#import "KNWTheme.h"
```

# How to use

```objectivec
    UIButton
    *button = [[UIButton alloc] init];
    [button.knw_themable setTitleColor:(id)@{@"daylight": UIColor.whiteColor,
                                             @"night": UIColor.blackColor,}
                              forState:UIControlStateNormal];
    
    KNWThemeContext.defaultThemeContext.theme = @"night";
```
