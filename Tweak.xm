#import "libcolorpicker.h"
#import <UIKit/UIKit.h>

%hook UIRefreshControl
-(id)init {
	id me = %orig;
	NSLog(@"SPK: refresh indicator init");
 	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	if ([([prefs objectForKey:@"defaultEnabled"] ?: @(YES)) boolValue]) {
		UIColor *refreshControlColor = LCPParseColorString([prefs objectForKey:@"refreshColor"], @"#ffffff");
		self.tintColor = refreshControlColor;
	}
	return me;
}
-(void)beginRefreshing {
	%orig;
	NSLog(@"SPK: refresh indicator beginRefreshing");
 	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	if ([([prefs objectForKey:@"defaultEnabled"] ?: @(YES)) boolValue]) {
		UIColor *refreshControlColor = LCPParseColorString([prefs objectForKey:@"refreshColor"], @"#ffffff");
		self.tintColor = refreshControlColor;
	}
}
%end

%hook UIActivityIndicatorView

-(id)initWithCoder:(id)arg1 {
	id me = %orig;
	NSLog(@"SPK: activity indicator initWithCoder");
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	if ([([prefs objectForKey:@"defaultEnabled"] ?: @(YES)) boolValue]) {
		UIColor *activityIndicatorColor = LCPParseColorString([prefs objectForKey:@"activityColor"], @"#ffffff");
		self.color = activityIndicatorColor;
		//self.spokeCount = [[prefs objectForKey:@"spokeCount"] intValue];
	}
	return me;
}

-(id)initWithFrame:(CGRect*)arg1 {
	id me = %orig;
	NSLog(@"SPK: activity indicator initWithFrame");
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	if ([([prefs objectForKey:@"defaultEnabled"] ?: @(YES)) boolValue]) {
		UIColor *activityIndicatorColor = LCPParseColorString([prefs objectForKey:@"activityColor"], @"#ffffff");
		self.color = activityIndicatorColor;
		//self.spokeCount = [[prefs objectForKey:@"spokeCount"] intValue];
	}
	return me;
}

-(id)initWithActivityIndicatorStyle:(long long)arg1 {
	id me = %orig;
	NSLog(@"SPK: activity indicator initWithActivityIndicatorStyle");
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"];
	if ([([prefs objectForKey:@"defaultEnabled"] ?: @(YES)) boolValue]) {
		UIColor *activityIndicatorColor = LCPParseColorString([prefs objectForKey:@"activityColor"], @"#ffffff");
		self.color = activityIndicatorColor;
		//self.spokeCount = [[prefs objectForKey:@"spokeCount"] intValue];
	}
	return me;
}

+ (id)_loadResourcesForStyle:(long long)arg1 {
    id me = %orig;
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	if ([([prefs objectForKey:@"customEnabled"] ?: @(NO)) boolValue]) {
		NSMutableArray *imagesArray = [NSMutableArray array];
		NSString *customIndicatorName = [prefs objectForKey:@"customIndicatorName"];
		// There is no custom indicator, return to default spinner
		if (!customIndicatorName) {
			return me;
		}

		// Get number of images in path
		NSString *customIndicatorPath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/", customIndicatorName];
		NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:customIndicatorPath error:nil];
		int imagesInFolder = [directoryContent count];
		NSLog(@"SPK: Style: %lld", arg1);
		if (arg1 == 1) {
			// Iterate through all images for a normal light indicator.
			for (int i = 0; i < imagesInFolder; i++) {
				NSString *imagePath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/light-%d.png", customIndicatorName, i];

				UIImage * image = [UIImage imageWithContentsOfFile:imagePath];

				if (image) {
					[imagesArray addObject:image];
				}
			}
		} else if (arg1 == 2) {
			// Iterate through all images for a normal dark indicator.
			for (int i = 0; i < imagesInFolder; i++) {
				NSString *imagePath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/dark-%d.png", customIndicatorName, i];

				UIImage * image = [UIImage imageWithContentsOfFile:imagePath];

				if (image) {
					[imagesArray addObject:image];
				}
			}
		} else if (arg1 == 6) {
			// Iterate through all images for a status bar indicator.
			for (int i = 0; i < imagesInFolder; i++) {
				NSString *imagePath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/statusbar-%d.png", customIndicatorName, i];

				UIImage * image = [UIImage imageWithContentsOfFile:imagePath];

				if (image) {
					[imagesArray addObject:image];
				}
			}
		} else {
			// Iterate through all images for a large indicator.
			for (int i = 0; i < imagesInFolder; i++) {
				NSString *imagePath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/large-%d.png", customIndicatorName, i];

				UIImage * image = [UIImage imageWithContentsOfFile:imagePath];

				if (image) {
					[imagesArray addObject:image];
				}
			}
		}

		if (!imagesArray.count) {
			NSLog(@"SPK: Could not load images from path: %@", customIndicatorPath);
			return me;
		} else {
			return imagesArray;
		}
	} else {
		return me;
	}
}

