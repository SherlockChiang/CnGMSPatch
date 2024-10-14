##########################################################################################
#
# Magisk Module Template Config Script
# by topjohnwu
#
##########################################################################################
##########################################################################################
#
# Instructions:
#
# 1. Place your files into system folder (delete the placeholder file)
# 2. Fill in your module's info into module.prop
# 3. Configure the settings in this file (config.sh)
# 4. If you need boot scripts, add them into common/post-fs-data.sh or common/service.sh
# 5. Add your additional or modified system properties into common/system.prop
#
##########################################################################################

##########################################################################################
# Configs
##########################################################################################

# Set to true if you do *NOT* want Magisk to mount
# any files for you. Most modules would NOT want
# to set this flag to true
SKIPMOUNT=false

# Set to true if you need to load system.prop
PROPFILE=true

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=false

##########################################################################################
# Installation Message
##########################################################################################

# Set what you want to show when installing your mod

print_modname() {
  ui_print "*******************************"
  ui_print "          CN GSM Patch         "
  ui_print "          By MinaMiGo          "
  ui_print "*******************************"
}

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info about how Magic Mount works, and why you need this

# This is an example
REPLACE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here, it will override the example above
# !DO NOT! remove this if you don't need to replace anything, leave it empty as it is now
REPLACE="
"

# Copy/extract your module files into $MODPATH in on_install.

on_install() {
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2

  if [ -e /system/etc/permissions/services.cn.google.xml ] ;then
    mkdir -p $MODPATH/system/etc/permissions/
    touch $MODPATH/system/etc/permissions/services.cn.google.xml
  fi
  if [ -e /system/etc/permissions/cn.google.services.xml ] ;then
    mkdir -p $MODPATH/system/etc/permissions/
    touch $MODPATH/system/etc/permissions/cn.google.services.xml
  fi

  if [ -e /system/product/etc/permissions/services.cn.google.xml ] ;then
    mkdir -p $MODPATH/system/product/etc/permissions/
    touch $MODPATH/system/product/etc/permissions/services.cn.google.xml
  fi
  if [ -e /system/product/etc/permissions/cn.google.services.xml ] ;then
    mkdir -p $MODPATH/system/product/etc/permissions/
    touch $MODPATH/system/product/etc/permissions/cn.google.services.xml
  fi

  if [ -e /system/system_ext/etc/permissions/services.cn.google.xml ] ;then
    mkdir -p $MODPATH/system/system_ext/etc/permissions/
    touch $MODPATH/system/system_ext/etc/permissions/services.cn.google.xml
  fi
  if [ -e /system/system_ext/etc/permissions/cn.google.services.xml ] ;then
    mkdir -p $MODPATH/system/system_ext/etc/permissions/
    touch $MODPATH/system/system_ext/etc/permissions/cn.google.services.xml
  fi

  if [ -e /system/vendor/etc/permissions/services.cn.google.xml ] ;then
    mkdir -p $MODPATH/system/vendor/etc/permissions/
    touch $MODPATH/system/vendor/etc/permissions/services.cn.google.xml
  fi
  if [ -e /system/vendor/etc/permissions/cn.google.services.xml ] ;then
    mkdir -p $MODPATH/system/vendor/etc/permissions/
    touch $MODPATH/system/vendor/etc/permissions/cn.google.services.xml
  fi

  rm -f /data/system/users/0/package-restrictions.xml
}

##########################################################################################
# Permissions
##########################################################################################

set_permissions() {
  # Only some special files require specific permissions
  # The default permissions should be good enough for most cases

  # Here are some examples for the set_perm functions:

  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm_recursive  $MODPATH/system/lib       0       0       0755            0644

  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm  $MODPATH/system/bin/app_process32   0       2000    0755         u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0       2000    0755         u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0       0       0644

  # The following is default permissions, DO NOT remove
  set_perm_recursive  $MODPATH  0  0  0755  0644
}
