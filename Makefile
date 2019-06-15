include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Spoke
Spoke_FILES = Tweak.xm
Spoke_LIBRARIES = colorpicker
ARCHS = arm64 arm64e

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += spokeprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
