ls -al ~/.ssh

ssh-keygen -t ed25519 -C "your-email@example.com"

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id\_ed25519

cat ~/.ssh/id\_ed25519.pub
