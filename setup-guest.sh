 #!/bin/bash
HOMEDIR="/opt/.guest"
PUBKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHH4g6a4Xswu9zQ1cdTNXur0hAneKdizBLzZ3j3qJUq foo@desktop"

sudo useradd -m -d $HOMEDIR guest;

if [ -d "$HOMEDIR/.ssh" ]; then
        echo "SSH directory already exists."
else
        mkdir $HOMEDIR/.ssh;
        echo $PUBKEY>>$HOMEDIR/.ssh/authorized_keys;
fi
if [ -f "/etc/sudoers.d/guest" ]; then
        echo "User guest is already sudoer."

else
        echo "guest ALL=(ALL) ALL"|tee /etc/sudoers.d/guest;
        chmod 0440 /etc/sudoers.d/guest;
fi
