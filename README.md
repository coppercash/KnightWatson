# Knight Watson

[![Build Status](https://img.shields.io/travis/coppercash/KnightWatson/master.svg)](https://travis-ci.org/coppercash/KnightWatson)
[![CocoaPods](https://img.shields.io/cocoapods/v/KnightWatson.svg)](https://cocoapods.org/pods/KnightWatson)
[![Platform](https://img.shields.io/cocoapods/p/KnightWatson.svg)](http://cocoadocs.org/docsets/KnightWatson)
[![License MIT](https://img.shields.io/cocoapods/l/KnightWatson.svg)](https://raw.githubusercontent.com/coppercash/KnightWatson/master/LICENSE)
[ ![Language](https://img.shields.io/badge/language-%20ObjC%20-green.svg)](#)

Knight Watson is a theme managing library, with which an iOS app can easily add functions like Night Version.
Benefiting from the runtime of ObjC, Knight Watson can add theme to an instance with simply a suffix following it. Thus, it would save you from many hours of learning unfamiliar new methods.

## Demo

![Demo](https://raw.githubusercontent.com/coppercash/images/master/KnightWatson/demo.gif)

## Installation with CocoaPods

Add following line to your `Podfile`.

```shell
pod 'KnightWatson'
```

The import the headers with one line to where you need it.

```objectivec
#import <KnightWatson/KnightWatson.h>
```

## How to Use

### The Most Basic

All magic starts from the suffix `knw_themable`, and then what left are only familiar Cocoa methods.

```objectivec
    // Configure the instance with values by theme
    //
    UIView
    *view = [[UIView alloc] init];
    view.knw_themable.backgroundColor = (id)@{@"daylight": UIColor.whiteColor,
                                                 @"night": UIColor.blackColor,};

    // Change the theme sometime later
    //
    KNWThemeContext.defaultThemeContext.theme = @"night";
```

### Themed Arguments

An argument will be regarded as themed if it conforms to protocol `KNWObjectArgument`. Class `KNWThemedArgument` is provided with the library as an example. Take a look at how method `knw_valueWithThemeContext:` is implemented, so you can implement your own THEMED ARGUMENTS. For example, to make `NSDictionary` themed argument:

```objectivec
@interface NSDictionary (KNWObjectArgument) <KNWObjectArgument>
@end

@implementation NSDictionary (KNWObjectArgument)

- (id)knw_valueWithThemeContext:(KNWThemeContext *)context
{
    return self[context.theme];
}

@end
```

#### Arguments Consume a lot of Memory

Instances of `UIImage` are widely used, and may be replaced while switching between themes. Because they consume a lot of memory, we shouldn't keep images for all the themes in memory. Instead, we just keep their names. Take a look at class `KNWAUIImage` to understand better.

```objectivec
@implementation KNWAUIImage

- (instancetype)initWithImageNamesByTheme:(NSDictionary *)names
{
    if (self = [super init]) {
        _imageNamesByTheme = names;
    }
    return self;
}

- (id)knw_valueWithThemeContext:(KNWThemeContext *)context
{
    return [UIImage imageNamed:_imageNamesByTheme[context.theme]];
}

@end
```

#### Non-object Arguments

Non-object arguments are supported as well:

```objectivec
    UIView
    *view = [[UIView alloc] init];
    NSDictionary
    *framesByTheme =
    @{@"theme_a": [NSValue valueWithCGRect:CGRectMake(1., 1., 1., 1.)],
      @"theme_b": [NSValue valueWithCGRect:CGRectMake(2., 2., 2., 2.)],};
      
    [view
     .knw_themable
     .argAtIndex(0, framesByTheme)
     setFrame:CGRectZero];
```

Primitive variables (integer, bool...) and C structs boxed in `NSNumber` or `NSValue` can be automatically de-boxed. Moreover, you can also implement a class to store non-object arguments in your own way. To archieve this, make the class conform protocol `KNWNonObjectArgument`. Take class `KNWACGColorRef` as an example:

```objectivec
@implementation KNWACGColorRef

- (instancetype)initWithColorsByTheme:(NSDictionary *)colors {
    if (self = [super init]) {
        _colorsByTheme = colors;
    }
    return self;
}

- (void)knw_invocation:(NSInvocation *)invocation
    setArgumentAtIndex:(NSUInteger)index
      withThemeContext:(KNWThemeContext *)context
{
    CGColorRef
    color = _colorsByTheme[context.theme].CGColor;
    [invocation setArgument:&color
                    atIndex:index];
}

@end
```

### Instance with Short Lifetime

Sometimes, we just want the value for the current theme instead of its changing with the theme. In that case, we need one more line:

```objectivec
    UIView
    *view = [[UIView alloc] init];
    NSDictionary
    *colorsByTheme = @{@"daylight": UIColor.whiteColor,
                       @"night": UIColor.blackColor,};
    [view
     .knw_themable
     .keepThemable(NO)
     setBackgroundColor:(id)colorsByTheme];
```

Or simply use the convenient suffix (notice that the suffix is replaced with `knw_themed`):

```objectivec
    view.knw_themed.backgroundColor = (id)@{@"daylight": UIColor.whiteColor,
                                            @"night": UIColor.blackColor,};
```

### What can be a Theme?

`KNWThemeContext#theme` is of type `id`. So it can be of any class as long as your implementation for `KNWObjectArgument` (or `KNWNonObjectArgument`) can handle it. 
For example, if instances of `NSNumber` are used as themes, `NSArray` will be able to be passed as themed argument:

```objectivec
    KNWThemeContext.defaultThemeContext.theme = @1;
    
    UIButton
    *button = [[UIButton alloc] init];
    NSArray
    *colorsByTheme = @[UIColor.whiteColor, UIColor.blackColor,];
    [button.knw_themable setTitleColor:(id)colorsByTheme
                              forState:UIControlStateNormal];
```

## Todo

+ [x] [`UIButton`, `UILabel`, `UIImageView`...] support
+ [x] [`UIColor`, `UIImage`, `NSAttributedString`...] support
+ [x] Mutiple themes support
+ [x] Custom theme type support
+ [x] Cocoapods support
+ [x] Non-object (primitive types, C struct) argument support
+ [x] Custom argument implementation support
+ [x] Dot expression support
+ [ ] Multiple threads (multiple theme contexts) support
+ [ ] Class methods support
+ [ ] Duplicate registered invocations removal
+ [ ] Notifications for theme-switching
+ [ ] Support OS X
+ [ ] Support Cathage
+ [ ] Documentation
