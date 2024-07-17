{ ... }:

{
  imports = [
    ./fail2ban.nix
    ./grafana.nix
    ./prometheus.nix
    ./node_exporter.nix
    ./loki.nix
    ./promtail.nix
    ./nginx.nix
    ./tailscale.nix
  ];
}
