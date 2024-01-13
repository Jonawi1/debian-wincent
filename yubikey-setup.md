# Github ssh
### Start ssh-agent
eval "$(ssh-agent -s)"
### Create a key on a new Yubikey
ssh-keygen -t ed25519-sk -O resident -C "your_email@example.com"
### Temporarily add key to new PC
ssh-add -K
### Permanently add key to new PC
ssh-keygen -K
mv id_ed25519_sk_rk ~/.ssh/id_ed25519_sk
