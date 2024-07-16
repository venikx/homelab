{ ... }:

{
  imports = [
    ./fail2ban.nix
    ./grafana.nix
    ./loki.nix
    ./prometheus.nix
    ./node_exporter.nix
    ./nginx.nix
    ./tailscale.nix
  ];
}
