# file: flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }: {
    nixosConfigurations.h = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({modulesPath, ... }: {
          imports = [
            "${modulesPath}/installer/scan/not-detected.nix"
            "${modulesPath}/profiles/qemu-guest.nix"
            disko.nixosModules.disko
          ];
          disko.devices = import ./single-gpt-disk-fullsize-ext4.nix "/dev/sda";
          boot.loader.grub = {
            devices = [ "/dev/sda" ];
            efiSupport = true;
            efiInstallAsRemovable = true;
          };
          services.openssh.enable = true;
          # users.users.cloudgenius.isSystemUser = true;
          # users.users.cloudgenius.group = "cloudgenius";
          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6z+lz/KN0Y7vvIO7EZDQNNJ5y868Zh4XsbO4R6VeA4a/UVXkA/LzJnjezBHOMKcL6n4WdjkYBDdcOfYSpTNzASUmiz8iP64pXgKiP96xx4rECHe1oaXRtufWSFDaXARPp33u8FtcWyC1y8xBzXTac45AiRbhdR5gHNxv4qFqSmRmeobAKf2V0iDHcKE6oWhqil27vGimFvAfF4VE3m6WPWdOTF82D+TSi/vfZnEFuCZ5mzfABOHcl0NT1w8l5ukjQCxZn/r2OSR56i07npiw/P50Paw+4tM1gaFVrnEt9gPjFD7KrIj02ecl14u77OSrg26ndelbvHSgNpofYaFri1g9YydOiaJn0zfZuqRJrx4whU7zmk0JQJBYwvRefnSIcalUbgZyKwaus1jtUUKEhjQB7HGvFVgP0Uecx+qldjsfdyX40xNqqVOa/n+CagYGN38e+YziVUklnBhZBvqrB3JF4pJ7XElvLRzjT/K+jiLD20UPG31NDswdYMALjFMnncB1qsMSvPJ7Iu5/vbuK7SiUo57rJhIqSilWHAn2dYxvX4pFdDHLqbVlBwPuQhmuSip5L86b2nR1J9canZG2UV8wDizAUvsVv7JmrQrgzYAwappXKy0j0ZkEOGkXMc7jocpBGsPbZ7kRoX7yEhABi8no20ZmpAGE1nm+MagQHYw=="
          ];
        })
      ];
    };
  };
}