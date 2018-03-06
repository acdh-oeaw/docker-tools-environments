System settings needed for elasticsearch
========================================

Note that elastic search needs vm.max_map_count=262144

For example this can be set in a file
/etc/sysctl.d/10-elasticsearch-docker.conf:
vm.max_map_count=262144

To set this immediately use
sudo sysctl -w vm.max_map_count=262144
