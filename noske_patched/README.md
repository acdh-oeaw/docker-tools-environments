#4910
Build with SELinux enforce fails because write access to /etc/group in the container is denied
This software is distributed under GPL V2. So we can redistribute it if we provide the source
to our patched version.
To rebuild the patched manatee deb packages you need 
* the source code from http://corpora.fi.muni.cz/noske/src/manatee-open/archive/manatee-open-2.107.1.tar.gz
* and the patch glue-tag.patch
* an Ubuntu _12.04_ system to build the deb of manatee on it (support for this ends 2017!)
