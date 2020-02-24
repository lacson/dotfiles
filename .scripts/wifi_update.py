#! /usr/bin/env python3
'''
wifi_update.py
@author jlacson

When connected to a specified SSID,
check a file and see if the IP address
needs to be updated.

Written for macOS, but Linux support forthcoming?
'''

DEFAULT_IFACE = "en0"

try:
    from wifi_update_vars import WIFI_NAME, FILE_TO_UPDATE, VAR_TO_UPDATE
except ImportError as e:
    print("Error importing variables")
    print(e.message())
    exit()

try:
    import objc
except ModuleNotFoundError:
    print("Error importing PyObjC")
    exit()

import os
import urllib.request

def main():
    # initialize wlan object
    objc.loadBundle('CoreWLAN',
                     bundle_path='/System/Library/Frameworks/CoreWLAN.framework',
                     module_globals=globals())
    
    # if en0 doesn't exist, exit
    try:
        CWInterface.interfaceWithName_(DEFAULT_IFACE).ssid()
    except AttributeError:
        print("Could not find interface %s" % DEFAULT_IFACE)
        exit()

    # check the WLAN name
    if WIFI_NAME in CWInterface.interfaceWithName_(DEFAULT_IFACE).ssid():
        # open the file if it exists
        file_contents = None
        
        try:
            file_contents = open(os.path.expanduser(FILE_TO_UPDATE)).readlines()
        except FileNotFoundError:
            print("Could not find file %s" % FILE_TO_UPDATE)
            exit()

        for idx, line in enumerate(file_contents):
            if VAR_TO_UPDATE + "=" in line:
                file_contents[idx] = VAR_TO_UPDATE + "=" + urllib.request.urlopen('https://api.ipify.org').read().decode('utf8') + '\n'
                open(os.path.expanduser(FILE_TO_UPDATE), 'w').writelines(file_contents)
                print("Success")
                exit()


if __name__ == "__main__":
    main()
