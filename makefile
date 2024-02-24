default:
	nix flake update && darwin-rebuild switch --flake .
