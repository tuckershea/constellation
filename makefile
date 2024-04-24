default:
	nix flake update && darwin-rebuild switch --flake .

check:
	nix flake check --no-build .
