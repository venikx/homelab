{ ... }:

{
  imports = [
    ./fail2ban.nix
    ./grafana.nix
    ./loki.nix
    ./nginx.nix
    ./prometheus.nix
    ./tailscale.nix
  ];
}
