{ lib, pkgs, config, ... }: {

  imports = [ ../all.nix ./hardware-configuration.nix ];

  networking = { hostName = "water"; };

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";

  services.tailscale.enable = false;
  services.prometheus.exporters.node.enable = true;
  services.promtail.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC32ziC0A25c+EOct/WXTf3bWUce+0padTZKnddsYNK+QYngGsfJNn1mZsA/w6WefRUQZ+0mghuPpnnd6AsGbL+Xq6h1vQC2XxFjBYZhv4FUr+572G7TklCqc4t9teAmjqzOhP8g4L+gFky0atb8lhw7HGA3e5h+wl7vrxXfU/pLE2YMasYQJ7qN/yJ3G/ZtYGcsFUCUtdZAWYdJUA9pLxJ/ujJx8S+Xt4DlflSXJCEYDs271DhOJeVpj2U+MwHQQnQkmU/k5nk/OBnE/SpROdUiimRFYIJyP27RSm4xW6gdWmKZIwPuQd5h1V9RzFEurk0A27ePLjfRlmr4GW/YLvPZXOCGk1lj/Xo63JE5FSRsltlpkHhqtcMGeE8TJialABG3ZCl1avIlQK4FAImX9KftbmTyb0MFuRIAOmW5BvwzFRcLjJgAu3TWb5yLIZXZSugOVYYh5owD6TA5vmyYQDtZQ/k9eSct1NnLW2cEAILZlGmSt6QU1rtjSDUd41lg9yfGuvwzNfPHUtwcsApEGbNVo7TAecsRAdHEh23fyxHgKdC1w8uWdw3pfWNIikRqbJBSiT3uNNuE1MaQn5VF+0dTgd4fe7sRqFIxuucyj0+HZoNRCYps1c6FBVyNaBFJxpctdVGpWheabGY5cab+H9pgvUFxM1rUufOGfXqIxIa4w== cardno:26_717_913"
  ];

}