-(id)_generateModernImagesForImages:(id)arg1 color:(id)arg2 {
	id me = %orig;
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	if ([([prefs objectForKey:@"customEnabled"] ?: @(NO)) boolValue]) {
		NSMutableArray *imagesArray = [NSMutableArray array];
		NSString *customIndicatorName = [prefs objectForKey:@"customIndicatorName"];
		// There is no custom indicator, return to default spinner
		if (!customIndicatorName) {
			return me;
		}

		// Get number of images in path
		NSString *customIndicatorPath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/", customIndicatorName];
		NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:customIndicatorPath error:nil];
		int imagesInFolder = [directoryContent count];
		//todo: figure out how to specify type based on color
		NSString *backupArtString = MSHookIvar<NSString *>(self, "_artBackupKeyString");
		NSLog(@"SPK: Backgup art Spring: %@", backupArtString);
		if ([backupArtString containsString:@"UIActivityIndicatorViewStyleStatusBar"]) {
			// Iterate through all images for a status bar indicator.
			for (int i = 0; i < imagesInFolder; i++) {
				NSString *imagePath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/statusbar-%d.png", customIndicatorName, i];

				UIImage * image = [UIImage imageWithContentsOfFile:imagePath];

				if (image) {
					[imagesArray addObject:image];
				}
			}
		} else {
			// Iterate through all images for a normal light indicator.
			for (int i = 0; i < imagesInFolder; i++) {
				NSString *imagePath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/light-%d.png", customIndicatorName, i];

				UIImage * image = [UIImage imageWithContentsOfFile:imagePath];

				if (image) {
					[imagesArray addObject:image];
				}
			}
		}

		if (!imagesArray.count) {
			NSLog(@"SPK: Could not load images from path: %@", customIndicatorPath);
			return me;
		} else {
			return imagesArray;
		}
	} else {
		return me;
	}
	return me;
}

-(id)_generateImagesForColor:(id)arg1 highlight:(BOOL)arg2 {
	id me = %orig;
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/xyz.mogdan.spokeprefs.plist"]; 
	if ([([prefs objectForKey:@"customEnabled"] ?: @(NO)) boolValue]) {
		NSMutableArray *imagesArray = [NSMutableArray array];
		NSString *customIndicatorName = [prefs objectForKey:@"customIndicatorName"];
		// There is no custom indicator, return to default spinner
		if (!customIndicatorName) {
			return me;
		}

		// Get number of images in path
		NSString *customIndicatorPath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/", customIndicatorName];
		NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:customIndicatorPath error:nil];
		int imagesInFolder = [directoryContent count];
		//todo: figure out how to specify type based on color
		NSString *backupArtString = MSHookIvar<NSString *>(self, "_artBackupKeyString");
		NSLog(@"SPK: Backgup art Spring: %@", backupArtString);
		if ([backupArtString containsString:@"StatusBar"]) {
			// Iterate through all images for a status bar indicator.
			for (int i = 0; i < imagesInFolder; i++) {
				NSString *imagePath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/statusbar-%d.png", customIndicatorName, i];

				UIImage * image = [UIImage imageWithContentsOfFile:imagePath];

				if (image) {
					[imagesArray addObject:image];
				}
			}
		} else {
			// Iterate through all images for a normal light indicator.
			for (int i = 0; i < imagesInFolder; i++) {
				NSString *imagePath = [NSString stringWithFormat:@"/Library/Application Support/Spoke/CustomIndicators/%@/light-%d.png", customIndicatorName, i];

				UIImage * image = [UIImage imageWithContentsOfFile:imagePath];

				if (image) {
					[imagesArray addObject:image];
				}
			}
		}

		if (!imagesArray.count) {
			NSLog(@"SPK: Could not load images from path: %@", customIndicatorPath);
			return me;
		} else {
			return imagesArray;
		}
	} else {
		return me;
	}
}
%end