#import "libcolorpicker.h"
#import <UIKit/UIKit.h>

%hook UIRefreshControl
-(id)init {
	id me = %orig;
 	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	NSLog(@"Refresh Control Color: %@", [prefs objectForKey:@"refreshColor"]);
    UIColor *refreshControlColor = LCPParseColorString([prefs objectForKey:@"refreshColor"], @"#ffffff");
	self.tintColor = refreshControlColor;
	return me;
}
%end

%hook UIActivityIndicatorView
-(id)initWithCoder:(id)arg1 {
	id me = %orig;
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	NSLog(@"Activity Indicator Color: %@", [prefs objectForKey:@"activityColor"]);
    UIColor *activityIndicatorColor = LCPParseColorString([prefs objectForKey:@"activityColor"], @"#ffffff");
	self.color = activityIndicatorColor;
	return me;
}
-(id)initWithActivityIndicatorStyle:(long long)arg1 {
	id me = %orig;
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	NSLog(@"Activity Indicator Color: %@", [prefs objectForKey:@"activityColor"]);
    UIColor *activityIndicatorColor = LCPParseColorString([prefs objectForKey:@"activityColor"], @"#ffffff");
	self.color = activityIndicatorColor;
	return me;
}
%end