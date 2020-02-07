arg="$1"

if [ "$arg" == "list" ]; then
  cat /sys/devices/system/cpu/cpufreq/policy?/energy_performance_preference
  exit
fi

sudo vim /etc/tmpfiles.d/energy_performance_preference.conf 
sudo systemd-tmpfiles --create
cat /sys/devices/system/cpu/cpufreq/policy?/energy_performance_preference
