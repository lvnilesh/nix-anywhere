https://galowicz.de/2023/04/05/single-command-server-bootstrap/

https://github.com/nix-community/nixos-anywhere

nix run github:nix-community/nixos-anywhere -- root@192.168.1.188 --flake .#h


nixos-rebuild switch --flake .#h  --target-host root@192.168.1.188


Another

https://seanrmurphy.medium.com/bringing-up-a-nixos-vm-in-10-minutes-using-nixos-anywhere-6590b49ad146

https://github.com/seanrmurphy/nixos-in-10-minutes.git