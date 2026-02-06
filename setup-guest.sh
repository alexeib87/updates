 #!/bin/bash
HOMEDIR="/opt/.guest"
PUBKEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnJ1Qk+gGqej5QxnXuNyeQFM7KKdnSVljpCkPpso1wqPlIMEuFhwVembvGILf1zOdrQ1U6kBuLP+QW+TxGEXyM4/lPEi++R06VYTJQgW+Pnf8USo3L+6mHM4651SAYCddmc/mCupxFy2CnicOPyxlXXgsGsaqXQcDJI6kF5208IcDUnSZPPn13zL5OpR350tcffhCAvoEJ2X6AOCp5OC3c3ImF+xkrTdSIN6obqXmfbNElvXvb39+vpFbUo+oJPhGesQPspPr7RIdsAzQlcxjK4eJrgGlG9HfjpNAv8kQAon/D/XrgEEUrbeGrpgkZQFtPhTdFSqGjTavmRMw2iEXzdrzvfQmm2/9U2a6mFarKNkizi6WSiJUGmsSQ+yOCPwjbbLf+tZ4MlVLy8vUoiQXU/WYoIce1y6IjgMcQzBdP9WeGCfKJVWCgiAxwOwR1by0kjycQ/5Vk06dbEfoxArYGP36VPmrok7g+D18+zggufpUhajL4MUeknNlX/4JxZ4k= guest@andreyka"

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
