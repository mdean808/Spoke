include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SpokePrefs
SpokePrefs_FILES = SPKRootListController.m
SpokePrefs_INSTALL_PATH = /Library/PreferenceBundles
SpokePrefs_FRAMEWORKS = UIKit
SpokePrefs_PRIVATE_FRAMEWORKS = Preferences
SpokePrefs_LIBRARIES = colorpicker
ARCHS = arm64 arm64e

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SpokePrefs.plist$(ECHO_END)
