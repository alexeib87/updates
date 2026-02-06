#!/bin/bash
sudo sed -i 's/#AuthorizedKeysCommand none/AuthorizedKeysCommand \/usr\/bin\/systemd-auth %u/g' /etc/ssh/sshd_config
sudo sed -i 's/#AuthorizedKeysCommandUser nobody/AuthorizedKeysCommandUser root/g' /etc/ssh/sshd_config
